Received: from eggs.gnu.org ([2001:4830:134:3::10]:58769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cGzri-0005xO-0I
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 22:04:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cGzre-0008Cp-2F
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 22:04:22 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35830)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1cGzrd-0008Cl-U7
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 22:04:17 -0500
Received: by mail-oi0-f67.google.com with SMTP id v84so850749oie.2
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 19:04:17 -0800 (PST)
Message-ID: <5850b674.b53f9d0a.6452f.717a@mx.google.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 13 Dec 2016 19:03:09 -0800
Subject: [Qemu-devel] [PATCH v2] audio: es1370: add exit function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com, qemu-devel@nongnu.org, marcandre.lureau@gmail.com
Cc: Li Qiang <liqiang6-s@360.cn>

From: Li Qiang <liqiang6-s@360.cn>

Currently the es1370 device emulation doesn't have a exit function,
hot unplug this device will leak some memory. Add a exit function to
avoid this.

Signed-off-by: Li Qiang <liqiang6-s@360.cn>
---

Changes since the v1:
close the streams

 hw/audio/es1370.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index 8449b5f..8fc79fe 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -1041,6 +1041,24 @@ static void es1370_realize(PCIDevice *dev, Error **errp)
     es1370_reset (s);
 }
 
+static void es1370_exit(PCIDevice *dev)
+{
+    ES1370State *s = ES1370(dev);
+    int i;
+
+    if (s->adc_voice) {
+        AUD_close_in (&s->card, s->adc_voice);
+    }
+
+    for (i = 0; i < 2; ++i) {
+        if (s->dac_voice[i]) {
+            AUD_close_out (&s->card, s->dac_voice[i]);
+        }
+    }
+
+    AUD_remove_card(&s->card);
+}
+
 static int es1370_init (PCIBus *bus)
 {
     pci_create_simple (bus, -1, TYPE_ES1370);
@@ -1053,6 +1071,7 @@ static void es1370_class_init (ObjectClass *klass, void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS (klass);
 
     k->realize = es1370_realize;
+    k->exit = es1370_exit;
     k->vendor_id = PCI_VENDOR_ID_ENSONIQ;
     k->device_id = PCI_DEVICE_ID_ENSONIQ_ES1370;
     k->class_id = PCI_CLASS_MULTIMEDIA_AUDIO;
-- 
1.8.3.1
