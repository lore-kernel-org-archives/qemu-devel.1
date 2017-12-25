Received: from eggs.gnu.org ([2001:4830:134:3::10]:50976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eTMZS-0001YF-HS
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 01:49:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eTMZN-00037T-VE
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 01:49:10 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:60319
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eTMZN-00034i-2M
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 01:49:05 -0500
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Mon, 25 Dec 2017 14:44:05 +0800
Message-ID: <7221483436734a75f3919fb6caf7b4a79a7465b9.1514183911.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2] hw/usb/ccid: Make ccid_card_init() take an
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Cao jin <caoj.fnst@cn.fujitsu.com>

Replace init() of CCIDCardClass with realize, then convert
ccid_card_init(), ccid_card_initfn() and it's callbacks to
take an Error** in ordor to report the error more clearly.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@gmail.com>
Cc: Cao jin <caoj.fnst@cn.fujitsu.com>

Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
 hw/usb/ccid-card-emulated.c   | 43 +++++++++++++++++++++----------------------
 hw/usb/ccid-card-passthru.c   | 11 +++++------
 hw/usb/ccid.h                 |  2 +-
 hw/usb/dev-smartcard-reader.c | 34 +++++++++++++++++++---------------
 4 files changed, 46 insertions(+), 44 deletions(-)

diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
index e646eb2..48f26f9 100644
--- a/hw/usb/ccid-card-emulated.c
+++ b/hw/usb/ccid-card-emulated.c
@@ -401,10 +401,10 @@ static void card_event_handler(EventNotifier *notifier)
     qemu_mutex_unlock(&card->event_list_mutex);
 }
 
-static int init_event_notifier(EmulatedState *card)
+static int init_event_notifier(EmulatedState *card, Error **errp)
 {
     if (event_notifier_init(&card->notifier, false) < 0) {
-        DPRINTF(card, 2, "event notifier creation failed\n");
+        error_setg(errp, "ccid-card-emul: event notifier creation failed");
         return -1;
     }
     event_notifier_set_handler(&card->notifier, card_event_handler);
@@ -480,7 +480,7 @@ static uint32_t parse_enumeration(char *str,
     return ret;
 }
 
-static int emulated_initfn(CCIDCardState *base)
+static void emulated_realize(CCIDCardState *base, Error **errp)
 {
     EmulatedState *card = EMULATED_CCID_CARD(base);
     VCardEmulError ret;
@@ -494,8 +494,8 @@ static int emulated_initfn(CCIDCardState *base)
     qemu_cond_init(&card->handle_apdu_cond);
     card->reader = NULL;
     card->quit_apdu_thread = 0;
-    if (init_event_notifier(card) < 0) {
-        return -1;
+    if (init_event_notifier(card, errp) < 0) {
+        return;
     }
 
     card->backend = 0;
@@ -505,11 +505,11 @@ static int emulated_initfn(CCIDCardState *base)
     }
 
     if (card->backend == 0) {
-        printf("backend must be one of:\n");
+        error_setg(errp, "backend must be one of:");
         for (ptable = backend_enum_table; ptable->name != NULL; ++ptable) {
-            printf("%s\n", ptable->name);
+            error_append_hint(errp, "%s\n", ptable->name);
         }
-        return -1;
+        return;
     }
 
     /* TODO: a passthru backened that works on local machine. third card type?*/
@@ -517,34 +517,33 @@ static int emulated_initfn(CCIDCardState *base)
         if (card->cert1 != NULL && card->cert2 != NULL && card->cert3 != NULL) {
             ret = emulated_initialize_vcard_from_certificates(card);
         } else {
-            printf("%s: you must provide all three certs for"
-                   " certificates backend\n", TYPE_EMULATED_CCID);
-            return -1;
+            error_setg(errp, "%s: you must provide all three certs for"
+                       " certificates backend", TYPE_EMULATED_CCID);
+            return;
         }
     } else {
         if (card->backend != BACKEND_NSS_EMULATED) {
-            printf("%s: bad backend specified. The options are:\n%s (default),"
-                " %s.\n", TYPE_EMULATED_CCID, BACKEND_NSS_EMULATED_NAME,
-                BACKEND_CERTIFICATES_NAME);
-            return -1;
+            error_setg(errp, "%s: bad backend specified. The options are:%s"
+                       " (default), %s.", TYPE_EMULATED_CCID,
+                       BACKEND_NSS_EMULATED_NAME, BACKEND_CERTIFICATES_NAME);
+            return;
         }
         if (card->cert1 != NULL || card->cert2 != NULL || card->cert3 != NULL) {
-            printf("%s: unexpected cert parameters to nss emulated backend\n",
-                   TYPE_EMULATED_CCID);
-            return -1;
+            error_setg(errp, "%s: unexpected cert parameters to nss emulated "
+                       "backend", TYPE_EMULATED_CCID);
+            return;
         }
         /* default to mirroring the local hardware readers */
         ret = wrap_vcard_emul_init(NULL);
     }
     if (ret != VCARD_EMUL_OK) {
-        printf("%s: failed to initialize vcard\n", TYPE_EMULATED_CCID);
-        return -1;
+        error_setg(errp, "%s: failed to initialize vcard", TYPE_EMULATED_CCID);
+        return;
     }
     qemu_thread_create(&card->event_thread_id, "ccid/event", event_thread,
                        card, QEMU_THREAD_JOINABLE);
     qemu_thread_create(&card->apdu_thread_id, "ccid/apdu", handle_apdu_thread,
                        card, QEMU_THREAD_JOINABLE);
-    return 0;
 }
 
 static void emulated_exitfn(CCIDCardState *base)
