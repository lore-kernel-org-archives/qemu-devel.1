Received: from eggs.gnu.org ([2001:4830:134:3::10]:39218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <v.mayatskih@gmail.com>) id 1gIevC-0004rd-5M
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 15:15:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <v.mayatskih@gmail.com>) id 1gIev8-0005Dz-KF
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 15:15:54 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:42246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <v.mayatskih@gmail.com>)
	id 1gIev8-0005Cr-9d
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 15:15:50 -0400
Received: by mail-qk1-x743.google.com with SMTP id u68so4745924qkg.9
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 12:15:49 -0700 (PDT)
From: Vitaly Mayatskikh <v.mayatskih@gmail.com>
Date: Fri,  2 Nov 2018 19:15:38 +0000
Message-Id: <20181102191538.7532-1-v.mayatskih@gmail.com>
Subject: [Qemu-devel] [PATCH 1/1] Add vhost-pci-blk driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Vitaly Mayatskikh <v.mayatskih@gmail.com>

This driver uses the kernel-mode acceleration for virtio-blk and
allows to get a near bare metal disk performance inside a VM.

Signed-off-by: Vitaly Mayatskikh <v.mayatskih@gmail.com>
---
 configure                  | 10 +++++++
 default-configs/virtio.mak |  1 +
 hw/block/Makefile.objs     |  1 +
 hw/virtio/virtio-pci.c     | 60 ++++++++++++++++++++++++++++++++++++++
 hw/virtio/virtio-pci.h     | 19 ++++++++++++
 5 files changed, 91 insertions(+)

diff --git a/configure b/configure
index 46ae1e8c76..787bc780da 100755
--- a/configure
+++ b/configure
@@ -371,6 +371,7 @@ vhost_crypto="no"
 vhost_scsi="no"
 vhost_vsock="no"
 vhost_user=""
+vhost_blk=""
 kvm="no"
 hax="no"
 hvf="no"
@@ -869,6 +870,7 @@ Linux)
   vhost_crypto="yes"
   vhost_scsi="yes"
   vhost_vsock="yes"
+  vhost_blk="yes"
   QEMU_INCLUDES="-I\$(SRC_PATH)/linux-headers -I$(pwd)/linux-headers $QEMU_INCLUDES"
   supported_os="yes"
   libudev="yes"
@@ -1263,6 +1265,10 @@ for opt do
   ;;
   --enable-vhost-vsock) vhost_vsock="yes"
   ;;
+  --disable-vhost-blk) vhost_blk="no"
+  ;;
+  --enable-vhost-blk) vhost_blk="yes"
+  ;;
   --disable-opengl) opengl="no"
   ;;
   --enable-opengl) opengl="yes"
@@ -6000,6 +6006,7 @@ echo "vhost-crypto support $vhost_crypto"
 echo "vhost-scsi support $vhost_scsi"
 echo "vhost-vsock support $vhost_vsock"
 echo "vhost-user support $vhost_user"
+echo "vhost-blk support $vhost_blk"
 echo "Trace backends    $trace_backends"
 if have_backend "simple"; then
 echo "Trace output file $trace_file-<pid>"
@@ -6461,6 +6468,9 @@ fi
 if test "$vhost_user" = "yes" ; then
   echo "CONFIG_VHOST_USER=y" >> $config_host_mak
 fi
+if test "$vhost_blk" = "yes" ; then
+  echo "CONFIG_VHOST_BLK=y" >> $config_host_mak
+fi
 if test "$blobs" = "yes" ; then
   echo "INSTALL_BLOBS=yes" >> $config_host_mak
 fi
diff --git a/default-configs/virtio.mak b/default-configs/virtio.mak
index 1304849018..765c0a2a04 100644
--- a/default-configs/virtio.mak
+++ b/default-configs/virtio.mak
@@ -1,5 +1,6 @@
 CONFIG_VHOST_USER_SCSI=$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX))
 CONFIG_VHOST_USER_BLK=$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX))
+CONFIG_VHOST_BLK=$(CONFIG_LINUX)
 CONFIG_VIRTIO=y
 CONFIG_VIRTIO_9P=y
 CONFIG_VIRTIO_BALLOON=y
diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
index 53ce5751ae..857ce823fc 100644
--- a/hw/block/Makefile.objs
+++ b/hw/block/Makefile.objs
@@ -14,3 +14,4 @@ obj-$(CONFIG_SH4) += tc58128.o
 obj-$(CONFIG_VIRTIO_BLK) += virtio-blk.o
 obj-$(CONFIG_VIRTIO_BLK) += dataplane/
 obj-$(CONFIG_VHOST_USER_BLK) += vhost-user-blk.o
+obj-$(CONFIG_VHOST_BLK) += vhost-blk.o
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index a954799267..ec00b54424 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2060,6 +2060,63 @@ static const TypeInfo vhost_user_blk_pci_info = {
 };
 #endif
 
+#ifdef CONFIG_VHOST_BLK
+/* vhost-blk */
+
+static Property vhost_blk_pci_properties[] = {
+    DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
+                       DEV_NVECTORS_UNSPECIFIED),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vhost_blk_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VHostBlkPCI *dev = VHOST_BLK_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+
+    if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
+        vpci_dev->nvectors = dev->vdev.num_queues + 1;
+    }
+
+    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+}
+
+static void vhost_blk_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    dc->props = vhost_blk_pci_properties;
+    k->realize = vhost_blk_pci_realize;
+    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_BLOCK;
+    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
+    pcidev_k->class_id = PCI_CLASS_STORAGE_SCSI;
+}
+
+static void vhost_blk_pci_instance_init(Object *obj)
+{
+    VHostBlkPCI *dev = VHOST_BLK_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VHOST_BLK);
+    object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
+                              "bootindex", &error_abort);
+}
+
+static const TypeInfo vhost_blk_pci_info = {
+    .name           = TYPE_VHOST_BLK_PCI,
+    .parent         = TYPE_VIRTIO_PCI,
+    .instance_size  = sizeof(VHostBlkPCI),
+    .instance_init  = vhost_blk_pci_instance_init,
+    .class_init     = vhost_blk_pci_class_init,
+};
+#endif
+
 /* virtio-scsi-pci */
 
 static Property virtio_scsi_pci_properties[] = {
@@ -2723,6 +2780,9 @@ static void virtio_pci_register_types(void)
 #ifdef CONFIG_VHOST_VSOCK
     type_register_static(&vhost_vsock_pci_info);
 #endif
+#ifdef CONFIG_VHOST_BLK
+    type_register_static(&vhost_blk_pci_info);
+#endif
 }
 
 type_init(virtio_pci_register_types)
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 813082b0d7..4cca04a45a 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -31,6 +31,10 @@
 #include "hw/virtio/vhost-user-blk.h"
 #endif
 
+#ifdef CONFIG_VHOST_BLK
+#include "hw/virtio/vhost-blk.h"
+#endif
+
 #ifdef CONFIG_VIRTFS
 #include "hw/9pfs/virtio-9p.h"
 #endif
@@ -50,6 +54,7 @@ typedef struct VirtIONetPCI VirtIONetPCI;
 typedef struct VHostSCSIPCI VHostSCSIPCI;
 typedef struct VHostUserSCSIPCI VHostUserSCSIPCI;
 typedef struct VHostUserBlkPCI VHostUserBlkPCI;
+typedef struct VHostBlkPCI VHostBlkPCI;
 typedef struct VirtIORngPCI VirtIORngPCI;
 typedef struct VirtIOInputPCI VirtIOInputPCI;
 typedef struct VirtIOInputHIDPCI VirtIOInputHIDPCI;
@@ -262,6 +267,20 @@ struct VHostUserBlkPCI {
 };
 #endif
 
+#ifdef CONFIG_VHOST_BLK
+/*
+ * vhost-blk-pci: This extends VirtioPCIProxy.
+ */
+#define TYPE_VHOST_BLK_PCI "vhost-blk-pci"
+#define VHOST_BLK_PCI(obj) \
+        OBJECT_CHECK(VHostBlkPCI, (obj), TYPE_VHOST_BLK_PCI)
+
+struct VHostBlkPCI {
+    VirtIOPCIProxy parent_obj;
+    VHostBlk vdev;
+};
+#endif
+
 /*
  * virtio-blk-pci: This extends VirtioPCIProxy.
  */
-- 
2.17.1
