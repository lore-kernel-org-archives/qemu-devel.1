Received: from eggs.gnu.org ([2001:4830:134:3::10]:45206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gMUGx-0002x8-TH
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 03:42:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gMU6w-0006VM-2M
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 03:31:51 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Tue, 13 Nov 2018 19:30:58 +1100
Message-Id: <20181113083104.2692-2-aik@ozlabs.ru>
In-Reply-To: <20181113083104.2692-1-aik@ozlabs.ru>
References: <20181113083104.2692-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu RFC 1/7] vfio/spapr: Fix indirect levels
 calculation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alistair Popple <alistair@popple.id.au>, Reza Arbab <arbab@linux.ibm.com>, Sam Bobroff <sbobroff@linux.ibm.com>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, =?UTF-8?q?Leonardo=20Augusto=20Guimar=C3=A3es=20Garcia?= <lagarcia@br.ibm.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, Oliver O'Halloran <oohall@gmail.com>

The current code assumes that we can address more bits on a PCI bus
for DMA than we really can. Limit to the known tested maximum of 55 bits
and assume 64K IOMMU pages.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 hw/vfio/spapr.c      | 3 ++-
 hw/vfio/trace-events | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index becf71a..f5fdc53 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -183,7 +183,7 @@ int vfio_spapr_create_window(VFIOContainer *container,
     entries = create.window_size >> create.page_shift;
     pages = MAX((entries * sizeof(uint64_t)) / getpagesize(), 1);
     pages = MAX(pow2ceil(pages), 1); /* Round up */
-    create.levels = ctz64(pages) / 6 + 1;
+    create.levels = MAX(1, (55 - create.page_shift) / 16);
 
     ret = ioctl(container->fd, VFIO_IOMMU_SPAPR_TCE_CREATE, &create);
     if (ret) {
@@ -200,6 +200,7 @@ int vfio_spapr_create_window(VFIOContainer *container,
         return -EINVAL;
     }
     trace_vfio_spapr_create_window(create.page_shift,
+                                   create.levels,
                                    create.window_size,
                                    create.start_addr);
     *pgsize = pagesize;
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index a85e866..db730f3 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -128,6 +128,6 @@ vfio_prereg_listener_region_add_skip(uint64_t start, uint64_t end) "0x%"PRIx64"
 vfio_prereg_listener_region_del_skip(uint64_t start, uint64_t end) "0x%"PRIx64" - 0x%"PRIx64
 vfio_prereg_register(uint64_t va, uint64_t size, int ret) "va=0x%"PRIx64" size=0x%"PRIx64" ret=%d"
 vfio_prereg_unregister(uint64_t va, uint64_t size, int ret) "va=0x%"PRIx64" size=0x%"PRIx64" ret=%d"
-vfio_spapr_create_window(int ps, uint64_t ws, uint64_t off) "pageshift=0x%x winsize=0x%"PRIx64" offset=0x%"PRIx64
+vfio_spapr_create_window(int ps, unsigned int levels, uint64_t ws, uint64_t off) "pageshift=0x%x levels=%u winsize=0x%"PRIx64" offset=0x%"PRIx64
 vfio_spapr_remove_window(uint64_t off) "offset=0x%"PRIx64
 vfio_spapr_group_attach(int groupfd, int tablefd) "Attached groupfd %d to liobn fd %d"
-- 
2.17.1
