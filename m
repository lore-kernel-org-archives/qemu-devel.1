Received: from eggs.gnu.org ([2001:4830:134:3::10]:40641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cHLqn-0000AB-6G
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 21:33:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cHLq2-0003ty-Ed
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 21:32:53 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36806)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1cHLq2-0003MP-80
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 21:32:06 -0500
Received: by mail-qt0-f193.google.com with SMTP id n34so5297136qtb.3
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 18:31:43 -0800 (PST)
Message-ID: <58520052.4825ed0a.27a71.6cae@mx.google.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 14 Dec 2016 18:30:21 -0800
Subject: [Qemu-devel] [PATCH v3] audio: ac97: add exit function
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

Currently the ac97 device emulation doesn't have a exit function,
hot unplug this device will leak some memory. Add a exit function to
avoid this.

Signed-off-by: Li Qiang <liqiang6-s@360.cn>
---

Changes since the v2:
take out of the null check

Changes since the v1:
close the streams

 hw/audio/ac97.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index cbd959e..c306575 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -1387,6 +1387,16 @@ static void ac97_realize(PCIDevice *dev, Error **errp)
     ac97_on_reset (&s->dev.qdev);
 }
 
+static void ac97_exit(PCIDevice *dev)
+{
+    AC97LinkState *s = DO_UPCAST(AC97LinkState, dev, dev);
+
+    AUD_close_in(&s->card, s->voice_pi);
+    AUD_close_out(&s->card, s->voice_po);
+    AUD_close_in(&s->card, s->voice_mc);
+    AUD_remove_card(&s->card);
+}
+
 static int ac97_init (PCIBus *bus)
 {
     pci_create_simple (bus, -1, "AC97");
@@ -1404,6 +1414,7 @@ static void ac97_class_init (ObjectClass *klass, void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS (klass);
 
     k->realize = ac97_realize;
+    k->exit = ac97_exit;
     k->vendor_id = PCI_VENDOR_ID_INTEL;
     k->device_id = PCI_DEVICE_ID_INTEL_82801AA_5;
     k->revision = 0x01;
-- 
1.8.3.1
