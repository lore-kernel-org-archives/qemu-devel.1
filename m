Received: from eggs.gnu.org ([2001:4830:134:3::10]:47217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1fGKYy-0004oW-OZ
	for qemu-devel@nongnu.org; Wed, 09 May 2018 04:35:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1fGKYu-0006y3-Gj
	for qemu-devel@nongnu.org; Wed, 09 May 2018 04:35:04 -0400
Received: from mga02.intel.com ([134.134.136.20]:46402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jingqi.liu@intel.com>)
	id 1fGKYu-0006vY-3n
	for qemu-devel@nongnu.org; Wed, 09 May 2018 04:35:00 -0400
From: Liu Jingqi <jingqi.liu@intel.com>
Date: Wed,  9 May 2018 16:34:29 +0800
Message-Id: <1525854869-13975-1-git-send-email-jingqi.liu@intel.com>
Subject: [Qemu-devel] [PATCH v1 1/7] hmat acpi: Build Memory Subsystem
 Address Range Structre(s) in ACPI HMAT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
Cc: mst@redhat.com, imammedo@redhat.com, marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org, Liu Jingqi <jingqi.liu@intel.com>

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
---
 default-configs/x86_64-softmmu.mak |   1 +
 hw/acpi/Makefile.objs              |   1 +
 hw/acpi/hmat.c                     | 174 +++++++++++++++++++++++++++++++++++++
 hw/acpi/hmat.h                     |  75 ++++++++++++++++
 hw/i386/acpi-build.c               |   3 +
 5 files changed, 254 insertions(+)
 create mode 100644 hw/acpi/hmat.c
 create mode 100644 hw/acpi/hmat.h

diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_64-softmmu.mak
index 0390b43..3b4a37d 100644
--- a/default-configs/x86_64-softmmu.mak
+++ b/default-configs/x86_64-softmmu.mak
@@ -66,3 +66,4 @@ CONFIG_I2C=y
 CONFIG_SEV=$(CONFIG_KVM)
 CONFIG_VTD=y
 CONFIG_AMD_IOMMU=y
+CONFIG_ACPI_HMAT=y
diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
index 11c35bc..21889fd 100644
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
index 0000000..bca1fbb
--- /dev/null
+++ b/hw/acpi/hmat.c
@@ -0,0 +1,174 @@
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
+#include "unistd.h"
+#include "fcntl.h"
+#include "qemu/osdep.h"
+#include "sysemu/numa.h"
+#include "hw/i386/pc.h"
+#include "hw/acpi/acpi.h"
+#include "hw/acpi/hmat.h"
+#include "hw/acpi/aml-build.h"
+#include "hw/nvram/fw_cfg.h"
+#include "hw/acpi/bios-linker-loader.h"
+
+#define HOLE_640K_START  (640 * 1024)
+#define HOLE_640K_END    (1024 * 1024)
+
+uint32_t initiator_pxm[MAX_NODES], target_pxm[MAX_NODES];
+uint32_t num_initiator = 0, num_target = 0;
+
+static void hmat_build_spa_info(AcpiHmatSpaRange *spa,
+                                uint64_t base, uint64_t length, int node)
+{
+    int i;
+
+    spa->type       = ACPI_HMAT_SPA;
+    spa->length     = sizeof(*spa);
+    spa->spa_base   = base;
+    spa->spa_length = length;
+    spa->flags      = 0;
+
+    for (i = 0; i < num_initiator; i++) {
+        if (initiator_pxm[i] == node) {
+            spa->proc_proximity = node;
+            spa->flags |= HMAT_SPA_PROC_VALID;
+            break;
+        }
+    }
+
+    for (i = 0; i < num_target; i++) {
+        if (target_pxm[i] == node) {
+            spa->mem_proximity = node;
+            spa->flags |= HMAT_SPA_MEM_VALID;
+            break;
+        }
+    }
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
+    AcpiHmatSpaRange *hmat_spa;
+    uint64_t mem_base, next_base, mem_len;
+    int node;
+
+    next_base = 0;
+    for (node = 0; node < nb_numa_nodes; node++) {
+        mem_len = numa_info[node].node_mem;
+        if (!mem_len) {
+            continue;
+        }
+
+        mem_base = next_base;
+        next_base = mem_base + mem_len;
+
+        /* Cut out the 640K hole */
+        if (mem_base <= HOLE_640K_START &&
+            next_base > HOLE_640K_START) {
+            mem_len -= next_base - HOLE_640K_START;
+            if (mem_len > 0) {
+                hmat_spa = acpi_data_push(table_data, sizeof(*hmat_spa));
+                hmat_build_spa_info(hmat_spa, mem_base, mem_len, node);
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
+                hmat_spa = acpi_data_push(table_data, sizeof(*hmat_spa));
+                hmat_build_spa_info(hmat_spa, mem_base, mem_len, node);
+            }
+            mem_base = 1ULL << 32;
+            mem_len = next_base - pcms->below_4g_mem_size;
+            next_base = mem_base + mem_len;
+        }
+        hmat_spa = acpi_data_push(table_data, sizeof(*hmat_spa));
+        hmat_build_spa_info(hmat_spa, mem_base, mem_len, node);
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
+        node = object_property_get_uint(OBJECT(dimm), PC_DIMM_NODE_PROP, NULL);
+
+        hmat_spa = acpi_data_push(table_data, sizeof(*hmat_spa));
+        hmat_build_spa_info(hmat_spa, mem_base, mem_len, node);
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
+    acpi_data_push(table_data, sizeof(AcpiHmat));
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
index 0000000..841c698
--- /dev/null
+++ b/hw/acpi/hmat.h
@@ -0,0 +1,75 @@
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
+/*
+ * HMAT (Heterogeneous Memory Attributes Table)
+ */
+struct AcpiHmat {
+    ACPI_TABLE_HEADER_DEF
+    uint32_t    reserved;
+} QEMU_PACKED;
+typedef struct AcpiHmat AcpiHmat;
+
+struct AcpiHmatSpaRange {
+    ACPI_HMAT_SUB_HEADER_DEF
+    uint16_t    flags;
+    uint16_t    reserved1;
+    uint32_t    proc_proximity;
+    uint32_t    mem_proximity;
+    uint32_t    reserved2;
+    uint64_t    spa_base;
+    uint64_t    spa_length;
+} QEMU_PACKED;
+typedef struct AcpiHmatSpaRange AcpiHmatSpaRange;
+
+extern uint32_t initiator_pxm[MAX_NODES], target_pxm[MAX_NODES];
+extern uint32_t num_initiator, num_target;
+void hmat_build_acpi(GArray *table_data, BIOSLinker *linker,
+                     MachineState *machine);
+
+#endif
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 9bc6d97..0f9fbe4 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -64,6 +64,7 @@
 #include "hw/i386/intel_iommu.h"
 
 #include "hw/acpi/ipmi.h"
+#include "hw/acpi/hmat.h"
 
 /* These are used to size the ACPI tables for -M pc-i440fx-1.7 and
  * -M pc-i440fx-2.0.  Even if the actual amount of AML generated grows
@@ -2713,6 +2714,8 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
             acpi_add_table(table_offsets, tables_blob);
             build_slit(tables_blob, tables->linker);
         }
+        acpi_add_table(table_offsets, tables_blob);
+        hmat_build_acpi(tables_blob, tables->linker, machine);
     }
     if (acpi_get_mcfg(&mcfg)) {
         acpi_add_table(table_offsets, tables_blob);
-- 
2.7.4
