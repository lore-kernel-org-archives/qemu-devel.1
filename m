Received: from eggs.gnu.org ([2001:4830:134:3::10]:41512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fdxqB-0004jN-Ui
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:10:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fdxq9-0006BO-Pk
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:10:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50156 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fdxq9-0006AV-G7
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:10:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EA71981A7CFF
	for <qemu-devel@nongnu.org>; Fri, 13 Jul 2018 13:10:28 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Jul 2018 15:09:15 +0200
Message-Id: <20180713130916.4153-29-marcandre.lureau@redhat.com>
In-Reply-To: <20180713130916.4153-1-marcandre.lureau@redhat.com>
References: <20180713130916.4153-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 28/29] virtio-gpu: split virtio-gpu-pci &
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
Cc: airlied@redhat.com, kraxel@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Add base classes that are common to vhost-user-gpu-pci and
vhost-user-vga.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-vga.h     |  22 +++++++
 hw/virtio/virtio-pci.h      |  16 ++---
 hw/display/virtio-gpu-pci.c |  39 +++++++++---
 hw/display/virtio-vga.c     | 122 +++++++++++++++++++-----------------
 MAINTAINERS                 |   2 +-
 5 files changed, 126 insertions(+), 75 deletions(-)
 create mode 100644 hw/display/virtio-vga.h

diff --git a/hw/display/virtio-vga.h b/hw/display/virtio-vga.h
new file mode 100644
index 0000000000..212624449c
--- /dev/null
+++ b/hw/display/virtio-vga.h
@@ -0,0 +1,22 @@
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
+
+typedef struct VirtIOVGABase {
+    VirtIOPCIProxy parent_obj;
+
+    VirtIOGPUBase *vgpu;
+    VGACommonState vga;
+    MemoryRegion   vga_mrs[3];
+} VirtIOVGABase;
+
+#endif /* VIRTIO_VGA_H_ */
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index c7e28e1b9c..42240f47b3 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -386,17 +386,19 @@ struct VHostUserInputPCI {
     VHostUserInput vhi;
 };
=20
+
 /*
- * virtio-gpu-pci: This extends VirtioPCIProxy.
+ * virtio-gpu-pci-base: This extends VirtioPCIProxy.
  */
-#define TYPE_VIRTIO_GPU_PCI "virtio-gpu-pci"
-#define VIRTIO_GPU_PCI(obj) \
-        OBJECT_CHECK(VirtIOGPUPCI, (obj), TYPE_VIRTIO_GPU_PCI)
+#define TYPE_VIRTIO_GPU_PCI_BASE "virtio-gpu-pci-base"
+#define VIRTIO_GPU_PCI_BASE(obj)                                 \
+    OBJECT_CHECK(VirtIOGPUPCIBase, (obj), TYPE_VIRTIO_GPU_PCI_BASE)
=20
-struct VirtIOGPUPCI {
+typedef struct VirtIOGPUPCIBase {
     VirtIOPCIProxy parent_obj;
-    VirtIOGPU vdev;
-};
+
+    VirtIOGPUBase *vgpu;
+} VirtIOGPUPCIBase;
=20
 #ifdef CONFIG_VHOST_VSOCK
 /*
diff --git a/hw/display/virtio-gpu-pci.c b/hw/display/virtio-gpu-pci.c
index 741badd909..5db6ad890d 100644
--- a/hw/display/virtio-gpu-pci.c
+++ b/hw/display/virtio-gpu-pci.c
@@ -19,16 +19,16 @@
 #include "hw/virtio/virtio-pci.h"
 #include "hw/virtio/virtio-gpu.h"
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
@@ -48,37 +48,56 @@ static void virtio_gpu_pci_realize(VirtIOPCIProxy *vp=
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
+struct VirtIOGPUPCI {
+    VirtIOGPUPCIBase parent_obj;
+    VirtIOGPU vdev;
+};
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
 static const TypeInfo virtio_gpu_pci_info =3D {
     .name =3D TYPE_VIRTIO_GPU_PCI,
-    .parent =3D TYPE_VIRTIO_PCI,
+    .parent =3D TYPE_VIRTIO_GPU_PCI_BASE,
     .instance_size =3D sizeof(VirtIOGPUPCI),
     .instance_init =3D virtio_gpu_initfn,
-    .class_init =3D virtio_gpu_pci_class_init,
 };
=20
 static void virtio_gpu_pci_register_types(void)
 {
+    type_register_static(&virtio_gpu_pci_base_info);
     type_register_static(&virtio_gpu_pci_info);
 }
+
 type_init(virtio_gpu_pci_register_types)
diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index 00939b7e0c..57b7b65423 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -1,56 +1,41 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
-#include "vga_int.h"
-#include "hw/virtio/virtio-pci.h"
 #include "qapi/error.h"
+#include "virtio-vga.h"
=20
-/*
- * virtio-vga: This extends VirtioPCIProxy.
- */
-#define TYPE_VIRTIO_VGA "virtio-vga"
-#define VIRTIO_VGA(obj) \
-        OBJECT_CHECK(VirtIOVGA, (obj), TYPE_VIRTIO_VGA)
-
-typedef struct VirtIOVGA {
-    VirtIOPCIProxy parent_obj;
-    VirtIOGPU      vdev;
-    VGACommonState vga;
-    MemoryRegion   vga_mrs[3];
-} VirtIOVGA;
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
@@ -59,49 +44,52 @@ static void virtio_vga_text_update(void *opaque, cons=
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
@@ -159,7 +147,7 @@ static void virtio_vga_realize(VirtIOPCIProxy *vpci_d=
ev, Error **errp)
                                  vvga->vga_mrs, true);
