Received: from eggs.gnu.org ([2001:4830:134:3::10]:47840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1e07ZX-0000fi-Ey
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:56:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1e07ZT-0002dn-Ss
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:56:23 -0400
Received: from mail-it0-x22e.google.com ([2607:f8b0:4001:c0b::22e]:46861)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1e07ZT-0002cR-OW
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:56:19 -0400
Received: by mail-it0-x22e.google.com with SMTP id v62so1707577itd.1
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 07:56:19 -0700 (PDT)
From: John Arbuckle <programmingkidx@gmail.com>
Date: Thu,  5 Oct 2017 10:55:57 -0400
Message-Id: <20171005145557.5746-3-programmingkidx@gmail.com>
In-Reply-To: <20171005145557.5746-1-programmingkidx@gmail.com>
References: <20171005145557.5746-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [PATCH v2 2/2] ui/cocoa.m: send ctrl-alt key
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

---
v2 changes:
- changed logic to use existing if case

 ui/cocoa.m | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index d3e7907103..828d507d57 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -619,25 +619,22 @@ - (void) handleEvent:(NSEvent *)event
                 return;
             }
 
-            // default
-
-            // handle control + alt Key Combos (ctrl+alt+[1..9,g] is reserved for QEMU)
-            if (([event modifierFlags] & NSEventModifierFlagControl) && ([event modifierFlags] & NSEventModifierFlagOption)) {
-                switch (keycode) {
-
-                    // enable graphic console
-                    case Q_KEY_CODE_1 ... Q_KEY_CODE_9: // '1' to '9' keys
-                        console_select(keycode - 11);
-                        break;
+            // console selection
+            if (([event modifierFlags] & NSEventModifierFlagControl) &&
+                ([event modifierFlags] & NSEventModifierFlagOption) &&
+                (keycode >= Q_KEY_CODE_1 && keycode <= Q_KEY_CODE_9)) {
+                console_select(keycode - 11);
+            }
 
-                    // release the mouse grab
-                    case Q_KEY_CODE_G:
-                        [self ungrabMouse];
-                        break;
-                }
+            // mouse ungrab
+            else if (([event modifierFlags] & NSEventModifierFlagControl) &&
+                     ([event modifierFlags] & NSEventModifierFlagOption) &&
+                     (keycode == Q_KEY_CODE_G)) {
+                [self ungrabMouse];
+            }
 
-            // handle keys for graphic console
-            } else if (qemu_console_is_graphic(NULL)) {
+            // send to guest
+            else if (qemu_console_is_graphic(NULL)) {
                 qemu_input_event_send_key_qcode(dcl->con, keycode, true);
 
             // handlekeys for Monitor
-- 
2.13.5 (Apple Git-94)
