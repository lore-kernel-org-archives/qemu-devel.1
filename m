Received: from eggs.gnu.org ([2001:4830:134:3::10]:41989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eez0t-0004MH-PS
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 03:05:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eez0q-00014D-Ju
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 03:05:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eez0q-00013q-Aj
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 03:05:28 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 26 Jan 2018 09:05:15 +0100
Message-Id: <20180126080515.26108-6-kraxel@redhat.com>
In-Reply-To: <20180126080515.26108-1-kraxel@redhat.com>
References: <20180126080515.26108-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 5/5] usb-ccid: convert CCIDCardClass::exitfn()
 -> unrealize()
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
Message-id: 20180125171432.13554-4-f4bug@amsat.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/ccid.h                 |  4 +++-
 hw/usb/ccid-card-emulated.c   |  4 ++--
 hw/usb/ccid-card-passthru.c   |  1 +
 hw/usb/dev-smartcard-reader.c | 25 +++++++++++--------------
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/hw/usb/ccid.h b/hw/usb/ccid.h
index 6c6c10188d..3920733f13 100644
--- a/hw/usb/ccid.h
+++ b/hw/usb/ccid.h
@@ -28,13 +28,15 @@ typedef struct CCIDCardInfo CCIDCardInfo;
  * into the smartcard device (hw/ccid-card-*.c)
  */
 typedef struct CCIDCardClass {
+    /*< private >*/
     DeviceClass parent_class;
+    /*< public >*/
     const uint8_t *(*get_atr)(CCIDCardState *card, uint32_t *len);
     void (*apdu_from_guest)(CCIDCardState *card,
                             const uint8_t *apdu,
                             uint32_t len);
-    void (*exitfn)(CCIDCardState *card);
     void (*realize)(CCIDCardState *card, Error **errp);
+    void (*unrealize)(CCIDCardState *card, Error **errp);
 } CCIDCardClass;
=20
 /*
diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
index daefd9f8f4..ea42e4681d 100644
--- a/hw/usb/ccid-card-emulated.c
+++ b/hw/usb/ccid-card-emulated.c
@@ -547,7 +547,7 @@ static void emulated_realize(CCIDCardState *base, Err=
or **errp)
                        card, QEMU_THREAD_JOINABLE);
 }
=20
-static void emulated_exitfn(CCIDCardState *base)
+static void emulated_unrealize(CCIDCardState *base, Error **errp)
 {
     EmulatedState *card =3D EMULATED_CCID_CARD(base);
     VEvent *vevent =3D vevent_new(VEVENT_LAST, NULL, NULL);
@@ -582,7 +582,7 @@ static void emulated_class_initfn(ObjectClass *klass,=
 void *data)
     CCIDCardClass *cc =3D CCID_CARD_CLASS(klass);
=20
     cc->realize =3D emulated_realize;
-    cc->exitfn =3D emulated_exitfn;
+    cc->unrealize =3D emulated_unrealize;
     cc->get_atr =3D emulated_get_atr;
     cc->apdu_from_guest =3D emulated_apdu_from_guest;
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index b7dd3602dc..085ed2c667 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -9,6 +9,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include <cacard/vscard_common.h>
 #include "chardev/char-fe.h"
 #include "qemu/error-report.h"
diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.=
c
index 85f5f2247b..e6468057a0 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -500,16 +500,6 @@ static void ccid_card_apdu_from_guest(CCIDCardState =
*card,
     }
 }
=20
-static void ccid_card_exitfn(CCIDCardState *card)
-{
-    CCIDCardClass *cc =3D CCID_CARD_GET_CLASS(card);
-
-    if (cc->exitfn) {
-        cc->exitfn(card);
-    }
-
-}
-
 static bool ccid_has_pending_answers(USBCCIDState *s)
 {
     return s->pending_answers_num > 0;
@@ -1271,18 +1261,25 @@ void ccid_card_card_inserted(CCIDCardState *card)
     ccid_on_slot_change(s, true);
 }
=20
-static int ccid_card_exit(DeviceState *qdev)
+static void ccid_card_unrealize(DeviceState *qdev, Error **errp)
 {
     CCIDCardState *card =3D CCID_CARD(qdev);
+    CCIDCardClass *cc =3D CCID_CARD_GET_CLASS(card);
     USBDevice *dev =3D USB_DEVICE(qdev->parent_bus->parent);
     USBCCIDState *s =3D USB_CCID_DEV(dev);
+    Error *local_err =3D NULL;
=20
     if (ccid_card_inserted(s)) {
         ccid_card_card_removed(card);
     }
-    ccid_card_exitfn(card);
+    if (cc->unrealize) {
+        cc->unrealize(card, &local_err);
+        if (local_err !=3D NULL) {
+            error_propagate(errp, local_err);
+            return;
+        }
+    }
     s->card =3D NULL;
-    return 0;
 }
=20
 static void ccid_card_realize(DeviceState *qdev, Error **errp)
@@ -1472,7 +1469,7 @@ static void ccid_card_class_init(ObjectClass *klass=
, void *data)
     DeviceClass *k =3D DEVICE_CLASS(klass);
     k->bus_type =3D TYPE_CCID_BUS;
     k->realize =3D ccid_card_realize;
-    k->exit =3D ccid_card_exit;
+    k->unrealize =3D ccid_card_unrealize;
     k->props =3D ccid_props;
 }
=20
--=20
2.9.3
