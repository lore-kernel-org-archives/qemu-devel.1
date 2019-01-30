Received: from eggs.gnu.org ([209.51.188.92]:54333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.y.sun@linux.intel.com>) id 1goie5-0004IQ-DZ
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 00:42:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.y.sun@linux.intel.com>) id 1goie1-0005MI-JE
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 00:42:45 -0500
Received: from mga02.intel.com ([134.134.136.20]:63854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.y.sun@linux.intel.com>)
	id 1goidm-0005HB-7h
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 00:42:32 -0500
From: Yi Sun <yi.y.sun@linux.intel.com>
Date: Wed, 30 Jan 2019 13:09:11 +0800
Message-Id: <1548824953-23413-2-git-send-email-yi.y.sun@linux.intel.com>
In-Reply-To: <1548824953-23413-1-git-send-email-yi.y.sun@linux.intel.com>
References: <1548824953-23413-1-git-send-email-yi.y.sun@linux.intel.com>
Subject: [Qemu-devel] [RFC v1 1/3] intel_iommu: scalable mode emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, peterx@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com, Yi Sun <yi.y.sun@linux.intel.com>

From: "Liu, Yi L" <yi.l.liu@intel.com>

Intel(R) VT-d 3.0 spec introduces scalable mode address translation to
replace extended context mode. This patch extends current emulator to
support Scalable Mode which includes root table, context table and new
pasid table format change. Now intel_iommu emulates both legacy mode
and scalable mode (with legacy-equivalent capability set).

The key points are below:
1. Extend root table operations to support both legacy mode and scalable
   mode.
2. Extend context table operations to support both legacy mode and
   scalable mode.
3. Add pasid tabled operations to support scalable mode.

[Yi Sun is co-developer to contribute much to refine the whole commit.]
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
---
 hw/i386/intel_iommu.c          | 528 ++++++++++++++++++++++++++++++++++-------
 hw/i386/intel_iommu_internal.h |  43 +++-
 hw/i386/trace-events           |   2 +-
 include/hw/i386/intel_iommu.h  |  16 +-
 4 files changed, 498 insertions(+), 91 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 8b72735..396ac8e 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -37,6 +37,34 @@
 #include "kvm_i386.h"
 #include "trace.h"
 
+#define vtd_devfn_check(devfn) ((devfn & VTD_DEVFN_CHECK_MASK) ? true : false)
+
+/* context entry operations */
+#define vtd_get_ce_size(s, ce) \
+    (((s)->root_scalable) ? \
+     VTD_CTX_ENTRY_SM_SIZE : VTD_CTX_ENTRY_LECY_SIZE)
+#define vtd_ce_get_domain_id(ce) VTD_CONTEXT_ENTRY_DID((ce)->val[1])
+#define vtd_ce_get_rid2pasid(ce) \
+    ((ce)->val[1] & VTD_SM_CONTEXT_ENTRY_RID2PASID_MASK)
+#define vtd_ce_get_pasid_dir_table(ce) \
+    ((ce)->val[0] & VTD_PASID_DIR_BASE_ADDR_MASK)
+
+/* pasid operations */
+#define vtd_pdire_get_pasidt_base(pdire) \
+    ((pdire)->val & VTD_PASID_TABLE_BASE_ADDR_MASK)
+#define vtd_get_pasid_dir_entry_size() VTD_PASID_DIR_ENTRY_SIZE
+#define vtd_get_pasid_entry_size() VTD_PASID_ENTRY_SIZE
+#define vtd_get_pasid_dir_index(pasid) VTD_PASID_DIR_INDEX(pasid)
+#define vtd_get_pasid_table_index(pasid) VTD_PASID_TABLE_INDEX(pasid)
+
+/* pe operations */
+#define vtd_pe_get_type(pe) ((pe)->val[0] & VTD_SM_PASID_ENTRY_PGTT)
+#define vtd_pe_get_level(pe) (2 + (((pe)->val[0] >> 2) & VTD_SM_PASID_ENTRY_AW))
+#define vtd_pe_get_agaw(pe) \
+    (30 + (((pe)->val[0] >> 2) & VTD_SM_PASID_ENTRY_AW) * 9)
+#define vtd_pe_get_slpt_base(pe) ((pe)->val[0] & VTD_SM_PASID_ENTRY_SLPTPTR)
+#define vtd_pe_get_domain_id(pe) VTD_SM_PASID_ENTRY_DID((pe)->val[1])
+
 static void vtd_address_space_refresh_all(IntelIOMMUState *s);
 static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
 
@@ -512,9 +540,15 @@ static void vtd_generate_completion_event(IntelIOMMUState *s)
     }
 }
 
