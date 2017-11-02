Received: from eggs.gnu.org ([2001:4830:134:3::10]:49416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eANCq-0002pa-Bt
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 17:39:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eANCn-0008Vl-9M
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 17:39:20 -0400
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:53398)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1eANCn-0008Vb-3p
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 17:39:17 -0400
Received: by mail-io0-x241.google.com with SMTP id 189so2106536iow.10
	for <qemu-devel@nongnu.org>; Thu, 02 Nov 2017 14:39:17 -0700 (PDT)
From: John Arbuckle <programmingkidx@gmail.com>
Date: Thu,  2 Nov 2017 17:39:06 -0400
Message-Id: <20171102213907.11443-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [PATCH v3 1/2] ui/cocoa.m: move ungrab to ctrl-alt-g
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

Currently the cocoa user interface relys on the user pushing control-alt to ungrab the mouse. This is patch changes the key combination to control-alt-g to be in line with the GTK user interface. 

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
v3 changes
- Code is now keyboard layout aware.

 ui/cocoa.m | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 2794f60b27..e06aa9c65f 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -609,10 +609,6 @@ - (void) handleEvent:(NSEvent *)event
                 }
             }
 
-            // release Mouse grab when pressing ctrl+alt
-            if (([event modifierFlags] & NSEventModifierFlagControl) && ([event modifierFlags] & NSEventModifierFlagOption)) {
-                [self ungrabMouse];
-            }
             break;
         case NSEventTypeKeyDown:
             keycode = cocoa_keycode_to_qemu([event keyCode]);
@@ -625,14 +621,23 @@ - (void) handleEvent:(NSEvent *)event
 
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
@@ -806,9 +811,9 @@ - (void) grabMouse
 
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
2.13.5 (Apple Git-94)
