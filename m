Received: from eggs.gnu.org ([2001:4830:134:3::10]:56850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cTtnv-00022q-B0
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:13:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cTtnt-0007H2-Kr
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:13:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cTtnt-0007GS-CJ
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:13:45 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 18 Jan 2017 18:13:20 +0100
Message-Id: <1484759609-264075-5-git-send-email-imammedo@redhat.com>
In-Reply-To: <1484759609-264075-1-git-send-email-imammedo@redhat.com>
References: <1484759609-264075-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [RFC 04/13] make possible_cpu_arch_ids() return const
 pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>, fanc.fnst@cn.fujitsu.com, caoj.fnst@cn.fujitsu.com, stefanha@redhat.com, izumi.taku@jp.fujitsu.com, vilanova@ac.upc.edu, ehabkost@redhat.com, peter.maydell@linaro.org, Andrew Jones <drjones@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>

make sure that external callers won't try to modify
possible_cpus and owner of possible_cpus can access
it directly when it modifies it.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
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
index 901a4ae..71d3c48 100644
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
index a51da9c..ac891a8 100644
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
index b22e699..f4a5941 100644
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
index 5ac89fe..6017ca0 100644
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
index f15a240..5243918 100644
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
index 0c8912f..0c91043 100644
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
index c0eba8a..a2ab7fb 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2245,15 +2245,11 @@ static unsigned pc_cpu_index_to_socket_id(unsigned cpu_index)
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
index 427e772..f88d6a0 100644
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
2.7.4
