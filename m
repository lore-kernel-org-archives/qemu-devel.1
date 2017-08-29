Received: from eggs.gnu.org ([2001:4830:134:3::10]:55902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1dmeZQ-00054y-BU
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 07:20:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1dmeZM-0008I5-Nz
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 07:20:36 -0400
References: <1503066227-18251-1-git-send-email-gengdongjiu@huawei.com>
	<1503066227-18251-3-git-send-email-gengdongjiu@huawei.com>
	<20170829122053.36cf550c@nial.brq.redhat.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <ddc75cd8-6bb6-343e-eafe-bfa69827b474@huawei.com>
Date: Tue, 29 Aug 2017 19:15:36 +0800
MIME-Version: 1.0
In-Reply-To: <20170829122053.36cf550c@nial.brq.redhat.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v11 2/6] ACPI: Add APEI GHES Table
 Generation support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: mst@redhat.com, zhaoshenglong@huawei.com, lersek@redhat.com, peter.maydell@linaro.org, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org, edk2-devel@lists.01.org, christoffer.dall@linaro.org, marc.zyngier@arm.com, will.deacon@arm.com, james.morse@arm.com, tbaicar@codeaurora.org, ard.biesheuvel@linaro.org, mingo@kernel.org, bp@suse.de, shiju.jose@huawei.com, zjzhang@codeaurora.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, john.garry@huawei.com, jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com, huangdaode@hisilicon.com, wangzhou1@hisilicon.com, zhengqiang10@huawei.com, wuquanming@huawei.com, huangshaoyu@huawei.com, linuxarm@huawei.com

Igor,
  Thank you very much for your review and comments, I will check your comments in detail and reply to you.


