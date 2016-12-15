Received: from eggs.gnu.org ([2001:4830:134:3::10]:41203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cHLre-0002VL-L3
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 21:33:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cHLra-0004gZ-O6
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 21:33:46 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1cHLra-0004gL-JA
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 21:33:42 -0500
Received: by mail-oi0-f68.google.com with SMTP id m75so4818344oig.1
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 18:33:42 -0800 (PST)
Message-ID: <585200c9.a968ca0a.1ab80.4c98@mx.google.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 14 Dec 2016 18:32:22 -0800
Subject: [Qemu-devel] [PATCH v3] audio: es1370: add exit function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com, marcandre.lureau@gmail.com, qemu-devel@nongnu.org
Cc: Li Qiang <liqiang6-s@360.cn>

From: Li Qiang <liqiang6-s@360.cn>

Currently the es1370 device emulation doesn't have a exit function,
hot unplug this device will leak some memory. Add a exit function to
avoid this.

Signed-off-by: Li Qiang <liqiang6-s@360.cn>
---

Changes since the v2:
take out of the null check

Changes since the v1:
close the streams

 hw/audio/es1370.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index 8449b5f..883ec69 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -1041,6 +1041,19 @@ static void es1370_realize(PCIDevice *dev, Error **errp)
     es1370_reset (s);
 }
 
+static void es1370_exit(PCIDevice *dev)
+{
+    ES1370State *s = ES1370(dev);
+    int i;
+
+    for (i = 0; i < 2; ++i) {
+        AUD_close_out(&s->card, s->dac_voice[i]);
+    }
+
+    AUD_close_in(&s->card, s->adc_voice);
+    AUD_remove_card(&s->card);
+}
+
 static int es1370_init (PCIBus *bus)
 {
     pci_create_simple (bus, -1, TYPE_ES1370);
@@ -1053,6 +1066,7 @@ static void es1370_class_init (ObjectClass *klass, void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS (klass);
 
     k->realize = es1370_realize;
+    k->exit = es1370_exit;
     k->vendor_id = PCI_VENDOR_ID_ENSONIQ;
     k->device_id = PCI_DEVICE_ID_ENSONIQ_ES1370;
     k->class_id = PCI_CLASS_MULTIMEDIA_AUDIO;
-- 
1.8.3.1
