Received: from eggs.gnu.org ([2001:4830:134:3::10]:38566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1ddZEq-0006PF-TW
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 05:49:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1ddZEo-00047Q-Cu
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 05:49:48 -0400
From: Dongjiu Geng <gengdongjiu@huawei.com>
Date: Fri, 4 Aug 2017 18:09:14 +0800
Message-ID: <1501841356-6486-2-git-send-email-gengdongjiu@huawei.com>
In-Reply-To: <1501841356-6486-1-git-send-email-gengdongjiu@huawei.com>
References: <1501841356-6486-1-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v9 1/3] ACPI: add APEI/HEST/CPER structures and
 macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: lersek@redhat.com, mst@redhat.com, imammedo@redhat.com, zhaoshenglong@huawei.com, peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: gengdongjiu@huawei.com, huangshaoyu@huawei.com, wuquanming@huawei.com, zhengqiang10@huawei.com

(1) Add related APEI/HEST table structures and  macros, these
    definition refer to ACPI 6.1 and UEFI 2.6 spec.
(2) Add generic error status block and CPER memory section
    definition, user space only handle memory section errors.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
thanks Michael and Laszlo's review:

change since v5:
(1) update the commit message title
(2) remove UUID_BE and UEFI_CPER_SEC_PLATFORM_MEM macros
(3) remove including "qemu/uuid.h" file in this patch
(4) remove including "hest_ghes.h" file in this patch
(5) drop "this is" from the comment of structures and macros
(6) replace the "QemuUUID section_type_le" to "uint8_t section_type_le[16]"

chnage since v4:
(1) fix email threading in this series is incorrect issue

change since v3:
(1) separate the original one patch into three patches: one is new
    ACPI structures and macros, another is C source file to generate ACPI HEST
    table and dynamically record CPER ,final patch is the change about Makefile
    and configuration
(2) add comments about where the ACPI structures and macros come from, for example,
    they come from the UEFI Spec 2.6, "xxxxxxxxxxxx"; ACPI 6.1 spec, 
    "xxxxxxxxxxxxxx".
(3) correct the macros name, for emaple, prefix some macro names with
    "UEFI_".
(4) remove the uuid_le struct and use the QemuUUID in the include/qemu/uuid.h"
(5) remove the duplicate ACPI address space, because it already defined in 
    the "include/hw/acpi/aml-build.h"
(6) remove the acpi_generic_address structure because same definition exists in the 
    AcpiGenericAddress.
(7) rename the struct acpi_hest_notify to AcpiHestNotifyType
(8) rename the struct acpi_hest_types to AcpiHestSourceType
(9) rename enum constants AcpiHestSourceType to ACPI_HEST_SOURCE_xxx from
     ACPI_HEST_TYPE_xxx
(10) remove the NOT_USED{3,4,5} enum constants in the AcpiHestSourceType.
(11) add missed QEMU_PACKED for the struct definition.
(12) remove the defnition of AcpiGenericErrorData, and rename the
     AcpiGenericErrorDataV300 to AcpiGenericErrorData.
(13) use the QemuUUID type for the "section_type" field AcpiGenericErrorData, and rename it
     to section_type_le.
(14) moving type AcpiGenericErrorSeverity above AcpiGenericErrorData and
     AcpiGenericErrorDataV300, and remarking on the "error_severity" fields
     that they take their values from AcpiGenericErrorSeverity
(15) remove the wrongly call to BERT(Boot Error Record Table)
(16) add comments for the struction member, for example, pint out that
     the block_status member in the AcpiGenericErrorStatus is a bitmask
     composed of ACPI_GEBS_xxx macros
(17) remove the hardware error source notification type list, and rename
     the MAX_ERROR_SOURCE_COUNT_V6 to ACPI_HEST_NOTIFY_RESERVED.
(18) remove the physical_addr member of GhesErrorState
(19) change the "uint64_t ghes_addr_le[8]" in GhesErrorState to uint64_t ghes_addr_le
(20) change the second parameter to "error_physical_addr" in the ghes_update_guest
     API statement
---
 include/hw/acpi/acpi-defs.h | 193 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 193 insertions(+)

diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index 4cc3630..ff9525e 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -295,6 +295,44 @@ typedef struct AcpiMultipleApicTable AcpiMultipleApicTable;
 #define ACPI_APIC_GENERIC_TRANSLATOR    15
 #define ACPI_APIC_RESERVED              16   /* 16 and greater are reserved */
 
