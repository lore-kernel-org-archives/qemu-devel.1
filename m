Received: from eggs.gnu.org ([2001:4830:134:3::10]:44529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eezHG-00027Z-Au
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 03:22:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eezHC-0004FU-TJ
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 03:22:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eezHC-0004FA-OS
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 03:22:22 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 26 Jan 2018 09:05:14 +0100
Message-Id: <20180126080515.26108-5-kraxel@redhat.com>
In-Reply-To: <20180126080515.26108-1-kraxel@redhat.com>
References: <20180126080515.26108-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/5] usb-ccid: inline ccid_card_initfn() in
 ccid_card_realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Gerd Hoffmann <kraxel@redhat.com>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20180125171432.13554-3-f4bug@amsat.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-smartcard-reader.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.=
c
index 0092493f4e..85f5f2247b 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -510,20 +510,6 @@ static void ccid_card_exitfn(CCIDCardState *card)
=20
 }
=20
-static void ccid_card_initfn(CCIDCardState *card, Error **errp)
-{
-    CCIDCardClass *cc =3D CCID_CARD_GET_CLASS(card);
-    Error *local_err =3D NULL;
-
-    if (cc->realize) {
-        cc->realize(card, &local_err);
-        if (local_err !=3D NULL) {
-            error_propagate(errp, local_err);
-            return;
-        }
-    }
-}
-
 static bool ccid_has_pending_answers(USBCCIDState *s)
 {
     return s->pending_answers_num > 0;
@@ -1302,6 +1288,7 @@ static int ccid_card_exit(DeviceState *qdev)
 static void ccid_card_realize(DeviceState *qdev, Error **errp)
 {
     CCIDCardState *card =3D CCID_CARD(qdev);
+    CCIDCardClass *cc =3D CCID_CARD_GET_CLASS(card);
     USBDevice *dev =3D USB_DEVICE(qdev->parent_bus->parent);
     USBCCIDState *s =3D USB_CCID_DEV(dev);
     Error *local_err =3D NULL;
@@ -1315,10 +1302,12 @@ static void ccid_card_realize(DeviceState *qdev, =
Error **errp)
         error_setg(errp, "usb-ccid card already full, not adding");
         return;
     }
-    ccid_card_initfn(card, &local_err);
-    if (local_err !=3D NULL) {
-        error_propagate(errp, local_err);
-        return;
+    if (cc->realize) {
+        cc->realize(card, &local_err);
+        if (local_err !=3D NULL) {
+            error_propagate(errp, local_err);
+            return;
+        }
     }
     s->card =3D card;
 }
--=20
2.9.3
