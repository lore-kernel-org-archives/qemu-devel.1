Received: from eggs.gnu.org ([2001:4830:134:3::10]:43064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRCM-0000pz-5D
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:23:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRCL-0008ID-0h
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:23:54 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gCRCK-0007xg-LK
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:23:52 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRC9-0003or-FO
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 16:23:41 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Oct 2018 16:23:17 +0100
Message-Id: <20181016152325.31367-12-peter.maydell@linaro.org>
In-Reply-To: <20181016152325.31367-1-peter.maydell@linaro.org>
References: <20181016152325.31367-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/19] net: cadence_gem: Add support for
 selecting the DMA MemoryRegion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Add support for selecting the Memory Region that the GEM
will do DMA to.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20181011021931.4249-7-edgar.iglesias@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/net/cadence_gem.h |  2 ++
 hw/net/cadence_gem.c         | 59 ++++++++++++++++++++++--------------
 2 files changed, 39 insertions(+), 22 deletions(-)

diff --git a/include/hw/net/cadence_gem.h b/include/hw/net/cadence_gem.h
index 00dbf4f72e3..5426961d91b 100644
--- a/include/hw/net/cadence_gem.h
+++ b/include/hw/net/cadence_gem.h
@@ -45,6 +45,8 @@ typedef struct CadenceGEMState {
 
     /*< public >*/
     MemoryRegion iomem;
+    MemoryRegion *dma_mr;
+    AddressSpace dma_as;
     NICState *nic;
     NICConf conf;
     qemu_irq irq[MAX_PRIORITY_QUEUES];
diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 759c1d71e02..a40f1362850 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -28,6 +28,7 @@
 #include "hw/net/cadence_gem.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
+#include "sysemu/dma.h"
 #include "net/checksum.h"
 
 #ifdef CADENCE_GEM_ERR_DEBUG
@@ -835,9 +836,9 @@ static void gem_get_rx_desc(CadenceGEMState *s, int q)
 {
     DB_PRINT("read descriptor 0x%x\n", (unsigned)s->rx_desc_addr[q]);
     /* read current descriptor */
-    cpu_physical_memory_read(s->rx_desc_addr[q],
-                             (uint8_t *)s->rx_desc[q],
-                             sizeof(uint32_t) * gem_get_desc_len(s, true));
+    address_space_read(&s->dma_as, s->rx_desc_addr[q], MEMTXATTRS_UNSPECIFIED,
+                       (uint8_t *)s->rx_desc[q],
+                       sizeof(uint32_t) * gem_get_desc_len(s, true));
 
     /* Descriptor owned by software ? */
     if (rx_desc_get_ownership(s->rx_desc[q]) == 1) {
@@ -956,10 +957,10 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
                 rx_desc_get_buffer(s->rx_desc[q]));
 
         /* Copy packet data to emulated DMA buffer */
-        cpu_physical_memory_write(rx_desc_get_buffer(s, s->rx_desc[q]) +
+        address_space_write(&s->dma_as, rx_desc_get_buffer(s, s->rx_desc[q]) +
                                                                   rxbuf_offset,
-                                  rxbuf_ptr,
-                                  MIN(bytes_to_copy, rxbufsize));
+                            MEMTXATTRS_UNSPECIFIED, rxbuf_ptr,
+                            MIN(bytes_to_copy, rxbufsize));
         rxbuf_ptr += MIN(bytes_to_copy, rxbufsize);
         bytes_to_copy -= MIN(bytes_to_copy, rxbufsize);
 
@@ -993,9 +994,10 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
         }
 
         /* Descriptor write-back.  */
-        cpu_physical_memory_write(s->rx_desc_addr[q],
-                                  (uint8_t *)s->rx_desc[q],
-                                  sizeof(uint32_t) * gem_get_desc_len(s, true));
+        address_space_write(&s->dma_as, s->rx_desc_addr[q],
+                            MEMTXATTRS_UNSPECIFIED,
+                            (uint8_t *)s->rx_desc[q],
+                            sizeof(uint32_t) * gem_get_desc_len(s, true));
 
         /* Next descriptor */
         if (rx_desc_get_wrap(s->rx_desc[q])) {
@@ -1099,9 +1101,9 @@ static void gem_transmit(CadenceGEMState *s)
         packet_desc_addr = s->tx_desc_addr[q];
 
         DB_PRINT("read descriptor 0x%" HWADDR_PRIx "\n", packet_desc_addr);
-        cpu_physical_memory_read(packet_desc_addr,
-                                 (uint8_t *)desc,
-                                 sizeof(uint32_t) * gem_get_desc_len(s, false));
+        address_space_read(&s->dma_as, packet_desc_addr,
+                           MEMTXATTRS_UNSPECIFIED, (uint8_t *)desc,
+                           sizeof(uint32_t) * gem_get_desc_len(s, false));
         /* Handle all descriptors owned by hardware */
         while (tx_desc_get_used(desc) == 0) {
 
@@ -1133,8 +1135,9 @@ static void gem_transmit(CadenceGEMState *s)
             /* Gather this fragment of the packet from "dma memory" to our
              * contig buffer.
              */
-            cpu_physical_memory_read(tx_desc_get_buffer(s, desc), p,
-                                     tx_desc_get_length(desc));
+            address_space_read(&s->dma_as, tx_desc_get_buffer(s, desc),
+                               MEMTXATTRS_UNSPECIFIED,
+                               p, tx_desc_get_length(desc));
             p += tx_desc_get_length(desc);
             total_bytes += tx_desc_get_length(desc);
 
@@ -1145,13 +1148,15 @@ static void gem_transmit(CadenceGEMState *s)
                 /* Modify the 1st descriptor of this packet to be owned by
                  * the processor.
                  */
-                cpu_physical_memory_read(s->tx_desc_addr[q],
-                                         (uint8_t *)desc_first,
-                                         sizeof(desc_first));
+                address_space_read(&s->dma_as, s->tx_desc_addr[q],
+                                   MEMTXATTRS_UNSPECIFIED,
+                                   (uint8_t *)desc_first,
+                                   sizeof(desc_first));
                 tx_desc_set_used(desc_first);
-                cpu_physical_memory_write(s->tx_desc_addr[q],
-                                          (uint8_t *)desc_first,
-                                          sizeof(desc_first));
+                address_space_write(&s->dma_as, s->tx_desc_addr[q],
+                                  MEMTXATTRS_UNSPECIFIED,
+                                  (uint8_t *)desc_first,
+                                   sizeof(desc_first));
                 /* Advance the hardware current descriptor past this packet */
                 if (tx_desc_get_wrap(desc)) {
                     s->tx_desc_addr[q] = s->regs[GEM_TXQBASE];
@@ -1204,8 +1209,9 @@ static void gem_transmit(CadenceGEMState *s)
                 packet_desc_addr += 4 * gem_get_desc_len(s, false);
             }
             DB_PRINT("read descriptor 0x%" HWADDR_PRIx "\n", packet_desc_addr);
-            cpu_physical_memory_read(packet_desc_addr, (uint8_t *)desc,
-                                sizeof(uint32_t) * gem_get_desc_len(s, false));
+            address_space_read(&s->dma_as, packet_desc_addr,
+                              MEMTXATTRS_UNSPECIFIED, (uint8_t *)desc,
+                              sizeof(uint32_t) * gem_get_desc_len(s, false));
         }
 
         if (tx_desc_get_used(desc)) {
@@ -1500,6 +1506,9 @@ static void gem_realize(DeviceState *dev, Error **errp)
     CadenceGEMState *s = CADENCE_GEM(dev);
     int i;
 
+    address_space_init(&s->dma_as,
+                       s->dma_mr ? s->dma_mr : get_system_memory(), "dma");
+
     if (s->num_priority_queues == 0 ||
         s->num_priority_queues > MAX_PRIORITY_QUEUES) {
         error_setg(errp, "Invalid num-priority-queues value: %" PRIx8,
@@ -1537,6 +1546,12 @@ static void gem_init(Object *obj)
                           "enet", sizeof(s->regs));
 
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
+
+    object_property_add_link(obj, "dma", TYPE_MEMORY_REGION,
+                             (Object **)&s->dma_mr,
+                             qdev_prop_allow_set_link_before_realize,
+                             OBJ_PROP_LINK_STRONG,
+                             &error_abort);
 }
 
 static const VMStateDescription vmstate_cadence_gem = {
-- 
2.19.0
