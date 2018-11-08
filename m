Received: from eggs.gnu.org ([2001:4830:134:3::10]:39732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1gKhR2-0004Xl-12
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:21:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1gKhOp-00023h-4L
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:18:57 -0500
From: Dongjiu Geng <gengdongjiu@huawei.com>
Date: Thu, 8 Nov 2018 02:15:48 -0800
Message-ID: <1541672153-15529-6-git-send-email-gengdongjiu@huawei.com>
In-Reply-To: <1541672153-15529-1-git-send-email-gengdongjiu@huawei.com>
References: <1541672153-15529-1-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v15 05/10] ACPI: Add APEI GHES table generation
 and CPER record support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: imammedo@redhat.com, mst@redhat.com, peter.maydell@linaro.org, pbonzini@redhat.com, mtosatti@redhat.com, rth@twiddle.net, ehabkost@redhat.com, kvm@vger.kernel.org, shannon.zhaosl@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, gengdongjiu@huawei.com

This implements APEI GHES Table generation and record CPER in
runtime via fw_cfg blobs.Now we only support two types of GHESv2,
which are GPIO-Signal and ARMv8 SEA. Afterwards, we can extend the
supported types if needed. For the CPER section type, currently it
is memory section because kernel mainly wants userspace to handle
the memory errors.

For GHESv2 error source, the OSPM must acknowledges the error via
Read ACK register. So user space must check the ACK value before
recording a new CPER to avoid read-write race condition.

Suggested-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>

The basic solution is suggested by Laszlo in [1]
[1]: https://lkml.org/lkml/2017/3/29/342
---
 default-configs/arm-softmmu.mak |   1 +
 hw/acpi/Makefile.objs           |   1 +
 hw/acpi/acpi_ghes.c             | 171 ++++++++++++++++++++++++++++++++++++++++
 hw/acpi/aml-build.c             |   2 +
 hw/arm/virt-acpi-build.c        |   8 ++
 include/hw/acpi/acpi_ghes.h     |  82 +++++++++++++++++++
 include/hw/acpi/aml-build.h     |   1 +
 7 files changed, 266 insertions(+)
 create mode 100644 hw/acpi/acpi_ghes.c
 create mode 100644 include/hw/acpi/acpi_ghes.h

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 2420491..7ea9857 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -159,3 +159,4 @@ CONFIG_PCI_DESIGNWARE=y
 CONFIG_STRONGARM=y
 CONFIG_HIGHBANK=y
 CONFIG_MUSICPAL=y
+CONFIG_ACPI_APEI=y
diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
index 11c35bc..209febf 100644
--- a/hw/acpi/Makefile.objs
+++ b/hw/acpi/Makefile.objs
@@ -6,6 +6,7 @@ common-obj-$(CONFIG_ACPI_MEMORY_HOTPLUG) += memory_hotplug.o
 common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) += cpu.o
 common-obj-$(CONFIG_ACPI_NVDIMM) += nvdimm.o
 common-obj-$(CONFIG_ACPI_VMGENID) += vmgenid.o
+common-obj-$(CONFIG_ACPI_APEI) += acpi_ghes.o
 common-obj-$(call lnot,$(CONFIG_ACPI_X86)) += acpi-stub.o
 
 common-obj-y += acpi_interface.o
