Received: from eggs.gnu.org ([2001:4830:134:3::10]:38520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@trasno.org>) id 1gXY6w-0001Ua-TL
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 16:01:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@trasno.org>) id 1gXY6t-0003wG-57
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 16:01:33 -0500
Received: from trasno.trasno.org ([83.165.45.250]:42132 helo=mail.trasno.org)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@trasno.org>) id 1gXY6r-0002zP-4k
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 16:01:29 -0500
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 13 Dec 2018 22:00:45 +0100
Message-Id: <20181213210057.3676-5-quintela@redhat.com>
In-Reply-To: <20181213210057.3676-1-quintela@redhat.com>
References: <20181213210057.3676-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 04/16] virtio: split virtio rng bits from
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Juan Quintela <quintela@redhat.com>

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>

---

Remove the "contributions after" clause.  This is based on

commit 59ccd20a9ac719cff82180429458728f03ec612f
Author: KONRAD Frederic <fred.konrad@greensocs.com>
Date:   Wed Apr 24 10:07:56 2013 +0200

Fix duplicated test entry (lvivier)
---
 hw/virtio/Makefile.objs    |  1 +
 hw/virtio/virtio-pci.c     | 52 -----------------------
 hw/virtio/virtio-pci.h     | 14 -------
 hw/virtio/virtio-rng-pci.c | 86 ++++++++++++++++++++++++++++++++++++++
 tests/Makefile.include     |  2 +-
 5 files changed, 88 insertions(+), 67 deletions(-)
 create mode 100644 hw/virtio/virtio-rng-pci.c

diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index c61bcd106b..032ba2ff0e 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -15,6 +15,7 @@ ifeq ($(CONFIG_PCI),y)
 obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock-pci.o
 obj-$(CONFIG_VIRTIO_INPUT_HOST) += virtio-input-host-pci.o
 obj-$(CONFIG_VIRTIO_INPUT) += virtio-input-pci.o
+obj-$(CONFIG_VIRTIO_RNG) += virtio-rng-pci.o
 endif
 endif
 
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index bb1d2db032..433ece611d 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2421,57 +2421,6 @@ static const TypeInfo virtio_net_pci_info = {
     .class_init    = virtio_net_pci_class_init,
 };
 
