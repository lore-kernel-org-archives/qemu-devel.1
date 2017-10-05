Received: from eggs.gnu.org ([2001:4830:134:3::10]:47841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1e07ZX-0000fj-F2
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:56:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1e07ZS-0002bC-WE
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:56:23 -0400
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:50894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1e07ZS-0002aD-Rc
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:56:18 -0400
Received: by mail-it0-x243.google.com with SMTP id y138so1690691itc.5
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 07:56:18 -0700 (PDT)
From: John Arbuckle <programmingkidx@gmail.com>
Date: Thu,  5 Oct 2017 10:55:56 -0400
Message-Id: <20171005145557.5746-2-programmingkidx@gmail.com>
In-Reply-To: <20171005145557.5746-1-programmingkidx@gmail.com>
References: <20171005145557.5746-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [PATCH v2 1/2] ui/cocoa.m: move ungrab to ctrl-alt-g
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

signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
 ui/cocoa.m | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 93e56d0518..d3e7907103 100644
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
@@ -625,7 +621,7 @@ - (void) handleEvent:(NSEvent *)event
 
             // default
 
-            // handle control + alt Key Combos (ctrl+alt is reserved for QEMU)
+            // handle control + alt Key Combos (ctrl+alt+[1..9,g] is reserved for QEMU)
             if (([event modifierFlags] & NSEventModifierFlagControl) && ([event modifierFlags] & NSEventModifierFlagOption)) {
                 switch (keycode) {
 
@@ -633,6 +629,11 @@ - (void) handleEvent:(NSEvent *)event
                     case Q_KEY_CODE_1 ... Q_KEY_CODE_9: // '1' to '9' keys
                         console_select(keycode - 11);
                         break;
+
+                    // release the mouse grab
+                    case Q_KEY_CODE_G:
+                        [self ungrabMouse];
+                        break;
                 }
 
             // handle keys for graphic console
@@ -806,9 +807,9 @@ - (void) grabMouse
 
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
