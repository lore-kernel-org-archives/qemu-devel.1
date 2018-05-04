Received: from eggs.gnu.org ([2001:4830:134:3::10]:51909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fEeJJ-0005oa-S7
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:15:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fEeJI-0000mZ-VU
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:15:57 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41496)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fEeJI-0000ld-OM
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:15:56 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fEeJH-00038D-OK
	for qemu-devel@nongnu.org; Fri, 04 May 2018 18:15:55 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  4 May 2018 18:15:36 +0100
Message-Id: <20180504171540.25813-21-peter.maydell@linaro.org>
In-Reply-To: <20180504171540.25813-1-peter.maydell@linaro.org>
References: <20180504171540.25813-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 20/24] hw/arm/smmuv3: Abort on vfio or vhost case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Auger <eric.auger@redhat.com>

At the moment, the SMMUv3 does not support notification on
TLB invalidation. So let's log an error as soon as such notifier
gets enabled.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 1524665762-31355-11-git-send-email-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index d896834764..b3026dea20 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1147,12 +1147,23 @@ static void smmuv3_class_init(ObjectClass *klass, void *data)
     dc->realize = smmu_realize;
 }
 
+static void smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
+                                       IOMMUNotifierFlag old,
+                                       IOMMUNotifierFlag new)
+{
+    if (old == IOMMU_NOTIFIER_NONE) {
+        warn_report("SMMUV3 does not support vhost/vfio integration yet: "
+                    "devices of those types will not function properly");
+    }
+}
+
 static void smmuv3_iommu_memory_region_class_init(ObjectClass *klass,
                                                   void *data)
 {
     IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
 
     imrc->translate = smmuv3_translate;
+    imrc->notify_flag_changed = smmuv3_notify_flag_changed;
 }
 
 static const TypeInfo smmuv3_type_info = {
-- 
2.17.0