=20
     vga->con =3D g->scanout[0].con;
-    graphic_console_set_hwops(vga->con, &virtio_vga_ops, vvga);
+    graphic_console_set_hwops(vga->con, &virtio_vga_base_ops, vvga);
=20
     for (i =3D 0; i < g->conf.max_outputs; i++) {
         object_property_set_link(OBJECT(g->scanout[i].con),
@@ -168,56 +156,76 @@ static void virtio_vga_realize(VirtIOPCIProxy *vpci=
_dev, Error **errp)
     }
 }
=20
-static void virtio_vga_reset(DeviceState *dev)
+static void virtio_vga_base_reset(DeviceState *dev)
 {
-    VirtIOVGA *vvga =3D VIRTIO_VGA(dev);
-    VirtIOGPUBase *g =3D VIRTIO_GPU_BASE(&vvga->vdev);
+    VirtIOVGABase *vvga =3D VIRTIO_VGA_BASE(dev);
+    VirtIOGPUBase *g =3D vvga->vgpu;
=20
     g->enable =3D 0;
=20
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
     PCIDeviceClass *pcidev_k =3D PCI_DEVICE_CLASS(klass);
=20
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
-    dc->props =3D virtio_vga_properties;
-    dc->reset =3D virtio_vga_reset;
-    dc->vmsd =3D &vmstate_virtio_vga;
+    dc->props =3D virtio_vga_base_properties;
+    dc->reset =3D virtio_vga_base_reset;
+    dc->vmsd =3D &vmstate_virtio_vga_base;
     dc->hotpluggable =3D false;
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
 static TypeInfo virtio_vga_info =3D {
     .name          =3D TYPE_VIRTIO_VGA,
-    .parent        =3D TYPE_VIRTIO_PCI,
+    .parent        =3D TYPE_VIRTIO_VGA_BASE,
     .instance_size =3D sizeof(struct VirtIOVGA),
     .instance_init =3D virtio_vga_inst_initfn,
-    .class_init    =3D virtio_vga_class_init,
 };
=20
 static void virtio_vga_register_types(void)
 {
+    type_register_static(&virtio_vga_base_info);
     type_register_static(&virtio_vga_info);
 }
=20
diff --git a/MAINTAINERS b/MAINTAINERS
index d340928bcd..7b6a18edd4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1368,7 +1368,7 @@ virtio-gpu
 M: Gerd Hoffmann <kraxel@redhat.com>
 S: Maintained
 F: hw/display/virtio-gpu*
-F: hw/display/virtio-vga.c
+F: hw/display/virtio-vga.*
 F: include/hw/virtio/virtio-gpu.h
=20
 vhost-user-gpu
--=20
2.18.0.129.ge3331758f1
