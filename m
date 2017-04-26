Received: from eggs.gnu.org ([2001:4830:134:3::10]:50630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1d3K7l-0003BP-6V
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:24:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1d3K7j-0002cs-PK
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:24:41 -0400
Received: from mga07.intel.com ([134.134.136.100]:30840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1d3K7j-0002Z6-An
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:24:39 -0400
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Date: Wed, 26 Apr 2017 18:06:45 +0800
Message-Id: <1493201210-14357-16-git-send-email-yi.l.liu@linux.intel.com>
In-Reply-To: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
References: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
Subject: [Qemu-devel] [RFC PATCH 15/20] intel_iommu: link whole guest pasid
 table to host
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

VT-d has a nested mode which allows SVM virtualization. Link the whole
guest PASID table to host context entry and enable nested mode, pIOMMU
would do nested translation for DMA request. Thus achieve GVA->HPA
translation.

When extended-context-entry is modified in guest, intel_iommu emulator
should capture it, then link the whole guest PASID table to host and
enable nested mode for the assigned device.

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 hw/i386/intel_iommu.c          | 121 +++++++++++++++++++++++++++++++++++++++--
 hw/i386/intel_iommu_internal.h |  11 ++++
 2 files changed, 127 insertions(+), 5 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index f291995..cd6db65 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -36,6 +36,7 @@
 #include "hw/i386/apic_internal.h"
 #include "kvm_i386.h"
 #include "trace.h"
+#include <linux/iommu.h>
 
 /*#define DEBUG_INTEL_IOMMU*/
 #ifdef DEBUG_INTEL_IOMMU
@@ -55,6 +56,14 @@ static int vtd_dbgflags = VTD_DBGBIT(GENERAL) | VTD_DBGBIT(CSR);
 #define VTD_DPRINTF(what, fmt, ...) do {} while (0)
 #endif
 
+typedef void (*vtd_device_hook)(VTDNotifierIterator *iter,
+                                void *hook_info,
+                                void *notify_info);
+
+static void vtd_context_inv_notify_hook(VTDNotifierIterator *iter,
+                                        void *hook_info,
+                                        void *notify_info);
+
 #define FOR_EACH_ASSIGN_DEVICE(__notify_info_type, \
                                __opaque_type, \
                                __hook_info, \
@@ -1213,6 +1222,66 @@ static void vtd_iommu_replay_all(IntelIOMMUState *s)
     }
 }
 
+void vtd_context_inv_notify_hook(VTDNotifierIterator *iter,
+                                 void *hook_info,
+                                 void *notify_info)
+{
+    struct pasid_table_info *pasidt_info;
+    IOMMUNotifierData iommu_data;
+    VTDContextHookInfo *context_hook_info;
+    uint16_t *host_sid;
+    pasidt_info = (struct pasid_table_info *) notify_info;
+    context_hook_info = (VTDContextHookInfo *) hook_info;
+    switch (context_hook_info->gran) {
+    case VTD_INV_DESC_CC_GLOBAL:
+        /* Fall through */
+    case VTD_INV_DESC_CC_DOMAIN:
+        if (iter->did == *context_hook_info->did) {
+            break;
+        }
+        /* Fall through */
+    case VTD_INV_DESC_CC_DEVICE:
+        if ((iter->did == *context_hook_info->did) &&
+            (iter->sid == *context_hook_info->sid)) {
+            break;
+        }
+        /* Fall through */
+    default:
+        return;
+    }
+
+    pasidt_info->model = INTEL_IOMMU;
+    host_sid = (uint16_t *)&pasidt_info->opaque;
+
+    pasidt_info->ptr = iter->ce[1].lo;
+    pasidt_info->size = iter->ce[1].lo & VTD_PASID_TABLE_SIZE_MASK;
+    *host_sid = iter->host_sid;
+    iommu_data.payload = (uint8_t *) pasidt_info;
+    iommu_data.payload_size = sizeof(*pasidt_info) + sizeof(*host_sid);
+    memory_region_notify_iommu_svm_bind(&iter->vtd_as->iommu,
+                                        &iommu_data);
+    return;
+}
+
+static void vtd_context_cache_invalidate_notify(IntelIOMMUState *s,
+                                                uint16_t *did,
+                                                uint16_t *sid,
+                                                uint8_t gran,
+                                                vtd_device_hook hook_fn)
+{
+    VTDContextHookInfo context_hook_info = {
+        .did = did,
+        .sid = sid,
+        .gran = gran,
+    };
+
+    FOR_EACH_ASSIGN_DEVICE(struct pasid_table_info,
+                           uint16_t,
+                           &context_hook_info,
+                           hook_fn);
+    return;
+}
+
 static void vtd_context_global_invalidate(IntelIOMMUState *s)
 {
     trace_vtd_inv_desc_cc_global();
@@ -1228,8 +1297,35 @@ static void vtd_context_global_invalidate(IntelIOMMUState *s)
      * VT-d emulation codes.
      */
     vtd_iommu_replay_all(s);
+
+    if (s->svm) {
+        vtd_context_cache_invalidate_notify(s, NULL, NULL,
+                VTD_INV_DESC_CC_GLOBAL, vtd_context_inv_notify_hook);
+    }
 }
 
