Received: from eggs.gnu.org ([209.51.188.92]:60913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hIvNJ-0007rN-56
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 09:22:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hIvMu-00067l-1O
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 09:21:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hIvMs-00064c-1b
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 09:21:51 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 19DD0C04FFF6
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 13:21:48 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 23 Apr 2019 15:20:03 +0200
Message-Id: <20190423132004.13725-11-marcandre.lureau@redhat.com>
In-Reply-To: <20190423132004.13725-1-marcandre.lureau@redhat.com>
References: <20190423132004.13725-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 10/11] virtio-gpu: split virtio-gpu-pci &
 virtio-vga
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Add base classes that are common to vhost-user-gpu-pci and
vhost-user-vga.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-vga.h     |  32 +++++++++
 hw/display/virtio-gpu-pci.c |  52 +++++++++-----
 hw/display/virtio-vga.c     | 135 ++++++++++++++++++------------------
 MAINTAINERS                 |   2 +-
 4 files changed, 137 insertions(+), 84 deletions(-)
 create mode 100644 hw/display/virtio-vga.h

diff --git a/hw/display/virtio-vga.h b/hw/display/virtio-vga.h
new file mode 100644
index 0000000000..f03e1ba619
--- /dev/null
+++ b/hw/display/virtio-vga.h
@@ -0,0 +1,32 @@
+#ifndef VIRTIO_VGA_H_
+#define VIRTIO_VGA_H_
+
+#include "hw/virtio/virtio-pci.h"
+#include "vga_int.h"
+
+/*
+ * virtio-vga-base: This extends VirtioPCIProxy.
+ */
+#define TYPE_VIRTIO_VGA_BASE "virtio-vga-base"
+#define VIRTIO_VGA_BASE(obj)                                \
+    OBJECT_CHECK(VirtIOVGABase, (obj), TYPE_VIRTIO_VGA_BASE)
+#define VIRTIO_VGA_BASE_GET_CLASS(obj)                      \
+    OBJECT_GET_CLASS(VirtIOVGABaseClass, obj, TYPE_VIRTIO_VGA_BASE)
+#define VIRTIO_VGA_BASE_CLASS(klass)                        \
+    OBJECT_CLASS_CHECK(VirtIOVGABaseClass, klass, TYPE_VIRTIO_VGA_BASE)
+
+typedef struct VirtIOVGABase {
+    VirtIOPCIProxy parent_obj;
+
+    VirtIOGPUBase *vgpu;
+    VGACommonState vga;
+    MemoryRegion vga_mrs[3];
+} VirtIOVGABase;
+
+typedef struct VirtIOVGABaseClass {
+    VirtioPCIClass parent_class;
+
+    DeviceReset parent_reset;
+} VirtIOVGABaseClass;
+
+#endif /* VIRTIO_VGA_H_ */
diff --git a/hw/display/virtio-gpu-pci.c b/hw/display/virtio-gpu-pci.c
index 305ea5fff3..3b88bf4d1f 100644
--- a/hw/display/virtio-gpu-pci.c
+++ b/hw/display/virtio-gpu-pci.c
@@ -19,30 +19,30 @@
 #include "hw/virtio/virtio-pci.h"
 #include "hw/virtio/virtio-gpu.h"
=20
-typedef struct VirtIOGPUPCI VirtIOGPUPCI;
+typedef struct VirtIOGPUPCIBase VirtIOGPUPCIBase;
=20
 /*
- * virtio-gpu-pci: This extends VirtioPCIProxy.
+ * virtio-gpu-pci-base: This extends VirtioPCIProxy.
  */
