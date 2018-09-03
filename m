Received: from eggs.gnu.org ([2001:4830:134:3::10]:58480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fwio9-0001mr-9C
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 02:57:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fwio8-0008Hu-Hi
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 02:57:57 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  3 Sep 2018 08:57:41 +0200
Message-Id: <20180903065745.23055-2-kraxel@redhat.com>
In-Reply-To: <20180903065745.23055-1-kraxel@redhat.com>
References: <20180903065745.23055-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/5] virtio-vga: fix reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Alistair Francis <alistair@alistair23.me>

We must call the reset functions for both virtio-gpu
and vga to properly reset the combo device.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20180821111313.27792-2-kraxel@redhat.com
---
 include/hw/virtio/virtio-gpu.h | 1 +
 hw/display/virtio-gpu.c        | 2 +-
 hw/display/virtio-vga.c        | 6 +++++-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
index d0321672f4..a718b7233f 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -150,6 +150,7 @@ extern const GraphicHwOps virtio_gpu_ops;
     } while (0)
=20
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
=20
-static void virtio_gpu_reset(VirtIODevice *vdev)
+void virtio_gpu_reset(VirtIODevice *vdev)
 {
     VirtIOGPU *g =3D VIRTIO_GPU(vdev);
     struct virtio_gpu_simple_resource *res, *tmp;
diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index 701d980872..50c72f26f4 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -179,8 +179,12 @@ static void virtio_vga_realize(VirtIOPCIProxy *vpci_=
dev, Error **errp)
 static void virtio_vga_reset(DeviceState *dev)
 {
     VirtIOVGA *vvga =3D VIRTIO_VGA(dev);
-    vvga->vdev.enable =3D 0;
=20
+    /* reset virtio-gpu */
+    virtio_gpu_reset(VIRTIO_DEVICE(&vvga->vdev));
+
+    /* reset vga */
+    vga_common_reset(&vvga->vga);
     vga_dirty_log_start(&vvga->vga);
 }
=20
--=20
2.9.3
