Received: from eggs.gnu.org ([2001:4830:134:3::10]:50758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1d3K87-0003Wp-04
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:25:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1d3K82-0002jQ-14
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:25:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:7861)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1d3K81-0002j3-KT
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:24:57 -0400
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Date: Wed, 26 Apr 2017 18:06:48 +0800
Message-Id: <1493201210-14357-19-git-send-email-yi.l.liu@linux.intel.com>
In-Reply-To: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
References: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
Subject: [Qemu-devel] [RFC PATCH 18/20] intel_iommu: propagate
 Extended-IOTLB invalidate to host
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

The invalidation of Extended-IOTLB invalidates first-level and nested
mappings from the IOTLB and the paging-structure-caches.

For SVM virtualization, iommu tlb invalidate notifier is added. The reason
is as below:

* On VT-d, MAP/UNMAP notifier would be used to shadow the changes of the
  guest second-level page table. While for the 1st-level page table, is
  not shadowed like the way of second-level page table. Actually, the
  guest 1st-level page table is linked to host after the whole guest PASID
  table is linked to host. 1st-level page table is owned by guest in this
  SVM virtualization solution for VT-d. Guest should have modified the
  1st-level page table in memory before it issues the invalidate request
  for 1st-level mappings, so MAP/UNMAP notifier is not suitable for the
  invalidation of guest 1st-level mappings.

* Since guest owns the 1st-level page table, host have no knowledge about
  the invalidations to 1st-level related mappings. So intel_iommu emulator
  needs to propagate the invalidate request to host, then host invalidates
  the 1st-level and nested mapping in IOTLB and paging-structure-caches on
  host. So a new notifier is added to meet such requirement.

Before passing the invalidate request to host, intel_iommu emulator needs
to do specific translation to the invalidation request. e.g. granularity
translation, needs to limit the scope of the invalidate.

This patchset proposes passing raw data from guest to host when propagating
the guest IOMMU TLB invalidation. As the cover letter mentioned, there is
both pros and cons for passing raw data. Would be pleased to see comments
on the way how to pass the invalidate request to host.

For Extended-IOTLB invalidation, intel_iommu emulator would check all the
assigned devices to see if the device is affected by the invalidate request,
also intel_iommu emulator needs to do sanity check to the invalidate request
and then pass it to host.

Host would replace some fields in the raw data before submitting to pIOMMU.
e.g. guest domain ID must be replaced with the real domain ID in host. In
future PASID may also need to be replaced.

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 hw/i386/intel_iommu.c          | 126 +++++++++++++++++++++++++++++++++++++++++
 hw/i386/intel_iommu_internal.h |  33 +++++++++++
 2 files changed, 159 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index cd6db65..5fbb7f1 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -64,6 +64,10 @@ static void vtd_context_inv_notify_hook(VTDNotifierIterator *iter,
                                         void *hook_info,
                                         void *notify_info);
 
+static void vtd_tlb_inv_notify_hook(VTDNotifierIterator *iter,
+                                    void *hook_info,
+                                    void *notify_info);
+
 #define FOR_EACH_ASSIGN_DEVICE(__notify_info_type, \
                                __opaque_type, \
                                __hook_info, \
@@ -1979,6 +1983,121 @@ done:
     return true;
 }
 
