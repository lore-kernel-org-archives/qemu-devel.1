Received: from eggs.gnu.org ([209.51.188.92]:59604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.y.sun@linux.intel.com>) id 1h0zvK-0002GZ-1v
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 21:35:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.y.sun@linux.intel.com>) id 1h0zvI-0004jf-SM
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 21:35:18 -0500
Received: from mga12.intel.com ([192.55.52.136]:36369)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.y.sun@linux.intel.com>)
	id 1h0zvI-0004cM-Gg
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 21:35:16 -0500
From: Yi Sun <yi.y.sun@linux.intel.com>
Date: Tue,  5 Mar 2019 10:34:54 +0800
Message-Id: <1551753295-30167-3-git-send-email-yi.y.sun@linux.intel.com>
In-Reply-To: <1551753295-30167-1-git-send-email-yi.y.sun@linux.intel.com>
References: <1551753295-30167-1-git-send-email-yi.y.sun@linux.intel.com>
Subject: [Qemu-devel] [PATCH v1 2/3] intel_iommu: add 256 bits qi_desc
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com, Yi Sun <yi.y.sun@linux.intel.com>

From: "Liu, Yi L" <yi.l.liu@intel.com>

Per Intel(R) VT-d 3.0, the qi_desc is 256 bits in Scalable
Mode. This patch adds emulation of 256bits qi_desc.

Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
[Yi Sun is co-developer to rebase and refine the patch.]
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
RFC v2->v1
    - do "(val & VTD_IQT_QT_256_RSV_BIT)" to be clear.
---
 hw/i386/intel_iommu.c          | 40 +++++++++++++++++++++++++++++-----------
 hw/i386/intel_iommu_internal.h |  9 ++++++++-
 include/hw/i386/intel_iommu.h  |  1 +
 3 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index ea9ea93..06b48b3 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2005,7 +2005,7 @@ static void vtd_handle_gcmd_qie(IntelIOMMUState *s, bool en)
     if (en) {
         s->iq = iqa_val & VTD_IQA_IQA_MASK(s->aw_bits);
         /* 2^(x+8) entries */
-        s->iq_size = 1UL << ((iqa_val & VTD_IQA_QS) + 8);
+        s->iq_size = 1UL << ((iqa_val & VTD_IQA_QS) + 8 - (s->iq_dw ? 1 : 0));
         s->qi_enabled = true;
         trace_vtd_inv_qi_setup(s->iq, s->iq_size);
         /* Ok - report back to driver */
@@ -2172,19 +2172,24 @@ static void vtd_handle_iotlb_write(IntelIOMMUState *s)
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
+    uint32_t dw = s->iq_dw ? 32 : 16;
+    dma_addr_t addr = base_addr + offset * dw;
+
+    if (dma_memory_read(&address_space_memory, addr, inv_desc, dw)) {
+        error_report_once("Read INV DESC failed.");
         return false;
     }
     inv_desc->lo = le64_to_cpu(inv_desc->lo);
     inv_desc->hi = le64_to_cpu(inv_desc->hi);
+    if (dw == 32) {
+        inv_desc->val[2] = le64_to_cpu(inv_desc->val[2]);
+        inv_desc->val[3] = le64_to_cpu(inv_desc->val[3]);
+    }
     return true;
 }
 
@@ -2390,10 +2395,11 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
     uint8_t desc_type;
 
     trace_vtd_inv_qi_head(s->iq_head);
