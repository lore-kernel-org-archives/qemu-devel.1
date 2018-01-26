Received: from eggs.gnu.org ([2001:4830:134:3::10]:33126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ef50V-0000HG-U0
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 09:29:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ef50S-0001uR-Id
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 09:29:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:13999)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ef50S-0001tz-AZ
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 09:29:28 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 26 Jan 2018 09:05:13 +0100
Message-Id: <20180126080515.26108-4-kraxel@redhat.com>
In-Reply-To: <20180126080515.26108-1-kraxel@redhat.com>
References: <20180126080515.26108-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/5] hw/usb/ccid: Make ccid_card_init() take an
 error parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, Cao jin <caoj.fnst@cn.fujitsu.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Gerd Hoffmann <kraxel@redhat.com>

From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>

Replace init() of CCIDCardClass with realize, then convert
ccid_card_init(), ccid_card_initfn() and it's callbacks to
take an Error** in ordor to report the error more clearly.

Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20180125171432.13554-2-f4bug@amsat.org
[PMD: fixed s->card assignation in ccid_card_realize()]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/ccid.h                 |  2 +-
 hw/usb/ccid-card-emulated.c   | 44 +++++++++++++++++++++----------------=
------
 hw/usb/ccid-card-passthru.c   | 12 ++++++------
 hw/usb/dev-smartcard-reader.c | 37 ++++++++++++++++++++----------------
 4 files changed, 50 insertions(+), 45 deletions(-)

diff --git a/hw/usb/ccid.h b/hw/usb/ccid.h
index 1f070116d6..6c6c10188d 100644
--- a/hw/usb/ccid.h
+++ b/hw/usb/ccid.h
@@ -34,7 +34,7 @@ typedef struct CCIDCardClass {
                             const uint8_t *apdu,
                             uint32_t len);
     void (*exitfn)(CCIDCardState *card);
-    int (*initfn)(CCIDCardState *card);
+    void (*realize)(CCIDCardState *card, Error **errp);
 } CCIDCardClass;
=20
 /*
diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
index e646eb243b..daefd9f8f4 100644
--- a/hw/usb/ccid-card-emulated.c
+++ b/hw/usb/ccid-card-emulated.c
@@ -35,6 +35,7 @@
 #include "qemu/thread.h"
 #include "qemu/main-loop.h"
 #include "ccid.h"
+#include "qapi/error.h"
=20
 #define DPRINTF(card, lvl, fmt, ...) \
 do {\
@@ -401,10 +402,10 @@ static void card_event_handler(EventNotifier *notif=
ier)
     qemu_mutex_unlock(&card->event_list_mutex);
 }
=20
-static int init_event_notifier(EmulatedState *card)
+static int init_event_notifier(EmulatedState *card, Error **errp)
 {
     if (event_notifier_init(&card->notifier, false) < 0) {
-        DPRINTF(card, 2, "event notifier creation failed\n");
+        error_setg(errp, "ccid-card-emul: event notifier creation failed=
");
         return -1;
     }
     event_notifier_set_handler(&card->notifier, card_event_handler);
@@ -480,7 +481,7 @@ static uint32_t parse_enumeration(char *str,
     return ret;
 }
=20
-static int emulated_initfn(CCIDCardState *base)
+static void emulated_realize(CCIDCardState *base, Error **errp)
 {
     EmulatedState *card =3D EMULATED_CCID_CARD(base);
     VCardEmulError ret;
@@ -494,8 +495,8 @@ static int emulated_initfn(CCIDCardState *base)
     qemu_cond_init(&card->handle_apdu_cond);
     card->reader =3D NULL;
     card->quit_apdu_thread =3D 0;
-    if (init_event_notifier(card) < 0) {
-        return -1;
+    if (init_event_notifier(card, errp) < 0) {
+        return;
     }
=20
     card->backend =3D 0;
@@ -505,11 +506,11 @@ static int emulated_initfn(CCIDCardState *base)
     }
=20
     if (card->backend =3D=3D 0) {
-        printf("backend must be one of:\n");
+        error_setg(errp, "backend must be one of:");
         for (ptable =3D backend_enum_table; ptable->name !=3D NULL; ++pt=
able) {
-            printf("%s\n", ptable->name);
+            error_append_hint(errp, "%s\n", ptable->name);
         }
-        return -1;
+        return;
     }
=20
     /* TODO: a passthru backened that works on local machine. third card=
 type?*/
