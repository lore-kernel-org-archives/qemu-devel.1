Received: from eggs.gnu.org ([209.51.188.92]:35531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUyo-00081v-DT
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUyR-0003Qz-3u
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjUyP-0002vc-He
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:10 -0500
Date: Tue, 15 Jan 2019 15:05:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190115200252.25911-24-mst@redhat.com>
References: <20190115200252.25911-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115200252.25911-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 23/49] virtio: split virtio 9p bits from
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Juan Quintela <quintela@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Greg Kurz <groug@kaod.org>

From: Juan Quintela <quintela@redhat.com>

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Acked-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-pci.h    | 20 ---------
 hw/virtio/virtio-9p-pci.c | 88 +++++++++++++++++++++++++++++++++++++++
 hw/virtio/virtio-pci.c    | 54 ------------------------
 hw/virtio/Makefile.objs   |  1 +
 tests/Makefile.include    |  2 +-
 5 files changed, 90 insertions(+), 75 deletions(-)
 create mode 100644 hw/virtio/virtio-9p-pci.c

diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index a2988ef309..94af08410a 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -28,9 +28,6 @@
 #include "hw/virtio/vhost-user-blk.h"
 #endif
 
-#ifdef CONFIG_VIRTFS
-#include "hw/9pfs/virtio-9p.h"
-#endif
 #ifdef CONFIG_VHOST_SCSI
 #include "hw/virtio/vhost-scsi.h"
 #endif
@@ -286,23 +283,6 @@ struct VirtIONetPCI {
     VirtIONet vdev;
 };
 
-/*
- * virtio-9p-pci: This extends VirtioPCIProxy.
- */
-
-#ifdef CONFIG_VIRTFS
-
-#define TYPE_VIRTIO_9P_PCI "virtio-9p-pci-base"
-#define VIRTIO_9P_PCI(obj) \
-        OBJECT_CHECK(V9fsPCIState, (obj), TYPE_VIRTIO_9P_PCI)
-
-typedef struct V9fsPCIState {
-    VirtIOPCIProxy parent_obj;
-    V9fsVirtioState vdev;
-} V9fsPCIState;
-
-#endif
-
 /*
  * virtio-input-pci: This extends VirtioPCIProxy.
  */
diff --git a/hw/virtio/virtio-9p-pci.c b/hw/virtio/virtio-9p-pci.c
new file mode 100644
index 0000000000..7bf1130966
--- /dev/null
+++ b/hw/virtio/virtio-9p-pci.c
@@ -0,0 +1,88 @@
+/*
+ * Virtio 9p PCI Bindings
+ *
+ * Copyright IBM, Corp. 2010
+ *
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ * Contributions after 2012-01-13 are licensed under the terms of the
+ * GNU GPL, version 2 or (at your option) any later version.
+ */
+
+#include "qemu/osdep.h"
+
+#include "virtio-pci.h"
+#include "hw/9pfs/virtio-9p.h"
+
+/*
+ * virtio-9p-pci: This extends VirtioPCIProxy.
+ */
+
+#define TYPE_VIRTIO_9P_PCI "virtio-9p-pci-base"
+#define VIRTIO_9P_PCI(obj) \
+        OBJECT_CHECK(V9fsPCIState, (obj), TYPE_VIRTIO_9P_PCI)
+
+typedef struct V9fsPCIState {
+    VirtIOPCIProxy parent_obj;
+    V9fsVirtioState vdev;
+} V9fsPCIState;
+
+static void virtio_9p_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    V9fsPCIState *dev = VIRTIO_9P_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+
+    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+}
+
+static Property virtio_9p_pci_properties[] = {
+    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
+                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 2),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_9p_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+
+    k->realize = virtio_9p_pci_realize;
+    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_9P;
+    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
+    pcidev_k->class_id = 0x2;
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    dc->props = virtio_9p_pci_properties;
+}
+
+static void virtio_9p_pci_instance_init(Object *obj)
+{
+    V9fsPCIState *dev = VIRTIO_9P_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_9P);
+}
+
+static const VirtioPCIDeviceTypeInfo virtio_9p_pci_info = {
+    .base_name              = TYPE_VIRTIO_9P_PCI,
+    .generic_name           = "virtio-9p-pci",
+    .transitional_name      = "virtio-9p-pci-transitional",
+    .non_transitional_name  = "virtio-9p-pci-non-transitional",
+    .instance_size = sizeof(V9fsPCIState),
+    .instance_init = virtio_9p_pci_instance_init,
+    .class_init    = virtio_9p_pci_class_init,
+};
+
+static void virtio_9p_pci_register(void)
+{
+    virtio_pci_types_register(&virtio_9p_pci_info);
+}
+
+type_init(virtio_9p_pci_register)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index a01c9dd46f..a62006c72c 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1077,57 +1077,6 @@ static void virtio_pci_vmstate_change(DeviceState *d, bool running)
     }
 }
 
