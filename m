Received: from eggs.gnu.org ([2001:4830:134:3::10]:50164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ecYGM-0002HP-NK
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 10:07:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ecYGL-0005LU-Oz
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 10:07:26 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Fri, 19 Jan 2018 14:49:13 +0000
Message-Id: <1516373355-305-21-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1516373355-305-1-git-send-email-eric.auger@redhat.com>
References: <1516373355-305-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v5 20/22] hw/vfio/common: Set the
 IOMMUMemoryRegion supported page sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, alex.williamson@redhat.com, mst@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, jean-philippe.brucker@arm.com
Cc: will.deacon@arm.com, kevin.tian@intel.com, marc.zyngier@arm.com, christoffer.dall@linaro.org, drjones@redhat.com, wei@redhat.com, tn@semihalf.com, bharat.bhushan@nxp.com, peterx@redhat.com, linuc.decode@gmail.com

We store the page_size_mask in the container and on
vfio_listener_region_add(), the information is conveyed
to the IOMMUMemoryRegion.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/vfio/common.c              | 5 +++++
 include/hw/vfio/vfio-common.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index b77be3a..35b83fe 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -480,6 +480,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
     if (memory_region_is_iommu(section->mr)) {
         VFIOGuestIOMMU *giommu;
         IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
+        IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_GET_CLASS(iommu_mr);
 
         trace_vfio_listener_region_add_iommu(iova, end);
         /*
@@ -500,6 +501,9 @@ static void vfio_listener_region_add(MemoryListener *listener,
                             IOMMU_NOTIFIER_ALL,
                             section->offset_within_region,
                             int128_get64(llend));
+        if (imrc->set_page_size_mask) {
+            imrc->set_page_size_mask(iommu_mr, container->page_size_mask);
+        }
         QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_next);
 
         memory_region_register_iommu_notifier(section->mr, &giommu->n);
@@ -1027,6 +1031,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
             /* Assume 4k IOVA page size */
             info.iova_pgsizes = 4096;
         }
+        container->page_size_mask = info.iova_pgsizes;
         vfio_host_win_add(container, 0, (hwaddr)-1, info.iova_pgsizes);
     } else if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_SPAPR_TCE_IOMMU) ||
                ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_SPAPR_TCE_v2_IOMMU)) {
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index f3a2ac9..221cc30 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -79,6 +79,7 @@ typedef struct VFIOContainer {
     int fd; /* /dev/vfio/vfio, empowered by the attached groups */
     MemoryListener listener;
     MemoryListener prereg_listener;
+    uint64_t page_size_mask; /* page sizes supported for this container */
     unsigned iommu_type;
     int error;
     bool initialized;
-- 
1.9.1
