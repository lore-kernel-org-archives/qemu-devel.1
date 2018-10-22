Received: from eggs.gnu.org ([2001:4830:134:3::10]:39302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gEf5z-0000Ps-Op
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:38:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gEf5w-0004Pu-6C
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:38:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:7827)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sameo@linux.intel.com>)
	id 1gEf5v-0003wU-Rf
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:38:28 -0400
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Mon, 22 Oct 2018 20:36:41 +0200
Message-Id: <20181022183656.4902-12-sameo@linux.intel.com>
In-Reply-To: <20181022183656.4902-1-sameo@linux.intel.com>
References: <20181022183656.4902-1-sameo@linux.intel.com>
Subject: [Qemu-devel] [PATCH 11/26] hw: i386: Make the hotpluggable memory
 size property more generic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Ortiz <sameo@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

This property is currently defined under i386/pc while it only describes
a region size that's eventually fetched from the AML ACPI code.

We can make it more generic and shareable across machine types by moving
it to memory-device.h instead.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
---
 hw/i386/acpi-build.c           | 2 +-
 hw/i386/pc.c                   | 3 ++-
 include/hw/i386/pc.h           | 1 -
 include/hw/mem/memory-device.h | 2 ++
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 414a6c4c4e..dfc02a8a85 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1630,7 +1630,7 @@ build_srat(GArray *table_data, BIOSLinker *linker,
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(machine);
     ram_addr_t hotplugabble_address_space_size =
-        object_property_get_int(OBJECT(machine), PC_MACHINE_DEVMEM_REGION_SIZE,
+        object_property_get_int(OBJECT(machine), MEMORY_DEVICE_REGION_SIZE,
                                 NULL);
 
     srat_start = table_data->len;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 940485a728..fa12583096 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -67,6 +67,7 @@
 #include "hw/boards.h"
 #include "acpi-build.h"
 #include "hw/mem/pc-dimm.h"
+#include "hw/mem/memory-device.h"
 #include "qapi/error.h"
 #include "qapi/qapi-visit-common.h"
 #include "qapi/visitor.h"
@@ -2442,7 +2443,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     nc->nmi_monitor_handler = x86_nmi;
     mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
 
-    object_class_property_add(oc, PC_MACHINE_DEVMEM_REGION_SIZE, "int",
+    object_class_property_add(oc, MEMORY_DEVICE_REGION_SIZE, "int",
         pc_machine_get_device_memory_region_size, NULL,
         NULL, NULL, &error_abort);
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index da0bd39741..7d177cd207 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -62,7 +62,6 @@ struct PCMachineState {
 };
 
 #define PC_MACHINE_ACPI_DEVICE_PROP "acpi-device"
-#define PC_MACHINE_DEVMEM_REGION_SIZE "device-memory-region-size"
 #define PC_MACHINE_MAX_RAM_BELOW_4G "max-ram-below-4g"
 #define PC_MACHINE_VMPORT           "vmport"
 #define PC_MACHINE_SMM              "smm"
diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index 2853b084b5..fc39fbe38f 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -39,6 +39,8 @@ typedef struct MemoryDeviceClass {
                              MemoryDeviceInfo *info);
 } MemoryDeviceClass;
 
+#define MEMORY_DEVICE_REGION_SIZE "memory-device-region-size"
+
 MemoryDeviceInfoList *qmp_memory_device_list(void);
 uint64_t get_plugged_memory_size(void);
 uint64_t memory_device_get_free_addr(MachineState *ms, const uint64_t *hint,
-- 
2.17.2
