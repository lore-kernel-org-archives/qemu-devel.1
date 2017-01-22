Received: from eggs.gnu.org ([2001:4830:134:3::10]:45936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cV8Fv-0005Zl-I5
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 21:51:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cV8Fr-0000Al-Lh
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 21:51:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cV8Fr-0000AO-Fg
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 21:51:43 -0500
From: Peter Xu <peterx@redhat.com>
Date: Sun, 22 Jan 2017 10:51:36 +0800
Message-Id: <1485053496-7524-1-git-send-email-peterx@redhat.com>
In-Reply-To: <1484917736-32056-5-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH RFC v4.1 04/20] intel_iommu: add "caching-mode"
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, peterx@redhat.com, alex.williamson@redhat.com, bd.aviv@gmail.com, eblake@redhat.com

From: Aviv Ben-David <bd.aviv@gmail.com>

This capability asks the guest to invalidate cache before each map operation.
We can use this invalidation to trap map operations in the hypervisor.

Signed-off-by: Aviv Ben-David <bd.aviv@gmail.com>
[peterx: using "caching-mode" instead of "cache-mode" to align with spec]
[peterx: re-write the subject to make it short and clear]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c          | 5 +++++
 hw/i386/intel_iommu_internal.h | 1 +
 include/hw/i386/intel_iommu.h  | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index ec62239..e58f1de 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2107,6 +2107,7 @@ static Property vtd_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO("eim", IntelIOMMUState, intr_eim,
                             ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BOOL("x-buggy-eim", IntelIOMMUState, buggy_eim, false),
+    DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALSE),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -2488,6 +2489,10 @@ static void vtd_init(IntelIOMMUState *s)
         s->ecap |= VTD_ECAP_DT;
     }
 
+    if (s->caching_mode) {
+        s->cap |= VTD_CAP_CM;
+    }
+
     vtd_reset_context_cache(s);
     vtd_reset_iotlb(s);
 
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 356f188..4104121 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -202,6 +202,7 @@
 #define VTD_CAP_MAMV                (VTD_MAMV << 48)
 #define VTD_CAP_PSI                 (1ULL << 39)
 #define VTD_CAP_SLLPS               ((1ULL << 34) | (1ULL << 35))
+#define VTD_CAP_CM                  (1ULL << 7)
 
 /* Supported Adjusted Guest Address Widths */
 #define VTD_CAP_SAGAW_SHIFT         8
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 405c9d1..fe645aa 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -257,6 +257,8 @@ struct IntelIOMMUState {
     uint8_t womask[DMAR_REG_SIZE];  /* WO (write only - read returns 0) */
     uint32_t version;
 
+    bool caching_mode;          /* RO - is cap CM enabled? */
+
     dma_addr_t root;                /* Current root table pointer */
     bool root_extended;             /* Type of root table (extended or not) */
     bool dmar_enabled;              /* Set if DMA remapping is enabled */
-- 
2.7.4