+static void vtd_tlb_inv_passdown_notify(IntelIOMMUState *s,
+                                        VTDIOTLBInvHookInfo *hook_info,
+                                        vtd_device_hook hook_fn)
+{
+    FOR_EACH_ASSIGN_DEVICE(struct tlb_invalidate_info,
+                           VTDInvalidateData,
+                           hook_info,
+                           hook_fn);
+    return;
+}
+
+static void vtd_tlb_inv_notify_hook(VTDNotifierIterator *iter,
+                             void *hook_info,
+                             void *notify_info)
+{
+    struct tlb_invalidate_info *tlb_inv_info;
+    IOMMUNotifierData iommu_data;
+    VTDIOTLBInvHookInfo *tlb_hook_info;
+    VTDInvalidateData *inv_data;
+    tlb_inv_info = (struct tlb_invalidate_info *) notify_info;
+    tlb_hook_info = (VTDIOTLBInvHookInfo *) hook_info;
+    switch (tlb_hook_info->inv_desc->lo & VTD_INV_DESC_TYPE) {
+    case VTD_INV_DESC_EXT_IOTLB:
+        if (iter->did == *tlb_hook_info->did) {
+            break;
+        } else {
+            return;
+        }
+    default:
+        return;
+    }
+
+    tlb_inv_info->model = INTEL_IOMMU;
+
+    inv_data = (VTDInvalidateData *)&tlb_inv_info->opaque;
+    inv_data->pasid = *tlb_hook_info->pasid;
+    inv_data->sid = iter->host_sid;
+    inv_data->inv_desc = *tlb_hook_info->inv_desc;
+
+    iommu_data.payload = (uint8_t *) tlb_inv_info;
+    iommu_data.payload_size = sizeof(*tlb_inv_info) + sizeof(*inv_data);
+
+    memory_region_notify_iommu_invalidate(&iter->vtd_as->iommu,
+                                          &iommu_data);
+}
+
+static bool vtd_process_exiotlb_desc(IntelIOMMUState *s,
+                                     VTDInvDesc *inv_desc)
+{
+    uint16_t domain_id;
+    uint32_t pasid;
+    uint8_t am;
+    VTDIOTLBInvHookInfo tlb_hook_info;
+
+    if ((inv_desc->lo & VTD_INV_DESC_EXIOTLB_RSVD_LO) ||
+        (inv_desc->hi & VTD_INV_DESC_EXIOTLB_RSVD_HI)) {
+        VTD_DPRINTF(GENERAL, "error: non-zero reserved field in"
+                    "EXIOTLB Invalidate Descriptor hi 0x%"PRIx64
+                    " lo 0x%"PRIx64, inv_desc->hi, inv_desc->lo);
+        return false;
+    }
+
+    domain_id = VTD_INV_DESC_EXIOTLB_DID(inv_desc->lo);
+    switch (inv_desc->lo & VTD_INV_DESC_IOTLB_G) {
+    case VTD_INV_DESC_EXIOTLB_ALL_ALL:
+        VTD_DPRINTF(INV, "Invalidate all within ALL PASID");
+        inv_desc->lo &= ~VTD_INV_DESC_IOTLB_G;
+        inv_desc->lo |= VTD_INV_DESC_EXIOTLB_NONG_PASID;
+        break;
+
+    case VTD_INV_DESC_EXIOTLB_NONG_ALL:
+        VTD_DPRINTF(INV, "Invalidate non-global within ALL PASID");
+        break;
+
+    case VTD_INV_DESC_EXIOTLB_NONG_PASID:
+        VTD_DPRINTF(INV, "Invalidate non-global within slective-PASID,"
+                    "domain 0x%"PRIx16, domain_id);
+
+        break;
+
+    case VTD_INV_DESC_EXIOTLB_PSI_PASID:
+        am = VTD_INV_DESC_EXIOTLB_AM(inv_desc->hi);
+        VTD_DPRINTF(INV, "Invalidate selective-page within selective-"
+                         "PASID, domain 0x%"PRIx16 " addr 0x%"PRIx64
+                         " mask %"PRIu8, domain_id,
+                         (hwaddr) VTD_INV_DESC_EXIOTLB_ADDR(inv_desc->hi),
+                          am);
+        if (am > VTD_MAMV) {
+            VTD_DPRINTF(GENERAL, "error: supported max address mask value"
+                        "is %"PRIu8, (uint8_t)VTD_MAMV);
+            return false;
+        }
+
+        break;
+
+    default:
+        VTD_DPRINTF(GENERAL, "error: invalid granularity in Ex-IOTLB"
+                    "Invalidate Descriptor hi 0x%"PRIx64 " lo 0x%"PRIx64,
+                    inv_desc->hi, inv_desc->lo);
+        return false;
+    }
+
+    pasid = VTD_INV_DESC_EXIOTLB_PASID(inv_desc->lo);
+
+    tlb_hook_info.did = &domain_id;
+    tlb_hook_info.sid = NULL;
+    tlb_hook_info.pasid = &pasid;
+    tlb_hook_info.inv_desc = inv_desc;
+    vtd_tlb_inv_passdown_notify(s,
+                                &tlb_hook_info,
+                                vtd_tlb_inv_notify_hook);
+
+    return true;
+}
+
 static bool vtd_process_inv_desc(IntelIOMMUState *s)
 {
     VTDInvDesc inv_desc;
@@ -2008,6 +2127,13 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
         }
         break;
 
