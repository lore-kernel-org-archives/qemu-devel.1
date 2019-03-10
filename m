Received: from eggs.gnu.org ([209.51.188.92]:42422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tno-0000dj-RV
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:27:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tnk-00014M-UH
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:27:23 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:26:04 +1100
Message-Id: <20190310082703.1245-2-david@gibson.dropbear.id.au>
In-Reply-To: <20190310082703.1245-1-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/60] vfio/spapr: Fix indirect levels
 calculation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson <david@gibson.dropbear.id.au>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

The current code assumes that we can address more bits on a PCI bus
for DMA than we really can but there is no way knowing the actual limit.

This makes a better guess for the number of levels and if the kernel
fails to allocate that, this increases the level numbers till succeeded
or reached the 64bit limit.

This adds levels to the trace point.

This may cause the kernel to warn about failed allocation:
   [65122.837458] Failed to allocate a TCE memory, level shift=3D28
which might happen if MAX_ORDER is not large enough as it can vary:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/a=
rch/powerpc/Kconfig?h=3Dv5.0-rc2#n727

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20190227085149.38596-3-aik@ozlabs.ru>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/vfio/spapr.c      | 43 +++++++++++++++++++++++++++++++++----------
 hw/vfio/trace-events |  2 +-
 2 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index becf71a3fc..88437a79e6 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -143,10 +143,10 @@ int vfio_spapr_create_window(VFIOContainer *contain=
er,
                              MemoryRegionSection *section,
                              hwaddr *pgsize)
 {
-    int ret;
+    int ret =3D 0;
     IOMMUMemoryRegion *iommu_mr =3D IOMMU_MEMORY_REGION(section->mr);
     uint64_t pagesize =3D memory_region_iommu_get_min_page_size(iommu_mr=
);
-    unsigned entries, pages;
+    unsigned entries, bits_total, bits_per_level, max_levels;
     struct vfio_iommu_spapr_tce_create create =3D { .argsz =3D sizeof(cr=
eate) };
     long systempagesize =3D qemu_getrampagesize();
=20
@@ -176,16 +176,38 @@ int vfio_spapr_create_window(VFIOContainer *contain=
er,
     create.window_size =3D int128_get64(section->size);
     create.page_shift =3D ctz64(pagesize);
     /*
-     * SPAPR host supports multilevel TCE tables, there is some
-     * heuristic to decide how many levels we want for our table:
-     * 0..64 =3D 1; 65..4096 =3D 2; 4097..262144 =3D 3; 262145.. =3D 4
+     * SPAPR host supports multilevel TCE tables. We try to guess optima=
l
+     * levels number and if this fails (for example due to the host memo=
ry
+     * fragmentation), we increase levels. The DMA address structure is:
+     * rrrrrrrr rxxxxxxx xxxxxxxx xxxxxxxx  xxxxxxxx xxxxxxxx xxxxxxxx i=
iiiiiii
+     * where:
+     *   r =3D reserved (bits >=3D 55 are reserved in the existing hardw=
are)
+     *   i =3D IOMMU page offset (64K in this example)
+     *   x =3D bits to index a TCE which can be split to equal chunks to=
 index
+     *      within the level.
+     * The aim is to split "x" to smaller possible number of levels.
      */
     entries =3D create.window_size >> create.page_shift;
-    pages =3D MAX((entries * sizeof(uint64_t)) / getpagesize(), 1);
-    pages =3D MAX(pow2ceil(pages), 1); /* Round up */
-    create.levels =3D ctz64(pages) / 6 + 1;
-
-    ret =3D ioctl(container->fd, VFIO_IOMMU_SPAPR_TCE_CREATE, &create);
+    /* bits_total is number of "x" needed */
+    bits_total =3D ctz64(entries * sizeof(uint64_t));
+    /*
+     * bits_per_level is a safe guess of how much we can allocate per le=
vel:
+     * 8 is the current minimum for CONFIG_FORCE_MAX_ZONEORDER and MAX_O=
RDER
+     * is usually bigger than that.
+     * Below we look at getpagesize() as TCEs are allocated from system =
pages.
+     */
+    bits_per_level =3D ctz64(getpagesize()) + 8;
+    create.levels =3D bits_total / bits_per_level;
+    if (bits_total % bits_per_level) {
+        ++create.levels;
+    }
+    max_levels =3D (64 - create.page_shift) / ctz64(getpagesize());
+    for ( ; create.levels <=3D max_levels; ++create.levels) {
+        ret =3D ioctl(container->fd, VFIO_IOMMU_SPAPR_TCE_CREATE, &creat=
e);
+        if (!ret) {
+            break;
+        }
+    }
     if (ret) {
         error_report("Failed to create a window, ret =3D %d (%m)", ret);
         return -errno;
@@ -200,6 +222,7 @@ int vfio_spapr_create_window(VFIOContainer *container=
,
         return -EINVAL;
     }
     trace_vfio_spapr_create_window(create.page_shift,
+                                   create.levels,
                                    create.window_size,
                                    create.start_addr);
     *pgsize =3D pagesize;
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index ed2f333ad7..cf1e886818 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -129,6 +129,6 @@ vfio_prereg_listener_region_add_skip(uint64_t start, =
uint64_t end) "0x%"PRIx64"
 vfio_prereg_listener_region_del_skip(uint64_t start, uint64_t end) "0x%"=
PRIx64" - 0x%"PRIx64
 vfio_prereg_register(uint64_t va, uint64_t size, int ret) "va=3D0x%"PRIx=
64" size=3D0x%"PRIx64" ret=3D%d"
 vfio_prereg_unregister(uint64_t va, uint64_t size, int ret) "va=3D0x%"PR=
Ix64" size=3D0x%"PRIx64" ret=3D%d"
-vfio_spapr_create_window(int ps, uint64_t ws, uint64_t off) "pageshift=3D=
0x%x winsize=3D0x%"PRIx64" offset=3D0x%"PRIx64
+vfio_spapr_create_window(int ps, unsigned int levels, uint64_t ws, uint6=
4_t off) "pageshift=3D0x%x levels=3D%u winsize=3D0x%"PRIx64" offset=3D0x%=
"PRIx64
 vfio_spapr_remove_window(uint64_t off) "offset=3D0x%"PRIx64
 vfio_spapr_group_attach(int groupfd, int tablefd) "Attached groupfd %d t=
o liobn fd %d"
--=20
2.20.1