-#ifdef CONFIG_VIRTFS
-static void virtio_9p_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
-{
-    V9fsPCIState *dev = VIRTIO_9P_PCI(vpci_dev);
-    DeviceState *vdev = DEVICE(&dev->vdev);
-
-    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
-    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
-}
-
-static Property virtio_9p_pci_properties[] = {
-    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
-                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
-    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 2),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void virtio_9p_pci_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
-    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
-
-    k->realize = virtio_9p_pci_realize;
-    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
-    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_9P;
-    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
-    pcidev_k->class_id = 0x2;
-    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
-    dc->props = virtio_9p_pci_properties;
-}
-
-static void virtio_9p_pci_instance_init(Object *obj)
-{
-    V9fsPCIState *dev = VIRTIO_9P_PCI(obj);
-
-    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
-                                TYPE_VIRTIO_9P);
-}
-
-static const VirtioPCIDeviceTypeInfo virtio_9p_pci_info = {
-    .base_name              = TYPE_VIRTIO_9P_PCI,
-    .generic_name           = "virtio-9p-pci",
-    .transitional_name      = "virtio-9p-pci-transitional",
-    .non_transitional_name  = "virtio-9p-pci-non-transitional",
-    .instance_size = sizeof(V9fsPCIState),
-    .instance_init = virtio_9p_pci_instance_init,
-    .class_init    = virtio_9p_pci_class_init,
-};
-#endif /* CONFIG_VIRTFS */
-
 /*
  * virtio-pci: This is the PCIDevice which has a virtio-pci-bus.
  */
@@ -2539,9 +2488,6 @@ static void virtio_pci_register_types(void)
     type_register_static(&virtio_pci_info);
 
     /* Implementations: */
-#ifdef CONFIG_VIRTFS
-    virtio_pci_types_register(&virtio_9p_pci_info);
-#endif
     virtio_pci_types_register(&virtio_blk_pci_info);
 #if defined(CONFIG_VHOST_USER) && defined(CONFIG_LINUX)
     virtio_pci_types_register(&vhost_user_blk_pci_info);
diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index 9e33104ce6..3e655fdce6 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -17,6 +17,7 @@ obj-$(CONFIG_VIRTIO_INPUT_HOST) += virtio-input-host-pci.o
 obj-$(CONFIG_VIRTIO_INPUT) += virtio-input-pci.o
 obj-$(CONFIG_VIRTIO_RNG) += virtio-rng-pci.o
 obj-$(CONFIG_VIRTIO_BALLOON) += virtio-balloon-pci.o
+obj-$(CONFIG_VIRTIO_9P) += virtio-9p-pci.o
 endif
 endif
 
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 0d76ec6a74..c2845b67aa 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -152,7 +152,7 @@ check-qtest-virtio-y += tests/virtio-blk-test$(EXESUF)
 check-qtest-virtio-$(CONFIG_VIRTIO_RNG) += tests/virtio-rng-test$(EXESUF)
 check-qtest-virtio-y += tests/virtio-scsi-test$(EXESUF)
 ifeq ($(CONFIG_VIRTIO)$(CONFIG_VIRTFS)$(CONFIG_PCI),yyy)
-check-qtest-virtio-y += tests/virtio-9p-test$(EXESUF)
+check-qtest-virtio-$(CONFIG_VIRTIO_9P) += tests/virtio-9p-test$(EXESUF)
 endif
 check-qtest-virtio-y += tests/virtio-serial-test$(EXESUF)
 check-qtest-virtio-y += $(check-qtest-virtioserial-y)
-- 
MST
