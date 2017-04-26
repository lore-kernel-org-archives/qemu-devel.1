Received: from eggs.gnu.org ([2001:4830:134:3::10]:50156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1d3K6Y-0002BP-NK
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:23:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1d3K6T-0001vC-Qq
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:23:26 -0400
Received: from mga05.intel.com ([192.55.52.43]:3709)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1d3K6T-0001ur-DQ
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:23:21 -0400
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Date: Wed, 26 Apr 2017 18:06:31 +0800
Message-Id: <1493201210-14357-2-git-send-email-yi.l.liu@linux.intel.com>
In-Reply-To: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
References: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
Subject: [Qemu-devel] [RFC PATCH 01/20] intel_iommu: add "ecs" option
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

Report ecap.ECS=1 to guest by "-deivce intel-iommu, ecs=on" in QEMU Cmd

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 hw/i386/intel_iommu.c          | 5 +++++
 hw/i386/intel_iommu_internal.h | 1 +
 include/hw/i386/intel_iommu.h  | 1 +
 3 files changed, 7 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 4b7d90d..400d0d1 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2409,6 +2409,7 @@ static Property vtd_properties[] = {
                             ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BOOL("x-buggy-eim", IntelIOMMUState, buggy_eim, false),
     DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALSE),
+    DEFINE_PROP_BOOL("ecs", IntelIOMMUState, ecs, FALSE),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -2925,6 +2926,10 @@ static void vtd_init(IntelIOMMUState *s)
         s->ecap |= VTD_ECAP_PT;
     }
 
+    if (s->ecs) {
+        s->ecap |= VTD_ECAP_ECS;
+    }
+
     if (s->caching_mode) {
         s->cap |= VTD_CAP_CM;
     }
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index b96884e..ec1bd17 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -190,6 +190,7 @@
 #define VTD_ECAP_EIM                (1ULL << 4)
 #define VTD_ECAP_PT                 (1ULL << 6)
 #define VTD_ECAP_MHMV               (15ULL << 20)
+#define VTD_ECAP_ECS                (1ULL << 24)
 
 /* CAP_REG */
 /* (offset >> 4) << 24 */
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 3e51876..fa5963e 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -266,6 +266,7 @@ struct IntelIOMMUState {
     uint32_t version;
 
     bool caching_mode;          /* RO - is cap CM enabled? */
+    bool ecs;                       /* Extended Context Support */
 
     dma_addr_t root;                /* Current root table pointer */
     bool root_extended;             /* Type of root table (extended or not) */
-- 
1.9.1
