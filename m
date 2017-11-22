Received: from eggs.gnu.org ([2001:4830:134:3::10]:37508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eHNOB-0000QQ-2U
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 00:15:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eHNO7-0004I3-Un
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 00:15:59 -0500
Received: from ozlabs.ru ([107.173.13.209]:59386)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eHNO7-0004Hg-Ow
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 00:15:55 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Wed, 22 Nov 2017 16:15:52 +1100
Message-Id: <20171122051552.3529-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu] vfio/spapr: Allow fallback to SPAPR TCE
 IOMMU v1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>

The vfio_iommu_spapr_tce driver always advertises v1 and v2 IOMMU support,
however PR KVM (a special version of KVM designed to work in
a paravirtualized system; these days used for nested virtualizaion) only
supports the "pseries" platform which does not support v2. Since there is
no way to choose the IOMMU version in QEMU, it fails to start.

This adds a fallback to the v1 IOMMU if v2 cannot be used.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
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
