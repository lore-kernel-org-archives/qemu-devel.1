Received: from eggs.gnu.org ([2001:4830:134:3::10]:54174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ejrZJ-0006Cw-8r
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ejrZI-0008Mj-85
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:13 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52412 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ejrZI-0008MV-1G
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:12 -0500
Date: Thu, 8 Feb 2018 21:09:08 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1518116908-10852-14-git-send-email-mst@redhat.com>
References: <1518116908-10852-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518116908-10852-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 13/26] virtio-blk: enable multiple vectors when
 using multiple I/O queues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Changpeng Liu <changpeng.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Changpeng Liu <changpeng.liu@intel.com>

Currently virtio-pci driver hardcoded 2 vectors for virtio-blk device,
for multiple I/O queues scenario, all the I/O queues will share one
interrupt vector, while here, enable multiple vectors according to
the number of I/O queues.

Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/compat.h    |  8 ++++++++
 hw/virtio/virtio-pci.c | 14 ++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/hw/compat.h b/include/hw/compat.h
index 7f31850..bc9e3a6 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -6,6 +6,14 @@
         .driver   = "hpet",\
         .property = "hpet-offset-saved",\
         .value    = "false",\
+    },{\
+        .driver   = "virtio-blk-pci",\
+        .property = "vectors",\
+        .value    = "2",\
+    },{\
+        .driver   = "vhost-user-blk-pci",\
+        .property = "vectors",\
+        .value    = "2",\
     },
 
 #define HW_COMPAT_2_10 \
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index c20537f..b55dfcf 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1932,7 +1932,8 @@ static Property virtio_blk_pci_properties[] = {
     DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
     DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
-    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 2),
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
+                       DEV_NVECTORS_UNSPECIFIED),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -1941,6 +1942,10 @@ static void virtio_blk_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     VirtIOBlkPCI *dev = VIRTIO_BLK_PCI(vpci_dev);
     DeviceState *vdev = DEVICE(&dev->vdev);
 
+    if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
+        vpci_dev->nvectors = dev->vdev.conf.num_queues + 1;
+    }
+
     qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
     object_property_set_bool(OBJECT(vdev), true, "realized", errp);
 }
@@ -1983,7 +1988,8 @@ static const TypeInfo virtio_blk_pci_info = {
 
 static Property vhost_user_blk_pci_properties[] = {
     DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
-    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 2),
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
+                       DEV_NVECTORS_UNSPECIFIED),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -1992,6 +1998,10 @@ static void vhost_user_blk_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
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
MST
