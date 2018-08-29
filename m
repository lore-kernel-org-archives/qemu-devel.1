Received: from eggs.gnu.org ([2001:4830:134:3::10]:35263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fv2X2-0004wO-DQ
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:37:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fv2X1-0002DD-FB
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:37:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57540 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fv2X1-0002Cq-90
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:37:19 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 29 Aug 2018 17:36:20 +0200
Message-Id: <20180829153624.12299-17-david@redhat.com>
In-Reply-To: <20180829153624.12299-1-david@redhat.com>
References: <20180829153624.12299-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 16/20] virtio-pci: proxy for virtio-pmem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>, David Hildenbrand <david@redhat.com>

From: Pankaj Gupta <pagupta@redhat.com>

We need a proxy device for virtio-pmem.

Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
[ split up patches ]
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-pci.c | 41 +++++++++++++++++++++++++++++++++++++++++
 hw/virtio/virtio-pci.h | 14 ++++++++++++++
 include/hw/pci/pci.h   |  1 +
 3 files changed, 56 insertions(+)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 3a01fe90f0..dcfcefc1b5 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2521,6 +2521,46 @@ static const TypeInfo virtio_rng_pci_info = {
     .class_init    = virtio_rng_pci_class_init,
 };
 
+/* virtio-pmem-pci */
+
+static void virtio_pmem_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VirtIOPMEMPCI *vpmem = VIRTIO_PMEM_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&vpmem->vdev);
+
+    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+}
+
+static void virtio_pmem_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+    k->realize = virtio_pmem_pci_realize;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_PMEM;
+    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
+    pcidev_k->class_id = PCI_CLASS_OTHERS;
+}
+
+static void virtio_pmem_pci_instance_init(Object *obj)
+{
+    VirtIOPMEMPCI *dev = VIRTIO_PMEM_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_PMEM);
+}
+
+static const TypeInfo virtio_pmem_pci_info = {
+    .name          = TYPE_VIRTIO_PMEM_PCI,
+    .parent        = TYPE_VIRTIO_PCI,
+    .instance_size = sizeof(VirtIOPMEMPCI),
+    .instance_init = virtio_pmem_pci_instance_init,
+    .class_init    = virtio_pmem_pci_class_init,
+};
+
 /* virtio-input-pci */
 
 static Property virtio_input_pci_properties[] = {
@@ -2714,6 +2754,7 @@ static void virtio_pci_register_types(void)
     type_register_static(&virtio_balloon_pci_info);
     type_register_static(&virtio_serial_pci_info);
     type_register_static(&virtio_net_pci_info);
+    type_register_static(&virtio_pmem_pci_info);
 #ifdef CONFIG_VHOST_SCSI
     type_register_static(&vhost_scsi_pci_info);
 #endif
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 813082b0d7..fe74fcad3f 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -19,6 +19,7 @@
 #include "hw/virtio/virtio-blk.h"
 #include "hw/virtio/virtio-net.h"
 #include "hw/virtio/virtio-rng.h"
+#include "hw/virtio/virtio-pmem.h"
 #include "hw/virtio/virtio-serial.h"
 #include "hw/virtio/virtio-scsi.h"
 #include "hw/virtio/virtio-balloon.h"
@@ -57,6 +58,7 @@ typedef struct VirtIOInputHostPCI VirtIOInputHostPCI;
 typedef struct VirtIOGPUPCI VirtIOGPUPCI;
 typedef struct VHostVSockPCI VHostVSockPCI;
 typedef struct VirtIOCryptoPCI VirtIOCryptoPCI;
+typedef struct VirtIOPMEMPCI VirtIOPMEMPCI;
 
 /* virtio-pci-bus */
 
@@ -274,6 +276,18 @@ struct VirtIOBlkPCI {
     VirtIOBlock vdev;
 };
 
+/*
+ * virtio-pmem-pci: This extends VirtioPCIProxy.
+ */
+#define TYPE_VIRTIO_PMEM_PCI "virtio-pmem-pci"
+#define VIRTIO_PMEM_PCI(obj) \
+        OBJECT_CHECK(VirtIOPMEMPCI, (obj), TYPE_VIRTIO_PMEM_PCI)
+
+struct VirtIOPMEMPCI {
+    VirtIOPCIProxy parent_obj;
+    VirtIOPMEM vdev;
+};
+
 /*
  * virtio-balloon-pci: This extends VirtioPCIProxy.
  */
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 990d6fcbde..28829b6437 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -85,6 +85,7 @@ extern bool pci_available;
 #define PCI_DEVICE_ID_VIRTIO_RNG         0x1005
 #define PCI_DEVICE_ID_VIRTIO_9P          0x1009
 #define PCI_DEVICE_ID_VIRTIO_VSOCK       0x1012
+#define PCI_DEVICE_ID_VIRTIO_PMEM        0x1013
 
 #define PCI_VENDOR_ID_REDHAT             0x1b36
 #define PCI_DEVICE_ID_REDHAT_BRIDGE      0x0001
-- 
2.17.1
