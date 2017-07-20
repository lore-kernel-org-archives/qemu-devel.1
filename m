Received: from eggs.gnu.org ([2001:4830:134:3::10]:44786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dYCZ8-00012b-IQ
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 10:36:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dYCZ4-0006oI-JP
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 10:36:34 -0400
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:36743)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dYCZ4-0006nz-FE
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 10:36:30 -0400
Received: by mail-io0-x241.google.com with SMTP id z74so563953ioz.3
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 07:36:28 -0700 (PDT)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Message-Id: <7843ECF8-2CA7-485F-B3D2-38A55D13D80D@gmail.com>
Date: Thu, 20 Jul 2017 10:36:25 -0400
Subject: [Qemu-devel] [PATCH] ui/cocoa.m: change mouse grab to control-alt-g
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

The GTK interface uses Control-Alt-G to ungrab the mouse. This patch =
changes the ungrab keys in the Cocoa interface to be consistent with the =
GTK interface. This patch has the added benefit of being able to send =
Control-Alt key combinations to the guest (like Control-Alt-Delete used =
in Windows).

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
 ui/cocoa.m | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 93e56d0..d64c7b9 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -609,10 +609,6 @@ QemuCocoaView *cocoaView;
                 }
             }
=20
-            // release Mouse grab when pressing ctrl+alt
-            if (([event modifierFlags] & NSEventModifierFlagControl) && =
([event modifierFlags] & NSEventModifierFlagOption)) {
-                [self ungrabMouse];
-            }
             break;
         case NSEventTypeKeyDown:
             keycode =3D cocoa_keycode_to_qemu([event keyCode]);
@@ -625,7 +621,7 @@ QemuCocoaView *cocoaView;
=20
             // default
=20
-            // handle control + alt Key Combos (ctrl+alt is reserved =
for QEMU)
+            // handle control + alt Key Combos (ctrl+alt+[1..9,g] is =
reserved for QEMU)
             if (([event modifierFlags] & NSEventModifierFlagControl) && =
([event modifierFlags] & NSEventModifierFlagOption)) {
                 switch (keycode) {
=20
@@ -633,6 +629,18 @@ QemuCocoaView *cocoaView;
                     case Q_KEY_CODE_1 ... Q_KEY_CODE_9: // '1' to '9' =
keys
                         console_select(keycode - 11);
                         break;
+
+                    // release the mouse grab
+                    case Q_KEY_CODE_G:
+                        [self ungrabMouse];
+                        break;
+
+                    // send to the guest
+                    default:
+                        qemu_input_event_send_key_qcode(dcl->con, =
Q_KEY_CODE_CTRL, true);
+                        qemu_input_event_send_key_qcode(dcl->con, =
Q_KEY_CODE_ALT, true);
+                        qemu_input_event_send_key_qcode(dcl->con, =
keycode, true);
+                        break;
                 }
=20
             // handle keys for graphic console
@@ -806,9 +814,9 @@ QemuCocoaView *cocoaView;
=20
     if (!isFullscreen) {
         if (qemu_name)
-            [normalWindow setTitle:[NSString stringWithFormat:@"QEMU %s =
- (Press ctrl + alt to release Mouse)", qemu_name]];
+            [normalWindow setTitle:[NSString stringWithFormat:@"QEMU %s =
- (Press ctrl + alt + g to release Mouse)", qemu_name]];
         else
-            [normalWindow setTitle:@"QEMU - (Press ctrl + alt to =
release Mouse)"];
+            [normalWindow setTitle:@"QEMU - (Press ctrl + alt + g to =
release Mouse)"];
     }
     [self hideCursor];
     if (!isAbsoluteEnabled) {
--=20
2.7.2
