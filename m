Received: from eggs.gnu.org ([209.51.188.92]:54318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.y.sun@linux.intel.com>) id 1goie3-0004IJ-Vd
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 00:42:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.y.sun@linux.intel.com>) id 1goie1-0005MD-JI
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 00:42:43 -0500
Received: from mga02.intel.com ([134.134.136.20]:63856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.y.sun@linux.intel.com>)
	id 1goidm-0005Hp-G3
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 00:42:32 -0500
From: Yi Sun <yi.y.sun@linux.intel.com>
Date: Wed, 30 Jan 2019 13:09:12 +0800
Message-Id: <1548824953-23413-3-git-send-email-yi.y.sun@linux.intel.com>
In-Reply-To: <1548824953-23413-1-git-send-email-yi.y.sun@linux.intel.com>
References: <1548824953-23413-1-git-send-email-yi.y.sun@linux.intel.com>
Subject: [Qemu-devel] [RFC v1 2/3] intel_iommu: add 256 bits qi_desc support
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

Per Intel(R) VT-d 3.0, the qi_desc is 256 bits in Scalable
Mode. This patch adds emulation of 256bits qi_desc.

[Yi Sun is co-developer to rebase and refine the patch.]
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
---
 hw/i386/intel_iommu.c          | 182 +++++++++++++++++++++++++----------------
 hw/i386/intel_iommu_internal.h |   8 +-
 include/hw/i386/intel_iommu.h  |   1 +
 3 files changed, 116 insertions(+), 75 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 396ac8e..3664a00 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -38,6 +38,7 @@
 #include "trace.h"
 
 #define vtd_devfn_check(devfn) ((devfn & VTD_DEVFN_CHECK_MASK) ? true : false)
+#define vtd_ecap_smts(s) ((s)->ecap & VTD_ECAP_SMTS)
 
 /* context entry operations */
 #define vtd_get_ce_size(s, ce) \
@@ -65,6 +66,9 @@
 #define vtd_pe_get_slpt_base(pe) ((pe)->val[0] & VTD_SM_PASID_ENTRY_SLPTPTR)
 #define vtd_pe_get_domain_id(pe) VTD_SM_PASID_ENTRY_DID((pe)->val[1])
 
+/* invalidation desc */
+#define vtd_get_inv_desc_width(s) ((s)->iq_dw ? 32 : 16)
+
 static void vtd_address_space_refresh_all(IntelIOMMUState *s);
 static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
 
@@ -1759,6 +1763,11 @@ static void vtd_root_table_setup(IntelIOMMUState *s)
     s->root_scalable = s->root & VTD_RTADDR_SMT;
     s->root &= VTD_RTADDR_ADDR_MASK(s->aw_bits);
 
+    /* if Scalable mode is not enabled, enforce iq_dw to be 16 byte */
+    if (!s->root_scalable) {
+        s->iq_dw = 0;
+    }
+
     trace_vtd_reg_dmar_root(s->root, s->root_extended);
 }
 
@@ -2052,7 +2061,7 @@ static void vtd_handle_gcmd_qie(IntelIOMMUState *s, bool en)
     if (en) {
         s->iq = iqa_val & VTD_IQA_IQA_MASK(s->aw_bits);
         /* 2^(x+8) entries */
-        s->iq_size = 1UL << ((iqa_val & VTD_IQA_QS) + 8);
+        s->iq_size = 1UL << ((iqa_val & VTD_IQA_QS) + 8 - (s->iq_dw ? 1 : 0));
         s->qi_enabled = true;
         trace_vtd_inv_qi_setup(s->iq, s->iq_size);
         /* Ok - report back to driver */
@@ -2219,54 +2228,66 @@ static void vtd_handle_iotlb_write(IntelIOMMUState *s)
 }
 
 /* Fetch an Invalidation Descriptor from the Invalidation Queue */
