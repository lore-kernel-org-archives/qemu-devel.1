Received: from eggs.gnu.org ([2001:4830:134:3::10]:50215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1d3K6f-0002FW-Aq
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:23:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1d3K6a-0001wu-AT
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:23:33 -0400
Received: from mga01.intel.com ([192.55.52.88]:41989)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1d3K6Z-0001wP-Sc
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:23:28 -0400
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Date: Wed, 26 Apr 2017 18:06:32 +0800
Message-Id: <1493201210-14357-3-git-send-email-yi.l.liu@linux.intel.com>
In-Reply-To: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
References: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
Subject: [Qemu-devel] [RFC PATCH 02/20] intel_iommu: exposed
 extended-context mode to guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, alex.williamson@redhat.com, peterx@redhat.com
Cc: kvm@vger.kernel.org, jasowang@redhat.com, iommu@lists.linux-foundation.org, kevin.tian@intel.com, ashok.raj@intel.com, jacob.jun.pan@intel.com, tianyu.lan@intel.com, yi.l.liu@intel.com, jean-philippe.brucker@arm.com, "Liu, Yi L" <yi.l.liu@linux.intel.com>

VT-d implementations reporting PASID or PRS fields as "Set", must also
report ecap.ECS as "Set". Extended-Context is required for SVM.

When ECS is reported, intel iommu driver would initiate extended root entry
and extended context entry, and also PASID table if there is any SVM capable
device.

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 hw/i386/intel_iommu.c          | 131 +++++++++++++++++++++++++++--------------
 hw/i386/intel_iommu_internal.h |   9 +++
 include/hw/i386/intel_iommu.h  |   2 +-
 3 files changed, 97 insertions(+), 45 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 400d0d1..bf98fa5 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -497,6 +497,11 @@ static inline bool vtd_root_entry_present(VTDRootEntry *root)
     return root->val & VTD_ROOT_ENTRY_P;
 }
 
+static inline bool vtd_root_entry_upper_present(VTDRootEntry *root)
+{
+    return root->rsvd & VTD_ROOT_ENTRY_P;
+}
+
 static int vtd_get_root_entry(IntelIOMMUState *s, uint8_t index,
                               VTDRootEntry *re)
 {
@@ -509,6 +514,9 @@ static int vtd_get_root_entry(IntelIOMMUState *s, uint8_t index,
         return -VTD_FR_ROOT_TABLE_INV;
     }
     re->val = le64_to_cpu(re->val);
+    if (s->ecs) {
+        re->rsvd = le64_to_cpu(re->rsvd);
+    }
     return 0;
 }
 
@@ -517,19 +525,30 @@ static inline bool vtd_context_entry_present(VTDContextEntry *context)
     return context->lo & VTD_CONTEXT_ENTRY_P;
 }
 
-static int vtd_get_context_entry_from_root(VTDRootEntry *root, uint8_t index,
-                                           VTDContextEntry *ce)
+static int vtd_get_context_entry_from_root(IntelIOMMUState *s,
+                 VTDRootEntry *root, uint8_t index, VTDContextEntry *ce)
 {
-    dma_addr_t addr;
+    dma_addr_t addr, ce_size;
 
     /* we have checked that root entry is present */
-    addr = (root->val & VTD_ROOT_ENTRY_CTP) + index * sizeof(*ce);
-    if (dma_memory_read(&address_space_memory, addr, ce, sizeof(*ce))) {
+    ce_size = (s->ecs) ? (2 * sizeof(*ce)) : (sizeof(*ce));
+    addr = (s->ecs && (index > 0x7f)) ?
+           ((root->rsvd & VTD_ROOT_ENTRY_CTP) + (index - 0x80) * ce_size) :
+           ((root->val & VTD_ROOT_ENTRY_CTP) + index * ce_size);
+
+    if (dma_memory_read(&address_space_memory, addr, ce, ce_size)) {
         trace_vtd_re_invalid(root->rsvd, root->val);
         return -VTD_FR_CONTEXT_TABLE_INV;
     }
-    ce->lo = le64_to_cpu(ce->lo);
-    ce->hi = le64_to_cpu(ce->hi);
+
+    ce[0].lo = le64_to_cpu(ce[0].lo);
+    ce[0].hi = le64_to_cpu(ce[0].hi);
+
+    if (s->ecs) {
+        ce[1].lo = le64_to_cpu(ce[1].lo);
+        ce[1].hi = le64_to_cpu(ce[1].hi);
+    }
+
     return 0;
 }
 
@@ -595,9 +614,11 @@ static inline uint32_t vtd_get_agaw_from_context_entry(VTDContextEntry *ce)
     return 30 + (ce->hi & VTD_CONTEXT_ENTRY_AW) * 9;
 }
 
