Received: from eggs.gnu.org ([2001:4830:134:3::10]:47784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWnSq-0000OZ-7R
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:08:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWnSp-0006yW-4m
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:08:32 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:37327)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWnSp-0006yP-0F
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:08:31 -0500
Received: by mail-qk0-x244.google.com with SMTP id p13so2563669qke.4
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 10:08:31 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 15:07:54 -0300
Message-Id: <20180103180805.18140-7-f4bug@amsat.org>
In-Reply-To: <20180103180805.18140-1-f4bug@amsat.org>
References: <20180103180805.18140-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 06/17] sdhci: refactor common sysbus/pci
 realize() into sdhci_common_realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Since previous series failed, I dropped:

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

 hw/sd/sdhci.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 68bcf75478..b3dbd994fd 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1194,6 +1194,15 @@ static void sdhci_initfn(SDHCIState *s)
     s->transfer_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sdhci_data_transfer, s);
 }
 
+static void sdhci_common_realize(SDHCIState *s, Error **errp)
+{
+    s->buf_maxsz = sdhci_get_fifolen(s);
+    s->fifo_buffer = g_malloc0(s->buf_maxsz);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &sdhci_mmio_ops, s, "sdhci",
+                          SDHC_REGISTERS_MAP_SIZE);
+}
+
 static void sdhci_uninitfn(SDHCIState *s)
 {
     timer_del(s->insert_timer);
@@ -1290,14 +1299,16 @@ static void sdhci_common_class_init(ObjectClass *klass, void *data)
 static void sdhci_pci_realize(PCIDevice *dev, Error **errp)
 {
     SDHCIState *s = PCI_SDHCI(dev);
+
+    sdhci_initfn(s);
+    sdhci_common_realize(s, errp);
+    if (errp && *errp) {
+        return;
+    }
+
     dev->config[PCI_CLASS_PROG] = 0x01; /* Standard Host supported DMA */
     dev->config[PCI_INTERRUPT_PIN] = 0x01; /* interrupt pin A */
-    sdhci_initfn(s);
-    s->buf_maxsz = sdhci_get_fifolen(s);
-    s->fifo_buffer = g_malloc0(s->buf_maxsz);
     s->irq = pci_allocate_irq(dev);
-    memory_region_init_io(&s->iomem, OBJECT(s), &sdhci_mmio_ops, s, "sdhci",
-            SDHC_REGISTERS_MAP_SIZE);
     pci_register_bar(dev, 0, 0, &s->iomem);
 }
 
@@ -1351,11 +1362,12 @@ static void sdhci_sysbus_realize(DeviceState *dev, Error ** errp)
     SDHCIState *s = SYSBUS_SDHCI(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
-    s->buf_maxsz = sdhci_get_fifolen(s);
-    s->fifo_buffer = g_malloc0(s->buf_maxsz);
+    sdhci_common_realize(s, errp);
+    if (errp && *errp) {
+        return;
+    }
+
     sysbus_init_irq(sbd, &s->irq);
-    memory_region_init_io(&s->iomem, OBJECT(s), &sdhci_mmio_ops, s, "sdhci",
-            SDHC_REGISTERS_MAP_SIZE);
     sysbus_init_mmio(sbd, &s->iomem);
 }
 
-- 
2.15.1
