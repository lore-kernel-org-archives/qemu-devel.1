Received: from eggs.gnu.org ([2001:4830:134:3::10]:53657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQBsc-0000H2-A1
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:20:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQBsZ-0006Me-Nc
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:20:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49526 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fQBsZ-0006M4-C7
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:20:03 -0400
From: Peter Xu <peterx@redhat.com>
Date: Tue,  5 Jun 2018 21:19:42 +0800
Message-Id: <20180605131944.14649-2-peterx@redhat.com>
In-Reply-To: <20180605131944.14649-1-peterx@redhat.com>
References: <20180605131944.14649-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC 1/3] memory: add MemTxAttrs to translate function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, peterx@redhat.com, Alex Williamson <alex.williamson@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Add a new MemTxAttrs parameter to the IOMMUMemoryRegionClass.translate()
function, which takes some extra context of the translation request.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/exec/memory.h    | 5 ++++-
 exec.c                   | 2 +-
 hw/alpha/typhoon.c       | 3 ++-
 hw/arm/smmuv3.c          | 2 +-
 hw/dma/rc4030.c          | 6 ++++--
 hw/i386/amd_iommu.c      | 2 +-
 hw/i386/intel_iommu.c    | 6 ++++--
 hw/ppc/spapr_iommu.c     | 3 ++-
 hw/s390x/s390-pci-bus.c  | 6 ++++--
 hw/sparc/sun4m_iommu.c   | 3 ++-
 hw/sparc64/sun4u_iommu.c | 3 ++-
 memory.c                 | 3 ++-
 12 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index eb2ba06519..6b0ced554d 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -234,9 +234,12 @@ typedef struct IOMMUMemoryRegionClass {
      * @iommu: the IOMMUMemoryRegion
      * @hwaddr: address to be translated within the memory region
      * @flag: requested access permissions
+     * @attrs: MemTxAttrs that was bound to the translation
+     *         operation. If flag==IOMMU_NONE, this field is
+     *         meaningless
      */
     IOMMUTLBEntry (*translate)(IOMMUMemoryRegion *iommu, hwaddr addr,
-                               IOMMUAccessFlags flag);
+                               IOMMUAccessFlags flag, MemTxAttrs attrs);
     /* Returns minimum supported page size in bytes.
      * If this method is not provided then the minimum is assumed to
      * be TARGET_PAGE_SIZE.
diff --git a/exec.c b/exec.c
index f6645ede0c..a0808ce9bd 100644
--- a/exec.c
+++ b/exec.c
@@ -502,7 +502,7 @@ static MemoryRegionSection address_space_translate_iommu(IOMMUMemoryRegion *iomm
         hwaddr addr = *xlat;
         IOMMUMemoryRegionClass *imrc = memory_region_get_iommu_class_nocheck(iommu_mr);
         IOMMUTLBEntry iotlb = imrc->translate(iommu_mr, addr, is_write ?
-                                              IOMMU_WO : IOMMU_RO);
+                                              IOMMU_WO : IOMMU_RO, attrs);
 
         if (!(iotlb.perm & (1 << is_write))) {
             goto unassigned;
diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index 6a40869488..49192ab24d 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -666,7 +666,8 @@ static bool window_translate(TyphoonWindow *win, hwaddr addr,
    Pchip and generate a machine check interrupt.  */
 static IOMMUTLBEntry typhoon_translate_iommu(IOMMUMemoryRegion *iommu,
                                              hwaddr addr,
-                                             IOMMUAccessFlags flag)
+                                             IOMMUAccessFlags flag,
+                                             MemTxAttrs attrs)
 {
     TyphoonPchip *pchip = container_of(iommu, TyphoonPchip, iommu);
     IOMMUTLBEntry ret;
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 42dc521c13..f50d31c9d1 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -538,7 +538,7 @@ static int smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
 }
 
 static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
-                                      IOMMUAccessFlags flag)
+                                      IOMMUAccessFlags flag, MemTxAttrs attrs)
 {
     SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
     SMMUv3State *s = sdev->smmu;
diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
index 5d4833eeca..1989bea771 100644
--- a/hw/dma/rc4030.c
+++ b/hw/dma/rc4030.c
@@ -490,8 +490,10 @@ static const MemoryRegionOps jazzio_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-static IOMMUTLBEntry rc4030_dma_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
-                                          IOMMUAccessFlags flag)
+static IOMMUTLBEntry rc4030_dma_translate(IOMMUMemoryRegion *iommu,
+                                          hwaddr addr,
+                                          IOMMUAccessFlags flag,
+                                          MemTxAttrs attrs)
 {
     rc4030State *s = container_of(iommu, rc4030State, dma_mr);
     IOMMUTLBEntry ret = {
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 63d46ff6ee..084bfb7024 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -991,7 +991,7 @@ static inline bool amdvi_is_interrupt_addr(hwaddr addr)
 }
 
 static IOMMUTLBEntry amdvi_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
-                                     IOMMUAccessFlags flag)
+                                     IOMMUAccessFlags flag, MemTxAttrs attrs)
 {
     AMDVIAddressSpace *as = container_of(iommu, AMDVIAddressSpace, iommu);
     AMDVIState *s = as->iommu_state;
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index b5a09b7908..ffbf19e257 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2470,8 +2470,10 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
     }
 }
 
