Received: from eggs.gnu.org ([2001:4830:134:3::10]:46673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eOcvp-0003DT-6W
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 00:16:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eOcvl-0005Iw-77
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 00:16:41 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Tue, 12 Dec 2017 16:16:19 +1100
Message-Id: <20171212051619.24456-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v2] vfio/spapr: Allow fallback to SPAPR
 TCE IOMMU v1
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

The vfio_iommu_spapr_tce driver advertises kernel's support for
v1 and v2 IOMMU support, however it is not always possible to use
the requested IOMMU type. For example, a pseries host platform does not
support dynamic DMA windows so v2 cannot initialize and QEMU fails to
start.

This adds a fallback to the v1 IOMMU if v2 cannot be used.

Fixes: 318f67ce1371 "vfio: spapr: Add DMA memory preregistering (SPAPR IOMMU v2)"
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v2:
* updated commit log

---
 hw/vfio/common.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 7b2924c..cd81cc9 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1040,6 +1040,11 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
             v2 ? VFIO_SPAPR_TCE_v2_IOMMU : VFIO_SPAPR_TCE_IOMMU;
         ret = ioctl(fd, VFIO_SET_IOMMU, container->iommu_type);
         if (ret) {
+            container->iommu_type = VFIO_SPAPR_TCE_IOMMU;
+            v2 = false;
+            ret = ioctl(fd, VFIO_SET_IOMMU, container->iommu_type);
+        }
+        if (ret) {
             error_setg_errno(errp, errno, "failed to set iommu for container");
             ret = -errno;
             goto free_container_exit;
-- 
2.11.0
