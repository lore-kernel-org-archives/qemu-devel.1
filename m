Received: from eggs.gnu.org ([2001:4830:134:3::10]:58685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaY92-0008LI-Gq
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 21:35:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaY8z-0003Q3-8x
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 21:35:36 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:42035)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaY8z-0003PS-2d
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 21:35:33 -0500
Received: by mail-qt0-x241.google.com with SMTP id c2so10506492qtn.9
	for <qemu-devel@nongnu.org>; Sat, 13 Jan 2018 18:35:32 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 13 Jan 2018 23:35:08 -0300
Message-Id: <20180114023508.27838-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] usb-ccid: QOM'ify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/usb/ccid.h                 |  9 +++++--
 hw/usb/ccid-card-emulated.c   | 48 +++++++++++++++++++-----------------
 hw/usb/ccid-card-passthru.c   | 13 +++++-----
 hw/usb/dev-smartcard-reader.c | 57 +++++++++++++++----------------------------
 4 files changed, 60 insertions(+), 67 deletions(-)

diff --git a/hw/usb/ccid.h b/hw/usb/ccid.h
index 1f070116d6..d9a1cbd09f 100644
--- a/hw/usb/ccid.h
+++ b/hw/usb/ccid.h
@@ -28,20 +28,25 @@ typedef struct CCIDCardInfo CCIDCardInfo;
  * into the smartcard device (hw/ccid-card-*.c)
  */
 typedef struct CCIDCardClass {
+    /*< private >*/
     DeviceClass parent_class;
+    /*< public >*/
+    DeviceRealize parent_realize;
+    DeviceUnrealize parent_unrealize;
+
     const uint8_t *(*get_atr)(CCIDCardState *card, uint32_t *len);
     void (*apdu_from_guest)(CCIDCardState *card,
                             const uint8_t *apdu,
                             uint32_t len);
-    void (*exitfn)(CCIDCardState *card);
-    int (*initfn)(CCIDCardState *card);
 } CCIDCardClass;
 
 /*
  * state of the CCID Card device (i.e. hw/ccid-card-*.c)
  */
 struct CCIDCardState {
+    /*< private >*/
     DeviceState qdev;
+    /*< public >*/
     uint32_t    slot; /* For future use with multiple slot reader. */
 };
 
diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
index e646eb243b..db2ed53773 100644
--- a/hw/usb/ccid-card-emulated.c
+++ b/hw/usb/ccid-card-emulated.c
@@ -27,6 +27,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include <eventt.h>
 #include <vevent.h>
 #include <vreader.h>
@@ -480,9 +481,9 @@ static uint32_t parse_enumeration(char *str,
     return ret;
 }
 
-static int emulated_initfn(CCIDCardState *base)
+static void emulated_realize(DeviceState *dev, Error **errp)
 {
-    EmulatedState *card = EMULATED_CCID_CARD(base);
+    EmulatedState *card = EMULATED_CCID_CARD(dev);
     VCardEmulError ret;
     const EnumTable *ptable;
 
@@ -495,7 +496,8 @@ static int emulated_initfn(CCIDCardState *base)
     card->reader = NULL;
     card->quit_apdu_thread = 0;
     if (init_event_notifier(card) < 0) {
-        return -1;
+        error_setg(errp, TYPE_EMULATED_CCID ": event notifier creation failed");
+        return;
     }
 
     card->backend = 0;
@@ -505,11 +507,12 @@ static int emulated_initfn(CCIDCardState *base)
     }
 
     if (card->backend == 0) {
-        printf("backend must be one of:\n");
+        error_setg(errp, TYPE_EMULATED_CCID ": no backend specified.");
+        printf("backend must be one of:\n"); /* TODO remove */
         for (ptable = backend_enum_table; ptable->name != NULL; ++ptable) {
             printf("%s\n", ptable->name);
         }
-        return -1;
+        return;
     }
 
     /* TODO: a passthru backened that works on local machine. third card type?*/