-static IOMMUTLBEntry vtd_iommu_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
-                                         IOMMUAccessFlags flag)
+static IOMMUTLBEntry vtd_iommu_translate(IOMMUMemoryRegion *iommu,
+                                         hwaddr addr,
+                                         IOMMUAccessFlags flag,
+                                         MemTxAttrs attrs)
 {
     VTDAddressSpace *vtd_as = container_of(iommu, VTDAddressSpace, iommu);
     IntelIOMMUState *s = vtd_as->iommu_state;
diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index aaa6010d5c..199612095a 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -112,7 +112,8 @@ static void spapr_tce_free_table(uint64_t *table, int fd, uint32_t nb_table)
 /* Called from RCU critical section */
 static IOMMUTLBEntry spapr_tce_translate_iommu(IOMMUMemoryRegion *iommu,
                                                hwaddr addr,
-                                               IOMMUAccessFlags flag)
+                                               IOMMUAccessFlags flag,
+                                               MemTxAttrs attrs)
 {
     sPAPRTCETable *tcet = container_of(iommu, sPAPRTCETable, iommu);
     uint64_t tce;
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 10da87458e..df321ae102 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -483,8 +483,10 @@ uint16_t s390_guest_io_table_walk(uint64_t g_iota, hwaddr addr,
     return error;
 }
 
-static IOMMUTLBEntry s390_translate_iommu(IOMMUMemoryRegion *mr, hwaddr addr,
-                                          IOMMUAccessFlags flag)
+static IOMMUTLBEntry s390_translate_iommu(IOMMUMemoryRegion *mr,
+                                          hwaddr addr,
+                                          IOMMUAccessFlags flag,
+                                          MemTxAttrs attrs)
 {
     S390PCIIOMMU *iommu = container_of(mr, S390PCIIOMMU, iommu_mr);
     S390IOTLBEntry *entry;
diff --git a/hw/sparc/sun4m_iommu.c b/hw/sparc/sun4m_iommu.c
index b677601fc6..f68bcade3c 100644
--- a/hw/sparc/sun4m_iommu.c
+++ b/hw/sparc/sun4m_iommu.c
@@ -282,7 +282,8 @@ static void iommu_bad_addr(IOMMUState *s, hwaddr addr,
 /* Called from RCU critical section */
 static IOMMUTLBEntry sun4m_translate_iommu(IOMMUMemoryRegion *iommu,
                                            hwaddr addr,
-                                           IOMMUAccessFlags flags)
+                                           IOMMUAccessFlags flags,
+                                           MemTxAttrs attrs)
 {
     IOMMUState *is = container_of(iommu, IOMMUState, iommu);
     hwaddr page, pa;
diff --git a/hw/sparc64/sun4u_iommu.c b/hw/sparc64/sun4u_iommu.c
index eb3aaa87e6..7a5a588aed 100644
--- a/hw/sparc64/sun4u_iommu.c
+++ b/hw/sparc64/sun4u_iommu.c
@@ -73,7 +73,8 @@
 /* Called from RCU critical section */
 static IOMMUTLBEntry sun4u_translate_iommu(IOMMUMemoryRegion *iommu,
                                            hwaddr addr,
-                                           IOMMUAccessFlags flag)
+                                           IOMMUAccessFlags flag,
+                                           MemTxAttrs attrs)
 {
     IOMMUState *is = container_of(iommu, IOMMUState, iommu);
     hwaddr baseaddr, offset;
diff --git a/memory.c b/memory.c
index 3212acc7f4..376f72b19c 100644
--- a/memory.c
+++ b/memory.c
@@ -1819,6 +1819,7 @@ void memory_region_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
     IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_GET_CLASS(iommu_mr);
     hwaddr addr, granularity;
     IOMMUTLBEntry iotlb;
+    MemTxAttrs attrs = { 0 };
 
     /* If the IOMMU has its own replay callback, override */
     if (imrc->replay) {
@@ -1829,7 +1830,7 @@ void memory_region_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
     granularity = memory_region_iommu_get_min_page_size(iommu_mr);
 
     for (addr = 0; addr < memory_region_size(mr); addr += granularity) {
-        iotlb = imrc->translate(iommu_mr, addr, IOMMU_NONE);
+        iotlb = imrc->translate(iommu_mr, addr, IOMMU_NONE, attrs);
         if (iotlb.perm != IOMMU_NONE) {
             n->notify(n, &iotlb);
         }
-- 
2.17.0
