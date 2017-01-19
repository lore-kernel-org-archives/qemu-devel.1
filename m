Received: from eggs.gnu.org ([2001:4830:134:3::10]:36972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJy9-0000v8-IG
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:10:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJy8-0000Pf-M5
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:10:05 -0500
Received: from mail.kernel.org ([198.145.29.136]:57014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJy8-0000OG-ED
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:10:04 -0500
Date: Thu, 19 Jan 2017 23:10:00 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484860116-25361-18-git-send-email-mst@redhat.com>
References: <1484860116-25361-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484860116-25361-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 17/17] virtio: force VIRTIO_F_IOMMU_PLATFORM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>

From: Jason Wang <jasowang@redhat.com>

We allow vhost to clear VIRITO_F_IOMMU_PLATFORM which is wrong since
VIRTIO_F_IOMMU_PLATFORM is mandatory for security. Fixing this by
enforce it after vdc->get_features().

Signed-off-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-bus.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
index d31cc00..a886011 100644
--- a/hw/virtio/virtio-bus.c
+++ b/hw/virtio/virtio-bus.c
@@ -47,6 +47,7 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, Error **errp)
     VirtioBusState *bus = VIRTIO_BUS(qbus);
     VirtioBusClass *klass = VIRTIO_BUS_GET_CLASS(bus);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
+    bool has_iommu = virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
 
     DPRINTF("%s: plug device.\n", qbus->name);
 
@@ -63,8 +64,8 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, Error **errp)
         klass->device_plugged(qbus->parent, errp);
     }
 
-    if (klass->get_dma_as != NULL &&
-        virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM)) {
+    if (klass->get_dma_as != NULL && has_iommu) {
+        virtio_add_feature(&vdev->host_features, VIRTIO_F_IOMMU_PLATFORM);
         vdev->dma_as = klass->get_dma_as(qbus->parent);
     } else {
         vdev->dma_as = &address_space_memory;
-- 
MST
