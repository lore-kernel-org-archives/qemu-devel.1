Received: from eggs.gnu.org ([2001:4830:134:3::10]:43457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs4bC-00052K-38
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 07:13:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs4bA-0001mC-AZ
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 07:13:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60304 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fs4bA-0001lx-5W
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 07:13:20 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Aug 2018 13:13:12 +0200
Message-Id: <20180821111313.27792-2-kraxel@redhat.com>
In-Reply-To: <20180821111313.27792-1-kraxel@redhat.com>
References: <20180821111313.27792-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] virtio-vga: fix reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

We must call the reset functions for both virtio-gpu
and vga to properly reset the combo device.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/virtio/virtio-gpu.h | 1 +
 hw/display/virtio-gpu.c        | 2 +-
 hw/display/virtio-vga.c        | 6 +++++-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index d0321672f4..a718b7233f 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -150,6 +150,7 @@ extern const GraphicHwOps virtio_gpu_ops;
     } while (0)
 
 /* virtio-gpu.c */
+void virtio_gpu_reset(VirtIODevice *vdev);
 void virtio_gpu_ctrl_response(VirtIOGPU *g,
                               struct virtio_gpu_ctrl_command *cmd,
                               struct virtio_gpu_ctrl_hdr *resp,
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 3ddd29c0de..d6c9b02b86 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1289,7 +1289,7 @@ static void virtio_gpu_instance_init(Object *obj)
 {
 }
 
-static void virtio_gpu_reset(VirtIODevice *vdev)
+void virtio_gpu_reset(VirtIODevice *vdev)
 {
     VirtIOGPU *g = VIRTIO_GPU(vdev);
     struct virtio_gpu_simple_resource *res, *tmp;
diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index 701d980872..50c72f26f4 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -179,8 +179,12 @@ static void virtio_vga_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
 static void virtio_vga_reset(DeviceState *dev)
 {
     VirtIOVGA *vvga = VIRTIO_VGA(dev);
-    vvga->vdev.enable = 0;
 
+    /* reset virtio-gpu */
+    virtio_gpu_reset(VIRTIO_DEVICE(&vvga->vdev));
+
+    /* reset vga */
+    vga_common_reset(&vvga->vga);
     vga_dirty_log_start(&vvga->vga);
 }
 
-- 
2.9.3
