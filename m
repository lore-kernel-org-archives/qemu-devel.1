Received: from eggs.gnu.org ([2001:4830:134:3::10]:55515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e3R7b-0001ib-GO
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 14:25:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e3R7Z-0002a5-Ub
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 14:25:15 -0400
Received: from chuckie.co.uk ([82.165.15.123]:36886
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1e3R7Z-0002Ze-NQ
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 14:25:13 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sat, 14 Oct 2017 19:24:58 +0100
Message-Id: <1508005498-29037-4-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1508005498-29037-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1508005498-29037-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 3/3] sun4m_iommu: remove legacy
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
index 0548bac..662f86e 100644
--- a/include/hw/sparc/sun4m.h
+++ b/include/hw/sparc/sun4m.h
@@ -31,22 +31,6 @@ typedef struct IOMMUState {
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
 /* lance.c */
 #define TYPE_LANCE "lance"
 #define SYSBUS_PCNET(obj) \
-- 
1.7.10.4
