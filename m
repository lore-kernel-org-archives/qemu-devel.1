Received: from eggs.gnu.org ([2001:4830:134:3::10]:47263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaE3I-0000uo-ON
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 00:08:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaE3E-0004Zc-PS
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 00:08:20 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:42832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaE3E-0004ZE-Jx
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 00:08:16 -0500
Received: by mail-qt0-x242.google.com with SMTP id c2so8545984qtn.9
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 21:08:16 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 13 Jan 2018 02:07:16 -0300
Message-Id: <20180113050717.22969-14-f4bug@amsat.org>
In-Reply-To: <20180113050717.22969-1-f4bug@amsat.org>
References: <20180113050717.22969-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 13/14] sdhci: fix the PCI device,
 using the PCI address space for DMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Kevin O'Connor <kevin@koconnor.net>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>

While SysBus devices can use the get_system_memory() address space,
PCI devices should use the bus master address space for DMA.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Should we check for the PCI_COMMAND_MASTER bit before
using pci_get_address_space()?

 include/hw/sd/sdhci.h |  1 +
 hw/sd/sdhci.c         | 33 +++++++++++++++++++--------------
 2 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 442e30aff2..4a102b86ce 100644
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
index 226a22c5fb..024b559f14 100644
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
@@ -1314,7 +1312,8 @@ static void sdhci_pci_realize(PCIDevice *dev, Error **errp)
     dev->config[PCI_CLASS_PROG] = 0x01; /* Standard Host supported DMA */
     dev->config[PCI_INTERRUPT_PIN] = 0x01; /* interrupt pin A */
     s->irq = pci_allocate_irq(dev);
-    pci_register_bar(dev, 0, 0, &s->iomem);
+    s->dma_as = pci_get_address_space(dev);
+    pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->iomem);
 }
 
 static void sdhci_pci_exit(PCIDevice *dev)
@@ -1382,6 +1381,9 @@ static void sdhci_sysbus_realize(DeviceState *dev, Error ** errp)
         return;
     }
 
+    s->dma_as = g_new0(AddressSpace, 1);
+    address_space_init(s->dma_as, get_system_memory(), "sdhci-dma");
+
     sysbus_init_irq(sbd, &s->irq);
     sysbus_init_mmio(sbd, &s->iomem);
 }
@@ -1391,6 +1393,9 @@ static void sdhci_sysbus_unrealize(DeviceState *dev, Error **errp)
     SDHCIState *s = SYSBUS_SDHCI(dev);
 
     sdhci_common_unrealize(s, &error_abort);
+
+    address_space_destroy(s->dma_as);
+    g_free(s->dma_as);
 }
 
 static void sdhci_sysbus_class_init(ObjectClass *klass, void *data)
-- 
2.15.1
