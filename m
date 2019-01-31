Received: from eggs.gnu.org ([209.51.188.92]:33424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1gp6ce-0006yy-Hq
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:18:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1gp6cc-000395-FF
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:18:52 -0500
Received: from mga07.intel.com ([134.134.136.100]:58183)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1gp6cc-000313-3M
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:18:50 -0500
From: Tao Xu <tao3.xu@intel.com>
Date: Thu, 31 Jan 2019 15:16:51 +0800
Message-Id: <20190131071658.29120-2-tao3.xu@intel.com>
In-Reply-To: <20190131071658.29120-1-tao3.xu@intel.com>
References: <20190131071658.29120-1-tao3.xu@intel.com>
Subject: [Qemu-devel] [PATCH v3 1/8] hmat acpi: Build Memory Subsystem
 Address Range Structure(s) in ACPI HMAT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eblake@redhat.com, mst@redhat.com, imammedo@redhat.com, xiaoguangrong.eric@gmail.com
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, karl.heubaum@oracle.com, jingqi.liu@intel.com, danmei.wei@intel.com, qemu-devel@nongnu.org, tao3.xu@intel.com

From: Liu Jingqi <jingqi.liu@intel.com>

HMAT is defined in ACPI 6.2: 5.2.27 Heterogeneous Memory Attribute Table (HMAT).
The specification references below link:
http://www.uefi.org/sites/default/files/resources/ACPI_6_2.pdf

It describes the memory attributes, such as memory side cache
attributes and bandwidth and latency details, related to the
System Physical Address (SPA) Memory Ranges. The software is
expected to use this information as hint for optimization.

This structure describes the System Physical Address(SPA) range
occupied by memory subsystem and its associativity with processor
proximity domain as well as hint for memory usage.

Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
---
 default-configs/i386-softmmu.mak |   1 +
 hw/acpi/Makefile.objs            |   1 +
 hw/acpi/hmat.c                   | 134 +++++++++++++++++++++++++++++++
 hw/acpi/hmat.h                   |  52 ++++++++++++
 hw/i386/acpi-build.c             | 123 +++++++++++++++++-----------
 hw/i386/acpi-build.h             |  10 +++
 include/sysemu/numa.h            |   2 +
 numa.c                           |   6 ++
 8 files changed, 284 insertions(+), 45 deletions(-)
 create mode 100644 hw/acpi/hmat.c
 create mode 100644 hw/acpi/hmat.h

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index 64c998c4c8..3b77640f9d 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -67,3 +67,4 @@ CONFIG_I2C=y
 CONFIG_SEV=$(CONFIG_KVM)
 CONFIG_VTD=y
 CONFIG_AMD_IOMMU=y
+CONFIG_ACPI_HMAT=y
diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
index 2d46e3789a..932ba42d13 100644
--- a/hw/acpi/Makefile.objs
+++ b/hw/acpi/Makefile.objs
@@ -6,6 +6,7 @@ common-obj-$(CONFIG_ACPI_MEMORY_HOTPLUG) += memory_hotplug.o
 common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) += cpu.o
 common-obj-$(CONFIG_ACPI_NVDIMM) += nvdimm.o
 common-obj-$(CONFIG_ACPI_VMGENID) += vmgenid.o
+common-obj-$(CONFIG_ACPI_HMAT) += hmat.o
 common-obj-$(call lnot,$(CONFIG_ACPI_X86)) += acpi-stub.o
 
 common-obj-y += acpi_interface.o
diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
new file mode 100644
index 0000000000..7e0fc0a9ae
--- /dev/null
+++ b/hw/acpi/hmat.c
@@ -0,0 +1,134 @@
+/*
+ * HMAT ACPI Implementation
+ *
+ * Copyright(C) 2018 Intel Corporation.
+ *
+ * Author:
+ *  Liu jingqi <jingqi.liu@linux.intel.com>
+ *
+ * HMAT is defined in ACPI 6.2.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>
+ */
+
+#include "qemu/osdep.h"
+#include "sysemu/numa.h"
+#include "hw/i386/pc.h"
+#include "hw/i386/acpi-build.h"
+#include "hw/acpi/hmat.h"
+#include "hw/nvram/fw_cfg.h"
+
+/* Build Memory Subsystem Address Range Structure */
+static void build_hmat_spa(GArray *table_data,
+                                uint64_t base, uint64_t length, int node)
+{
+    uint16_t flags = 0;
+
+    if (numa_info[node].is_initiator) {
+        flags |= HMAT_SPA_PROC_VALID;
+    }
+    if (numa_info[node].is_target) {
+        flags |= HMAT_SPA_MEM_VALID;
+    }
+
+    /* Memory Subsystem Address Range Structure */
+    /* Type */
+    build_append_int_noprefix(table_data, 0, 2);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 2);
+    /* Length */
+    build_append_int_noprefix(table_data, 40, 4);
+    /* Flags */
+    build_append_int_noprefix(table_data, flags, 2);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 2);
+    /* Process Proximity Domain */
+    build_append_int_noprefix(table_data, node, 4);
+    /* Memory Proximity Domain */
+    build_append_int_noprefix(table_data, node, 4);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 4);
+    /* System Physical Address Range Base */
+    build_append_int_noprefix(table_data, base, 8);
+    /* System Physical Address Range Length */
+    build_append_int_noprefix(table_data, length, 8);
+}
+
+static int pc_dimm_device_list(Object *obj, void *opaque)
+{
+    GSList **list = opaque;
+
+    if (object_dynamic_cast(obj, TYPE_PC_DIMM)) {
+        *list = g_slist_append(*list, DEVICE(obj));
+    }
+
+    object_child_foreach(obj, pc_dimm_device_list, opaque);
+    return 0;
+}
+
+/*
+ * The Proximity Domain of System Physical Address ranges defined
+ * in the HMAT, NFIT and SRAT tables shall match each other.
+ */
+static void hmat_build_spa(GArray *table_data, PCMachineState *pcms)
+{
+    GSList *device_list = NULL;
+    uint64_t mem_base, mem_len;
+    int i;
+
+    if (pcms->numa_nodes && !mem_ranges_number) {
+        build_mem_ranges(pcms);
+    }
+
+    for (i = 0; i < mem_ranges_number; i++) {
+        hmat_build_spa_info(table_data, mem_ranges[i].base,
+                            mem_ranges[i].length, mem_ranges[i].node);
+    }
+
+    /* Build HMAT SPA structures for PC-DIMM devices. */
+    object_child_foreach(qdev_get_machine(), pc_dimm_device_list, &device_list);
+
+    for (; device_list; device_list = device_list->next) {
+        PCDIMMDevice *dimm = device_list->data;
+        mem_base = object_property_get_uint(OBJECT(dimm), PC_DIMM_ADDR_PROP,
+                                            NULL);
+        mem_len = object_property_get_uint(OBJECT(dimm), PC_DIMM_SIZE_PROP,
+                                           NULL);
+        i = object_property_get_uint(OBJECT(dimm), PC_DIMM_NODE_PROP, NULL);
+        hmat_build_spa_info(table_data, mem_base, mem_len, i);
+    }
+}
+
+static void hmat_build_hma(GArray *hma, PCMachineState *pcms)
+{
+    /* Build HMAT Memory Subsystem Address Range. */
+    hmat_build_spa(hma, pcms);
+}
+
+void hmat_build_acpi(GArray *table_data, BIOSLinker *linker,
+                     MachineState *machine)
+{
+    PCMachineState *pcms = PC_MACHINE(machine);
+    uint64_t hmat_start, hmat_len;
+
+    hmat_start = table_data->len;
+    acpi_data_push(table_data, 40);
+
+    hmat_build_hma(table_data, pcms);
+    hmat_len = table_data->len - hmat_start;
+
+    build_header(linker, table_data,
+                 (void *)(table_data->data + hmat_start),
+                 "HMAT", hmat_len, 1, NULL, NULL);
+}
diff --git a/hw/acpi/hmat.h b/hw/acpi/hmat.h
new file mode 100644
index 0000000000..f216e658c4
--- /dev/null
+++ b/hw/acpi/hmat.h
@@ -0,0 +1,52 @@
+/*
+ * HMAT ACPI Implementation Header
+ *
+ * Copyright(C) 2018 Intel Corporation.
+ *
+ * Author:
+ *  Liu jingqi <jingqi.liu@linux.intel.com>
+ *
+ * HMAT is defined in ACPI 6.2.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>
+ */
+
+#ifndef HMAT_H
+#define HMAT_H
+
+#include "qemu/osdep.h"
+#include "hw/acpi/acpi-defs.h"
+#include "hw/acpi/acpi.h"
+#include "hw/acpi/bios-linker-loader.h"
+#include "hw/acpi/aml-build.h"
+
+#define ACPI_HMAT_SPA               0
+
+/* ACPI HMAT sub-structure header */
+#define ACPI_HMAT_SUB_HEADER_DEF    \
+    uint16_t  type;                 \
+    uint16_t  reserved0;            \
+    uint32_t  length;
+
+/* the values of AcpiHmatSpaRange flag */
+enum {
+    HMAT_SPA_PROC_VALID = 0x1,
+    HMAT_SPA_MEM_VALID  = 0x2,
+    HMAT_SPA_RESERVATION_HINT = 0x4,
+};
+
+void hmat_build_acpi(GArray *table_data, BIOSLinker *linker,
+                     MachineState *machine);
+
+#endif
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 2e21a31f82..4187a947d2 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -64,6 +64,7 @@
 #include "hw/i386/intel_iommu.h"
 
 #include "hw/acpi/ipmi.h"
