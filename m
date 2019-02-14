Received: from eggs.gnu.org ([209.51.188.92]:55502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gu9Tg-0007dY-DT
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 00:22:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gu9Tf-00065g-JI
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 00:22:28 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu, 14 Feb 2019 16:21:42 +1100
Message-Id: <20190214052144.59541-3-aik@ozlabs.ru>
In-Reply-To: <20190214052144.59541-1-aik@ozlabs.ru>
References: <20190214052144.59541-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v2 2/4] vfio/spapr: Rename local
 systempagesize variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>, Reza Arbab <arbab@linux.ibm.com>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>

The "systempagesize" name suggests that it is the host system page size
while it is the smallest page size of memory backing the guest RAM so
let's rename it to stop confusion. This should cause no behavioral change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 hw/vfio/spapr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 302d6b0..1498fee 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -148,14 +148,14 @@ int vfio_spapr_create_window(VFIOContainer *container,
     uint64_t pagesize = memory_region_iommu_get_min_page_size(iommu_mr);
     unsigned entries, bits_total, bits_per_level, max_levels;
     struct vfio_iommu_spapr_tce_create create = { .argsz = sizeof(create) };
-    long systempagesize = qemu_getrampagesize();
+    long minpagesize = qemu_getrampagesize();
 
     /*
      * The host might not support the guest supported IOMMU page size,
      * so we will use smaller physical IOMMU pages to back them.
      */
-    if (pagesize > systempagesize) {
-        pagesize = systempagesize;
+    if (pagesize > minpagesize) {
+        pagesize = minpagesize;
     }
     pagesize = 1ULL << (63 - clz64(container->pgsizes &
                                    (pagesize | (pagesize - 1))));
-- 
2.17.1
