Received: from eggs.gnu.org ([2001:4830:134:3::10]:50782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1d3K89-0003ZT-Vt
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:25:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1d3K88-0002lW-W5
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:25:06 -0400
Received: from mga09.intel.com ([134.134.136.24]:7861)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1d3K88-0002j3-Hs
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:25:04 -0400
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Date: Wed, 26 Apr 2017 18:06:50 +0800
Message-Id: <1493201210-14357-21-git-send-email-yi.l.liu@linux.intel.com>
In-Reply-To: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
References: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
Subject: [Qemu-devel] [RFC PATCH 20/20] intel_iommu: propagate
 Ext-Device-TLB invalidate to host
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

For Extended-Device-TLB invalidation, intel_iommu emulator needs to check
all the assigned device and find the affected device. Replace the guest
SID with the host SID in the invalidate descriptor and pass the request to
host.

Host may just submit the request to corresponding invalidation queue in
pIOMMU. In future maybe PASID needs to be replaced.

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 hw/i386/intel_iommu.c          | 43 ++++++++++++++++++++++++++++++++++++++++++
 hw/i386/intel_iommu_internal.h |  7 +++++++
 2 files changed, 50 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index c5e9170..4370790 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2012,6 +2012,13 @@ static void vtd_tlb_inv_notify_hook(VTDNotifierIterator *iter,
         } else {
             return;
         }
+    case VTD_INV_DESC_EXT_DIOTLB:
+        if (iter->sid != *tlb_hook_info->sid) {
+            return;
+        }
+        tlb_hook_info->inv_desc->lo &= ~VTD_INV_DESC_EXT_DIOTLB_SID_MASK;
+        tlb_hook_info->inv_desc->lo |= (iter->host_sid << 16);
+        break;
     default:
         return;
     }
@@ -2147,6 +2154,34 @@ static bool vtd_process_pasid_desc(IntelIOMMUState *s,
     return true;
 }
 
+static bool vtd_process_ext_device_iotlb(IntelIOMMUState *s,
+                                         VTDInvDesc *inv_desc)
+{
+    uint32_t pasid;
+    uint16_t sid;
+    VTDIOTLBInvHookInfo tlb_hook_info;
+
+    if ((inv_desc->lo & VTD_INV_DESC_EXT_DIOTLB_RSVD_LO) ||
+        (inv_desc->hi & VTD_INV_DESC_EXT_DIOTLB_RSVD_HI)) {
+        VTD_DPRINTF(GENERAL, "error: non-zero reserved field in"
+                    " Device ExIOTLB desc, hi 0x%"PRIx64 " lo 0x%"PRIx64,
+                    inv_desc->hi, inv_desc->lo);
+        return false;
+    }
+
+    pasid = VTD_INV_DESC_EXT_DIOTLB_PASID(inv_desc->lo);
+    sid = VTD_INV_DESC_EXT_DIOTLB_SID(inv_desc->lo);
+
+    tlb_hook_info.did = NULL;
+    tlb_hook_info.sid = &sid;
+    tlb_hook_info.pasid = &pasid;
+    tlb_hook_info.inv_desc = inv_desc;
+    vtd_tlb_inv_passdown_notify(s,
+                                &tlb_hook_info,
+                                vtd_tlb_inv_notify_hook);
+    return true;
+}
+
 static bool vtd_process_inv_desc(IntelIOMMUState *s)
 {
     VTDInvDesc inv_desc;
@@ -2190,6 +2225,14 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
         }
         break;
 
+    case VTD_INV_DESC_EXT_DIOTLB:
+        trace_vtd_inv_desc("device-extended-iotlb",
+                           inv_desc.hi, inv_desc.lo);
+        if (!vtd_process_ext_device_iotlb(s, &inv_desc)) {
+            return false;
+        }
+        break;
+
     case VTD_INV_DESC_WAIT:
         trace_vtd_inv_desc("wait", inv_desc.hi, inv_desc.lo);
         if (!vtd_process_wait_desc(s, &inv_desc)) {
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index a6b9350..3cb2361 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -343,6 +343,7 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_INV_DESC_WAIT               0x5 /* Invalidation Wait Descriptor */
 #define VTD_INV_DESC_EXT_IOTLB          0x6 /* Ext-IOTLB Invalidate Desc */
 #define VTD_INV_DESC_PC                 0x7 /* PASID-cache Invalidate Desc */
+#define VTD_INV_DESC_EXT_DIOTLB         0x8 /* Ext-DIOTLB Invalidate Desc */
 #define VTD_INV_DESC_NONE               0   /* Not an Invalidate Descriptor */
 
 /* Masks for Invalidation Wait Descriptor*/
@@ -407,6 +408,12 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_INV_DESC_PASIDC_ALL_ALL    (0ULL << 4)
 #define VTD_INV_DESC_PASIDC_PASID_SI   (1ULL << 4)
 
+#define VTD_INV_DESC_EXT_DIOTLB_PASID(val) (((val) >> 32) & 0xfffffULL)
+#define VTD_INV_DESC_EXT_DIOTLB_SID(val)   (((val) >> 16) & 0xffff)
+#define VTD_INV_DESC_EXT_DIOTLB_RSVD_LO    0xe00ULL
+#define VTD_INV_DESC_EXT_DIOTLB_RSVD_HI    0x7feULL
+#define VTD_INV_DESC_EXT_DIOTLB_SID_MASK   0xFFFF0000ULL
+
 /* Information about page-selective IOTLB invalidate */
 struct VTDIOTLBPageInvInfo {
     uint16_t domain_id;
-- 
1.9.1
