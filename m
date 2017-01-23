Received: from eggs.gnu.org ([2001:4830:134:3::10]:38230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cVo24-0003OO-5C
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 18:28:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cVo20-00064t-V6
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 18:28:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cVo20-000635-MA
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 18:28:12 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 23 Jan 2017 21:27:33 -0200
Message-Id: <20170123232738.20796-9-ehabkost@redhat.com>
In-Reply-To: <20170123232738.20796-1-ehabkost@redhat.com>
References: <20170123232738.20796-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 08/13] machine: Make possible_cpu_arch_ids()
 return const pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

make sure that external callers won't try to modify
possible_cpus and owner of possible_cpus can access
it directly when it modifies it.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1484759609-264075-5-git-send-email-imammedo@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/acpi/acpi_dev_interface.h |  2 +-
 include/hw/boards.h                  |  2 +-
 include/hw/i386/pc.h                 |  2 +-
 hw/acpi/cpu.c                        |  6 ++----
 hw/acpi/cpu_hotplug.c                |  4 +---
 hw/i386/acpi-build.c                 |  8 +++-----
 hw/i386/pc.c                         | 10 +++-------
 stubs/pc_madt_cpu_entry.c            |  2 +-
 8 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
index 901a4ae876..71d3c48e7d 100644
--- a/include/hw/acpi/acpi_dev_interface.h
+++ b/include/hw/acpi/acpi_dev_interface.h
@@ -57,6 +57,6 @@ typedef struct AcpiDeviceIfClass {
     void (*ospm_status)(AcpiDeviceIf *adev, ACPIOSTInfoList ***list);
     void (*send_event)(AcpiDeviceIf *adev, AcpiEventStatusBits ev);
     void (*madt_cpu)(AcpiDeviceIf *adev, int uid,
-                     CPUArchIdList *apic_ids, GArray *entry);
+                     const CPUArchIdList *apic_ids, GArray *entry);
 } AcpiDeviceIfClass;
 #endif
diff --git a/include/hw/boards.h b/include/hw/boards.h
index a51da9c440..ac891a828b 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -135,7 +135,7 @@ struct MachineClass {
     HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
                                            DeviceState *dev);
     unsigned (*cpu_index_to_socket_id)(unsigned cpu_index);
-    CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
+    const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
     HotpluggableCPUList *(*query_hotpluggable_cpus)(MachineState *machine);
 };
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 738bfd6c60..5a20c5e38e 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -361,7 +361,7 @@ uint16_t pvpanic_port(void);
 
 /* acpi-build.c */
 void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
-                       CPUArchIdList *apic_ids, GArray *entry);
+                       const CPUArchIdList *apic_ids, GArray *entry);
 
 /* e820 types */
 #define E820_RAM        1
diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 5ac89fefaf..6017ca04bf 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -190,7 +190,7 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
 {
     MachineState *machine = MACHINE(qdev_get_machine());
     MachineClass *mc = MACHINE_GET_CLASS(machine);
-    CPUArchIdList *id_list;
+    const CPUArchIdList *id_list;
     int i;
 
     assert(mc->possible_cpu_arch_ids);
@@ -201,7 +201,6 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
         state->devs[i].cpu =  id_list->cpus[i].cpu;
         state->devs[i].arch_id = id_list->cpus[i].arch_id;
     }
-    g_free(id_list);
     memory_region_init_io(&state->ctrl_reg, owner, &cpu_hotplug_ops, state,
                           "acpi-mem-hotplug", ACPI_CPU_HOTPLUG_REG_LEN);
     memory_region_add_subregion(as, base_addr, &state->ctrl_reg);
@@ -325,7 +324,7 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
     Aml *one = aml_int(1);
     Aml *sb_scope = aml_scope("_SB");
     MachineClass *mc = MACHINE_GET_CLASS(machine);
-    CPUArchIdList *arch_ids = mc->possible_cpu_arch_ids(machine);
+    const CPUArchIdList *arch_ids = mc->possible_cpu_arch_ids(machine);
     char *cphp_res_path = g_strdup_printf("%s." CPUHP_RES_DEVICE, res_root);
     Object *obj = object_resolve_path_type("", TYPE_ACPI_DEVICE_IF, NULL);
     AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(obj);
@@ -574,5 +573,4 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
     aml_append(table, method);
 
     g_free(cphp_res_path);
-    g_free(arch_ids);
 }
