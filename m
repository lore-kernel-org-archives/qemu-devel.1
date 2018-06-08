Received: from eggs.gnu.org ([2001:4830:134:3::10]:58110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fRFRL-00086M-7s
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 07:20:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fRFRK-0001na-1B
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 07:20:19 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  8 Jun 2018 13:19:58 +0200
Message-Id: <20180608112001.14729-4-kraxel@redhat.com>
In-Reply-To: <20180608112001.14729-1-kraxel@redhat.com>
References: <20180608112001.14729-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v3 3/6] hw/display: add virtio-ramfb device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?L=C3=A1szl=C3=B3=20=C3=89rsek?= <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Like virtio-vga, but using ramfb instead of legacy vga.

Note: Not clear yet whenever this will be ever merged upstream.
      No clear benefit, given that edk2 has a virtio-gpu driver
      which doesn't depend on the vga compatibility mode.

      Will keeping it in the devel branch for now, for testing
      purposes and as playground.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/virtio-ramfb.c | 149 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/display/Makefile.objs  |   2 +-
 2 files changed, 150 insertions(+), 1 deletion(-)
 create mode 100644 hw/display/virtio-ramfb.c

diff --git a/hw/display/virtio-ramfb.c b/hw/display/virtio-ramfb.c
new file mode 100644
index 0000000000..e8ffe66047
--- /dev/null
+++ b/hw/display/virtio-ramfb.c
@@ -0,0 +1,149 @@
+#include "qemu/osdep.h"
+#include "hw/hw.h"
+#include "hw/pci/pci.h"
+#include "ui/console.h"
+#include "hw/virtio/virtio-pci.h"
+#include "hw/display/ramfb.h"
+#include "qapi/error.h"
+
+/*
+ * virtio-ramfb: This extends VirtioPCIProxy.
+ */
+#define TYPE_VIRTIO_RAMFB "virtio-ramfb"
+#define VIRTIO_RAMFB(obj) \
+        OBJECT_CHECK(VirtIORAMFB, (obj), TYPE_VIRTIO_RAMFB)
+
+typedef struct VirtIORAMFB {
+    VirtIOPCIProxy parent_obj;
+    VirtIOGPU      vdev;
+    RAMFBState     *ramfb;
+} VirtIORAMFB;
+
+static void virtio_ramfb_invalidate_display(void *opaque)
+{
+    VirtIORAMFB *vramfb = opaque;
+
+    if (vramfb->vdev.enable) {
+        virtio_gpu_ops.invalidate(&vramfb->vdev);
+    }
+}
+
+static void virtio_ramfb_update_display(void *opaque)
+{
+    VirtIORAMFB *vramfb = opaque;
+    VirtIOGPU *g = &vramfb->vdev;
+
+    if (vramfb->vdev.enable) {
+        virtio_gpu_ops.gfx_update(&vramfb->vdev);
+    } else {
+        ramfb_display_update(g->scanout[0].con, vramfb->ramfb);
+    }
+}
+
+static int virtio_ramfb_ui_info(void *opaque, uint32_t idx, QemuUIInfo *info)
+{
+    VirtIORAMFB *vramfb = opaque;
+
+    if (virtio_gpu_ops.ui_info) {
+        return virtio_gpu_ops.ui_info(&vramfb->vdev, idx, info);
+    }
+    return -1;
+}
+
+static void virtio_ramfb_gl_block(void *opaque, bool block)
+{
+    VirtIORAMFB *vramfb = opaque;
+
+    if (virtio_gpu_ops.gl_block) {
+        virtio_gpu_ops.gl_block(&vramfb->vdev, block);
+    }
+}
+
+static const GraphicHwOps virtio_ramfb_ops = {
+    .invalidate = virtio_ramfb_invalidate_display,
+    .gfx_update = virtio_ramfb_update_display,
+    .ui_info = virtio_ramfb_ui_info,
+    .gl_block = virtio_ramfb_gl_block,
+};
+
+static const VMStateDescription vmstate_virtio_ramfb = {
+    .name = "virtio-ramfb",
+    .version_id = 2,
+    .minimum_version_id = 2,
+    .fields = (VMStateField[]) {
+        /* no pci stuff here, saving the virtio device will handle that */
+        /* FIXME */
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+/* RAMFB device wrapper around PCI device around virtio GPU */
+static void virtio_ramfb_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VirtIORAMFB *vramfb = VIRTIO_RAMFB(vpci_dev);
+    VirtIOGPU *g = &vramfb->vdev;
+    Error *err = NULL;
+    int i;
+
+    /* init virtio bits */
+    qdev_set_parent_bus(DEVICE(g), BUS(&vpci_dev->bus));
+    virtio_pci_force_virtio_1(vpci_dev);
+    object_property_set_bool(OBJECT(g), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    /* init ramfb */
+    vramfb->ramfb = ramfb_setup(errp);
+    graphic_console_set_hwops(g->scanout[0].con, &virtio_ramfb_ops, vramfb);
+
+    for (i = 0; i < g->conf.max_outputs; i++) {
+        object_property_set_link(OBJECT(g->scanout[i].con),
+                                 OBJECT(vpci_dev),
+                                 "device", errp);
+    }
+}
+
+static Property virtio_ramfb_properties[] = {
+    DEFINE_VIRTIO_GPU_PCI_PROPERTIES(VirtIOPCIProxy),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_ramfb_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+
+    set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
+    dc->props = virtio_ramfb_properties;
+    dc->vmsd = &vmstate_virtio_ramfb;
+    dc->hotpluggable = false;
+
+    k->realize = virtio_ramfb_realize;
+    pcidev_k->class_id = PCI_CLASS_DISPLAY_OTHER;
+}
+
+static void virtio_ramfb_inst_initfn(Object *obj)
+{
+    VirtIORAMFB *dev = VIRTIO_RAMFB(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_GPU);
+}
+
+static TypeInfo virtio_ramfb_info = {
+    .name          = TYPE_VIRTIO_RAMFB,
+    .parent        = TYPE_VIRTIO_PCI,
+    .instance_size = sizeof(struct VirtIORAMFB),
+    .instance_init = virtio_ramfb_inst_initfn,
+    .class_init    = virtio_ramfb_class_init,
+};
+
+static void virtio_ramfb_register_types(void)
+{
+    type_register_static(&virtio_ramfb_info);
+}
+
+type_init(virtio_ramfb_register_types)
diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index fb8408c6d0..e70e71ac5c 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -40,7 +40,7 @@ obj-$(CONFIG_VGA) += vga.o
 common-obj-$(CONFIG_QXL) += qxl.o qxl-logger.o qxl-render.o
 
 obj-$(CONFIG_VIRTIO_GPU) += virtio-gpu.o virtio-gpu-3d.o
-obj-$(call land,$(CONFIG_VIRTIO_GPU),$(CONFIG_VIRTIO_PCI)) += virtio-gpu-pci.o
+obj-$(call land,$(CONFIG_VIRTIO_GPU),$(CONFIG_VIRTIO_PCI)) += virtio-gpu-pci.o virtio-ramfb.o
 obj-$(CONFIG_VIRTIO_VGA) += virtio-vga.o
 virtio-gpu.o-cflags := $(VIRGL_CFLAGS)
 virtio-gpu.o-libs += $(VIRGL_LIBS)
-- 
2.9.3
