Received: from eggs.gnu.org ([2001:4830:134:3::10]:54574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZHzc-0006eW-B0
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 11:13:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZHzY-0002rS-Ep
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 11:13:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gZHzY-0002qv-3R
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 11:13:08 -0500
Date: Tue, 18 Dec 2018 11:13:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181218161008.3882-20-mst@redhat.com>
References: <20181218161008.3882-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218161008.3882-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 19/30] intel_iommu: convert invalid traces
 into error reports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Peter Xu <peterx@redhat.com>

Report more *_invalid() tracepoints to error_report_once() so that we
can detect issues even without tracing enabled.  Drop those tracepoints.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 58 ++++++++++++++++++++++++++++++++-----------
 hw/i386/trace-events  |  6 -----
 2 files changed, 43 insertions(+), 21 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index f21988f396..4806d7edb4 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -524,7 +524,6 @@ static int vtd_get_root_entry(IntelIOMMUState *s, uint8_t index,
 
     addr = s->root + index * sizeof(*re);
     if (dma_memory_read(&address_space_memory, addr, re, sizeof(*re))) {
-        trace_vtd_re_invalid(re->rsvd, re->val);
         re->val = 0;
         return -VTD_FR_ROOT_TABLE_INV;
     }
@@ -545,7 +544,6 @@ static int vtd_get_context_entry_from_root(VTDRootEntry *root, uint8_t index,
     /* we have checked that root entry is present */
     addr = (root->val & VTD_ROOT_ENTRY_CTP) + index * sizeof(*ce);
     if (dma_memory_read(&address_space_memory, addr, ce, sizeof(*ce))) {
-        trace_vtd_re_invalid(root->rsvd, root->val);
         return -VTD_FR_CONTEXT_TABLE_INV;
     }
     ce->lo = le64_to_cpu(ce->lo);
@@ -630,16 +628,20 @@ static inline bool vtd_ce_type_check(X86IOMMUState *x86_iommu,
         break;
     case VTD_CONTEXT_TT_DEV_IOTLB:
         if (!x86_iommu->dt_supported) {
+            error_report_once("%s: DT specified but not supported", __func__);
             return false;
         }
         break;
     case VTD_CONTEXT_TT_PASS_THROUGH:
         if (!x86_iommu->pt_supported) {
+            error_report_once("%s: PT specified but not supported", __func__);
             return false;
         }
         break;
     default:
         /* Unknwon type */
+        error_report_once("%s: unknown ce type: %"PRIu32, __func__,
+                          vtd_ce_get_type(ce));
         return false;
     }
     return true;
@@ -1003,7 +1005,9 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
     }
 
     if (re.rsvd || (re.val & VTD_ROOT_ENTRY_RSVD(s->aw_bits))) {
-        trace_vtd_re_invalid(re.rsvd, re.val);
+        error_report_once("%s: invalid root entry: rsvd=0x%"PRIx64
+                          ", val=0x%"PRIx64" (reserved nonzero)",
+                          __func__, re.rsvd, re.val);
         return -VTD_FR_ROOT_ENTRY_RSVD;
     }
 
@@ -1020,19 +1024,23 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
 
     if ((ce->hi & VTD_CONTEXT_ENTRY_RSVD_HI) ||
                (ce->lo & VTD_CONTEXT_ENTRY_RSVD_LO(s->aw_bits))) {
-        trace_vtd_ce_invalid(ce->hi, ce->lo);
+        error_report_once("%s: invalid context entry: hi=%"PRIx64
+                          ", lo=%"PRIx64" (reserved nonzero)",
+                          __func__, ce->hi, ce->lo);
         return -VTD_FR_CONTEXT_ENTRY_RSVD;
     }
 
     /* Check if the programming of context-entry is valid */
     if (!vtd_is_level_supported(s, vtd_ce_get_level(ce))) {
-        trace_vtd_ce_invalid(ce->hi, ce->lo);
+        error_report_once("%s: invalid context entry: hi=%"PRIx64
+                          ", lo=%"PRIx64" (level %d not supported)",
+                          __func__, ce->hi, ce->lo, vtd_ce_get_level(ce));
         return -VTD_FR_CONTEXT_ENTRY_INV;
     }
 
     /* Do translation type check */
     if (!vtd_ce_type_check(x86_iommu, ce)) {
-        trace_vtd_ce_invalid(ce->hi, ce->lo);
+        /* Errors dumped in vtd_ce_type_check() */
         return -VTD_FR_CONTEXT_ENTRY_INV;
     }
 
@@ -1878,7 +1886,9 @@ static bool vtd_process_wait_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
 {
     if ((inv_desc->hi & VTD_INV_DESC_WAIT_RSVD_HI) ||
         (inv_desc->lo & VTD_INV_DESC_WAIT_RSVD_LO)) {
-        trace_vtd_inv_desc_wait_invalid(inv_desc->hi, inv_desc->lo);
+        error_report_once("%s: invalid wait desc: hi=%"PRIx64", lo=%"PRIx64
+                          " (reserved nonzero)", __func__, inv_desc->hi,
+                          inv_desc->lo);
         return false;
     }
     if (inv_desc->lo & VTD_INV_DESC_WAIT_SW) {
@@ -1901,7 +1911,9 @@ static bool vtd_process_wait_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
         /* Interrupt flag */
         vtd_generate_completion_event(s);
     } else {
-        trace_vtd_inv_desc_wait_invalid(inv_desc->hi, inv_desc->lo);
+        error_report_once("%s: invalid wait desc: hi=%"PRIx64", lo=%"PRIx64
+                          " (unknown type)", __func__, inv_desc->hi,
+                          inv_desc->lo);
         return false;
     }
     return true;
@@ -1913,7 +1925,9 @@ static bool vtd_process_context_cache_desc(IntelIOMMUState *s,
     uint16_t sid, fmask;
 
     if ((inv_desc->lo & VTD_INV_DESC_CC_RSVD) || inv_desc->hi) {
-        trace_vtd_inv_desc_cc_invalid(inv_desc->hi, inv_desc->lo);
+        error_report_once("%s: invalid cc inv desc: hi=%"PRIx64", lo=%"PRIx64
+                          " (reserved nonzero)", __func__, inv_desc->hi,
+                          inv_desc->lo);
         return false;
     }
     switch (inv_desc->lo & VTD_INV_DESC_CC_G) {
@@ -1932,7 +1946,9 @@ static bool vtd_process_context_cache_desc(IntelIOMMUState *s,
         break;
 
     default:
-        trace_vtd_inv_desc_cc_invalid(inv_desc->hi, inv_desc->lo);
+        error_report_once("%s: invalid cc inv desc: hi=%"PRIx64", lo=%"PRIx64
+                          " (invalid type)", __func__, inv_desc->hi,
+                          inv_desc->lo);
         return false;
     }
     return true;
@@ -1946,7 +1962,9 @@ static bool vtd_process_iotlb_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
 
     if ((inv_desc->lo & VTD_INV_DESC_IOTLB_RSVD_LO) ||
         (inv_desc->hi & VTD_INV_DESC_IOTLB_RSVD_HI)) {
-        trace_vtd_inv_desc_iotlb_invalid(inv_desc->hi, inv_desc->lo);
+        error_report_once("%s: invalid iotlb inv desc: hi=0x%"PRIx64
+                          ", lo=0x%"PRIx64" (reserved bits unzero)\n",
+                          __func__, inv_desc->hi, inv_desc->lo);
         return false;
     }
 
@@ -1965,14 +1983,20 @@ static bool vtd_process_iotlb_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
         addr = VTD_INV_DESC_IOTLB_ADDR(inv_desc->hi);
         am = VTD_INV_DESC_IOTLB_AM(inv_desc->hi);
         if (am > VTD_MAMV) {
-            trace_vtd_inv_desc_iotlb_invalid(inv_desc->hi, inv_desc->lo);
+            error_report_once("%s: invalid iotlb inv desc: hi=0x%"PRIx64
+                              ", lo=0x%"PRIx64" (am=%u > VTD_MAMV=%u)\n",
+                              __func__, inv_desc->hi, inv_desc->lo,
+                              am, (unsigned)VTD_MAMV);
             return false;
         }
         vtd_iotlb_page_invalidate(s, domain_id, addr, am);
         break;
 
     default:
-        trace_vtd_inv_desc_iotlb_invalid(inv_desc->hi, inv_desc->lo);
+        error_report_once("%s: invalid iotlb inv desc: hi=0x%"PRIx64
+                          ", lo=0x%"PRIx64" (type mismatch: 0x%llx)\n",
+                          __func__, inv_desc->hi, inv_desc->lo,
+                          inv_desc->lo & VTD_INV_DESC_IOTLB_G);
         return false;
     }
     return true;
@@ -2012,7 +2036,9 @@ static bool vtd_process_device_iotlb_desc(IntelIOMMUState *s,
 
     if ((inv_desc->lo & VTD_INV_DESC_DEVICE_IOTLB_RSVD_LO) ||
         (inv_desc->hi & VTD_INV_DESC_DEVICE_IOTLB_RSVD_HI)) {
-        trace_vtd_inv_desc_iotlb_invalid(inv_desc->hi, inv_desc->lo);
+        error_report_once("%s: invalid dev-iotlb inv desc: hi=%"PRIx64
+                          ", lo=%"PRIx64" (reserved nonzero)", __func__,
+                          inv_desc->hi, inv_desc->lo);
         return false;
     }
 
@@ -2103,7 +2129,9 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
         break;
 
     default:
-        trace_vtd_inv_desc_invalid(inv_desc.hi, inv_desc.lo);
+        error_report_once("%s: invalid inv desc: hi=%"PRIx64", lo=%"PRIx64
+                          " (unknown type)", __func__, inv_desc.hi,
+                          inv_desc.lo);
         return false;
     }
     s->iq_head++;
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 6ac347d18c..77244fc384 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -5,19 +5,15 @@ x86_iommu_iec_notify(bool global, uint32_t index, uint32_t mask) "Notify IEC inv
 
 # hw/i386/intel_iommu.c
 vtd_inv_desc(const char *type, uint64_t hi, uint64_t lo) "invalidate desc type %s high 0x%"PRIx64" low 0x%"PRIx64
-vtd_inv_desc_invalid(uint64_t hi, uint64_t lo) "invalid inv desc hi 0x%"PRIx64" lo 0x%"PRIx64
 vtd_inv_desc_cc_domain(uint16_t domain) "context invalidate domain 0x%"PRIx16
 vtd_inv_desc_cc_global(void) "context invalidate globally"
 vtd_inv_desc_cc_device(uint8_t bus, uint8_t dev, uint8_t fn) "context invalidate device %02"PRIx8":%02"PRIx8".%02"PRIx8
 vtd_inv_desc_cc_devices(uint16_t sid, uint16_t fmask) "context invalidate devices sid 0x%"PRIx16" fmask 0x%"PRIx16
-vtd_inv_desc_cc_invalid(uint64_t hi, uint64_t lo) "invalid context-cache desc hi 0x%"PRIx64" lo 0x%"PRIx64
 vtd_inv_desc_iotlb_global(void) "iotlb invalidate global"
 vtd_inv_desc_iotlb_domain(uint16_t domain) "iotlb invalidate whole domain 0x%"PRIx16
 vtd_inv_desc_iotlb_pages(uint16_t domain, uint64_t addr, uint8_t mask) "iotlb invalidate domain 0x%"PRIx16" addr 0x%"PRIx64" mask 0x%"PRIx8
-vtd_inv_desc_iotlb_invalid(uint64_t hi, uint64_t lo) "invalid iotlb desc hi 0x%"PRIx64" lo 0x%"PRIx64
 vtd_inv_desc_wait_sw(uint64_t addr, uint32_t data) "wait invalidate status write addr 0x%"PRIx64" data 0x%"PRIx32
 vtd_inv_desc_wait_irq(const char *msg) "%s"
-vtd_inv_desc_wait_invalid(uint64_t hi, uint64_t lo) "invalid wait desc hi 0x%"PRIx64" lo 0x%"PRIx64
 vtd_inv_desc_wait_write_fail(uint64_t hi, uint64_t lo) "write fail for wait desc hi 0x%"PRIx64" lo 0x%"PRIx64
 vtd_inv_desc_iec(uint32_t granularity, uint32_t index, uint32_t mask) "granularity 0x%"PRIx32" index 0x%"PRIx32" mask 0x%"PRIx32
 vtd_inv_qi_enable(bool enable) "enabled %d"
@@ -27,9 +23,7 @@ vtd_inv_qi_tail(uint16_t head) "write tail %d"
 vtd_inv_qi_fetch(void) ""
 vtd_context_cache_reset(void) ""
 vtd_re_not_present(uint8_t bus) "Root entry bus %"PRIu8" not present"
-vtd_re_invalid(uint64_t hi, uint64_t lo) "invalid root entry hi 0x%"PRIx64" lo 0x%"PRIx64
 vtd_ce_not_present(uint8_t bus, uint8_t devfn) "Context entry bus %"PRIu8" devfn %"PRIu8" not present"
-vtd_ce_invalid(uint64_t hi, uint64_t lo) "invalid context entry hi 0x%"PRIx64" lo 0x%"PRIx64
 vtd_iotlb_page_hit(uint16_t sid, uint64_t addr, uint64_t slpte, uint16_t domain) "IOTLB page hit sid 0x%"PRIx16" iova 0x%"PRIx64" slpte 0x%"PRIx64" domain 0x%"PRIx16
 vtd_iotlb_page_update(uint16_t sid, uint64_t addr, uint64_t slpte, uint16_t domain) "IOTLB page update sid 0x%"PRIx16" iova 0x%"PRIx64" slpte 0x%"PRIx64" domain 0x%"PRIx16
 vtd_iotlb_cc_hit(uint8_t bus, uint8_t devfn, uint64_t high, uint64_t low, uint32_t gen) "IOTLB context hit bus 0x%"PRIx8" devfn 0x%"PRIx8" high 0x%"PRIx64" low 0x%"PRIx64" gen %"PRIu32
-- 
MST