diff --git a/hw/acpi/acpi_ghes.c b/hw/acpi/acpi_ghes.c
new file mode 100644
index 0000000..d03e797
--- /dev/null
+++ b/hw/acpi/acpi_ghes.c
@@ -0,0 +1,171 @@
+/* Support for generating APEI tables and record CPER for Guests
+ *
+ * Copyright (C) 2017 HuaWei Corporation.
+ *
+ * Author: Dongjiu Geng <gengdongjiu@huawei.com>
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
+#include "hw/acpi/acpi.h"
+#include "hw/acpi/aml-build.h"
+#include "hw/acpi/acpi_ghes.h"
+#include "hw/nvram/fw_cfg.h"
+#include "sysemu/sysemu.h"
+#include "qemu/error-report.h"
+
+/* Build table for the hardware error fw_cfg blob */
+void build_hardware_error_table(GArray *hardware_errors, BIOSLinker *linker)
+{
+    int i;
+
+    /*
+     * | +--------------------------+
+     * | |    error_block_address   |
+     * | |      ..........          |
+     * | +--------------------------+
+     * | |    read_ack_register     |
+     * | |     ...........          |
+     * | +--------------------------+
+     * | |  Error Status Data Block |
+     * | |      ........            |
+     * | +--------------------------+
+     */
+
+    /* Build error_block_address */
+    build_append_int_noprefix((void *)hardware_errors, 0,
+                    GHES_ADDRESS_SIZE * ACPI_HEST_ERROR_SOURCE_COUNT);
+
+    /* Build read_ack_register */
+    for (i = 0; i < ACPI_HEST_ERROR_SOURCE_COUNT; i++)
+        /* Initialize the value of read_ack_register to 1, so GHES can be
+         * writeable in the first time
+         */
+        build_append_int_noprefix((void *)hardware_errors, 1, GHES_ADDRESS_SIZE);
+
+     /* Build Error Status Data Block */
+    build_append_int_noprefix((void *)hardware_errors, 0,
+                    GHES_MAX_RAW_DATA_LENGTH * ACPI_HEST_ERROR_SOURCE_COUNT);
+
+    /* Allocate guest memory for the hardware error fw_cfg blob */
+    bios_linker_loader_alloc(linker, GHES_ERRORS_FW_CFG_FILE, hardware_errors,
+                            1, false);
+}
+
+/* Build Hardware Error Source Table */
+void build_apei_hest(GArray *table_data, GArray *hardware_errors,
+                                            BIOSLinker *linker)
+{
+    uint32_t i, error_status_block_offset, length = table_data->len;
+
+    /* Reserve Hardware Error Source Table header size */
+    acpi_data_push(table_data, sizeof(AcpiTableHeader));
+
+    /* Set the error source counts */
+    build_append_int_noprefix(table_data, ACPI_HEST_ERROR_SOURCE_COUNT, 4);
+
+    for (i = 0; i < ACPI_HEST_ERROR_SOURCE_COUNT; i++) {
+        /* Generic Hardware Error Source version 2(GHESv2 - Type 10)
+         */
+        build_append_int_noprefix(table_data,
+            ACPI_HEST_SOURCE_GENERIC_ERROR_V2, 2); /* type */
+        build_append_int_noprefix(table_data, cpu_to_le16(i), 2); /* source id */
+        build_append_int_noprefix(table_data, 0xffff, 2); /* related source id */
+        build_append_int_noprefix(table_data, 0, 1); /* flags */
+
+        build_append_int_noprefix(table_data, 1, 1); /* enabled */
+
+        /* Number of Records To Pre-allocate */
+        build_append_int_noprefix(table_data, 1, 4);
+        /* Max Sections Per Record */
+        build_append_int_noprefix(table_data, 1, 4);
+        /* Max Raw Data Length */
+        build_append_int_noprefix(table_data, GHES_MAX_RAW_DATA_LENGTH, 4);
+
+        /* Build error status address*/
+        build_append_gas(table_data, AML_SYSTEM_MEMORY, 0x40, 0, 4 /* QWord access */, 0);
+        bios_linker_loader_add_pointer(linker,
+            ACPI_BUILD_TABLE_FILE, ERROR_STATUS_ADDRESS_OFFSET(length, i),
+            GHES_ADDRESS_SIZE, GHES_ERRORS_FW_CFG_FILE, i * GHES_ADDRESS_SIZE);
+
+        /* Build Hardware Error Notification
+         * Now only enable GPIO-Signal and ARMv8 SEA notification types
+         */
+        if (i == 0) {
+            build_append_ghes_notify(table_data, ACPI_HEST_NOTIFY_GPIO, 28,
+                                     0, 0, 0, 0, 0, 0, 0);
+        } else if (i == 1) {
+            build_append_ghes_notify(table_data, ACPI_HEST_NOTIFY_SEA, 28, 0,
+                                     0, 0, 0, 0, 0, 0);
+        }
+
+        /* Error Status Block Length */
+        build_append_int_noprefix(table_data,
+            cpu_to_le32(GHES_MAX_RAW_DATA_LENGTH), 4);
+
+        /* Build Read ACK register
+         * ACPI 6.1/6.2: 18.3.2.8 Generic Hardware Error Source
+         * version 2 (GHESv2 - Type 10)
+         */
+        build_append_gas(table_data, AML_SYSTEM_MEMORY, 0x40, 0, 4 /* QWord access */, 0);
+        bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
+            READ_ACK_REGISTER_ADDRESS_OFFSET(length, i), GHES_ADDRESS_SIZE,
+            GHES_ERRORS_FW_CFG_FILE,
+            (ACPI_HEST_ERROR_SOURCE_COUNT + i) * GHES_ADDRESS_SIZE);
+
+        /* Build Read Ack Preserve and Read Ack Writer */
+        build_append_int_noprefix(table_data, cpu_to_le64(ReadAckPreserve), 8);
+        build_append_int_noprefix(table_data, cpu_to_le64(ReadAckWrite), 8);
+    }
+
+    /* Generic Error Status Block offset in the hardware error fw_cfg blob */
+    error_status_block_offset = GHES_ADDRESS_SIZE * 2 *
+                                ACPI_HEST_ERROR_SOURCE_COUNT;
+
+    for (i = 0; i < ACPI_HEST_ERROR_SOURCE_COUNT; i++)
+        /* Patch address of Error Status Data Block into
+         * the error_block_address of hardware_errors fw_cfg blob
+         */
+        bios_linker_loader_add_pointer(linker,
+            GHES_ERRORS_FW_CFG_FILE, GHES_ADDRESS_SIZE * i, GHES_ADDRESS_SIZE,
+            GHES_ERRORS_FW_CFG_FILE,
+            error_status_block_offset + i * GHES_MAX_RAW_DATA_LENGTH);
+
+    /* write address of hardware_errors fw_cfg blob into the
+     * hardware_errors_addr fw_cfg blob.
+     */
+    bios_linker_loader_write_pointer(linker, GHES_DATA_ADDR_FW_CFG_FILE,
+        0, GHES_ADDRESS_SIZE, GHES_ERRORS_FW_CFG_FILE, 0);
+
+    build_header(linker, table_data,
+        (void *)(table_data->data + length), "HEST",
+        table_data->len - length, 1, NULL, "GHES");
+}
+
+static GhesState ges;
+void ghes_add_fw_cfg(FWCfgState *s, GArray *hardware_error)
+{
+
+    size_t size = 2 * GHES_ADDRESS_SIZE + GHES_MAX_RAW_DATA_LENGTH;
+    size_t request_block_size = ACPI_HEST_ERROR_SOURCE_COUNT * size;
+
+    /* Create a read-only fw_cfg file for GHES */
+    fw_cfg_add_file(s, GHES_ERRORS_FW_CFG_FILE, hardware_error->data,
+                    request_block_size);
+
+    /* Create a read-write fw_cfg file for Address */
+    fw_cfg_add_file_callback(s, GHES_DATA_ADDR_FW_CFG_FILE, NULL, NULL, NULL,
+        &ges.ghes_addr_le, sizeof(ges.ghes_addr_le), false);
+}
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 5923248..4f2478f 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1645,6 +1645,7 @@ void acpi_build_tables_init(AcpiBuildTables *tables)
     tables->table_data = g_array_new(false, true /* clear */, 1);
     tables->tcpalog = g_array_new(false, true /* clear */, 1);
     tables->vmgenid = g_array_new(false, true /* clear */, 1);