-static inline uint32_t vtd_ce_get_type(VTDContextEntry *ce)
+static inline uint32_t vtd_ce_get_type(IntelIOMMUState *s,
+                                       VTDContextEntry *ce)
 {
-    return ce->lo & VTD_CONTEXT_ENTRY_TT;
+    return s->ecs ? (ce->lo & VTD_CONTEXT_ENTRY_TT) :
+                    (ce->lo & VTD_EXT_CONTEXT_ENTRY_TT);
 }
 
 static inline uint64_t vtd_iova_limit(VTDContextEntry *ce)
@@ -842,16 +863,20 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
         return ret_fr;
     }
 
-    if (!vtd_root_entry_present(&re)) {
+    if (!vtd_root_entry_present(&re) ||
+        (s->ecs && (devfn > 0x7f) && (!vtd_root_entry_upper_present(&re)))) {
         /* Not error - it's okay we don't have root entry. */
         trace_vtd_re_not_present(bus_num);
         return -VTD_FR_ROOT_ENTRY_P;
-    } else if (re.rsvd || (re.val & VTD_ROOT_ENTRY_RSVD)) {
-        trace_vtd_re_invalid(re.rsvd, re.val);
-        return -VTD_FR_ROOT_ENTRY_RSVD;
+    }
+    if ((s->ecs && (devfn > 0x7f) && (re.rsvd & VTD_ROOT_ENTRY_RSVD)) ||
+        (s->ecs && (devfn < 0x80) && (re.val & VTD_ROOT_ENTRY_RSVD)) ||
+        ((!s->ecs) && (re.rsvd || (re.val & VTD_ROOT_ENTRY_RSVD)))) {
+            trace_vtd_re_invalid(re.rsvd, re.val);
+            return -VTD_FR_ROOT_ENTRY_RSVD;
     }
 
-    ret_fr = vtd_get_context_entry_from_root(&re, devfn, ce);
+    ret_fr = vtd_get_context_entry_from_root(s, &re, devfn, ce);
     if (ret_fr) {
         return ret_fr;
     }
@@ -860,21 +885,36 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
         /* Not error - it's okay we don't have context entry. */
         trace_vtd_ce_not_present(bus_num, devfn);
         return -VTD_FR_CONTEXT_ENTRY_P;
-    } else if ((ce->hi & VTD_CONTEXT_ENTRY_RSVD_HI) ||
-               (ce->lo & VTD_CONTEXT_ENTRY_RSVD_LO)) {
+    }
+
+    /* Check Reserved bits in context-entry */
+    if ((!s->ecs && (ce->hi & VTD_CONTEXT_ENTRY_RSVD_HI)) ||
+        (!s->ecs && (ce->lo & VTD_CONTEXT_ENTRY_RSVD_LO)) ||
+        (s->ecs && (ce[0].lo & VTD_EXT_CONTEXT_ENTRY_RSVD_LOW0)) ||
+        (s->ecs && (ce[0].hi & VTD_EXT_CONTEXT_ENTRY_RSVD_HIGH0)) ||
+        (s->ecs && (ce[1].lo & VTD_EXT_CONTEXT_ENTRY_RSVD_LOW1))) {
         trace_vtd_ce_invalid(ce->hi, ce->lo);
         return -VTD_FR_CONTEXT_ENTRY_RSVD;
     }