@@ -517,39 +520,38 @@ static int emulated_initfn(CCIDCardState *base)
         if (card->cert1 != NULL && card->cert2 != NULL && card->cert3 != NULL) {
             ret = emulated_initialize_vcard_from_certificates(card);
         } else {
-            printf("%s: you must provide all three certs for"
-                   " certificates backend\n", TYPE_EMULATED_CCID);
-            return -1;
+            error_setg(errp, TYPE_EMULATED_CCID ": you must provide all three "
+                             "certs for certificates backend");
+            return;
         }
     } else {
         if (card->backend != BACKEND_NSS_EMULATED) {
-            printf("%s: bad backend specified. The options are:\n%s (default),"
-                " %s.\n", TYPE_EMULATED_CCID, BACKEND_NSS_EMULATED_NAME,
-                BACKEND_CERTIFICATES_NAME);
-            return -1;
+            error_setg(errp, TYPE_EMULATED_CCID ": bad backend specified. "
+                             "The options are: %s (default), %s.",
+                       BACKEND_NSS_EMULATED_NAME, BACKEND_CERTIFICATES_NAME);
+            return;
         }
         if (card->cert1 != NULL || card->cert2 != NULL || card->cert3 != NULL) {
-            printf("%s: unexpected cert parameters to nss emulated backend\n",
-                   TYPE_EMULATED_CCID);
-            return -1;
+            error_setg(errp, TYPE_EMULATED_CCID ": unexpected cert parameters "
+                             "to nss emulated backend");
+            return;
         }
         /* default to mirroring the local hardware readers */
         ret = wrap_vcard_emul_init(NULL);
     }
     if (ret != VCARD_EMUL_OK) {
-        printf("%s: failed to initialize vcard\n", TYPE_EMULATED_CCID);
-        return -1;
+        error_setg(errp, TYPE_EMULATED_CCID ": failed to initialize vcard");
+        return;
     }
     qemu_thread_create(&card->event_thread_id, "ccid/event", event_thread,
                        card, QEMU_THREAD_JOINABLE);
     qemu_thread_create(&card->apdu_thread_id, "ccid/apdu", handle_apdu_thread,
                        card, QEMU_THREAD_JOINABLE);
-    return 0;
 }
 
-static void emulated_exitfn(CCIDCardState *base)
+static void emulated_unrealize(DeviceState *dev, Error **errp)
 {
-    EmulatedState *card = EMULATED_CCID_CARD(base);
+    EmulatedState *card = EMULATED_CCID_CARD(dev);
     VEvent *vevent = vevent_new(VEVENT_LAST, NULL, NULL);
 
     vevent_queue_vevent(vevent); /* stop vevent thread */
@@ -581,8 +583,10 @@ static void emulated_class_initfn(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     CCIDCardClass *cc = CCID_CARD_CLASS(klass);
 
-    cc->initfn = emulated_initfn;
-    cc->exitfn = emulated_exitfn;
+    cc->parent_realize = dc->realize;
+    dc->realize = emulated_realize;
+    cc->parent_unrealize = dc->unrealize;
+    dc->unrealize = emulated_unrealize;
     cc->get_atr = emulated_get_atr;
     cc->apdu_from_guest = emulated_apdu_from_guest;
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index 117711862e..50393f859e 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -9,6 +9,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include <cacard/vscard_common.h>
 #include "chardev/char-fe.h"
 #include "qemu/error-report.h"
@@ -337,9 +338,9 @@ static const uint8_t *passthru_get_atr(CCIDCardState *base, uint32_t *len)
     return card->atr;
 }
 
-static int passthru_initfn(CCIDCardState *base)
+static void passthru_realize(DeviceState *dev, Error **errp)
 {
-    PassthruState *card = PASSTHRU_CCID_CARD(base);
+    PassthruState *card = PASSTHRU_CCID_CARD(dev);
 
     card->vscard_in_pos = 0;
     card->vscard_in_hdr = 0;
@@ -351,15 +352,14 @@ static int passthru_initfn(CCIDCardState *base)
             ccid_card_vscard_event, NULL, card, NULL, true);
         ccid_card_vscard_send_init(card);
     } else {
-        error_report("missing chardev");
-        return -1;
+        error_setg(errp, "missing chardev");
+        return;
     }
     card->debug = parse_debug_env("QEMU_CCID_PASSTHRU_DEBUG", D_VERBOSE,
                                   card->debug);
     assert(sizeof(DEFAULT_ATR) <= MAX_ATR_SIZE);
     memcpy(card->atr, DEFAULT_ATR, sizeof(DEFAULT_ATR));
     card->atr_length = sizeof(DEFAULT_ATR);
