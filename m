Received: from eggs.gnu.org ([209.51.188.92]:49749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gx3TI-0002Ei-3X
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 00:34:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gx3TG-0004kQ-Qn
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 00:34:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gx3TG-0004gx-DD
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 00:34:02 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E34873091D80
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 05:33:51 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Thu, 21 Feb 2019 22:33:49 -0700
Message-ID: <155081362929.23160.15724111710078454465.stgit@gimli.home>
In-Reply-To: <155081340903.23160.4034617687275790161.stgit@gimli.home>
References: <155081340903.23160.4034617687275790161.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 1/2] vfio/common: Work around kernel overflow
 bug in DMA unmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

A kernel bug was introduced in v4.15 via commit 71a7d3d78e3c which
adds a test for address space wrap-around in the vfio DMA unmap path.
Unfortunately due to overflow, the kernel detects an unmap of the last
page in the 64-bit address space as a wrap-around.  In QEMU, a Q35
guest with VT-d emulation and guest IOMMU enabled will attempt to make
such an unmap request during VM system reset, triggering an error:

  qemu-kvm: VFIO_UNMAP_DMA: -22
  qemu-kvm: vfio_dma_unmap(0x561f059948f0, 0xfef00000, 0xffffffff01100000) = -22 (Invalid argument)

Here the IOVA start address (0xfef00000) and the size parameter
(0xffffffff01100000) add to exactly 2^64, triggering the bug.  A
kernel fix is queued for the Linux v5.0 release to address this.

This patch implements a workaround to retry the unmap, excluding the
final page of the range when we detect an unmap failing which matches
the requirements for this issue.  This is expected to be a safe and
complete workaround as the VT-d address space does not extend to the
full 64-bit space and therefore the last page should never be mapped.

This workaround can be removed once all kernels with this bug are
sufficiently deprecated.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1662291
Reported-by: Pei Zhang <pezhang@redhat.com>
Debugged-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/common.c     |   20 +++++++++++++++++++-
 hw/vfio/trace-events |    1 +
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 4262b80c4450..9c3796e7db43 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -220,7 +220,25 @@ static int vfio_dma_unmap(VFIOContainer *container,
         .size = size,
     };
 
-    if (ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
+    while (ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
+        /*
+         * The type1 backend has an off-by-one bug in the kernel (71a7d3d78e3c
+         * v4.15) where an overflow in its wrap-around check prevents us from
+         * unmapping the last page of the address space.  Test for the error
+         * condition and re-try the unmap excluding the last page.  The
+         * expectation is that we've never mapped the last page anyway and this
+         * unmap request comes via vIOMMU support which also makes it unlikely
+         * that this page is used.  This bug was introduced well after type1 v2
+         * support was introduced, so we shouldn't need to test for v1.  A fix
+         * is queued for kernel v5.0 so this workaround can be removed once
+         * affected kernels are sufficiently deprecated.
+         */
+        if (errno == EINVAL && unmap.size && !(unmap.iova + unmap.size) &&
+            container->iommu_type == VFIO_TYPE1v2_IOMMU) {
+            trace_vfio_dma_unmap_overflow_workaround();
+            unmap.size -= 1ULL << ctz64(container->pgsizes);
+            continue;
+        }
         error_report("VFIO_UNMAP_DMA: %d", -errno);
         return -errno;
     }
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index f41ca96160bf..ed2f333ad726 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -110,6 +110,7 @@ vfio_region_mmaps_set_enabled(const char *name, bool enabled) "Region %s mmaps e
 vfio_region_sparse_mmap_header(const char *name, int index, int nr_areas) "Device %s region %d: %d sparse mmap entries"
 vfio_region_sparse_mmap_entry(int i, unsigned long start, unsigned long end) "sparse entry %d [0x%lx - 0x%lx]"
 vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_t subtype) "%s index %d, %08x/%0x8"
+vfio_dma_unmap_overflow_workaround(void) ""
 
 # hw/vfio/platform.c
 vfio_platform_base_device_init(char *name, int groupid) "%s belongs to group #%d"