-static bool vtd_get_inv_desc(dma_addr_t base_addr, uint32_t offset,
+static bool vtd_get_inv_desc(IntelIOMMUState *s,
                              VTDInvDesc *inv_desc)
 {
-    dma_addr_t addr = base_addr + offset * sizeof(*inv_desc);
-    if (dma_memory_read(&address_space_memory, addr, inv_desc,
-        sizeof(*inv_desc))) {
-        error_report_once("Read INV DESC failed");
-        inv_desc->lo = 0;
-        inv_desc->hi = 0;
+    dma_addr_t base_addr = s->iq;
+    uint32_t offset = s->iq_head;
+    uint32_t dw = vtd_get_inv_desc_width(s);
+    dma_addr_t addr = base_addr + offset * dw;
+
+    /* init */
+    inv_desc->val[0] = 0;
+    inv_desc->val[1] = 0;
+    inv_desc->val[2] = 0;
+    inv_desc->val[3] = 0;
+
+    if (dma_memory_read(&address_space_memory, addr, inv_desc, dw)) {
+        error_report_once("Read INV DESC failed.");
         return false;
     }
-    inv_desc->lo = le64_to_cpu(inv_desc->lo);
-    inv_desc->hi = le64_to_cpu(inv_desc->hi);
+    inv_desc->val[0] = le64_to_cpu(inv_desc->val[0]);
+    inv_desc->val[1] = le64_to_cpu(inv_desc->val[1]);
+    inv_desc->val[2] = le64_to_cpu(inv_desc->val[2]);
+    inv_desc->val[3] = le64_to_cpu(inv_desc->val[3]);
     return true;
 }
 
 static bool vtd_process_wait_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
 {
-    if ((inv_desc->hi & VTD_INV_DESC_WAIT_RSVD_HI) ||
-        (inv_desc->lo & VTD_INV_DESC_WAIT_RSVD_LO)) {
-        error_report_once("%s: invalid wait desc: hi=%"PRIx64", lo=%"PRIx64
-                          " (reserved nonzero)", __func__, inv_desc->hi,
-                          inv_desc->lo);
+    if ((inv_desc->val[1] & VTD_INV_DESC_WAIT_RSVD_HI) ||
+        (inv_desc->val[0] & VTD_INV_DESC_WAIT_RSVD_LO)) {
+        error_report_once("%s: invalid wait desc: val[1]=%"PRIx64
+                          ", val[0]=%"PRIx64
+                          " (reserved nonzero)", __func__, inv_desc->val[1],
+                          inv_desc->val[0]);
         return false;
     }
-    if (inv_desc->lo & VTD_INV_DESC_WAIT_SW) {
+    if (inv_desc->val[0] & VTD_INV_DESC_WAIT_SW) {
         /* Status Write */
-        uint32_t status_data = (uint32_t)(inv_desc->lo >>
+        uint32_t status_data = (uint32_t)(inv_desc->val[0] >>
                                VTD_INV_DESC_WAIT_DATA_SHIFT);
 
-        assert(!(inv_desc->lo & VTD_INV_DESC_WAIT_IF));
+        assert(!(inv_desc->val[0] & VTD_INV_DESC_WAIT_IF));
 
         /* FIXME: need to be masked with HAW? */
-        dma_addr_t status_addr = inv_desc->hi;
+        dma_addr_t status_addr = inv_desc->val[1];
         trace_vtd_inv_desc_wait_sw(status_addr, status_data);
         status_data = cpu_to_le32(status_data);
         if (dma_memory_write(&address_space_memory, status_addr, &status_data,
                              sizeof(status_data))) {
-            trace_vtd_inv_desc_wait_write_fail(inv_desc->hi, inv_desc->lo);
+            trace_vtd_inv_desc_wait_write_fail(inv_desc->val[1],
+                                               inv_desc->val[0]);
             return false;
         }
-    } else if (inv_desc->lo & VTD_INV_DESC_WAIT_IF) {
+    } else if (inv_desc->val[0] & VTD_INV_DESC_WAIT_IF) {
         /* Interrupt flag */
         vtd_generate_completion_event(s);
     } else {
-        error_report_once("%s: invalid wait desc: hi=%"PRIx64", lo=%"PRIx64
-                          " (unknown type)", __func__, inv_desc->hi,
-                          inv_desc->lo);
+        error_report_once("%s: invalid wait desc: val[1]=%"PRIx64
+                          ", val[0]=%"PRIx64
+                          " (unknown type)", __func__, inv_desc->val[1],
+                          inv_desc->val[0]);
         return false;
     }
     return true;
@@ -2277,31 +2298,33 @@ static bool vtd_process_context_cache_desc(IntelIOMMUState *s,
 {
     uint16_t sid, fmask;
 
-    if ((inv_desc->lo & VTD_INV_DESC_CC_RSVD) || inv_desc->hi) {
-        error_report_once("%s: invalid cc inv desc: hi=%"PRIx64", lo=%"PRIx64
-                          " (reserved nonzero)", __func__, inv_desc->hi,
-                          inv_desc->lo);
+    if ((inv_desc->val[0] & VTD_INV_DESC_CC_RSVD) || inv_desc->val[1]) {
+        error_report_once("%s: invalid cc inv desc: val[1]=%"PRIx64
+                          ", val[0]=%"PRIx64
+                          " (reserved nonzero)", __func__, inv_desc->val[1],
+                          inv_desc->val[0]);
         return false;
     }
-    switch (inv_desc->lo & VTD_INV_DESC_CC_G) {
+    switch (inv_desc->val[0] & VTD_INV_DESC_CC_G) {
     case VTD_INV_DESC_CC_DOMAIN:
         trace_vtd_inv_desc_cc_domain(
-            (uint16_t)VTD_INV_DESC_CC_DID(inv_desc->lo));
+            (uint16_t)VTD_INV_DESC_CC_DID(inv_desc->val[0]));
         /* Fall through */
     case VTD_INV_DESC_CC_GLOBAL:
         vtd_context_global_invalidate(s);
         break;
 
     case VTD_INV_DESC_CC_DEVICE:
-        sid = VTD_INV_DESC_CC_SID(inv_desc->lo);
-        fmask = VTD_INV_DESC_CC_FM(inv_desc->lo);
+        sid = VTD_INV_DESC_CC_SID(inv_desc->val[0]);
+        fmask = VTD_INV_DESC_CC_FM(inv_desc->val[0]);
         vtd_context_device_invalidate(s, sid, fmask);
         break;
 
     default:
-        error_report_once("%s: invalid cc inv desc: hi=%"PRIx64", lo=%"PRIx64
-                          " (invalid type)", __func__, inv_desc->hi,
-                          inv_desc->lo);
+        error_report_once("%s: invalid cc inv desc: val[1]=%"PRIx64
+                          ", val[0]=%"PRIx64
+                          " (invalid type)", __func__, inv_desc->val[1],
+                          inv_desc->val[0]);
         return false;
     }
     return true;
@@ -2313,32 +2336,32 @@ static bool vtd_process_iotlb_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
     uint8_t am;
     hwaddr addr;
 
-    if ((inv_desc->lo & VTD_INV_DESC_IOTLB_RSVD_LO) ||
-        (inv_desc->hi & VTD_INV_DESC_IOTLB_RSVD_HI)) {
-        error_report_once("%s: invalid iotlb inv desc: hi=0x%"PRIx64
-                          ", lo=0x%"PRIx64" (reserved bits unzero)\n",
-                          __func__, inv_desc->hi, inv_desc->lo);
+    if ((inv_desc->val[0] & VTD_INV_DESC_IOTLB_RSVD_LO) ||
+        (inv_desc->val[1] & VTD_INV_DESC_IOTLB_RSVD_HI)) {
+        error_report_once("%s: invalid iotlb inv desc: val[1]=0x%"PRIx64
+                          ", val[0]=0x%"PRIx64" (reserved bits unzero)\n",
+                          __func__, inv_desc->val[1], inv_desc->val[0]);
         return false;
     }
 
-    switch (inv_desc->lo & VTD_INV_DESC_IOTLB_G) {
+    switch (inv_desc->val[0] & VTD_INV_DESC_IOTLB_G) {
     case VTD_INV_DESC_IOTLB_GLOBAL:
         vtd_iotlb_global_invalidate(s);
         break;
 
     case VTD_INV_DESC_IOTLB_DOMAIN:
-        domain_id = VTD_INV_DESC_IOTLB_DID(inv_desc->lo);
+        domain_id = VTD_INV_DESC_IOTLB_DID(inv_desc->val[0]);
         vtd_iotlb_domain_invalidate(s, domain_id);
         break;
 
     case VTD_INV_DESC_IOTLB_PAGE:
-        domain_id = VTD_INV_DESC_IOTLB_DID(inv_desc->lo);
-        addr = VTD_INV_DESC_IOTLB_ADDR(inv_desc->hi);
-        am = VTD_INV_DESC_IOTLB_AM(inv_desc->hi);
+        domain_id = VTD_INV_DESC_IOTLB_DID(inv_desc->val[0]);
+        addr = VTD_INV_DESC_IOTLB_ADDR(inv_desc->val[1]);
+        am = VTD_INV_DESC_IOTLB_AM(inv_desc->val[1]);
         if (am > VTD_MAMV) {
-            error_report_once("%s: invalid iotlb inv desc: hi=0x%"PRIx64
-                              ", lo=0x%"PRIx64" (am=%u > VTD_MAMV=%u)\n",
-                              __func__, inv_desc->hi, inv_desc->lo,
+            error_report_once("%s: invalid iotlb inv desc: val[1]=0x%"PRIx64
+                              ", val[0]=0x%"PRIx64" (am=%u > VTD_MAMV=%u)\n",
+                              __func__, inv_desc->val[1], inv_desc->val[0],
                               am, (unsigned)VTD_MAMV);
             return false;
         }
@@ -2346,10 +2369,10 @@ static bool vtd_process_iotlb_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
         break;
 
     default:
-        error_report_once("%s: invalid iotlb inv desc: hi=0x%"PRIx64
-                          ", lo=0x%"PRIx64" (type mismatch: 0x%llx)\n",
-                          __func__, inv_desc->hi, inv_desc->lo,
-                          inv_desc->lo & VTD_INV_DESC_IOTLB_G);
+        error_report_once("%s: invalid iotlb inv desc: val[1]=0x%"PRIx64
+                          ", val[0]=0x%"PRIx64" (type mismatch: 0x%llx)\n",
+                          __func__, inv_desc->val[1], inv_desc->val[0],
+                          inv_desc->val[0] & VTD_INV_DESC_IOTLB_G);
         return false;
     }
     return true;
@@ -2381,17 +2404,17 @@ static bool vtd_process_device_iotlb_desc(IntelIOMMUState *s,
     bool size;
     uint8_t bus_num;
 
-    addr = VTD_INV_DESC_DEVICE_IOTLB_ADDR(inv_desc->hi);
-    sid = VTD_INV_DESC_DEVICE_IOTLB_SID(inv_desc->lo);
+    addr = VTD_INV_DESC_DEVICE_IOTLB_ADDR(inv_desc->val[1]);
+    sid = VTD_INV_DESC_DEVICE_IOTLB_SID(inv_desc->val[0]);
     devfn = sid & 0xff;
     bus_num = sid >> 8;
-    size = VTD_INV_DESC_DEVICE_IOTLB_SIZE(inv_desc->hi);
+    size = VTD_INV_DESC_DEVICE_IOTLB_SIZE(inv_desc->val[1]);
 
-    if ((inv_desc->lo & VTD_INV_DESC_DEVICE_IOTLB_RSVD_LO) ||
-        (inv_desc->hi & VTD_INV_DESC_DEVICE_IOTLB_RSVD_HI)) {
-        error_report_once("%s: invalid dev-iotlb inv desc: hi=%"PRIx64
-                          ", lo=%"PRIx64" (reserved nonzero)", __func__,
-                          inv_desc->hi, inv_desc->lo);
+    if ((inv_desc->val[0] & VTD_INV_DESC_DEVICE_IOTLB_RSVD_LO) ||
+        (inv_desc->val[1] & VTD_INV_DESC_DEVICE_IOTLB_RSVD_HI)) {
+        error_report_once("%s: invalid dev-iotlb inv desc: val[1]=%"PRIx64
+                          ", val[0]=%"PRIx64" (reserved nonzero)", __func__,
+                          inv_desc->val[1], inv_desc->val[0]);
         return false;
     }
 
@@ -2437,54 +2460,64 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
     uint8_t desc_type;
 
     trace_vtd_inv_qi_head(s->iq_head);
-    if (!vtd_get_inv_desc(s->iq, s->iq_head, &inv_desc)) {
+    if (!vtd_get_inv_desc(s, &inv_desc)) {
         s->iq_last_desc_type = VTD_INV_DESC_NONE;
         return false;
     }
-    desc_type = inv_desc.lo & VTD_INV_DESC_TYPE;
+    if (inv_desc.val[3] || inv_desc.val[2]) {
+        error_report_once("%s: invalid inv desc: val[3]=%"PRIx64
+                          ", val[2]=%"PRIx64
+                          " (detect reserve non-zero)", __func__,
+                          inv_desc.val[3],
+                          inv_desc.val[2]);
+        return false;
+    }
+
+    desc_type = inv_desc.val[0] & VTD_INV_DESC_TYPE;
     /* FIXME: should update at first or at last? */
     s->iq_last_desc_type = desc_type;
 
     switch (desc_type) {
     case VTD_INV_DESC_CC:
-        trace_vtd_inv_desc("context-cache", inv_desc.hi, inv_desc.lo);
+        trace_vtd_inv_desc("context-cache", inv_desc.val[1], inv_desc.val[0]);
         if (!vtd_process_context_cache_desc(s, &inv_desc)) {
             return false;
         }
         break;
 
     case VTD_INV_DESC_IOTLB:
-        trace_vtd_inv_desc("iotlb", inv_desc.hi, inv_desc.lo);
+        trace_vtd_inv_desc("iotlb", inv_desc.val[1], inv_desc.val[0]);
         if (!vtd_process_iotlb_desc(s, &inv_desc)) {
             return false;
         }
         break;
 
     case VTD_INV_DESC_WAIT:
-        trace_vtd_inv_desc("wait", inv_desc.hi, inv_desc.lo);
+        trace_vtd_inv_desc("wait", inv_desc.val[1], inv_desc.val[0]);
         if (!vtd_process_wait_desc(s, &inv_desc)) {
             return false;
         }
         break;
 
     case VTD_INV_DESC_IEC:
-        trace_vtd_inv_desc("iec", inv_desc.hi, inv_desc.lo);
+        trace_vtd_inv_desc("iec", inv_desc.val[1], inv_desc.val[0]);
         if (!vtd_process_inv_iec_desc(s, &inv_desc)) {
             return false;
         }
         break;
 
     case VTD_INV_DESC_DEVICE:
-        trace_vtd_inv_desc("device", inv_desc.hi, inv_desc.lo);
+        trace_vtd_inv_desc("device", inv_desc.val[1], inv_desc.val[0]);
         if (!vtd_process_device_iotlb_desc(s, &inv_desc)) {
             return false;
         }
         break;
 
     default:
-        error_report_once("%s: invalid inv desc: hi=%"PRIx64", lo=%"PRIx64
-                          " (unknown type)", __func__, inv_desc.hi,
-                          inv_desc.lo);
+        error_report_once("%s: invalid inv desc: val[1]=%"PRIx64
+                          ", val[0]=%"PRIx64
+                          " (unknown type)", __func__, inv_desc.val[1],
+                          inv_desc.val[0]);
         return false;
     }
     s->iq_head++;
@@ -2525,7 +2558,7 @@ static void vtd_handle_iqt_write(IntelIOMMUState *s)
 {
     uint64_t val = vtd_get_quad_raw(s, DMAR_IQT_REG);
 
-    s->iq_tail = VTD_IQT_QT(val);
+    s->iq_tail = VTD_IQT_QT(s->iq_dw, val);
     trace_vtd_inv_qi_tail(s->iq_tail);
 
     if (s->qi_enabled && !(vtd_get_long_raw(s, DMAR_FSTS_REG) & VTD_FSTS_IQE)) {
@@ -2794,6 +2827,11 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
         } else {
             vtd_set_quad(s, addr, val);
         }
+        if (vtd_ecap_smts(s)) {
+            s->iq_dw = val & VTD_IQA_DW_MASK;
+        } else {
+            s->iq_dw = 0;
+        }
         break;
 
     case DMAR_IQA_REG_HI:
@@ -3577,7 +3615,7 @@ static void vtd_init(IntelIOMMUState *s)
 
     vtd_define_quad(s, DMAR_IQH_REG, 0, 0, 0);
     vtd_define_quad(s, DMAR_IQT_REG, 0, 0x7fff0ULL, 0);
-    vtd_define_quad(s, DMAR_IQA_REG, 0, 0xfffffffffffff007ULL, 0);
+    vtd_define_quad(s, DMAR_IQA_REG, 0, 0xfffffffffffff807ULL, 0);
     vtd_define_long(s, DMAR_ICS_REG, 0, 0, 0x1UL);
     vtd_define_long(s, DMAR_IECTL_REG, 0x80000000UL, 0x80000000UL, 0);
     vtd_define_long(s, DMAR_IEDATA_REG, 0, 0xffffffffUL, 0);
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 02674f9..2a753c5 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -190,6 +190,7 @@
 #define VTD_ECAP_EIM                (1ULL << 4)
 #define VTD_ECAP_PT                 (1ULL << 6)
 #define VTD_ECAP_MHMV               (15ULL << 20)
+#define VTD_ECAP_SMTS               (1ULL << 43)
 
 /* CAP_REG */
 /* (offset >> 4) << 24 */
@@ -218,11 +219,13 @@
 #define VTD_CAP_SAGAW_48bit         (0x4ULL << VTD_CAP_SAGAW_SHIFT)
 
 /* IQT_REG */
-#define VTD_IQT_QT(val)             (((val) >> 4) & 0x7fffULL)
+#define VTD_IQT_QT(dw_bit, val)     (dw_bit ? (((val) >> 5) & 0x3fffULL) : \
+                                     (((val) >> 4) & 0x7fffULL))
 
 /* IQA_REG */
 #define VTD_IQA_IQA_MASK(aw)        (VTD_HAW_MASK(aw) ^ 0xfffULL)
 #define VTD_IQA_QS                  0x7ULL
+#define VTD_IQA_DW_MASK             0x800
 
 /* IQH_REG */
 #define VTD_IQH_QH_SHIFT            4
@@ -321,8 +324,7 @@ typedef struct VTDInvDescIEC VTDInvDescIEC;
 /* Queued Invalidation Descriptor */
 union VTDInvDesc {
     struct {
-        uint64_t lo;
-        uint64_t hi;
+        uint64_t val[4];
     };
     union {
         VTDInvDescIEC iec;
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index ff13ff27..a5da139 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -230,6 +230,7 @@ struct IntelIOMMUState {
     uint16_t iq_tail;               /* Current invalidation queue tail */
     dma_addr_t iq;                  /* Current invalidation queue pointer */
     uint16_t iq_size;               /* IQ Size in number of entries */
+    uint16_t iq_dw;                 /* IQ descriptor width */
     bool qi_enabled;                /* Set if the QI is enabled */
     uint8_t iq_last_desc_type;      /* The type of last completed descriptor */
 
-- 
1.9.1