+    case VTD_INV_DESC_EXT_IOTLB:
+        trace_vtd_inv_desc("extended-iotlb", inv_desc.hi, inv_desc.lo);
+        if (!vtd_process_exiotlb_desc(s, &inv_desc)) {
+            return false;
+        }
+        break;
+
     case VTD_INV_DESC_WAIT:
         trace_vtd_inv_desc("wait", inv_desc.hi, inv_desc.lo);
         if (!vtd_process_wait_desc(s, &inv_desc)) {
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 5ab7d77..9f89751 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -341,6 +341,7 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_INV_DESC_IEC                0x4 /* Interrupt Entry Cache
                                                Invalidate Descriptor */
 #define VTD_INV_DESC_WAIT               0x5 /* Invalidation Wait Descriptor */
+#define VTD_INV_DESC_EXT_IOTLB          0x6 /* Ext-IOTLB Invalidate Desc */
 #define VTD_INV_DESC_NONE               0   /* Not an Invalidate Descriptor */
 
 /* Masks for Invalidation Wait Descriptor*/
@@ -380,6 +381,22 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_INV_DESC_DEVICE_IOTLB_RSVD_HI 0xffeULL
 #define VTD_INV_DESC_DEVICE_IOTLB_RSVD_LO 0xffff0000ffe0fff8
 
+#define VTD_INV_DESC_EXIOTLB_ALL_ALL       (0ULL << 4)
+#define VTD_INV_DESC_EXIOTLB_NONG_ALL      (1ULL << 4)
+#define VTD_INV_DESC_EXIOTLB_NONG_PASID    (2ULL << 4)
+#define VTD_INV_DESC_EXIOTLB_PSI_PASID     (3ULL << 4)
+
+#define VTD_INV_DESC_EXIOTLB_RSVD_LO       0xfff000000000ffc0ULL
+#define VTD_INV_DESC_EXIOTLB_RSVD_HI       0xf00ULL
+
+#define VTD_INV_DESC_EXIOTLB_PASID(val)    (((val) >> 32) & 0xfffffULL)
+#define VTD_INV_DESC_EXIOTLB_DID(val)      (((val) >> 16) & \
+                                             VTD_DOMAIN_ID_MASK)
+#define VTD_INV_DESC_EXIOTLB_ADDR(val)     ((val) & ~0xfffULL)
+#define VTD_INV_DESC_EXIOTLB_AM(val)       ((val) & 0x3fULL)
+#define VTD_INV_DESC_EXIOTLB_IH(val)       (((val) >> 6) & 0x1)
+#define VTD_INV_DESC_EXIOTLB_GL(val)       (((val) >> 7) & 0x1)
+
 /* Information about page-selective IOTLB invalidate */
 struct VTDIOTLBPageInvInfo {
     uint16_t domain_id;
@@ -388,6 +405,13 @@ struct VTDIOTLBPageInvInfo {
 };
 typedef struct VTDIOTLBPageInvInfo VTDIOTLBPageInvInfo;
 
+struct VTDInvalidateData {
+    uint16_t sid; /* it is a physical SID instead of guest SID */
+    uint32_t pasid;
+    VTDInvDesc inv_desc;
+};
+typedef struct VTDInvalidateData VTDInvalidateData;
+
 /* Pagesize of VTD paging structures, including root and context tables */
 #define VTD_PAGE_SHIFT              12
 #define VTD_PAGE_SIZE               (1ULL << VTD_PAGE_SHIFT)
@@ -447,6 +471,15 @@ struct VTDContextHookInfo {
 
 typedef struct VTDContextHookInfo VTDContextHookInfo;
 
+struct VTDIOTLBInvHookInfo {
+    uint16_t *did;
+    uint32_t *pasid;
+    uint16_t *sid;
+    VTDInvDesc *inv_desc;
+};
+
+typedef struct  VTDIOTLBInvHookInfo VTDIOTLBInvHookInfo;
+
 struct VTDNotifierIterator {
     VTDAddressSpace *vtd_as;
     VTDContextEntry *ce;
-- 
1.9.1
