Received: from eggs.gnu.org ([2001:4830:134:3::10]:46226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gL50R-00073P-Px
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 06:31:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gL50Q-0002m4-Hd
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 06:31:19 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Fri,  9 Nov 2018 12:29:53 +0100
Message-Id: <20181109112957.10067-15-eric.auger@redhat.com>
In-Reply-To: <20181109112957.10067-1-eric.auger@redhat.com>
References: <20181109112957.10067-1-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v8 14/18] virtio-iommu-pci: Add virtio iommu pci
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com, jean-philippe.brucker@arm.com
Cc: kevin.tian@intel.com, tn@semihalf.com, bharat.bhushan@nxp.com, peterx@redhat.com

This patch adds virtio-iommu-pci, which is the pci proxy for
the virtio-iommu device.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/virtio/virtio-pci.c | 50 ++++++++++++++++++++++++++++++++++++++++++
 hw/virtio/virtio-pci.h | 14 ++++++++++++
 include/hw/pci/pci.h   |  1 +
 qdev-monitor.c         |  1 +
 4 files changed, 66 insertions(+)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index a954799267..45b294b34d 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2342,6 +2342,55 @@ static const TypeInfo virtio_balloon_pci_info = {
     .class_init    = virtio_balloon_pci_class_init,
 };
 
+/* virtio-iommu-pci */
+
+static Property virtio_iommu_pci_properties[] = {
+    DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_iommu_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VirtIOIOMMUPCI *dev = VIRTIO_IOMMU_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+
+    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
+    object_property_set_link(OBJECT(dev),
+                             OBJECT(pci_get_bus(&vpci_dev->pci_dev)),
+                             "primary-bus", errp);
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+}
+
+static void virtio_iommu_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+    k->realize = virtio_iommu_pci_realize;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->props = virtio_iommu_pci_properties;
+    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_IOMMU;
+    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
+    pcidev_k->class_id = PCI_CLASS_OTHERS;
+}
+
+static void virtio_iommu_pci_instance_init(Object *obj)
+{
+    VirtIOIOMMUPCI *dev = VIRTIO_IOMMU_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_IOMMU);
+}
+
+static const TypeInfo virtio_iommu_pci_info = {
+    .name          = TYPE_VIRTIO_IOMMU_PCI,
+    .parent        = TYPE_VIRTIO_PCI,
+    .instance_size = sizeof(VirtIOIOMMUPCI),
+    .instance_init = virtio_iommu_pci_instance_init,
+    .class_init    = virtio_iommu_pci_class_init,
+};
+
 /* virtio-serial-pci */
 
 static void virtio_serial_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
@@ -2712,6 +2761,7 @@ static void virtio_pci_register_types(void)
 #endif
     type_register_static(&virtio_scsi_pci_info);
     type_register_static(&virtio_balloon_pci_info);
+    type_register_static(&virtio_iommu_pci_info);
     type_register_static(&virtio_serial_pci_info);
     type_register_static(&virtio_net_pci_info);
 #ifdef CONFIG_VHOST_SCSI
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 813082b0d7..a17100b4a0 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -26,6 +26,7 @@
 #include "hw/virtio/virtio-input.h"
 #include "hw/virtio/virtio-gpu.h"
 #include "hw/virtio/virtio-crypto.h"
+#include "hw/virtio/virtio-iommu.h"
 #include "hw/virtio/vhost-user-scsi.h"
 #if defined(CONFIG_VHOST_USER) && defined(CONFIG_LINUX)
 #include "hw/virtio/vhost-user-blk.h"
@@ -57,6 +58,7 @@ typedef struct VirtIOInputHostPCI VirtIOInputHostPCI;
 typedef struct VirtIOGPUPCI VirtIOGPUPCI;
 typedef struct VHostVSockPCI VHostVSockPCI;
 typedef struct VirtIOCryptoPCI VirtIOCryptoPCI;
+typedef struct VirtIOIOMMUPCI VirtIOIOMMUPCI;
 
 /* virtio-pci-bus */
 
@@ -363,6 +365,18 @@ struct VirtIOInputHIDPCI {
     VirtIOInputHID vdev;
 };
 
+/*
+ *  * virtio-iommu-pci: This extends VirtioPCIProxy.
+ *   */
+#define TYPE_VIRTIO_IOMMU_PCI "virtio-iommu-pci"
+#define VIRTIO_IOMMU_PCI(obj) \
+        OBJECT_CHECK(VirtIOIOMMUPCI, (obj), TYPE_VIRTIO_IOMMU_PCI)
+
+struct VirtIOIOMMUPCI {
+    VirtIOPCIProxy parent_obj;
+    VirtIOIOMMU vdev;
+};
+
 #ifdef CONFIG_LINUX
 
 #define TYPE_VIRTIO_INPUT_HOST_PCI "virtio-input-host-pci"
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index e6514bba23..a01fd4d2e1 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -85,6 +85,7 @@ extern bool pci_available;
 #define PCI_DEVICE_ID_VIRTIO_RNG         0x1005
 #define PCI_DEVICE_ID_VIRTIO_9P          0x1009
 #define PCI_DEVICE_ID_VIRTIO_VSOCK       0x1012
+#define PCI_DEVICE_ID_VIRTIO_IOMMU       0x1013
 
 #define PCI_VENDOR_ID_REDHAT             0x1b36
 #define PCI_DEVICE_ID_REDHAT_BRIDGE      0x0001
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 07147c63bf..4f1ae056da 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -62,6 +62,7 @@ static const QDevAlias qdev_alias_table[] = {
     { "virtio-input-host-ccw", "virtio-input-host", QEMU_ARCH_S390X },
     { "virtio-input-host-pci", "virtio-input-host",
             QEMU_ARCH_ALL & ~QEMU_ARCH_S390X },
+    { "virtio-iommu-pci", "virtio-iommu", QEMU_ARCH_ALL & ~QEMU_ARCH_S390X },
     { "virtio-keyboard-ccw", "virtio-keyboard", QEMU_ARCH_S390X },
     { "virtio-keyboard-pci", "virtio-keyboard",
             QEMU_ARCH_ALL & ~QEMU_ARCH_S390X },
-- 
2.17.2
