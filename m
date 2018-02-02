Received: from eggs.gnu.org ([2001:4830:134:3::10]:51345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eheYm-0002to-2y
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:52:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eheXi-0004QA-21
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:51:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eheXh-0004OK-EA
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:50:25 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1B20A4F1CD
	for <qemu-devel@nongnu.org>; Fri,  2 Feb 2018 08:32:45 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  2 Feb 2018 09:32:29 +0100
Message-Id: <20180202083229.6681-2-kraxel@redhat.com>
In-Reply-To: <20180202083229.6681-1-kraxel@redhat.com>
References: <20180202083229.6681-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/1] virtio-gpu: disallow vIOMMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

From: Peter Xu <peterx@redhat.com>

virtio-gpu has special code path that bypassed vIOMMU protection.  So
for now let's disable iommu_platform for the device until we fully
support that (if needed).

After the patch, both virtio-vga and virtio-gpu won't allow to boot with
iommu_platform parameter set.

CC: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-id: 20180131040401.3550-1-peterx@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/virtio-gpu-pci.c | 8 +++++++-
 hw/display/virtio-gpu.c     | 5 +++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu-pci.c b/hw/display/virtio-gpu-pci.c
index ef92c4ad6f..3519dc80b1 100644
--- a/hw/display/virtio-gpu-pci.c
+++ b/hw/display/virtio-gpu-pci.c
@@ -28,10 +28,16 @@ static void virtio_gpu_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     VirtIOGPU *g = &vgpu->vdev;
     DeviceState *vdev = DEVICE(&vgpu->vdev);
     int i;
+    Error *local_error = NULL;
 
     qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
     virtio_pci_force_virtio_1(vpci_dev);
-    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+    object_property_set_bool(OBJECT(vdev), true, "realized", &local_error);
+
+    if (local_error) {
+        error_propagate(errp, local_error);
+        return;
+    }
 
     for (i = 0; i < g->conf.max_outputs; i++) {
         object_property_set_link(OBJECT(g->scanout[i].con),
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 274e365713..6658f6c6a6 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1173,6 +1173,11 @@ static void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
     Error *local_err = NULL;
     int i;
 
+    if (virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM)) {
+        error_setg(errp, "virtio-gpu does not support vIOMMU yet");
+        return;
+    }
+
     if (g->conf.max_outputs > VIRTIO_GPU_MAX_SCANOUTS) {
         error_setg(errp, "invalid max_outputs > %d", VIRTIO_GPU_MAX_SCANOUTS);
         return;
-- 
2.9.3
