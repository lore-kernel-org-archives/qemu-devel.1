Received: from eggs.gnu.org ([2001:4830:134:3::10]:49415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eANCq-0002pZ-BW
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 17:39:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eANCo-0008Vy-0L
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 17:39:20 -0400
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:53239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1eANCn-0008Vq-S0
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 17:39:17 -0400
Received: by mail-io0-x241.google.com with SMTP id f20so2124721ioj.9
	for <qemu-devel@nongnu.org>; Thu, 02 Nov 2017 14:39:17 -0700 (PDT)
From: John Arbuckle <programmingkidx@gmail.com>
Date: Thu,  2 Nov 2017 17:39:07 -0400
Message-Id: <20171102213907.11443-2-programmingkidx@gmail.com>
In-Reply-To: <20171102213907.11443-1-programmingkidx@gmail.com>
References: <20171102213907.11443-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [PATCH v3 2/2] ui/cocoa.m: send ctrl-alt key
 combinations to guest if not used by QEMU
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

Send control-alt key combinations to the guest if not used by the user interface.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
v3 changes:
- Code is now keyboard layout aware

v2 changes:
- changed logic to use existing if case

 ui/cocoa.m | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index e06aa9c65f..030479f4cd 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -619,29 +619,28 @@ - (void) handleEvent:(NSEvent *)event
                 return;
             }
 
-            // default
-
-            // handle control + alt Key Combos (ctrl+alt+[1..9,g] is reserved for QEMU)
-            if (([event modifierFlags] & NSEventModifierFlagControl) && ([event modifierFlags] & NSEventModifierFlagOption)) {
+            // console selection
+            if (([event modifierFlags] & NSEventModifierFlagControl) &&
+                ([event modifierFlags] & NSEventModifierFlagOption) &&
+                ([[event charactersIgnoringModifiers] length] == 1) &&
+                (isdigit([[event charactersIgnoringModifiers] characterAtIndex: 0]))) {
                 NSString *keychar = [event charactersIgnoringModifiers];
-                if ([keychar length] == 1) {
-                    char key = [keychar characterAtIndex:0];
-                    switch (key) {
-
-                        // enable graphic console
-                        case '1' ... '9':
-                            console_select(key - '0' - 1); /* ascii math */
-                            return;
-
-                        // release the mouse grab
-                        case 'g':
-                            [self ungrabMouse];
-                            return;
-                    }
-                }
+                char key = [keychar characterAtIndex:0];
+                console_select(key - '0' - 1); /* ascii math */
+                return;
+            }
+
+            // mouse ungrab
+            else if (([event modifierFlags] & NSEventModifierFlagControl) &&
+                     ([event modifierFlags] & NSEventModifierFlagOption) &&
+                     ([[event charactersIgnoringModifiers] length] == 1) &&
+                     ([[event charactersIgnoringModifiers] characterAtIndex: 0] == 'g')) {
+                [self ungrabMouse];
+                return;
+            }
 
-            // handle keys for graphic console
-            } else if (qemu_console_is_graphic(NULL)) {
+            // send to guest
+            else if (qemu_console_is_graphic(NULL)) {
                 qemu_input_event_send_key_qcode(dcl->con, keycode, true);
 
             // handlekeys for Monitor
-- 
2.13.5 (Apple Git-94)
