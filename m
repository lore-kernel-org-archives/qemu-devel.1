Received: from eggs.gnu.org ([2001:4830:134:3::10]:50760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1d3K87-0003Wq-0c
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:25:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1d3K84-0002jx-RP
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:25:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:7861)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1d3K84-0002j3-DA
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:25:00 -0400
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Date: Wed, 26 Apr 2017 18:06:49 +0800
Message-Id: <1493201210-14357-20-git-send-email-yi.l.liu@linux.intel.com>
In-Reply-To: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
References: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
Subject: [Qemu-devel] [RFC PATCH 19/20] intel_iommu: propagate PASID-Cache
 invalidate to host
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

This patch adds support for propagating PASID-Cache invalidation to host.
Similar with Extended-IOTLB invalidation, intel_iommu emulator would also
check all the assigned devices and do sanity check, then pass it to host.

Host pIOMMU driver would replace some fields in the raw data before
submitting to pIOMMU. e.g. guest domain ID must be replaced with the real
domain ID in host. In future PASID may need to be replaced.

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 hw/i386/intel_iommu.c          | 56 ++++++++++++++++++++++++++++++++++++++++++
 hw/i386/intel_iommu_internal.h | 10 ++++++++
 2 files changed, 66 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 5fbb7f1..c5e9170 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2006,6 +2006,7 @@ static void vtd_tlb_inv_notify_hook(VTDNotifierIterator *iter,
     tlb_hook_info = (VTDIOTLBInvHookInfo *) hook_info;
     switch (tlb_hook_info->inv_desc->lo & VTD_INV_DESC_TYPE) {
     case VTD_INV_DESC_EXT_IOTLB:
+    case VTD_INV_DESC_PC:
         if (iter->did == *tlb_hook_info->did) {
             break;
         } else {
@@ -2098,6 +2099,54 @@ static bool vtd_process_exiotlb_desc(IntelIOMMUState *s,
     return true;
 }
 
+static bool vtd_process_pasid_desc(IntelIOMMUState *s,
+                                   VTDInvDesc *inv_desc)
+{
+    uint16_t domain_id;
+    uint32_t pasid;
+    VTDIOTLBInvHookInfo tlb_hook_info;
+
+    if ((inv_desc->lo & VTD_INV_DESC_PASIDC_RSVD_LO) ||
+        (inv_desc->hi & VTD_INV_DESC_PASIDC_RSVD_HI)) {
+        VTD_DPRINTF(GENERAL, "error: non-zero reserved field"
+                    " in PASID desc, hi 0x%"PRIx64 " lo 0x%"PRIx64,
+                    inv_desc->hi, inv_desc->lo);
+        return false;
+    }
+
+    domain_id = VTD_INV_DESC_PASIDC_DID(inv_desc->lo);
+
+    switch (inv_desc->lo & VTD_INV_DESC_PASIDC_G) {
+    case VTD_INV_DESC_PASIDC_ALL_ALL:
+        VTD_DPRINTF(INV, "Invalidate all PASID");
+        break;
+
+    case VTD_INV_DESC_PASIDC_PASID_SI:
+        VTD_DPRINTF(INV, "pasid-selective invalidation"
+                    " domain 0x%"PRIx16, domain_id);
+        break;
+
+    default:
+        VTD_DPRINTF(GENERAL, "error: invalid granularity"
+                    " in PASID-Cache Invalidate Descriptor"
+                    " hi 0x%"PRIx64 " lo 0x%"PRIx64,
+                    inv_desc->hi, inv_desc->lo);
+        return false;
+    }
+
+    pasid = VTD_INV_DESC_PASIDC_PASID(inv_desc->lo);
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
@@ -2134,6 +2183,13 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
         }
         break;
 
+     case VTD_INV_DESC_PC:
+        trace_vtd_inv_desc("pasid-cache", inv_desc.hi, inv_desc.lo);
+        if (!vtd_process_pasid_desc(s, &inv_desc)) {
+            return false;
+        }
+        break;
+
     case VTD_INV_DESC_WAIT:
         trace_vtd_inv_desc("wait", inv_desc.hi, inv_desc.lo);
         if (!vtd_process_wait_desc(s, &inv_desc)) {
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 9f89751..a6b9350 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -342,6 +342,7 @@ typedef union VTDInvDesc VTDInvDesc;
                                                Invalidate Descriptor */
 #define VTD_INV_DESC_WAIT               0x5 /* Invalidation Wait Descriptor */
 #define VTD_INV_DESC_EXT_IOTLB          0x6 /* Ext-IOTLB Invalidate Desc */
+#define VTD_INV_DESC_PC                 0x7 /* PASID-cache Invalidate Desc */
 #define VTD_INV_DESC_NONE               0   /* Not an Invalidate Descriptor */
 
 /* Masks for Invalidation Wait Descriptor*/
@@ -397,6 +398,15 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_INV_DESC_EXIOTLB_IH(val)       (((val) >> 6) & 0x1)
 #define VTD_INV_DESC_EXIOTLB_GL(val)       (((val) >> 7) & 0x1)
 
+#define VTD_INV_DESC_PASIDC_G          (3ULL << 4)
+#define VTD_INV_DESC_PASIDC_PASID(val) (((val) >> 32) & 0xfffffULL)
+#define VTD_INV_DESC_PASIDC_DID(val)   (((val) >> 16) & VTD_DOMAIN_ID_MASK)
+#define VTD_INV_DESC_PASIDC_RSVD_LO    0xfff000000000ffc0ULL
+#define VTD_INV_DESC_PASIDC_RSVD_HI    0xffffffffffffffffULL
+
+#define VTD_INV_DESC_PASIDC_ALL_ALL    (0ULL << 4)
+#define VTD_INV_DESC_PASIDC_PASID_SI   (1ULL << 4)
+
 /* Information about page-selective IOTLB invalidate */
 struct VTDIOTLBPageInvInfo {
     uint16_t domain_id;
-- 
1.9.1
