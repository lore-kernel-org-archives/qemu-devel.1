Received: from eggs.gnu.org ([2001:4830:134:3::10]:35352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fv2XH-00055S-6J
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:37:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fv2XD-0002HP-Uy
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:37:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44008 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fv2XD-0002HL-Os
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:37:31 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 29 Aug 2018 17:36:24 +0200
Message-Id: <20180829153624.12299-21-david@redhat.com>
In-Reply-To: <20180829153624.12299-1-david@redhat.com>
References: <20180829153624.12299-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 20/20] pc: support for virtio-pmem
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

Compile virtio-pmem for x86 and properly hotplug virtio-pmem devices
(memory-device part) from our pc machine hotplug handler.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 default-configs/i386-softmmu.mak |  1 +
 hw/i386/pc.c                     | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index 4c1637338b..dfb1e6d63a 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -51,6 +51,7 @@ CONFIG_APIC=y
 CONFIG_IOAPIC=y
 CONFIG_PVPANIC=y
 CONFIG_MEM_DEVICE=y
+CONFIG_VIRTIO_PMEM=y
 CONFIG_DIMM=y
 CONFIG_NVDIMM=y
 CONFIG_ACPI_NVDIMM=y
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 03148450c8..bea043fe23 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -74,6 +74,7 @@
 #include "hw/nmi.h"
 #include "hw/i386/intel_iommu.h"
 #include "hw/net/ne2000-isa.h"
+#include "hw/virtio/virtio-pmem.h"
 
 /* debug PC/ISA interrupts */
 //#define DEBUG_IRQ
@@ -2013,6 +2014,8 @@ static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
         pc_memory_pre_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         pc_cpu_pre_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM)) {
+        virtio_pmem_pre_plug(VIRTIO_PMEM(dev), MACHINE(hotplug_dev), errp);
     }
 }
 
@@ -2023,6 +2026,8 @@ static void pc_machine_device_plug_cb(HotplugHandler *hotplug_dev,
         pc_memory_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         pc_cpu_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM)) {
+        virtio_pmem_plug(VIRTIO_PMEM(dev), MACHINE(hotplug_dev), errp);
     }
 }
 
@@ -2046,6 +2051,8 @@ static void pc_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
         pc_memory_unplug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         pc_cpu_unplug_cb(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM)) {
+        virtio_pmem_unplug(VIRTIO_PMEM(dev), MACHINE(hotplug_dev), errp);
     } else {
         error_setg(errp, "acpi: device unplug for not supported device"
                    " type: %s", object_get_typename(OBJECT(dev)));
@@ -2056,7 +2063,8 @@ static HotplugHandler *pc_get_hotpug_handler(MachineState *machine,
                                              DeviceState *dev)
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
-        object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
+        object_dynamic_cast(OBJECT(dev), TYPE_CPU) ||
+        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM)) {
         return HOTPLUG_HANDLER(machine);
     }
 
-- 
2.17.1
