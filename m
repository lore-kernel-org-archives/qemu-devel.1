Received: from eggs.gnu.org ([2001:4830:134:3::10]:39206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brendan@bslabs.net>) id 1d2tzE-0000cw-0d
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 02:30:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brendan@bslabs.net>) id 1d2tzA-0006In-2J
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 02:30:08 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:36229)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <brendan@bslabs.net>) id 1d2tz9-0006Hj-OR
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 02:30:03 -0400
Received: by mail-pf0-x244.google.com with SMTP id v14so6928493pfd.3
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 23:30:03 -0700 (PDT)
From: Brendan Shanks <brendan@bslabs.net>
Date: Mon, 24 Apr 2017 23:29:52 -0700
Message-Id: <20170425062952.99149-1-brendan@bslabs.net>
Subject: [Qemu-devel] [PATCH] ui/cocoa.m: Fix macOS 10.12 deprecation
 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Brendan Shanks <brendan@bslabs.net>

macOS 10.12 deprecated/replaced many AppKit constants to make naming
more consistent. Use the new constants, and #define them to the
old constants when compiling against a pre-10.12 SDK.

Signed-off-by: Brendan Shanks <brendan@bslabs.net>
---
 ui/cocoa.m | 87 +++++++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 58 insertions(+), 29 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index c81f7b6183..207555edf7 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -45,7 +45,36 @@
 #ifndef MAC_OS_X_VERSION_10_10
 #define MAC_OS_X_VERSION_10_10 101000
 #endif
+#ifndef MAC_OS_X_VERSION_10_12
+#define MAC_OS_X_VERSION_10_12 101200
+#endif
 
+/* macOS 10.12 deprecated many constants, #define the new names for older SDKs */
+#if MAC_OS_X_VERSION_MAX_ALLOWED < MAC_OS_X_VERSION_10_12
+#define NSEventMaskAny                  NSAnyEventMask
+#define NSEventModifierFlagCommand      NSCommandKeyMask
+#define NSEventModifierFlagControl      NSControlKeyMask
+#define NSEventModifierFlagOption       NSAlternateKeyMask
+#define NSEventTypeFlagsChanged         NSFlagsChanged
+#define NSEventTypeKeyUp                NSKeyUp
+#define NSEventTypeKeyDown              NSKeyDown
+#define NSEventTypeMouseMoved           NSMouseMoved
+#define NSEventTypeLeftMouseDown        NSLeftMouseDown
+#define NSEventTypeRightMouseDown       NSRightMouseDown
+#define NSEventTypeOtherMouseDown       NSOtherMouseDown
+#define NSEventTypeLeftMouseDragged     NSLeftMouseDragged
+#define NSEventTypeRightMouseDragged    NSRightMouseDragged
+#define NSEventTypeOtherMouseDragged    NSOtherMouseDragged
+#define NSEventTypeLeftMouseUp          NSLeftMouseUp
+#define NSEventTypeRightMouseUp         NSRightMouseUp
+#define NSEventTypeOtherMouseUp         NSOtherMouseUp
+#define NSEventTypeScrollWheel          NSScrollWheel
+#define NSTextAlignmentCenter           NSCenterTextAlignment
+#define NSWindowStyleMaskBorderless     NSBorderlessWindowMask
+#define NSWindowStyleMaskClosable       NSClosableWindowMask
+#define NSWindowStyleMaskMiniaturizable NSMiniaturizableWindowMask
+#define NSWindowStyleMaskTitled         NSTitledWindowMask
+#endif
 
 //#define DEBUG
 
