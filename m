Received: from eggs.gnu.org ([209.51.188.92]:45430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gjjUw-0005SJ-Il
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:36:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gjjUt-00007q-5d
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:36:42 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 16 Jan 2019 12:35:19 +0100
Message-Id: <20190116113523.9213-7-david@redhat.com>
In-Reply-To: <20190116113523.9213-1-david@redhat.com>
References: <20190116113523.9213-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 06/10] virtio-pci: Proxy for virtio-pmem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Collin Walling <walling@linux.ibm.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Pankaj Gupta <pagupta@redhat.com>

From: Pankaj Gupta <pagupta@redhat.com>

We need a proxy device for virtio-pmem, and this device has to be the
actual memory device so we can cleanly hotplug it.

Forward memory device class functions either to the actual device or use
properties of the virtio-pmem device to implement these in the proxy.

virtio-pmem will only be compiled for selected, supported architectures
(that can deal with virtio/pci devices being memory devices). An
architecture that is prepared for that can simply enable
CONFIG_VIRTIO_PMEM to make it work.

As not all architectures support memory devices (and CONFIG_VIRTIO_PMEM
will be enabled per supported architecture), we have to move the PCI proxy
to a separate file.

Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
[ split up patches, memory-device changes, move pci proxy, drop legacy
  pci ID ]
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/Makefile.objs     |   1 +
 hw/virtio/virtio-pci.h      |  14 ++++
 hw/virtio/virtio-pmem-pci.c | 129 ++++++++++++++++++++++++++++++++++++
 3 files changed, 144 insertions(+)
 create mode 100644 hw/virtio/virtio-pmem-pci.c

diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index 5463c682f7..0f724725df 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -10,6 +10,7 @@ obj-$(CONFIG_VIRTIO_CRYPTO) += virtio-crypto.o
 obj-$(call land,$(CONFIG_VIRTIO_CRYPTO),$(CONFIG_VIRTIO_PCI)) += virtio-crypto-pci.o
 
 obj-$(CONFIG_VIRTIO_PMEM) += virtio-pmem.o
