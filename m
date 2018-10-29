Received: from eggs.gnu.org ([2001:4830:134:3::10]:47540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gHAxF-0002GT-F3
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:03:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gHAxD-0004qy-NU
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:03:53 -0400
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Mon, 29 Oct 2018 18:01:53 +0100
Message-Id: <20181029170159.3801-14-sameo@linux.intel.com>
In-Reply-To: <20181029170159.3801-1-sameo@linux.intel.com>
References: <20181029170159.3801-1-sameo@linux.intel.com>
Subject: [Qemu-devel] [PATCH v3 13/19] hw: acpi: Export the SRAT AML build
 API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yang Zhong <yang.zhong@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "open list:ARM ACPI Subsystem" <qemu-arm@nongnu.org>

From: Yang Zhong <yang.zhong@intel.com>

The SRAT ACPI table is not x86 specific and will be needed for the
Hardware-reduced ACPI implementation. So we should export it through the
architecture independent hw/acpi folder.

Also, now that the generic build_srat() API is exported, we have to
rename the ARM static one in order to avoid build time conflicts.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 hw/acpi/aml-build.c         | 130 ++++++++++++++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c    |   4 +-
 hw/i386/acpi-build.c        | 129 -----------------------------------
 include/hw/acpi/aml-build.h |   3 +
 4 files changed, 135 insertions(+), 131 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 2110e18799..c3f652a68f 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -22,6 +22,7 @@
 #include "qemu/osdep.h"
 #include <glib/gprintf.h>
 #include "hw/acpi/aml-build.h"
+#include "hw/mem/memory-device.h"
 #include "qemu/bswap.h"
 #include "qemu/bitops.h"
 #include "sysemu/numa.h"
@@ -2459,6 +2460,135 @@ void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_t base,
     numamem->range_length = cpu_to_le64(len);
 }
 