-/* virtio-rng-pci */
-
-static void virtio_rng_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
-{
-    VirtIORngPCI *vrng = VIRTIO_RNG_PCI(vpci_dev);
-    DeviceState *vdev = DEVICE(&vrng->vdev);
-    Error *err = NULL;
-
-    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
-    object_property_set_bool(OBJECT(vdev), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
-    }
-
-    object_property_set_link(OBJECT(vrng),
-                             OBJECT(vrng->vdev.conf.rng), "rng",
-                             NULL);
-}
-
-static void virtio_rng_pci_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
-    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
-
-    k->realize = virtio_rng_pci_realize;
-    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-
-    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
-    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_RNG;
-    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
-    pcidev_k->class_id = PCI_CLASS_OTHERS;
-}
-
-static void virtio_rng_initfn(Object *obj)
-{
-    VirtIORngPCI *dev = VIRTIO_RNG_PCI(obj);
-
-    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
-                                TYPE_VIRTIO_RNG);
-}
-
-static const TypeInfo virtio_rng_pci_info = {
-    .name          = TYPE_VIRTIO_RNG_PCI,
-    .parent        = TYPE_VIRTIO_PCI,
-    .instance_size = sizeof(VirtIORngPCI),
-    .instance_init = virtio_rng_initfn,
-    .class_init    = virtio_rng_pci_class_init,
-};
-
 /* virtio-pci-bus */
 
 static void virtio_pci_bus_new(VirtioBusState *bus, size_t bus_size,
@@ -2519,7 +2468,6 @@ static const TypeInfo virtio_pci_bus_info = {
 
 static void virtio_pci_register_types(void)
 {
-    type_register_static(&virtio_rng_pci_info);
     type_register_static(&virtio_pci_bus_info);
     type_register_static(&virtio_pci_info);
 #ifdef CONFIG_VIRTFS
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 32d5f0fbff..2415eb6a4d 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -18,7 +18,6 @@
 #include "hw/pci/msi.h"
 #include "hw/virtio/virtio-blk.h"
 #include "hw/virtio/virtio-net.h"
-#include "hw/virtio/virtio-rng.h"
 #include "hw/virtio/virtio-serial.h"
 #include "hw/virtio/virtio-scsi.h"
 #include "hw/virtio/virtio-balloon.h"
@@ -46,7 +45,6 @@ typedef struct VirtIONetPCI VirtIONetPCI;
 typedef struct VHostSCSIPCI VHostSCSIPCI;
 typedef struct VHostUserSCSIPCI VHostUserSCSIPCI;
 typedef struct VHostUserBlkPCI VHostUserBlkPCI;
-typedef struct VirtIORngPCI VirtIORngPCI;
 typedef struct VirtIOGPUPCI VirtIOGPUPCI;
 typedef struct VirtIOCryptoPCI VirtIOCryptoPCI;
 
@@ -319,18 +317,6 @@ typedef struct V9fsPCIState {
 
 #endif
 
-/*
- * virtio-rng-pci: This extends VirtioPCIProxy.
- */
-#define TYPE_VIRTIO_RNG_PCI "virtio-rng-pci"
-#define VIRTIO_RNG_PCI(obj) \
-        OBJECT_CHECK(VirtIORngPCI, (obj), TYPE_VIRTIO_RNG_PCI)
-
-struct VirtIORngPCI {
-    VirtIOPCIProxy parent_obj;
-    VirtIORNG vdev;
-};
-
 /*
  * virtio-input-pci: This extends VirtioPCIProxy.
  */
diff --git a/hw/virtio/virtio-rng-pci.c b/hw/virtio/virtio-rng-pci.c
new file mode 100644
index 0000000000..60688fbea9
--- /dev/null
+++ b/hw/virtio/virtio-rng-pci.c
@@ -0,0 +1,86 @@
+/*
+ * Virtio rng PCI Bindings
+ *
+ * Copyright 2012 Red Hat, Inc.
+ * Copyright 2012 Amit Shah <amit.shah@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#include "qemu/osdep.h"
+
+#include "virtio-pci.h"
+#include "hw/virtio/virtio-rng.h"
+#include "qapi/error.h"
+
+typedef struct VirtIORngPCI VirtIORngPCI;
+
+/*
+ * virtio-rng-pci: This extends VirtioPCIProxy.
+ */
+#define TYPE_VIRTIO_RNG_PCI "virtio-rng-pci"
+#define VIRTIO_RNG_PCI(obj) \
+        OBJECT_CHECK(VirtIORngPCI, (obj), TYPE_VIRTIO_RNG_PCI)
+
+struct VirtIORngPCI {
+    VirtIOPCIProxy parent_obj;
+    VirtIORNG vdev;
+};
+
+static void virtio_rng_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VirtIORngPCI *vrng = VIRTIO_RNG_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&vrng->vdev);
+    Error *err = NULL;
+
+    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
+    object_property_set_bool(OBJECT(vdev), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    object_property_set_link(OBJECT(vrng),
+                             OBJECT(vrng->vdev.conf.rng), "rng",
+                             NULL);
+}
+
+static void virtio_rng_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+
+    k->realize = virtio_rng_pci_realize;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+
+    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_RNG;
+    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
+    pcidev_k->class_id = PCI_CLASS_OTHERS;
+}
+
+static void virtio_rng_initfn(Object *obj)
+{
+    VirtIORngPCI *dev = VIRTIO_RNG_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_RNG);
+}
+
+static const TypeInfo virtio_rng_pci_info = {
+    .name          = TYPE_VIRTIO_RNG_PCI,
+    .parent        = TYPE_VIRTIO_PCI,
+    .instance_size = sizeof(VirtIORngPCI),
+    .instance_init = virtio_rng_initfn,
+    .class_init    = virtio_rng_pci_class_init,
+};
+
+static void virtio_rng_pci_register(void)
+{
+    type_register_static(&virtio_rng_pci_info);
+}
+
+type_init(virtio_rng_pci_register)
diff --git a/tests/Makefile.include b/tests/Makefile.include
index fb0b449c02..aa4e89704d 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -148,7 +148,7 @@ check-qtest-virtioserial-y += tests/virtio-console-test$(EXESUF)
 check-qtest-virtio-y += tests/virtio-net-test$(EXESUF)
 check-qtest-virtio-y += tests/virtio-balloon-test$(EXESUF)
 check-qtest-virtio-y += tests/virtio-blk-test$(EXESUF)
-check-qtest-virtio-y += tests/virtio-rng-test$(EXESUF)
+check-qtest-virtio-$(CONFIG_VIRTIO_RNG) += tests/virtio-rng-test$(EXESUF)
 check-qtest-virtio-y += tests/virtio-scsi-test$(EXESUF)
 ifeq ($(CONFIG_VIRTIO)$(CONFIG_VIRTFS)$(CONFIG_PCI),yyy)
 check-qtest-virtio-y += tests/virtio-9p-test$(EXESUF)
-- 
2.19.2
