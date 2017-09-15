Received: from eggs.gnu.org ([2001:4830:134:3::10]:54142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dshfL-0006f4-2z
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:51:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dshfJ-0003N1-Ll
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:51:43 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 15 Sep 2017 13:51:23 +1000
Message-Id: <20170915035130.8354-12-david@gibson.dropbear.id.au>
In-Reply-To: <20170915035130.8354-1-david@gibson.dropbear.id.au>
References: <20170915035130.8354-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 11/18] vfio, spapr: Fix levels calculation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, gkurz@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

The existing tries to round up the number of pages but @pages is always
calculated as the rounded up value minus one  which makes ctz64() always
return 0 and have create.levels always set 1.

This removes wrong "-1" and allows having more than 1 levels. This becomes
handy for >128GB guests with standard 64K pages as this requires blocks
with zone order 9 and the popular limit of CONFIG_FORCE_MAX_ZONEORDER=9
means that only blocks up to order 8 are allowed.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/vfio/spapr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 32fd6a9b54..259397c002 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -163,7 +163,7 @@ int vfio_spapr_create_window(VFIOContainer *container,
      */
     entries = create.window_size >> create.page_shift;
     pages = MAX((entries * sizeof(uint64_t)) / getpagesize(), 1);
-    pages = MAX(pow2ceil(pages) - 1, 1); /* Round up */
+    pages = MAX(pow2ceil(pages), 1); /* Round up */
     create.levels = ctz64(pages) / 6 + 1;
 
     ret = ioctl(container->fd, VFIO_IOMMU_SPAPR_TCE_CREATE, &create);
-- 
2.13.5