+#define HOLE_640K_START  (640 * KiB)
+#define HOLE_640K_END   (1 * MiB)
+
+void
+build_srat(GArray *table_data, BIOSLinker *linker,
+           MachineState *machine, AcpiConfiguration *conf)
+{
+    AcpiSystemResourceAffinityTable *srat;
+    AcpiSratMemoryAffinity *numamem;
+
+    int i;
+    int srat_start, numa_start, slots;
+    uint64_t mem_len, mem_base, next_base;
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(machine);
+    ram_addr_t hotplugabble_address_space_size =
+        object_property_get_int(OBJECT(machine), MEMORY_DEVICE_REGION_SIZE,
+                                NULL);
+
+    srat_start = table_data->len;
+
+    srat = acpi_data_push(table_data, sizeof *srat);
+    srat->reserved1 = cpu_to_le32(1);
+
+    for (i = 0; i < apic_ids->len; i++) {
+        int node_id = apic_ids->cpus[i].props.node_id;
+        uint32_t apic_id = apic_ids->cpus[i].arch_id;
+
+        if (apic_id < 255) {
+            AcpiSratProcessorAffinity *core;
+
+            core = acpi_data_push(table_data, sizeof *core);
+            core->type = ACPI_SRAT_PROCESSOR_APIC;
+            core->length = sizeof(*core);
+            core->local_apic_id = apic_id;
+            core->proximity_lo = node_id;
+            memset(core->proximity_hi, 0, 3);
+            core->local_sapic_eid = 0;
+            core->flags = cpu_to_le32(1);
+        } else {
+            AcpiSratProcessorX2ApicAffinity *core;
+
+            core = acpi_data_push(table_data, sizeof *core);
+            core->type = ACPI_SRAT_PROCESSOR_x2APIC;
+            core->length = sizeof(*core);
+            core->x2apic_id = cpu_to_le32(apic_id);
+            core->proximity_domain = cpu_to_le32(node_id);
+            core->flags = cpu_to_le32(1);
+        }
+    }
+
+
+    /* the memory map is a bit tricky, it contains at least one hole
+     * from 640k-1M and possibly another one from 3.5G-4G.
+     */
+    next_base = 0;
+    numa_start = table_data->len;
+
+    for (i = 1; i < conf->numa_nodes + 1; ++i) {
+        mem_base = next_base;
+        mem_len = conf->node_mem[i - 1];
+        next_base = mem_base + mem_len;
+
+        /* Cut out the 640K hole */
+        if (mem_base <= HOLE_640K_START &&
+            next_base > HOLE_640K_START) {
+            mem_len -= next_base - HOLE_640K_START;
+            if (mem_len > 0) {
+                numamem = acpi_data_push(table_data, sizeof *numamem);
+                build_srat_memory(numamem, mem_base, mem_len, i - 1,
+                                  MEM_AFFINITY_ENABLED);
+            }
+
+            /* Check for the rare case: 640K < RAM < 1M */
+            if (next_base <= HOLE_640K_END) {
+                next_base = HOLE_640K_END;
+                continue;
+            }
+            mem_base = HOLE_640K_END;
+            mem_len = next_base - HOLE_640K_END;
+        }
+
+        /* Cut out the ACPI_PCI hole */
+        if (mem_base <= conf->below_4g_mem_size &&
+            next_base > conf->below_4g_mem_size) {
+            mem_len -= next_base - conf->below_4g_mem_size;
+            if (mem_len > 0) {
+                numamem = acpi_data_push(table_data, sizeof *numamem);
+                build_srat_memory(numamem, mem_base, mem_len, i - 1,
+                                  MEM_AFFINITY_ENABLED);
+            }
+            mem_base = 1ULL << 32;
+            mem_len = next_base - conf->below_4g_mem_size;
+            next_base = mem_base + mem_len;
+        }
+
+        if (mem_len > 0) {
+            numamem = acpi_data_push(table_data, sizeof *numamem);
+            build_srat_memory(numamem, mem_base, mem_len, i - 1,
+                              MEM_AFFINITY_ENABLED);
+        }
+    }
+    slots = (table_data->len - numa_start) / sizeof *numamem;
+    for (; slots < conf->numa_nodes + 2; slots++) {
+        numamem = acpi_data_push(table_data, sizeof *numamem);
+        build_srat_memory(numamem, 0, 0, 0, MEM_AFFINITY_NOFLAGS);
+    }
+
+    /*
+     * Entry is required for Windows to enable memory hotplug in OS
+     * and for Linux to enable SWIOTLB when booted with less than
+     * 4G of RAM. Windows works better if the entry sets proximity
+     * to the highest NUMA node in the machine.
+     * Memory devices may override proximity set by this entry,
+     * providing _PXM method if necessary.
+     */
+    if (hotplugabble_address_space_size) {
+        numamem = acpi_data_push(table_data, sizeof *numamem);
+        build_srat_memory(numamem, machine->device_memory->base,
+                          hotplugabble_address_space_size, conf->numa_nodes - 1,
+                          MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
+    }
+
+    build_header(linker, table_data,
+                 (void *)(table_data->data + srat_start),
+                 "SRAT",
+                 table_data->len - srat_start, 1, NULL, NULL);
+}
+
 /*
  * ACPI spec 5.2.17 System Locality Distance Information Table
  * (Revision 2.0 or later)
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index f9a60907f1..353aa55357 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -469,7 +469,7 @@ build_spcr(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 }
 
 static void
-build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
+virt_build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
     AcpiSystemResourceAffinityTable *srat;
     AcpiSratProcessorGiccAffinity *core;
@@ -759,7 +759,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
 
     if (nb_numa_nodes > 0) {
         acpi_add_table(table_offsets, tables_blob);
-        build_srat(tables_blob, tables->linker, vms);
+        virt_build_srat(tables_blob, tables->linker, vms);
         if (have_numa_distance) {
             acpi_add_table(table_offsets, tables_blob);
             build_slit(tables_blob, tables->linker);
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index dfc02a8a85..5932dbe825 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1614,135 +1614,6 @@ build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
                  (void *)tpm2_ptr, "TPM2", sizeof(*tpm2_ptr), 4, NULL, NULL);
 }
 
-#define HOLE_640K_START  (640 * KiB)
-#define HOLE_640K_END   (1 * MiB)
-
-static void
-build_srat(GArray *table_data, BIOSLinker *linker,
-           MachineState *machine, AcpiConfiguration *conf)
-{
-    AcpiSystemResourceAffinityTable *srat;
-    AcpiSratMemoryAffinity *numamem;
-
-    int i;
-    int srat_start, numa_start, slots;
-    uint64_t mem_len, mem_base, next_base;
-    MachineClass *mc = MACHINE_GET_CLASS(machine);
-    const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(machine);
-    ram_addr_t hotplugabble_address_space_size =
-        object_property_get_int(OBJECT(machine), MEMORY_DEVICE_REGION_SIZE,
-                                NULL);
-
-    srat_start = table_data->len;
-
-    srat = acpi_data_push(table_data, sizeof *srat);
-    srat->reserved1 = cpu_to_le32(1);
-
-    for (i = 0; i < apic_ids->len; i++) {
-        int node_id = apic_ids->cpus[i].props.node_id;
-        uint32_t apic_id = apic_ids->cpus[i].arch_id;
-
-        if (apic_id < 255) {
-            AcpiSratProcessorAffinity *core;
-
-            core = acpi_data_push(table_data, sizeof *core);
-            core->type = ACPI_SRAT_PROCESSOR_APIC;
-            core->length = sizeof(*core);
-            core->local_apic_id = apic_id;
-            core->proximity_lo = node_id;
-            memset(core->proximity_hi, 0, 3);
-            core->local_sapic_eid = 0;
-            core->flags = cpu_to_le32(1);
-        } else {
-            AcpiSratProcessorX2ApicAffinity *core;
-
-            core = acpi_data_push(table_data, sizeof *core);
-            core->type = ACPI_SRAT_PROCESSOR_x2APIC;
-            core->length = sizeof(*core);
-            core->x2apic_id = cpu_to_le32(apic_id);
-            core->proximity_domain = cpu_to_le32(node_id);
-            core->flags = cpu_to_le32(1);
-        }
-    }
-
-
-    /* the memory map is a bit tricky, it contains at least one hole
-     * from 640k-1M and possibly another one from 3.5G-4G.
-     */
-    next_base = 0;
-    numa_start = table_data->len;
-
-    for (i = 1; i < conf->numa_nodes + 1; ++i) {
-        mem_base = next_base;
-        mem_len = conf->node_mem[i - 1];
-        next_base = mem_base + mem_len;
-
-        /* Cut out the 640K hole */
-        if (mem_base <= HOLE_640K_START &&
-            next_base > HOLE_640K_START) {
-            mem_len -= next_base - HOLE_640K_START;
-            if (mem_len > 0) {
-                numamem = acpi_data_push(table_data, sizeof *numamem);
-                build_srat_memory(numamem, mem_base, mem_len, i - 1,
-                                  MEM_AFFINITY_ENABLED);
-            }
-
-            /* Check for the rare case: 640K < RAM < 1M */
-            if (next_base <= HOLE_640K_END) {
-                next_base = HOLE_640K_END;
-                continue;
-            }
-            mem_base = HOLE_640K_END;
-            mem_len = next_base - HOLE_640K_END;
-        }
-
-        /* Cut out the ACPI_PCI hole */
-        if (mem_base <= conf->below_4g_mem_size &&
-            next_base > conf->below_4g_mem_size) {
-            mem_len -= next_base - conf->below_4g_mem_size;
-            if (mem_len > 0) {
-                numamem = acpi_data_push(table_data, sizeof *numamem);
-                build_srat_memory(numamem, mem_base, mem_len, i - 1,
-                                  MEM_AFFINITY_ENABLED);
-            }
-            mem_base = 1ULL << 32;
-            mem_len = next_base - conf->below_4g_mem_size;
-            next_base = mem_base + mem_len;
-        }
-
-        if (mem_len > 0) {
-            numamem = acpi_data_push(table_data, sizeof *numamem);
-            build_srat_memory(numamem, mem_base, mem_len, i - 1,
-                              MEM_AFFINITY_ENABLED);
-        }
-    }
-    slots = (table_data->len - numa_start) / sizeof *numamem;
-    for (; slots < conf->numa_nodes + 2; slots++) {
-        numamem = acpi_data_push(table_data, sizeof *numamem);
-        build_srat_memory(numamem, 0, 0, 0, MEM_AFFINITY_NOFLAGS);
-    }
-
-    /*
-     * Entry is required for Windows to enable memory hotplug in OS
-     * and for Linux to enable SWIOTLB when booted with less than
-     * 4G of RAM. Windows works better if the entry sets proximity
-     * to the highest NUMA node in the machine.
-     * Memory devices may override proximity set by this entry,
-     * providing _PXM method if necessary.
-     */
-    if (hotplugabble_address_space_size) {
-        numamem = acpi_data_push(table_data, sizeof *numamem);
-        build_srat_memory(numamem, machine->device_memory->base,
-                          hotplugabble_address_space_size, conf->numa_nodes - 1,
-                          MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
-    }
-
-    build_header(linker, table_data,
-                 (void *)(table_data->data + srat_start),
-                 "SRAT",
-                 table_data->len - srat_start, 1, NULL, NULL);
-}
-
 /*
  * VT-d spec 8.1 DMA Remapping Reporting Structure
  * (version Oct. 2014 or later)
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index 1fabf58df2..654ce2ec26 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -1,6 +1,7 @@
 #ifndef HW_ACPI_AML_BUILD_H
 #define HW_ACPI_AML_BUILD_H
 
+#include "hw/acpi/acpi.h"
 #include "hw/acpi/acpi-defs.h"
 #include "hw/acpi/bios-linker-loader.h"
 #include "hw/pci/pcie_host.h"
@@ -438,6 +439,8 @@ void
 build_xsdt(GArray *table_data, BIOSLinker *linker, GArray *table_offsets,
            const char *oem_id, const char *oem_table_id);
 
+void build_srat(GArray *table_data, BIOSLinker *linker,
+                MachineState *machine, AcpiConfiguration *conf);
 int
 build_append_named_dword(GArray *array, const char *name_format, ...)
 GCC_FMT_ATTR(2, 3);
-- 
2.17.2
