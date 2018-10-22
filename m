Received: from eggs.gnu.org ([2001:4830:134:3::10]:39504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gEf6Y-00017I-U7
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:39:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gEf6T-00051I-U4
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:39:06 -0400
Received: from mga01.intel.com ([192.55.52.88]:7889)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sameo@linux.intel.com>)
	id 1gEf6Q-0004iw-Bq
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:39:00 -0400
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Mon, 22 Oct 2018 20:36:48 +0200
Message-Id: <20181022183656.4902-19-sameo@linux.intel.com>
In-Reply-To: <20181022183656.4902-1-sameo@linux.intel.com>
References: <20181022183656.4902-1-sameo@linux.intel.com>
Subject: [Qemu-devel] [PATCH 18/26] hw: acpi: Initial hardware-reduced
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Ortiz <sameo@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

We build a minimal set of ACPI hardware-reduced tables: XSDT,
FADT, MADT and a DSDT pointed by a RSDP.
The DSDT only contains one PCI host bridge for now.

This API will be consumed by new x86 machine type but also potentially
by the ARM virt one.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
---
 default-configs/i386-softmmu.mak |   1 +
 hw/acpi/Makefile.objs            |   1 +
 hw/acpi/reduced.c                | 248 +++++++++++++++++++++++++++++++
 include/hw/acpi/reduced.h        |  24 +++
 4 files changed, 274 insertions(+)
 create mode 100644 hw/acpi/reduced.c
 create mode 100644 include/hw/acpi/reduced.h

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index 210cff2781..a80509a111 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -66,3 +66,4 @@ CONFIG_I2C=y
 CONFIG_SEV=$(CONFIG_KVM)
 CONFIG_VTD=y
 CONFIG_AMD_IOMMU=y
+CONFIG_ACPI_HW_REDUCED=y
diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
index 11c35bcb44..276e0cfbce 100644
--- a/hw/acpi/Makefile.objs
+++ b/hw/acpi/Makefile.objs
@@ -6,6 +6,7 @@ common-obj-$(CONFIG_ACPI_MEMORY_HOTPLUG) += memory_hotplug.o
 common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) += cpu.o
 common-obj-$(CONFIG_ACPI_NVDIMM) += nvdimm.o
 common-obj-$(CONFIG_ACPI_VMGENID) += vmgenid.o
+common-obj-$(CONFIG_ACPI_HW_REDUCED) += reduced.o
 common-obj-$(call lnot,$(CONFIG_ACPI_X86)) += acpi-stub.o
 
 common-obj-y += acpi_interface.o
