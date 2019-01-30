Received: from eggs.gnu.org ([209.51.188.92]:54377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.y.sun@linux.intel.com>) id 1goie8-0004K1-QM
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 00:42:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.y.sun@linux.intel.com>) id 1goie7-0005OQ-LU
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 00:42:48 -0500
Received: from mga02.intel.com ([134.134.136.20]:63851)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.y.sun@linux.intel.com>)
	id 1goie7-0005Gl-Dn
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 00:42:47 -0500
From: Yi Sun <yi.y.sun@linux.intel.com>
Date: Wed, 30 Jan 2019 13:09:13 +0800
Message-Id: <1548824953-23413-4-git-send-email-yi.y.sun@linux.intel.com>
In-Reply-To: <1548824953-23413-1-git-send-email-yi.y.sun@linux.intel.com>
References: <1548824953-23413-1-git-send-email-yi.y.sun@linux.intel.com>
Subject: [Qemu-devel] [RFC v1 3/3] intel_iommu: add scalable-mode option to
 make scalable mode work
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

This patch adds an option to provide flexibility for user to expose
Scalable Mode to guest. User could expose Scalable Mode to guest by
the config as below:

"-device intel-iommu,caching-mode=on,scalable-mode=on"

The Linux iommu driver has supported scalable mode. Please refer below
patch set:

    https://www.spinics.net/lists/kernel/msg2985279.html

Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
---
 hw/i386/intel_iommu.c          | 22 ++++++++++++++++++++++
 hw/i386/intel_iommu_internal.h |  6 ++++++
 include/hw/i386/intel_iommu.h  |  3 ++-
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 3664a00..447fdf3 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2492,6 +2492,17 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
         }
         break;
 
+    /*
+     * TODO: the entity of below two cases will be implemented in future series.
+     * To make guest (which integrates scalable mode support patch set in
+     * iommu driver) work, just return true is enough so far.
+     */
+    case VTD_INV_DESC_PC:
+        break;
+
+    case VTD_INV_DESC_PIOTLB:
+        break;
+
     case VTD_INV_DESC_WAIT:
         trace_vtd_inv_desc("wait", inv_desc.val[1], inv_desc.val[0]);
         if (!vtd_process_wait_desc(s, &inv_desc)) {
@@ -3051,6 +3062,7 @@ static Property vtd_properties[] = {
     DEFINE_PROP_UINT8("aw-bits", IntelIOMMUState, aw_bits,
                       VTD_HOST_ADDRESS_WIDTH),
     DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALSE),
+    DEFINE_PROP_BOOL("scalable-mode", IntelIOMMUState, scalable_mode, FALSE),
     DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -3583,6 +3595,16 @@ static void vtd_init(IntelIOMMUState *s)
         s->cap |= VTD_CAP_CM;
     }
 
+    /* TODO: read cap/ecap from host to decide which cap to be exposed. */
+    if (s->scalable_mode) {
+        if (!s->caching_mode) {
+            error_report("Need to set caching-mode for scalable mode");
+            exit(1);
+        }
+        s->cap |= VTD_CAP_DWD | VTD_CAP_DRD;
+        s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_SRS | VTD_ECAP_SLTS;
+    }
+
     vtd_reset_caches(s);
 
     /* Define registers with default values and bit semantics */
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 2a753c5..b01953a 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -190,7 +190,9 @@
 #define VTD_ECAP_EIM                (1ULL << 4)
 #define VTD_ECAP_PT                 (1ULL << 6)
 #define VTD_ECAP_MHMV               (15ULL << 20)
+#define VTD_ECAP_SRS                (1ULL << 31)
 #define VTD_ECAP_SMTS               (1ULL << 43)
+#define VTD_ECAP_SLTS               (1ULL << 46)
 
 /* CAP_REG */
 /* (offset >> 4) << 24 */
@@ -209,6 +211,8 @@
 #define VTD_CAP_DRAIN_READ          (1ULL << 55)
 #define VTD_CAP_DRAIN               (VTD_CAP_DRAIN_READ | VTD_CAP_DRAIN_WRITE)
 #define VTD_CAP_CM                  (1ULL << 7)
+#define VTD_CAP_DWD                 (1ULL << 54)
+#define VTD_CAP_DRD                 (1ULL << 55)
 
 /* Supported Adjusted Guest Address Widths */
 #define VTD_CAP_SAGAW_SHIFT         8
@@ -340,6 +344,8 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_INV_DESC_IEC                0x4 /* Interrupt Entry Cache
                                                Invalidate Descriptor */
 #define VTD_INV_DESC_WAIT               0x5 /* Invalidation Wait Descriptor */
+#define VTD_INV_DESC_PIOTLB             0x6 /* PASID-IOTLB Invalidate Desc */
+#define VTD_INV_DESC_PC                 0x7 /* PASID-cache Invalidate Desc */
 #define VTD_INV_DESC_NONE               0   /* Not an Invalidate Descriptor */
 
 /* Masks for Invalidation Wait Descriptor*/
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index a5da139..a04fad6 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -219,7 +219,8 @@ struct IntelIOMMUState {
     uint8_t womask[DMAR_REG_SIZE];  /* WO (write only - read returns 0) */
     uint32_t version;
 
-    bool caching_mode;          /* RO - is cap CM enabled? */
+    bool caching_mode;              /* RO - is cap CM enabled? */
+    bool scalable_mode;             /* RO - is Scalable Mode supported? */
 
     dma_addr_t root;                /* Current root table pointer */
     bool root_extended;             /* Type of root table (extended or not) */
-- 
1.9.1
