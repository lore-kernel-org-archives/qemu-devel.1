Received: from eggs.gnu.org ([2001:4830:134:3::10]:51259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ePBWN-0004Uv-Br
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ePBWK-0007Pr-9u
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1ePBWK-0007PA-3H
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:40 -0500
From: Alex Williamson <alex.williamson@redhat.com>
Date: Wed, 13 Dec 2017 11:12:36 -0700
Message-ID: <20171213181227.10809.9824.stgit@gimli.home>
In-Reply-To: <20171213180541.10386.38737.stgit@gimli.home>
References: <20171213180541.10386.38737.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 2/4] vfio/common: init giommu_list and
 hostwin_list of vfio container
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: yi.l.liu@linux.intel.com

From: Liu, Yi L <yi.l.liu@linux.intel.com>

The init of giommu_list and hostwin_list is missed during container
initialization.

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/common.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 7007878e345e..216eec68ef68 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -991,6 +991,8 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     container = g_malloc0(sizeof(*container));
     container->space = space;
     container->fd = fd;
+    QLIST_INIT(&container->giommu_list);
+    QLIST_INIT(&container->hostwin_list);
     if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1_IOMMU) ||
         ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU)) {
         bool v2 = !!ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU);