-#define TYPE_VIRTIO_GPU_PCI "virtio-gpu-pci"
-#define VIRTIO_GPU_PCI(obj) \
-        OBJECT_CHECK(VirtIOGPUPCI, (obj), TYPE_VIRTIO_GPU_PCI)
+#define TYPE_VIRTIO_GPU_PCI_BASE "virtio-gpu-pci-base"
+#define VIRTIO_GPU_PCI_BASE(obj) \
+        OBJECT_CHECK(VirtIOGPUPCIBase, (obj), TYPE_VIRTIO_GPU_PCI_BASE)
=20
-struct VirtIOGPUPCI {
+struct VirtIOGPUPCIBase {
     VirtIOPCIProxy parent_obj;
-    VirtIOGPU vdev;
+    VirtIOGPUBase *vgpu;
 };
=20
-static Property virtio_gpu_pci_properties[] =3D {
+static Property virtio_gpu_pci_base_properties[] =3D {
     DEFINE_VIRTIO_GPU_PCI_PROPERTIES(VirtIOPCIProxy),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
-static void virtio_gpu_pci_realize(VirtIOPCIProxy *vpci_dev, Error **err=
p)
+static void virtio_gpu_pci_base_realize(VirtIOPCIProxy *vpci_dev, Error =
**errp)
 {
-    VirtIOGPUPCI *vgpu =3D VIRTIO_GPU_PCI(vpci_dev);
-    VirtIOGPUBase *g =3D VIRTIO_GPU_BASE(&vgpu->vdev);
-    DeviceState *vdev =3D DEVICE(&vgpu->vdev);
+    VirtIOGPUPCIBase *vgpu =3D VIRTIO_GPU_PCI_BASE(vpci_dev);
+    VirtIOGPUBase *g =3D vgpu->vgpu;
+    DeviceState *vdev =3D DEVICE(g);
     int i;
     Error *local_error =3D NULL;
=20
@@ -62,36 +62,56 @@ static void virtio_gpu_pci_realize(VirtIOPCIProxy *vp=
ci_dev, Error **errp)
     }
 }
=20
-static void virtio_gpu_pci_class_init(ObjectClass *klass, void *data)
+static void virtio_gpu_pci_base_class_init(ObjectClass *klass, void *dat=
a)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
     VirtioPCIClass *k =3D VIRTIO_PCI_CLASS(klass);
     PCIDeviceClass *pcidev_k =3D PCI_DEVICE_CLASS(klass);
=20
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
-    dc->props =3D virtio_gpu_pci_properties;
+    dc->props =3D virtio_gpu_pci_base_properties;
     dc->hotpluggable =3D false;
-    k->realize =3D virtio_gpu_pci_realize;
+    k->realize =3D virtio_gpu_pci_base_realize;
     pcidev_k->class_id =3D PCI_CLASS_DISPLAY_OTHER;
 }
=20
+static const TypeInfo virtio_gpu_pci_base_info =3D {
+    .name =3D TYPE_VIRTIO_GPU_PCI_BASE,
+    .parent =3D TYPE_VIRTIO_PCI,
+    .instance_size =3D sizeof(VirtIOGPUPCIBase),
+    .class_init =3D virtio_gpu_pci_base_class_init,
+    .abstract =3D true
+};
+
+#define TYPE_VIRTIO_GPU_PCI "virtio-gpu-pci"
+#define VIRTIO_GPU_PCI(obj)                                 \
+    OBJECT_CHECK(VirtIOGPUPCI, (obj), TYPE_VIRTIO_GPU_PCI)
+
+typedef struct VirtIOGPUPCI {
+    VirtIOGPUPCIBase parent_obj;
+    VirtIOGPU vdev;
+} VirtIOGPUPCI;
+
 static void virtio_gpu_initfn(Object *obj)
 {
     VirtIOGPUPCI *dev =3D VIRTIO_GPU_PCI(obj);
=20
     virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
                                 TYPE_VIRTIO_GPU);
+    VIRTIO_GPU_PCI_BASE(obj)->vgpu =3D VIRTIO_GPU_BASE(&dev->vdev);
 }
=20
 static const VirtioPCIDeviceTypeInfo virtio_gpu_pci_info =3D {
     .generic_name =3D TYPE_VIRTIO_GPU_PCI,
+    .parent =3D TYPE_VIRTIO_GPU_PCI_BASE,
     .instance_size =3D sizeof(VirtIOGPUPCI),
     .instance_init =3D virtio_gpu_initfn,
-    .class_init =3D virtio_gpu_pci_class_init,
 };
=20
 static void virtio_gpu_pci_register_types(void)
 {
+    type_register_static(&virtio_gpu_pci_base_info);
     virtio_pci_types_register(&virtio_gpu_pci_info);
 }
