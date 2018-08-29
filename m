Received: from eggs.gnu.org ([2001:4830:134:3::10]:42829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fuyqx-0001cf-Dk
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:41:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fuynF-0007M2-Cv
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:37:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35892 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fuynF-0007Lt-71
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:37:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DF7ED40216F9
	for <qemu-devel@nongnu.org>; Wed, 29 Aug 2018 11:37:48 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 29 Aug 2018 13:37:17 +0200
Message-Id: <20180829113730.14992-4-quintela@redhat.com>
In-Reply-To: <20180829113730.14992-1-quintela@redhat.com>
References: <20180829113730.14992-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 03/16] virtio: split virtio input bits from
 virtio-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, mst@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/virtio/Makefile.objs      |   1 +
 hw/virtio/virtio-input-pci.c | 154 +++++++++++++++++++++++++++++++++++
 hw/virtio/virtio-pci.c       | 113 -------------------------
 hw/virtio/virtio-pci.h       |  22 -----
 4 files changed, 155 insertions(+), 135 deletions(-)
 create mode 100644 hw/virtio/virtio-input-pci.c

diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index 685ae1d866..6819ed4e14 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -12,6 +12,7 @@ obj-$(call land,$(CONFIG_VIRTIO_CRYPTO),$(CONFIG_VIRTIO_PCI)) += virtio-crypto-p
 obj-$(CONFIG_LINUX) += vhost.o vhost-backend.o vhost-user.o
 obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock.o vhost-vsock-pci.o
 obj-$(CONFIG_VIRTIO_INPUT_HOST) += virtio-input-host-pci.o
+obj-$(CONFIG_VIRTIO_INPUT) += virtio-input-pci.o
 endif
 
 common-obj-$(call lnot,$(call land,$(CONFIG_VIRTIO),$(CONFIG_LINUX))) += vhost-stub.o
diff --git a/hw/virtio/virtio-input-pci.c b/hw/virtio/virtio-input-pci.c
new file mode 100644
index 0000000000..12fc46043e
--- /dev/null
+++ b/hw/virtio/virtio-input-pci.c
@@ -0,0 +1,154 @@
+/*
+ * Virtio input PCI Bindings
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#include "qemu/osdep.h"
+
+#include "virtio-pci.h"
+#include "hw/virtio/virtio-input.h"
+
+typedef struct VirtIOInputPCI VirtIOInputPCI;
+typedef struct VirtIOInputHIDPCI VirtIOInputHIDPCI;
+
+/*
+ * virtio-input-pci: This extends VirtioPCIProxy.
+ */
+#define VIRTIO_INPUT_PCI(obj) \
+        OBJECT_CHECK(VirtIOInputPCI, (obj), TYPE_VIRTIO_INPUT_PCI)
+
+struct VirtIOInputPCI {
+    VirtIOPCIProxy parent_obj;
+    VirtIOInput vdev;
+};
+
+#define TYPE_VIRTIO_INPUT_HID_PCI "virtio-input-hid-pci"
+#define TYPE_VIRTIO_KEYBOARD_PCI  "virtio-keyboard-pci"
+#define TYPE_VIRTIO_MOUSE_PCI     "virtio-mouse-pci"
+#define TYPE_VIRTIO_TABLET_PCI    "virtio-tablet-pci"
+#define VIRTIO_INPUT_HID_PCI(obj) \
+        OBJECT_CHECK(VirtIOInputHIDPCI, (obj), TYPE_VIRTIO_INPUT_HID_PCI)
+
+struct VirtIOInputHIDPCI {
+    VirtIOPCIProxy parent_obj;
+    VirtIOInputHID vdev;
+};
+
+static Property virtio_input_pci_properties[] = {
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 2),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_input_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VirtIOInputPCI *vinput = VIRTIO_INPUT_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&vinput->vdev);
+
+    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
+    virtio_pci_force_virtio_1(vpci_dev);
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+}
+
+static void virtio_input_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+
+    dc->props = virtio_input_pci_properties;
+    k->realize = virtio_input_pci_realize;
+    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
+
+    pcidev_k->class_id = PCI_CLASS_INPUT_OTHER;
+}
+
+static void virtio_input_hid_kbd_pci_class_init(ObjectClass *klass, void *data)
+{
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+
+    pcidev_k->class_id = PCI_CLASS_INPUT_KEYBOARD;
+}
+
+static void virtio_input_hid_mouse_pci_class_init(ObjectClass *klass,
+                                                  void *data)
+{
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+
+    pcidev_k->class_id = PCI_CLASS_INPUT_MOUSE;
+}
+
+static void virtio_keyboard_initfn(Object *obj)
+{
+    VirtIOInputHIDPCI *dev = VIRTIO_INPUT_HID_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_KEYBOARD);
+}
+
+static void virtio_mouse_initfn(Object *obj)
+{
+    VirtIOInputHIDPCI *dev = VIRTIO_INPUT_HID_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_MOUSE);
+}
+
+static void virtio_tablet_initfn(Object *obj)
+{
+    VirtIOInputHIDPCI *dev = VIRTIO_INPUT_HID_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_TABLET);
+}
+
+static const TypeInfo virtio_input_pci_info = {
+    .name          = TYPE_VIRTIO_INPUT_PCI,
+    .parent        = TYPE_VIRTIO_PCI,
+    .instance_size = sizeof(VirtIOInputPCI),
+    .class_init    = virtio_input_pci_class_init,
+    .abstract      = true,
+};
+
+static const TypeInfo virtio_input_hid_pci_info = {
+    .name          = TYPE_VIRTIO_INPUT_HID_PCI,
+    .parent        = TYPE_VIRTIO_INPUT_PCI,
+    .instance_size = sizeof(VirtIOInputHIDPCI),
+    .abstract      = true,
+};
+
+static const TypeInfo virtio_keyboard_pci_info = {
+    .name          = TYPE_VIRTIO_KEYBOARD_PCI,
+    .parent        = TYPE_VIRTIO_INPUT_HID_PCI,
+    .class_init    = virtio_input_hid_kbd_pci_class_init,
+    .instance_size = sizeof(VirtIOInputHIDPCI),
+    .instance_init = virtio_keyboard_initfn,
+};
+
+static const TypeInfo virtio_mouse_pci_info = {
+    .name          = TYPE_VIRTIO_MOUSE_PCI,
+    .parent        = TYPE_VIRTIO_INPUT_HID_PCI,
+    .class_init    = virtio_input_hid_mouse_pci_class_init,
+    .instance_size = sizeof(VirtIOInputHIDPCI),
+    .instance_init = virtio_mouse_initfn,
+};
+
+static const TypeInfo virtio_tablet_pci_info = {
+    .name          = TYPE_VIRTIO_TABLET_PCI,
+    .parent        = TYPE_VIRTIO_INPUT_HID_PCI,
+    .instance_size = sizeof(VirtIOInputHIDPCI),
+    .instance_init = virtio_tablet_initfn,
+};
+
+static void virtio_pci_input_register(void)
+{
+    type_register_static(&virtio_input_pci_info);
+    type_register_static(&virtio_input_hid_pci_info);
+    type_register_static(&virtio_keyboard_pci_info);
+    type_register_static(&virtio_mouse_pci_info);
+    type_register_static(&virtio_tablet_pci_info);
+}
+
+type_init(virtio_pci_input_register)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 3ecd5954b2..7c19a6f1a5 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -24,7 +24,6 @@
 #include "hw/virtio/virtio-serial.h"
 #include "hw/virtio/virtio-scsi.h"
 #include "hw/virtio/virtio-balloon.h"
