Received: from eggs.gnu.org ([2001:4830:134:3::10]:60102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb9RS-0008KO-Lf
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:25:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb9RR-00034o-LN
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:25:06 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:36060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb9RR-00034b-Gl
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:25:05 -0500
Received: by mail-qt0-x243.google.com with SMTP id a16so15251761qtj.3
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 10:25:05 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 15 Jan 2018 15:24:27 -0300
Message-Id: <20180115182436.2066-6-f4bug@amsat.org>
In-Reply-To: <20180115182436.2066-1-f4bug@amsat.org>
References: <20180115182436.2066-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v8 05/14] sdhci: refactor common sysbus/pci
 realize() into sdhci_common_realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Kevin O'Connor <kevin@koconnor.net>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Marcel Apfelbaum <marcel@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/sd/sdhci.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 15d0961ac7..cf0c079990 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1214,6 +1214,15 @@ static void sdhci_uninitfn(SDHCIState *s)
     s->fifo_buffer = NULL;
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
 static bool sdhci_pending_insert_vmstate_needed(void *opaque)
 {
     SDHCIState *s = opaque;
@@ -1292,14 +1301,16 @@ static Property sdhci_pci_properties[] = {
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
 
@@ -1362,11 +1373,12 @@ static void sdhci_sysbus_realize(DeviceState *dev, Error ** errp)
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
