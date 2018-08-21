Received: from eggs.gnu.org ([2001:4830:134:3::10]:56310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fryMh-00041r-PZ
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:34:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fryMg-0000E6-7i
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:33:59 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 21 Aug 2018 14:33:28 +1000
Message-Id: <20180821043343.7514-12-david@gibson.dropbear.id.au>
In-Reply-To: <20180821043343.7514-1-david@gibson.dropbear.id.au>
References: <20180821043343.7514-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 11/26] vfio/spapr: Allow backing bigger guest
 IOMMU pages with smaller physical pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

At the moment the PPC64/pseries guest only supports 4K/64K/16M IOMMU
pages and POWER8 CPU supports the exact same set of page size so
so far things worked fine.

However POWER9 supports different set of sizes - 4K/64K/2M/1G and
the last two - 2M and 1G - are not even allowed in the paravirt interface
(RTAS DDW) so we always end up using 64K IOMMU pages, although we could
back guest's 16MB IOMMU pages with 2MB pages on the host.

This stores the supported host IOMMU page sizes in VFIOContainer and uses
this later when creating a new DMA window. This uses the system page size
(64k normally, 2M/16M/1G if hugepages used) as the upper limit of
the IOMMU pagesize.

This changes the type of @pagesize to uint64_t as this is what
memory_region_iommu_get_min_page_size() returns and clz64() takes.

There should be no behavioral changes on platforms other than pseries.
The guest will keep using the IOMMU page size selected by the PHB pagesize
property as this only changes the underlying hardware TCE table
granularity.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/vfio/common.c              |  3 +++
 hw/vfio/spapr.c               | 21 ++++++++++++++++++++-
 include/hw/vfio/vfio-common.h |  1 +
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index cd1f4af18a..3f31f80b12 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1136,6 +1136,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
             info.iova_pgsizes = 4096;
         }
         vfio_host_win_add(container, 0, (hwaddr)-1, info.iova_pgsizes);
+        container->pgsizes = info.iova_pgsizes;
     } else if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_SPAPR_TCE_IOMMU) ||
                ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_SPAPR_TCE_v2_IOMMU)) {
         struct vfio_iommu_spapr_tce_info info;
@@ -1200,6 +1201,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
         }
 
         if (v2) {
+            container->pgsizes = info.ddw.pgsizes;
             /*
              * There is a default window in just created container.
              * To make region_add/del simpler, we better remove this
@@ -1214,6 +1216,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
             }
         } else {
             /* The default table uses 4K pages */
+            container->pgsizes = 0x1000;
             vfio_host_win_add(container, info.dma32_window_start,
                               info.dma32_window_start +
                               info.dma32_window_size - 1,
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 259397c002..becf71a3fc 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -15,6 +15,7 @@
 
 #include "hw/vfio/vfio-common.h"
 #include "hw/hw.h"
+#include "exec/ram_addr.h"
 #include "qemu/error-report.h"
 #include "trace.h"
 
@@ -144,9 +145,27 @@ int vfio_spapr_create_window(VFIOContainer *container,
 {
     int ret;
     IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
-    unsigned pagesize = memory_region_iommu_get_min_page_size(iommu_mr);
+    uint64_t pagesize = memory_region_iommu_get_min_page_size(iommu_mr);
     unsigned entries, pages;
     struct vfio_iommu_spapr_tce_create create = { .argsz = sizeof(create) };
+    long systempagesize = qemu_getrampagesize();
+
+    /*
+     * The host might not support the guest supported IOMMU page size,
+     * so we will use smaller physical IOMMU pages to back them.
+     */
+    if (pagesize > systempagesize) {
+        pagesize = systempagesize;
+    }
+    pagesize = 1ULL << (63 - clz64(container->pgsizes &
+                                   (pagesize | (pagesize - 1))));
+    if (!pagesize) {
+        error_report("Host doesn't support page size 0x%"PRIx64
+                     ", the supported mask is 0x%lx",
+                     memory_region_iommu_get_min_page_size(iommu_mr),
+                     container->pgsizes);
+        return -EINVAL;
+    }
 
     /*
      * FIXME: For VFIO iommu types which have KVM acceleration to
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 15ea6c26fd..821def0565 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -73,6 +73,7 @@ typedef struct VFIOContainer {
     unsigned iommu_type;
     int error;
     bool initialized;
+    unsigned long pgsizes;
     /*
      * This assumes the host IOMMU can support only a single
      * contiguous IOVA window.  We may need to generalize that in
-- 
2.17.1
