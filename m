Received: from eggs.gnu.org ([2001:4830:134:3::10]:51651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cRsDB-00024C-P3
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 22:07:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cRsDA-0007Qo-1L
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 22:07:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52420)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cRsD9-0007PK-OT
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 22:07:27 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri, 13 Jan 2017 11:06:31 +0800
Message-Id: <1484276800-26814-6-git-send-email-peterx@redhat.com>
In-Reply-To: <1484276800-26814-1-git-send-email-peterx@redhat.com>
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH RFC v3 05/14] intel_iommu: fix trace for addr
 translation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, peterx@redhat.com, alex.williamson@redhat.com, bd.aviv@gmail.com

Another patch to convert the DPRINTF() stuffs. This patch focuses on the
address translation path and caching.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 84 +++++++++++++++++++++++++--------------------------
 hw/i386/trace-events  |  7 +++++
 2 files changed, 48 insertions(+), 43 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 459e575..b4166e0 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -260,11 +260,9 @@ static void vtd_update_iotlb(IntelIOMMUState *s, uint16_t source_id,
     uint64_t *key = g_malloc(sizeof(*key));
     uint64_t gfn = vtd_get_iotlb_gfn(addr, level);
 
-    VTD_DPRINTF(CACHE, "update iotlb sid 0x%"PRIx16 " iova 0x%"PRIx64
-                " slpte 0x%"PRIx64 " did 0x%"PRIx16, source_id, addr, slpte,
-                domain_id);
+    trace_vtd_iotlb_page_update(source_id, addr, slpte, domain_id);
     if (g_hash_table_size(s->iotlb) >= VTD_IOTLB_MAX_SIZE) {
-        VTD_DPRINTF(CACHE, "iotlb exceeds size limit, forced to reset");
+        trace_vtd_iotlb_reset("iotlb exceeds size limit");
         vtd_reset_iotlb(s);
     }
 
@@ -505,8 +503,8 @@ static int vtd_get_root_entry(IntelIOMMUState *s, uint8_t index,
 
     addr = s->root + index * sizeof(*re);
     if (dma_memory_read(&address_space_memory, addr, re, sizeof(*re))) {
-        VTD_DPRINTF(GENERAL, "error: fail to access root-entry at 0x%"PRIx64
-                    " + %"PRIu8, s->root, index);
+        error_report("Fail to access root-entry at 0x%"PRIx64
+                     " index %"PRIu8, s->root, index);
         re->val = 0;
         return -VTD_FR_ROOT_TABLE_INV;
     }
@@ -525,13 +523,12 @@ static int vtd_get_context_entry_from_root(VTDRootEntry *root, uint8_t index,
     dma_addr_t addr;
 
     if (!vtd_root_entry_present(root)) {
-        VTD_DPRINTF(GENERAL, "error: root-entry is not present");
+        error_report("Root-entry is not present");
         return -VTD_FR_ROOT_ENTRY_P;
     }
     addr = (root->val & VTD_ROOT_ENTRY_CTP) + index * sizeof(*ce);
     if (dma_memory_read(&address_space_memory, addr, ce, sizeof(*ce))) {
-        VTD_DPRINTF(GENERAL, "error: fail to access context-entry at 0x%"PRIx64
-                    " + %"PRIu8,
+        error_report("Fail to access context-entry at 0x%"PRIx64" ind %"PRIu8,
                     (uint64_t)(root->val & VTD_ROOT_ENTRY_CTP), index);
         return -VTD_FR_CONTEXT_TABLE_INV;
     }
@@ -644,7 +641,7 @@ static int vtd_gpa_to_slpte(VTDContextEntry *ce, uint64_t iova, bool is_write,
      * in CAP_REG and AW in context-entry.
      */
     if (iova & ~((1ULL << MIN(ce_agaw, VTD_MGAW)) - 1)) {
-        VTD_DPRINTF(GENERAL, "error: iova 0x%"PRIx64 " exceeds limits", iova);
+        error_report("IOVA 0x%"PRIx64 " exceeds limits", iova);
         return -VTD_FR_ADDR_BEYOND_MGAW;
     }
 
@@ -656,7 +653,7 @@ static int vtd_gpa_to_slpte(VTDContextEntry *ce, uint64_t iova, bool is_write,
         slpte = vtd_get_slpte(addr, offset);
 
         if (slpte == (uint64_t)-1) {
-            VTD_DPRINTF(GENERAL, "error: fail to access second-level paging "
+            error_report("Fail to access second-level paging "
                         "entry at level %"PRIu32 " for iova 0x%"PRIx64,
                         level, iova);
             if (level == vtd_get_level_from_context_entry(ce)) {
@@ -669,13 +666,13 @@ static int vtd_gpa_to_slpte(VTDContextEntry *ce, uint64_t iova, bool is_write,
         *reads = (*reads) && (slpte & VTD_SL_R);
         *writes = (*writes) && (slpte & VTD_SL_W);
         if (!(slpte & access_right_check)) {
-            VTD_DPRINTF(GENERAL, "error: lack of %s permission for "
-                        "iova 0x%"PRIx64 " slpte 0x%"PRIx64,
-                        (is_write ? "write" : "read"), iova, slpte);
+            error_report("Lack of %s permission for iova 0x%"PRIx64
+                         " slpte 0x%"PRIx64,
+                         (is_write ? "write" : "read"), iova, slpte);
             return is_write ? -VTD_FR_WRITE : -VTD_FR_READ;
         }
         if (vtd_slpte_nonzero_rsvd(slpte, level)) {
-            VTD_DPRINTF(GENERAL, "error: non-zero reserved field in second "
+            error_report("Non-zero reserved field in second "
                         "level paging entry level %"PRIu32 " slpte 0x%"PRIx64,
                         level, slpte);
             return -VTD_FR_PAGING_ENTRY_RSVD;
@@ -704,12 +701,13 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
     }
 
     if (!vtd_root_entry_present(&re)) {
-        VTD_DPRINTF(GENERAL, "error: root-entry #%"PRIu8 " is not present",
-                    bus_num);
+        /* Not error - it's okay we don't have root entry. */
+        trace_vtd_re_not_present(bus_num);
         return -VTD_FR_ROOT_ENTRY_P;
     } else if (re.rsvd || (re.val & VTD_ROOT_ENTRY_RSVD)) {
-        VTD_DPRINTF(GENERAL, "error: non-zero reserved field in root-entry "
-                    "hi 0x%"PRIx64 " lo 0x%"PRIx64, re.rsvd, re.val);
+        error_report("Non-zero reserved field in root-entry bus_num %d "
+                     "hi 0x%"PRIx64 " lo 0x%"PRIx64,
+                     bus_num, re.rsvd, re.val);
         return -VTD_FR_ROOT_ENTRY_RSVD;
     }
 
@@ -719,22 +717,20 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
     }
 
     if (!vtd_context_entry_present(ce)) {
-        VTD_DPRINTF(GENERAL,
-                    "error: context-entry #%"PRIu8 "(bus #%"PRIu8 ") "
-                    "is not present", devfn, bus_num);
+        /* Not error - it's okay we don't have context entry. */
+        trace_vtd_ce_not_present(bus_num, devfn);
         return -VTD_FR_CONTEXT_ENTRY_P;
     } else if ((ce->hi & VTD_CONTEXT_ENTRY_RSVD_HI) ||
                (ce->lo & VTD_CONTEXT_ENTRY_RSVD_LO)) {
-        VTD_DPRINTF(GENERAL,
-                    "error: non-zero reserved field in context-entry "
+        error_report("Non-zero reserved field in context-entry"
                     "hi 0x%"PRIx64 " lo 0x%"PRIx64, ce->hi, ce->lo);
         return -VTD_FR_CONTEXT_ENTRY_RSVD;
     }
     /* Check if the programming of context-entry is valid */
     if (!vtd_is_level_supported(s, vtd_get_level_from_context_entry(ce))) {
-        VTD_DPRINTF(GENERAL, "error: unsupported Address Width value in "
-                    "context-entry hi 0x%"PRIx64 " lo 0x%"PRIx64,
-                    ce->hi, ce->lo);
+        error_report("Unsupported Address Width value in "
+                     "context-entry hi 0x%"PRIx64 " lo 0x%"PRIx64,
+                     ce->hi, ce->lo);
         return -VTD_FR_CONTEXT_ENTRY_INV;
     } else {
         switch (ce->lo & VTD_CONTEXT_ENTRY_TT) {
@@ -746,6 +742,9 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
             VTD_DPRINTF(GENERAL, "error: unsupported Translation Type in "
                         "context-entry hi 0x%"PRIx64 " lo 0x%"PRIx64,
                         ce->hi, ce->lo);
+            error_report("Unsupported Translation Type in "
+                         "context-entry hi 0x%"PRIx64 " lo 0x%"PRIx64,
+                         ce->hi, ce->lo);
             return -VTD_FR_CONTEXT_ENTRY_INV;
         }
     }
@@ -825,9 +824,8 @@ static void vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     /* Try to fetch slpte form IOTLB */
     iotlb_entry = vtd_lookup_iotlb(s, source_id, addr);
     if (iotlb_entry) {
-        VTD_DPRINTF(CACHE, "hit iotlb sid 0x%"PRIx16 " iova 0x%"PRIx64
-                    " slpte 0x%"PRIx64 " did 0x%"PRIx16, source_id, addr,
-                    iotlb_entry->slpte, iotlb_entry->domain_id);
+        trace_vtd_iotlb_page_hit(source_id, addr, iotlb_entry->slpte,
+                                 iotlb_entry->domain_id);
         slpte = iotlb_entry->slpte;
         reads = iotlb_entry->read_flags;
         writes = iotlb_entry->write_flags;
@@ -836,10 +834,9 @@ static void vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     }
     /* Try to fetch context-entry from cache first */
     if (cc_entry->context_cache_gen == s->context_cache_gen) {
-        VTD_DPRINTF(CACHE, "hit context-cache bus %d devfn %d "
-                    "(hi %"PRIx64 " lo %"PRIx64 " gen %"PRIu32 ")",
-                    bus_num, devfn, cc_entry->context_entry.hi,
-                    cc_entry->context_entry.lo, cc_entry->context_cache_gen);
+        trace_vtd_iotlb_cc_hit(bus_num, devfn, cc_entry->context_entry.hi,
+                               cc_entry->context_entry.lo,
+                               cc_entry->context_cache_gen);
         ce = cc_entry->context_entry;
         is_fpd_set = ce.lo & VTD_CONTEXT_ENTRY_FPD;
     } else {
@@ -848,19 +845,18 @@ static void vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
         if (ret_fr) {
             ret_fr = -ret_fr;
             if (is_fpd_set && vtd_is_qualified_fault(ret_fr)) {
-                VTD_DPRINTF(FLOG, "fault processing is disabled for DMA "
-                            "requests through this context-entry "
-                            "(with FPD Set)");
+                error_report("Fault processing is disabled for DMA "
+                             "requests through this context-entry "
+                             "(with FPD Set)");
             } else {
                 vtd_report_dmar_fault(s, source_id, addr, ret_fr, is_write);
             }
             return;
         }
         /* Update context-cache */
-        VTD_DPRINTF(CACHE, "update context-cache bus %d devfn %d "
-                    "(hi %"PRIx64 " lo %"PRIx64 " gen %"PRIu32 "->%"PRIu32 ")",
-                    bus_num, devfn, ce.hi, ce.lo,
-                    cc_entry->context_cache_gen, s->context_cache_gen);
+        trace_vtd_iotlb_cc_update(bus_num, devfn, ce.hi, ce.lo,
+                                  cc_entry->context_cache_gen,
+                                  s->context_cache_gen);
         cc_entry->context_entry = ce;
         cc_entry->context_cache_gen = s->context_cache_gen;
     }
@@ -870,8 +866,9 @@ static void vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     if (ret_fr) {
         ret_fr = -ret_fr;
         if (is_fpd_set && vtd_is_qualified_fault(ret_fr)) {
-            VTD_DPRINTF(FLOG, "fault processing is disabled for DMA requests "
-                        "through this context-entry (with FPD Set)");
+            error_report("Fault processing is disabled for DMA "
+                         "requests through this context-entry "
+                         "(with FPD Set)");
         } else {
             vtd_report_dmar_fault(s, source_id, addr, ret_fr, is_write);
         }
@@ -1031,6 +1028,7 @@ static uint64_t vtd_context_cache_invalidate(IntelIOMMUState *s, uint64_t val)
 
 static void vtd_iotlb_global_invalidate(IntelIOMMUState *s)
 {
+    trace_vtd_iotlb_reset("global invalidation recved");
     vtd_reset_iotlb(s);
 }
 
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index fba81f4..eba9bf2 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -22,6 +22,13 @@ vtd_inv_desc_iotlb_domain(uint16_t domain) "iotlb invalidate whole domain 0x%"PR
 vtd_inv_desc_iotlb_pages(uint16_t domain, uint64_t addr, uint8_t mask) "iotlb invalidate domain 0x%"PRIx16" addr 0x%"PRIx64" mask 0x%"PRIx8
 vtd_inv_desc_wait_sw(uint64_t addr, uint32_t data) "wait invalidate status write addr 0x%"PRIx64" data 0x%"PRIx32
 vtd_inv_desc_wait_irq(const char *msg) "%s"
+vtd_re_not_present(uint8_t bus) "Root entry bus %"PRIu8" not present"
+vtd_ce_not_present(uint8_t bus, uint8_t devfn) "Context entry bus %"PRIu8" devfn %"PRIu8" not present"
+vtd_iotlb_page_hit(uint16_t sid, uint64_t addr, uint64_t slpte, uint16_t domain) "IOTLB page hit sid 0x%"PRIx16" iova 0x%"PRIx64" slpte 0x%"PRIx64" domain 0x%"PRIx16
+vtd_iotlb_page_update(uint16_t sid, uint64_t addr, uint64_t slpte, uint16_t domain) "IOTLB page update sid 0x%"PRIx16" iova 0x%"PRIx64" slpte 0x%"PRIx64" domain 0x%"PRIx16
+vtd_iotlb_cc_hit(uint8_t bus, uint8_t devfn, uint64_t high, uint64_t low, uint32_t gen) "IOTLB context hit bus 0x%"PRIx8" devfn 0x%"PRIx8" high 0x%"PRIx64" low 0x%"PRIx64" gen %"PRIu32
+vtd_iotlb_cc_update(uint8_t bus, uint8_t devfn, uint64_t high, uint64_t low, uint32_t gen1, uint32_t gen2) "IOTLB context update bus 0x%"PRIx8" devfn 0x%"PRIx8" high 0x%"PRIx64" low 0x%"PRIx64" gen %"PRIu32" -> gen %"PRIu32
+vtd_iotlb_reset(const char *reason) "IOTLB reset (reason: %s)"
 
 # hw/i386/amd_iommu.c
 amdvi_evntlog_fail(uint64_t addr, uint32_t head) "error: fail to write at addr 0x%"PRIx64" +  offset 0x%"PRIx32
-- 
2.7.4
