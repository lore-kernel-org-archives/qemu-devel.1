Received: from eggs.gnu.org ([2001:4830:134:3::10]:56696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e1fGv-0004Fv-Nj
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 17:07:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e1fGu-0006dd-9d
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 17:07:33 -0400
Received: from chuckie.co.uk ([82.165.15.123]:40564
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1e1fGu-0006d7-2X
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 17:07:32 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Mon,  9 Oct 2017 22:07:03 +0100
Message-Id: <1507583223-14819-9-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1507583223-14819-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1507583223-14819-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 8/8] sparc32_dma: remove is_ledma hack and
 replace with memory region alias
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com

This hack originated from before the memory region API was introduced, and
increased the size of the ledma DMA device to capture incorrect accesses
beyond the end of the ledma device. A full analysis can be found on Artyom's
blog at http://tyom.blogspot.co.uk/2010/10/bug-in-all-solaris-versions-after-57.html.

With the memory API we can now simply alias the incorrect access onto its
intended destination allowing us to remove the hack.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/dma/sparc32_dma.c           |   20 ++++++--------------
 include/hw/sparc/sparc32_dma.h |    2 +-
 2 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index c7aa4a4..a26bc50 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -160,12 +160,6 @@ static uint64_t dma_mem_read(void *opaque, hwaddr addr,
     DMADeviceState *s = opaque;
     uint32_t saddr;
 
-    if (s->is_ledma && (addr > DMA_MAX_REG_OFFSET)) {
-        /* aliased to espdma, but we can't get there from here */
-        /* buggy driver if using undocumented behavior, just return 0 */
-        trace_sparc32_dma_mem_readl(addr, 0);
-        return 0;
-    }
     saddr = (addr & DMA_MASK) >> 2;
     trace_sparc32_dma_mem_readl(addr, s->dmaregs[saddr]);
     return s->dmaregs[saddr];
@@ -177,11 +171,6 @@ static void dma_mem_write(void *opaque, hwaddr addr,
     DMADeviceState *s = opaque;
     uint32_t saddr;
 
-    if (s->is_ledma && (addr > DMA_MAX_REG_OFFSET)) {
-        /* aliased to espdma, but we can't get there from here */
-        trace_sparc32_dma_mem_writel(addr, 0, val);
-        return;
-    }
     saddr = (addr & DMA_MASK) >> 2;
     trace_sparc32_dma_mem_writel(addr, s->dmaregs[saddr], val);
     switch (saddr) {
@@ -296,7 +285,6 @@ static void sparc32_espdma_device_init(Object *obj)
 
     memory_region_init_io(&s->iomem, OBJECT(s), &dma_mem_ops, s,
                           "espdma", DMA_SIZE);
-    s->is_ledma = 0;
 }
 
 static const TypeInfo sparc32_espdma_device_info = {
@@ -311,8 +299,7 @@ static void sparc32_ledma_device_init(Object *obj)
     DMADeviceState *s = SPARC32_DMA_DEVICE(obj);
 
     memory_region_init_io(&s->iomem, OBJECT(s), &dma_mem_ops, s,
-                          "ledma", DMA_ETH_SIZE);
-    s->is_ledma = 1;
+                          "ledma", DMA_SIZE);
 }
 
 static const TypeInfo sparc32_ledma_device_info = {
@@ -359,6 +346,11 @@ static void sparc32_dma_realize(DeviceState *dev, Error **errp)
     sbd = SYS_BUS_DEVICE(d);
     memory_region_add_subregion(&s->dmamem, 0x10,
                                 sysbus_mmio_get_region(sbd, 0));
+
+    /* Add ledma alias to handle SunOS 5.7 - Solaris 9 invalid access bug */
+    memory_region_init_alias(&s->ledma_alias, OBJECT(dev), "ledma-alias",
+                             sysbus_mmio_get_region(sbd, 0), 0x4, 0x4);
+    memory_region_add_subregion(&s->dmamem, 0x20, &s->ledma_alias);
 }
 
 static void sparc32_dma_class_init(ObjectClass *klass, void *data)
diff --git a/include/hw/sparc/sparc32_dma.h b/include/hw/sparc/sparc32_dma.h
index 131d4de..67aa30c 100644
--- a/include/hw/sparc/sparc32_dma.h
+++ b/include/hw/sparc/sparc32_dma.h
@@ -19,7 +19,6 @@ struct DMADeviceState {
     qemu_irq irq;
     void *iommu;
     qemu_irq gpio[2];
-    uint32_t is_ledma;
 };
 
 #define TYPE_SPARC32_ESPDMA_DEVICE "sparc32-espdma"
@@ -46,6 +45,7 @@ typedef struct SPARC32DMAState {
     SysBusDevice parent_obj;
 
     MemoryRegion dmamem;
+    MemoryRegion ledma_alias;
     ESPDMADeviceState *espdma;
     LEDMADeviceState *ledma;
 } SPARC32DMAState;
-- 
1.7.10.4
