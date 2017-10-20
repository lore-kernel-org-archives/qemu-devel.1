Received: from eggs.gnu.org ([2001:4830:134:3::10]:59340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5VuG-0003NA-Qx
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:56:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5VuF-0003q9-Lc
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:56:04 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 20 Oct 2017 13:54:04 +0200
Message-Id: <20171020115418.2050-33-cohuck@redhat.com>
In-Reply-To: <20171020115418.2050-1-cohuck@redhat.com>
References: <20171020115418.2050-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 32/46] virtio-ccw: Add the virtio-input devices
 for CCW bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Farhan Ali <alifm@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Farhan Ali <alifm@linux.vnet.ibm.com>

Wire up the virtio-input HID devices (keyboard, mouse, tablet)
for the CCW bus. The virtio-input is a virtio-1 device,
so disable legacy revision 0.

Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <6a8ea4c503ee32c2ca7fa608b5f2f547009be8ee.1507557166.git.alifm@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/virtio-ccw.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/virtio-ccw.h |  22 +++++++++++
 2 files changed, 122 insertions(+)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 085f17f871..184515ce94 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -953,6 +953,15 @@ static void virtio_ccw_gpu_realize(VirtioCcwDevice *ccw_dev, Error **errp)
     object_property_set_bool(OBJECT(vdev), true, "realized", errp);
 }
 
+static void virtio_ccw_input_realize(VirtioCcwDevice *ccw_dev, Error **errp)
+{
+    VirtIOInputCcw *dev = VIRTIO_INPUT_CCW(ccw_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+
+    qdev_set_parent_bus(vdev, BUS(&ccw_dev->bus));
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+}
+
 /* DeviceState to VirtioCcwDevice. Note: used on datapath,
  * be careful and test performance if you change this.
  */
@@ -1601,6 +1610,92 @@ static const TypeInfo virtio_ccw_gpu = {
     .class_init    = virtio_ccw_gpu_class_init,
 };
 
+static Property virtio_ccw_input_properties[] = {
+    DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
+                    VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
+    DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
+                       VIRTIO_CCW_MAX_REV),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_ccw_input_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
+
+    k->realize = virtio_ccw_input_realize;
+    k->exit = virtio_ccw_exit;
+    dc->reset = virtio_ccw_reset;
+    dc->props = virtio_ccw_input_properties;
+    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
+}
+
+static void virtio_ccw_keyboard_instance_init(Object *obj)
+{
+    VirtIOInputHIDCcw *dev = VIRTIO_INPUT_HID_CCW(obj);
+    VirtioCcwDevice *ccw_dev = VIRTIO_CCW_DEVICE(obj);
+
+    ccw_dev->force_revision_1 = true;
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_KEYBOARD);
+}
+
+static void virtio_ccw_mouse_instance_init(Object *obj)
+{
+    VirtIOInputHIDCcw *dev = VIRTIO_INPUT_HID_CCW(obj);
+    VirtioCcwDevice *ccw_dev = VIRTIO_CCW_DEVICE(obj);
+
+    ccw_dev->force_revision_1 = true;
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_MOUSE);
+}
+
+static void virtio_ccw_tablet_instance_init(Object *obj)
+{
+    VirtIOInputHIDCcw *dev = VIRTIO_INPUT_HID_CCW(obj);
+    VirtioCcwDevice *ccw_dev = VIRTIO_CCW_DEVICE(obj);
+
+    ccw_dev->force_revision_1 = true;
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_TABLET);
+}
+
+static const TypeInfo virtio_ccw_input = {
+    .name          = TYPE_VIRTIO_INPUT_CCW,
+    .parent        = TYPE_VIRTIO_CCW_DEVICE,
+    .instance_size = sizeof(VirtIOInputCcw),
+    .class_init    = virtio_ccw_input_class_init,
+    .abstract = true,
+};
+
+static const TypeInfo virtio_ccw_input_hid = {
+    .name          = TYPE_VIRTIO_INPUT_HID_CCW,
+    .parent        = TYPE_VIRTIO_INPUT_CCW,
+    .instance_size = sizeof(VirtIOInputHIDCcw),
+    .abstract = true,
+};
+
+static const TypeInfo virtio_ccw_keyboard = {
+    .name          = TYPE_VIRTIO_KEYBOARD_CCW,
+    .parent        = TYPE_VIRTIO_INPUT_HID_CCW,
+    .instance_size = sizeof(VirtIOInputHIDCcw),
+    .instance_init = virtio_ccw_keyboard_instance_init,
+};
+
+static const TypeInfo virtio_ccw_mouse = {
+    .name          = TYPE_VIRTIO_MOUSE_CCW,
+    .parent        = TYPE_VIRTIO_INPUT_HID_CCW,
+    .instance_size = sizeof(VirtIOInputHIDCcw),
+    .instance_init = virtio_ccw_mouse_instance_init,
+};
+
+static const TypeInfo virtio_ccw_tablet = {
+    .name          = TYPE_VIRTIO_TABLET_CCW,
+    .parent        = TYPE_VIRTIO_INPUT_HID_CCW,
+    .instance_size = sizeof(VirtIOInputHIDCcw),
+    .instance_init = virtio_ccw_tablet_instance_init,
+};
+
 static void virtio_ccw_busdev_realize(DeviceState *dev, Error **errp)
 {
     VirtioCcwDevice *_dev = (VirtioCcwDevice *)dev;
@@ -1801,6 +1896,11 @@ static void virtio_ccw_register(void)
 #endif
     type_register_static(&virtio_ccw_crypto);
     type_register_static(&virtio_ccw_gpu);
+    type_register_static(&virtio_ccw_input);
+    type_register_static(&virtio_ccw_input_hid);
+    type_register_static(&virtio_ccw_keyboard);
+    type_register_static(&virtio_ccw_mouse);
+    type_register_static(&virtio_ccw_tablet);
 }
 
 type_init(virtio_ccw_register)