+/* UEFI Spec 2.6, "N.2.5 Memory Error Section */
+#define UEFI_CPER_MEM_VALID_ERROR_STATUS     0x0001
+#define UEFI_CPER_MEM_VALID_PA               0x0002
+#define UEFI_CPER_MEM_VALID_PA_MASK          0x0004
+#define UEFI_CPER_MEM_VALID_NODE             0x0008
+#define UEFI_CPER_MEM_VALID_CARD             0x0010
+#define UEFI_CPER_MEM_VALID_MODULE           0x0020
+#define UEFI_CPER_MEM_VALID_BANK             0x0040
+#define UEFI_CPER_MEM_VALID_DEVICE           0x0080
+#define UEFI_CPER_MEM_VALID_ROW              0x0100
+#define UEFI_CPER_MEM_VALID_COLUMN           0x0200
+#define UEFI_CPER_MEM_VALID_BIT_POSITION     0x0400
+#define UEFI_CPER_MEM_VALID_REQUESTOR        0x0800
+#define UEFI_CPER_MEM_VALID_RESPONDER        0x1000
+#define UEFI_CPER_MEM_VALID_TARGET           0x2000
+#define UEFI_CPER_MEM_VALID_ERROR_TYPE       0x4000
+#define UEFI_CPER_MEM_VALID_RANK_NUMBER      0x8000
+#define UEFI_CPER_MEM_VALID_CARD_HANDLE      0x10000
+#define UEFI_CPER_MEM_VALID_MODULE_HANDLE    0x20000
+#define UEFI_CPER_MEM_ERROR_TYPE_MULTI_ECC   3
+
+/* From the ACPI 6.1 spec, "18.3.2.9 Hardware Error Notification" */
+
+enum AcpiHestNotifyType {
+    ACPI_HEST_NOTIFY_POLLED = 0,
+    ACPI_HEST_NOTIFY_EXTERNAL = 1,
+    ACPI_HEST_NOTIFY_LOCAL = 2,
+    ACPI_HEST_NOTIFY_SCI = 3,
+    ACPI_HEST_NOTIFY_NMI = 4,
+    ACPI_HEST_NOTIFY_CMCI = 5,  /* ACPI 5.0 */
+    ACPI_HEST_NOTIFY_MCE = 6,   /* ACPI 5.0 */
+    ACPI_HEST_NOTIFY_GPIO = 7,  /* ACPI 6.0 */
+    ACPI_HEST_NOTIFY_SEA = 8,   /* ACPI 6.1 */
+    ACPI_HEST_NOTIFY_SEI = 9,   /* ACPI 6.1 */
+    ACPI_HEST_NOTIFY_GSIV = 10, /* ACPI 6.1 */
+    ACPI_HEST_NOTIFY_RESERVED = 11  /* 11 and greater are reserved */
+};
+
 /*
  * MADT sub-structures (Follow MULTIPLE_APIC_DESCRIPTION_TABLE)
  */
@@ -475,6 +513,161 @@ struct AcpiSystemResourceAffinityTable
 } QEMU_PACKED;
 typedef struct AcpiSystemResourceAffinityTable AcpiSystemResourceAffinityTable;
 
