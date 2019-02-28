Received: from eggs.gnu.org ([209.51.188.92]:45546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.y.sun@linux.intel.com>) id 1gzMZ2-0002Zg-Lg
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 09:21:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.y.sun@linux.intel.com>) id 1gzMZ1-00075C-Ac
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 09:21:32 -0500
Received: from mga07.intel.com ([134.134.136.100]:44785)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.y.sun@linux.intel.com>)
	id 1gzMZ0-000727-T9
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 09:21:31 -0500
From: Yi Sun <yi.y.sun@linux.intel.com>
Date: Thu, 28 Feb 2019 21:47:57 +0800
Message-Id: <1551361677-28933-4-git-send-email-yi.y.sun@linux.intel.com>
In-Reply-To: <1551361677-28933-1-git-send-email-yi.y.sun@linux.intel.com>
References: <1551361677-28933-1-git-send-email-yi.y.sun@linux.intel.com>
Subject: [Qemu-devel] [RFC v2 3/3] intel_iommu: add scalable-mode option to
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
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com, Yi Sun <yi.y.sun@linux.intel.com>

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
v2:
    - rename "scalable-mode" to "x-scalable-mode".
    - remove caching_mode check when scalable_mode is set.
    - check dma_drain check when scalable_mode is set. This is requested
      by spec.
    - remove redundant macros.
---
 hw/i386/intel_iommu.c          | 24 ++++++++++++++++++++++++
 hw/i386/intel_iommu_internal.h |  4 ++++
 include/hw/i386/intel_iommu.h  |  3 ++-
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index d1eb0c5..ec7722d 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1733,6 +1733,9 @@ static void vtd_root_table_setup(IntelIOMMUState *s)
 {
     s->root = vtd_get_quad_raw(s, DMAR_RTADDR_REG);
     s->root_extended = s->root & VTD_RTADDR_RTT;
+    if (s->scalable_mode) {
+        s->root_scalable = s->root & VTD_RTADDR_SMT;
+    }
     s->root &= VTD_RTADDR_ADDR_MASK(s->aw_bits);
 
     trace_vtd_reg_dmar_root(s->root, s->root_extended);
@@ -2442,6 +2445,17 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
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
         trace_vtd_inv_desc("wait", inv_desc.hi, inv_desc.lo);
         if (!vtd_process_wait_desc(s, &inv_desc)) {
@@ -3006,6 +3020,7 @@ static Property vtd_properties[] = {
     DEFINE_PROP_UINT8("aw-bits", IntelIOMMUState, aw_bits,
                       VTD_HOST_ADDRESS_WIDTH),
     DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALSE),
+    DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState, scalable_mode, FALSE),
     DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -3540,6 +3555,15 @@ static void vtd_init(IntelIOMMUState *s)
         s->cap |= VTD_CAP_CM;
     }
 
+    /* TODO: read cap/ecap from host to decide which cap to be exposed. */
+    if (s->scalable_mode) {
+        if (!s->dma_drain) {
+            error_report("Need to set dma_drain for scalable mode");
+            exit(1);
+        }
+        s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_SRS | VTD_ECAP_SLTS;
+    }
+
     vtd_reset_caches(s);
 
     /* Define registers with default values and bit semantics */
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 016fa4c..1160618 100644
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
@@ -345,6 +347,8 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_INV_DESC_IEC                0x4 /* Interrupt Entry Cache
                                                Invalidate Descriptor */
 #define VTD_INV_DESC_WAIT               0x5 /* Invalidation Wait Descriptor */
+#define VTD_INV_DESC_PIOTLB             0x6 /* PASID-IOTLB Invalidate Desc */
+#define VTD_INV_DESC_PC                 0x7 /* PASID-cache Invalidate Desc */
 #define VTD_INV_DESC_NONE               0   /* Not an Invalidate Descriptor */
 
 /* Masks for Invalidation Wait Descriptor*/
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 2877c94..c11e3d5 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -227,7 +227,8 @@ struct IntelIOMMUState {
     uint8_t womask[DMAR_REG_SIZE];  /* WO (write only - read returns 0) */
     uint32_t version;
 
-    bool caching_mode;          /* RO - is cap CM enabled? */
+    bool caching_mode;              /* RO - is cap CM enabled? */
+    bool scalable_mode;             /* RO - is Scalable Mode supported? */
 
     dma_addr_t root;                /* Current root table pointer */
     bool root_extended;             /* Type of root table (extended or not) */
-- 
1.9.1
