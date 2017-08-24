Received: from eggs.gnu.org ([2001:4830:134:3::10]:58054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1dkrMN-0001Vy-OF
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:35:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1dkrMM-000350-7E
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:35:43 -0400
Message-ID: <599EC7AB.3080604@huawei.com>
Date: Thu, 24 Aug 2017 20:33:47 +0800
From: Shannon Zhao <zhaoshenglong@huawei.com>
MIME-Version: 1.0
References: <1503066227-18251-1-git-send-email-gengdongjiu@huawei.com>
	<1503066227-18251-2-git-send-email-gengdongjiu@huawei.com>
In-Reply-To: <1503066227-18251-2-git-send-email-gengdongjiu@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v11 1/6] ACPI: add APEI/HEST/CPER
 structures and macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dongjiu Geng <gengdongjiu@huawei.com>, mst@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org, edk2-devel@lists.01.org, christoffer.dall@linaro.org, marc.zyngier@arm.com, will.deacon@arm.com, james.morse@arm.com, tbaicar@codeaurora.org, ard.biesheuvel@linaro.org, mingo@kernel.org, bp@suse.de, shiju.jose@huawei.com, zjzhang@codeaurora.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, john.garry@huawei.com, jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com, huangdaode@hisilicon.com, wangzhou1@hisilicon.com
Cc: huangshaoyu@huawei.com, wuquanming@huawei.com, linuxarm@huawei.com, zhengqiang10@huawei.com



On 2017/8/18 22:23, Dongjiu Geng wrote:
> (1) Add related APEI/HEST table structures and  macros, these
>     definition refer to ACPI 6.1 and UEFI 2.6 spec.
> (2) Add generic error status block and CPER memory section
>     definition, user space only handle memory section errors.
> 
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> ---
>  include/hw/acpi/acpi-defs.h | 193 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 193 insertions(+)
> 
> diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
> index 72be675..3b4bad7 100644
> --- a/include/hw/acpi/acpi-defs.h
> +++ b/include/hw/acpi/acpi-defs.h
> @@ -297,6 +297,44 @@ typedef struct AcpiMultipleApicTable AcpiMultipleApicTable;
>  #define ACPI_APIC_GENERIC_TRANSLATOR    15
>  #define ACPI_APIC_RESERVED              16   /* 16 and greater are reserved */
>  
> +/* UEFI Spec 2.6, "N.2.5 Memory Error Section */
missing "

> +#define UEFI_CPER_MEM_VALID_ERROR_STATUS     0x0001
> +#define UEFI_CPER_MEM_VALID_PA               0x0002
> +#define UEFI_CPER_MEM_VALID_PA_MASK          0x0004
> +#define UEFI_CPER_MEM_VALID_NODE             0x0008
> +#define UEFI_CPER_MEM_VALID_CARD             0x0010
> +#define UEFI_CPER_MEM_VALID_MODULE           0x0020
> +#define UEFI_CPER_MEM_VALID_BANK             0x0040
> +#define UEFI_CPER_MEM_VALID_DEVICE           0x0080
> +#define UEFI_CPER_MEM_VALID_ROW              0x0100
> +#define UEFI_CPER_MEM_VALID_COLUMN           0x0200
> +#define UEFI_CPER_MEM_VALID_BIT_POSITION     0x0400
> +#define UEFI_CPER_MEM_VALID_REQUESTOR        0x0800
> +#define UEFI_CPER_MEM_VALID_RESPONDER        0x1000
> +#define UEFI_CPER_MEM_VALID_TARGET           0x2000
> +#define UEFI_CPER_MEM_VALID_ERROR_TYPE       0x4000
> +#define UEFI_CPER_MEM_VALID_RANK_NUMBER      0x8000
> +#define UEFI_CPER_MEM_VALID_CARD_HANDLE      0x10000
> +#define UEFI_CPER_MEM_VALID_MODULE_HANDLE    0x20000
> +#define UEFI_CPER_MEM_ERROR_TYPE_MULTI_ECC   3
> +
> +/* From the ACPI 6.1 spec, "18.3.2.9 Hardware Error Notification" */
> +
It's better to refer to the first spec version of this structure and
same with others you define.

