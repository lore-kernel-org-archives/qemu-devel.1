Received: from eggs.gnu.org ([2001:4830:134:3::10]:53256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e3QxP-0005EW-P8
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 14:14:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e3QxO-0004og-SL
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 14:14:43 -0400
Received: from chuckie.co.uk ([82.165.15.123]:36853
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1e3QxO-0004oN-Le
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 14:14:42 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sat, 14 Oct 2017 19:09:05 +0100
Message-Id: <1508004545-28578-14-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1508004545-28578-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1508004545-28578-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv2 13/13] sparc32_dma: add len to esp/le DMA
 memory tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com

This is surprisingly useful when trying to debug DMA issues.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/dma/sparc32_dma.c |    8 ++++----
 hw/dma/trace-events  |    8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index bb7d70a..fbb072a 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -73,7 +73,7 @@ void ledma_memory_read(void *opaque, hwaddr addr,
     int i;
 
     addr |= s->dmaregs[3];
-    trace_ledma_memory_read(addr);
+    trace_ledma_memory_read(addr, len);
     if (do_bswap) {
         sparc_iommu_memory_read(s->iommu, addr, buf, len);
     } else {
@@ -94,7 +94,7 @@ void ledma_memory_write(void *opaque, hwaddr addr,
     uint16_t tmp_buf[32];
 
     addr |= s->dmaregs[3];
-    trace_ledma_memory_write(addr);
+    trace_ledma_memory_write(addr, len);
     if (do_bswap) {
         sparc_iommu_memory_write(s->iommu, addr, buf, len);
     } else {
@@ -139,7 +139,7 @@ void espdma_memory_read(void *opaque, uint8_t *buf, int len)
 {
     DMADeviceState *s = opaque;
 
-    trace_espdma_memory_read(s->dmaregs[1]);
+    trace_espdma_memory_read(s->dmaregs[1], len);
     sparc_iommu_memory_read(s->iommu, s->dmaregs[1], buf, len);
     s->dmaregs[1] += len;
 }
@@ -148,7 +148,7 @@ void espdma_memory_write(void *opaque, uint8_t *buf, int len)
 {
     DMADeviceState *s = opaque;
 
-    trace_espdma_memory_write(s->dmaregs[1]);
+    trace_espdma_memory_write(s->dmaregs[1], len);
     sparc_iommu_memory_write(s->iommu, s->dmaregs[1], buf, len);
     s->dmaregs[1] += len;
 }
diff --git a/hw/dma/trace-events b/hw/dma/trace-events
index 428469a..6b367f0 100644
--- a/hw/dma/trace-events
+++ b/hw/dma/trace-events
@@ -7,12 +7,12 @@ rc4030_read(uint64_t addr, uint32_t ret) "read reg[0x%"PRIx64"] = 0x%x"
 rc4030_write(uint64_t addr, uint32_t val) "write reg[0x%"PRIx64"] = 0x%x"
 
 # hw/dma/sparc32_dma.c
-ledma_memory_read(uint64_t addr) "DMA read addr 0x%"PRIx64
-ledma_memory_write(uint64_t addr) "DMA write addr 0x%"PRIx64
+ledma_memory_read(uint64_t addr, int len) "DMA read addr 0x%"PRIx64 " len %d"
+ledma_memory_write(uint64_t addr, int len) "DMA write addr 0x%"PRIx64 " len %d"
 sparc32_dma_set_irq_raise(void) "Raise IRQ"
 sparc32_dma_set_irq_lower(void) "Lower IRQ"
-espdma_memory_read(uint32_t addr) "DMA read addr 0x%08x"
-espdma_memory_write(uint32_t addr) "DMA write addr 0x%08x"
+espdma_memory_read(uint32_t addr, int len) "DMA read addr 0x%08x len %d"
+espdma_memory_write(uint32_t addr, int len) "DMA write addr 0x%08x len %d"
 sparc32_dma_mem_readl(uint64_t addr, uint32_t ret) "read dmareg 0x%"PRIx64": 0x%08x"
 sparc32_dma_mem_writel(uint64_t addr, uint32_t old, uint32_t val) "write dmareg 0x%"PRIx64": 0x%08x -> 0x%08x"
 sparc32_dma_enable_raise(void) "Raise DMA enable"
-- 
1.7.10.4
