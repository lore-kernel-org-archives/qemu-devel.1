Received: from eggs.gnu.org ([209.51.188.92]:36638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h3Gdm-0004ud-My
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 04:50:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h3Gdl-0002C4-52
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 04:50:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44279)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1h3Gdk-0002B4-OF
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 04:50:33 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 11 Mar 2019 09:50:21 +0100
Message-Id: <20190311085024.13780-3-kraxel@redhat.com>
In-Reply-To: <20190311085024.13780-1-kraxel@redhat.com>
References: <20190311085024.13780-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/5] virtio-vga: fix reset.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@wavecomp.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Store reset handler of the parent class and just call that for a
complete virtio reset.  When taking the shortcut and calling
virtio_gpu_reset() directly the generic virtio reset code (for
virtqueues etc) will not be executed.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1597621
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-id: 20190307080244.9011-3-kraxel@redhat.com
---
 hw/display/virtio-vga.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index 1e48009b74a6..a2b803b75f94 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -12,6 +12,10 @@
 #define TYPE_VIRTIO_VGA "virtio-vga"
 #define VIRTIO_VGA(obj) \
         OBJECT_CHECK(VirtIOVGA, (obj), TYPE_VIRTIO_VGA)
+#define VIRTIO_VGA_GET_CLASS(obj) \
+        OBJECT_GET_CLASS(VirtIOVGAClass, obj, TYPE_VIRTIO_VGA)
+#define VIRTIO_VGA_CLASS(klass) \
+        OBJECT_CLASS_CHECK(VirtIOVGAClass, klass, TYPE_VIRTIO_VGA)
=20
 typedef struct VirtIOVGA {
     VirtIOPCIProxy parent_obj;
@@ -20,6 +24,11 @@ typedef struct VirtIOVGA {
     MemoryRegion   vga_mrs[3];
 } VirtIOVGA;
=20
+typedef struct VirtIOVGAClass {
+    VirtioPCIClass parent_class;
+    DeviceReset parent_reset;
+} VirtIOVGAClass;
+
 static void virtio_vga_invalidate_display(void *opaque)
 {
     VirtIOVGA *vvga =3D opaque;
@@ -168,10 +177,11 @@ static void virtio_vga_realize(VirtIOPCIProxy *vpci=
_dev, Error **errp)
=20
 static void virtio_vga_reset(DeviceState *dev)
 {
+    VirtIOVGAClass *klass =3D VIRTIO_VGA_GET_CLASS(dev);
     VirtIOVGA *vvga =3D VIRTIO_VGA(dev);
=20
     /* reset virtio-gpu */
-    virtio_gpu_reset(VIRTIO_DEVICE(&vvga->vdev));
+    klass->parent_reset(dev);
=20
     /* reset vga */
     vga_common_reset(&vvga->vga);
@@ -187,13 +197,15 @@ static void virtio_vga_class_init(ObjectClass *klas=
s, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
     VirtioPCIClass *k =3D VIRTIO_PCI_CLASS(klass);
+    VirtIOVGAClass *v =3D VIRTIO_VGA_CLASS(klass);
     PCIDeviceClass *pcidev_k =3D PCI_DEVICE_CLASS(klass);
=20
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
     dc->props =3D virtio_vga_properties;
-    dc->reset =3D virtio_vga_reset;
     dc->vmsd =3D &vmstate_virtio_vga;
     dc->hotpluggable =3D false;
+    device_class_set_parent_reset(dc, virtio_vga_reset,
+                                  &v->parent_reset);
=20
     k->realize =3D virtio_vga_realize;
     pcidev_k->romfile =3D "vgabios-virtio.bin";
@@ -212,6 +224,7 @@ static VirtioPCIDeviceTypeInfo virtio_vga_info =3D {
     .generic_name  =3D TYPE_VIRTIO_VGA,
     .instance_size =3D sizeof(struct VirtIOVGA),
     .instance_init =3D virtio_vga_inst_initfn,
+    .class_size    =3D sizeof(struct VirtIOVGAClass),
     .class_init    =3D virtio_vga_class_init,
 };
=20
--=20
2.18.1
