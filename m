Received: from eggs.gnu.org ([2001:4830:134:3::10]:38697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFjYR-0006hI-7g
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:04:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFjYP-0007wS-0d
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:04:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fFjYO-0007vr-Pc
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:04:00 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  7 May 2018 14:03:12 -0300
Message-Id: <20180507170315.11497-10-ehabkost@redhat.com>
In-Reply-To: <20180507170315.11497-1-ehabkost@redhat.com>
References: <20180507170315.11497-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 09/12] pc: rename "hotplug memory" terminology
 to "device memory"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

Let's make it clear that we are dealing with device memory. That it can
be used for memory hotplug is just a special case.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180423165126.15441-10-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/i386/pc.h |  2 +-
 hw/i386/acpi-build.c |  2 +-
 hw/i386/pc.c         | 25 ++++++++++++-------------
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 07b596ee76..2e834e6ded 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -71,7 +71,7 @@ struct PCMachineState {
 };
 
 #define PC_MACHINE_ACPI_DEVICE_PROP "acpi-device"
-#define PC_MACHINE_MEMHP_REGION_SIZE "hotplug-memory-region-size"
+#define PC_MACHINE_DEVMEM_REGION_SIZE "device-memory-region-size"
 #define PC_MACHINE_MAX_RAM_BELOW_4G "max-ram-below-4g"
 #define PC_MACHINE_VMPORT           "vmport"
 #define PC_MACHINE_SMM              "smm"
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index b1eddeb204..9bc6d97ea1 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2313,7 +2313,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
     const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(machine);
     PCMachineState *pcms = PC_MACHINE(machine);
     ram_addr_t hotplugabble_address_space_size =
-        object_property_get_int(OBJECT(pcms), PC_MACHINE_MEMHP_REGION_SIZE,
+        object_property_get_int(OBJECT(pcms), PC_MACHINE_DEVMEM_REGION_SIZE,
                                 NULL);
 
     srat_start = table_data->len;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index e94e63dc6c..868893d0a1 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1374,11 +1374,10 @@ void pc_memory_init(PCMachineState *pcms,
     /* always allocate the device memory information */
     machine->device_memory = g_malloc0(sizeof(*machine->device_memory));
 
-    /* initialize hotplug memory address space */
+    /* initialize device memory address space */
     if (pcmc->has_reserved_memory &&
         (machine->ram_size < machine->maxram_size)) {
-        ram_addr_t hotplug_mem_size =
-            machine->maxram_size - machine->ram_size;
+        ram_addr_t device_mem_size = machine->maxram_size - machine->ram_size;
 
         if (machine->ram_slots > ACPI_MAX_RAM_SLOTS) {
             error_report("unsupported amount of memory slots: %"PRIu64,
@@ -1397,19 +1396,19 @@ void pc_memory_init(PCMachineState *pcms,
             ROUND_UP(0x100000000ULL + pcms->above_4g_mem_size, 1ULL << 30);
 
         if (pcmc->enforce_aligned_dimm) {
-            /* size hotplug region assuming 1G page max alignment per slot */
-            hotplug_mem_size += (1ULL << 30) * machine->ram_slots;
+            /* size device region assuming 1G page max alignment per slot */
+            device_mem_size += (1ULL << 30) * machine->ram_slots;
         }
 
-        if ((machine->device_memory->base + hotplug_mem_size) <
-            hotplug_mem_size) {
+        if ((machine->device_memory->base + device_mem_size) <
+            device_mem_size) {
             error_report("unsupported amount of maximum memory: " RAM_ADDR_FMT,
                          machine->maxram_size);
             exit(EXIT_FAILURE);
         }
 
         memory_region_init(&machine->device_memory->mr, OBJECT(pcms),
-                           "hotplug-memory", hotplug_mem_size);
+                           "device-memory", device_mem_size);
         memory_region_add_subregion(system_memory, machine->device_memory->base,
                                     &machine->device_memory->mr);
     }
@@ -2064,9 +2063,9 @@ static HotplugHandler *pc_get_hotpug_handler(MachineState *machine,
 }
 
 static void
-pc_machine_get_hotplug_memory_region_size(Object *obj, Visitor *v,
-                                          const char *name, void *opaque,
-                                          Error **errp)
+pc_machine_get_device_memory_region_size(Object *obj, Visitor *v,
+                                         const char *name, void *opaque,
+                                         Error **errp)
 {
     MachineState *ms = MACHINE(obj);
     int64_t value = memory_region_size(&ms->device_memory->mr);
@@ -2373,8 +2372,8 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     nc->nmi_monitor_handler = x86_nmi;
     mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
 
-    object_class_property_add(oc, PC_MACHINE_MEMHP_REGION_SIZE, "int",
-        pc_machine_get_hotplug_memory_region_size, NULL,
+    object_class_property_add(oc, PC_MACHINE_DEVMEM_REGION_SIZE, "int",
+        pc_machine_get_device_memory_region_size, NULL,
         NULL, NULL, &error_abort);
 
     object_class_property_add(oc, PC_MACHINE_MAX_RAM_BELOW_4G, "size",
-- 
2.14.3
