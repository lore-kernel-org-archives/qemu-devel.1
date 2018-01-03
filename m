Received: from eggs.gnu.org ([2001:4830:134:3::10]:47977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWnTL-0000qA-RB
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:09:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWnTK-0007AS-Ez
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:09:03 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:42900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWnTK-0007AN-AJ
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:09:02 -0500
Received: by mail-qt0-x242.google.com with SMTP id g9so3109597qth.9
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 10:09:02 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 15:08:05 -0300
Message-Id: <20180103180805.18140-18-f4bug@amsat.org>
In-Reply-To: <20180103180805.18140-1-f4bug@amsat.org>
References: <20180103180805.18140-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 17/17] sdhci: add a "dma-memory" property
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

Add a dma property allowing machine creation to provide the address-space
sdhci dma operates on.

[based on a patch from Alistair Francis <alistair.francis@xilinx.com>
 from qemu/xilinx tag xilinx-v2016.1]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 include/hw/sd/sdhci.h |  2 ++
 hw/sd/sdhci.c         | 36 +++++++++++++++++++++++-------------
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 9436375b1e..2aea20f1d8 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -41,6 +41,8 @@ typedef struct SDHCIState {
     /*< public >*/
     SDBus sdbus;
     MemoryRegion iomem;
+    MemoryRegion *dma_mr;
+    AddressSpace dma_as;
 
     QEMUTimer *insert_timer;       /* timer for 'changing' sd card. */
     QEMUTimer *transfer_timer;
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 5ed4b472c6..b080950f80 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -501,7 +501,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
                     s->blkcnt--;
                 }
             }
-            dma_memory_write(&address_space_memory, s->sdmasysad,
+            dma_memory_write(&s->dma_as, s->sdmasysad,
                              &s->fifo_buffer[begin], s->data_count - begin);
             s->sdmasysad += s->data_count - begin;
             if (s->data_count == block_size) {
@@ -523,7 +523,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
                 s->data_count = block_size;
                 boundary_count -= block_size - begin;
             }
-            dma_memory_read(&address_space_memory, s->sdmasysad,
+            dma_memory_read(&s->dma_as, s->sdmasysad,
                             &s->fifo_buffer[begin], s->data_count - begin);
             s->sdmasysad += s->data_count - begin;
             if (s->data_count == block_size) {
@@ -561,11 +561,9 @@ static void sdhci_sdma_transfer_single_block(SDHCIState *s)
         for (n = 0; n < datacnt; n++) {
             s->fifo_buffer[n] = sdbus_read_data(&s->sdbus);
         }
-        dma_memory_write(&address_space_memory, s->sdmasysad, s->fifo_buffer,
-                         datacnt);
+        dma_memory_write(&s->dma_as, s->sdmasysad, s->fifo_buffer, datacnt);
     } else {
-        dma_memory_read(&address_space_memory, s->sdmasysad, s->fifo_buffer,
-                        datacnt);
+        dma_memory_read(&s->dma_as, s->sdmasysad, s->fifo_buffer, datacnt);
         for (n = 0; n < datacnt; n++) {
             sdbus_write_data(&s->sdbus, s->fifo_buffer[n]);
         }
@@ -589,7 +587,7 @@ static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
     hwaddr entry_addr = (hwaddr)s->admasysaddr;
     switch (SDHC_DMA_TYPE(s->hostctl)) {
     case SDHC_CTRL_ADMA2_32:
-        dma_memory_read(&address_space_memory, entry_addr, (uint8_t *)&adma2,
+        dma_memory_read(&s->dma_as, entry_addr, (uint8_t *)&adma2,
                         sizeof(adma2));
         adma2 = le64_to_cpu(adma2);
         /* The spec does not specify endianness of descriptor table.
@@ -601,7 +599,7 @@ static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
         dscr->incr = 8;
         break;
     case SDHC_CTRL_ADMA1_32:
-        dma_memory_read(&address_space_memory, entry_addr, (uint8_t *)&adma1,
+        dma_memory_read(&s->dma_as, entry_addr, (uint8_t *)&adma1,
                         sizeof(adma1));
         adma1 = le32_to_cpu(adma1);
         dscr->addr = (hwaddr)(adma1 & 0xFFFFF000);
@@ -614,12 +612,12 @@ static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
         }
         break;
     case SDHC_CTRL_ADMA2_64:
-        dma_memory_read(&address_space_memory, entry_addr,
+        dma_memory_read(&s->dma_as, entry_addr,
                         (uint8_t *)(&dscr->attr), 1);
-        dma_memory_read(&address_space_memory, entry_addr + 2,
+        dma_memory_read(&s->dma_as, entry_addr + 2,
                         (uint8_t *)(&dscr->length), 2);
         dscr->length = le16_to_cpu(dscr->length);
-        dma_memory_read(&address_space_memory, entry_addr + 4,
+        dma_memory_read(&s->dma_as, entry_addr + 4,
                         (uint8_t *)(&dscr->addr), 8);
         dscr->attr = le64_to_cpu(dscr->attr);
         dscr->attr &= 0xfffffff8;
@@ -678,7 +676,7 @@ static void sdhci_do_adma(SDHCIState *s)
                         s->data_count = block_size;
                         length -= block_size - begin;
                     }
-                    dma_memory_write(&address_space_memory, dscr.addr,
+                    dma_memory_write(&s->dma_as, dscr.addr,
                                      &s->fifo_buffer[begin],
                                      s->data_count - begin);
                     dscr.addr += s->data_count - begin;
@@ -702,7 +700,7 @@ static void sdhci_do_adma(SDHCIState *s)
                         s->data_count = block_size;
                         length -= block_size - begin;
                     }
-                    dma_memory_read(&address_space_memory, dscr.addr,
+                    dma_memory_read(&s->dma_as, dscr.addr,
                                     &s->fifo_buffer[begin],
                                     s->data_count - begin);
                     dscr.addr += s->data_count - begin;
@@ -1197,10 +1195,20 @@ static void sdhci_common_realize(SDHCIState *s, Error **errp)
 
     memory_region_init_io(&s->iomem, OBJECT(s), &sdhci_mmio_ops, s, "sdhci",
                           SDHC_REGISTERS_MAP_SIZE);
+
+    /* use system_memory() if property "dma-memory" not set */
+    address_space_init(&s->dma_as,
+                       s->dma_mr ? s->dma_mr : get_system_memory(),
+                       "sdhci-dma");
 }
 
 static void sdhci_common_unrealize(SDHCIState *s, Error **errp)
 {
+    if (s->dma_mr) {
+        address_space_destroy(&s->dma_as);
+        object_unparent(OBJECT(&s->dma_mr));
+    }
+
     /* This function is expected to be called only once for each class:
      * - SysBus:    via DeviceClass->unrealize(),
      * - PCI:       via PCIDeviceClass->exit().
@@ -1287,6 +1295,8 @@ static Property sdhci_properties[] = {
     DEFINE_PROP_UINT64("maxcurr", SDHCIState, maxcurr, 0),
     DEFINE_PROP_BOOL("pending-insert-quirk", SDHCIState, pending_insert_quirk,
                      false),
+    DEFINE_PROP_LINK("dma-memory", SDHCIState, dma_mr,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.15.1
