Received: from eggs.gnu.org ([209.51.188.92]:59772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gn9co-0005Ff-0U
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:06:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gn9cm-0006ba-8S
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:06:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gn9cl-0006a7-Te
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:06:56 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 25 Jan 2019 17:06:44 -0500
Message-Id: <20190125220648.28164-5-jsnow@redhat.com>
In-Reply-To: <20190125220648.28164-1-jsnow@redhat.com>
References: <20190125220648.28164-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 4/8] ide: Get rid of CMD646BAR struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jsnow@redhat.com, BALATON Zoltan <balaton@eik.bme.hu>

From: BALATON Zoltan <balaton@eik.bme.hu>

Now that no CMD646 specific parts are left in CMD646BAR (all remaining
members are really PCI IDE specific) this struct can be deleted moving
the memory regions for PCI IDE BARs to PCIIDEState where they better
belong. The CMD646 PCI IDE model is adjusted accordingly.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 4b6cb2ae150dc0d21178209e4beb1e35140a7325.1547166960.git.balaton@eik.bme.hu
Signed-off-by: John Snow <jsnow@redhat.com>
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
2.17.2
