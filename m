Received: from eggs.gnu.org ([2001:4830:134:3::10]:41123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1drbK8-0004yJ-II
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 22:53:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1drbK4-00056a-Bk
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 22:53:16 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Tue, 12 Sep 2017 12:53:07 +1000
Message-Id: <20170912025307.45376-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu] vfio, spapr: Fix levels calculation
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

The existing tries to round up the number of pages but @pages is always
calculated as the rounded up value minus one  which makes ctz64() always
return 0 and have create.levels always set 1.

This removes wrong "-1" and allows having more than 1 levels. This becomes
handy for >128GB guests with standard 64K pages as this requires blocks
with zone order 9 and the popular limit of CONFIG_FORCE_MAX_ZONEORDER=9
means that only blocks up to order 8 are allowed.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
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
2.11.0
