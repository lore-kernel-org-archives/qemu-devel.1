Received: from eggs.gnu.org ([2001:4830:134:3::10]:54953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fw6po-0005sK-Df
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 10:25:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fw6pP-0006FX-MQ
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 10:24:44 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Sat,  1 Sep 2018 16:23:12 +0200
Message-Id: <20180901142312.11662-21-eric.auger@redhat.com>
In-Reply-To: <20180901142312.11662-1-eric.auger@redhat.com>
References: <20180901142312.11662-1-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC 20/20] hw/arm/smmuv3: Remove warning about
 unsupported MAP notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: alex.williamson@redhat.com, mst@redhat.com, cdall@kernel.org, jean-philippe.brucker@arm.com, peterx@redhat.com, yi.l.liu@intel.com

SMMUv3 now is integrated with VFIO by enable the 2 stages of
the physical SMMUv3. This relies on a MAP notifier for MSI
stage 1 binding notification. So let's remove this warning.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/smmuv3.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index a31df03d47..9f39887602 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1497,14 +1497,6 @@ static void smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
     SMMUNotifierNode *node = NULL;
     SMMUNotifierNode *next_node = NULL;
 
-    if (new & IOMMU_NOTIFIER_MAP) {
-        int bus_num = pci_bus_num(sdev->bus);
-        PCIDevice *pcidev = pci_find_device(sdev->bus, bus_num, sdev->devfn);
-
-        warn_report("SMMUv3 does not support notification on MAP: "
-                     "device %s will not function properly", pcidev->name);
-    }
-
     if (old == IOMMU_NOTIFIER_NONE) {
         trace_smmuv3_notify_flag_add(iommu->parent_obj.name);
         node = g_malloc0(sizeof(*node));
-- 
2.17.1
