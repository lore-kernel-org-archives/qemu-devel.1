Received: from eggs.gnu.org ([2001:4830:134:3::10]:54683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cED78-0007EV-P3
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:36:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cED77-0001wG-D7
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:36:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48106)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cED77-0001w0-4c
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:36:45 -0500
From: Peter Xu <peterx@redhat.com>
Date: Tue,  6 Dec 2016 18:36:18 +0800
Message-Id: <1481020588-4245-4-git-send-email-peterx@redhat.com>
In-Reply-To: <1481020588-4245-1-git-send-email-peterx@redhat.com>
References: <1481020588-4245-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 03/13] intel_iommu: renaming gpa to iova
 where proper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, bd.aviv@gmail.com, peterx@redhat.com, alex.williamson@redhat.com, jasowang@redhat.com

There are lots of places in current intel_iommu.c codes that named
"iova" as "gpa". It is really confusing to use a name "gpa" in these
places (which is very easily to be understood as "Guest Physical
Address", while it's not). To make the codes (much) easier to be read, I
decided to do this once and for all.

No functional change is made. Only literal ones.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index f19a8b3..3d98797 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -279,7 +279,7 @@ static void vtd_update_iotlb(IntelIOMMUState *s, uint16_t source_id,
     uint64_t *key = g_malloc(sizeof(*key));
     uint64_t gfn = vtd_get_iotlb_gfn(addr, level);
 
-    VTD_DPRINTF(CACHE, "update iotlb sid 0x%"PRIx16 " gpa 0x%"PRIx64
+    VTD_DPRINTF(CACHE, "update iotlb sid 0x%"PRIx16 " iova 0x%"PRIx64
                 " slpte 0x%"PRIx64 " did 0x%"PRIx16, source_id, addr, slpte,
                 domain_id);
     if (g_hash_table_size(s->iotlb) >= VTD_IOTLB_MAX_SIZE) {
@@ -595,12 +595,12 @@ static uint64_t vtd_get_slpte(dma_addr_t base_addr, uint32_t index)
     return slpte;
 }
 
-/* Given a gpa and the level of paging structure, return the offset of current
- * level.
+/* Given a iova and the level of paging structure, return the offset
+ * of current level.
  */
-static inline uint32_t vtd_gpa_level_offset(uint64_t gpa, uint32_t level)
+static inline uint32_t vtd_iova_level_offset(uint64_t iova, uint32_t level)
 {
-    return (gpa >> vtd_slpt_level_shift(level)) &
+    return (iova >> vtd_slpt_level_shift(level)) &
             ((1ULL << VTD_SL_LEVEL_BITS) - 1);
 }
 
@@ -648,13 +648,13 @@ static bool vtd_slpte_nonzero_rsvd(uint64_t slpte, uint32_t level)
     }
 }
 
-/* Given the @gpa, get relevant @slptep. @slpte_level will be the last level
+/* Given the @iova, get relevant @slptep. @slpte_level will be the last level
  * of the translation, can be used for deciding the size of large page.
  */
-static int vtd_gpa_to_slpte(VTDContextEntry *ce, uint64_t gpa,
-                            IOMMUAccessFlags flags,
-                            uint64_t *slptep, uint32_t *slpte_level,
-                            bool *reads, bool *writes)
+static int vtd_iova_to_slpte(VTDContextEntry *ce, uint64_t iova,
+                             IOMMUAccessFlags flags,
+                             uint64_t *slptep, uint32_t *slpte_level,
+                             bool *reads, bool *writes)
 {
     dma_addr_t addr = vtd_get_slpt_base_from_context(ce);
     uint32_t level = vtd_get_level_from_context_entry(ce);
@@ -663,11 +663,11 @@ static int vtd_gpa_to_slpte(VTDContextEntry *ce, uint64_t gpa,
     uint32_t ce_agaw = vtd_get_agaw_from_context_entry(ce);
     uint64_t access_right_check = 0;
 
-    /* Check if @gpa is above 2^X-1, where X is the minimum of MGAW in CAP_REG
-     * and AW in context-entry.
+    /* Check if @iova is above 2^X-1, where X is the minimum of MGAW
+     * in CAP_REG and AW in context-entry.
      */
-    if (gpa & ~((1ULL << MIN(ce_agaw, VTD_MGAW)) - 1)) {
-        VTD_DPRINTF(GENERAL, "error: gpa 0x%"PRIx64 " exceeds limits", gpa);
+    if (iova & ~((1ULL << MIN(ce_agaw, VTD_MGAW)) - 1)) {
+        VTD_DPRINTF(GENERAL, "error: iova 0x%"PRIx64 " exceeds limits", iova);
         return -VTD_FR_ADDR_BEYOND_MGAW;
     }
 
@@ -683,13 +683,13 @@ static int vtd_gpa_to_slpte(VTDContextEntry *ce, uint64_t gpa,
     }
 
     while (true) {
-        offset = vtd_gpa_level_offset(gpa, level);
+        offset = vtd_iova_level_offset(iova, level);
         slpte = vtd_get_slpte(addr, offset);
 
         if (slpte == (uint64_t)-1) {
             VTD_DPRINTF(GENERAL, "error: fail to access second-level paging "
-                        "entry at level %"PRIu32 " for gpa 0x%"PRIx64,
-                        level, gpa);
+                        "entry at level %"PRIu32 " for iova 0x%"PRIx64,
+                        level, iova);
             if (level == vtd_get_level_from_context_entry(ce)) {
                 /* Invalid programming of context-entry */
                 return -VTD_FR_CONTEXT_ENTRY_INV;
@@ -701,8 +701,8 @@ static int vtd_gpa_to_slpte(VTDContextEntry *ce, uint64_t gpa,
         *writes = (*writes) && (slpte & VTD_SL_W);
         if (!(slpte & access_right_check) && !(flags & IOMMU_NO_FAIL)) {
             VTD_DPRINTF(GENERAL, "error: lack of %s permission for "
-                        "gpa 0x%"PRIx64 " slpte 0x%"PRIx64,
-                        (flags & IOMMU_WO ? "write" : "read"), gpa, slpte);
+                        "iova 0x%"PRIx64 " slpte 0x%"PRIx64,
+                        (flags & IOMMU_WO ? "write" : "read"), iova, slpte);
             return (flags & IOMMU_WO) ? -VTD_FR_WRITE : -VTD_FR_READ;
         }
         if (vtd_slpte_nonzero_rsvd(slpte, level)) {
@@ -851,7 +851,7 @@ static void vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     /* Try to fetch slpte form IOTLB */
     iotlb_entry = vtd_lookup_iotlb(s, source_id, addr);
     if (iotlb_entry) {
-        VTD_DPRINTF(CACHE, "hit iotlb sid 0x%"PRIx16 " gpa 0x%"PRIx64
+        VTD_DPRINTF(CACHE, "hit iotlb sid 0x%"PRIx16 " iova 0x%"PRIx64
                     " slpte 0x%"PRIx64 " did 0x%"PRIx16, source_id, addr,
                     iotlb_entry->slpte, iotlb_entry->domain_id);
         slpte = iotlb_entry->slpte;
@@ -894,8 +894,8 @@ static void vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
         cc_entry->context_cache_gen = s->context_cache_gen;
     }
 
-    ret_fr = vtd_gpa_to_slpte(&ce, addr, flags, &slpte, &level,
-                              &reads, &writes);
+    ret_fr = vtd_iova_to_slpte(&ce, addr, flags, &slpte, &level,
+                               &reads, &writes);
     if (ret_fr) {
         ret_fr = -ret_fr;
         if (!(flags & IOMMU_NO_FAIL)) {
@@ -2032,7 +2032,7 @@ static IOMMUTLBEntry vtd_iommu_translate(MemoryRegion *iommu, hwaddr addr,
                            flags, &ret);
     VTD_DPRINTF(MMU,
                 "bus %"PRIu8 " slot %"PRIu8 " func %"PRIu8 " devfn %"PRIu8
-                " gpa 0x%"PRIx64 " hpa 0x%"PRIx64, pci_bus_num(vtd_as->bus),
+                " iova 0x%"PRIx64 " hpa 0x%"PRIx64, pci_bus_num(vtd_as->bus),
                 VTD_PCI_SLOT(vtd_as->devfn), VTD_PCI_FUNC(vtd_as->devfn),
                 vtd_as->devfn, addr, ret.translated_addr);
     return ret;
-- 
2.7.4