-#include "hw/virtio/virtio-input.h"
 #include "hw/pci/pci.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
@@ -2473,113 +2472,6 @@ static const TypeInfo virtio_rng_pci_info = {
     .class_init    = virtio_rng_pci_class_init,
 };
 
-/* virtio-input-pci */
-
-static Property virtio_input_pci_properties[] = {
-    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 2),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void virtio_input_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
-{
-    VirtIOInputPCI *vinput = VIRTIO_INPUT_PCI(vpci_dev);
-    DeviceState *vdev = DEVICE(&vinput->vdev);
-
-    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
-    virtio_pci_force_virtio_1(vpci_dev);
-    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
-}
-
-static void virtio_input_pci_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
-    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
-
-    dc->props = virtio_input_pci_properties;
-    k->realize = virtio_input_pci_realize;
-    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
-
-    pcidev_k->class_id = PCI_CLASS_INPUT_OTHER;
-}
-
-static void virtio_input_hid_kbd_pci_class_init(ObjectClass *klass, void *data)
-{
-    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
-
-    pcidev_k->class_id = PCI_CLASS_INPUT_KEYBOARD;
-}
-
-static void virtio_input_hid_mouse_pci_class_init(ObjectClass *klass,
-                                                  void *data)
-{
-    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
-
-    pcidev_k->class_id = PCI_CLASS_INPUT_MOUSE;
-}
-
-static void virtio_keyboard_initfn(Object *obj)
-{
-    VirtIOInputHIDPCI *dev = VIRTIO_INPUT_HID_PCI(obj);
-
-    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
-                                TYPE_VIRTIO_KEYBOARD);
-}
-
-static void virtio_mouse_initfn(Object *obj)
-{
-    VirtIOInputHIDPCI *dev = VIRTIO_INPUT_HID_PCI(obj);
-
-    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
-                                TYPE_VIRTIO_MOUSE);
-}
-
-static void virtio_tablet_initfn(Object *obj)
-{
-    VirtIOInputHIDPCI *dev = VIRTIO_INPUT_HID_PCI(obj);
-
-    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
-                                TYPE_VIRTIO_TABLET);
-}
-
-static const TypeInfo virtio_input_pci_info = {
-    .name          = TYPE_VIRTIO_INPUT_PCI,
-    .parent        = TYPE_VIRTIO_PCI,
-    .instance_size = sizeof(VirtIOInputPCI),
-    .class_init    = virtio_input_pci_class_init,
-    .abstract      = true,
-};
-
-static const TypeInfo virtio_input_hid_pci_info = {
-    .name          = TYPE_VIRTIO_INPUT_HID_PCI,
-    .parent        = TYPE_VIRTIO_INPUT_PCI,
-    .instance_size = sizeof(VirtIOInputHIDPCI),
-    .abstract      = true,
-};
-
-static const TypeInfo virtio_keyboard_pci_info = {
-    .name          = TYPE_VIRTIO_KEYBOARD_PCI,
-    .parent        = TYPE_VIRTIO_INPUT_HID_PCI,
-    .class_init    = virtio_input_hid_kbd_pci_class_init,
-    .instance_size = sizeof(VirtIOInputHIDPCI),
-    .instance_init = virtio_keyboard_initfn,
-};
-
-static const TypeInfo virtio_mouse_pci_info = {
-    .name          = TYPE_VIRTIO_MOUSE_PCI,
-    .parent        = TYPE_VIRTIO_INPUT_HID_PCI,
-    .class_init    = virtio_input_hid_mouse_pci_class_init,
-    .instance_size = sizeof(VirtIOInputHIDPCI),
-    .instance_init = virtio_mouse_initfn,
-};
-
-static const TypeInfo virtio_tablet_pci_info = {
-    .name          = TYPE_VIRTIO_TABLET_PCI,
-    .parent        = TYPE_VIRTIO_INPUT_HID_PCI,
-    .instance_size = sizeof(VirtIOInputHIDPCI),
-    .instance_init = virtio_tablet_initfn,
-};
-
 /* virtio-pci-bus */
 
 static void virtio_pci_bus_new(VirtioBusState *bus, size_t bus_size,
@@ -2628,11 +2520,6 @@ static const TypeInfo virtio_pci_bus_info = {
 static void virtio_pci_register_types(void)
 {
     type_register_static(&virtio_rng_pci_info);
-    type_register_static(&virtio_input_pci_info);
-    type_register_static(&virtio_input_hid_pci_info);
-    type_register_static(&virtio_keyboard_pci_info);
-    type_register_static(&virtio_mouse_pci_info);
-    type_register_static(&virtio_tablet_pci_info);
     type_register_static(&virtio_pci_bus_info);
     type_register_static(&virtio_pci_info);
 #ifdef CONFIG_VIRTFS
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index cf4cbecfab..32d5f0fbff 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -23,7 +23,6 @@
 #include "hw/virtio/virtio-scsi.h"
 #include "hw/virtio/virtio-balloon.h"
 #include "hw/virtio/virtio-bus.h"
-#include "hw/virtio/virtio-input.h"
 #include "hw/virtio/virtio-gpu.h"
 #include "hw/virtio/virtio-crypto.h"
 #include "hw/virtio/vhost-user-scsi.h"
@@ -48,8 +47,6 @@ typedef struct VHostSCSIPCI VHostSCSIPCI;
 typedef struct VHostUserSCSIPCI VHostUserSCSIPCI;
 typedef struct VHostUserBlkPCI VHostUserBlkPCI;
 typedef struct VirtIORngPCI VirtIORngPCI;
-typedef struct VirtIOInputPCI VirtIOInputPCI;
-typedef struct VirtIOInputHIDPCI VirtIOInputHIDPCI;
 typedef struct VirtIOGPUPCI VirtIOGPUPCI;
 typedef struct VirtIOCryptoPCI VirtIOCryptoPCI;
 
@@ -338,25 +335,6 @@ struct VirtIORngPCI {
  * virtio-input-pci: This extends VirtioPCIProxy.
  */
 #define TYPE_VIRTIO_INPUT_PCI "virtio-input-pci"
-#define VIRTIO_INPUT_PCI(obj) \
-        OBJECT_CHECK(VirtIOInputPCI, (obj), TYPE_VIRTIO_INPUT_PCI)
-
-struct VirtIOInputPCI {
-    VirtIOPCIProxy parent_obj;
-    VirtIOInput vdev;
-};
-
-#define TYPE_VIRTIO_INPUT_HID_PCI "virtio-input-hid-pci"
-#define TYPE_VIRTIO_KEYBOARD_PCI  "virtio-keyboard-pci"
-#define TYPE_VIRTIO_MOUSE_PCI     "virtio-mouse-pci"
-#define TYPE_VIRTIO_TABLET_PCI    "virtio-tablet-pci"
-#define VIRTIO_INPUT_HID_PCI(obj) \
-        OBJECT_CHECK(VirtIOInputHIDPCI, (obj), TYPE_VIRTIO_INPUT_HID_PCI)
-
-struct VirtIOInputHIDPCI {
-    VirtIOPCIProxy parent_obj;
-    VirtIOInputHID vdev;
-};
 
 /*
  * virtio-gpu-pci: This extends VirtioPCIProxy.
-- 
2.17.1
