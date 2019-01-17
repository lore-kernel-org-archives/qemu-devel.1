Received: from eggs.gnu.org ([209.51.188.92]:42955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gjxwx-0007zz-2K
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 22:02:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gjxmc-0005xZ-ST
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 21:51:56 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu, 17 Jan 2019 13:51:13 +1100
Message-Id: <20190117025115.81178-2-aik@ozlabs.ru>
In-Reply-To: <20190117025115.81178-1-aik@ozlabs.ru>
References: <20190117025115.81178-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu 1/3] vfio/spapr: Fix indirect levels
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>, Alex Williamson <alex.williamson@redhat.com>

The current code assumes that we can address more bits on a PCI bus
for DMA than we really can but there is no way knowing the actual limit.

This makes a better guess for the number of levels and if the kernel
fails to allocate that, this increases the level numbers till succeeded
or reached the 64bit limit.

This adds levels to the trace point.

This may cause the kernel to warn about failed allocation:
   [65122.837458] Failed to allocate a TCE memory, level shift=28
which might happen if MAX_ORDER is not large enough as it can vary:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/Kconfig?h=v5.0-rc2#n727

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 hw/vfio/spapr.c      | 38 +++++++++++++++++++++++++++++---------
 hw/vfio/trace-events |  2 +-
 2 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index becf71a..2675bf5 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -146,7 +146,7 @@ int vfio_spapr_create_window(VFIOContainer *container,
     int ret;
     IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
     uint64_t pagesize = memory_region_iommu_get_min_page_size(iommu_mr);
-    unsigned entries, pages;
+    unsigned entries, bits_total, bits_per_level, max_levels;
     struct vfio_iommu_spapr_tce_create create = { .argsz = sizeof(create) };
     long systempagesize = qemu_getrampagesize();
 
@@ -176,16 +176,35 @@ int vfio_spapr_create_window(VFIOContainer *container,
     create.window_size = int128_get64(section->size);
     create.page_shift = ctz64(pagesize);
     /*
-     * SPAPR host supports multilevel TCE tables, there is some
-     * heuristic to decide how many levels we want for our table:
-     * 0..64 = 1; 65..4096 = 2; 4097..262144 = 3; 262145.. = 4
+     * SPAPR host supports multilevel TCE tables. We try to guess optimal
+     * levels number and if this fails (for example due to the host memory
+     * fragmentation), we increase levels. The DMA address structure is:
+     * rrrrrrrr rxxxxxxx xxxxxxxx xxxxxxxx  xxxxxxxx xxxxxxxx xxxxxxxx iiiiiiii
+     * where:
+     *   r = reserved (bits >= 55 are reserved in the existing hardware)
+     *   i = IOMMU page offset (64K in this example)
+     *   x = bits to index a TCE which can be split to equal chunks to index
+     *      within the level.
+     * The aim is to split "x" to smaller possible number of levels.
      */
     entries = create.window_size >> create.page_shift;
-    pages = MAX((entries * sizeof(uint64_t)) / getpagesize(), 1);
-    pages = MAX(pow2ceil(pages), 1); /* Round up */
-    create.levels = ctz64(pages) / 6 + 1;
-
-    ret = ioctl(container->fd, VFIO_IOMMU_SPAPR_TCE_CREATE, &create);
+    /* bits_total is number of "x" needed */
+    bits_total = ctz64((entries * sizeof(uint64_t)));
+    /*
+     * bits_per_level is a safe guess of how much we can allocate per level:
+     * 8 is the current minimum for CONFIG_FORCE_MAX_ZONEORDER and MAX_ORDER
+     * is usually bigger than that.
+     */
+    bits_per_level = ctz64(systempagesize) + 8;
+    create.levels = bits_total / bits_per_level;
+    create.levels = MAX(1, create.levels);
+    max_levels = (64 - create.page_shift) / ctz64(systempagesize);
+    for ( ; create.levels <= max_levels; ++create.levels) {
+        ret = ioctl(container->fd, VFIO_IOMMU_SPAPR_TCE_CREATE, &create);
+        if (!ret) {
+            break;
+        }
+    }
     if (ret) {
         error_report("Failed to create a window, ret = %d (%m)", ret);
         return -errno;
@@ -200,6 +219,7 @@ int vfio_spapr_create_window(VFIOContainer *container,
         return -EINVAL;
     }
     trace_vfio_spapr_create_window(create.page_shift,
+                                   create.levels,
                                    create.window_size,
                                    create.start_addr);
     *pgsize = pagesize;
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 0f9f810..adfa75e 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -129,6 +129,6 @@ vfio_prereg_listener_region_add_skip(uint64_t start, uint64_t end) "0x%"PRIx64"
 vfio_prereg_listener_region_del_skip(uint64_t start, uint64_t end) "0x%"PRIx64" - 0x%"PRIx64
 vfio_prereg_register(uint64_t va, uint64_t size, int ret) "va=0x%"PRIx64" size=0x%"PRIx64" ret=%d"
 vfio_prereg_unregister(uint64_t va, uint64_t size, int ret) "va=0x%"PRIx64" size=0x%"PRIx64" ret=%d"
-vfio_spapr_create_window(int ps, uint64_t ws, uint64_t off) "pageshift=0x%x winsize=0x%"PRIx64" offset=0x%"PRIx64
+vfio_spapr_create_window(int ps, unsigned int levels, uint64_t ws, uint64_t off) "pageshift=0x%x levels=%u winsize=0x%"PRIx64" offset=0x%"PRIx64
 vfio_spapr_remove_window(uint64_t off) "offset=0x%"PRIx64
 vfio_spapr_group_attach(int groupfd, int tablefd) "Attached groupfd %d to liobn fd %d"
-- 
2.17.1