+static void vtd_context_domain_selective_invalidate(IntelIOMMUState *s,
+                                                    uint16_t did)
+{
+    trace_vtd_inv_desc_cc_global();
+    s->context_cache_gen++;
+    if (s->context_cache_gen == VTD_CONTEXT_CACHE_GEN_MAX) {
+        vtd_reset_context_cache(s);
+    }
+    /*
+     * From VT-d spec 6.5.2.1, a global context entry invalidation
+     * should be followed by a IOTLB global invalidation, so we should
+     * be safe even without this. Hoewever, let's replay the region as
+     * well to be safer, and go back here when we need finer tunes for
+     * VT-d emulation codes.
+     */
+    vtd_iommu_replay_all(s);
+
+    if (s->svm) {
+        vtd_context_cache_invalidate_notify(s, &did, NULL,
+                 VTD_INV_DESC_CC_DOMAIN, vtd_context_inv_notify_hook);
+    }
+}
 
 /* Find the VTD address space currently associated with a given bus number,
  */
@@ -1258,13 +1354,14 @@ static VTDBus *vtd_find_as_from_bus_num(IntelIOMMUState *s, uint8_t bus_num)
  */
 static void vtd_context_device_invalidate(IntelIOMMUState *s,
                                           uint16_t source_id,
+                                          uint16_t did,
                                           uint16_t func_mask)
 {
     uint16_t mask;
     VTDBus *vtd_bus;
     VTDAddressSpace *vtd_as;
     uint8_t bus_n, devfn;
-    uint16_t devfn_it;
+    uint16_t devfn_it, sid_it;
 
     trace_vtd_inv_desc_cc_devices(source_id, func_mask);
 
@@ -1311,6 +1408,12 @@ static void vtd_context_device_invalidate(IntelIOMMUState *s,
                  * happened.
                  */
                 memory_region_iommu_replay_all(&vtd_as->iommu);
+                if (s->svm) {
+                    sid_it = vtd_make_source_id(pci_bus_num(vtd_bus->bus),
+                                                devfn_it);
+                    vtd_context_cache_invalidate_notify(s, &did, &sid_it,
+                        VTD_INV_DESC_CC_DEVICE, vtd_context_inv_notify_hook);
+                }
             }
         }
     }
@@ -1324,6 +1427,7 @@ static uint64_t vtd_context_cache_invalidate(IntelIOMMUState *s, uint64_t val)
 {
     uint64_t caig;
     uint64_t type = val & VTD_CCMD_CIRG_MASK;
+    uint16_t did;
 
     switch (type) {
     case VTD_CCMD_DOMAIN_INVL:
@@ -1338,7 +1442,9 @@ static uint64_t vtd_context_cache_invalidate(IntelIOMMUState *s, uint64_t val)
 
     case VTD_CCMD_DEVICE_INVL:
         caig = VTD_CCMD_DEVICE_INVL_A;
-        vtd_context_device_invalidate(s, VTD_CCMD_SID(val), VTD_CCMD_FM(val));
+        did = VTD_CCMD_DID(val);
+        vtd_context_device_invalidate(s, VTD_CCMD_SID(val),
+                                      did, VTD_CCMD_FM(val));
         break;
 
     default:
@@ -1720,7 +1826,7 @@ static bool vtd_process_wait_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
 static bool vtd_process_context_cache_desc(IntelIOMMUState *s,
                                            VTDInvDesc *inv_desc)
 {
-    uint16_t sid, fmask;
+    uint16_t sid, fmask, did;
 
     if ((inv_desc->lo & VTD_INV_DESC_CC_RSVD) || inv_desc->hi) {
         trace_vtd_inv_desc_cc_invalid(inv_desc->hi, inv_desc->lo);
@@ -1728,17 +1834,22 @@ static bool vtd_process_context_cache_desc(IntelIOMMUState *s,
     }
     switch (inv_desc->lo & VTD_INV_DESC_CC_G) {
     case VTD_INV_DESC_CC_DOMAIN:
+        did = VTD_INV_DESC_CC_DID(inv_desc->lo);
+        vtd_context_domain_selective_invalidate(s, did);
         trace_vtd_inv_desc_cc_domain(
             (uint16_t)VTD_INV_DESC_CC_DID(inv_desc->lo));
-        /* Fall through */
+        break;
     case VTD_INV_DESC_CC_GLOBAL:
+        trace_vtd_inv_desc_cc_domain(
+            (uint16_t)VTD_INV_DESC_CC_DID(inv_desc->lo));
         vtd_context_global_invalidate(s);
         break;
 
     case VTD_INV_DESC_CC_DEVICE:
         sid = VTD_INV_DESC_CC_SID(inv_desc->lo);
         fmask = VTD_INV_DESC_CC_FM(inv_desc->lo);
-        vtd_context_device_invalidate(s, sid, fmask);
+        did = VTD_INV_DESC_CC_DID(inv_desc->lo);
+        vtd_context_device_invalidate(s, sid, did, fmask);
         break;
 
     default:
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 5178398..5ab7d77 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -439,6 +439,14 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_EXT_CONTEXT_TT_NO_DEV_IOTLB   (4ULL << 2)
 #define VTD_EXT_CONTEXT_TT_DEV_IOTLB      (5ULL << 2)
 
+struct VTDContextHookInfo {
+    uint16_t *did;
+    uint16_t *sid;
+    uint8_t  gran;
+};
+
+typedef struct VTDContextHookInfo VTDContextHookInfo;
+
 struct VTDNotifierIterator {
     VTDAddressSpace *vtd_as;
     VTDContextEntry *ce;
@@ -450,6 +458,9 @@ struct VTDNotifierIterator {
 
 typedef struct VTDNotifierIterator VTDNotifierIterator;
 
+/* Masks for struct VTDContextEntry - Extended Context */
+#define VTD_PASID_TABLE_SIZE_MASK 0xf
+
 /* Paging Structure common */
 #define VTD_SL_PT_PAGE_SIZE_MASK    (1ULL << 7)
 /* Bits to decide the offset for each level */
-- 
1.9.1