@@ -517,34 +518,33 @@ static int emulated_initfn(CCIDCardState *base)
         if (card->cert1 !=3D NULL && card->cert2 !=3D NULL && card->cert=
3 !=3D NULL) {
             ret =3D emulated_initialize_vcard_from_certificates(card);
         } else {
-            printf("%s: you must provide all three certs for"
-                   " certificates backend\n", TYPE_EMULATED_CCID);
-            return -1;
+            error_setg(errp, "%s: you must provide all three certs for"
+                       " certificates backend", TYPE_EMULATED_CCID);
+            return;
         }
     } else {
         if (card->backend !=3D BACKEND_NSS_EMULATED) {
-            printf("%s: bad backend specified. The options are:\n%s (def=
ault),"
-                " %s.\n", TYPE_EMULATED_CCID, BACKEND_NSS_EMULATED_NAME,
-                BACKEND_CERTIFICATES_NAME);
-            return -1;
+            error_setg(errp, "%s: bad backend specified. The options are=
:%s"
+                       " (default), %s.", TYPE_EMULATED_CCID,
+                       BACKEND_NSS_EMULATED_NAME, BACKEND_CERTIFICATES_N=
AME);
+            return;
         }
         if (card->cert1 !=3D NULL || card->cert2 !=3D NULL || card->cert=
3 !=3D NULL) {
-            printf("%s: unexpected cert parameters to nss emulated backe=
nd\n",
-                   TYPE_EMULATED_CCID);
-            return -1;
+            error_setg(errp, "%s: unexpected cert parameters to nss emul=
ated "
+                       "backend", TYPE_EMULATED_CCID);
+            return;
         }
         /* default to mirroring the local hardware readers */
         ret =3D wrap_vcard_emul_init(NULL);
     }
     if (ret !=3D VCARD_EMUL_OK) {
-        printf("%s: failed to initialize vcard\n", TYPE_EMULATED_CCID);
-        return -1;
+        error_setg(errp, "%s: failed to initialize vcard", TYPE_EMULATED=
_CCID);
+        return;
     }
     qemu_thread_create(&card->event_thread_id, "ccid/event", event_threa=
d,
                        card, QEMU_THREAD_JOINABLE);
     qemu_thread_create(&card->apdu_thread_id, "ccid/apdu", handle_apdu_t=
hread,
                        card, QEMU_THREAD_JOINABLE);
-    return 0;
 }
=20
 static void emulated_exitfn(CCIDCardState *base)
@@ -581,7 +581,7 @@ static void emulated_class_initfn(ObjectClass *klass,=
 void *data)
     DeviceClass *dc =3D DEVICE_CLASS(klass);
     CCIDCardClass *cc =3D CCID_CARD_CLASS(klass);
=20
-    cc->initfn =3D emulated_initfn;
+    cc->realize =3D emulated_realize;
     cc->exitfn =3D emulated_exitfn;
     cc->get_atr =3D emulated_get_atr;
     cc->apdu_from_guest =3D emulated_apdu_from_guest;
diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index 117711862e..b7dd3602dc 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -14,6 +14,7 @@
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
 #include "ccid.h"
+#include "qapi/error.h"
=20
 #define DPRINTF(card, lvl, fmt, ...)                    \
 do {                                                    \
@@ -337,29 +338,28 @@ static const uint8_t *passthru_get_atr(CCIDCardStat=
e *base, uint32_t *len)
     return card->atr;
 }