-    return 0;
 }
 
 static VMStateDescription passthru_vmstate = {
@@ -387,7 +387,8 @@ static void passthru_class_initfn(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     CCIDCardClass *cc = CCID_CARD_CLASS(klass);
 
-    cc->initfn = passthru_initfn;
+    cc->parent_realize = dc->realize;
+    dc->realize = passthru_realize;
     cc->get_atr = passthru_get_atr;
     cc->apdu_from_guest = passthru_apdu_from_guest;
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index e334d3be11..cbd00645c3 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -37,7 +37,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
-#include "qemu/error-report.h"
 #include "hw/usb.h"
 #include "hw/usb/desc.h"
 
@@ -500,26 +499,6 @@ static void ccid_card_apdu_from_guest(CCIDCardState *card,
     }
 }
 
-static void ccid_card_exitfn(CCIDCardState *card)
-{
-    CCIDCardClass *cc = CCID_CARD_GET_CLASS(card);
-
-    if (cc->exitfn) {
-        cc->exitfn(card);
-    }
-
-}
-
-static int ccid_card_initfn(CCIDCardState *card)
-{
-    CCIDCardClass *cc = CCID_CARD_GET_CLASS(card);
-
-    if (cc->initfn) {
-        return cc->initfn(card);
-    }
-    return 0;
-}
-
 static bool ccid_has_pending_answers(USBCCIDState *s)
 {
     return s->pending_answers_num > 0;
@@ -1281,41 +1260,45 @@ void ccid_card_card_inserted(CCIDCardState *card)
     ccid_on_slot_change(s, true);
 }
 
-static int ccid_card_exit(DeviceState *qdev)
+static void ccid_card_unrealize(DeviceState *qdev, Error **errp)
 {
     CCIDCardState *card = CCID_CARD(qdev);
+    CCIDCardClass *cc = CCID_CARD_GET_CLASS(card);
     USBDevice *dev = USB_DEVICE(qdev->parent_bus->parent);
     USBCCIDState *s = USB_CCID_DEV(dev);
 
     if (ccid_card_inserted(s)) {
         ccid_card_card_removed(card);
     }
-    ccid_card_exitfn(card);
+    if (cc->parent_unrealize) {
+        cc->parent_unrealize(qdev, errp);
+    }
     s->card = NULL;
-    return 0;
 }
 
-static int ccid_card_init(DeviceState *qdev)
+static void ccid_card_realize(DeviceState *qdev, Error **errp)
 {
     CCIDCardState *card = CCID_CARD(qdev);
+    CCIDCardClass *cc = CCID_CARD_GET_CLASS(card);
     USBDevice *dev = USB_DEVICE(qdev->parent_bus->parent);
     USBCCIDState *s = USB_CCID_DEV(dev);
-    int ret = 0;
 
     if (card->slot != 0) {
-        warn_report("usb-ccid supports one slot, can't add %d",
-                    card->slot);
-        return -1;
+        error_setg(errp, "usb-ccid supports one slot, can't add %d",
+                   card->slot);
+        return;
     }
     if (s->card != NULL) {
-        warn_report("usb-ccid card already full, not adding");
-        return -1;
+        error_setg(errp, "usb-ccid card already full, not adding");
+        return;
     }
-    ret = ccid_card_initfn(card);
-    if (ret == 0) {
-        s->card = card;
+    if (cc->parent_realize) {
+        cc->parent_realize(qdev, errp);
+        if (errp && *errp) {
+            return;
+        }
     }
-    return ret;
+    s->card = card;
 }
 
 static void ccid_realize(USBDevice *dev, Error **errp)
@@ -1477,8 +1460,8 @@ static void ccid_card_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *k = DEVICE_CLASS(klass);
     k->bus_type = TYPE_CCID_BUS;
-    k->init = ccid_card_init;
-    k->exit = ccid_card_exit;
+    k->realize = ccid_card_realize;
+    k->unrealize = ccid_card_unrealize;
     k->props = ccid_props;
 }
 
-- 
2.15.1
