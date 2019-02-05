Received: from eggs.gnu.org ([209.51.188.92]:42599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gqyQs-0007P8-UW
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 05:58:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gqyQq-0006I4-Sh
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 05:58:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gqyQo-00067X-ST
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 05:58:24 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  5 Feb 2019 11:57:49 +0100
Message-Id: <20190205105758.4230-6-kraxel@redhat.com>
In-Reply-To: <20190205105758.4230-1-kraxel@redhat.com>
References: <20190205105758.4230-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 05/14] ui/cocoa.m: Fix macOS 10.14 deprecation
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
Cc: libvir-list@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Brendan Shanks <brendan@bslabs.net>

From: Brendan Shanks <brendan@bslabs.net>

macOS 10.14 deprecated NSOnState/NSOffState in favour of
NSControlStateValueOn/NSControlStateValueOff. Use the new constants,
and #define them to the old ones when compiling against a pre-10.13 SDK.
Also [NSGraphicsContext graphicsPort] is now deprecated, use
[NSGraphicsContext CGContext] when available.

Signed-off-by: Brendan Shanks <brendan@bslabs.net>
Message-id: 20190201071225.20576-1-brendan@bslabs.net
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/cocoa.m | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index ddc058e76e..e2567d6946 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -54,6 +54,9 @@
 #ifndef MAC_OS_X_VERSION_10_12
 #define MAC_OS_X_VERSION_10_12 101200
 #endif
+#ifndef MAC_OS_X_VERSION_10_13
+#define MAC_OS_X_VERSION_10_13 101300
+#endif
 
 /* macOS 10.12 deprecated many constants, #define the new names for older SDKs */
 #if MAC_OS_X_VERSION_MAX_ALLOWED < MAC_OS_X_VERSION_10_12
@@ -90,6 +93,14 @@
 #if MAC_OS_X_VERSION_MAX_ALLOWED < MAC_OS_X_VERSION_10_9
 #define NSModalResponseOK NSFileHandlingPanelOKButton
 #endif
+/* 10.14 deprecates NSOnState and NSOffState in favor of
+ * NSControlStateValueOn/Off, which were introduced in 10.13.
+ * Define for older versions
+ */
+#if MAC_OS_X_VERSION_MAX_ALLOWED < MAC_OS_X_VERSION_10_13
+#define NSControlStateValueOn NSOnState
+#define NSControlStateValueOff NSOffState
+#endif
 
 //#define DEBUG
 
@@ -377,7 +388,12 @@ QemuCocoaView *cocoaView;
     COCOA_DEBUG("QemuCocoaView: drawRect\n");
 
     // get CoreGraphic context
+#if MAC_OS_X_VERSION_MAX_ALLOWED < MAC_OS_X_VERSION_10_10
     CGContextRef viewContextRef = [[NSGraphicsContext currentContext] graphicsPort];
+#else
+    CGContextRef viewContextRef = [[NSGraphicsContext currentContext] CGContext];
+#endif
+
     CGContextSetInterpolationQuality (viewContextRef, kCGInterpolationNone);
     CGContextSetShouldAntialias (viewContextRef, NO);
 
@@ -1147,9 +1163,9 @@ QemuCocoaView *cocoaView;
 {
     stretch_video = !stretch_video;
     if (stretch_video == true) {
-        [sender setState: NSOnState];
+        [sender setState: NSControlStateValueOn];
     } else {
-        [sender setState: NSOffState];
+        [sender setState: NSControlStateValueOff];
     }
 }
 
@@ -1390,15 +1406,15 @@ QemuCocoaView *cocoaView;
     {
         /* Unselect the currently selected item */
         for (NSMenuItem *item in [menu itemArray]) {
-            if (item.state == NSOnState) {
-                [item setState: NSOffState];
+            if (item.state == NSControlStateValueOn) {
+                [item setState: NSControlStateValueOff];
                 break;
             }
         }
     }
 
     // check the menu item
-    [sender setState: NSOnState];
+    [sender setState: NSControlStateValueOn];
 
     // get the throttle percentage
     throttle_pct = [sender tag];
@@ -1502,7 +1518,7 @@ int main (int argc, const char * argv[]) {
                    initWithTitle: [NSString stringWithFormat: @"%d%%", percentage] action:@selector(adjustSpeed:) keyEquivalent:@""] autorelease];
 
         if (percentage == 100) {
-            [menuItem setState: NSOnState];
+            [menuItem setState: NSControlStateValueOn];
         }
 
         /* Calculate the throttle percentage */
-- 
2.9.3
