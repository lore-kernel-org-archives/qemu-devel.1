Received: from eggs.gnu.org ([209.51.188.92]:38371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ggpsO-0008Cf-Cm
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:48:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ggpsN-0005hV-9j
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:48:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:18573)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ggpsM-0005En-8q
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:48:55 -0500
From: Peter Xu <peterx@redhat.com>
Date: Tue,  8 Jan 2019 19:47:20 +0800
Message-Id: <20190108114720.21760-6-peterx@redhat.com>
In-Reply-To: <20190108114720.21760-1-peterx@redhat.com>
References: <20190108114720.21760-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 5/5] vfio: retry one more time conditionally
 for type1 unmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Eric Auger <eric.auger@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

In Linux version v4.15+ there's a bug (introduced in 71a7d3d78e3c,
"vfio/type1: silence integer overflow warning", 2017-10-20) that could
potentially reject a valid unmap region that covers exactly the whole
u64 address space (like iova=0xfef00000, size=2^64-0xfef00000).
Besides a fix on the kernel side, QEMU also needs to live well even
with the old kernels.  When booting a guest with both vfio-pci and
intel-iommu device, we can see error dumped:

  qemu-kvm: VFIO_UNMAP_DMA: -22
  qemu-kvm: vfio_dma_unmap(0x561f059948f0, 0xfef00000,
            0xffffffff01100000) = -22 (Invalid argument)

This patch gives another shot of the UNMAP ioctl if the specific error
was detected, while in the second UNMAP ioctl we skip the last page
assuming that it's never used.  In our case, currently only Intel VT-d
is using this code and it should never use the iova address
2^64-4096 (so far largest supported GAW is 57 bits) so ignoring that
page should be fine.

After this patch is applied, the errors go away.

Reported-by: Pei Zhang <pezhang@redhat.com>
Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1662291
Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/vfio/common.c     | 16 ++++++++++++++++
 hw/vfio/trace-events |  1 +
 2 files changed, 17 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 7c185e5a2e..7f8de5b7a5 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -221,6 +221,22 @@ static int vfio_dma_unmap(VFIOContainer *container,
     };
 
     if (ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
+        /*
+         * Give it another shot due to a bug in kernel (v4.15-v4.20)
+         * that could potentially reject a region that exactly covers
+         * the whole u64 address space (71a7d3d78e3c, "vfio/type1:
+         * silence integer overflow warning", 2017-10-20).  If that
+         * happens, we retry for one more time assuming that the last
+         * page of the address space (2^64-getpagesize()) has already
+         * been dropped.
+         */
+        if (errno == EINVAL && unmap.size && unmap.iova + unmap.size == 0) {
+            trace_vfio_dma_unmap_workaround_overflow();
+            unmap.size -= getpagesize();
+            if (ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, &unmap) == 0) {
+                return 0;
+            }
+        }
         error_report("VFIO_UNMAP_DMA: %d", -errno);
         return -errno;
     }
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index a85e8662ea..2c9db4fb9a 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -110,6 +110,7 @@ vfio_region_mmaps_set_enabled(const char *name, bool enabled) "Region %s mmaps e
 vfio_region_sparse_mmap_header(const char *name, int index, int nr_areas) "Device %s region %d: %d sparse mmap entries"
 vfio_region_sparse_mmap_entry(int i, unsigned long start, unsigned long end) "sparse entry %d [0x%lx - 0x%lx]"
 vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_t subtype) "%s index %d, %08x/%0x8"
+vfio_dma_unmap_workaround_overflow(void) ""
 
 # hw/vfio/platform.c
 vfio_platform_base_device_init(char *name, int groupid) "%s belongs to group #%d"
-- 
2.17.1