diff --git a/hw/acpi/cpu_hotplug.c b/hw/acpi/cpu_hotplug.c
index f15a2402fc..5243918125 100644
--- a/hw/acpi/cpu_hotplug.c
+++ b/hw/acpi/cpu_hotplug.c
@@ -128,7 +128,7 @@ void build_legacy_cpu_hotplug_aml(Aml *ctx, MachineState *machine,
     Aml *zero = aml_int(0);
     Aml *one = aml_int(1);
     MachineClass *mc = MACHINE_GET_CLASS(machine);
-    CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(machine);
+    const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(machine);
     PCMachineState *pcms = PC_MACHINE(machine);
 
     /*
@@ -329,8 +329,6 @@ void build_legacy_cpu_hotplug_aml(Aml *ctx, MachineState *machine,
         apic_idx = apic_id + 1;
     }
     aml_append(sb_scope, aml_name_decl(CPU_ON_BITMAP, pkg));
-    g_free(apic_ids);
-
     aml_append(ctx, sb_scope);
 
     method = aml_method("\\_GPE._E02", 0, AML_NOTSERIALIZED);
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index a1d781ae42..1c928abb28 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -332,7 +332,7 @@ build_fadt(GArray *table_data, BIOSLinker *linker, AcpiPmInfo *pm,
 }
 
 void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
-                       CPUArchIdList *apic_ids, GArray *entry)
+                       const CPUArchIdList *apic_ids, GArray *entry)
 {
     uint32_t apic_id = apic_ids->cpus[uid].arch_id;
 
@@ -373,7 +373,7 @@ static void
 build_madt(GArray *table_data, BIOSLinker *linker, PCMachineState *pcms)
 {
     MachineClass *mc = MACHINE_GET_CLASS(pcms);
-    CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(MACHINE(pcms));
+    const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(MACHINE(pcms));
     int madt_start = table_data->len;
     AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(pcms->acpi_dev);
     AcpiDeviceIf *adev = ACPI_DEVICE_IF(pcms->acpi_dev);
@@ -394,7 +394,6 @@ build_madt(GArray *table_data, BIOSLinker *linker, PCMachineState *pcms)
             x2apic_mode = true;
         }
     }
-    g_free(apic_ids);
 
     io_apic = acpi_data_push(table_data, sizeof *io_apic);
     io_apic->type = ACPI_APIC_IO;
@@ -2294,7 +2293,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
     int srat_start, numa_start, slots;
     uint64_t mem_len, mem_base, next_base;
     MachineClass *mc = MACHINE_GET_CLASS(machine);
-    CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(machine);
+    const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(machine);
     PCMachineState *pcms = PC_MACHINE(machine);
     ram_addr_t hotplugabble_address_space_size =
         object_property_get_int(OBJECT(pcms), PC_MACHINE_MEMHP_REGION_SIZE,
@@ -2393,7 +2392,6 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
                  (void *)(table_data->data + srat_start),
                  "SRAT",
                  table_data->len - srat_start, 1, NULL, NULL);
-    g_free(apic_ids);
 }
 
 static void
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 079346ac5d..c949cf0ecc 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2240,15 +2240,11 @@ static unsigned pc_cpu_index_to_socket_id(unsigned cpu_index)
     return topo.pkg_id;
 }
 
-static CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *machine)
+static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *machine)
 {
     PCMachineState *pcms = PC_MACHINE(machine);
-    int len = sizeof(CPUArchIdList) +
-              sizeof(CPUArchId) * (pcms->possible_cpus->len);
-    CPUArchIdList *list = g_malloc(len);
-
-    memcpy(list, pcms->possible_cpus, len);
-    return list;
+    assert(pcms->possible_cpus);
+    return pcms->possible_cpus;
 }
 
 static HotpluggableCPUList *pc_query_hotpluggable_cpus(MachineState *machine)
diff --git a/stubs/pc_madt_cpu_entry.c b/stubs/pc_madt_cpu_entry.c
index 427e772868..f88d6a090b 100644
--- a/stubs/pc_madt_cpu_entry.c
+++ b/stubs/pc_madt_cpu_entry.c
@@ -2,6 +2,6 @@
 #include "hw/i386/pc.h"
 
 void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
-                       CPUArchIdList *apic_ids, GArray *entry)
+                       const CPUArchIdList *apic_ids, GArray *entry)
 {
 }
-- 
2.11.0.259.g40922b1
