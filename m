Received: from eggs.gnu.org ([2001:4830:134:3::10]:33420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1e9vE6-0001XZ-7y
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 11:46:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1e9vE1-0000Sc-5D
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 11:46:46 -0400
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:55131)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1e9vE1-0000Rj-0D
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 11:46:41 -0400
Received: by mail-io0-x241.google.com with SMTP id e89so6951462ioi.11
	for <qemu-devel@nongnu.org>; Wed, 01 Nov 2017 08:46:40 -0700 (PDT)
From: John Arbuckle <programmingkidx@gmail.com>
Date: Wed,  1 Nov 2017 11:46:07 -0400
Message-Id: <20171101154607.1582-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [PATCH v2] Make scrolling work again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: John Arbuckle <programmingkidx@gmail.com>

Make scrolling in the monitor work.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
 ui/cocoa.m | 96 +++++++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 64 insertions(+), 32 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 93e56d0518..744fa31a56 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -281,6 +281,7 @@ - (void) switchSurface:(DisplaySurface *)surface;
 - (void) grabMouse;
 - (void) ungrabMouse;
 - (void) toggleFullScreen:(id)sender;
+- (void) handleMonitorInput:(NSEvent *)event;
 - (void) handleEvent:(NSEvent *)event;
 - (void) setAbsoluteEnabled:(BOOL)tIsAbsoluteEnabled;
 /* The state surrounding mouse grabbing is potentially confusing.
@@ -554,6 +555,68 @@ - (void) toggleStatefulModifier: (int)keycode {
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
+        if ([ks length] > 0)
+            keysym = [ks characterAtIndex:0];
+    }
+
+    if (keysym)
+        kbd_put_keysym(keysym);
+}
+
 - (void) handleEvent:(NSEvent *)event
 {
     COCOA_DEBUG("QemuCocoaView: handleEvent\n");
@@ -641,38 +704,7 @@ - (void) handleEvent:(NSEvent *)event
 
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
2.13.5 (Apple Git-94)