+common-obj-$(call land,$(CONFIG_VIRTIO_PMEM),$(CONFIG_VIRTIO_PCI)) += virtio-pmem-pci.o
 
 obj-$(CONFIG_LINUX) += vhost.o vhost-backend.o vhost-user.o
 obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock.o
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 9d8f41ea15..3496c7ca09 100644
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
+#define TYPE_VIRTIO_PMEM_PCI "virtio-pmem-pci-base"
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
diff --git a/hw/virtio/virtio-pmem-pci.c b/hw/virtio/virtio-pmem-pci.c
new file mode 100644
index 0000000000..5687aebe7d
--- /dev/null
+++ b/hw/virtio/virtio-pmem-pci.c
@@ -0,0 +1,129 @@
+/*
+ * Virtio PMEM PCI device
+ *
+ * Copyright (C) 2018 Red Hat, Inc.
+ *
+ * Authors:
+ *  Pankaj Gupta <pagupta@redhat.com>
+ *  David Hildenbrand <david@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ * See the COPYING file in the top-level directory.
+ */
+#include "qemu/osdep.h"
+#include "hw/virtio/virtio.h"
+#include "hw/virtio/virtio-bus.h"
+#include "hw/virtio/virtio-pci.h"
+#include "hw/pci/pci.h"
+#include "qapi/error.h"
+#include "hw/mem/memory-device.h"
+
+static void virtio_pmem_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VirtIOPMEMPCI *pmem_pci = VIRTIO_PMEM_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&pmem_pci->vdev);
+
+    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+}
+
+static void virtio_pmem_pci_set_addr(MemoryDeviceState *md, uint64_t addr,
+                                     Error **errp)
+{
+    object_property_set_uint(OBJECT(md), addr, VIRTIO_PMEM_ADDR_PROP, errp);
+}
+
+static uint64_t virtio_pmem_pci_get_addr(const MemoryDeviceState *md)
+{
+    return object_property_get_uint(OBJECT(md), VIRTIO_PMEM_ADDR_PROP,
+                                    &error_abort);
+}
+
+static MemoryRegion *virtio_pmem_pci_get_memory_region(MemoryDeviceState *md,
+                                                       Error **errp)
+{
+    VirtIOPMEMPCI *pci_pmem = VIRTIO_PMEM_PCI(md);
+    VirtIOPMEM *pmem = VIRTIO_PMEM(&pci_pmem->vdev);
+    VirtIOPMEMClass *vpc = VIRTIO_PMEM_GET_CLASS(pmem);
+
+    return vpc->get_memory_region(pmem, errp);
+}
+
+static uint64_t virtio_pmem_pci_get_plugged_size(const MemoryDeviceState *md,
+                                                 Error **errp)
+{
+    VirtIOPMEMPCI *pci_pmem = VIRTIO_PMEM_PCI(md);
+    VirtIOPMEM *pmem = VIRTIO_PMEM(&pci_pmem->vdev);
+    VirtIOPMEMClass *vpc = VIRTIO_PMEM_GET_CLASS(pmem);
+    MemoryRegion *mr = vpc->get_memory_region(pmem, errp);
+
+    /* the plugged size corresponds to the region size */
+    return mr ? 0 : memory_region_size(mr);
+}
+
+static void virtio_pmem_pci_fill_device_info(const MemoryDeviceState *md,
+                                             MemoryDeviceInfo *info)
+{
+    VirtioPMEMDeviceInfo *vi = g_new0(VirtioPMEMDeviceInfo, 1);
+    VirtIOPMEMPCI *pci_pmem = VIRTIO_PMEM_PCI(md);
+    VirtIOPMEM *pmem = VIRTIO_PMEM(&pci_pmem->vdev);
+    VirtIOPMEMClass *vpc = VIRTIO_PMEM_GET_CLASS(pmem);
+    DeviceState *dev = DEVICE(md);
+
+    if (dev->id) {
+        vi->has_id = true;
+        vi->id = g_strdup(dev->id);
+    }
+
+    /* let the real device handle everything else */
+    vpc->fill_device_info(pmem, vi);
+
+    info->u.virtio_pmem.data = vi;
+    info->type = MEMORY_DEVICE_INFO_KIND_VIRTIO_PMEM;
+}
+
+static void virtio_pmem_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+    MemoryDeviceClass *mdc = MEMORY_DEVICE_CLASS(klass);
+
+    k->realize = virtio_pmem_pci_realize;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    pcidev_k->class_id = PCI_CLASS_OTHERS;
+
+    mdc->get_addr = virtio_pmem_pci_get_addr;
+    mdc->set_addr = virtio_pmem_pci_set_addr;
+    mdc->get_plugged_size = virtio_pmem_pci_get_plugged_size;
+    mdc->get_memory_region = virtio_pmem_pci_get_memory_region;
+    mdc->fill_device_info = virtio_pmem_pci_fill_device_info;
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
+static const VirtioPCIDeviceTypeInfo virtio_pmem_pci_info = {
+    .base_name             = TYPE_VIRTIO_PMEM_PCI,
+    .generic_name          = "virtio-pmem-pci",
+    .transitional_name     = "virtio-pmem-pci-transitional",
+    .non_transitional_name = "virtio-pmem-pci-non-transitional",
+    .instance_size = sizeof(VirtIOPMEMPCI),
+    .instance_init = virtio_pmem_pci_instance_init,
+    .class_init    = virtio_pmem_pci_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_MEMORY_DEVICE },
+        { }
+    },
+};
+
+static void virtio_pmem_pci_register_types(void)
+{
+    virtio_pci_types_register(&virtio_pmem_pci_info);
+}
+type_init(virtio_pmem_pci_register_types)
-- 
2.17.2