@@ -581,7 +580,7 @@ static void emulated_class_initfn(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     CCIDCardClass *cc = CCID_CARD_CLASS(klass);
 
-    cc->initfn = emulated_initfn;
+    cc->realize = emulated_realize;
     cc->exitfn = emulated_exitfn;
     cc->get_atr = emulated_get_atr;
     cc->apdu_from_guest = emulated_apdu_from_guest;
diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index 1177118..4ce87f8 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -337,29 +337,28 @@ static const uint8_t *passthru_get_atr(CCIDCardState *base, uint32_t *len)
     return card->atr;
 }
 
-static int passthru_initfn(CCIDCardState *base)
+static void passthru_realize(CCIDCardState *base, Error **errp)
 {
     PassthruState *card = PASSTHRU_CCID_CARD(base);
 
     card->vscard_in_pos = 0;
     card->vscard_in_hdr = 0;
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
     card->debug = parse_debug_env("QEMU_CCID_PASSTHRU_DEBUG", D_VERBOSE,
                                   card->debug);
     assert(sizeof(DEFAULT_ATR) <= MAX_ATR_SIZE);
     memcpy(card->atr, DEFAULT_ATR, sizeof(DEFAULT_ATR));
     card->atr_length = sizeof(DEFAULT_ATR);
-    return 0;
 }
 
 static VMStateDescription passthru_vmstate = {
@@ -387,7 +386,7 @@ static void passthru_class_initfn(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     CCIDCardClass *cc = CCID_CARD_CLASS(klass);
 
-    cc->initfn = passthru_initfn;
+    cc->realize = passthru_realize;
     cc->get_atr = passthru_get_atr;
     cc->apdu_from_guest = passthru_apdu_from_guest;
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
diff --git a/hw/usb/ccid.h b/hw/usb/ccid.h
index 1f07011..6c6c101 100644
--- a/hw/usb/ccid.h
+++ b/hw/usb/ccid.h
@@ -34,7 +34,7 @@ typedef struct CCIDCardClass {
                             const uint8_t *apdu,
                             uint32_t len);
     void (*exitfn)(CCIDCardState *card);
-    int (*initfn)(CCIDCardState *card);
+    void (*realize)(CCIDCardState *card, Error **errp);
 } CCIDCardClass;
 
 /*
diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index e334d3b..43c564f 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -510,14 +510,18 @@ static void ccid_card_exitfn(CCIDCardState *card)
 
 }
 
-static int ccid_card_initfn(CCIDCardState *card)
+static void ccid_card_initfn(CCIDCardState *card, Error **errp)
 {
     CCIDCardClass *cc = CCID_CARD_GET_CLASS(card);
+    Error *local_err = NULL;
 
-    if (cc->initfn) {
-        return cc->initfn(card);
+    if (cc->realize) {
+        cc->realize(card, &local_err);
+        if (local_err != NULL) {
+            error_propagate(errp, local_err);
+            return;
+        }
     }
-    return 0;
 }
 
 static bool ccid_has_pending_answers(USBCCIDState *s)
@@ -1295,27 +1299,27 @@ static int ccid_card_exit(DeviceState *qdev)
     return 0;
 }
 
-static int ccid_card_init(DeviceState *qdev)
+static void ccid_card_realize(DeviceState *qdev, Error **errp)
 {
     CCIDCardState *card = CCID_CARD(qdev);
     USBDevice *dev = USB_DEVICE(qdev->parent_bus->parent);
     USBCCIDState *s = USB_CCID_DEV(dev);
-    int ret = 0;
+    Error *local_err = NULL;
 
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
+    ccid_card_initfn(card, &local_err);
+    if (local_err != NULL) {
+        error_propagate(errp, local_err);
         s->card = card;
     }
-    return ret;
 }
 
 static void ccid_realize(USBDevice *dev, Error **errp)
@@ -1477,7 +1481,7 @@ static void ccid_card_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *k = DEVICE_CLASS(klass);
     k->bus_type = TYPE_CCID_BUS;
-    k->init = ccid_card_init;
+    k->realize = ccid_card_realize;
     k->exit = ccid_card_exit;
     k->props = ccid_props;
 }
-- 
2.9.4
