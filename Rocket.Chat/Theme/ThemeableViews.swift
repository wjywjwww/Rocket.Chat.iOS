//
//  ThemeableViews.swift
//  Rocket.Chat
//
//  Created by Samar Sunkaria on 5/2/18.
//  Copyright © 2018 Rocket.Chat. All rights reserved.
//

import UIKit
import SlackTextViewController

extension UIView: Themeable {

    /**
     Applies theme to the view and all of its `subviews`.

     The `Theme` returned from the `theme` property is used. To exempt a view from getting themed, override the `theme` property and return `nil`.

     The default implementation calls the `applyTheme` method on all of its subviews, and sets the background color of the views.

     Override this method to adapt the components of the view to the theme being applied. The implementation of `super` should be called somewhere in the overridden implementation to apply the theme on all of the subviews, and to adapt the `backgroundColor` of `self`.

     This method should only be called directly if the view or any of its subviews require theming after the first initialization.

     - Important:
     On first initializaiton, it is recommended that the view controller for the view be added as an observer to the ThemeManager using the `ThemeManager.addObserver(_:)` method. If a view controller does not exist, the view should be added as an observer instead.
     */

    func applyTheme() {
        guard let theme = theme else { return }
        backgroundColor = theme.backgroundColor.withAlphaComponent(backgroundColor?.cgColor.alpha ?? 0.0)
        tintColor = theme.hyperlinkText
        self.subviews.forEach { $0.applyTheme() }
    }
}

extension UIView: ThemeProvider {

    /**
     Returns the theme to be allied to the view.

     By default the `theme` of the `superview` is returned. If a `superview` does not exits, then the value is taken from `ThemeManager.theme`

     Overriding this property and returning `nil` will exempt the view from getting themed.
     */

    var theme: Theme? {
        guard let superview = superview else { return ThemeManager.theme }
        return superview.theme
    }
}

extension UILabel {
    override func applyTheme() {
        super.applyTheme()
        guard let theme = theme else { return }
        textColor = theme.titleText
    }
}

extension UITextField {
    override func applyTheme() {
        super.applyTheme()
        guard let theme = theme else { return }
        textColor = theme.titleText
        tintColor = theme.hyperlinkText
        keyboardAppearance = theme.appearence.keyboardAppearence
        if let placeholder = placeholder {
            attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: theme.mutedAccent])
        }
    }
}

extension UISearchBar {
    override func applyTheme() {
        super.applyTheme()
        guard let theme = theme else { return }
        tintColor = theme.tintColor
        let textField = subviews.first?.subviews.first { $0 is UITextField } as? UITextField
        textField?.backgroundColor = #colorLiteral(red: 0.497693181, green: 0.494099319, blue: 0.5004472733, alpha: 0.04910321301)
    }
}

extension UIActivityIndicatorView {
    override func applyTheme() {
        super.applyTheme()
        guard let theme = theme else { return }
        color = theme.bodyText
    }
}

extension UIRefreshControl {
    override func applyTheme() {
        super.applyTheme()
        guard let theme = theme else { return }
        tintColor = theme.bodyText
    }
}

extension UICollectionView {
    open override func insertSubview(_ view: UIView, at index: Int) {
        super.insertSubview(view, at: index)
        view.applyTheme()
    }

    open override func addSubview(_ view: UIView) {
        super.addSubview(view)
        view.applyTheme()
    }
}

extension UITableView {
    override func applyTheme() {
        super.applyTheme()
        guard let theme = theme else { return }
        switch theme {
        case .dark, .black: backgroundColor = style == .grouped ? theme.focusedBackground : theme.backgroundColor
        default: backgroundColor = style == .grouped ? #colorLiteral(red: 0.937, green: 0.937, blue: 0.957, alpha: 1) : theme.backgroundColor
        }
        separatorColor = theme.mutedAccent
    }

    open override func insertSubview(_ view: UIView, at index: Int) {
        super.insertSubview(view, at: index)
        view.applyTheme()
    }

    open override func addSubview(_ view: UIView) {
        super.addSubview(view)
        view.applyTheme()
    }
}

extension UITableViewCell {
    override func applyTheme() {
        subviews.filter { type(of: $0).description() != "_UITableViewCellSeparatorView" }
            .forEach { $0.applyTheme() }
        guard let theme = theme else { return }
        backgroundColor = theme.backgroundColor.withAlphaComponent(backgroundColor?.cgColor.alpha ?? 0.0)
        detailTextLabel?.textColor = theme.auxiliaryText
        tintColor = theme.auxiliaryText
    }
}

extension UITextView {
    override func applyTheme() {
        super.applyTheme()
        guard let theme = theme else { return }
        tintColor = theme.hyperlinkText
    }
}

extension UINavigationBar {
    override func applyTheme() {
        super.applyTheme()
        guard let theme = theme else { return }
        tintColor = theme.hyperlinkText
        barStyle = theme.appearence.barStyle
        barTintColor = theme.focusedBackground
    }

    open override func insertSubview(_ view: UIView, at index: Int) {
        super.insertSubview(view, at: index)
        view.applyTheme()
    }
}

extension UIToolbar {
    override func applyTheme() {
        super.applyTheme()
        guard let theme = theme else { return }
        isTranslucent = false
        barTintColor = theme.focusedBackground
        tintColor = theme.tintColor
        barStyle = theme.appearence.barStyle
    }

    open override func insertSubview(_ view: UIView, at index: Int) {
        super.insertSubview(view, at: index)
        view.applyTheme()
    }
}

extension UITabBar {
    override func applyTheme() {
        super.applyTheme()
        guard let theme = theme else { return }
        barTintColor = theme.focusedBackground
        tintColor = theme.tintColor
        barStyle = theme.appearence.barStyle
    }

    open override func insertSubview(_ view: UIView, at index: Int) {
        super.insertSubview(view, at: index)
        view.applyTheme()
    }
}

extension SLKTextInputbar {
    override func applyTheme() {
        super.applyTheme()
        guard let theme = theme else { return }
        textView.keyboardAppearance = theme.appearence.keyboardAppearence
    }

    open override func insertSubview(_ view: UIView, at index: Int) {
        super.insertSubview(view, at: index)
        view.applyTheme()
    }
}

extension SLKTextView {
    override func applyTheme() {
        super.applyTheme()
        guard let theme = theme else { return }
        layer.borderColor = #colorLiteral(red: 0.497693181, green: 0.494099319, blue: 0.5004472733, alpha: 0.1518210827)
        backgroundColor = #colorLiteral(red: 0.497693181, green: 0.494099319, blue: 0.5004472733, alpha: 0.04910321301)
        textColor = theme.bodyText
        tintColor = theme.hyperlinkText
    }
}
