Received: from eggs.gnu.org ([2001:4830:134:3::10]:42665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eUQji-0004wk-Oh
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 00:28:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eUQjf-0000X5-Hc
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 00:28:10 -0500
From: Dongjiu Geng <gengdongjiu@huawei.com>
Date: Thu, 28 Dec 2017 13:54:11 +0800
Message-ID: <1514440458-10515-3-git-send-email-gengdongjiu@huawei.com>
In-Reply-To: <1514440458-10515-1-git-send-email-gengdongjiu@huawei.com>
References: <1514440458-10515-1-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v14 2/9] ACPI: Add APEI GHES table generation
 and CPER record support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, imammedo@redhat.com, zhaoshenglong@huawei.com, peter.maydell@linaro.org, mtosatti@redhat.com, rth@twiddle.net, ehabkost@redhat.com, james.morse@arm.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: gengdongjiu@huawei.com, huangshaoyu@huawei.com, zhengqiang10@huawei.com, xuwei5@hisilicon.com

This implements APEI GHES Table generation and record CPER in
runtime via fw_cfg blobs.Now we only support two types of GHESv2,
which are GPIO-Signal and ARMv8 SEA. Afterwards, we can extend the
supported type if needed. For the CPER section type, currently it
is memory section because kernel manly wants userspace to handle
the memory errors. In order to simulation, we hard code the error
type to Multi-bit ECC.

For GHESv2 error source, the OSPM must acknowledges the error via
Read ACK register. So user space must check the ACK value before
recording a new CPER to avoid read-write race condition.

Suggested-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
The basic solution is suggested by Laszlo in [1]
[1]: https://lkml.org/lkml/2017/3/29/342
---
 hw/acpi/aml-build.c         |   2 +
 hw/acpi/hest_ghes.c         | 390 ++++++++++++++++++++++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c    |   8 +
 include/hw/acpi/aml-build.h |   1 +
 include/hw/acpi/hest_ghes.h |  82 ++++++++++
 5 files changed, 483 insertions(+)
 create mode 100644 hw/acpi/hest_ghes.c
 create mode 100644 include/hw/acpi/hest_ghes.h

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 36a6cc4..6849e5f 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1561,6 +1561,7 @@ void acpi_build_tables_init(AcpiBuildTables *tables)
     tables->table_data = g_array_new(false, true /* clear */, 1);
     tables->tcpalog = g_array_new(false, true /* clear */, 1);
     tables->vmgenid = g_array_new(false, true /* clear */, 1);
+    tables->hardware_errors = g_array_new(false, true /* clear */, 1);
     tables->linker = bios_linker_loader_init();
 }
 
@@ -1571,6 +1572,7 @@ void acpi_build_tables_cleanup(AcpiBuildTables *tables, bool mfre)
     g_array_free(tables->table_data, true);
     g_array_free(tables->tcpalog, mfre);
     g_array_free(tables->vmgenid, mfre);
+    g_array_free(tables->hardware_errors, mfre);
 }
 
 /* Build rsdt table */