+#include "hw/acpi/hmat.h"
 
 /* These are used to size the ACPI tables for -M pc-i440fx-1.7 and
  * -M pc-i440fx-2.0.  Even if the actual amount of AML generated grows
@@ -125,6 +126,15 @@ typedef struct FwCfgTPMConfig {
     uint8_t tpmppi_version;
 } QEMU_PACKED FwCfgTPMConfig;
 
+/*
+ * The memory contains at least one hole
+ * from 640k-1M and possibly another one from 3.5G-4G.
+ * So far, the number of memory ranges is up to 2
+ * more than the number of numa nodes.
+ */
+MemoryRange mem_ranges[MAX_NODES + 2];
+uint32_t mem_ranges_number;
+
 static void init_common_fadt_data(Object *o, AcpiFadtData *data)
 {
     uint32_t io = object_property_get_uint(o, ACPI_PM_PROP_PM_IO_BASE, NULL);
@@ -2263,6 +2273,64 @@ build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
 #define HOLE_640K_START  (640 * KiB)
 #define HOLE_640K_END   (1 * MiB)
 
+void build_mem_ranges(PCMachineState *pcms)
+{
+    uint64_t mem_len, mem_base, next_base;
+    int i;
+
+    /*
+     * the memory map is a bit tricky, it contains at least one hole
+     * from 640k-1M and possibly another one from 3.5G-4G.
+     */
+    mem_ranges_number = 0;
+    next_base = 0;
+
+    for (i = 0; i < pcms->numa_nodes; ++i) {
+        mem_base = next_base;
+        mem_len = pcms->node_mem[i];
+        next_base = mem_base + mem_len;
+
+        /* Cut out the 640K hole */
+        if (mem_base <= HOLE_640K_START &&
+            next_base > HOLE_640K_START) {
+            mem_len -= next_base - HOLE_640K_START;
+            if (mem_len > 0) {
+                mem_ranges[mem_ranges_number].base = mem_base;
+                mem_ranges[mem_ranges_number].length = mem_len;
+                mem_ranges[mem_ranges_number].node = i;
+                mem_ranges_number++;
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
+        if (mem_base <= pcms->below_4g_mem_size &&
+            next_base > pcms->below_4g_mem_size) {
+            mem_len -= next_base - pcms->below_4g_mem_size;
+            if (mem_len > 0) {
+                mem_ranges[mem_ranges_number].base = mem_base;
+                mem_ranges[mem_ranges_number].length = mem_len;
+                mem_ranges[mem_ranges_number].node = i;
+                mem_ranges_number++;
+            }
+            mem_base = 1ULL << 32;
+            mem_len = next_base - pcms->below_4g_mem_size;
+            next_base = mem_base + mem_len;
+        }
+        mem_ranges[mem_ranges_number].base = mem_base;
+        mem_ranges[mem_ranges_number].length = mem_len;
+        mem_ranges[mem_ranges_number].node = i;
+        mem_ranges_number++;
+    }
+}
+
 static void
 build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
 {
@@ -2271,7 +2339,6 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
 
     int i;
     int srat_start, numa_start, slots;
-    uint64_t mem_len, mem_base, next_base;
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(machine);
     PCMachineState *pcms = PC_MACHINE(machine);
@@ -2311,54 +2378,18 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
         }
     }
 
+    if (pcms->numa_nodes && !mem_ranges_number) {
+        build_mem_ranges(pcms);
+    }
 
-    /* the memory map is a bit tricky, it contains at least one hole
-     * from 640k-1M and possibly another one from 3.5G-4G.
-     */
-    next_base = 0;
     numa_start = table_data->len;
 
-    for (i = 1; i < pcms->numa_nodes + 1; ++i) {
-        mem_base = next_base;
-        mem_len = pcms->node_mem[i - 1];
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
-        if (mem_base <= pcms->below_4g_mem_size &&
-            next_base > pcms->below_4g_mem_size) {
-            mem_len -= next_base - pcms->below_4g_mem_size;
-            if (mem_len > 0) {
+    for (i = 0; i < mem_ranges_number; i++) {
+        if (mem_ranges[i].length > 0) {
                 numamem = acpi_data_push(table_data, sizeof *numamem);
-                build_srat_memory(numamem, mem_base, mem_len, i - 1,
-                                  MEM_AFFINITY_ENABLED);
-            }
-            mem_base = 1ULL << 32;
-            mem_len = next_base - pcms->below_4g_mem_size;
-            next_base = mem_base + mem_len;
-        }
-
-        if (mem_len > 0) {
-            numamem = acpi_data_push(table_data, sizeof *numamem);
-            build_srat_memory(numamem, mem_base, mem_len, i - 1,
+            build_srat_memory(numamem, mem_ranges[i].base,
+                              mem_ranges[i].length,
+                              mem_ranges[i].node,
                               MEM_AFFINITY_ENABLED);
         }
     }
@@ -2681,6 +2712,8 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
             acpi_add_table(table_offsets, tables_blob);
             build_slit(tables_blob, tables->linker);
         }
+        acpi_add_table(table_offsets, tables_blob);
+        hmat_build_acpi(tables_blob, tables->linker, machine);
     }
     if (acpi_get_mcfg(&mcfg)) {
         acpi_add_table(table_offsets, tables_blob);
diff --git a/hw/i386/acpi-build.h b/hw/i386/acpi-build.h
index 007332e51c..f17de6af6a 100644
--- a/hw/i386/acpi-build.h
+++ b/hw/i386/acpi-build.h
@@ -2,6 +2,16 @@
 #ifndef HW_I386_ACPI_BUILD_H
 #define HW_I386_ACPI_BUILD_H
 
+typedef struct memory_range {
+    uint64_t base;
+    uint64_t length;
+    uint32_t node;
+} MemoryRange;
+
+extern MemoryRange mem_ranges[];
+extern uint32_t mem_ranges_number;
+
+void build_mem_ranges(PCMachineState *pcms);
 void acpi_setup(void);
 
 #endif
diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index b6ac7de43e..d41be00b92 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -13,6 +13,8 @@ struct NodeInfo {
     uint64_t node_mem;
     struct HostMemoryBackend *node_memdev;
     bool present;
+    bool is_initiator;
+    bool is_target;
     uint8_t distance[MAX_NODES];
 };
 
diff --git a/numa.c b/numa.c
index 50ec016013..9ee4f6f258 100644
--- a/numa.c
+++ b/numa.c
@@ -105,6 +105,10 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
         }
     }
 
+    if (node->cpus) {
+        numa_info[nodenr].is_initiator = true;
+    }
+
     if (node->has_mem && node->has_memdev) {
         error_setg(errp, "cannot specify both mem= and memdev=");
         return;
@@ -121,6 +125,7 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
 
     if (node->has_mem) {
         numa_info[nodenr].node_mem = node->mem;
+        numa_info[nodenr].is_target = true;
     }
     if (node->has_memdev) {
         Object *o;
@@ -133,6 +138,7 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
         object_ref(o);
         numa_info[nodenr].node_mem = object_property_get_uint(o, "size", NULL);
         numa_info[nodenr].node_memdev = MEMORY_BACKEND(o);
+        numa_info[nodenr].is_target = true;
     }
     numa_info[nodenr].present = true;
     max_numa_nodeid = MAX(max_numa_nodeid, nodenr + 1);
-- 
2.17.1