@@ -494,7 +523,7 @@ - (void) toggleFullScreen:(id)sender
         } else {
             [NSMenu setMenuBarVisible:NO];
             fullScreenWindow = [[NSWindow alloc] initWithContentRect:[[NSScreen mainScreen] frame]
-                styleMask:NSBorderlessWindowMask
+                styleMask:NSWindowStyleMaskBorderless
                 backing:NSBackingStoreBuffered
                 defer:NO];
             [fullScreenWindow setAcceptsMouseMovedEvents: YES];
@@ -517,7 +546,7 @@ - (void) handleEvent:(NSEvent *)event
     NSPoint p = [event locationInWindow];
 
     switch ([event type]) {
-        case NSFlagsChanged:
+        case NSEventTypeFlagsChanged:
             keycode = cocoa_keycode_to_qemu([event keyCode]);
 
             if ((keycode == Q_KEY_CODE_META_L || keycode == Q_KEY_CODE_META_R)
@@ -544,15 +573,15 @@ - (void) handleEvent:(NSEvent *)event
             }
 
             // release Mouse grab when pressing ctrl+alt
-            if (([event modifierFlags] & NSControlKeyMask) && ([event modifierFlags] & NSAlternateKeyMask)) {
+            if (([event modifierFlags] & NSEventModifierFlagControl) && ([event modifierFlags] & NSEventModifierFlagOption)) {
                 [self ungrabMouse];
             }
             break;
-        case NSKeyDown:
+        case NSEventTypeKeyDown:
             keycode = cocoa_keycode_to_qemu([event keyCode]);
 
             // forward command key combos to the host UI unless the mouse is grabbed
-            if (!isMouseGrabbed && ([event modifierFlags] & NSCommandKeyMask)) {
+            if (!isMouseGrabbed && ([event modifierFlags] & NSEventModifierFlagCommand)) {
                 [NSApp sendEvent:event];
                 return;
             }
@@ -560,7 +589,7 @@ - (void) handleEvent:(NSEvent *)event
             // default
 
             // handle control + alt Key Combos (ctrl+alt is reserved for QEMU)
-            if (([event modifierFlags] & NSControlKeyMask) && ([event modifierFlags] & NSAlternateKeyMask)) {
+            if (([event modifierFlags] & NSEventModifierFlagControl) && ([event modifierFlags] & NSEventModifierFlagOption)) {
                 switch (keycode) {
 
                     // enable graphic console
@@ -609,12 +638,12 @@ - (void) handleEvent:(NSEvent *)event
                     kbd_put_keysym(keysym);
             }
             break;
-        case NSKeyUp:
+        case NSEventTypeKeyUp:
             keycode = cocoa_keycode_to_qemu([event keyCode]);
 
             // don't pass the guest a spurious key-up if we treated this
             // command-key combo as a host UI action
-            if (!isMouseGrabbed && ([event modifierFlags] & NSCommandKeyMask)) {
+            if (!isMouseGrabbed && ([event modifierFlags] & NSEventModifierFlagCommand)) {
                 return;
             }
 
@@ -622,7 +651,7 @@ - (void) handleEvent:(NSEvent *)event
                 qemu_input_event_send_key_qcode(dcl->con, keycode, false);
             }
             break;
-        case NSMouseMoved:
+        case NSEventTypeMouseMoved:
             if (isAbsoluteEnabled) {
                 if (![self screenContainsPoint:p] || ![[self window] isKeyWindow]) {
                     if (isMouseGrabbed) {
@@ -636,39 +665,39 @@ - (void) handleEvent:(NSEvent *)event
             }
             mouse_event = true;
             break;
-        case NSLeftMouseDown:
-            if ([event modifierFlags] & NSCommandKeyMask) {
+        case NSEventTypeLeftMouseDown:
+            if ([event modifierFlags] & NSEventModifierFlagCommand) {
                 buttons |= MOUSE_EVENT_RBUTTON;
             } else {
                 buttons |= MOUSE_EVENT_LBUTTON;
             }
             mouse_event = true;
             break;
-        case NSRightMouseDown:
+        case NSEventTypeRightMouseDown:
             buttons |= MOUSE_EVENT_RBUTTON;
             mouse_event = true;
             break;
-        case NSOtherMouseDown:
+        case NSEventTypeOtherMouseDown:
             buttons |= MOUSE_EVENT_MBUTTON;
             mouse_event = true;
             break;
-        case NSLeftMouseDragged:
-            if ([event modifierFlags] & NSCommandKeyMask) {
+        case NSEventTypeLeftMouseDragged:
+            if ([event modifierFlags] & NSEventModifierFlagCommand) {
                 buttons |= MOUSE_EVENT_RBUTTON;
             } else {
                 buttons |= MOUSE_EVENT_LBUTTON;
             }
             mouse_event = true;
             break;
-        case NSRightMouseDragged:
+        case NSEventTypeRightMouseDragged:
             buttons |= MOUSE_EVENT_RBUTTON;
             mouse_event = true;
             break;
-        case NSOtherMouseDragged:
+        case NSEventTypeOtherMouseDragged:
             buttons |= MOUSE_EVENT_MBUTTON;
             mouse_event = true;
             break;
-        case NSLeftMouseUp:
+        case NSEventTypeLeftMouseUp:
             mouse_event = true;
             if (!isMouseGrabbed && [self screenContainsPoint:p]) {
                 if([[self window] isKeyWindow]) {
@@ -676,13 +705,13 @@ - (void) handleEvent:(NSEvent *)event
                 }
             }
             break;
-        case NSRightMouseUp:
+        case NSEventTypeRightMouseUp:
             mouse_event = true;
             break;
-        case NSOtherMouseUp:
+        case NSEventTypeOtherMouseUp:
             mouse_event = true;
             break;
-        case NSScrollWheel:
+        case NSEventTypeScrollWheel:
             if (isMouseGrabbed) {
                 buttons |= ([event deltaY] < 0) ?
                     MOUSE_EVENT_WHEELUP : MOUSE_EVENT_WHEELDN;
@@ -847,7 +876,7 @@ - (id) init
 
         // create a window
         normalWindow = [[NSWindow alloc] initWithContentRect:[cocoaView frame]
-            styleMask:NSTitledWindowMask|NSMiniaturizableWindowMask|NSClosableWindowMask
+            styleMask:NSWindowStyleMaskTitled|NSWindowStyleMaskMiniaturizable|NSWindowStyleMaskClosable
             backing:NSBackingStoreBuffered defer:NO];
         if(!normalWindow) {
             fprintf(stderr, "(cocoa) can't create window\n");
@@ -1152,8 +1181,8 @@ - (void)make_about_window
     int x = 0, y = 0, about_width = 400, about_height = 200;
     NSRect window_rect = NSMakeRect(x, y, about_width, about_height);
     about_window = [[NSWindow alloc] initWithContentRect:window_rect
-                    styleMask:NSTitledWindowMask | NSClosableWindowMask |
-                    NSMiniaturizableWindowMask
+                    styleMask:NSWindowStyleMaskTitled | NSWindowStyleMaskClosable |
+                    NSWindowStyleMaskMiniaturizable
                     backing:NSBackingStoreBuffered
                     defer:NO];
     [about_window setTitle: @"About"];
@@ -1192,7 +1221,7 @@ - (void)make_about_window
     [name_label setEditable: NO];
     [name_label setBezeled: NO];
     [name_label setDrawsBackground: NO];
-    [name_label setAlignment: NSCenterTextAlignment];
+    [name_label setAlignment: NSTextAlignmentCenter];
     NSString *qemu_name = [[NSString alloc] initWithCString: gArgv[0]
                                             encoding: NSASCIIStringEncoding];
     qemu_name = [qemu_name lastPathComponent];
@@ -1208,7 +1237,7 @@ - (void)make_about_window
                                                       version_rect];
     [version_label setEditable: NO];
     [version_label setBezeled: NO];
-    [version_label setAlignment: NSCenterTextAlignment];
+    [version_label setAlignment: NSTextAlignmentCenter];
     [version_label setDrawsBackground: NO];
 
     /* Create the version string*/
@@ -1228,7 +1257,7 @@ - (void)make_about_window
     [copyright_label setEditable: NO];
     [copyright_label setBezeled: NO];
     [copyright_label setDrawsBackground: NO];
-    [copyright_label setAlignment: NSCenterTextAlignment];
+    [copyright_label setAlignment: NSTextAlignmentCenter];
     [copyright_label setStringValue: [NSString stringWithFormat: @"%s",
                                      QEMU_COPYRIGHT]];
     [superView addSubview: copyright_label];
@@ -1285,7 +1314,7 @@ int main (int argc, const char * argv[]) {
     [menu addItem:[NSMenuItem separatorItem]]; //Separator
     [menu addItemWithTitle:@"Hide QEMU" action:@selector(hide:) keyEquivalent:@"h"]; //Hide QEMU
     menuItem = (NSMenuItem *)[menu addItemWithTitle:@"Hide Others" action:@selector(hideOtherApplications:) keyEquivalent:@"h"]; // Hide Others
-    [menuItem setKeyEquivalentModifierMask:(NSAlternateKeyMask|NSCommandKeyMask)];
+    [menuItem setKeyEquivalentModifierMask:(NSEventModifierFlagOption|NSEventModifierFlagCommand)];
     [menu addItemWithTitle:@"Show All" action:@selector(unhideAllApplications:) keyEquivalent:@""]; // Show All
     [menu addItem:[NSMenuItem separatorItem]]; //Separator
     [menu addItemWithTitle:@"Quit QEMU" action:@selector(terminate:) keyEquivalent:@"q"];
@@ -1399,7 +1428,7 @@ static void cocoa_refresh(DisplayChangeListener *dcl)
     NSEvent *event;
     distantPast = [NSDate distantPast];
     do {
-        event = [NSApp nextEventMatchingMask:NSAnyEventMask untilDate:distantPast
+        event = [NSApp nextEventMatchingMask:NSEventMaskAny untilDate:distantPast
                         inMode: NSDefaultRunLoopMode dequeue:YES];
         if (event != nil) {
             [cocoaView handleEvent:event];
-- 
2.11.0 (Apple Git-81)
