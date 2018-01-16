Received: from eggs.gnu.org ([2001:4830:134:3::10]:37530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRO6-0008P5-Qh
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRO0-0002w3-RM
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:50 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ebRO0-0002u6-JG
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:44 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRNz-0002zP-Fd
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 13:34:43 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2018 13:34:18 +0000
Message-Id: <1516109659-1557-24-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1516109659-1557-1-git-send-email-peter.maydell@linaro.org>
References: <1516109659-1557-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 23/24] sdhci: fix the PCI device,
 using the PCI address space for DMA
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

While SysBus devices can use the get_system_memory() address space,
PCI devices should use the bus master address space for DMA.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20180115182436.2066-14-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/sd/sdhci.h |  1 +
 hw/sd/sdhci.c         | 29 +++++++++++++++--------------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 442e30a..4a102b8 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -41,6 +41,7 @@ typedef struct SDHCIState {
     /*< public >*/
     SDBus sdbus;
     MemoryRegion iomem;
+    AddressSpace *dma_as;
 
     QEMUTimer *insert_timer;       /* timer for 'changing' sd card. */
     QEMUTimer *transfer_timer;
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 9bdbcd0..dd40069 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -496,7 +496,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
                     s->blkcnt--;
                 }
             }
-            dma_memory_write(&address_space_memory, s->sdmasysad,
+            dma_memory_write(s->dma_as, s->sdmasysad,
                              &s->fifo_buffer[begin], s->data_count - begin);
             s->sdmasysad += s->data_count - begin;
             if (s->data_count == block_size) {
@@ -518,7 +518,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
                 s->data_count = block_size;
                 boundary_count -= block_size - begin;
             }
-            dma_memory_read(&address_space_memory, s->sdmasysad,
+            dma_memory_read(s->dma_as, s->sdmasysad,
                             &s->fifo_buffer[begin], s->data_count - begin);
             s->sdmasysad += s->data_count - begin;
             if (s->data_count == block_size) {
@@ -556,11 +556,9 @@ static void sdhci_sdma_transfer_single_block(SDHCIState *s)
         for (n = 0; n < datacnt; n++) {
             s->fifo_buffer[n] = sdbus_read_data(&s->sdbus);
         }
-        dma_memory_write(&address_space_memory, s->sdmasysad, s->fifo_buffer,
-                         datacnt);
+        dma_memory_write(s->dma_as, s->sdmasysad, s->fifo_buffer, datacnt);
     } else {
-        dma_memory_read(&address_space_memory, s->sdmasysad, s->fifo_buffer,
-                        datacnt);
+        dma_memory_read(s->dma_as, s->sdmasysad, s->fifo_buffer, datacnt);
         for (n = 0; n < datacnt; n++) {
             sdbus_write_data(&s->sdbus, s->fifo_buffer[n]);
         }
@@ -584,7 +582,7 @@ static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
     hwaddr entry_addr = (hwaddr)s->admasysaddr;
     switch (SDHC_DMA_TYPE(s->hostctl)) {
     case SDHC_CTRL_ADMA2_32:
-        dma_memory_read(&address_space_memory, entry_addr, (uint8_t *)&adma2,
+        dma_memory_read(s->dma_as, entry_addr, (uint8_t *)&adma2,
                         sizeof(adma2));
         adma2 = le64_to_cpu(adma2);
         /* The spec does not specify endianness of descriptor table.
@@ -596,7 +594,7 @@ static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
         dscr->incr = 8;
         break;
     case SDHC_CTRL_ADMA1_32:
-        dma_memory_read(&address_space_memory, entry_addr, (uint8_t *)&adma1,
+        dma_memory_read(s->dma_as, entry_addr, (uint8_t *)&adma1,
                         sizeof(adma1));
         adma1 = le32_to_cpu(adma1);
         dscr->addr = (hwaddr)(adma1 & 0xFFFFF000);
@@ -609,12 +607,12 @@ static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
         }
         break;
     case SDHC_CTRL_ADMA2_64:
-        dma_memory_read(&address_space_memory, entry_addr,
+        dma_memory_read(s->dma_as, entry_addr,
                         (uint8_t *)(&dscr->attr), 1);
-        dma_memory_read(&address_space_memory, entry_addr + 2,
+        dma_memory_read(s->dma_as, entry_addr + 2,
                         (uint8_t *)(&dscr->length), 2);
         dscr->length = le16_to_cpu(dscr->length);
-        dma_memory_read(&address_space_memory, entry_addr + 4,
+        dma_memory_read(s->dma_as, entry_addr + 4,
                         (uint8_t *)(&dscr->addr), 8);
         dscr->attr = le64_to_cpu(dscr->attr);
         dscr->attr &= 0xfffffff8;
@@ -673,7 +671,7 @@ static void sdhci_do_adma(SDHCIState *s)
                         s->data_count = block_size;
                         length -= block_size - begin;
                     }
-                    dma_memory_write(&address_space_memory, dscr.addr,
+                    dma_memory_write(s->dma_as, dscr.addr,
                                      &s->fifo_buffer[begin],
                                      s->data_count - begin);
                     dscr.addr += s->data_count - begin;
@@ -697,7 +695,7 @@ static void sdhci_do_adma(SDHCIState *s)
                         s->data_count = block_size;
                         length -= block_size - begin;
                     }
-                    dma_memory_read(&address_space_memory, dscr.addr,
+                    dma_memory_read(s->dma_as, dscr.addr,
                                     &s->fifo_buffer[begin],
                                     s->data_count - begin);
                     dscr.addr += s->data_count - begin;
@@ -1312,7 +1310,8 @@ static void sdhci_pci_realize(PCIDevice *dev, Error **errp)
     dev->config[PCI_CLASS_PROG] = 0x01; /* Standard Host supported DMA */
     dev->config[PCI_INTERRUPT_PIN] = 0x01; /* interrupt pin A */
     s->irq = pci_allocate_irq(dev);
-    pci_register_bar(dev, 0, 0, &s->iomem);
+    s->dma_as = pci_get_address_space(dev);
+    pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->iomem);
 }
 
 static void sdhci_pci_exit(PCIDevice *dev)
@@ -1381,6 +1380,8 @@ static void sdhci_sysbus_realize(DeviceState *dev, Error ** errp)
         return;
     }
 
+    s->dma_as = &address_space_memory;
+
     sysbus_init_irq(sbd, &s->irq);
     sysbus_init_mmio(sbd, &s->iomem);
 }
-- 
2.7.4