diff --git a/hw/acpi/hest_ghes.c b/hw/acpi/hest_ghes.c
new file mode 100644
index 0000000..86ec99e
--- /dev/null
+++ b/hw/acpi/hest_ghes.c
@@ -0,0 +1,390 @@
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
+#include "hw/acpi/hest_ghes.h"
+#include "hw/nvram/fw_cfg.h"
+#include "sysemu/sysemu.h"
+#include "qemu/error-report.h"
+
+/* Generic Address Structure (GAS)
+ * ACPI 2.0/3.0: 5.2.3.1 Generic Address Structure
+ * 2.0 compat note:
+ *    @access_width must be 0, see ACPI 2.0:Table 5-1
+ */
+static void build_append_gas(GArray *table, AmlRegionSpace as,
+                      uint8_t bit_width, uint8_t bit_offset,
+                      uint8_t access_width, uint64_t address)
+{
+    build_append_int_noprefix(table, as, 1);
+    build_append_int_noprefix(table, bit_width, 1);
+    build_append_int_noprefix(table, bit_offset, 1);
+    build_append_int_noprefix(table, access_width, 1);
+    build_append_int_noprefix(table, address, 8);
+}
+
+/* Hardware Error Notification
+ * ACPI 4.0: 17.3.2.7 Hardware Error Notification
+ */
+static void build_append_notify(GArray *table, const uint8_t type,
+                                uint8_t length)
+{
+        build_append_int_noprefix(table, type, 1); /* type */
+        build_append_int_noprefix(table, length, 1);
+        build_append_int_noprefix(table, 0, 26);
+}
+
+/* Generic Error Status Block
+ * ACPI 4.0: 17.3.2.6.1 Generic Error Data
+ */
+static void build_append_gesb_header(GArray *table, uint32_t block_status,
+                      uint32_t raw_data_offset, uint32_t raw_data_length,
+                      uint32_t data_length, uint32_t error_severity)
+{
+    build_append_int_noprefix(table, block_status, 4);
+    build_append_int_noprefix(table, raw_data_offset, 4);
+    build_append_int_noprefix(table, raw_data_length, 4);
+    build_append_int_noprefix(table, data_length, 4);
+    build_append_int_noprefix(table, error_severity, 4);
+}
+
+/* Generic Error Data Entry
+ * ACPI 4.0: 17.3.2.6.1 Generic Error Data
+ */
+static void build_append_gede_header(GArray *table, const char *section_type,
+                      const uint32_t error_severity, const uint16_t revision,
+                      const uint32_t error_data_length)
+{
+    int i;
+
+    for (i = 0; i < 16; i++) {
+        build_append_int_noprefix(table, section_type[i], 1);
+    }
+
+    build_append_int_noprefix(table, error_severity, 4);
+    build_append_int_noprefix(table, revision, 2);
+    build_append_int_noprefix(table, 0, 2);
+    build_append_int_noprefix(table, error_data_length, 4);
+    build_append_int_noprefix(table, 0, 44);
+}
+
+/* Memory section CPER record */
+static void build_append_mem_cper(GArray *table, uint64_t error_physical_addr)
+{
+    /*
+     * Memory Error Record
+     */
+    build_append_int_noprefix(table,
+                 (1UL << 14) | /* Type Valid */
+                 (1UL << 1) /* Physical Address Valid */,
+                 8);
+    /* Memory error status information */
+    build_append_int_noprefix(table, 0, 8);
+    /* The physical address at which the memory error occurred */
+    build_append_int_noprefix(table, error_physical_addr, 8);
+    build_append_int_noprefix(table, 0, 48);
+    /* Hard code to Multi-bit ECC error */
+    build_append_int_noprefix(table, 3 /* Multi-bit ECC */, 1);
+    build_append_int_noprefix(table, 0, 7);
+}
+
+static int ghes_record_mem_error(uint64_t error_block_address,
+                                    uint64_t error_physical_addr)
+{
+    GArray *block;
+    uint64_t current_block_length;
+    uint32_t data_length;
+    /* Memory section */
+    char mem_section_id_le[] = {0x14, 0x11, 0xBC, 0xA5, 0x64, 0x6F, 0xDE,
+                                0x4E, 0xB8, 0x63, 0x3E, 0x83, 0xED, 0x7C,
+                                0x83, 0xB1};
+
+    block = g_array_new(false, true /* clear */, 1);
+
+    /* Read the current length in bytes of the generic error data */
+    cpu_physical_memory_read(error_block_address +
+        offsetof(AcpiGenericErrorStatus, data_length), &data_length, 4);
+
+    /* The current whole length in bytes of the generic error status block */
+    current_block_length = sizeof(AcpiGenericErrorStatus) + data_length;
+
+    /* Add a new generic error data entry*/
+    data_length += GHES_DATA_LENGTH;
+    data_length += GHES_CPER_LENGTH;
+
+    /* Check whether it will run out of the preallocated memory if adding a new
+     * generic error data entry
+     */
+    if ((data_length + sizeof(AcpiGenericErrorStatus)) > GHES_MAX_RAW_DATA_LENGTH) {
+        error_report("Record CPER out of boundary!!!");
+        return GHES_CPER_FAIL;
+    }
+    /* Build the new generic error status block header */
+    build_append_gesb_header(block, cpu_to_le32(ACPI_GEBS_UNCORRECTABLE), 0, 0,
+        cpu_to_le32(data_length), cpu_to_le32(ACPI_CPER_SEV_RECOVERABLE));
+
+    /* Write back above generic error status block header to guest memory */
+    cpu_physical_memory_write(error_block_address, block->data,
+                              block->len);
+
+    /* Build the generic error data entries */
+
+    data_length = block->len;
+    /* Build the new generic error data entry header */
+    build_append_gede_header(block, mem_section_id_le,
+                    cpu_to_le32(ACPI_CPER_SEV_RECOVERABLE), cpu_to_le32(0x300),
+                    cpu_to_le32(80)/* the total size of Memory Error Record */);
+
+    /* Build the memory section CPER */
+    build_append_mem_cper(block, error_physical_addr);
+
+    /* Write back above whole new generic error data entry to guest memory */
+    cpu_physical_memory_write(error_block_address + current_block_length,
+                    block->data + data_length, block->len - data_length);
+
+    g_array_free(block, true);
+
+    return GHES_CPER_OK;
+}
+
+/* Build table for the hardware error fw_cfg blob */
+void build_hardware_error_table(GArray *hardware_errors, BIOSLinker *linker)
+{
+    int i;
+
+    /*
+     * | +--------------------------+
+     * | |    error_block_addressN   |
+     * | |      ..........          |
+     * | +--------------------------+
+     * | |    read_ack_registerN    |
+     * | |     ...........          |
+     * | +--------------------------+
+     * | |Generic Error Status Block|
+     * | |      ........            |
+     * | +--------------------------+
+     */
+
+    /* Build error block address */
+    build_append_int_noprefix((void *)hardware_errors, 0,
+                    GHES_ADDRESS_SIZE * ACPI_HEST_ERROR_SOURCE_COUNT);
+
+    for (i = 0; i < ACPI_HEST_ERROR_SOURCE_COUNT; i++)
+        /* Build Read ACK registes and initialize them to 1, so GHES can be
+         * writeable in the first time
+         */
+        build_append_int_noprefix((void *)hardware_errors, 1, GHES_ADDRESS_SIZE);
+
+     /* Build generic error status blocks */
+    build_append_int_noprefix((void *)hardware_errors, 0,
+                    GHES_MAX_RAW_DATA_LENGTH * ACPI_HEST_ERROR_SOURCE_COUNT);
+
+    /* Allocate guest memory for the hardware error fw_cfg blob */
+    bios_linker_loader_alloc(linker, GHES_ERRORS_FW_CFG_FILE, hardware_errors,
+                            1, false);
+}
+
+void build_apei_ghes(GArray *table_data, GArray *hardware_errors,
+                                            BIOSLinker *linker)
+{
+    uint32_t i, error_status_block_offset, length = table_data->len;
+
+    /* Reserve table header size */
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
+        /* Hardware Error Notification
+         * Now only enable GPIO-Signal and ARMv8 SEA notification types
+         */
+        if (i == 0) {
+            build_append_notify(table_data, ACPI_HEST_NOTIFY_GPIO, 28);
+        } else if (i == 1) {
+            build_append_notify(table_data, ACPI_HEST_NOTIFY_SEA, 28);
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
+        /* Patch address of generic error status block into
+         * the error block address register of hardware_errors fw_cfg blob
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
+    fw_cfg_add_file_callback(s, GHES_DATA_ADDR_FW_CFG_FILE, NULL, NULL,
+        &ges.ghes_addr_le, sizeof(ges.ghes_addr_le), false);
+}
+
+bool ghes_record_errors(uint32_t notify, uint64_t physical_address)
+{
+    uint64_t error_block_addr, read_ack_register_addr;
+    int read_ack_register = 0, loop = 0;
+    uint64_t start_addr = le32_to_cpu(ges.ghes_addr_le);
+    bool ret = GHES_CPER_FAIL;
+    const uint8_t error_source_id[] = { 0xff, 0xff, 0xff, 0xff,
+                                        0xff, 0xff, 0xff, 0, 1};
+
+    /*
+     * | +---------------------+ ges.ghes_addr_le
+     * | |error_block_address0|
+     * | +---------------------+
+     * | |error_block_address1|
+     * | +---------------------+ --+--
+     * | |    .............    | GHES_ADDRESS_SIZE
+     * | +---------------------+ --+--
+     * | |error_block_addressN|
+     * | +---------------------+
+     * | | read_ack_register0  |
+     * | +---------------------+ --+--
+     * | | read_ack_register1  | GHES_ADDRESS_SIZE
+     * | +---------------------+ --+--
+     * | |   .............     |
+     * | +---------------------+
+     * | | read_ack_registerN  |
+     * | +---------------------+ --+--
+     * | |      CPER           |   |
+     * | |      ....           | GHES_MAX_RAW_DATA_LENGT
+     * | |      CPER           |   |
+     * | +---------------------+ --+--
+     * | |    ..........       |
+     * | +---------------------+
+     * | |      CPER           |
+     * | |      ....           |
+     * | |      CPER           |
+     * | +---------------------+
+     */
+    if (physical_address && notify < ACPI_HEST_NOTIFY_RESERVED) {
+        /* Find and check the source id for this new CPER */
+        if (error_source_id[notify] != 0xff) {
+            start_addr += error_source_id[notify] * GHES_ADDRESS_SIZE;
+        } else {
+            goto out;
+        }
+
+        cpu_physical_memory_read(start_addr, &error_block_addr,
+                                    GHES_ADDRESS_SIZE);
+
+        read_ack_register_addr = start_addr +
+                        ACPI_HEST_ERROR_SOURCE_COUNT * GHES_ADDRESS_SIZE;
+retry:
+        cpu_physical_memory_read(read_ack_register_addr,
+                                 &read_ack_register, GHES_ADDRESS_SIZE);
+
+        /* zero means OSPM does not acknowledge the error */
+        if (!read_ack_register) {
+            if (loop < 3) {
+                usleep(100 * 1000);
+                loop++;
+                goto retry;
+            } else {
+                error_report("Last time OSPM does not acknowledge the error,"
+                    " record CPER failed this time, set the ack value to"
+                    " avoid blocking next time CPER record! exit");
+                read_ack_register = 1;
+                cpu_physical_memory_write(read_ack_register_addr,
+                    &read_ack_register, GHES_ADDRESS_SIZE);
+            }
+        } else {
+            if (error_block_addr) {
+                read_ack_register = 0;
+                cpu_physical_memory_write(read_ack_register_addr,
+                    &read_ack_register, GHES_ADDRESS_SIZE);
+                ret = ghes_record_mem_error(error_block_addr, physical_address);
+            }
+        }
+    }
+
+out:
+    return ret;
+}
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 3d78ff6..b7d45cd 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -45,6 +45,7 @@
 #include "hw/arm/virt.h"
 #include "sysemu/numa.h"
 #include "kvm_arm.h"
+#include "hw/acpi/hest_ghes.h"
 
 #define ARM_SPI_BASE 32
 #define ACPI_POWER_BUTTON_DEVICE "PWRB"
@@ -771,6 +772,11 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     acpi_add_table(table_offsets, tables_blob);
     build_spcr(tables_blob, tables->linker, vms);
 
+    acpi_add_table(table_offsets, tables_blob);
+    build_hardware_error_table(tables->hardware_errors, tables->linker);
+    build_apei_ghes(tables_blob, tables->hardware_errors, tables->linker);
+
+
     if (nb_numa_nodes > 0) {
         acpi_add_table(table_offsets, tables_blob);
         build_srat(tables_blob, tables->linker, vms);
@@ -887,6 +893,8 @@ void virt_acpi_setup(VirtMachineState *vms)
     fw_cfg_add_file(vms->fw_cfg, ACPI_BUILD_TPMLOG_FILE, tables.tcpalog->data,
                     acpi_data_len(tables.tcpalog));
 
+    ghes_add_fw_cfg(vms->fw_cfg, tables.hardware_errors);
+
     build_state->rsdp_mr = acpi_add_rom_blob(build_state, tables.rsdp,
                                               ACPI_BUILD_RSDP_FILE, 0);
 
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index 88d0738..7f7b55c 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -211,6 +211,7 @@ struct AcpiBuildTables {
     GArray *rsdp;
     GArray *tcpalog;
     GArray *vmgenid;
+    GArray *hardware_errors;
     BIOSLinker *linker;
 } AcpiBuildTables;
 
diff --git a/include/hw/acpi/hest_ghes.h b/include/hw/acpi/hest_ghes.h
new file mode 100644
index 0000000..420e825
--- /dev/null
+++ b/include/hw/acpi/hest_ghes.h
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
+#define GHES_CPER_OK            1
+#define GHES_CPER_FAIL          0
+
+/* The Address field is 64-bit size, ACPI 2.0/3.0: 5.2.3.1 Generic Address
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
+void build_apei_ghes(GArray *table_data, GArray *hardware_error,
+                    BIOSLinker *linker);
+void build_hardware_error_table(GArray *hardware_errors, BIOSLinker *linker);
+void ghes_add_fw_cfg(FWCfgState *s, GArray *hardware_errors);
+bool ghes_record_errors(uint32_t notify, uint64_t error_physical_addr);
+#endif
-- 
1.8.3.1