=20
-static int passthru_initfn(CCIDCardState *base)
+static void passthru_realize(CCIDCardState *base, Error **errp)
 {
     PassthruState *card =3D PASSTHRU_CCID_CARD(base);
=20
     card->vscard_in_pos =3D 0;
     card->vscard_in_hdr =3D 0;
     if (qemu_chr_fe_backend_connected(&card->cs)) {
-        DPRINTF(card, D_INFO, "initing chardev\n");
+        error_setg(errp, "ccid-card-passthru: initing chardev");
         qemu_chr_fe_set_handlers(&card->cs,
             ccid_card_vscard_can_read,
             ccid_card_vscard_read,
             ccid_card_vscard_event, NULL, card, NULL, true);
         ccid_card_vscard_send_init(card);
     } else {
-        error_report("missing chardev");
-        return -1;
+        error_setg(errp, "missing chardev");
+        return;
     }
     card->debug =3D parse_debug_env("QEMU_CCID_PASSTHRU_DEBUG", D_VERBOS=
E,
                                   card->debug);
     assert(sizeof(DEFAULT_ATR) <=3D MAX_ATR_SIZE);
     memcpy(card->atr, DEFAULT_ATR, sizeof(DEFAULT_ATR));
     card->atr_length =3D sizeof(DEFAULT_ATR);
-    return 0;
 }
=20
 static VMStateDescription passthru_vmstate =3D {
@@ -387,7 +387,7 @@ static void passthru_class_initfn(ObjectClass *klass,=
 void *data)
     DeviceClass *dc =3D DEVICE_CLASS(klass);
     CCIDCardClass *cc =3D CCID_CARD_CLASS(klass);
=20
-    cc->initfn =3D passthru_initfn;
+    cc->realize =3D passthru_realize;
     cc->get_atr =3D passthru_get_atr;
     cc->apdu_from_guest =3D passthru_apdu_from_guest;
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.=
c
index e334d3be11..0092493f4e 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -510,14 +510,18 @@ static void ccid_card_exitfn(CCIDCardState *card)
=20
 }
=20
-static int ccid_card_initfn(CCIDCardState *card)
+static void ccid_card_initfn(CCIDCardState *card, Error **errp)
 {
     CCIDCardClass *cc =3D CCID_CARD_GET_CLASS(card);
+    Error *local_err =3D NULL;
=20
-    if (cc->initfn) {
-        return cc->initfn(card);
+    if (cc->realize) {
+        cc->realize(card, &local_err);
+        if (local_err !=3D NULL) {
+            error_propagate(errp, local_err);
+            return;
+        }
     }
-    return 0;
 }
=20
 static bool ccid_has_pending_answers(USBCCIDState *s)
@@ -1295,27 +1299,28 @@ static int ccid_card_exit(DeviceState *qdev)
     return 0;
 }
=20
-static int ccid_card_init(DeviceState *qdev)
+static void ccid_card_realize(DeviceState *qdev, Error **errp)
 {
     CCIDCardState *card =3D CCID_CARD(qdev);
     USBDevice *dev =3D USB_DEVICE(qdev->parent_bus->parent);
     USBCCIDState *s =3D USB_CCID_DEV(dev);
-    int ret =3D 0;
+    Error *local_err =3D NULL;
=20
     if (card->slot !=3D 0) {
-        warn_report("usb-ccid supports one slot, can't add %d",
-                    card->slot);
-        return -1;
+        error_setg(errp, "usb-ccid supports one slot, can't add %d",
+                   card->slot);
+        return;
     }
     if (s->card !=3D NULL) {
-        warn_report("usb-ccid card already full, not adding");
-        return -1;
+        error_setg(errp, "usb-ccid card already full, not adding");
+        return;
     }
-    ret =3D ccid_card_initfn(card);
-    if (ret =3D=3D 0) {
-        s->card =3D card;
+    ccid_card_initfn(card, &local_err);
+    if (local_err !=3D NULL) {
+        error_propagate(errp, local_err);
+        return;
     }
-    return ret;
+    s->card =3D card;
 }
=20
 static void ccid_realize(USBDevice *dev, Error **errp)
@@ -1477,7 +1482,7 @@ static void ccid_card_class_init(ObjectClass *klass=
, void *data)
 {
     DeviceClass *k =3D DEVICE_CLASS(klass);
     k->bus_type =3D TYPE_CCID_BUS;
-    k->init =3D ccid_card_init;
+    k->realize =3D ccid_card_realize;
     k->exit =3D ccid_card_exit;
     k->props =3D ccid_props;
 }
--=20
2.9.3