+/* Hardware Error Notification, from the ACPI 6.1
+ * spec, "18.3.2.9 Hardware Error Notification"
+ */
+struct AcpiHestNotify {
+    uint8_t type;
+    uint8_t length;
+    uint16_t config_write_enable;
+    uint32_t poll_interval;
+    uint32_t vector;
+    uint32_t polling_threshold_value;
+    uint32_t polling_threshold_window;
+    uint32_t error_threshold_value;
+    uint32_t error_threshold_window;
+} QEMU_PACKED;
+typedef struct AcpiHestNotify AcpiHestNotify;
+
+/* From ACPI 6.1, sections "18.3.2.1 IA-32 Architecture Machine
+ * Check Exception" through "18.3.2.8 Generic Hardware Error Source version 2".
+ */
+enum AcpiHestSourceType {
+    ACPI_HEST_SOURCE_IA32_CHECK = 0,
+    ACPI_HEST_SOURCE_IA32_CORRECTED_CHECK = 1,
+    ACPI_HEST_SOURCE_IA32_NMI = 2,
+    ACPI_HEST_SOURCE_AER_ROOT_PORT = 6,
+    ACPI_HEST_SOURCE_AER_ENDPOINT = 7,
+    ACPI_HEST_SOURCE_AER_BRIDGE = 8,
+    ACPI_HEST_SOURCE_GENERIC_ERROR = 9,
+    ACPI_HEST_SOURCE_GENERIC_ERROR_V2 = 10,
+    ACPI_HEST_SOURCE_RESERVED = 11    /* 11 and greater are reserved */
+};
+
+/* Block status bitmasks from ACPI 6.1, "18.3.2.7.1 Generic Error Data" */
+#define ACPI_GEBS_UNCORRECTABLE             (1)
+#define ACPI_GEBS_CORRECTABLE               (1 << 1)
+#define ACPI_GEBS_MULTIPLE_UNCORRECTABLE    (1 << 2)
+#define ACPI_GEBS_MULTIPLE_CORRECTABLE      (1 << 3)
+/* 10 bits, error data entry count */
+#define ACPI_GEBS_ERROR_ENTRY_COUNT         (0x3FF << 4)
+
+/* Generic Hardware Error Source Structure, refer to ACPI 6.1
+ * "18.3.2.7 Generic Hardware Error Source". in this struct the
+ * "type" field has to be ACPI_HEST_SOURCE_GENERIC_ERROR
+ */
+
+struct AcpiGenericHardwareErrorSource {
+    uint16_t type;
+    uint16_t source_id;
+    uint16_t related_source_id;
+    uint8_t flags;
+    uint8_t enabled;
+    uint32_t number_of_records;
+    uint32_t max_sections_per_record;
+    uint32_t max_raw_data_length;
+    struct AcpiGenericAddress error_status_address;
+    struct AcpiHestNotify notify;
+    uint32_t error_status_block_length;
+} QEMU_PACKED;
+typedef struct AcpiGenericHardwareErrorSource AcpiGenericHardwareErrorSource;
+
+/* Generic Hardware Error Source, version 2, ACPI 6.1, "18.3.2.8 Generic
+ * Hardware Error Source version 2", in this struct the "type" field has to
+ * be ACPI_HEST_SOURCE_GENERIC_ERROR_V2
+ */
+struct AcpiGenericHardwareErrorSourceV2 {
+    uint16_t type;
+    uint16_t source_id;
+    uint16_t related_source_id;
+    uint8_t flags;
+    uint8_t enabled;
+    uint32_t number_of_records;
+    uint32_t max_sections_per_record;
+    uint32_t max_raw_data_length;
+    struct AcpiGenericAddress error_status_address;
+    struct AcpiHestNotify notify;
+    uint32_t error_status_block_length;
+    struct AcpiGenericAddress read_ack_register;
+    uint64_t read_ack_preserve;
+    uint64_t read_ack_write;
+} QEMU_PACKED;
+typedef struct AcpiGenericHardwareErrorSourceV2
+            AcpiGenericHardwareErrorSourceV2;
+
+/* Generic Error Status block, from ACPI 6.1,
+ * "18.3.2.7.1 Generic Error Data"
+ */
+struct AcpiGenericErrorStatus {
+    /* It is a bitmask composed of ACPI_GEBS_xxx macros */
+    uint32_t block_status;
+    uint32_t raw_data_offset;
+    uint32_t raw_data_length;
+    uint32_t data_length;
+    uint32_t error_severity;
+} QEMU_PACKED;
+typedef struct AcpiGenericErrorStatus AcpiGenericErrorStatus;
+
+enum AcpiGenericErrorSeverity {
+    ACPI_CPER_SEV_RECOVERABLE,
+    ACPI_CPER_SEV_FATAL,
+    ACPI_CPER_SEV_CORRECTED,
+    ACPI_CPER_SEV_NONE,
+};
+
+/* Generic Error Data entry, revision number is 0x0300,
+ * ACPI 6.1, "18.3.2.7.1 Generic Error Data"
+ */
+struct AcpiGenericErrorData {
+    uint8_t section_type_le[16];
+    /* The "error_severity" fields that they take their
+     * values from AcpiGenericErrorSeverity
+     */
+    uint32_t error_severity;
+    uint16_t revision;
+    uint8_t validation_bits;
+    uint8_t flags;
+    uint32_t error_data_length;
+    uint8_t fru_id[16];
+    uint8_t fru_text[20];
+    uint64_t time_stamp;
+} QEMU_PACKED;
+typedef struct AcpiGenericErrorData AcpiGenericErrorData;
+
+/* From UEFI 2.6, "N.2.5 Memory Error Section" */
+struct UefiCperSecMemErr {
+    uint64_t    validation_bits;
+    uint64_t    error_status;
+    uint64_t    physical_addr;
+    uint64_t    physical_addr_mask;
+    uint16_t    node;
+    uint16_t    card;
+    uint16_t    module;
+    uint16_t    bank;
+    uint16_t    device;
+    uint16_t    row;
+    uint16_t    column;
+    uint16_t    bit_pos;
+    uint64_t    requestor_id;
+    uint64_t    responder_id;
+    uint64_t    target_id;
+    uint8_t     error_type;
+    uint8_t     reserved;
+    uint16_t    rank;
+    uint16_t    mem_array_handle;   /* card handle in UEFI 2.4 */
+    uint16_t    mem_dev_handle;     /* module handle in UEFI 2.4 */
+} QEMU_PACKED;
+typedef struct UefiCperSecMemErr UefiCperSecMemErr;
+
+/*
+ * HEST Description Table
+ */
+struct AcpiHardwareErrorSourceTable {
+    ACPI_TABLE_HEADER_DEF                    /* ACPI common table header */
+    uint32_t           error_source_count;
+} QEMU_PACKED;
+typedef struct AcpiHardwareErrorSourceTable AcpiHardwareErrorSourceTable;
+
 #define ACPI_SRAT_PROCESSOR_APIC     0
 #define ACPI_SRAT_MEMORY             1
 #define ACPI_SRAT_PROCESSOR_x2APIC   2
-- 
1.8.3.1
