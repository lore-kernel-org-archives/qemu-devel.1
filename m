Received: from eggs.gnu.org ([2001:4830:134:3::10]:57584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d8MZt-0005vN-67
	for qemu-devel@nongnu.org; Wed, 10 May 2017 04:02:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d8MZo-0000vw-JG
	for qemu-devel@nongnu.org; Wed, 10 May 2017 04:02:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d8MZo-0000vf-A8
	for qemu-devel@nongnu.org; Wed, 10 May 2017 04:02:28 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed, 10 May 2017 16:01:45 +0800
Message-Id: <1494403315-12760-3-git-send-email-peterx@redhat.com>
In-Reply-To: <1494403315-12760-1-git-send-email-peterx@redhat.com>
References: <1494403315-12760-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 02/12] memory: tune last param of
 iommu_ops.translate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, "Michael S . Tsirkin" <mst@redhat.com>, yi.l.liu@intel.com, Marcel Apfelbaum <marcel@redhat.com>, Lan Tianyu <tianyu.lan@intel.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This patch converts the old "is_write" bool into IOMMUAccessFlags. The
difference is that "is_write" can only express either read/write, but
sometimes what we really want is "none" here (neither read nor write).
Replay is an good example - during replay, we should not check any RW
permission bits since thats not an actual IO at all.

CC: Paolo Bonzini <pbonzini@redhat.com>
CC: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 exec.c                   |  6 ++++--
 hw/alpha/typhoon.c       |  2 +-
 hw/dma/rc4030.c          |  2 +-
 hw/i386/amd_iommu.c      |  4 ++--
 hw/i386/intel_iommu.c    |  4 ++--
 hw/pci-host/apb.c        |  2 +-
 hw/ppc/spapr_iommu.c     |  2 +-
 hw/s390x/s390-pci-bus.c  |  2 +-
 hw/s390x/s390-pci-inst.c |  2 +-
 include/exec/memory.h    | 10 ++++++++--
 memory.c                 |  3 ++-
 11 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/exec.c b/exec.c
index eac6085..072de5d 100644
--- a/exec.c
+++ b/exec.c
@@ -481,7 +481,8 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
             break;
         }
 
