Received: from eggs.gnu.org ([209.51.188.92]:38026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ghlYr-0006R1-SL
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 20:24:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ghlYq-0000t7-2b
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 20:24:37 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:50518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1ghlYo-0000lE-Bb
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 20:24:35 -0500
Message-Id: <4b6cb2ae150dc0d21178209e4beb1e35140a7325.1547166960.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1547166960.git.balaton@eik.bme.hu>
References: <cover.1547166960.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Fri, 11 Jan 2019 01:36:00 +0100
Subject: [Qemu-devel] [PATCH 4/5] ide: Get rid of CMD646BAR struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Richard Henderson <rth@twiddle.net>

Now that no CMD646 specific parts are left in CMD646BAR (all remaining
members are really PCI IDE specific) this struct can be deleted moving
the memory regions for PCI IDE BARs to PCIIDEState where they better
belong. The CMD646 PCI IDE model is adjusted accordingly.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ide/cmd646.c      | 33 ++++++++++++++++-----------------
 include/hw/ide/pci.h | 10 ++--------
 2 files changed, 18 insertions(+), 25 deletions(-)

diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index 95f0df9742..5a5679134a 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -50,17 +50,6 @@
 
 static void cmd646_update_irq(PCIDevice *pd);
 
-static void setup_cmd646_bar(PCIIDEState *d, int bus_num)
-{
-    IDEBus *bus = &d->bus[bus_num];
-    CMD646BAR *bar = &d->cmd646_bar[bus_num];
-
-    memory_region_init_io(&bar->cmd, OBJECT(d), &pci_ide_cmd_le_ops, bus,
-                          "cmd646-cmd", 4);
-    memory_region_init_io(&bar->data, OBJECT(d), &pci_ide_data_le_ops, bus,
-                          "cmd646-data", 8);
-}
-
 static void cmd646_update_dma_interrupts(PCIDevice *pd)
 {
     /* Sync DMA interrupt status from UDMA interrupt status */
@@ -277,12 +266,22 @@ static void pci_cmd646_ide_realize(PCIDevice *dev, Error **errp)
     dev->wmask[MRDMODE] = 0x0;
     dev->w1cmask[MRDMODE] = MRDMODE_INTR_CH0 | MRDMODE_INTR_CH1;
 
-    setup_cmd646_bar(d, 0);
-    setup_cmd646_bar(d, 1);
-    pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &d->cmd646_bar[0].data);
-    pci_register_bar(dev, 1, PCI_BASE_ADDRESS_SPACE_IO, &d->cmd646_bar[0].cmd);
-    pci_register_bar(dev, 2, PCI_BASE_ADDRESS_SPACE_IO, &d->cmd646_bar[1].data);
-    pci_register_bar(dev, 3, PCI_BASE_ADDRESS_SPACE_IO, &d->cmd646_bar[1].cmd);
+    memory_region_init_io(&d->data_bar[0], OBJECT(d), &pci_ide_data_le_ops,
+                          &d->bus[0], "cmd646-data0", 8);
+    pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &d->data_bar[0]);
+
+    memory_region_init_io(&d->cmd_bar[0], OBJECT(d), &pci_ide_cmd_le_ops,
+                          &d->bus[0], "cmd646-cmd0", 4);
+    pci_register_bar(dev, 1, PCI_BASE_ADDRESS_SPACE_IO, &d->cmd_bar[0]);
+
+    memory_region_init_io(&d->data_bar[1], OBJECT(d), &pci_ide_data_le_ops,
+                          &d->bus[1], "cmd646-data1", 8);
+    pci_register_bar(dev, 2, PCI_BASE_ADDRESS_SPACE_IO, &d->data_bar[1]);
+
+    memory_region_init_io(&d->cmd_bar[1], OBJECT(d), &pci_ide_cmd_le_ops,
+                          &d->bus[1], "cmd646-cmd1", 4);
+    pci_register_bar(dev, 3, PCI_BASE_ADDRESS_SPACE_IO, &d->cmd_bar[1]);
+
     bmdma_setup_bar(d);
     pci_register_bar(dev, 4, PCI_BASE_ADDRESS_SPACE_IO, &d->bmdma_bar);
 
diff --git a/include/hw/ide/pci.h b/include/hw/ide/pci.h
index 3110633e4c..a9f2c33e68 100644
--- a/include/hw/ide/pci.h
+++ b/include/hw/ide/pci.h
@@ -37,11 +37,6 @@ typedef struct BMDMAState {
     struct PCIIDEState *pci_dev;
 } BMDMAState;
 
-typedef struct CMD646BAR {
-    MemoryRegion cmd;
-    MemoryRegion data;
-} CMD646BAR;
-
 #define TYPE_PCI_IDE "pci-ide"
 #define PCI_IDE(obj) OBJECT_CHECK(PCIIDEState, (obj), TYPE_PCI_IDE)
 
@@ -54,17 +49,16 @@ typedef struct PCIIDEState {
     BMDMAState bmdma[2];
     uint32_t secondary; /* used only for cmd646 */
     MemoryRegion bmdma_bar;
-    CMD646BAR cmd646_bar[2]; /* used only for cmd646 */
+    MemoryRegion cmd_bar[2];
+    MemoryRegion data_bar[2];
 } PCIIDEState;
 
-
 static inline IDEState *bmdma_active_if(BMDMAState *bmdma)
 {
     assert(bmdma->bus->retry_unit != (uint8_t)-1);
     return bmdma->bus->ifs + bmdma->bus->retry_unit;
 }
 
-
 void bmdma_init(IDEBus *bus, BMDMAState *bm, PCIIDEState *d);
 void bmdma_cmd_writeb(BMDMAState *bm, uint32_t val);
 extern MemoryRegionOps bmdma_addr_ioport_ops;
-- 
2.13.7