+
 type_init(virtio_gpu_pci_register_types)
diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index 33af54d44f..caa3e138b0 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -1,66 +1,42 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
-#include "vga_int.h"
-#include "hw/virtio/virtio-pci.h"
 #include "hw/virtio/virtio-gpu.h"
 #include "qapi/error.h"
+#include "virtio-vga.h"
=20
-/*
- * virtio-vga: This extends VirtioPCIProxy.
- */
-#define TYPE_VIRTIO_VGA "virtio-vga"
-#define VIRTIO_VGA(obj) \
-        OBJECT_CHECK(VirtIOVGA, (obj), TYPE_VIRTIO_VGA)
-#define VIRTIO_VGA_GET_CLASS(obj) \
-        OBJECT_GET_CLASS(VirtIOVGAClass, obj, TYPE_VIRTIO_VGA)
-#define VIRTIO_VGA_CLASS(klass) \
-        OBJECT_CLASS_CHECK(VirtIOVGAClass, klass, TYPE_VIRTIO_VGA)
-
-typedef struct VirtIOVGA {
-    VirtIOPCIProxy parent_obj;
-    VirtIOGPU      vdev;
-    VGACommonState vga;
-    MemoryRegion   vga_mrs[3];
-} VirtIOVGA;
-
-typedef struct VirtIOVGAClass {
-    VirtioPCIClass parent_class;
-    DeviceReset parent_reset;
-} VirtIOVGAClass;
-
-static void virtio_vga_invalidate_display(void *opaque)
+static void virtio_vga_base_invalidate_display(void *opaque)
 {
-    VirtIOVGA *vvga =3D opaque;
-    VirtIOGPUBase *g =3D VIRTIO_GPU_BASE(&vvga->vdev);
+    VirtIOVGABase *vvga =3D opaque;
+    VirtIOGPUBase *g =3D vvga->vgpu;
=20
     if (g->enable) {
-        virtio_gpu_ops.invalidate(&vvga->vdev);
+        virtio_gpu_ops.invalidate(g);
     } else {
         vvga->vga.hw_ops->invalidate(&vvga->vga);
     }
 }
=20
-static void virtio_vga_update_display(void *opaque)
+static void virtio_vga_base_update_display(void *opaque)
 {
-    VirtIOVGA *vvga =3D opaque;
-    VirtIOGPUBase *g =3D VIRTIO_GPU_BASE(&vvga->vdev);
+    VirtIOVGABase *vvga =3D opaque;
+    VirtIOGPUBase *g =3D vvga->vgpu;
=20
     if (g->enable) {
-        virtio_gpu_ops.gfx_update(&vvga->vdev);
+        virtio_gpu_ops.gfx_update(g);
     } else {
         vvga->vga.hw_ops->gfx_update(&vvga->vga);
     }
 }
