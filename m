Received: from eggs.gnu.org ([2001:4830:134:3::10]:40828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cRGbk-0001GP-TC
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 05:58:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cRGbh-0007Um-Qg
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 05:58:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cRGbh-0007UO-IQ
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 05:58:17 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 11 Jan 2017 11:58:12 +0100
Message-Id: <1484132292-21458-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] cocoa: stop using MOUSE_EVENT_*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

No need to go the indirect route with a bitfield and mapping the bits to
INPUT_BUTTON_*.  We can use a bool array and INPUT_BUTTON_* directly
instead.

Untested, not even compiled, due to lack of a osx^Wmacos machine.
Test results are very welcome.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/cocoa.m | 46 +++++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 26d4a1c..599b899 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -66,7 +66,7 @@ typedef struct {
 
 NSWindow *normalWindow, *about_window;
 static DisplayChangeListener *dcl;
-static int last_buttons;
+static bool last_buttons[INPUT_BUTTON__MAX];
 
 int gArgc;
 char **gArgv;
@@ -511,7 +511,9 @@ QemuCocoaView *cocoaView;
 {
     COCOA_DEBUG("QemuCocoaView: handleEvent\n");
 
-    int buttons = 0;
+    bool buttons[INPUT_BUTTON__MAX] = {
+        [ 0 ... (INPUT_BUTTON__MAX-1) ] = false;
+    };
     int keycode;
     bool mouse_event = false;
     NSPoint p = [event locationInWindow];
@@ -638,34 +640,34 @@ QemuCocoaView *cocoaView;
             break;
         case NSLeftMouseDown:
             if ([event modifierFlags] & NSCommandKeyMask) {
-                buttons |= MOUSE_EVENT_RBUTTON;
+                buttons[INPUT_BUTTON_RIGHT] = true;
             } else {
-                buttons |= MOUSE_EVENT_LBUTTON;
+                buttons[INPUT_BUTTON_LEFT] = true;
             }
             mouse_event = true;
             break;
         case NSRightMouseDown:
-            buttons |= MOUSE_EVENT_RBUTTON;
+            buttons[INPUT_BUTTON_RIGHT] = true;
             mouse_event = true;
             break;
         case NSOtherMouseDown:
-            buttons |= MOUSE_EVENT_MBUTTON;
+            buttons[INPUT_BUTTON_MIDDLE] = true;
             mouse_event = true;
             break;
         case NSLeftMouseDragged:
             if ([event modifierFlags] & NSCommandKeyMask) {
-                buttons |= MOUSE_EVENT_RBUTTON;
+                buttons[INPUT_BUTTON_RIGHT] = true;
             } else {
-                buttons |= MOUSE_EVENT_LBUTTON;
+                buttons[INPUT_BUTTON_LEFT] = true;
             }
             mouse_event = true;
             break;
         case NSRightMouseDragged:
-            buttons |= MOUSE_EVENT_RBUTTON;
+            buttons[INPUT_BUTTON_RIGHT] = true;
             mouse_event = true;
             break;
         case NSOtherMouseDragged:
-            buttons |= MOUSE_EVENT_MBUTTON;
+            buttons[INPUT_BUTTON_MIDDLE] = true;
             mouse_event = true;
             break;
         case NSLeftMouseUp:
@@ -684,8 +686,11 @@ QemuCocoaView *cocoaView;
             break;
         case NSScrollWheel:
             if (isMouseGrabbed) {
-                buttons |= ([event deltaY] < 0) ?
-                    MOUSE_EVENT_WHEELUP : MOUSE_EVENT_WHEELDN;
+                if ([event deltaY] < 0) {
+                    buttons[INPUT_BUTTON_WHEEL_UP] = true;
+                } else {
+                    buttons[INPUT_BUTTON_WHEEL_DOWN] = true;
+                }
             }
             mouse_event = true;
             break;
@@ -703,15 +708,14 @@ QemuCocoaView *cocoaView;
          */
         if ((isMouseGrabbed || [[self window] isKeyWindow]) &&
             (last_buttons != buttons)) {
-            static uint32_t bmap[INPUT_BUTTON__MAX] = {
-                [INPUT_BUTTON_LEFT]       = MOUSE_EVENT_LBUTTON,
-                [INPUT_BUTTON_MIDDLE]     = MOUSE_EVENT_MBUTTON,
-                [INPUT_BUTTON_RIGHT]      = MOUSE_EVENT_RBUTTON,
-                [INPUT_BUTTON_WHEEL_UP]   = MOUSE_EVENT_WHEELUP,
-                [INPUT_BUTTON_WHEEL_DOWN] = MOUSE_EVENT_WHEELDN,
-            };
-            qemu_input_update_buttons(dcl->con, bmap, last_buttons, buttons);
-            last_buttons = buttons;
+            InputButton btn;
+
+            for (btn = 0; btn < INPUT_BUTTON__MAX; btn++) {
+                if (last_button[btn] != button[btn]) {
+                    qemu_input_queue_btn(dcl->con, btn, button[btn]);
+                    last_button[btn] = button[btn];
+                }
+            }
         }
         if (isMouseGrabbed) {
             if (isAbsoluteEnabled) {
-- 
1.8.3.1
