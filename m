Received: from eggs.gnu.org ([2001:4830:134:3::10]:60717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eel6q-0004b4-KQ
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 12:14:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eel6p-0004zy-Lc
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 12:14:44 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:33560)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eel6p-0004zq-Gw
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 12:14:43 -0500
Received: by mail-qt0-x242.google.com with SMTP id d8so21039874qtm.0
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 09:14:43 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 25 Jan 2018 14:14:31 -0300
Message-Id: <20180125171432.13554-3-f4bug@amsat.org>
In-Reply-To: <20180125171432.13554-1-f4bug@amsat.org>
References: <20180125171432.13554-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 2/3] usb-ccid: inline ccid_card_initfn() in
 ccid_card_realize()
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
 hw/usb/dev-smartcard-reader.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 0092493f4e..85f5f2247b 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -510,20 +510,6 @@ static void ccid_card_exitfn(CCIDCardState *card)
 
 }
 
-static void ccid_card_initfn(CCIDCardState *card, Error **errp)
-{
-    CCIDCardClass *cc = CCID_CARD_GET_CLASS(card);
-    Error *local_err = NULL;
-
-    if (cc->realize) {
-        cc->realize(card, &local_err);
-        if (local_err != NULL) {
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
     CCIDCardState *card = CCID_CARD(qdev);
+    CCIDCardClass *cc = CCID_CARD_GET_CLASS(card);
     USBDevice *dev = USB_DEVICE(qdev->parent_bus->parent);
     USBCCIDState *s = USB_CCID_DEV(dev);
     Error *local_err = NULL;
@@ -1315,10 +1302,12 @@ static void ccid_card_realize(DeviceState *qdev, Error **errp)
         error_setg(errp, "usb-ccid card already full, not adding");
         return;
     }
-    ccid_card_initfn(card, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
-        return;
+    if (cc->realize) {
+        cc->realize(card, &local_err);
+        if (local_err != NULL) {
+            error_propagate(errp, local_err);
+            return;
+        }
     }
     s->card = card;
 }
-- 
2.15.1
