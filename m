Received: from eggs.gnu.org ([2001:4830:134:3::10]:44687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dqbBW-0006kc-Ok
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 04:32:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dqbBT-0005xP-Ky
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 04:32:14 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:5806
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dqbBT-0005wI-96
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 04:32:11 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Sat, 9 Sep 2017 16:30:01 +0800
Message-ID: <20170909083001.17451-1-maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] usb/dev-smartcard-reader: convert to realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Convert CCID Device to realize and rename the ccid_card_init()
to ccid_card_realize().

Cc: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
---
 hw/usb/dev-smartcard-reader.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index bef1f03..27cd48d 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -1306,27 +1306,25 @@ static int ccid_card_exit(DeviceState *qdev)
     return 0;
 }
 
-static int ccid_card_init(DeviceState *qdev)
+static void ccid_card_realize(DeviceState *qdev, Error **errp)
 {
     CCIDCardState *card = CCID_CARD(qdev);
     USBDevice *dev = USB_DEVICE(qdev->parent_bus->parent);
     USBCCIDState *s = USB_CCID_DEV(dev);
-    int ret = 0;
 
     if (card->slot != 0) {
-        warn_report("usb-ccid supports one slot, can't add %d",
+        error_setg(errp, "usb-ccid supports one slot, can't add %d",
                     card->slot);
-        return -1;
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
+
+    if (!ccid_card_initfn(card)) {
         s->card = card;
     }
-    return ret;
 }
 
 static void ccid_realize(USBDevice *dev, Error **errp)
@@ -1496,7 +1494,7 @@ static void ccid_card_class_init(ObjectClass *klass, void *data)
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