=20
-static void virtio_vga_text_update(void *opaque, console_ch_t *chardata)
+static void virtio_vga_base_text_update(void *opaque, console_ch_t *char=
data)
 {
-    VirtIOVGA *vvga =3D opaque;
-    VirtIOGPUBase *g =3D VIRTIO_GPU_BASE(&vvga->vdev);
+    VirtIOVGABase *vvga =3D opaque;
+    VirtIOGPUBase *g =3D vvga->vgpu;
=20
     if (g->enable) {
         if (virtio_gpu_ops.text_update) {
-            virtio_gpu_ops.text_update(&vvga->vdev, chardata);
+            virtio_gpu_ops.text_update(g, chardata);
         }
     } else {
         if (vvga->vga.hw_ops->text_update) {
@@ -69,49 +45,52 @@ static void virtio_vga_text_update(void *opaque, cons=
ole_ch_t *chardata)
     }
 }
=20
-static int virtio_vga_ui_info(void *opaque, uint32_t idx, QemuUIInfo *in=
fo)
+static int virtio_vga_base_ui_info(void *opaque, uint32_t idx, QemuUIInf=
o *info)
 {
-    VirtIOVGA *vvga =3D opaque;
+    VirtIOVGABase *vvga =3D opaque;
+    VirtIOGPUBase *g =3D vvga->vgpu;
=20
     if (virtio_gpu_ops.ui_info) {
-        return virtio_gpu_ops.ui_info(&vvga->vdev, idx, info);
+        return virtio_gpu_ops.ui_info(g, idx, info);
     }
     return -1;
 }
=20
-static void virtio_vga_gl_block(void *opaque, bool block)
+static void virtio_vga_base_gl_block(void *opaque, bool block)
 {
-    VirtIOVGA *vvga =3D opaque;
+    VirtIOVGABase *vvga =3D opaque;
+    VirtIOGPUBase *g =3D vvga->vgpu;
=20
     if (virtio_gpu_ops.gl_block) {
-        virtio_gpu_ops.gl_block(&vvga->vdev, block);
+        virtio_gpu_ops.gl_block(g, block);
     }
 }
=20
-static const GraphicHwOps virtio_vga_ops =3D {
-    .invalidate =3D virtio_vga_invalidate_display,
-    .gfx_update =3D virtio_vga_update_display,
-    .text_update =3D virtio_vga_text_update,
-    .ui_info =3D virtio_vga_ui_info,
-    .gl_block =3D virtio_vga_gl_block,
+static const GraphicHwOps virtio_vga_base_ops =3D {
+    .invalidate =3D virtio_vga_base_invalidate_display,
+    .gfx_update =3D virtio_vga_base_update_display,
+    .text_update =3D virtio_vga_base_text_update,
+    .ui_info =3D virtio_vga_base_ui_info,
+    .gl_block =3D virtio_vga_base_gl_block,
 };
=20
-static const VMStateDescription vmstate_virtio_vga =3D {
+static const VMStateDescription vmstate_virtio_vga_base =3D {
     .name =3D "virtio-vga",
     .version_id =3D 2,
     .minimum_version_id =3D 2,
     .fields =3D (VMStateField[]) {
         /* no pci stuff here, saving the virtio device will handle that =
*/
-        VMSTATE_STRUCT(vga, VirtIOVGA, 0, vmstate_vga_common, VGACommonS=
tate),
+        VMSTATE_STRUCT(vga, VirtIOVGABase, 0,
+                       vmstate_vga_common, VGACommonState),
         VMSTATE_END_OF_LIST()
     }
 };
=20
 /* VGA device wrapper around PCI device around virtio GPU */
-static void virtio_vga_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+static void virtio_vga_base_realize(VirtIOPCIProxy *vpci_dev, Error **er=
rp)
 {
-    VirtIOVGA *vvga =3D VIRTIO_VGA(vpci_dev);
-    VirtIOGPUBase *g =3D VIRTIO_GPU_BASE(&vvga->vdev);
+    VirtIOVGABase *vvga =3D VIRTIO_VGA_BASE(vpci_dev);
+    VirtIOGPUBase *g =3D vvga->vgpu;
     VGACommonState *vga =3D &vvga->vga;
     Error *err =3D NULL;
     uint32_t offset;
@@ -169,7 +148,7 @@ static void virtio_vga_realize(VirtIOPCIProxy *vpci_d=
ev, Error **errp)
                                  vvga->vga_mrs, true, false);
=20
     vga->con =3D g->scanout[0].con;
-    graphic_console_set_hwops(vga->con, &virtio_vga_ops, vvga);
+    graphic_console_set_hwops(vga->con, &virtio_vga_base_ops, vvga);
=20
     for (i =3D 0; i < g->conf.max_outputs; i++) {
         object_property_set_link(OBJECT(g->scanout[i].con),
@@ -178,10 +157,10 @@ static void virtio_vga_realize(VirtIOPCIProxy *vpci=
_dev, Error **errp)
     }
 }
=20
-static void virtio_vga_reset(DeviceState *dev)
+static void virtio_vga_base_reset(DeviceState *dev)
 {
-    VirtIOVGAClass *klass =3D VIRTIO_VGA_GET_CLASS(dev);
-    VirtIOVGA *vvga =3D VIRTIO_VGA(dev);
+    VirtIOVGABaseClass *klass =3D VIRTIO_VGA_BASE_GET_CLASS(dev);
+    VirtIOVGABase *vvga =3D VIRTIO_VGA_BASE(dev);
=20
     /* reset virtio-gpu */
     klass->parent_reset(dev);
@@ -191,48 +170,70 @@ static void virtio_vga_reset(DeviceState *dev)
     vga_dirty_log_start(&vvga->vga);
 }
=20
-static Property virtio_vga_properties[] =3D {
+static Property virtio_vga_base_properties[] =3D {
     DEFINE_VIRTIO_GPU_PCI_PROPERTIES(VirtIOPCIProxy),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
-static void virtio_vga_class_init(ObjectClass *klass, void *data)
+static void virtio_vga_base_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
     VirtioPCIClass *k =3D VIRTIO_PCI_CLASS(klass);
-    VirtIOVGAClass *v =3D VIRTIO_VGA_CLASS(klass);
+    VirtIOVGABaseClass *v =3D VIRTIO_VGA_BASE_CLASS(klass);
     PCIDeviceClass *pcidev_k =3D PCI_DEVICE_CLASS(klass);
=20
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
-    dc->props =3D virtio_vga_properties;
-    dc->vmsd =3D &vmstate_virtio_vga;
+    dc->props =3D virtio_vga_base_properties;
+    dc->vmsd =3D &vmstate_virtio_vga_base;
     dc->hotpluggable =3D false;
-    device_class_set_parent_reset(dc, virtio_vga_reset,
+    device_class_set_parent_reset(dc, virtio_vga_base_reset,
                                   &v->parent_reset);
=20
-    k->realize =3D virtio_vga_realize;
+    k->realize =3D virtio_vga_base_realize;
     pcidev_k->romfile =3D "vgabios-virtio.bin";
     pcidev_k->class_id =3D PCI_CLASS_DISPLAY_VGA;
 }
=20
+static TypeInfo virtio_vga_base_info =3D {
+    .name          =3D TYPE_VIRTIO_VGA_BASE,
+    .parent        =3D TYPE_VIRTIO_PCI,
+    .instance_size =3D sizeof(struct VirtIOVGABase),
+    .class_size    =3D sizeof(struct VirtIOVGABaseClass),
+    .class_init    =3D virtio_vga_base_class_init,
+    .abstract      =3D true,
+};
+
+#define TYPE_VIRTIO_VGA "virtio-vga"
+
+#define VIRTIO_VGA(obj)                             \
+    OBJECT_CHECK(VirtIOVGA, (obj), TYPE_VIRTIO_VGA)
+
+typedef struct VirtIOVGA {
+    VirtIOVGABase parent_obj;
+
+    VirtIOGPU     vdev;
+} VirtIOVGA;
+
 static void virtio_vga_inst_initfn(Object *obj)
 {
     VirtIOVGA *dev =3D VIRTIO_VGA(obj);
=20
     virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
                                 TYPE_VIRTIO_GPU);
+    VIRTIO_VGA_BASE(dev)->vgpu =3D VIRTIO_GPU_BASE(&dev->vdev);
 }
=20
+
 static VirtioPCIDeviceTypeInfo virtio_vga_info =3D {
     .generic_name  =3D TYPE_VIRTIO_VGA,
+    .parent        =3D TYPE_VIRTIO_VGA_BASE,
     .instance_size =3D sizeof(struct VirtIOVGA),
     .instance_init =3D virtio_vga_inst_initfn,
-    .class_size    =3D sizeof(struct VirtIOVGAClass),
-    .class_init    =3D virtio_vga_class_init,
 };
=20
 static void virtio_vga_register_types(void)
 {
+    type_register_static(&virtio_vga_base_info);
     virtio_pci_types_register(&virtio_vga_info);
 }
=20
diff --git a/MAINTAINERS b/MAINTAINERS
index 476fe4c49c..ef25553169 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1656,7 +1656,7 @@ virtio-gpu
 M: Gerd Hoffmann <kraxel@redhat.com>
 S: Maintained
 F: hw/display/virtio-gpu*
-F: hw/display/virtio-vga.c
+F: hw/display/virtio-vga.*
 F: include/hw/virtio/virtio-gpu.h
=20
 vhost-user-gpu
--=20
2.21.0.313.ge35b8cb8e2