diff --git a/hw/s390x/virtio-ccw.h b/hw/s390x/virtio-ccw.h
index 541fdd2994..3905f3a3d6 100644
--- a/hw/s390x/virtio-ccw.h
+++ b/hw/s390x/virtio-ccw.h
@@ -28,6 +28,7 @@
 #include "hw/virtio/vhost-vsock.h"
 #endif /* CONFIG_VHOST_VSOCK */
 #include "hw/virtio/virtio-gpu.h"
+#include "hw/virtio/virtio-input.h"
 
 #include "hw/s390x/s390_flic.h"
 #include "hw/s390x/css.h"
@@ -233,4 +234,25 @@ typedef struct VirtIOGPUCcw {
     VirtIOGPU vdev;
 } VirtIOGPUCcw;
 
+#define TYPE_VIRTIO_INPUT_CCW "virtio-input-ccw"
+#define VIRTIO_INPUT_CCW(obj) \
+        OBJECT_CHECK(VirtIOInputCcw, (obj), TYPE_VIRTIO_INPUT_CCW)
+
+typedef struct VirtIOInputCcw {
+    VirtioCcwDevice parent_obj;
+    VirtIOInput vdev;
+} VirtIOInputCcw;
+
+#define TYPE_VIRTIO_INPUT_HID_CCW "virtio-input-hid-ccw"
+#define TYPE_VIRTIO_KEYBOARD_CCW "virtio-keyboard-ccw"
+#define TYPE_VIRTIO_MOUSE_CCW "virtio-mouse-ccw"
+#define TYPE_VIRTIO_TABLET_CCW "virtio-tablet-ccw"
+#define VIRTIO_INPUT_HID_CCW(obj) \
+        OBJECT_CHECK(VirtIOInputHIDCcw, (obj), TYPE_VIRTIO_INPUT_HID_CCW)
+
+typedef struct VirtIOInputHIDCcw {
+    VirtioCcwDevice parent_obj;
+    VirtIOInputHID vdev;
+} VirtIOInputHIDCcw;
+
 #endif
-- 
2.13.6