+
     /* Check if the programming of context-entry is valid */
     if (!vtd_is_level_supported(s, vtd_get_level_from_context_entry(ce))) {
         trace_vtd_ce_invalid(ce->hi, ce->lo);
         return -VTD_FR_CONTEXT_ENTRY_INV;
     } else {
-        switch (vtd_ce_get_type(ce)) {
+        switch (vtd_ce_get_type(s, ce)) {
         case VTD_CONTEXT_TT_MULTI_LEVEL:
             /* fall through */
         case VTD_CONTEXT_TT_DEV_IOTLB:
             break;
+        case VTD_EXT_CONTEXT_TT_NO_DEV_IOTLB:
+        case VTD_EXT_CONTEXT_TT_DEV_IOTLB:
+            if (s->ecs) {
+                break;
+            } else {
+                trace_vtd_ce_invalid(ce->hi, ce->lo);
+                return -VTD_FR_CONTEXT_ENTRY_INV;
+            }
         case VTD_CONTEXT_TT_PASS_THROUGH:
             if (s->ecap & VTD_ECAP_PT) {
                 break;
@@ -894,18 +934,18 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
 static int vtd_dev_get_trans_type(VTDAddressSpace *as)
 {
     IntelIOMMUState *s;
-    VTDContextEntry ce;
+    VTDContextEntry ce[2];
     int ret;
 
     s = as->iommu_state;
 
     ret = vtd_dev_to_context_entry(s, pci_bus_num(as->bus),
-                                   as->devfn, &ce);
+                                   as->devfn, &ce[0]);
     if (ret) {
         return ret;
     }
 
-    return vtd_ce_get_type(&ce);
+    return vtd_ce_get_type(s, &ce[0]);
 }
 
 static bool vtd_dev_pt_enabled(VTDAddressSpace *as)
@@ -1008,7 +1048,7 @@ static void vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
                                    IOMMUTLBEntry *entry)
 {
     IntelIOMMUState *s = vtd_as->iommu_state;
-    VTDContextEntry ce;
+    VTDContextEntry ce[2];
     uint8_t bus_num = pci_bus_num(bus);
     VTDContextCacheEntry *cc_entry = &vtd_as->context_cache_entry;
     uint64_t slpte, page_mask;
@@ -1039,14 +1079,16 @@ static void vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     }
     /* Try to fetch context-entry from cache first */
     if (cc_entry->context_cache_gen == s->context_cache_gen) {
-        trace_vtd_iotlb_cc_hit(bus_num, devfn, cc_entry->context_entry.hi,
-                               cc_entry->context_entry.lo,
+        trace_vtd_iotlb_cc_hit(bus_num, devfn,
+                               cc_entry->context_entry[0].hi,
+                               cc_entry->context_entry[0].lo,
                                cc_entry->context_cache_gen);
-        ce = cc_entry->context_entry;
-        is_fpd_set = ce.lo & VTD_CONTEXT_ENTRY_FPD;
+        ce[0] = cc_entry->context_entry[0];
+        ce[1] = cc_entry->context_entry[1];
+        is_fpd_set = ce[0].lo & VTD_CONTEXT_ENTRY_FPD;
     } else {
-        ret_fr = vtd_dev_to_context_entry(s, bus_num, devfn, &ce);
-        is_fpd_set = ce.lo & VTD_CONTEXT_ENTRY_FPD;
+        ret_fr = vtd_dev_to_context_entry(s, bus_num, devfn, &ce[0]);
+        is_fpd_set = ce[0].lo & VTD_CONTEXT_ENTRY_FPD;
         if (ret_fr) {
             ret_fr = -ret_fr;
             if (is_fpd_set && vtd_is_qualified_fault(ret_fr)) {
@@ -1057,10 +1099,11 @@ static void vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
             return;
         }
         /* Update context-cache */
-        trace_vtd_iotlb_cc_update(bus_num, devfn, ce.hi, ce.lo,
+        trace_vtd_iotlb_cc_update(bus_num, devfn, ce[0].hi, ce[0].lo,
                                   cc_entry->context_cache_gen,
                                   s->context_cache_gen);
-        cc_entry->context_entry = ce;
+        cc_entry->context_entry[0] = ce[0];
+        cc_entry->context_entry[1] = ce[1];
         cc_entry->context_cache_gen = s->context_cache_gen;
     }
 
@@ -1068,7 +1111,7 @@ static void vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
      * We don't need to translate for pass-through context entries.
      * Also, let's ignore IOTLB caching as well for PT devices.
      */
-    if (vtd_ce_get_type(&ce) == VTD_CONTEXT_TT_PASS_THROUGH) {
+    if (vtd_ce_get_type(s, &ce[0]) == VTD_CONTEXT_TT_PASS_THROUGH) {
         entry->translated_addr = entry->iova;
         entry->addr_mask = VTD_PAGE_SIZE - 1;
         entry->perm = IOMMU_RW;
@@ -1076,7 +1119,7 @@ static void vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
         return;
     }
 
-    ret_fr = vtd_iova_to_slpte(&ce, addr, is_write, &slpte, &level,
+    ret_fr = vtd_iova_to_slpte(&ce[0], addr, is_write, &slpte, &level,
                                &reads, &writes);
     if (ret_fr) {
         ret_fr = -ret_fr;
@@ -1089,7 +1132,7 @@ static void vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     }
 
     page_mask = vtd_slpt_level_page_mask(level);
-    vtd_update_iotlb(s, source_id, VTD_CONTEXT_ENTRY_DID(ce.hi), addr, slpte,
+    vtd_update_iotlb(s, source_id, VTD_CONTEXT_ENTRY_DID(ce[0].hi), addr, slpte,
                      reads, writes, level);
 out:
     entry->iova = addr & page_mask;
@@ -1283,7 +1326,7 @@ static void vtd_iotlb_global_invalidate(IntelIOMMUState *s)
 static void vtd_iotlb_domain_invalidate(IntelIOMMUState *s, uint16_t domain_id)
 {
     IntelIOMMUNotifierNode *node;
-    VTDContextEntry ce;
+    VTDContextEntry ce[2];
     VTDAddressSpace *vtd_as;
 
     g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_domain,
@@ -1292,8 +1335,8 @@ static void vtd_iotlb_domain_invalidate(IntelIOMMUState *s, uint16_t domain_id)
     QLIST_FOREACH(node, &s->notifiers_list, next) {
         vtd_as = node->vtd_as;
         if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
-                                      vtd_as->devfn, &ce) &&
-            domain_id == VTD_CONTEXT_ENTRY_DID(ce.hi)) {
+                                      vtd_as->devfn, &ce[0]) &&
+            domain_id == VTD_CONTEXT_ENTRY_DID(ce[0].hi)) {
             memory_region_iommu_replay_all(&vtd_as->iommu);
         }
     }
@@ -1311,15 +1354,15 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
                                            uint8_t am)
 {
     IntelIOMMUNotifierNode *node;
-    VTDContextEntry ce;
+    VTDContextEntry ce[2];
     int ret;
 
     QLIST_FOREACH(node, &(s->notifiers_list), next) {
         VTDAddressSpace *vtd_as = node->vtd_as;
         ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
-                                       vtd_as->devfn, &ce);
-        if (!ret && domain_id == VTD_CONTEXT_ENTRY_DID(ce.hi)) {
-            vtd_page_walk(&ce, addr, addr + (1 << am) * VTD_PAGE_SIZE,
+                                       vtd_as->devfn, &ce[0]);
+        if (!ret && domain_id == VTD_CONTEXT_ENTRY_DID(ce[0].hi)) {
+            vtd_page_walk(&ce[0], addr, addr + (1 << am) * VTD_PAGE_SIZE,
                           vtd_page_invalidate_notify_hook,
                           (void *)&vtd_as->iommu, true);
         }
@@ -2858,7 +2901,7 @@ static void vtd_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n)
     VTDAddressSpace *vtd_as = container_of(mr, VTDAddressSpace, iommu);
     IntelIOMMUState *s = vtd_as->iommu_state;
     uint8_t bus_n = pci_bus_num(vtd_as->bus);
-    VTDContextEntry ce;
+    VTDContextEntry ce[2];
 
     /*
      * The replay can be triggered by either a invalidation or a newly
@@ -2867,12 +2910,12 @@ static void vtd_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n)
      */
     vtd_address_space_unmap(vtd_as, n);
 
-    if (vtd_dev_to_context_entry(s, bus_n, vtd_as->devfn, &ce) == 0) {
+    if (vtd_dev_to_context_entry(s, bus_n, vtd_as->devfn, &ce[0]) == 0) {
         trace_vtd_replay_ce_valid(bus_n, PCI_SLOT(vtd_as->devfn),
                                   PCI_FUNC(vtd_as->devfn),
-                                  VTD_CONTEXT_ENTRY_DID(ce.hi),
-                                  ce.hi, ce.lo);
-        vtd_page_walk(&ce, 0, ~0ULL, vtd_replay_hook, (void *)n, false);
+                                  VTD_CONTEXT_ENTRY_DID(ce[0].hi),
+                                  ce[0].hi, ce[0].lo);
+        vtd_page_walk(&ce[0], 0, ~0ULL, vtd_replay_hook, (void *)n, false);
     } else {
         trace_vtd_replay_ce_invalid(bus_n, PCI_SLOT(vtd_as->devfn),
                                     PCI_FUNC(vtd_as->devfn));
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index ec1bd17..71a1c1e 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -425,6 +425,15 @@ typedef struct VTDRootEntry VTDRootEntry;
 
 #define VTD_CONTEXT_ENTRY_NR        (VTD_PAGE_SIZE / sizeof(VTDContextEntry))
 
+/* Definition for Extended Context */
+#define VTD_EXT_CONTEXT_ENTRY_RSVD_LOW0   (~(VTD_HAW_MASK))
+#define VTD_EXT_CONTEXT_ENTRY_RSVD_HIGH0  0xF0000000ULL
+#define VTD_EXT_CONTEXT_ENTRY_RSVD_LOW1   ((~(VTD_HAW_MASK)) | 0xFF0ULL)
+#define VTD_EXT_CONTEXT_ENTRY_RSVD_HIGH1  ((~(VTD_HAW_MASK)) | 0xFFFULL)
+#define VTD_EXT_CONTEXT_ENTRY_TT          (7ULL << 2)
+#define VTD_EXT_CONTEXT_TT_NO_DEV_IOTLB   (4ULL << 2)
+#define VTD_EXT_CONTEXT_TT_DEV_IOTLB      (5ULL << 2)
+
 /* Paging Structure common */
 #define VTD_SL_PT_PAGE_SIZE_MASK    (1ULL << 7)
 /* Bits to decide the offset for each level */
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index fa5963e..ae21fe5 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -76,7 +76,7 @@ struct VTDContextCacheEntry {
      * context_cache_gen!=IntelIOMMUState.context_cache_gen
      */
     uint32_t context_cache_gen;
-    struct VTDContextEntry context_entry;
+    struct VTDContextEntry context_entry[2];
 };
 
 struct VTDAddressSpace {
-- 
1.9.1
