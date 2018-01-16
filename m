Received: from eggs.gnu.org ([2001:4830:134:3::10]:37468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRO0-0008H2-3o
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRNu-0002qX-7i
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:44 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ebRNu-0002ll-1l
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:38 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRNt-0002vJ-2A
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 13:34:37 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2018 13:34:10 +0000
Message-Id: <1516109659-1557-16-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1516109659-1557-1-git-send-email-peter.maydell@linaro.org>
References: <1516109659-1557-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 15/24] sdhci: refactor common sysbus/pci
 realize() into sdhci_common_realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Message-id: 20180115182436.2066-6-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sdhci.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 15d0961..cf0c079 100644
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
2.7.4
