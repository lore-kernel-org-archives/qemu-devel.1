Received: from eggs.gnu.org ([2001:4830:134:3::10]:55517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e3R7b-0001id-GN
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 14:25:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e3R7Y-0002ZP-Lw
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 14:25:15 -0400
Received: from chuckie.co.uk ([82.165.15.123]:36882
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1e3R7Y-0002Yi-Fk
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 14:25:12 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sat, 14 Oct 2017 19:24:57 +0100
Message-Id: <1508005498-29037-3-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1508005498-29037-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1508005498-29037-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 2/3] sparc32_dma: switch over to using IOMMU
 memory region and DMA API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/dma/sparc32_dma.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index fbb072a..5438831 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -29,6 +29,7 @@
 #include "hw/hw.h"
 #include "hw/sparc/sparc32_dma.h"
 #include "hw/sysbus.h"
+#include "sysemu/dma.h"
 #include "qapi/error.h"
 #include "trace.h"
 
@@ -70,16 +71,17 @@ void ledma_memory_read(void *opaque, hwaddr addr,
                        uint8_t *buf, int len, int do_bswap)
 {
     DMADeviceState *s = opaque;
+    IOMMUState *is = (IOMMUState *)s->iommu;
     int i;
 
     addr |= s->dmaregs[3];
     trace_ledma_memory_read(addr, len);
     if (do_bswap) {
-        sparc_iommu_memory_read(s->iommu, addr, buf, len);
+        dma_memory_read(&is->iommu_as, addr, buf, len);
     } else {
         addr &= ~1;
         len &= ~1;
-        sparc_iommu_memory_read(s->iommu, addr, buf, len);
+        dma_memory_read(&is->iommu_as, addr, buf, len);
         for(i = 0; i < len; i += 2) {
             bswap16s((uint16_t *)(buf + i));
         }
@@ -90,13 +92,14 @@ void ledma_memory_write(void *opaque, hwaddr addr,
                         uint8_t *buf, int len, int do_bswap)
 {
     DMADeviceState *s = opaque;
+    IOMMUState *is = (IOMMUState *)s->iommu;
     int l, i;
     uint16_t tmp_buf[32];
 
     addr |= s->dmaregs[3];
     trace_ledma_memory_write(addr, len);
     if (do_bswap) {
-        sparc_iommu_memory_write(s->iommu, addr, buf, len);
+        dma_memory_write(&is->iommu_as, addr, buf, len);
     } else {
         addr &= ~1;
         len &= ~1;
@@ -107,7 +110,7 @@ void ledma_memory_write(void *opaque, hwaddr addr,
             for(i = 0; i < l; i += 2) {
                 tmp_buf[i >> 1] = bswap16(*(uint16_t *)(buf + i));
             }
-            sparc_iommu_memory_write(s->iommu, addr, (uint8_t *)tmp_buf, l);
+            dma_memory_write(&is->iommu_as, addr, tmp_buf, l);
             len -= l;
             buf += l;
             addr += l;
@@ -138,18 +141,20 @@ static void dma_set_irq(void *opaque, int irq, int level)
 void espdma_memory_read(void *opaque, uint8_t *buf, int len)
 {
     DMADeviceState *s = opaque;
+    IOMMUState *is = (IOMMUState *)s->iommu;
 
     trace_espdma_memory_read(s->dmaregs[1], len);
-    sparc_iommu_memory_read(s->iommu, s->dmaregs[1], buf, len);
+    dma_memory_read(&is->iommu_as, s->dmaregs[1], buf, len);
     s->dmaregs[1] += len;
 }
 
 void espdma_memory_write(void *opaque, uint8_t *buf, int len)
 {
     DMADeviceState *s = opaque;
+    IOMMUState *is = (IOMMUState *)s->iommu;
 
     trace_espdma_memory_write(s->dmaregs[1], len);
-    sparc_iommu_memory_write(s->iommu, s->dmaregs[1], buf, len);
+    dma_memory_write(&is->iommu_as, s->dmaregs[1], buf, len);
     s->dmaregs[1] += len;
 }
 
-- 
1.7.10.4
