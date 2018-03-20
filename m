Received: from eggs.gnu.org ([2001:4830:134:3::10]:42915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eyGXU-000845-CW
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 08:38:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eyGXP-0003jx-G7
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 08:38:52 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Tue, 20 Mar 2018 13:37:32 +0100
Message-Id: <1521549456-14072-11-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1521549456-14072-1-git-send-email-eric.auger@redhat.com>
References: <1521549456-14072-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v10 10/14] hw/arm/smmuv3: Abort on vfio or
 vhost case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, prem.mallappa@gmail.com
Cc: alex.williamson@redhat.com, tn@semihalf.com, mst@redhat.com, cdall@kernel.org, bharat.bhushan@nxp.com, jean-philippe.brucker@arm.com, linuc.decode@gmail.com, peterx@redhat.com, jintack@cs.columbia.edu

At the moment, the SMMUv3 does not support notification on
TLB invalidation. So let's log an error as soon as such notifier
gets enabled.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/smmuv3.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 4f5186d..c9d6e21 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1151,12 +1151,23 @@ static void smmuv3_class_init(ObjectClass *klass, void *data)
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
2.5.5
