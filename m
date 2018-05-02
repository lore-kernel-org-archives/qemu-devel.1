Received: from eggs.gnu.org ([2001:4830:134:3::10]:50065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fDjf1-00064G-H3
	for qemu-devel@nongnu.org; Wed, 02 May 2018 00:46:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fDjey-0000TW-GU
	for qemu-devel@nongnu.org; Wed, 02 May 2018 00:46:35 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Wed,  2 May 2018 14:45:57 +1000
Message-Id: <20180502044557.21035-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu] vfio/spapr: Allow backing bigger guest
 IOMMU pages with smaller physical pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>

At the moment the PPC64/pseries guest only supports 4K/64K/16M IOMMU
pages and POWER8 CPU supports the exact same set of page size so
so far things worked fine.

However POWER9 supports different set of sizes - 4K/64K/2M/1G and
the last two - 2M and 1G - are not even allowed in the paravirt interface
(RTAS DDW) so we always end up using 64K IOMMU pages, although we could
back guest's 16MB IOMMU pages with 2MB pages on the host.

This stores the supported host IOMMU page sizes in VFIOContainer and uses
this later when creating a new DMA window.

There should be no behavioral changes on platforms other than pseries.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 include/hw/vfio/vfio-common.h |  1 +
 hw/vfio/common.c              |  3 +++
 hw/vfio/spapr.c               | 15 ++++++++++++++-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index d936014..dd8d0d3 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -83,6 +83,7 @@ typedef struct VFIOContainer {
     unsigned iommu_type;
     int error;
     bool initialized;
+    unsigned long pgsizes;
     /*
      * This assumes the host IOMMU can support only a single
      * contiguous IOVA window.  We may need to generalize that in
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 07ffa0b..15ddef2 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1103,6 +1103,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
             info.iova_pgsizes = 4096;
         }
         vfio_host_win_add(container, 0, (hwaddr)-1, info.iova_pgsizes);
+        container->pgsizes = info.iova_pgsizes;
     } else if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_SPAPR_TCE_IOMMU) ||
                ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_SPAPR_TCE_v2_IOMMU)) {
         struct vfio_iommu_spapr_tce_info info;
@@ -1167,6 +1168,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
         }
 
         if (v2) {
+            container->pgsizes = info.ddw.pgsizes;
             /*
              * There is a default window in just created container.
              * To make region_add/del simpler, we better remove this
@@ -1181,6 +1183,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
             }
         } else {
             /* The default table uses 4K pages */
+            container->pgsizes = 0x1000;
             vfio_host_win_add(container, info.dma32_window_start,
                               info.dma32_window_start +
                               info.dma32_window_size - 1,
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 259397c..9637ed5 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -144,11 +144,24 @@ int vfio_spapr_create_window(VFIOContainer *container,
 {
     int ret;
     IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
-    unsigned pagesize = memory_region_iommu_get_min_page_size(iommu_mr);
+    uint64_t pagesize = memory_region_iommu_get_min_page_size(iommu_mr);
     unsigned entries, pages;
     struct vfio_iommu_spapr_tce_create create = { .argsz = sizeof(create) };
 
     /*
+     * The host might not support the guest supported IOMMU page size,
+     * so we will use smaller physical IOMMU pages to back them.
+     */
+    pagesize = 1ULL << ctz64(container->pgsizes & (pagesize | (pagesize - 1)));
+    if (!pagesize) {
+        error_report("Host doesn't support page size 0x%"PRIx64
+                     ", the supported mask is 0x%lx",
+                     memory_region_iommu_get_min_page_size(iommu_mr),
+                     container->pgsizes);
+        return -EINVAL;
+    }
+
+    /*
      * FIXME: For VFIO iommu types which have KVM acceleration to
      * avoid bouncing all map/unmaps through qemu this way, this
      * would be the right place to wire that up (tell the KVM
-- 
2.11.0