-static inline bool vtd_root_entry_present(VTDRootEntry *root)
+static inline bool vtd_root_entry_present(IntelIOMMUState *s,
+                                          VTDRootEntry *re,
+                                          uint8_t devfn)
 {
-    return root->val & VTD_ROOT_ENTRY_P;
+    if (s->root_scalable && vtd_devfn_check(devfn)) {
+        return re->hi & VTD_ROOT_ENTRY_P;
+    }
+
+    return re->lo & VTD_ROOT_ENTRY_P;
 }
 
 static int vtd_get_root_entry(IntelIOMMUState *s, uint8_t index,
@@ -524,36 +558,64 @@ static int vtd_get_root_entry(IntelIOMMUState *s, uint8_t index,
 
     addr = s->root + index * sizeof(*re);
     if (dma_memory_read(&address_space_memory, addr, re, sizeof(*re))) {
-        re->val = 0;
+        re->lo = 0;
         return -VTD_FR_ROOT_TABLE_INV;
     }
-    re->val = le64_to_cpu(re->val);
+    re->lo = le64_to_cpu(re->lo);
+    if (s->root_scalable) {
+        re->hi = le64_to_cpu(re->hi);
+    }
     return 0;
 }
 
-static inline bool vtd_ce_present(VTDContextEntry *context)
+static inline bool vtd_ce_present(VTDContextEntry *ce)
+{
+    return ce->val[0] & VTD_CONTEXT_ENTRY_P;
+}
+
+static inline dma_addr_t vtd_get_context_base(IntelIOMMUState *s,
+                                              VTDRootEntry *re,
+                                              uint8_t *index)
 {
-    return context->lo & VTD_CONTEXT_ENTRY_P;
+    if (s->root_scalable && vtd_devfn_check(*index)) {
+        *index = *index & (~VTD_DEVFN_CHECK_MASK);
+        return re->hi & VTD_ROOT_ENTRY_CTP;
+    }
+
+    return re->lo & VTD_ROOT_ENTRY_CTP;
 }
 
-static int vtd_get_context_entry_from_root(VTDRootEntry *root, uint8_t index,
+static void vtd_context_entry_format(IntelIOMMUState *s,
+                                     VTDContextEntry *ce)
+{
+    ce->val[0] = le64_to_cpu(ce->val[0]);
+    ce->val[1] = le64_to_cpu(ce->val[1]);
+    if (s->root_scalable) {
+        ce->val[2] = le64_to_cpu(ce->val[2]);
+        ce->val[3] = le64_to_cpu(ce->val[3]);
+    }
+}
+
+static int vtd_get_context_entry_from_root(IntelIOMMUState *s,
+                                           VTDRootEntry *re,
+                                           uint8_t index,
                                            VTDContextEntry *ce)
 {
-    dma_addr_t addr;
+    dma_addr_t addr, ce_size;
 
     /* we have checked that root entry is present */
-    addr = (root->val & VTD_ROOT_ENTRY_CTP) + index * sizeof(*ce);
-    if (dma_memory_read(&address_space_memory, addr, ce, sizeof(*ce))) {
+    ce_size = vtd_get_ce_size(s, ce);
+    addr = vtd_get_context_base(s, re, &index) + index * ce_size;
+    if (dma_memory_read(&address_space_memory, addr, ce, ce_size)) {
         return -VTD_FR_CONTEXT_TABLE_INV;
     }
-    ce->lo = le64_to_cpu(ce->lo);
-    ce->hi = le64_to_cpu(ce->hi);
+    vtd_context_entry_format(s, ce);
     return 0;
 }
 
 static inline dma_addr_t vtd_ce_get_slpt_base(VTDContextEntry *ce)
 {
-    return ce->lo & VTD_CONTEXT_ENTRY_SLPTPTR;
+    return ce->val[0] & VTD_CONTEXT_ENTRY_SLPTPTR;
 }
 
 static inline uint64_t vtd_get_slpte_addr(uint64_t slpte, uint8_t aw)
@@ -600,28 +662,203 @@ static inline bool vtd_is_level_supported(IntelIOMMUState *s, uint32_t level)
            (1ULL << (level - 2 + VTD_CAP_SAGAW_SHIFT));
 }
 
+/* Return true if check passed, otherwise false */
+static inline bool vtd_pe_type_check(X86IOMMUState *x86_iommu,
+                                     VTDPASIDEntry *pe)
+{
+    switch (vtd_pe_get_type(pe)) {
+    case VTD_SM_PASID_ENTRY_FLT:
+    case VTD_SM_PASID_ENTRY_SLT:
+    case VTD_SM_PASID_ENTRY_NESTED:
+        break;
+    case VTD_SM_PASID_ENTRY_PT:
+        if (!x86_iommu->pt_supported) {
+            return false;
+        }
+        break;
+    default:
+        /* Unknwon type */
+        return false;
+    }
+    return true;
+}
+
+static inline int vtd_get_pasid_dire(dma_addr_t pasid_dir_base,
+                                     uint32_t pasid,
+                                     VTDPASIDDirEntry *pdire)
+{
+    uint32_t index;
+    dma_addr_t addr, entry_size;
+
+    index = vtd_get_pasid_dir_index(pasid);
+    entry_size = vtd_get_pasid_dir_entry_size();
+    addr = pasid_dir_base + index * entry_size;
+    if (dma_memory_read(&address_space_memory, addr, pdire, entry_size)) {
+        return -VTD_FR_PASID_TABLE_INV;
+    }
+
+    return 0;
+}
+
+static inline int vtd_get_pasid_entry(IntelIOMMUState *s,
+                                      uint32_t pasid,
+                                      VTDPASIDDirEntry *pdire,
+                                      VTDPASIDEntry *pe)
+{
+    uint32_t index;
+    dma_addr_t addr, entry_size;
+    X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
+
+    index = vtd_get_pasid_table_index(pasid);
+    entry_size = vtd_get_pasid_entry_size();
+    addr = vtd_pdire_get_pasidt_base(pdire);
+    addr = addr + index * entry_size;
+    if (dma_memory_read(&address_space_memory, addr, pe, entry_size)) {
+        memset(pe->val, 0, sizeof(pe->val));
+        return -VTD_FR_PASID_TABLE_INV;
+    }
+
+    /* Do translation type check */
+    if (!vtd_pe_type_check(x86_iommu, pe)) {
+        return -VTD_FR_PASID_TABLE_INV;
+    }
+
+    if (!vtd_is_level_supported(s, vtd_pe_get_level(pe))) {
+        return -VTD_FR_PASID_TABLE_INV;
+    }
+
+    return 0;
+}
+
+static int vtd_get_pasid_entry_from_pasid(IntelIOMMUState *s,
+                                          dma_addr_t pasid_dir_base,
+                                          uint32_t pasid,
+                                          VTDPASIDEntry *pe)
+{
+    int ret;
+    VTDPASIDDirEntry pdire;
+
+    ret = vtd_get_pasid_dire(pasid_dir_base, pasid, &pdire);
+    if (ret) {
+        return ret;
+    }
+
+    ret = vtd_get_pasid_entry(s, pasid, &pdire, pe);
+    if (ret) {
+        return ret;
+    }
+
+    return ret;
+}
+
+static inline int vtd_ce_get_rid2pasid_entry(IntelIOMMUState *s,
+                                             VTDContextEntry *ce,
+                                             VTDPASIDEntry *pe)
+{
+    uint32_t pasid;
+    dma_addr_t pasid_dir_base;
+    int ret = 0;
+
+    pasid = vtd_ce_get_rid2pasid(ce);
+    pasid_dir_base = vtd_ce_get_pasid_dir_table(ce);
+    ret = vtd_get_pasid_entry_from_pasid(s, pasid_dir_base, pasid, pe);
+
+    return ret;
+}
+
+static inline int vtd_ce_get_pasid_fpd(IntelIOMMUState *s,
+                                       VTDContextEntry *ce,
+                                       bool *pe_fpd_set)
+{
+    int ret;
+    uint32_t pasid;
+    dma_addr_t pasid_dir_base;
+    VTDPASIDDirEntry pdire;
+    VTDPASIDEntry pe;
+
+    pasid = vtd_ce_get_rid2pasid(ce);
+    pasid_dir_base = vtd_ce_get_pasid_dir_table(ce);
+
+    ret = vtd_get_pasid_dire(pasid_dir_base, pasid, &pdire);
+    if (ret) {
+        return ret;
+    }
+
+    if (pdire.val & VTD_PASID_DIR_FPD) {
+        *pe_fpd_set = true;
+        return 0;
+    }
+
+    ret = vtd_get_pasid_entry(s, pasid, &pdire, &pe);
+    if (ret) {
+        return ret;
+    }
+
+    if (pe.val[0] & VTD_PASID_ENTRY_FPD) {
+        *pe_fpd_set = true;
+    }
+
+    return 0;
+}
+
 /* Get the page-table level that hardware should use for the second-level
  * page-table walk from the Address Width field of context-entry.
  */
 static inline uint32_t vtd_ce_get_level(VTDContextEntry *ce)
 {
-    return 2 + (ce->hi & VTD_CONTEXT_ENTRY_AW);
+    return 2 + (ce->val[1] & VTD_CONTEXT_ENTRY_AW);
+}
+
+static inline uint32_t vtd_get_iova_level(IntelIOMMUState *s,
+                                          VTDContextEntry *ce)
+{
+    VTDPASIDEntry pe;
+
+    if (s->root_scalable) {
+        vtd_ce_get_rid2pasid_entry(s, ce, &pe);
+        return vtd_pe_get_level(&pe);
+    }
+
+    return vtd_ce_get_level(ce);
 }
 
 static inline uint32_t vtd_ce_get_agaw(VTDContextEntry *ce)
 {
-    return 30 + (ce->hi & VTD_CONTEXT_ENTRY_AW) * 9;
+    return 30 + (ce->val[1] & VTD_CONTEXT_ENTRY_AW) * 9;
+}
+
+static inline uint32_t vtd_get_iova_agaw(IntelIOMMUState *s,
+                                         VTDContextEntry *ce)
+{
+    VTDPASIDEntry pe;
+
+    if (s->root_scalable) {
+        vtd_ce_get_rid2pasid_entry(s, ce, &pe);
+        return vtd_pe_get_agaw(&pe);
+    }
+
+    return vtd_ce_get_agaw(ce);
 }
 
 static inline uint32_t vtd_ce_get_type(VTDContextEntry *ce)
 {
-    return ce->lo & VTD_CONTEXT_ENTRY_TT;
+    return ce->val[0] & VTD_CONTEXT_ENTRY_TT;
 }
 
 /* Return true if check passed, otherwise false */
-static inline bool vtd_ce_type_check(X86IOMMUState *x86_iommu,
+static inline bool vtd_ce_type_check(IntelIOMMUState *s,
+                                     X86IOMMUState *x86_iommu,
                                      VTDContextEntry *ce)
 {
+    if (s->root_scalable) {
+        /*
+         * Translation Type locates in context entry only when VTD is in
+         * legacy mode. For scalable mode, need to return true to avoid
+         * unnecessary fault.
+         */
+        return true;
+    }
+
     switch (vtd_ce_get_type(ce)) {
     case VTD_CONTEXT_TT_MULTI_LEVEL:
         /* Always supported */
@@ -639,7 +876,7 @@ static inline bool vtd_ce_type_check(X86IOMMUState *x86_iommu,
         }
         break;
     default:
-        /* Unknwon type */
+        /* Unknown type */
         error_report_once("%s: unknown ce type: %"PRIu32, __func__,
                           vtd_ce_get_type(ce));
         return false;
@@ -647,21 +884,36 @@ static inline bool vtd_ce_type_check(X86IOMMUState *x86_iommu,
     return true;
 }
 
-static inline uint64_t vtd_iova_limit(VTDContextEntry *ce, uint8_t aw)
+static inline uint64_t vtd_iova_limit(IntelIOMMUState *s,
+                                      VTDContextEntry *ce, uint8_t aw)
 {
-    uint32_t ce_agaw = vtd_ce_get_agaw(ce);
+    uint32_t ce_agaw = vtd_get_iova_agaw(s, ce);
     return 1ULL << MIN(ce_agaw, aw);
 }
 
 /* Return true if IOVA passes range check, otherwise false. */
-static inline bool vtd_iova_range_check(uint64_t iova, VTDContextEntry *ce,
+static inline bool vtd_iova_range_check(IntelIOMMUState *s,
+                                        uint64_t iova, VTDContextEntry *ce,
                                         uint8_t aw)
 {
     /*
      * Check if @iova is above 2^X-1, where X is the minimum of MGAW
      * in CAP_REG and AW in context-entry.
      */
-    return !(iova & ~(vtd_iova_limit(ce, aw) - 1));
+    return !(iova & ~(vtd_iova_limit(s, ce, aw) - 1));
+}
+
+static inline dma_addr_t vtd_get_iova_pgtbl_base(IntelIOMMUState *s,
+                                                 VTDContextEntry *ce)
+{
+    VTDPASIDEntry pe;
+
+    if (s->root_scalable) {
+        vtd_ce_get_rid2pasid_entry(s, ce, &pe);
+        return vtd_pe_get_slpt_base(&pe);
+    }
+
+    return vtd_ce_get_slpt_base(ce);
 }
 
 /*
@@ -707,17 +959,18 @@ static VTDBus *vtd_find_as_from_bus_num(IntelIOMMUState *s, uint8_t bus_num)
 /* Given the @iova, get relevant @slptep. @slpte_level will be the last level
  * of the translation, can be used for deciding the size of large page.
  */
-static int vtd_iova_to_slpte(VTDContextEntry *ce, uint64_t iova, bool is_write,
+static int vtd_iova_to_slpte(IntelIOMMUState *s, VTDContextEntry *ce,
+                             uint64_t iova, bool is_write,
                              uint64_t *slptep, uint32_t *slpte_level,
                              bool *reads, bool *writes, uint8_t aw_bits)
 {
-    dma_addr_t addr = vtd_ce_get_slpt_base(ce);
-    uint32_t level = vtd_ce_get_level(ce);
+    dma_addr_t addr = vtd_get_iova_pgtbl_base(s, ce);
+    uint32_t level = vtd_get_iova_level(s, ce);
     uint32_t offset;
     uint64_t slpte;
     uint64_t access_right_check;
 
-    if (!vtd_iova_range_check(iova, ce, aw_bits)) {
+    if (!vtd_iova_range_check(s, iova, ce, aw_bits)) {
         error_report_once("%s: detected IOVA overflow (iova=0x%" PRIx64 ")",
                           __func__, iova);
         return -VTD_FR_ADDR_BEYOND_MGAW;
@@ -733,7 +986,7 @@ static int vtd_iova_to_slpte(VTDContextEntry *ce, uint64_t iova, bool is_write,
         if (slpte == (uint64_t)-1) {
             error_report_once("%s: detected read error on DMAR slpte "
                               "(iova=0x%" PRIx64 ")", __func__, iova);
-            if (level == vtd_ce_get_level(ce)) {
+            if (level == vtd_get_iova_level(s, ce)) {
                 /* Invalid programming of context-entry */
                 return -VTD_FR_CONTEXT_ENTRY_INV;
             } else {
@@ -962,29 +1215,96 @@ next:
 /**
  * vtd_page_walk - walk specific IOVA range, and call the hook
  *
+ * @s: intel iommu state
  * @ce: context entry to walk upon
  * @start: IOVA address to start the walk
  * @end: IOVA range end address (start <= addr < end)
  * @info: page walking information struct
  */
-static int vtd_page_walk(VTDContextEntry *ce, uint64_t start, uint64_t end,
+static int vtd_page_walk(IntelIOMMUState *s, VTDContextEntry *ce,
+                         uint64_t start, uint64_t end,
                          vtd_page_walk_info *info)
 {
-    dma_addr_t addr = vtd_ce_get_slpt_base(ce);
-    uint32_t level = vtd_ce_get_level(ce);
+    dma_addr_t addr = vtd_get_iova_pgtbl_base(s, ce);
+    uint32_t level = vtd_get_iova_level(s, ce);
 
-    if (!vtd_iova_range_check(start, ce, info->aw)) {
+    if (!vtd_iova_range_check(s, start, ce, info->aw)) {
         return -VTD_FR_ADDR_BEYOND_MGAW;
     }
 
-    if (!vtd_iova_range_check(end, ce, info->aw)) {
+    if (!vtd_iova_range_check(s, end, ce, info->aw)) {
         /* Fix end so that it reaches the maximum */
-        end = vtd_iova_limit(ce, info->aw);
+        end = vtd_iova_limit(s, ce, info->aw);
     }
 
     return vtd_page_walk_level(addr, start, end, level, true, true, info);
 }
 
+static int vtd_root_entry_rsvd_bits_check(IntelIOMMUState *s,
+                                          VTDRootEntry *re)
+{
+    /* Legacy Mode reserved bits check */
+    if (!s->root_scalable &&
+        (re->hi || (re->lo & VTD_ROOT_ENTRY_RSVD(s->aw_bits))))
+        goto rsvd_err;
+
+    /* Scalable Mode reserved bits check */
+    if (s->root_scalable &&
+        ((re->lo & VTD_ROOT_ENTRY_RSVD(s->aw_bits)) ||
+         (re->hi & VTD_ROOT_ENTRY_RSVD(s->aw_bits))))
+        goto rsvd_err;
+
+    return 0;
+
+rsvd_err:
+    error_report_once("%s: invalid root entry: hi=0x%"PRIx64
+                      ", lo=0x%"PRIx64,
+                      __func__, re->hi, re->lo);
+    return -VTD_FR_ROOT_ENTRY_RSVD;
+}
+
+static inline int vtd_context_entry_rsvd_bits_check(IntelIOMMUState *s,
+                                                    VTDContextEntry *ce)
+{
+    if (!s->root_scalable &&
+        (ce->val[1] & VTD_CONTEXT_ENTRY_RSVD_HI ||
+         ce->val[0] & VTD_CONTEXT_ENTRY_RSVD_LO(s->aw_bits))) {
+        error_report_once("%s: invalid context entry: hi=%"PRIx64
+                          ", lo=%"PRIx64" (reserved nonzero)",
+                          __func__, ce->val[1], ce->val[0]);
+        return -VTD_FR_CONTEXT_ENTRY_RSVD;
+    }
+
+    if (s->root_scalable &&
+        (ce->val[0] & VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(s->aw_bits) ||
+         ce->val[1] & VTD_SM_CONTEXT_ENTRY_RSVD_VAL1 ||
+         ce->val[2] ||
+         ce->val[3])) {
+        error_report_once("%s: invalid context entry: val[3]=%"PRIx64
+                          ", val[2]=%"PRIx64
+                          ", val[1]=%"PRIx64
+                          ", val[0]=%"PRIx64" (reserved nonzero)",
+                          __func__, ce->val[3], ce->val[2],
+                          ce->val[1], ce->val[0]);
+        return -VTD_FR_CONTEXT_ENTRY_RSVD;
+    }
+
+    return 0;
+}
+
+static inline int vtd_ce_rid2pasid_check(IntelIOMMUState *s,
+                                         VTDContextEntry *ce)
+{
+    VTDPASIDEntry pe;
+
+    /*
+     * Make sure in Scalable Mode, a present context entry
+     * has valid rid2pasid setting, which includes valid
+     * rid2pasid field and corresponding pasid entry setting
+     */
+    return vtd_ce_get_rid2pasid_entry(s, ce, &pe);
+}
+
 /* Map a device to its corresponding domain (context-entry) */
 static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
                                     uint8_t devfn, VTDContextEntry *ce)
@@ -998,20 +1318,18 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
         return ret_fr;
     }
 
-    if (!vtd_root_entry_present(&re)) {
+    if (!vtd_root_entry_present(s, &re, devfn)) {
         /* Not error - it's okay we don't have root entry. */
         trace_vtd_re_not_present(bus_num);
         return -VTD_FR_ROOT_ENTRY_P;
     }
 
-    if (re.rsvd || (re.val & VTD_ROOT_ENTRY_RSVD(s->aw_bits))) {
-        error_report_once("%s: invalid root entry: rsvd=0x%"PRIx64
-                          ", val=0x%"PRIx64" (reserved nonzero)",
-                          __func__, re.rsvd, re.val);
-        return -VTD_FR_ROOT_ENTRY_RSVD;
+    ret_fr = vtd_root_entry_rsvd_bits_check(s, &re);
+    if (ret_fr) {
+        return ret_fr;
     }
 
-    ret_fr = vtd_get_context_entry_from_root(&re, devfn, ce);
+    ret_fr = vtd_get_context_entry_from_root(s, &re, devfn, ce);
     if (ret_fr) {
         return ret_fr;
     }
@@ -1022,28 +1340,40 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
         return -VTD_FR_CONTEXT_ENTRY_P;
     }
 
-    if ((ce->hi & VTD_CONTEXT_ENTRY_RSVD_HI) ||
-               (ce->lo & VTD_CONTEXT_ENTRY_RSVD_LO(s->aw_bits))) {
-        error_report_once("%s: invalid context entry: hi=%"PRIx64
-                          ", lo=%"PRIx64" (reserved nonzero)",
-                          __func__, ce->hi, ce->lo);
-        return -VTD_FR_CONTEXT_ENTRY_RSVD;
+    ret_fr = vtd_context_entry_rsvd_bits_check(s, ce);
+    if (ret_fr) {
+        return ret_fr;
     }
 
     /* Check if the programming of context-entry is valid */
-    if (!vtd_is_level_supported(s, vtd_ce_get_level(ce))) {
+    if (!s->root_scalable &&
+        !vtd_is_level_supported(s, vtd_ce_get_level(ce))) {
         error_report_once("%s: invalid context entry: hi=%"PRIx64
                           ", lo=%"PRIx64" (level %d not supported)",
-                          __func__, ce->hi, ce->lo, vtd_ce_get_level(ce));
+                          __func__, ce->val[1], ce->val[0],
+                          vtd_ce_get_level(ce));
         return -VTD_FR_CONTEXT_ENTRY_INV;
     }
 
     /* Do translation type check */
-    if (!vtd_ce_type_check(x86_iommu, ce)) {
+    if (!vtd_ce_type_check(s, x86_iommu, ce)) {
         /* Errors dumped in vtd_ce_type_check() */
         return -VTD_FR_CONTEXT_ENTRY_INV;
     }
 
+    /*
+     * Check if the programming of context-entry.rid2pasid
+     * and corresponding pasid setting is valid, and thus
+     * avoids to check pasid entry fetching result in future
+     * helper function calling.
+     */
+    if (s->root_scalable) {
+        ret_fr = vtd_ce_rid2pasid_check(s, ce);
+        if (ret_fr) {
+            return ret_fr;
+        }
+    }
+
     return 0;
 }
 
@@ -1065,10 +1395,10 @@ static int vtd_sync_shadow_page_table_range(VTDAddressSpace *vtd_as,
         .notify_unmap = true,
         .aw = s->aw_bits,
         .as = vtd_as,
-        .domain_id = VTD_CONTEXT_ENTRY_DID(ce->hi),
+        .domain_id = VTD_CONTEXT_ENTRY_DID(ce->val[1]),
     };
 
-    return vtd_page_walk(ce, addr, addr + size, &info);
+    return vtd_page_walk(s, ce, addr, addr + size, &info);
 }
 
 static int vtd_sync_shadow_page_table(VTDAddressSpace *vtd_as)
@@ -1103,35 +1433,24 @@ static int vtd_sync_shadow_page_table(VTDAddressSpace *vtd_as)
 }
 
 /*
- * Fetch translation type for specific device. Returns <0 if error
- * happens, otherwise return the shifted type to check against
- * VTD_CONTEXT_TT_*.
+ * Check if specific device is configed to bypass address
+ * translation for DMA requests. In Scalable Mode, bypass
+ * 1st-level translation or 2nd-level translation, it depends
+ * on PGTT setting.
  */
-static int vtd_dev_get_trans_type(VTDAddressSpace *as)
+static bool vtd_dev_pt_enabled(VTDAddressSpace *as)
 {
     IntelIOMMUState *s;
     VTDContextEntry ce;
+    VTDPASIDEntry pe;
     int ret;
 
-    s = as->iommu_state;
+    assert(as);
 
+    s = as->iommu_state;
     ret = vtd_dev_to_context_entry(s, pci_bus_num(as->bus),
                                    as->devfn, &ce);
     if (ret) {
-        return ret;
-    }
-
-    return vtd_ce_get_type(&ce);
-}
-
-static bool vtd_dev_pt_enabled(VTDAddressSpace *as)
-{
-    int ret;
-
-    assert(as);
-
-    ret = vtd_dev_get_trans_type(as);
-    if (ret < 0) {
         /*
          * Possibly failed to parse the context entry for some reason
          * (e.g., during init, or any guest configuration errors on
@@ -1141,7 +1460,25 @@ static bool vtd_dev_pt_enabled(VTDAddressSpace *as)
         return false;
     }
 
-    return ret == VTD_CONTEXT_TT_PASS_THROUGH;
+    if (s->root_scalable) {
+        vtd_ce_get_rid2pasid_entry(s, &ce, &pe);
+        return (vtd_pe_get_type(&pe) == VTD_SM_PASID_ENTRY_PT);
+    }
+
+    return (vtd_ce_get_type(&ce) == VTD_CONTEXT_TT_PASS_THROUGH);
+}
+
+static inline uint16_t vtd_get_domain_id(IntelIOMMUState *s,
+                                         VTDContextEntry *ce)
+{
+    VTDPASIDEntry pe;
+
+    if (s->root_scalable) {
+        vtd_ce_get_rid2pasid_entry(s, ce, &pe);
+        return vtd_pe_get_domain_id(&pe);
+    }
+
+    return vtd_ce_get_domain_id(ce);
 }
 
 /* Return whether the device is using IOMMU translation. */
@@ -1317,14 +1654,29 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
 
     /* Try to fetch context-entry from cache first */
     if (cc_entry->context_cache_gen == s->context_cache_gen) {
-        trace_vtd_iotlb_cc_hit(bus_num, devfn, cc_entry->context_entry.hi,
-                               cc_entry->context_entry.lo,
+        trace_vtd_iotlb_cc_hit(bus_num, devfn, cc_entry->context_entry.val[1],
+                               cc_entry->context_entry.val[0],
                                cc_entry->context_cache_gen);
         ce = cc_entry->context_entry;
-        is_fpd_set = ce.lo & VTD_CONTEXT_ENTRY_FPD;
+        is_fpd_set = ce.val[0] & VTD_CONTEXT_ENTRY_FPD;
+        if (s->root_scalable) {
+            ret_fr = vtd_ce_get_pasid_fpd(s, &ce, &is_fpd_set);
+            if (ret_fr) {
+                ret_fr = -ret_fr;
+                if (is_fpd_set && vtd_is_qualified_fault(ret_fr)) {
+                    trace_vtd_fault_disabled();
+                } else {
+                    vtd_report_dmar_fault(s, source_id, addr, ret_fr, is_write);
+                }
+                goto error;
+            }
+        }
     } else {
         ret_fr = vtd_dev_to_context_entry(s, bus_num, devfn, &ce);
-        is_fpd_set = ce.lo & VTD_CONTEXT_ENTRY_FPD;
+        is_fpd_set = ce.val[0] & VTD_CONTEXT_ENTRY_FPD;
+        if (!ret_fr && s->root_scalable) {
+            ret_fr = vtd_ce_get_pasid_fpd(s, &ce, &is_fpd_set);
+        }
         if (ret_fr) {
             ret_fr = -ret_fr;
             if (is_fpd_set && vtd_is_qualified_fault(ret_fr)) {
@@ -1335,7 +1687,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
             goto error;
         }
         /* Update context-cache */
-        trace_vtd_iotlb_cc_update(bus_num, devfn, ce.hi, ce.lo,
+        trace_vtd_iotlb_cc_update(bus_num, devfn, ce.val[1], ce.val[0],
                                   cc_entry->context_cache_gen,
                                   s->context_cache_gen);
         cc_entry->context_entry = ce;
@@ -1367,7 +1719,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
         return true;
     }
 
-    ret_fr = vtd_iova_to_slpte(&ce, addr, is_write, &slpte, &level,
+    ret_fr = vtd_iova_to_slpte(s, &ce, addr, is_write, &slpte, &level,
                                &reads, &writes, s->aw_bits);
     if (ret_fr) {
         ret_fr = -ret_fr;
@@ -1381,7 +1733,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
 
     page_mask = vtd_slpt_level_page_mask(level);
     access_flags = IOMMU_ACCESS_FLAG(reads, writes);
-    vtd_update_iotlb(s, source_id, VTD_CONTEXT_ENTRY_DID(ce.hi), addr, slpte,
+    vtd_update_iotlb(s, source_id, vtd_get_domain_id(s, &ce), addr, slpte,
                      access_flags, level);
 out:
     vtd_iommu_unlock(s);
@@ -1404,6 +1756,7 @@ static void vtd_root_table_setup(IntelIOMMUState *s)
 {
     s->root = vtd_get_quad_raw(s, DMAR_RTADDR_REG);
     s->root_extended = s->root & VTD_RTADDR_RTT;
+    s->root_scalable = s->root & VTD_RTADDR_SMT;
     s->root &= VTD_RTADDR_ADDR_MASK(s->aw_bits);
 
     trace_vtd_reg_dmar_root(s->root, s->root_extended);
@@ -1573,7 +1926,7 @@ static void vtd_iotlb_domain_invalidate(IntelIOMMUState *s, uint16_t domain_id)
     QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
         if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
                                       vtd_as->devfn, &ce) &&
-            domain_id == VTD_CONTEXT_ENTRY_DID(ce.hi)) {
+            domain_id == vtd_get_domain_id(s, &ce)) {
             vtd_sync_shadow_page_table(vtd_as);
         }
     }
@@ -1591,7 +1944,7 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
     QLIST_FOREACH(vtd_as, &(s->vtd_as_with_notifiers), next) {
         ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
                                        vtd_as->devfn, &ce);
-        if (!ret && domain_id == VTD_CONTEXT_ENTRY_DID(ce.hi)) {
+        if (!ret && domain_id == vtd_get_domain_id(s, &ce)) {
             if (vtd_as_has_map_notifier(vtd_as)) {
                 /*
                  * As long as we have MAP notifications registered in
@@ -2629,6 +2982,7 @@ static const VMStateDescription vtd_vmstate = {
         VMSTATE_UINT8_ARRAY(csr, IntelIOMMUState, DMAR_REG_SIZE),
         VMSTATE_UINT8(iq_last_desc_type, IntelIOMMUState),
         VMSTATE_BOOL(root_extended, IntelIOMMUState),
+        VMSTATE_BOOL(root_scalable, IntelIOMMUState),
         VMSTATE_BOOL(dmar_enabled, IntelIOMMUState),
         VMSTATE_BOOL(qi_enabled, IntelIOMMUState),
         VMSTATE_BOOL(intr_enabled, IntelIOMMUState),
@@ -3098,10 +3452,11 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
     vtd_address_space_unmap(vtd_as, n);
 
     if (vtd_dev_to_context_entry(s, bus_n, vtd_as->devfn, &ce) == 0) {
-        trace_vtd_replay_ce_valid(bus_n, PCI_SLOT(vtd_as->devfn),
+        trace_vtd_replay_ce_valid(s->root_scalable ? "scalable mode" : "",
+                                  bus_n, PCI_SLOT(vtd_as->devfn),
                                   PCI_FUNC(vtd_as->devfn),
-                                  VTD_CONTEXT_ENTRY_DID(ce.hi),
-                                  ce.hi, ce.lo);
+                                  vtd_get_domain_id(s, &ce),
+                                  ce.val[1], ce.val[0]);
         if (vtd_as_has_map_notifier(vtd_as)) {
             /* This is required only for MAP typed notifiers */
             vtd_page_walk_info info = {
@@ -3110,10 +3465,10 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
                 .notify_unmap = false,
                 .aw = s->aw_bits,
                 .as = vtd_as,
-                .domain_id = VTD_CONTEXT_ENTRY_DID(ce.hi),
+                .domain_id = VTD_CONTEXT_ENTRY_DID(ce.val[1]),
             };
 
-            vtd_page_walk(&ce, 0, ~0ULL, &info);
+            vtd_page_walk(s, &ce, 0, ~0ULL, &info);
         }
     } else {
         trace_vtd_replay_ce_invalid(bus_n, PCI_SLOT(vtd_as->devfn),
@@ -3137,6 +3492,7 @@ static void vtd_init(IntelIOMMUState *s)
 
     s->root = 0;
     s->root_extended = false;
+    s->root_scalable = false;
     s->dmar_enabled = false;
     s->iq_head = 0;
     s->iq_tail = 0;
@@ -3198,7 +3554,7 @@ static void vtd_init(IntelIOMMUState *s)
     vtd_define_long(s, DMAR_GCMD_REG, 0, 0xff800000UL, 0);
     vtd_define_long_wo(s, DMAR_GCMD_REG, 0xff800000UL);
     vtd_define_long(s, DMAR_GSTS_REG, 0, 0, 0);
-    vtd_define_quad(s, DMAR_RTADDR_REG, 0, 0xfffffffffffff000ULL, 0);
+    vtd_define_quad(s, DMAR_RTADDR_REG, 0, 0xfffffffffffffc00ULL, 0);
     vtd_define_quad(s, DMAR_CCMD_REG, 0, 0xe0000003ffffffffULL, 0);
     vtd_define_quad_wo(s, DMAR_CCMD_REG, 0x3ffff0000ULL);
 
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 00e9edb..02674f9 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -172,6 +172,7 @@
 
 /* RTADDR_REG */
 #define VTD_RTADDR_RTT              (1ULL << 11)
+#define VTD_RTADDR_SMT              (1ULL << 10)
 #define VTD_RTADDR_ADDR_MASK(aw)    (VTD_HAW_MASK(aw) ^ 0xfffULL)
 
 /* IRTA_REG */
@@ -294,6 +295,8 @@ typedef enum VTDFaultReason {
                                   * request while disabled */
     VTD_FR_IR_SID_ERR = 0x26,   /* Invalid Source-ID */
 
+    VTD_FR_PASID_TABLE_INV = 0x58,
+
     /* This is not a normal fault reason. We use this to indicate some faults
      * that are not referenced by the VT-d specification.
      * Fault event with such reason should not be recorded.
@@ -411,8 +414,8 @@ typedef struct VTDIOTLBPageInvInfo VTDIOTLBPageInvInfo;
 #define VTD_PAGE_MASK_1G            (~((1ULL << VTD_PAGE_SHIFT_1G) - 1))
 
 struct VTDRootEntry {
-    uint64_t val;
-    uint64_t rsvd;
+    uint64_t lo;
+    uint64_t hi;
 };
 typedef struct VTDRootEntry VTDRootEntry;
 
@@ -423,6 +426,10 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_ROOT_ENTRY_NR           (VTD_PAGE_SIZE / sizeof(VTDRootEntry))
 #define VTD_ROOT_ENTRY_RSVD(aw)     (0xffeULL | ~VTD_HAW_MASK(aw))
 
+#define VTD_ROOT_ENTRY_SIZE         16
+
+#define VTD_DEVFN_CHECK_MASK        0x80
+
 /* Masks for struct VTDContextEntry */
 /* lo */
 #define VTD_CONTEXT_ENTRY_P         (1ULL << 0)
@@ -441,6 +448,38 @@ typedef struct VTDRootEntry VTDRootEntry;
 
 #define VTD_CONTEXT_ENTRY_NR        (VTD_PAGE_SIZE / sizeof(VTDContextEntry))
 
+#define VTD_CTX_ENTRY_LECY_SIZE     16
+#define VTD_CTX_ENTRY_SM_SIZE       32
+
+#define VTD_SM_CONTEXT_ENTRY_RID2PASID_MASK 0xfffff
+#define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL | ~VTD_HAW_MASK(aw))
+#define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
+
+/* PASID Table Related Definitions */
+#define VTD_PASID_DIR_BASE_ADDR_MASK  (~0xfffULL)
+#define VTD_PASID_TABLE_BASE_ADDR_MASK (~0xfffULL)
+#define VTD_PASID_DIR_ENTRY_SIZE      8
+#define VTD_PASID_ENTRY_SIZE          64
+#define VTD_PASID_DIR_BITS_MASK       (0x3fffULL)
+#define VTD_PASID_DIR_INDEX(pasid)    (((pasid) >> 6) & VTD_PASID_DIR_BITS_MASK)
+#define VTD_PASID_DIR_FPD             (1ULL << 1) /* Fault Processing Disable */
+#define VTD_PASID_TABLE_BITS_MASK     (0x3fULL)
+#define VTD_PASID_TABLE_INDEX(pasid)  ((pasid) & VTD_PASID_TABLE_BITS_MASK)
+#define VTD_PASID_ENTRY_FPD           (1ULL << 1) /* Fault Processing Disable */
+
+/* PASID Granular Translation Type Mask */
+#define VTD_SM_PASID_ENTRY_PGTT        (7ULL << 6)
+#define VTD_SM_PASID_ENTRY_FLT         (1ULL << 6)
+#define VTD_SM_PASID_ENTRY_SLT         (2ULL << 6)
+#define VTD_SM_PASID_ENTRY_NESTED      (3ULL << 6)
+#define VTD_SM_PASID_ENTRY_PT          (4ULL << 6)
+
+#define VTD_SM_PASID_ENTRY_AW          7ULL /* Adjusted guest-address-width */
+#define VTD_SM_PASID_ENTRY_DID(val)    ((val) & VTD_DOMAIN_ID_MASK)
+
+/* Second Level Page Translation Pointer*/
+#define VTD_SM_PASID_ENTRY_SLPTPTR     (~0xfffULL)
+
 /* Paging Structure common */
 #define VTD_SL_PT_PAGE_SIZE_MASK    (1ULL << 7)
 /* Bits to decide the offset for each level */
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 77244fc..cae1b76 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -30,7 +30,7 @@ vtd_iotlb_cc_hit(uint8_t bus, uint8_t devfn, uint64_t high, uint64_t low, uint32
 vtd_iotlb_cc_update(uint8_t bus, uint8_t devfn, uint64_t high, uint64_t low, uint32_t gen1, uint32_t gen2) "IOTLB context update bus 0x%"PRIx8" devfn 0x%"PRIx8" high 0x%"PRIx64" low 0x%"PRIx64" gen %"PRIu32" -> gen %"PRIu32
 vtd_iotlb_reset(const char *reason) "IOTLB reset (reason: %s)"
 vtd_fault_disabled(void) "Fault processing disabled for context entry"
-vtd_replay_ce_valid(uint8_t bus, uint8_t dev, uint8_t fn, uint16_t domain, uint64_t hi, uint64_t lo) "replay valid context device %02"PRIx8":%02"PRIx8".%02"PRIx8" domain 0x%"PRIx16" hi 0x%"PRIx64" lo 0x%"PRIx64
+vtd_replay_ce_valid(const char *mode, uint8_t bus, uint8_t dev, uint8_t fn, uint16_t domain, uint64_t hi, uint64_t lo) "%s: replay valid context device %02"PRIx8":%02"PRIx8".%02"PRIx8" domain 0x%"PRIx16" hi 0x%"PRIx64" lo 0x%"PRIx64
 vtd_replay_ce_invalid(uint8_t bus, uint8_t dev, uint8_t fn) "replay invalid context device %02"PRIx8":%02"PRIx8".%02"PRIx8
 vtd_page_walk_level(uint64_t addr, uint32_t level, uint64_t start, uint64_t end) "walk (base=0x%"PRIx64", level=%"PRIu32") iova range 0x%"PRIx64" - 0x%"PRIx64
 vtd_page_walk_one(uint16_t domain, uint64_t iova, uint64_t gpa, uint64_t mask, int perm) "domain 0x%"PRIu16" iova 0x%"PRIx64" -> gpa 0x%"PRIx64" mask 0x%"PRIx64" perm %d"
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index a321cc9..ff13ff27 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -66,11 +66,12 @@ typedef struct VTDIOTLBEntry VTDIOTLBEntry;
 typedef struct VTDBus VTDBus;
 typedef union VTD_IR_TableEntry VTD_IR_TableEntry;
 typedef union VTD_IR_MSIAddress VTD_IR_MSIAddress;
+typedef struct VTDPASIDDirEntry VTDPASIDDirEntry;
+typedef struct VTDPASIDEntry VTDPASIDEntry;
 
 /* Context-Entry */
 struct VTDContextEntry {
-    uint64_t lo;
-    uint64_t hi;
+    uint64_t val[4];
 };
 
 struct VTDContextCacheEntry {
@@ -81,6 +82,16 @@ struct VTDContextCacheEntry {
     struct VTDContextEntry context_entry;
 };
 
+/* PASID Directory Entry */
+struct VTDPASIDDirEntry {
+    uint64_t val;
+};
+
+/* PASID Table Entry */
+struct VTDPASIDEntry {
+    uint64_t val[8];
+};
+
 struct VTDAddressSpace {
     PCIBus *bus;
     uint8_t devfn;
@@ -212,6 +223,7 @@ struct IntelIOMMUState {
 
     dma_addr_t root;                /* Current root table pointer */
     bool root_extended;             /* Type of root table (extended or not) */
+    bool root_scalable;             /* Type of root table (scalable or not) */
     bool dmar_enabled;              /* Set if DMA remapping is enabled */
 
     uint16_t iq_head;               /* Current invalidation queue head */
-- 
1.9.1