On 2017/8/29 18:20, Igor Mammedov wrote:
> On Fri, 18 Aug 2017 22:23:43 +0800
> Dongjiu Geng <gengdongjiu@huawei.com> wrote:
> 
>> This implements APEI GHES Table by passing the error CPER info
>> to the guest via a fw_cfg_blob. After a CPER info is recorded, an
>> SEA(Synchronous External Abort)/SEI(SError Interrupt) exception
>> will be injected into the guest OS.
> 
> it's a bit complex patch/functionality so I've just mosty skimmed and
> commented only on structure of the patch and changes I'd like to see
> so it would be more structured and review-able.
> 
> I'd suggest to add doc patch first which will describe how it's
> supposed to work between QEMU/firmware/guest OS with expected
> flows.
>  
>> Below is the table layout, the max number of error soure is 11,
>> which is classified by notification type.
>>
>>      etc/acpi/tables                               etc/hardware_errors
>>     ====================                    ==========================================
>> + +--------------------------+            +------------------+
>> | | HEST                     |            |    address       |              +--------------+
>> | +--------------------------+            |    registers     |              | Error Status |
>> | | GHES0                    |            | +----------------+              | Data Block 0 |
>> | +--------------------------+ +--------->| |status_address0 |------------->| +------------+
>> | | .................        | |          | +----------------+              | |  CPER      |
>> | | error_status_address-----+-+ +------->| |status_address1 |----------+   | |  CPER      |
>> | | .................        |   |        | +----------------+          |   | |  ....      |
>> | | read_ack_register--------+-+ |        |  .............   |          |   | |  CPER      |
>> | | read_ack_preserve        | | |        +------------------+          |   | +-+------------+
>> | | read_ack_write           | | | +----->| |status_address10|--------+ |   | Error Status |
>> + +--------------------------+ | | |      | +----------------+        | |   | Data Block 1 |
>> | | GHES1                    | +-+-+----->| | ack_value0     |        | +-->| +------------+
>> + +--------------------------+   | |      | +----------------+        |     | |  CPER      |
>> | | .................        |   | | +--->| | ack_value1     |        |     | |  CPER      |
>> | | error_status_address-----+---+ | |    | +----------------+        |     | |  ....      |
>> | | .................        |     | |    | |  ............. |        |     | |  CPER      |
>> | | read_ack_register--------+-----+-+    | +----------------+        |     +-+------------+
>> | | read_ack_preserve        |     |   +->| | ack_value10    |        |     | |..........  |
>> | | read_ack_write           |     |   |  | +----------------+        |     | +------------+
>> + +--------------------------|     |   |                              |     | Error Status |
>> | | ...............          |     |   |                              |     | Data Block 10|
>> + +--------------------------+     |   |                              +---->| +------------+
>> | | GHES10                   |     |   |                                    | |  CPER      |
>> + +--------------------------+     |   |                                    | |  CPER      |
>> | | .................        |     |   |                                    | |  ....      |
>> | | error_status_address-----+-----+   |                                    | |  CPER      |
>> | | .................        |         |                                    +-+------------+
>> | | read_ack_register--------+---------+
>> | | read_ack_preserve        |
>> | | read_ack_write           |
>> + +--------------------------+
> these diagram shows relations between tables which not necessarily bad
> but as layout it's useless.
>  * Probably there is not much sense to have HEST table here, it's described
>    well enough in spec. You might just put reference here.
>  * these diagrams should go into doc/spec patch
>  * when you describe layout you need to show what and at what offsets
>    in which order in which blob/file is located. See ACPI spec for example
>    and/or docs/specs/acpi_nvdimm.txt docs/specs/acpi_mem_hotplug.txt for inspiration.
> 
>> For GHESv2 error source, the OSPM must acknowledges the error via Read Ack register.
>> so user space must check the ack value to avoid read-write race condition.
>>
>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>> ---
>>  hw/acpi/aml-build.c         |   2 +
>>  hw/acpi/hest_ghes.c         | 345 ++++++++++++++++++++++++++++++++++++++++++++
>>  hw/arm/virt-acpi-build.c    |   6 +
>>  include/hw/acpi/aml-build.h |   1 +
>>  include/hw/acpi/hest_ghes.h |  47 ++++++
>>  5 files changed, 401 insertions(+)
>>  create mode 100644 hw/acpi/hest_ghes.c
>>  create mode 100644 include/hw/acpi/hest_ghes.h
>>
>> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
>> index 36a6cc4..6849e5f 100644
>> --- a/hw/acpi/aml-build.c
>> +++ b/hw/acpi/aml-build.c
>> @@ -1561,6 +1561,7 @@ void acpi_build_tables_init(AcpiBuildTables *tables)
>>      tables->table_data = g_array_new(false, true /* clear */, 1);
>>      tables->tcpalog = g_array_new(false, true /* clear */, 1);
>>      tables->vmgenid = g_array_new(false, true /* clear */, 1);
>> +    tables->hardware_errors = g_array_new(false, true /* clear */, 1);
>>      tables->linker = bios_linker_loader_init();
>>  }
>>  
>> @@ -1571,6 +1572,7 @@ void acpi_build_tables_cleanup(AcpiBuildTables *tables, bool mfre)
>>      g_array_free(tables->table_data, true);
>>      g_array_free(tables->tcpalog, mfre);
>>      g_array_free(tables->vmgenid, mfre);
>> +    g_array_free(tables->hardware_errors, mfre);
>>  }
>>  
>>  /* Build rsdt table */
>> diff --git a/hw/acpi/hest_ghes.c b/hw/acpi/hest_ghes.c
>> new file mode 100644
>> index 0000000..ff6b5ef
>> --- /dev/null
>> +++ b/hw/acpi/hest_ghes.c
>> @@ -0,0 +1,345 @@
>> +/*
>> + *  APEI GHES table Generation
>> + *
>> + *  Copyright (C) 2017 huawei.
>> + *
>> + *  Author: Dongjiu Geng <gengdongjiu@huawei.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> + * See the COPYING file in the top-level directory.
>> + *
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qmp-commands.h"
>> +#include "hw/acpi/acpi.h"
>> +#include "hw/acpi/aml-build.h"
>> +#include "hw/acpi/hest_ghes.h"
>> +#include "hw/nvram/fw_cfg.h"
>> +#include "sysemu/sysemu.h"
>> +#include "qemu/error-report.h"
>> +
>> +/* The structure that stands for the layout
>> + * GHES_ERRORS_FW_CFG_FILE fw_cfg blob
>> + *
>> + *           etc/hardware_errors
>> + * ==========================================
>> + * +------------------+
>> + * |    address       |              +--------------+
>> + * |    registers     |              | Error Status |
>> + * | +----------------+              | Data Block 0 |
>> + * | |status_address0 |------------->| +------------+
>> + * | +----------------+              | |  CPER      |
>> + * | |status_address1 |----------+   | |  CPER      |
>> + * | +----------------+          |   | |  ....      |
>> + * | |.............   |          |   | |  CPER      |
>> + * | +----------------+          |   | +------------+
>> + * | |status_address10|-----+    |   | Error Status |
>> + * | +----------------+     |    |   | Data Block 1 |
>> + * | |ack_value0      |     |    +-->| +------------+
>> + * | +----------------+     |        | |  CPER      |
>> + * | |ack_value1      |     |        | |  CPER      |
>> + * | +----------------+     |        | |  ....      |
>> + * | | .............  |     |        | |  CPER      |
>> + * | +----------------+     |        +-+------------+
>> + * | |ack_value10     |     |        | |..........  |
>> + * | +----------------+     |        | +------------+
>> + *                          |        | Error Status |
>> + *                          |        | Data Block10 |
>> + *                          +------->+------------+
>> + *                                   | |  CPER      |
>> + *                                   | |  CPER      |
>> + *                                   | |  ....      |
>> + *                                   | |  CPER      |
>> + *                                   +-+------------+
>> + */
>> +struct hardware_errors_buffer {
>> +    /* Generic Error Status Block register */
>> +    uint64_t gesb_address[GHES_ACPI_HEST_NOTIFY_RESERVED];
>> +    uint64_t ack_value[GHES_ACPI_HEST_NOTIFY_RESERVED];
>> +    char gesb[GHES_MAX_RAW_DATA_LENGTH][GHES_ACPI_HEST_NOTIFY_RESERVED];
>> +};
>> +
>> +static int ghes_record_cper(uint64_t error_block_address,
>> +                                    uint64_t error_physical_addr)
>> +{
>> +    AcpiGenericErrorStatus block;
>> +    AcpiGenericErrorData *gdata;
>> +    UefiCperSecMemErr *mem_err;
>> +    uint64_t current_block_length;
>> +    unsigned char *buffer;
>> +    /* memory section */
>> +    char mem_section_id_le[] = {0x14, 0x11, 0xBC, 0xA5, 0x64, 0x6F, 0xDE,
>> +                              0x4E, 0xB8, 0x63, 0x3E, 0x83, 0xED, 0x7C,
>> +                              0x83, 0xB1};
>> +
>> +    cpu_physical_memory_read(error_block_address, &block,
>> +                                sizeof(AcpiGenericErrorStatus));
>> +
>> +    /* Get the current generic error status block length */
>> +    current_block_length = sizeof(AcpiGenericErrorStatus) +
>> +        le32_to_cpu(block.data_length);
>> +
>> +    /* If the Generic Error Status Block is NULL, update
>> +     * the block header
>> +     */
>> +    if (!block.block_status) {
>> +        block.block_status = ACPI_GEBS_UNCORRECTABLE;
>> +        block.error_severity = ACPI_CPER_SEV_RECOVERABLE;
>> +    }
>> +
>> +    block.data_length += cpu_to_le32(sizeof(AcpiGenericErrorData));
>> +    block.data_length += cpu_to_le32(sizeof(UefiCperSecMemErr));
>> +
>> +    /* check whether it runs out of the preallocated memory */
>> +    if ((le32_to_cpu(block.data_length) + sizeof(AcpiGenericErrorStatus)) >
>> +       GHES_MAX_RAW_DATA_LENGTH) {
>> +        error_report("Record CPER out of boundary!!!");
>> +        return GHES_CPER_FAIL;
>> +    }
>> +
>> +    /* Write back the Generic Error Status Block to guest memory */
>> +    cpu_physical_memory_write(error_block_address, &block,
>> +        sizeof(AcpiGenericErrorStatus));
>> +
>> +    /* Fill in Generic Error Data Entry */
>> +    buffer = g_malloc0(sizeof(AcpiGenericErrorData) +
>> +                       sizeof(UefiCperSecMemErr));
>> +
>> +
>> +    memset(buffer, 0, sizeof(AcpiGenericErrorData) + sizeof(UefiCperSecMemErr));
> looks redundant, g_malloc0 does it for you
> 
>> +    gdata = (AcpiGenericErrorData *)buffer;
>> +
>> +    /* Memory section */
>> +    memcpy(&(gdata->section_type_le), &mem_section_id_le,
>> +            sizeof(mem_section_id_le));
>> +
>> +    /* error severity is recoverable */
>> +    gdata->error_severity = ACPI_CPER_SEV_RECOVERABLE;
>> +    gdata->revision = 0x300; /* the revision number is 0x300 */
>> +    gdata->error_data_length = cpu_to_le32(sizeof(UefiCperSecMemErr));
>> +
>> +    mem_err = (UefiCperSecMemErr *) (gdata + 1);
>> +
>> +    /* User space only handle the memory section CPER */
>> +
>> +    /* Hard code to Multi-bit ECC error */
>> +    mem_err->validation_bits |= cpu_to_le32(UEFI_CPER_MEM_VALID_ERROR_TYPE);
>> +    mem_err->error_type = cpu_to_le32(UEFI_CPER_MEM_ERROR_TYPE_MULTI_ECC);
>> +
>> +    /* Record the physical address at which the memory error occurred */
>> +    mem_err->validation_bits |= cpu_to_le32(UEFI_CPER_MEM_VALID_PA);
>> +    mem_err->physical_addr = cpu_to_le32(error_physical_addr);
> 
> I'd prefer for you to use build_append_int_noprefix() API to compose
> whole error status block
> 
> and try to get rid of most structures you introduce in patch 1/6,
> as they will be left unused after that.
> 
>> +
>> +    /* Write back the Generic Error Data Entry to guest memory */
>> +    cpu_physical_memory_write(error_block_address + current_block_length,
>> +        buffer, sizeof(AcpiGenericErrorData) + sizeof(UefiCperSecMemErr));
>> +
>> +    g_free(buffer);
>> +    return GHES_CPER_OK;
>> +}
>> +
>> +static void
>> +build_address(GArray *table_data, BIOSLinker *linker,
>> +    uint32_t dst_patched_offset, uint32_t src_offset,
>> +    uint8_t address_space_id , uint8_t  register_bit_width,
>> +    uint8_t register_bit_offset, uint8_t access_size)
>> +{
>> +    uint32_t address_size = sizeof(struct AcpiGenericAddress) -
>> +        offsetof(struct AcpiGenericAddress, address);
>> +
>> +    /* Address space */
>> +    build_append_int_noprefix(table_data, address_space_id, 1);
>> +    /* register bit width */
>> +    build_append_int_noprefix(table_data, register_bit_width, 1);
>> +    /* register bit offset */
>> +    build_append_int_noprefix(table_data, register_bit_offset, 1);
>> +    /* access size */
>> +    build_append_int_noprefix(table_data, access_size, 1);
>> +    acpi_data_push(table_data, address_size);
>> +
>> +    /* Patch address of ERRORS fw_cfg blob into the TABLE fw_cfg blob so OSPM
>> +     * can retrieve and read it. the address size is 64 bits.
>> +     */
>> +    bios_linker_loader_add_pointer(linker,
>> +        ACPI_BUILD_TABLE_FILE, dst_patched_offset, sizeof(uint64_t),
>> +        GHES_ERRORS_FW_CFG_FILE, src_offset);
>> +}
> It's mostly generic GAS structure with linker addition.
> I'd suggest to reuse something like
>  https://github.com/imammedo/qemu/commit/3d2fd6d13a3ea298d2ee814835495ce6241d085c
> to build GAS and use bios_linker_loader_add_pointer() directly in ghes_build_acpi().
> 
>> +void ghes_build_acpi(GArray *table_data, GArray *hardware_error,
>> +                                            BIOSLinker *linker)
>> +{
>> +    uint32_t ghes_start = table_data->len;
>> +    uint32_t address_size, error_status_address_offset;
>> +    uint32_t read_ack_register_offset, i;
>> +
>> +    address_size = sizeof(struct AcpiGenericAddress) -
>> +        offsetof(struct AcpiGenericAddress, address);
> it's confusing name for var,
> AcpiGenericAddress::address is fixed unsigned 64 bit integer per spec
> also, I'm not sure why it's needed at all.
> 
>> +
>> +    error_status_address_offset = ghes_start +
>> +        sizeof(AcpiHardwareErrorSourceTable) +
>> +        offsetof(AcpiGenericHardwareErrorSourceV2, error_status_address) +
>> +        offsetof(struct AcpiGenericAddress, address);
>> +
>> +    read_ack_register_offset = ghes_start +
>> +        sizeof(AcpiHardwareErrorSourceTable) +
>> +        offsetof(AcpiGenericHardwareErrorSourceV2, read_ack_register) +
>> +        offsetof(struct AcpiGenericAddress, address);
> it's really hard to get why you use offsetof() so much in this function,
> to me above code totally unreadable.
> 
>> +    acpi_data_push(hardware_error,
>> +        offsetof(struct hardware_errors_buffer, ack_value));
> it looks like you are trying to build several tables within one function,
> so it's hard to get what's going on.
> I'd suggest to build separate table independently where it's possible.
> 
> i.e. build independent tables first
> and only then build dependent tables passing to it pointers
> to previously build table if necessary.
> 
>> +    for (i = 0; i < GHES_ACPI_HEST_NOTIFY_RESERVED; i++)
>> +        /* Initialize read ack register */
>> +        build_append_int_noprefix((void *)hardware_error, 1, 8);
>> +
>> +    /* Reserved the total size for ERRORS fw_cfg blob
>> +     */
>> +    acpi_data_push(hardware_error, sizeof(struct hardware_errors_buffer));
>> +
>> +    /* Allocate guest memory for the Data fw_cfg blob */
>> +    bios_linker_loader_alloc(linker, GHES_ERRORS_FW_CFG_FILE, hardware_error,
>> +                            1, false);
>> +    /* Reserve table header size */
>> +    acpi_data_push(table_data, sizeof(AcpiTableHeader));
>> +
>> +    build_append_int_noprefix(table_data, GHES_ACPI_HEST_NOTIFY_RESERVED, 4);
> GHES_ACPI_HEST_NOTIFY_RESERVED - name doesn't actually tell what it is
> I'd suggest to use spec field name wit table prefix, ex:
> ACPI_HEST_ERROR_SOURCE_COUNT
> 
> also, beside build_append_int_noprefix() you need to at least
> add comment that exactly matches field from spec.
> 
> the same applies to other fields you are adding in this patch
> 
>> +
>> +    for (i = 0; i < GHES_ACPI_HEST_NOTIFY_RESERVED; i++) {
>> +        build_append_int_noprefix(table_data,
>> +            ACPI_HEST_SOURCE_GENERIC_ERROR_V2, 2); /* type */
>> +        /* source id */
>> +        build_append_int_noprefix(table_data, cpu_to_le16(i), 2);
>> +        /* related source id */
>> +        build_append_int_noprefix(table_data, 0xffff, 2);
>> +        build_append_int_noprefix(table_data, 0, 1); /* flags */
>> +
>> +        /* Currently only enable SEA notification type to avoid the kernel
>> +         * warning, reserve the space for other notification error source
>> +         */
>> +        if (i == ACPI_HEST_NOTIFY_SEA) {
>> +            build_append_int_noprefix(table_data, 1, 1); /* enabled */
>> +        } else {
>> +            build_append_int_noprefix(table_data, 0, 1); /* enabled */
>> +        }
>> +
>> +        /* The number of error status block per generic hardware error source */
>> +        build_append_int_noprefix(table_data, 1, 4);
>> +        /* Max sections per record */
>> +        build_append_int_noprefix(table_data, 1, 4);
>> +        /* Max raw data length */
>> +        build_append_int_noprefix(table_data, GHES_MAX_RAW_DATA_LENGTH, 4);
>> +
>> +        /* Build error status address*/
>> +        build_address(table_data, linker, error_status_address_offset + i *
>> +            sizeof(AcpiGenericHardwareErrorSourceV2), i * address_size,
>> +            AML_SYSTEM_MEMORY, 0x40, 0, 4 /* QWord access */);
> just do something like this instead of build_address():
> build_append_gas()
> bios_linker_loader_add_pointer()
> 
> also register width 0x40 looks suspicious, where does it come from?
> While at it do you have a real hardware which has HEST table that you re trying to model after?
> I'd like to see HEST and other related tables from it.
> 
>> +
>> +        /* Hardware error notification structure */
>> +        build_append_int_noprefix(table_data, i, 1); /* type */
>> +        /* length */
>> +        build_append_int_noprefix(table_data, sizeof(AcpiHestNotify), 1);
>> +        build_append_int_noprefix(table_data, 0, 26);
>> +
>> +        /* Error Status Block Length */
>> +        build_append_int_noprefix(table_data,
>> +            cpu_to_le32(GHES_MAX_RAW_DATA_LENGTH), 4);
>> +
>> +        /* Build read ack register */
>> +        build_address(table_data, linker, read_ack_register_offset + i *
>> +            sizeof(AcpiGenericHardwareErrorSourceV2),
>> +            offsetof(struct hardware_errors_buffer, ack_value) +
>> +            i * address_size, AML_SYSTEM_MEMORY, 0x40, 0,
>> +            4 /* QWord access */);
>> +
>> +        /* Read ack preserve */
>> +        build_append_int_noprefix(table_data, cpu_to_le64(0xfffffffe), 8);
>> +
>> +        /* Read ack write */
>> +        build_append_int_noprefix(table_data, cpu_to_le64(0x1), 8);
>> +    }
>> +
>> +    for (i = 0; i < GHES_ACPI_HEST_NOTIFY_RESERVED; i++)
>> +        /* Patch address of generic error status block into
>> +         * the address register so OSPM can retrieve and read it.
>> +         */
>> +        bios_linker_loader_add_pointer(linker,
>> +            GHES_ERRORS_FW_CFG_FILE, address_size * i, address_size,
>> +            GHES_ERRORS_FW_CFG_FILE,
>> +            offsetof(struct hardware_errors_buffer, gesb) +
>> +            i * GHES_MAX_RAW_DATA_LENGTH);
>> +
>> +    /* Patch address of ERRORS fw_cfg blob into the ADDR fw_cfg blob
>> +     * so QEMU can write the ERRORS there. The address is expected to be
>> +     * < 4GB, but write 64 bits anyway.
>> +     */
>> +    bios_linker_loader_write_pointer(linker, GHES_DATA_ADDR_FW_CFG_FILE,
>> +        0, address_size, GHES_ERRORS_FW_CFG_FILE,
>> +        offsetof(struct hardware_errors_buffer, gesb));
>> +
>> +    build_header(linker, table_data,
>> +        (void *)(table_data->data + ghes_start), "HEST",
>> +        table_data->len - ghes_start, 1, NULL, "GHES");
>> +}
>> +
>> +static GhesState ges;
>> +void ghes_add_fw_cfg(FWCfgState *s, GArray *hardware_error)
>> +{
>> +
>> +    size_t request_block_size = sizeof(uint64_t) + GHES_MAX_RAW_DATA_LENGTH;
>> +    size_t size = GHES_ACPI_HEST_NOTIFY_RESERVED * request_block_size;
>> +
>> +    /* Create a read-only fw_cfg file for GHES */
>> +    fw_cfg_add_file(s, GHES_ERRORS_FW_CFG_FILE, hardware_error->data,
>> +                    size);
>> +    /* Create a read-write fw_cfg file for Address */
>> +    fw_cfg_add_file_callback(s, GHES_DATA_ADDR_FW_CFG_FILE, NULL, NULL,
>> +        &ges.ghes_addr_le, sizeof(ges.ghes_addr_le), false);
>> +}
>> +
>> +bool ghes_update_guest(uint32_t notify, uint64_t physical_address)
>> +{
>> +    uint64_t error_block_addr;
>> +    uint64_t ack_value_addr, ack_value = 0;
>> +    int loop = 0, ack_value_size;
>> +    bool ret = GHES_CPER_FAIL;
>> +
>> +    ack_value_size = (offsetof(struct hardware_errors_buffer, gesb) -
>> +        offsetof(struct hardware_errors_buffer, ack_value)) /
>> +            GHES_ACPI_HEST_NOTIFY_RESERVED;
>> +
>> +    if (physical_address && notify < GHES_ACPI_HEST_NOTIFY_RESERVED) {
>> +        error_block_addr = ges.ghes_addr_le + notify * GHES_MAX_RAW_DATA_LENGTH;
>> +        error_block_addr = le32_to_cpu(error_block_addr);
>> +
>> +        ack_value_addr = ges.ghes_addr_le -
>> +            (GHES_ACPI_HEST_NOTIFY_RESERVED - notify) * ack_value_size;
>> +retry:
>> +        cpu_physical_memory_read(ack_value_addr, &ack_value, ack_value_size);
>> +        if (!ack_value) {
>> +            if (loop < 3) {
>> +                usleep(100 * 1000);
>> +                loop++;
>> +                goto retry;
>> +            } else {
>> +                error_report("Last time OSPM does not acknowledge the error,"
>> +                    " record CPER failed this time, set the ack value to"
>> +                    " avoid blocking next time CPER record! exit");
>> +                ack_value = 1;
>> +                cpu_physical_memory_write(ack_value_addr,
>> +                    &ack_value, ack_value_size);
>> +                return ret;
>> +            }
>> +        } else {
>> +            /* A zero value in ghes_addr means that BIOS has not yet written
>> +             * the address
>> +             */
>> +            if (error_block_addr) {
>> +                ack_value = 0;
>> +                cpu_physical_memory_write(ack_value_addr,
>> +                    &ack_value, ack_value_size);
>> +                ret = ghes_record_cper(error_block_addr, physical_address);
>> +            }
>> +        }
>> +    }
>> +    return ret;
>> +}
>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>> index 3d78ff6..def1ec1 100644
>> --- a/hw/arm/virt-acpi-build.c
>> +++ b/hw/arm/virt-acpi-build.c
>> @@ -45,6 +45,7 @@
>>  #include "hw/arm/virt.h"
>>  #include "sysemu/numa.h"
>>  #include "kvm_arm.h"
>> +#include "hw/acpi/hest_ghes.h"
>>  
>>  #define ARM_SPI_BASE 32
>>  #define ACPI_POWER_BUTTON_DEVICE "PWRB"
>> @@ -771,6 +772,9 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>>      acpi_add_table(table_offsets, tables_blob);
>>      build_spcr(tables_blob, tables->linker, vms);
>>  
>> +    acpi_add_table(table_offsets, tables_blob);
>> +    ghes_build_acpi(tables_blob, tables->hardware_errors, tables->linker);
>> +
>>      if (nb_numa_nodes > 0) {
>>          acpi_add_table(table_offsets, tables_blob);
>>          build_srat(tables_blob, tables->linker, vms);
>> @@ -887,6 +891,8 @@ void virt_acpi_setup(VirtMachineState *vms)
>>      fw_cfg_add_file(vms->fw_cfg, ACPI_BUILD_TPMLOG_FILE, tables.tcpalog->data,
>>                      acpi_data_len(tables.tcpalog));
>>  
>> +    ghes_add_fw_cfg(vms->fw_cfg, tables.hardware_errors);
>> +
>>      build_state->rsdp_mr = acpi_add_rom_blob(build_state, tables.rsdp,
>>                                                ACPI_BUILD_RSDP_FILE, 0);
>>  
>> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
>> index 88d0738..7f7b55c 100644
>> --- a/include/hw/acpi/aml-build.h
>> +++ b/include/hw/acpi/aml-build.h
>> @@ -211,6 +211,7 @@ struct AcpiBuildTables {
>>      GArray *rsdp;
>>      GArray *tcpalog;
>>      GArray *vmgenid;
>> +    GArray *hardware_errors;
>>      BIOSLinker *linker;
>>  } AcpiBuildTables;
>>  
>> diff --git a/include/hw/acpi/hest_ghes.h b/include/hw/acpi/hest_ghes.h
>> new file mode 100644
>> index 0000000..0772756
>> --- /dev/null
>> +++ b/include/hw/acpi/hest_ghes.h
>> @@ -0,0 +1,47 @@
>> +/*
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> +
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * Authors:
>> + *   Dongjiu Geng <gengdongjiu@huawei.com>
>> + *
>> + * You should have received a copy of the GNU General Public License along
>> + * with this program; if not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#ifndef ACPI_GHES_H
>> +#define ACPI_GHES_H
>> +
>> +#include "hw/acpi/bios-linker-loader.h"
>> +
>> +#define GHES_ERRORS_FW_CFG_FILE      "etc/hardware_errors"
>> +#define GHES_DATA_ADDR_FW_CFG_FILE      "etc/hardware_errors_addr"
>> +
>> +#define GHES_GAS_ADDRESS_OFFSET              4
>> +#define GHES_ERROR_STATUS_ADDRESS_OFFSET     20
>> +#define GHES_NOTIFICATION_STRUCTURE          32
>> +
>> +#define GHES_CPER_OK   1
>> +#define GHES_CPER_FAIL 0
>> +
>> +#define GHES_ACPI_HEST_NOTIFY_RESERVED           11
>> +/* The max size in Bytes for one error block */
>> +#define GHES_MAX_RAW_DATA_LENGTH                 0x1000
>> +
>> +
>> +typedef struct GhesState {
>> +    uint64_t ghes_addr_le;
>> +} GhesState;
>> +
>> +void ghes_build_acpi(GArray *table_data, GArray *hardware_error,
>> +                            BIOSLinker *linker);
>> +void ghes_add_fw_cfg(FWCfgState *s, GArray *hardware_errors);
>> +bool ghes_update_guest(uint32_t notify, uint64_t error_physical_addr);
>> +#endif
> 
> 
> .
> 
