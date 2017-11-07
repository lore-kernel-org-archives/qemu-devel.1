Received: from eggs.gnu.org ([2001:4830:134:3::10]:52479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eC0ux-0000QX-PE
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:15:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eC0uq-0007qH-4G
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:15:39 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:38228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eC0up-0007lV-SX
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:15:32 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  7 Nov 2017 10:16:01 +0000
Message-Id: <1510049762-4609-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1510049762-4609-1-git-send-email-peter.maydell@linaro.org>
References: <1510049762-4609-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 2/3] ui/cocoa.m: move ungrab to ctrl-alt-g
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

Currently the cocoa user interface relis on the user pushing
control-alt to ungrab the mouse.  This is patch changes the key
combination to control-alt-g to be in line with the GTK user
interface.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
Message-id: 20171102213907.11443-1-programmingkidx@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 ui/cocoa.m | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 2f76dac..f39c792 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -674,10 +674,6 @@ QemuCocoaView *cocoaView;
                 }
             }
 
-            // release Mouse grab when pressing ctrl+alt
-            if (([event modifierFlags] & NSEventModifierFlagControl) && ([event modifierFlags] & NSEventModifierFlagOption)) {
-                [self ungrabMouse];
-            }
             break;
         case NSEventTypeKeyDown:
             keycode = cocoa_keycode_to_qemu([event keyCode]);
@@ -690,14 +686,23 @@ QemuCocoaView *cocoaView;
 
             // default
 
-            // handle control + alt Key Combos (ctrl+alt is reserved for QEMU)
+            // handle control + alt Key Combos (ctrl+alt+[1..9,g] is reserved for QEMU)
             if (([event modifierFlags] & NSEventModifierFlagControl) && ([event modifierFlags] & NSEventModifierFlagOption)) {
-                switch (keycode) {
-
-                    // enable graphic console
-                    case Q_KEY_CODE_1 ... Q_KEY_CODE_9: // '1' to '9' keys
-                        console_select(keycode - Q_KEY_CODE_1);
-                        break;
+                NSString *keychar = [event charactersIgnoringModifiers];
+                if ([keychar length] == 1) {
+                    char key = [keychar characterAtIndex:0];
+                    switch (key) {
+
+                        // enable graphic console
+                        case '1' ... '9':
+                            console_select(key - '0' - 1); /* ascii math */
+                            return;
+
+                        // release the mouse grab
+                        case 'g':
+                            [self ungrabMouse];
+                            return;
+                    }
                 }
 
             // handle keys for graphic console
@@ -840,9 +845,9 @@ QemuCocoaView *cocoaView;
 
     if (!isFullscreen) {
         if (qemu_name)
-            [normalWindow setTitle:[NSString stringWithFormat:@"QEMU %s - (Press ctrl + alt to release Mouse)", qemu_name]];
+            [normalWindow setTitle:[NSString stringWithFormat:@"QEMU %s - (Press ctrl + alt + g to release Mouse)", qemu_name]];
         else
-            [normalWindow setTitle:@"QEMU - (Press ctrl + alt to release Mouse)"];
+            [normalWindow setTitle:@"QEMU - (Press ctrl + alt + g to release Mouse)"];
     }
     [self hideCursor];
     if (!isAbsoluteEnabled) {
-- 
2.7.4
