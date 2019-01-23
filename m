Received: from eggs.gnu.org ([209.51.188.92]:50109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gmOjl-0007Dl-VB
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 15:03:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gmOdW-0002lh-1K
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 14:56:35 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 23 Jan 2019 20:55:27 +0100
Message-Id: <20190123195527.29575-10-david@redhat.com>
In-Reply-To: <20190123195527.29575-1-david@redhat.com>
References: <20190123195527.29575-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH RFCv2 9/9] pc: Support for virtio-pmem-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Collin Walling <walling@linux.ibm.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org

Override the device hotplug handler to properly handle the memory device
part via virtio-pmem-pci callbacks from the machine hotplug handler and
forward to the actual PCI bus hotplug handler.

As PCI hotplug has not been properly factored out into hotplug handlers,
most magic is performed in the (un)realize functions. Also some PCI host
buses don't have a PCI hotplug handler at all yet, just to be sure that
we alway have a hotplug handler on x86, add a simple error check.

Unlocking virtio-pmem will unlock virtio-pmem-pci.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 default-configs/i386-softmmu.mak |  1 +
 hw/i386/pc.c                     | 70 +++++++++++++++++++++++++++++++-
 2 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index 64c998c4c8..3f63e95a55 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -52,6 +52,7 @@ CONFIG_APIC=y
 CONFIG_IOAPIC=y
 CONFIG_PVPANIC=y
 CONFIG_MEM_DEVICE=y
+CONFIG_VIRTIO_PMEM=y
 CONFIG_DIMM=y
 CONFIG_NVDIMM=y
 CONFIG_ACPI_NVDIMM=y
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index fd0cb29ba9..6a176caeb9 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -75,6 +75,7 @@
 #include "hw/usb.h"
 #include "hw/i386/intel_iommu.h"
 #include "hw/net/ne2000-isa.h"
+#include "hw/virtio/virtio-pmem-pci.h"
 
 /* debug PC/ISA interrupts */
 //#define DEBUG_IRQ
@@ -2224,6 +2225,64 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
     numa_cpu_pre_plug(cpu_slot, dev, errp);
 }
 
+static void pc_virtio_pmem_pci_pre_plug(HotplugHandler *hotplug_dev,
+                                        DeviceState *dev, Error **errp)
+{
+    HotplugHandler *hotplug_dev2 = qdev_get_bus_hotplug_handler(dev);
+    Error *local_err = NULL;
+
+    if (!hotplug_dev2) {
+        /*
+         * Without a bus hotplug handler, we cannot control the plug/unplug
+         * order. This should never be the case on x86, however better add
+         * a safety net.
+         */
+        error_setg(errp, "virtio-pmem-pci not supported on this bus.");
+        return;
+    }
+    virtio_pmem_pci_pre_plug(VIRTIO_PMEM_PCI(dev), MACHINE(hotplug_dev),
+                             &local_err);
+    if (!local_err) {
+        hotplug_handler_pre_plug(hotplug_dev2, dev, &local_err);
+    }
+    error_propagate(errp, local_err);
+}
+
+static void pc_virtio_pmem_pci_plug(HotplugHandler *hotplug_dev,
+                                    DeviceState *dev, Error **errp)
+{
+    HotplugHandler *hotplug_dev2 = qdev_get_bus_hotplug_handler(dev);
+    Error *local_err = NULL;
+
+    virtio_pmem_pci_plug(VIRTIO_PMEM_PCI(dev), MACHINE(hotplug_dev));
+    hotplug_handler_plug(hotplug_dev2, dev, &local_err);
+    if (local_err) {
+        virtio_pmem_pci_unplug(VIRTIO_PMEM_PCI(dev), MACHINE(hotplug_dev));
+    }
+    error_propagate(errp, local_err);
+}
+
+static void pc_virtio_pmem_pci_unplug_request(HotplugHandler *hotplug_dev,
+                                              DeviceState *dev, Error **errp)
+{
+    HotplugHandler *hotplug_dev2 = qdev_get_bus_hotplug_handler(dev);
+
+    hotplug_handler_unplug_request(hotplug_dev2, dev, errp);
+}
+
+static void pc_virtio_pmem_pci_unplug(HotplugHandler *hotplug_dev,
+                                      DeviceState *dev, Error **errp)
+{
+    HotplugHandler *hotplug_dev2 = qdev_get_bus_hotplug_handler(dev);
+    Error *local_err = NULL;
+
+    hotplug_handler_unplug(hotplug_dev2, dev, &local_err);
+    if (!local_err) {
+        virtio_pmem_pci_unplug(VIRTIO_PMEM_PCI(dev), MACHINE(hotplug_dev));
+    }
+    error_propagate(errp, local_err);
+}
+
 static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
                                           DeviceState *dev, Error **errp)
 {
@@ -2231,6 +2290,8 @@ static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
         pc_memory_pre_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         pc_cpu_pre_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI)) {
+        pc_virtio_pmem_pci_pre_plug(hotplug_dev, dev, errp);
     }
 }
 
@@ -2241,6 +2302,8 @@ static void pc_machine_device_plug_cb(HotplugHandler *hotplug_dev,
         pc_memory_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         pc_cpu_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI)) {
+        pc_virtio_pmem_pci_plug(hotplug_dev, dev, errp);
     }
 }
 
@@ -2251,6 +2314,8 @@ static void pc_machine_device_unplug_request_cb(HotplugHandler *hotplug_dev,
         pc_memory_unplug_request(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         pc_cpu_unplug_request_cb(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI)) {
+        pc_virtio_pmem_pci_unplug_request(hotplug_dev, dev, errp);
     } else {
         error_setg(errp, "acpi: device unplug request for not supported device"
                    " type: %s", object_get_typename(OBJECT(dev)));
@@ -2264,6 +2329,8 @@ static void pc_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
         pc_memory_unplug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         pc_cpu_unplug_cb(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI)) {
+        pc_virtio_pmem_pci_unplug(hotplug_dev, dev, errp);
     } else {
         error_setg(errp, "acpi: device unplug for not supported device"
                    " type: %s", object_get_typename(OBJECT(dev)));
@@ -2274,7 +2341,8 @@ static HotplugHandler *pc_get_hotpug_handler(MachineState *machine,
                                              DeviceState *dev)
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
-        object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
+        object_dynamic_cast(OBJECT(dev), TYPE_CPU) ||
+        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI)) {
         return HOTPLUG_HANDLER(machine);
     }
 
-- 
2.17.2