> +enum AcpiHestNotifyType {
> +    ACPI_HEST_NOTIFY_POLLED = 0,
> +    ACPI_HEST_NOTIFY_EXTERNAL = 1,
> +    ACPI_HEST_NOTIFY_LOCAL = 2,
> +    ACPI_HEST_NOTIFY_SCI = 3,
> +    ACPI_HEST_NOTIFY_NMI = 4,
> +    ACPI_HEST_NOTIFY_CMCI = 5,  /* ACPI 5.0 */
> +    ACPI_HEST_NOTIFY_MCE = 6,   /* ACPI 5.0 */
> +    ACPI_HEST_NOTIFY_GPIO = 7,  /* ACPI 6.0 */
> +    ACPI_HEST_NOTIFY_SEA = 8,   /* ACPI 6.1 */
> +    ACPI_HEST_NOTIFY_SEI = 9,   /* ACPI 6.1 */
> +    ACPI_HEST_NOTIFY_GSIV = 10, /* ACPI 6.1 */
> +    ACPI_HEST_NOTIFY_RESERVED = 11  /* 11 and greater are reserved */
In ACPI 6.2, 11 is for Software Delegated Exception, is this useful for
your patchset?

> +};
> +
>  /*
>   * MADT sub-structures (Follow MULTIPLE_APIC_DESCRIPTION_TABLE)
>   */
> @@ -474,6 +512,161 @@ struct AcpiSystemResourceAffinityTable {
>  } QEMU_PACKED;
>  typedef struct AcpiSystemResourceAffinityTable AcpiSystemResourceAffinityTable;
>  
> +/* Hardware Error Notification, from the ACPI 6.1
> + * spec, "18.3.2.9 Hardware Error Notification"
> + */
Use below style for multiple comment lines
/*
 * XXX
 */

