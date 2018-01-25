Received: from eggs.gnu.org ([2001:4830:134:3::10]:60741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eel6s-0004d2-TO
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 12:14:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eel6r-000514-Td
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 12:14:46 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:41916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eel6r-00050o-PP
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 12:14:45 -0500
Received: by mail-qt0-x242.google.com with SMTP id i1so21012584qtj.8
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 09:14:45 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 25 Jan 2018 14:14:32 -0300
Message-Id: <20180125171432.13554-4-f4bug@amsat.org>
In-Reply-To: <20180125171432.13554-1-f4bug@amsat.org>
References: <20180125171432.13554-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 3/3] usb-ccid: convert
 CCIDCardClass::exitfn() -> unrealize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
 
 /*
diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
index daefd9f8f4..ea42e4681d 100644
--- a/hw/usb/ccid-card-emulated.c
+++ b/hw/usb/ccid-card-emulated.c
@@ -547,7 +547,7 @@ static void emulated_realize(CCIDCardState *base, Error **errp)
                        card, QEMU_THREAD_JOINABLE);
 }
 
-static void emulated_exitfn(CCIDCardState *base)
+static void emulated_unrealize(CCIDCardState *base, Error **errp)
 {
     EmulatedState *card = EMULATED_CCID_CARD(base);
     VEvent *vevent = vevent_new(VEVENT_LAST, NULL, NULL);
@@ -582,7 +582,7 @@ static void emulated_class_initfn(ObjectClass *klass, void *data)
     CCIDCardClass *cc = CCID_CARD_CLASS(klass);
 
     cc->realize = emulated_realize;
-    cc->exitfn = emulated_exitfn;
+    cc->unrealize = emulated_unrealize;
     cc->get_atr = emulated_get_atr;
     cc->apdu_from_guest = emulated_apdu_from_guest;
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index b7dd3602dc..085ed2c667 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -9,6 +9,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include <cacard/vscard_common.h>
 #include "chardev/char-fe.h"
 #include "qemu/error-report.h"
diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 85f5f2247b..e6468057a0 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -500,16 +500,6 @@ static void ccid_card_apdu_from_guest(CCIDCardState *card,
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
 static bool ccid_has_pending_answers(USBCCIDState *s)
 {
     return s->pending_answers_num > 0;
@@ -1271,18 +1261,25 @@ void ccid_card_card_inserted(CCIDCardState *card)
     ccid_on_slot_change(s, true);
 }
 
-static int ccid_card_exit(DeviceState *qdev)
+static void ccid_card_unrealize(DeviceState *qdev, Error **errp)
 {
     CCIDCardState *card = CCID_CARD(qdev);
+    CCIDCardClass *cc = CCID_CARD_GET_CLASS(card);
     USBDevice *dev = USB_DEVICE(qdev->parent_bus->parent);
     USBCCIDState *s = USB_CCID_DEV(dev);
+    Error *local_err = NULL;
 
     if (ccid_card_inserted(s)) {
         ccid_card_card_removed(card);
     }
-    ccid_card_exitfn(card);
+    if (cc->unrealize) {
+        cc->unrealize(card, &local_err);
+        if (local_err != NULL) {
+            error_propagate(errp, local_err);
+            return;
+        }
+    }
     s->card = NULL;
-    return 0;
 }
 
 static void ccid_card_realize(DeviceState *qdev, Error **errp)
@@ -1472,7 +1469,7 @@ static void ccid_card_class_init(ObjectClass *klass, void *data)
     DeviceClass *k = DEVICE_CLASS(klass);
     k->bus_type = TYPE_CCID_BUS;
     k->realize = ccid_card_realize;
-    k->exit = ccid_card_exit;
+    k->unrealize = ccid_card_unrealize;
     k->props = ccid_props;
 }
 
-- 
2.15.1