+    tables->hardware_errors = g_array_new(false, true /* clear */, 1);
     tables->linker = bios_linker_loader_init();
 }
 
@@ -1655,6 +1656,7 @@ void acpi_build_tables_cleanup(AcpiBuildTables *tables, bool mfre)
     g_array_free(tables->table_data, true);
     g_array_free(tables->tcpalog, mfre);
     g_array_free(tables->vmgenid, mfre);
+    g_array_free(tables->hardware_errors, mfre);
 }
 
 /* Build rsdt table */
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 5785fb6..19c1b7e 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -45,6 +45,7 @@
 #include "hw/arm/virt.h"
 #include "sysemu/numa.h"
 #include "kvm_arm.h"
+#include "hw/acpi/acpi_ghes.h"
 
 #define ARM_SPI_BASE 32
 #define ACPI_POWER_BUTTON_DEVICE "PWRB"
@@ -835,6 +836,11 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     acpi_add_table(table_offsets, tables_blob);
     build_spcr(tables_blob, tables->linker, vms);
 
+    acpi_add_table(table_offsets, tables_blob);
+    build_hardware_error_table(tables->hardware_errors, tables->linker);
+    build_apei_hest(tables_blob, tables->hardware_errors, tables->linker);
+
+
     if (nb_numa_nodes > 0) {
         acpi_add_table(table_offsets, tables_blob);
         build_srat(tables_blob, tables->linker, vms);
@@ -951,6 +957,8 @@ void virt_acpi_setup(VirtMachineState *vms)
     fw_cfg_add_file(vms->fw_cfg, ACPI_BUILD_TPMLOG_FILE, tables.tcpalog->data,
                     acpi_data_len(tables.tcpalog));
 
+    ghes_add_fw_cfg(vms->fw_cfg, tables.hardware_errors);
+
     build_state->rsdp_mr = acpi_add_rom_blob(build_state, tables.rsdp,
                                               ACPI_BUILD_RSDP_FILE, 0);
 
diff --git a/include/hw/acpi/acpi_ghes.h b/include/hw/acpi/acpi_ghes.h
new file mode 100644
index 0000000..0a7c6c2
--- /dev/null
+++ b/include/hw/acpi/acpi_ghes.h
@@ -0,0 +1,82 @@
+/* Support for generating APEI tables and record CPER for Guests
+ *
+ * Copyright (C) 2017 HuaWei Corporation.
+ *
+ * Author: Dongjiu Geng <gengdongjiu@huawei.com>
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
+#ifndef ACPI_GHES_H
+#define ACPI_GHES_H
+
+#include "hw/acpi/bios-linker-loader.h"
+
+#define GHES_ERRORS_FW_CFG_FILE         "etc/hardware_errors"
+#define GHES_DATA_ADDR_FW_CFG_FILE      "etc/hardware_errors_addr"
+
+/* The size of Address field in Generic Address Structure, ACPI 2.0/3.0: 5.2.3.1 Generic Address
+ * Structure
+ */
+#define GHES_ADDRESS_SIZE           8
+
+#define GHES_DATA_LENGTH            72
+#define GHES_CPER_LENGTH            80
+
+#define ReadAckPreserve             0xfffffffe
+#define ReadAckWrite                0x1
+
+#define GHES_CPER_OK                1
+#define GHES_CPER_FAIL              0
+
+/* The max size in bytes for one error block */
+#define GHES_MAX_RAW_DATA_LENGTH        0x1000
+/* Now only have GPIO-Signal and ARMv8 SEA notification types error sources
+ */
+#define ACPI_HEST_ERROR_SOURCE_COUNT    2
+
+/*
+ * | +--------------------------+ 0
+ * | |        Header            |
+ * | +--------------------------+ 40---+-
+ * | | .................        |      |
+ * | | error_status_address-----+ 60   |
+ * | | .................        |      |
+ * | | read_ack_register--------+ 104  92
+ * | | read_ack_preserve        |      |
+ * | | read_ack_write           |      |
+ * + +--------------------------+ 132--+-
+ *
+ * From above GHES definition, the error status address offset is 60;
+ * the Read ack register offset is 104, the whole size of GHESv2 is 92
+ */
+
+/* The error status address offset in GHES */
+#define ERROR_STATUS_ADDRESS_OFFSET(start_addr, n)     (start_addr + 60 + \
+                    offsetof(struct AcpiGenericAddress, address) + n * 92)
+
+/* The read Ack register offset in GHES */
+#define READ_ACK_REGISTER_ADDRESS_OFFSET(start_addr, n) (start_addr + 104 + \
+                    offsetof(struct AcpiGenericAddress, address) + n * 92)
+
+typedef struct GhesState {
+    uint64_t ghes_addr_le;
+} GhesState;
+
+void build_apei_hest(GArray *table_data, GArray *hardware_error,
+                     BIOSLinker *linker);
+
+void build_hardware_error_table(GArray *hardware_errors, BIOSLinker *linker);
+void ghes_add_fw_cfg(FWCfgState *s, GArray *hardware_errors);
+#endif
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index 657a0d5..c01b0f3 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -220,6 +220,7 @@ struct AcpiBuildTables {
     GArray *rsdp;
     GArray *tcpalog;
     GArray *vmgenid;
+    GArray *hardware_errors;
     BIOSLinker *linker;
 } AcpiBuildTables;
 
-- 
1.8.3.1