diff --git a/hw/acpi/reduced.c b/hw/acpi/reduced.c
new file mode 100644
index 0000000000..364b105f58
--- /dev/null
+++ b/hw/acpi/reduced.c
@@ -0,0 +1,248 @@
+/* HW reduced ACPI support
+ *
+ * Copyright (c) 2018 Intel Corportation
+ * Copyright (C) 2013 Red Hat Inc
+ * Copyright (c) 2015 HUAWEI TECHNOLOGIES CO.,LTD.
+ * Copyright (C) 2008-2010  Kevin O'Connor <kevin@koconnor.net>
+ * Copyright (C) 2006 Fabrice Bellard
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/range.h"
+#include "qemu-common.h"
+
+#include "hw/acpi/acpi-defs.h"
+#include "hw/acpi/acpi.h"
+#include "hw/acpi/aml-build.h"
+#include "hw/acpi/bios-linker-loader.h"
+#include "hw/acpi/reduced.h"
+
+#include "hw/nvram/fw_cfg.h"
+
+#include "hw/pci/pcie_host.h"
+#include "hw/pci/pci.h"
+
+#include "hw/loader.h"
+#include "hw/hw.h"
+
+#include "sysemu/numa.h"
+
+#include "migration/vmstate.h"
+
+/* DSDT */
+static void build_dsdt(GArray *table_data, BIOSLinker *linker,
+                       AcpiPciBus *pci_host)
+{
+    Aml *scope, *dsdt;
+
+    dsdt = init_aml_allocator();
+    /* Reserve space for header */
+    acpi_data_push(dsdt->buf, sizeof(AcpiTableHeader));
+
+    scope = aml_scope("\\_SB");
+    if (pci_host->pci_bus) {
+        acpi_dsdt_add_pci_bus(dsdt, pci_host);
+    }
+    aml_append(dsdt, scope);
+
+    /* copy AML table into ACPI tables blob and patch header there */
+    g_array_append_vals(table_data, dsdt->buf->data, dsdt->buf->len);
+    build_header(linker, table_data,
+        (void *)(table_data->data + table_data->len - dsdt->buf->len),
+        "DSDT", dsdt->buf->len, 2, NULL, NULL);
+    free_aml_allocator();
+}
+
+
+static void build_fadt_reduced(GArray *table_data, BIOSLinker *linker,
+                               unsigned dsdt_tbl_offset)
+{
+    /* ACPI v5.1 */
+    AcpiFadtData fadt = {
+        .rev = 5,
+        .minor_ver = 1,
+        .flags = 1 << ACPI_FADT_F_HW_REDUCED_ACPI,
+        .dsdt_tbl_offset = &dsdt_tbl_offset,
+        .xdsdt_tbl_offset = &dsdt_tbl_offset,
+        .arm_boot_arch = 0,
+    };
+
+    build_fadt(table_data, linker, &fadt, NULL, NULL);
+}
+
+static void acpi_reduced_build(MachineState *ms, AcpiBuildTables *tables,
+                               AcpiConfiguration *conf)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    GArray *table_offsets;
+    unsigned dsdt, xsdt;
+    Range pci_hole, pci_hole64;
+    Object *pci_host;
+    PCIBus *bus = NULL;
+    GArray *tables_blob = tables->table_data;
+
+    acpi_get_pci_holes(&pci_hole, &pci_hole64);
+    table_offsets = g_array_new(false, true /* clear */,
+                                sizeof(uint32_t));
+
+    bios_linker_loader_alloc(tables->linker,
+                             ACPI_BUILD_TABLE_FILE, tables_blob,
+                             64, false /* high memory */);
+
+    pci_host = acpi_get_pci_host();
+    if (pci_host) {
+        bus = PCI_HOST_BRIDGE(pci_host)->bus;
+    }
+
+    AcpiPciBus acpi_pci_host = {
+        .pci_bus    = bus,
+        .pci_hole   = &pci_hole,
+        .pci_hole64 = &pci_hole64,
+    };
+
+    /* DSDT is pointed to by FADT */
+    dsdt = tables_blob->len;
+    build_dsdt(tables_blob, tables->linker, &acpi_pci_host);
+
+    /* FADT pointed to by RSDT */
+    acpi_add_table(table_offsets, tables_blob);
+    build_fadt_reduced(tables_blob, tables->linker, dsdt);
+
+    /* MADT pointed to by RSDT */
+    acpi_add_table(table_offsets, tables_blob);
+    mc->firmware_build_methods.acpi.madt(tables_blob, tables->linker, ms, conf);
+
+    /* RSDT is pointed to by RSDP */
+    xsdt = tables_blob->len;
+    build_xsdt(tables_blob, tables->linker, table_offsets, NULL, NULL);
+
+    /* RSDP is in FSEG memory, so allocate it separately */
+    mc->firmware_build_methods.acpi.rsdp(tables->rsdp, tables->linker, xsdt);
+    acpi_align_size(tables->linker->cmd_blob, ACPI_BUILD_ALIGN_SIZE);
+
+    /* Cleanup memory that's no longer used. */
+    g_array_free(table_offsets, true);
+}
+
+static void acpi_ram_update(MemoryRegion *mr, GArray *data)
+{
+    uint32_t size = acpi_data_len(data);
+
+    /* Make sure RAM size is correct - in case it got changed
+     * e.g. by migration */
+    memory_region_ram_resize(mr, size, &error_abort);
+
+    memcpy(memory_region_get_ram_ptr(mr), data->data, size);
+    memory_region_set_dirty(mr, 0, size);
+}
+
+static void acpi_reduced_build_update(void *build_opaque)
+{
+    MachineState *ms = MACHINE(build_opaque);
+    AcpiBuildState *build_state = ms->firmware_build_state.acpi.state;
+    AcpiConfiguration *conf = ms->firmware_build_state.acpi.conf;
+    AcpiBuildTables tables;
+
+    /* No ACPI configuration? Nothing to do. */
+    if (!conf) {
+        return;
+    }
+
+    /* No state to update or already patched? Nothing to do. */
+    if (!build_state || build_state->patched) {
+        return;
+    }
+    build_state->patched = true;
+
+    acpi_build_tables_init(&tables);
+
+    acpi_reduced_build(ms, &tables, conf);
+
+    acpi_ram_update(build_state->table_mr, tables.table_data);
+    acpi_ram_update(build_state->rsdp_mr, tables.rsdp);
+    acpi_ram_update(build_state->linker_mr, tables.linker->cmd_blob);
+
+    acpi_build_tables_cleanup(&tables, true);
+}
+
+static void acpi_reduced_build_reset(void *build_opaque)
+{
+    MachineState *ms = MACHINE(build_opaque);
+    AcpiBuildState *build_state = ms->firmware_build_state.acpi.state;
+
+    build_state->patched = false;
+}
+
+static MemoryRegion *acpi_add_rom_blob(MachineState *ms,
+                                       GArray *blob, const char *name,
+                                       uint64_t max_size)
+{
+    return rom_add_blob(name, blob->data, acpi_data_len(blob), max_size, -1,
+                        name, acpi_reduced_build_update, ms, NULL, true);
+}
+
+static const VMStateDescription vmstate_acpi_reduced_build = {
+    .name = "acpi_reduced_build",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_BOOL(patched, AcpiBuildState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+void acpi_reduced_setup(MachineState *machine, AcpiConfiguration *conf)
+{
+    AcpiBuildTables tables;
+    AcpiBuildState *build_state;
+
+    build_state = g_malloc0(sizeof(*build_state));
+    machine->firmware_build_state.acpi.state = build_state;
+    machine->firmware_build_state.acpi.conf = conf;
+
+    acpi_build_tables_init(&tables);
+    acpi_reduced_build(machine, &tables, conf);
+
+    if (conf->fw_cfg) {
+        /* Now expose it all to Guest */
+        build_state->table_mr = acpi_add_rom_blob(machine, tables.table_data,
+                                                  ACPI_BUILD_TABLE_FILE,
+                                                  ACPI_BUILD_TABLE_MAX_SIZE);
+        assert(build_state->table_mr != NULL);
+
+        build_state->linker_mr =
+            acpi_add_rom_blob(machine, tables.linker->cmd_blob,
+                              "etc/table-loader", 0);
+
+        fw_cfg_add_file(conf->fw_cfg, ACPI_BUILD_TPMLOG_FILE,
+                        tables.tcpalog->data,
+                        acpi_data_len(tables.tcpalog));
+
+        build_state->rsdp_mr = acpi_add_rom_blob(machine, tables.rsdp,
+                                                 ACPI_BUILD_RSDP_FILE, 0);
+    }
+
+    qemu_register_reset(acpi_reduced_build_reset, machine);
+    acpi_reduced_build_reset(machine);
+    vmstate_register(NULL, 0, &vmstate_acpi_reduced_build, machine);
+
+    /* Cleanup tables but don't free the memory: we track it
+     * in build_state.
+     */
+    acpi_build_tables_cleanup(&tables, false);
+}
diff --git a/include/hw/acpi/reduced.h b/include/hw/acpi/reduced.h
new file mode 100644
index 0000000000..94a5aac9eb
--- /dev/null
+++ b/include/hw/acpi/reduced.h
@@ -0,0 +1,24 @@
+/* HW reduced ACPI headers
+ *
+ * Copyright (c) 2018 Intel Corportation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef HW_ACPI_REDUCED_H
+#define HW_ACPI_REDUCED_H
+
+void acpi_reduced_setup(MachineState *machine, AcpiConfiguration *conf);
+
+#endif
-- 
2.17.2
