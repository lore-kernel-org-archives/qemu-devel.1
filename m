Received: from eggs.gnu.org ([2001:4830:134:3::10]:55471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1eh7ha-0008PR-Bf
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 00:46:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1eh7hX-000536-9f
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 00:46:26 -0500
Received: from mga04.intel.com ([192.55.52.120]:11115)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1eh7hW-00052c-VZ
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 00:46:23 -0500
From: Changpeng Liu <changpeng.liu@intel.com>
Date: Thu,  1 Feb 2018 13:51:33 +0800
Message-Id: <1517464293-7012-1-git-send-email-changpeng.liu@intel.com>
Subject: [Qemu-devel] [PATCH] virtio-blk: enable multiple vectors when using
 multiple I/O queues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: changpeng.liu@intel.com, qemu-devel@nongnu.org
Cc: stefanha@gmail.com, pbonzini@redhat.com, mst@redhat.com, marcandre.lureau@redhat.com, james.r.harris@intel.com

Currently virtio-pci driver hardcoded 2 vectors for virtio-blk device,
for multiple I/O queues scenario, all the I/O queues will share one
interrupt vector, while here, enable multiple vectors according to
the number of I/O queues.

Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
---
 hw/virtio/virtio-pci.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 9ae10f0..379b00c 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1932,7 +1932,7 @@ static Property virtio_blk_pci_properties[] = {
     DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
     DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
-    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 2),
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, DEV_NVECTORS_UNSPECIFIED),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -1941,6 +1941,10 @@ static void virtio_blk_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     VirtIOBlkPCI *dev = VIRTIO_BLK_PCI(vpci_dev);
     DeviceState *vdev = DEVICE(&dev->vdev);
 
+    if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
+        vpci_dev->nvectors = dev->vdev.conf.num_queues + 1;
+    }
+
     qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
     object_property_set_bool(OBJECT(vdev), true, "realized", errp);
 }
@@ -1983,7 +1987,7 @@ static const TypeInfo virtio_blk_pci_info = {
 
 static Property vhost_user_blk_pci_properties[] = {
     DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
-    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 2),
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, DEV_NVECTORS_UNSPECIFIED),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -1992,6 +1996,10 @@ static void vhost_user_blk_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     VHostUserBlkPCI *dev = VHOST_USER_BLK_PCI(vpci_dev);
     DeviceState *vdev = DEVICE(&dev->vdev);
 
+    if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
+        vpci_dev->nvectors = dev->vdev.num_queues + 1;
+    }
+
     qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
     object_property_set_bool(OBJECT(vdev), true, "realized", errp);
 }
-- 
1.9.3
