Received: from eggs.gnu.org ([2001:4830:134:3::10]:60762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e83cX-0003Bm-5B
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 08:20:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e83cT-0006hq-1r
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 08:20:17 -0400
Received: from chuckie.co.uk ([82.165.15.123]:33175
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1e83cS-0006Zj-K9
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 08:20:12 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 27 Oct 2017 13:19:48 +0100
Message-Id: <1509106789-8626-4-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1509106789-8626-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1509106789-8626-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv2 3/4] sun4m_iommu: remove legacy
 sparc_iommu_memory_rw() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com

With the switch to the IOMMU memory region and DMA API, this is no longer
required.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/dma/sun4m_iommu.c     |   33 ---------------------------------
 include/hw/sparc/sun4m.h |   16 ----------------
 2 files changed, 49 deletions(-)

diff --git a/hw/dma/sun4m_iommu.c b/hw/dma/sun4m_iommu.c
index ce21a22..30a05e8 100644
--- a/hw/dma/sun4m_iommu.c
+++ b/hw/dma/sun4m_iommu.c
@@ -321,39 +321,6 @@ static IOMMUTLBEntry sun4m_translate_iommu(IOMMUMemoryRegion *iommu,
     return ret;
 }
 
-void sparc_iommu_memory_rw(void *opaque, hwaddr addr,
-                           uint8_t *buf, int len, int is_write)
-{
-    int l;
-    uint32_t flags;
-    hwaddr page, phys_addr;
-
-    while (len > 0) {
-        page = addr & IOMMU_PAGE_MASK;
-        l = (page + IOMMU_PAGE_SIZE) - addr;
-        if (l > len)
-            l = len;
-        flags = iommu_page_get_flags(opaque, page);
-        if (!(flags & IOPTE_VALID)) {
-            iommu_bad_addr(opaque, page, is_write);
-            return;
-        }
-        phys_addr = iommu_translate_pa(addr, flags);
-        if (is_write) {
-            if (!(flags & IOPTE_WRITE)) {
-                iommu_bad_addr(opaque, page, is_write);
-                return;
-            }
-            cpu_physical_memory_write(phys_addr, buf, l);
-        } else {
-            cpu_physical_memory_read(phys_addr, buf, l);
-        }
-        len -= l;
-        buf += l;
-        addr += l;
-    }
-}
-
 static const VMStateDescription vmstate_iommu = {
     .name ="iommu",
     .version_id = 2,
diff --git a/include/hw/sparc/sun4m.h b/include/hw/sparc/sun4m.h
index 6e21e10..c2d0448 100644
--- a/include/hw/sparc/sun4m.h
+++ b/include/hw/sparc/sun4m.h
@@ -29,22 +29,6 @@ typedef struct IOMMUState {
     uint32_t version;
 } IOMMUState;
 
-void sparc_iommu_memory_rw(void *opaque, hwaddr addr,
-                                 uint8_t *buf, int len, int is_write);
-static inline void sparc_iommu_memory_read(void *opaque,
-                                           hwaddr addr,
-                                           uint8_t *buf, int len)
-{
-    sparc_iommu_memory_rw(opaque, addr, buf, len, 0);
-}
-
-static inline void sparc_iommu_memory_write(void *opaque,
-                                            hwaddr addr,
-                                            uint8_t *buf, int len)
-{
-    sparc_iommu_memory_rw(opaque, addr, buf, len, 1);
-}
-
 /* sparc32_dma.c */
 #include "hw/sparc/sparc32_dma.h"
 
-- 
1.7.10.4
