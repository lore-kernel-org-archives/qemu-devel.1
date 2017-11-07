Received: from eggs.gnu.org ([2001:4830:134:3::10]:52447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eC0uu-0000Ol-JC
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:15:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eC0ur-0007rL-TX
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:15:36 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:38228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eC0ur-0007lV-MP
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:15:33 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  7 Nov 2017 10:16:00 +0000
Message-Id: <1510049762-4609-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1510049762-4609-1-git-send-email-peter.maydell@linaro.org>
References: <1510049762-4609-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 1/3] ui/cocoa.m: Make scrolling work again in
 GUI monitor windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: programmingkidx@gmail.com

From: John Arbuckle <programmingkidx@gmail.com>

Make scrolling in the monitor work, by correctly passing through
control+key combinations.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
Message-id: 20171101154607.1582-1-programmingkidx@gmail.com
[PMM: fixed coding style nits; cleaned up commit message]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 ui/cocoa.m | 98 ++++++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 66 insertions(+), 32 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 2794f60..2f76dac 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -281,6 +281,7 @@ static void handleAnyDeviceErrors(Error * err)
 - (void) grabMouse;
 - (void) ungrabMouse;
 - (void) toggleFullScreen:(id)sender;
+- (void) handleMonitorInput:(NSEvent *)event;
 - (void) handleEvent:(NSEvent *)event;
 - (void) setAbsoluteEnabled:(BOOL)tIsAbsoluteEnabled;
 /* The state surrounding mouse grabbing is potentially confusing.
@@ -554,6 +555,70 @@ QemuCocoaView *cocoaView;
     qemu_input_event_send_key_qcode(dcl->con, keycode, false);
 }
 
+// Does the work of sending input to the monitor
+- (void) handleMonitorInput:(NSEvent *)event
+{
+    int keysym = 0;
+    int control_key = 0;
+
+    // if the control key is down
+    if ([event modifierFlags] & NSEventModifierFlagControl) {
+        control_key = 1;
+    }
+
+    /* translates Macintosh keycodes to QEMU's keysym */
+
+    int without_control_translation[] = {
+        [0 ... 0xff] = 0,   // invalid key
+
+        [kVK_UpArrow]       = QEMU_KEY_UP,
+        [kVK_DownArrow]     = QEMU_KEY_DOWN,
+        [kVK_RightArrow]    = QEMU_KEY_RIGHT,
+        [kVK_LeftArrow]     = QEMU_KEY_LEFT,
+        [kVK_Home]          = QEMU_KEY_HOME,
+        [kVK_End]           = QEMU_KEY_END,
+        [kVK_PageUp]        = QEMU_KEY_PAGEUP,
+        [kVK_PageDown]      = QEMU_KEY_PAGEDOWN,
+        [kVK_ForwardDelete] = QEMU_KEY_DELETE,
+        [kVK_Delete]        = QEMU_KEY_BACKSPACE,
+    };
+
+    int with_control_translation[] = {
+        [0 ... 0xff] = 0,   // invalid key
+
+        [kVK_UpArrow]       = QEMU_KEY_CTRL_UP,
+        [kVK_DownArrow]     = QEMU_KEY_CTRL_DOWN,
+        [kVK_RightArrow]    = QEMU_KEY_CTRL_RIGHT,
+        [kVK_LeftArrow]     = QEMU_KEY_CTRL_LEFT,
+        [kVK_Home]          = QEMU_KEY_CTRL_HOME,
+        [kVK_End]           = QEMU_KEY_CTRL_END,
+        [kVK_PageUp]        = QEMU_KEY_CTRL_PAGEUP,
+        [kVK_PageDown]      = QEMU_KEY_CTRL_PAGEDOWN,
+    };
+
+    if (control_key != 0) { /* If the control key is being used */
+        if ([event keyCode] < ARRAY_SIZE(with_control_translation)) {
+            keysym = with_control_translation[[event keyCode]];
+        }
+    } else {
+        if ([event keyCode] < ARRAY_SIZE(without_control_translation)) {
+            keysym = without_control_translation[[event keyCode]];
+        }
+    }
+
+    // if not a key that needs translating
+    if (keysym == 0) {
+        NSString *ks = [event characters];
+        if ([ks length] > 0) {
+            keysym = [ks characterAtIndex:0];
+        }
+    }
+
+    if (keysym) {
+        kbd_put_keysym(keysym);
+    }
+}
+
 - (void) handleEvent:(NSEvent *)event
 {
     COCOA_DEBUG("QemuCocoaView: handleEvent\n");
@@ -641,38 +706,7 @@ QemuCocoaView *cocoaView;
 
             // handlekeys for Monitor
             } else {
-                int keysym = 0;
-                switch([event keyCode]) {
-                case 115:
-                    keysym = QEMU_KEY_HOME;
-                    break;
-                case 117:
-                    keysym = QEMU_KEY_DELETE;
-                    break;
-                case 119:
-                    keysym = QEMU_KEY_END;
-                    break;
-                case 123:
-                    keysym = QEMU_KEY_LEFT;
-                    break;
-                case 124:
-                    keysym = QEMU_KEY_RIGHT;
-                    break;
-                case 125:
-                    keysym = QEMU_KEY_DOWN;
-                    break;
-                case 126:
-                    keysym = QEMU_KEY_UP;
-                    break;
-                default:
-                    {
-                        NSString *ks = [event characters];
-                        if ([ks length] > 0)
-                            keysym = [ks characterAtIndex:0];
-                    }
-                }
-                if (keysym)
-                    kbd_put_keysym(keysym);
+                [self handleMonitorInput: event];
             }
             break;
         case NSEventTypeKeyUp:
-- 
2.7.4
