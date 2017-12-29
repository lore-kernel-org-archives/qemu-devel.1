Received: from eggs.gnu.org ([2001:4830:134:3::10]:56814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eUynI-0002t5-Pt
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 12:50:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eUynI-0005h4-1S
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 12:50:08 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:34528)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eUynH-0005gG-SB
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 12:50:07 -0500
Received: by mail-qt0-x242.google.com with SMTP id 33so54962921qtv.1
	for <qemu-devel@nongnu.org>; Fri, 29 Dec 2017 09:50:07 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 29 Dec 2017 14:48:57 -0300
Message-Id: <20171229174933.1781-7-f4bug@amsat.org>
In-Reply-To: <20171229174933.1781-1-f4bug@amsat.org>
References: <20171229174933.1781-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 06/42] sdhci: refactor common sysbus/pci
 realize() into sdhci_realizefn()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Xiaoqiang Zhao <zxq_yx_007@163.com>, Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/sd/sdhci.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 38d82b4c61..ad5853d527 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1194,6 +1194,15 @@ static void sdhci_initfn(SDHCIState *s)
     s->transfer_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sdhci_data_transfer, s);
 }
 
+static void sdhci_realizefn(SDHCIState *s, Error **errp)
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
@@ -1292,12 +1301,11 @@ static void sdhci_pci_realize(PCIDevice *dev, Error **errp)
     SDHCIState *s = PCI_SDHCI(dev);
     dev->config[PCI_CLASS_PROG] = 0x01; /* Standard Host supported DMA */
     dev->config[PCI_INTERRUPT_PIN] = 0x01; /* interrupt pin A */
+
     sdhci_initfn(s);
-    s->buf_maxsz = sdhci_get_fifolen(s);
-    s->fifo_buffer = g_malloc0(s->buf_maxsz);
+    sdhci_realizefn(s, errp);
+
     s->irq = pci_allocate_irq(dev);
-    memory_region_init_io(&s->iomem, OBJECT(s), &sdhci_mmio_ops, s, "sdhci",
-            SDHC_REGISTERS_MAP_SIZE);
     pci_register_bar(dev, 0, 0, &s->iomem);
 }
 
@@ -1351,11 +1359,9 @@ static void sdhci_sysbus_realize(DeviceState *dev, Error ** errp)
     SDHCIState *s = SYSBUS_SDHCI(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
-    s->buf_maxsz = sdhci_get_fifolen(s);
-    s->fifo_buffer = g_malloc0(s->buf_maxsz);
+    sdhci_realizefn(s, errp);
+
     sysbus_init_irq(sbd, &s->irq);
-    memory_region_init_io(&s->iomem, OBJECT(s), &sdhci_mmio_ops, s, "sdhci",
-            SDHC_REGISTERS_MAP_SIZE);
     sysbus_init_mmio(sbd, &s->iomem);
 }
 
-- 
2.15.1