-        iotlb = mr->iommu_ops->translate(mr, addr, is_write);
+        iotlb = mr->iommu_ops->translate(mr, addr, is_write ?
+                                         IOMMU_WO : IOMMU_RO);
         if (!(iotlb.perm & (1 << is_write))) {
             iotlb.target_as = NULL;
             break;
@@ -513,7 +514,8 @@ MemoryRegion *address_space_translate(AddressSpace *as, hwaddr addr,
             break;
         }
 
-        iotlb = mr->iommu_ops->translate(mr, addr, is_write);
+        iotlb = mr->iommu_ops->translate(mr, addr, is_write ?
+                                         IOMMU_WO : IOMMU_RO);
         addr = ((iotlb.translated_addr & ~iotlb.addr_mask)
                 | (addr & iotlb.addr_mask));
         *plen = MIN(*plen, (addr | iotlb.addr_mask) - addr + 1);
diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index f50f5cf..c1cf780 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -664,7 +664,7 @@ static bool window_translate(TyphoonWindow *win, hwaddr addr,
 /* TODO: A translation failure here ought to set PCI error codes on the
    Pchip and generate a machine check interrupt.  */
 static IOMMUTLBEntry typhoon_translate_iommu(MemoryRegion *iommu, hwaddr addr,
-                                             bool is_write)
+                                             IOMMUAccessFlags flag)
 {
     TyphoonPchip *pchip = container_of(iommu, TyphoonPchip, iommu);
     IOMMUTLBEntry ret;
diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
index 0080141..edf9432 100644
--- a/hw/dma/rc4030.c
+++ b/hw/dma/rc4030.c
@@ -489,7 +489,7 @@ static const MemoryRegionOps jazzio_ops = {
 };
 
 static IOMMUTLBEntry rc4030_dma_translate(MemoryRegion *iommu, hwaddr addr,
-                                          bool is_write)
+                                          IOMMUAccessFlags flag)
 {
     rc4030State *s = container_of(iommu, rc4030State, dma_mr);
     IOMMUTLBEntry ret = {
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index f86a40a..42b34ef 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -987,7 +987,7 @@ static inline bool amdvi_is_interrupt_addr(hwaddr addr)
 }
 
 static IOMMUTLBEntry amdvi_translate(MemoryRegion *iommu, hwaddr addr,
-                                     bool is_write)
+                                     IOMMUAccessFlags flag)
 {
     AMDVIAddressSpace *as = container_of(iommu, AMDVIAddressSpace, iommu);
     AMDVIState *s = as->iommu_state;
@@ -1016,7 +1016,7 @@ static IOMMUTLBEntry amdvi_translate(MemoryRegion *iommu, hwaddr addr,
         return ret;
     }
 
-    amdvi_do_translate(as, addr, is_write, &ret);
+    amdvi_do_translate(as, addr, flag & IOMMU_WO, &ret);
     trace_amdvi_translation_result(as->bus_num, PCI_SLOT(as->devfn),
             PCI_FUNC(as->devfn), addr, ret.translated_addr);
     return ret;
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 02f047c..ea54ec3 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2221,7 +2221,7 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
 }
 
 static IOMMUTLBEntry vtd_iommu_translate(MemoryRegion *iommu, hwaddr addr,
-                                         bool is_write)
+                                         IOMMUAccessFlags flag)
 {
     VTDAddressSpace *vtd_as = container_of(iommu, VTDAddressSpace, iommu);
     IntelIOMMUState *s = vtd_as->iommu_state;
@@ -2243,7 +2243,7 @@ static IOMMUTLBEntry vtd_iommu_translate(MemoryRegion *iommu, hwaddr addr,
     }
 
     vtd_do_iommu_translate(vtd_as, vtd_as->bus, vtd_as->devfn, addr,
-                           is_write, &ret);
+                           flag & IOMMU_WO, &ret);
     VTD_DPRINTF(MMU,
                 "bus %"PRIu8 " slot %"PRIu8 " func %"PRIu8 " devfn %"PRIu8
                 " iova 0x%"PRIx64 " hpa 0x%"PRIx64, pci_bus_num(vtd_as->bus),
diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
index 653e711..ad7abb2 100644
--- a/hw/pci-host/apb.c
+++ b/hw/pci-host/apb.c
@@ -209,7 +209,7 @@ static AddressSpace *pbm_pci_dma_iommu(PCIBus *bus, void *opaque, int devfn)
 
 /* Called from RCU critical section */
 static IOMMUTLBEntry pbm_translate_iommu(MemoryRegion *iommu, hwaddr addr,
-                                         bool is_write)
+                                         IOMMUAccessFlags flag)
 {
     IOMMUState *is = container_of(iommu, IOMMUState, iommu);
     hwaddr baseaddr, offset;
diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index 29c80bb..0341bc0 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -111,7 +111,7 @@ static void spapr_tce_free_table(uint64_t *table, int fd, uint32_t nb_table)
 
 /* Called from RCU critical section */
 static IOMMUTLBEntry spapr_tce_translate_iommu(MemoryRegion *iommu, hwaddr addr,
-                                               bool is_write)
+                                               IOMMUAccessFlags flag)
 {
     sPAPRTCETable *tcet = container_of(iommu, sPAPRTCETable, iommu);
     uint64_t tce;
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index a8a1bab..6bdc795 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -357,7 +357,7 @@ out:
 }
 
 static IOMMUTLBEntry s390_translate_iommu(MemoryRegion *mr, hwaddr addr,
-                                          bool is_write)
+                                          IOMMUAccessFlags flag)
 {
     uint64_t pte;
     uint32_t flags;
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 314a9cb..8bc7c98 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -624,7 +624,7 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
 
     mr = &iommu->iommu_mr;
     while (start < end) {
-        entry = mr->iommu_ops->translate(mr, start, 0);
+        entry = mr->iommu_ops->translate(mr, start, IOMMU_NONE);
 
         if (!entry.translated_addr) {
             pbdev->state = ZPCI_FS_ERROR;
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 99e0f54..97fd0c2 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -185,8 +185,14 @@ struct MemoryRegionOps {
 typedef struct MemoryRegionIOMMUOps MemoryRegionIOMMUOps;
 
 struct MemoryRegionIOMMUOps {
-    /* Return a TLB entry that contains a given address. */
-    IOMMUTLBEntry (*translate)(MemoryRegion *iommu, hwaddr addr, bool is_write);
+    /*
+     * Return a TLB entry that contains a given address. Flag should
+     * be the access permission of this translation operation. We can
+     * set flag to IOMMU_NONE to mean that we don't need any
+     * read/write permission checks, like, when for region replay.
+     */
+    IOMMUTLBEntry (*translate)(MemoryRegion *iommu, hwaddr addr,
+                               IOMMUAccessFlags flag);
     /* Returns minimum supported page size */
     uint64_t (*get_min_page_size)(MemoryRegion *iommu);
     /* Called when IOMMU Notifier flag changed */
diff --git a/memory.c b/memory.c
index b727f5e..3f0aae8 100644
--- a/memory.c
+++ b/memory.c
@@ -1625,6 +1625,7 @@ void memory_region_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n,
 {
     hwaddr addr, granularity;
     IOMMUTLBEntry iotlb;
+    IOMMUAccessFlags flag = is_write ? IOMMU_WO : IOMMU_RO;
 
     /* If the IOMMU has its own replay callback, override */
     if (mr->iommu_ops->replay) {
@@ -1635,7 +1636,7 @@ void memory_region_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n,
     granularity = memory_region_iommu_get_min_page_size(mr);
 
     for (addr = 0; addr < memory_region_size(mr); addr += granularity) {
-        iotlb = mr->iommu_ops->translate(mr, addr, is_write);
+        iotlb = mr->iommu_ops->translate(mr, addr, flag);
         if (iotlb.perm != IOMMU_NONE) {
             n->notify(n, &iotlb);
         }
-- 
2.7.4
