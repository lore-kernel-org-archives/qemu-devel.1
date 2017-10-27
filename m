Received: from eggs.gnu.org ([2001:4830:134:3::10]:60761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e83cX-0003Bk-59
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 08:20:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e83cS-0006gx-3Y
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 08:20:17 -0400
Received: from chuckie.co.uk ([82.165.15.123]:33174
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1e83cR-0006Yf-Sh
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 08:20:12 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 27 Oct 2017 13:19:46 +0100
Message-Id: <1509106789-8626-2-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1509106789-8626-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1509106789-8626-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv2 1/4] sun4m: implement IOMMU translation using
 IOMMU memory region
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
 hw/dma/sun4m_iommu.c     |   62 ++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/sparc/sun4m.h |    5 ++++
 2 files changed, 67 insertions(+)

diff --git a/hw/dma/sun4m_iommu.c b/hw/dma/sun4m_iommu.c
index 840064b..ce21a22 100644
--- a/hw/dma/sun4m_iommu.c
+++ b/hw/dma/sun4m_iommu.c
@@ -278,6 +278,49 @@ static void iommu_bad_addr(IOMMUState *s, hwaddr addr,
     qemu_irq_raise(s->irq);
 }
 
+/* Called from RCU critical section */
+static IOMMUTLBEntry sun4m_translate_iommu(IOMMUMemoryRegion *iommu,
+                                           hwaddr addr,
+                                           IOMMUAccessFlags flags)
+{
+    IOMMUState *is = container_of(iommu, IOMMUState, iommu);
+    hwaddr page, pa;
+    int is_write = (flags & IOMMU_WO) ? 1 : 0;
+    uint32_t pte;
+    IOMMUTLBEntry ret = {
+        .target_as = &address_space_memory,
+        .iova = 0,
+        .translated_addr = 0,
+        .addr_mask = ~(hwaddr)0,
+        .perm = IOMMU_NONE,
+    };
+
+    page = addr & IOMMU_PAGE_MASK;
+    pte = iommu_page_get_flags(is, page);
+    if (!(pte & IOPTE_VALID)) {
+        iommu_bad_addr(is, page, is_write);
+        return ret;
+    }
+
+    pa = iommu_translate_pa(addr, pte);
+    if (is_write && !(pte & IOPTE_WRITE)) {
+        iommu_bad_addr(is, page, is_write);
+        return ret;
+    }
+
+    if (pte & IOPTE_WRITE) {
+        ret.perm = IOMMU_RW;
+    } else {
+        ret.perm = IOMMU_RO;
+    }
+
+    ret.iova = page;
+    ret.translated_addr = pa;
+    ret.addr_mask = ~IOMMU_PAGE_MASK;
+
+    return ret;
+}
+
 void sparc_iommu_memory_rw(void *opaque, hwaddr addr,
                            uint8_t *buf, int len, int is_write)
 {
@@ -340,6 +383,11 @@ static void iommu_init(Object *obj)
     IOMMUState *s = SUN4M_IOMMU(obj);
     SysBusDevice *dev = SYS_BUS_DEVICE(obj);
 
+    memory_region_init_iommu(&s->iommu, sizeof(s->iommu),
+                             TYPE_SUN4M_IOMMU_MEMORY_REGION, OBJECT(dev),
+                             "iommu-sun4m", UINT64_MAX);
+    address_space_init(&s->iommu_as, MEMORY_REGION(&s->iommu), "iommu-as");
+
     sysbus_init_irq(dev, &s->irq);
 
     memory_region_init_io(&s->iomem, obj, &iommu_mem_ops, s, "iommu",
@@ -369,9 +417,23 @@ static const TypeInfo iommu_info = {
     .class_init    = iommu_class_init,
 };
 
+static void sun4m_iommu_memory_region_class_init(ObjectClass *klass, void *data)
+{
+    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
+
+    imrc->translate = sun4m_translate_iommu;
+}
+
+static const TypeInfo sun4m_iommu_memory_region_info = {
+    .parent = TYPE_IOMMU_MEMORY_REGION,
+    .name = TYPE_SUN4M_IOMMU_MEMORY_REGION,
+    .class_init = sun4m_iommu_memory_region_class_init,
+};
+
 static void iommu_register_types(void)
 {
     type_register_static(&iommu_info);
+    type_register_static(&sun4m_iommu_memory_region_info);
 }
 
 type_init(iommu_register_types)
diff --git a/include/hw/sparc/sun4m.h b/include/hw/sparc/sun4m.h
index 1f1cf91..6e21e10 100644
--- a/include/hw/sparc/sun4m.h
+++ b/include/hw/sparc/sun4m.h
@@ -12,11 +12,16 @@
 #define TYPE_SUN4M_IOMMU "iommu"
 #define SUN4M_IOMMU(obj) OBJECT_CHECK(IOMMUState, (obj), TYPE_SUN4M_IOMMU)
 
+#define TYPE_SUN4M_IOMMU_MEMORY_REGION "sun4m-iommu-memory-region"
+
 #define IOMMU_NREGS         (4 * 4096 / 4)
 
 typedef struct IOMMUState {
     SysBusDevice parent_obj;
 
+    AddressSpace iommu_as;
+    IOMMUMemoryRegion iommu;
+
     MemoryRegion iomem;
     uint32_t regs[IOMMU_NREGS];
     hwaddr iostart;
-- 
1.7.10.4
