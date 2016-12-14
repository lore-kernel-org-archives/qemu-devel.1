Received: from eggs.gnu.org ([2001:4830:134:3::10]:58841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cGzs3-0007KV-5o
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 22:04:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cGzrz-0008HX-8C
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 22:04:43 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33341)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1cGzrz-0008HB-1t
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 22:04:39 -0500
Received: by mail-oi0-f68.google.com with SMTP id f201so871853oib.0
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 19:04:38 -0800 (PST)
Message-ID: <5850b689.68219d0a.9be2d.9b07@mx.google.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 13 Dec 2016 19:03:32 -0800
Subject: [Qemu-devel] [PATCH v2] audio: ac97: add exit function
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

Currently the ac97 device emulation doesn't have a exit function,
hot unplug this device will leak some memory. Add a exit function to
avoid this.

Signed-off-by: Li Qiang <liqiang6-s@360.cn>
---

Changes since the v1:
close the streams

 hw/audio/ac97.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index cbd959e..efa20b5 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -1387,6 +1387,23 @@ static void ac97_realize(PCIDevice *dev, Error **errp)
     ac97_on_reset (&s->dev.qdev);
 }
 
+static void ac97_exit(PCIDevice *dev)
+{
+    AC97LinkState *s = DO_UPCAST(AC97LinkState, dev, dev);
+
+    if (s->voice_pi) {
+        AUD_close_in (&s->card, s->voice_pi);
+    }
+    if (s->voice_po) {
+        AUD_close_out (&s->card, s->voice_po);
+    }
+    if (s->voice_mc) {
+        AUD_close_in (&s->card, s->voice_mc);
+    }
+
+    AUD_remove_card (&s->card);
+}
+
 static int ac97_init (PCIBus *bus)
 {
     pci_create_simple (bus, -1, "AC97");
@@ -1404,6 +1421,7 @@ static void ac97_class_init (ObjectClass *klass, void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS (klass);
 
     k->realize = ac97_realize;
+    k->exit = ac97_exit;
     k->vendor_id = PCI_VENDOR_ID_INTEL;
     k->device_id = PCI_DEVICE_ID_INTEL_82801AA_5;
     k->revision = 0x01;
-- 
1.8.3.1
