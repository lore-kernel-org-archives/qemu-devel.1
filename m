Received: from eggs.gnu.org ([2001:4830:134:3::10]:54359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eHQBK-0005MN-TP
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 03:14:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eHQBG-0007xu-4U
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 03:14:54 -0500
Received: from mga03.intel.com ([134.134.136.65]:57618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1eHQBF-0007wv-FL
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 03:14:50 -0500
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Date: Wed, 22 Nov 2017 15:58:02 +0800
Message-Id: <1511337482-15505-1-git-send-email-yi.l.liu@linux.intel.com>
Subject: [Qemu-devel] [PATCH] vfio/common: init giommu_list and hostwin_list
 of vfio container
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, david@gibson.dropbear.id.au, pbonzini@redhat.com, alex.williamson@redhat.com, aik@ozlabs.ru, yi.l.liu@intel.com, "Liu, Yi L" <yi.l.liu@linux.intel.com>

The init of giommu_list and hostwin_list is missed during container
initialization.

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 hw/vfio/common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 7b2924c..14c5940 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -990,6 +990,8 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     container = g_malloc0(sizeof(*container));
     container->space = space;
     container->fd = fd;
+    QLIST_INIT(&container->giommu_list);
+    QLIST_INIT(&container->hostwin_list);
     if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1_IOMMU) ||
         ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU)) {
         bool v2 = !!ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU);
-- 
1.9.1