-    if (!vtd_get_inv_desc(s->iq, s->iq_head, &inv_desc)) {
+    if (!vtd_get_inv_desc(s, &inv_desc)) {
         s->iq_last_desc_type = VTD_INV_DESC_NONE;
         return false;
     }
+
     desc_type = inv_desc.lo & VTD_INV_DESC_TYPE;
     /* FIXME: should update at first or at last? */
     s->iq_last_desc_type = desc_type;
@@ -2478,7 +2484,12 @@ static void vtd_handle_iqt_write(IntelIOMMUState *s)
 {
     uint64_t val = vtd_get_quad_raw(s, DMAR_IQT_REG);
 
-    s->iq_tail = VTD_IQT_QT(val);
+    if (s->iq_dw && (val & VTD_IQT_QT_256_RSV_BIT)) {
+        error_report_once("%s: RSV bit is set: val=0x%"PRIx64,
+                          __func__, val);
+        return;
+    }
+    s->iq_tail = VTD_IQT_QT(s->iq_dw, val);
     trace_vtd_inv_qi_tail(s->iq_tail);
 
     if (s->qi_enabled && !(vtd_get_long_raw(s, DMAR_FSTS_REG) & VTD_FSTS_IQE)) {
@@ -2747,6 +2758,12 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
         } else {
             vtd_set_quad(s, addr, val);
         }
+        if (s->ecap & VTD_ECAP_SMTS &&
+            val & VTD_IQA_DW_MASK) {
+            s->iq_dw = true;
+        } else {
+            s->iq_dw = false;
+        }
         break;
 
     case DMAR_IQA_REG_HI:
@@ -3455,6 +3472,7 @@ static void vtd_init(IntelIOMMUState *s)
     s->iq_size = 0;
     s->qi_enabled = false;
     s->iq_last_desc_type = VTD_INV_DESC_NONE;
+    s->iq_dw = false;
     s->next_frcd_reg = 0;
     s->cap = VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND |
              VTD_CAP_MAMV | VTD_CAP_PSI | VTD_CAP_SLLPS |
@@ -3532,7 +3550,7 @@ static void vtd_init(IntelIOMMUState *s)
 
     vtd_define_quad(s, DMAR_IQH_REG, 0, 0, 0);
     vtd_define_quad(s, DMAR_IQT_REG, 0, 0x7fff0ULL, 0);
-    vtd_define_quad(s, DMAR_IQA_REG, 0, 0xfffffffffffff007ULL, 0);
+    vtd_define_quad(s, DMAR_IQA_REG, 0, 0xfffffffffffff807ULL, 0);
     vtd_define_long(s, DMAR_ICS_REG, 0, 0, 0x1UL);
     vtd_define_long(s, DMAR_IECTL_REG, 0x80000000UL, 0x80000000UL, 0);
     vtd_define_long(s, DMAR_IEDATA_REG, 0, 0xffffffffUL, 0);
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index fe72bc3..016fa4c 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -190,6 +190,7 @@
 #define VTD_ECAP_EIM                (1ULL << 4)
 #define VTD_ECAP_PT                 (1ULL << 6)
 #define VTD_ECAP_MHMV               (15ULL << 20)
+#define VTD_ECAP_SMTS               (1ULL << 43)
 
 /* CAP_REG */
 /* (offset >> 4) << 24 */
@@ -218,11 +219,14 @@
 #define VTD_CAP_SAGAW_48bit         (0x4ULL << VTD_CAP_SAGAW_SHIFT)
 
 /* IQT_REG */
-#define VTD_IQT_QT(val)             (((val) >> 4) & 0x7fffULL)
+#define VTD_IQT_QT(dw_bit, val)     (dw_bit ? (((val) >> 5) & 0x3fffULL) : \
+                                     (((val) >> 4) & 0x7fffULL))
+#define VTD_IQT_QT_256_RSV_BIT      0x10
 
 /* IQA_REG */
 #define VTD_IQA_IQA_MASK(aw)        (VTD_HAW_MASK(aw) ^ 0xfffULL)
 #define VTD_IQA_QS                  0x7ULL
+#define VTD_IQA_DW_MASK             0x800
 
 /* IQH_REG */
 #define VTD_IQH_QH_SHIFT            4
@@ -324,6 +328,9 @@ union VTDInvDesc {
         uint64_t lo;
         uint64_t hi;
     };
+    struct {
+        uint64_t val[4];
+    };
     union {
         VTDInvDescIEC iec;
     };
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 72c5ca6..2877c94 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -238,6 +238,7 @@ struct IntelIOMMUState {
     uint16_t iq_tail;               /* Current invalidation queue tail */
     dma_addr_t iq;                  /* Current invalidation queue pointer */
     uint16_t iq_size;               /* IQ Size in number of entries */
+    bool iq_dw;                     /* IQ descriptor width 256bit or not */
     bool qi_enabled;                /* Set if the QI is enabled */
     uint8_t iq_last_desc_type;      /* The type of last completed descriptor */
 
-- 
1.9.1
