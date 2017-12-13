Received: from eggs.gnu.org ([2001:4830:134:3::10]:51910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ePBWt-00055U-F4
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:13:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ePBWr-0008G3-3d
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:13:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1ePBWq-0008FG-U9
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:13:13 -0500
From: Alex Williamson <alex.williamson@redhat.com>
Date: Wed, 13 Dec 2017 11:13:09 -0700
Message-ID: <20171213181301.10875.78618.stgit@gimli.home>
In-Reply-To: <20171213180541.10386.38737.stgit@gimli.home>
References: <20171213180541.10386.38737.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 3/4] vfio/spapr: Allow fallback to SPAPR TCE
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
Cc: aik@ozlabs.ru

From: Alexey Kardashevskiy <aik@ozlabs.ru>

The vfio_iommu_spapr_tce driver advertises kernel's support for
v1 and v2 IOMMU support, however it is not always possible to use
the requested IOMMU type. For example, a pseries host platform does not
support dynamic DMA windows so v2 cannot initialize and QEMU fails to
start.

This adds a fallback to the v1 IOMMU if v2 cannot be used.

Fixes: 318f67ce1371 ("vfio: spapr: Add DMA memory preregistering (SPAPR IOMMU v2)")
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/common.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 216eec68ef68..b77be3a8b36b 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1043,6 +1043,11 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
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