> +struct AcpiHestNotify {
> +    uint8_t type;
> +    uint8_t length;
> +    uint16_t config_write_enable;
> +    uint32_t poll_interval;
> +    uint32_t vector;
> +    uint32_t polling_threshold_value;
> +    uint32_t polling_threshold_window;
> +    uint32_t error_threshold_value;
> +    uint32_t error_threshold_window;
> +} QEMU_PACKED;
> +typedef struct AcpiHestNotify AcpiHestNotify;
> +
> +/* From ACPI 6.1, sections "18.3.2.1 IA-32 Architecture Machine
> + * Check Exception" through "18.3.2.8 Generic Hardware Error Source version 2".
> + */
> +enum AcpiHestSourceType {
> +    ACPI_HEST_SOURCE_IA32_CHECK = 0,
> +    ACPI_HEST_SOURCE_IA32_CORRECTED_CHECK = 1,
> +    ACPI_HEST_SOURCE_IA32_NMI = 2,
What's 3, 4, 5 for?

> +    ACPI_HEST_SOURCE_AER_ROOT_PORT = 6,
> +    ACPI_HEST_SOURCE_AER_ENDPOINT = 7,
> +    ACPI_HEST_SOURCE_AER_BRIDGE = 8,
> +    ACPI_HEST_SOURCE_GENERIC_ERROR = 9,
> +    ACPI_HEST_SOURCE_GENERIC_ERROR_V2 = 10,
> +    ACPI_HEST_SOURCE_RESERVED = 11    /* 11 and greater are reserved */
> +};
> +
> +/* Block status bitmasks from ACPI 6.1, "18.3.2.7.1 Generic Error Data" */
> +#define ACPI_GEBS_UNCORRECTABLE             (1)
> +#define ACPI_GEBS_CORRECTABLE               (1 << 1)
> +#define ACPI_GEBS_MULTIPLE_UNCORRECTABLE    (1 << 2)
> +#define ACPI_GEBS_MULTIPLE_CORRECTABLE      (1 << 3)
> +/* 10 bits, error data entry count */
> +#define ACPI_GEBS_ERROR_ENTRY_COUNT         (0x3FF << 4)
> +
> +/* Generic Hardware Error Source Structure, refer to ACPI 6.1
> + * "18.3.2.7 Generic Hardware Error Source". in this struct the
> + * "type" field has to be ACPI_HEST_SOURCE_GENERIC_ERROR
> + */
> +
> +struct AcpiGenericHardwareErrorSource {
> +    uint16_t type;
> +    uint16_t source_id;
> +    uint16_t related_source_id;
> +    uint8_t flags;
> +    uint8_t enabled;
> +    uint32_t number_of_records;
> +    uint32_t max_sections_per_record;
> +    uint32_t max_raw_data_length;
> +    struct AcpiGenericAddress error_status_address;
> +    struct AcpiHestNotify notify;
> +    uint32_t error_status_block_length;
> +} QEMU_PACKED;
> +typedef struct AcpiGenericHardwareErrorSource AcpiGenericHardwareErrorSource;
> +
> +/* Generic Hardware Error Source, version 2, ACPI 6.1, "18.3.2.8 Generic
> + * Hardware Error Source version 2", in this struct the "type" field has to
> + * be ACPI_HEST_SOURCE_GENERIC_ERROR_V2
> + */
> +struct AcpiGenericHardwareErrorSourceV2 {
> +    uint16_t type;
> +    uint16_t source_id;
> +    uint16_t related_source_id;
> +    uint8_t flags;
> +    uint8_t enabled;
> +    uint32_t number_of_records;
> +    uint32_t max_sections_per_record;
> +    uint32_t max_raw_data_length;
> +    struct AcpiGenericAddress error_status_address;
> +    struct AcpiHestNotify notify;
> +    uint32_t error_status_block_length;
> +    struct AcpiGenericAddress read_ack_register;
> +    uint64_t read_ack_preserve;
> +    uint64_t read_ack_write;
> +} QEMU_PACKED;
> +typedef struct AcpiGenericHardwareErrorSourceV2
> +            AcpiGenericHardwareErrorSourceV2;
> +
> +/* Generic Error Status block, from ACPI 6.1,
> + * "18.3.2.7.1 Generic Error Data"
> + */
> +struct AcpiGenericErrorStatus {
> +    /* It is a bitmask composed of ACPI_GEBS_xxx macros */
> +    uint32_t block_status;
> +    uint32_t raw_data_offset;
> +    uint32_t raw_data_length;
> +    uint32_t data_length;
> +    uint32_t error_severity;
> +} QEMU_PACKED;
> +typedef struct AcpiGenericErrorStatus AcpiGenericErrorStatus;
> +
> +enum AcpiGenericErrorSeverity {
> +    ACPI_CPER_SEV_RECOVERABLE,
> +    ACPI_CPER_SEV_FATAL,
> +    ACPI_CPER_SEV_CORRECTED,
> +    ACPI_CPER_SEV_NONE,
> +};
> +
> +/* Generic Error Data entry, revision number is 0x0300,
> + * ACPI 6.1, "18.3.2.7.1 Generic Error Data"
> + */
> +struct AcpiGenericErrorData {
> +    uint8_t section_type_le[16];
> +    /* The "error_severity" fields that they take their
> +     * values from AcpiGenericErrorSeverity
> +     */
> +    uint32_t error_severity;
> +    uint16_t revision;
> +    uint8_t validation_bits;
> +    uint8_t flags;
> +    uint32_t error_data_length;
> +    uint8_t fru_id[16];
> +    uint8_t fru_text[20];
> +    uint64_t time_stamp;
> +} QEMU_PACKED;
> +typedef struct AcpiGenericErrorData AcpiGenericErrorData;
> +
> +/* From UEFI 2.6, "N.2.5 Memory Error Section" */
> +struct UefiCperSecMemErr {
> +    uint64_t    validation_bits;
> +    uint64_t    error_status;
> +    uint64_t    physical_addr;
> +    uint64_t    physical_addr_mask;
> +    uint16_t    node;
> +    uint16_t    card;
> +    uint16_t    module;
> +    uint16_t    bank;
> +    uint16_t    device;
> +    uint16_t    row;
> +    uint16_t    column;
> +    uint16_t    bit_pos;
> +    uint64_t    requestor_id;
> +    uint64_t    responder_id;
> +    uint64_t    target_id;
> +    uint8_t     error_type;
> +    uint8_t     reserved;
> +    uint16_t    rank;
> +    uint16_t    mem_array_handle;   /* card handle in UEFI 2.4 */
> +    uint16_t    mem_dev_handle;     /* module handle in UEFI 2.4 */
> +} QEMU_PACKED;
> +typedef struct UefiCperSecMemErr UefiCperSecMemErr;
> +
> +/*
> + * HEST Description Table
> + */
> +struct AcpiHardwareErrorSourceTable {
> +    ACPI_TABLE_HEADER_DEF                    /* ACPI common table header */
> +    uint32_t           error_source_count;
> +} QEMU_PACKED;
> +typedef struct AcpiHardwareErrorSourceTable AcpiHardwareErrorSourceTable;
> +
>  #define ACPI_SRAT_PROCESSOR_APIC     0
>  #define ACPI_SRAT_MEMORY             1
>  #define ACPI_SRAT_PROCESSOR_x2APIC   2
> 

-- 
Shannon
