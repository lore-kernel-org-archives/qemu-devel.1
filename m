Received: from eggs.gnu.org ([2001:4830:134:3::10]:53372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d9KSr-0006ZN-S2
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:59:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d9KSp-0003yc-7r
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:59:17 -0400
Date: Sat, 13 May 2017 02:59:01 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170513002820-mutt-send-email-mst@kernel.org>
References: <1493530506-26833-1-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1493530506-26833-1-git-send-email-gengdongjiu@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/4] ACPI: Add APEI GHES Table
 Generation support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: james.morse@arm.com, marc.zyngier@arm.com, christoffer.dall@linaro.org, rkrcmar@redhat.com, linux@armlinux.org.uk, tbaicar@codeaurora.org, imammedo@redhat.com, zhaoshenglong@huawei.com, peter.maydell@linaro.org, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, lersek@redhat.com, ard.biesheuvel@linaro.org, drjones@redhat.com, ben@skyportsystems.com, kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, xiexiuqi@huawei.com, wangxiongfeng2@huawei.com, songwenjun@huawei.com, wuquanming@huawei.com, huangshaoyu@huawei.com

On Sun, Apr 30, 2017 at 01:35:03PM +0800, Dongjiu Geng wrote:
> This implements APEI GHES Table by passing the error cper info
> to the guest via a fw_cfg_blob. After a CPER info is added, an
> SEA/SEI exception will be injected into the guest OS.
> 
> Below is the table layout, the max number of error soure is 11,
> which is classified by notification type.
> 
> etc/acpi/tables                 etc/hardware_errors
> ================     ==========================================
>                      +-----------+
> +--------------+     | address   |         +-> +--------------+
> |    HEST      +     | registers |         |   | Error Status |
> + +------------+     | +---------+         |   | Data Block 1 |
> | | GHES1      | --> | |address1 | --------+   | +------------+
> | | GHES2      | --> | |address2 | ------+     | |  CPER      |
> | | GHES3      | --> | |address3 | ----+ |     | |  CPER      |
> | |  ....      | --> | | ....... |     | |     | |  CPER      |
> | | GHES10     | --> | |address10| -+  | |     | |  CPER      |
> +-+------------+     +-+---------+  |  | |     +-+------------+
>                                     |  | |
>                                     |  | +---> +--------------+
>                                     |  |       | Error Status |
>                                     |  |       | Data Block 2 |
>                                     |  |       | +------------+
>                                     |  |       | |  CPER      |
>                                     |  |       | |  CPER      |
>                                     |  |       +-+------------+
>                                     |  |
>                                     |  +-----> +--------------+
>                                     |          | Error Status |
>                                     |          | Data Block 3 |
>                                     |          | +------------+
>                                     |          | |  CPER      |
>                                     |          +-+------------+
>                                     |            ...........
>                                     +--------> +--------------+
>                                                | Error Status |
>                                                | Data Block 10|
>                                                | +------------+
>                                                | |  CPER      |
>                                                | |  CPER      |
>                                                | |  CPER      |
>                                                +-+------------+
> 
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> ---
>  default-configs/arm-softmmu.mak |   1 +
>  hw/acpi/Makefile.objs           |   1 +
>  hw/acpi/aml-build.c             |   2 +
>  hw/acpi/hest_ghes.c             | 203 +++++++++++++++++++++++++++++++++++
>  hw/arm/virt-acpi-build.c        |   6 ++
>  include/hw/acpi/acpi-defs.h     | 227 ++++++++++++++++++++++++++++++++++++++++
>  include/hw/acpi/aml-build.h     |   1 +
>  include/hw/acpi/hest_ghes.h     |  43 ++++++++
>  8 files changed, 484 insertions(+)
>  create mode 100644 hw/acpi/hest_ghes.c
>  create mode 100644 include/hw/acpi/hest_ghes.h
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 1e3bd2b..d5f1552 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -121,3 +121,4 @@ CONFIG_ACPI=y
>  CONFIG_SMBIOS=y
>  CONFIG_ASPEED_SOC=y
>  CONFIG_GPIO_KEY=y
> +CONFIG_ACPI_APEI_GENERATION=y
> diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
> index 11c35bc..776b46e 100644
> --- a/hw/acpi/Makefile.objs
> +++ b/hw/acpi/Makefile.objs
> @@ -6,6 +6,7 @@ common-obj-$(CONFIG_ACPI_MEMORY_HOTPLUG) += memory_hotplug.o
>  common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) += cpu.o
>  common-obj-$(CONFIG_ACPI_NVDIMM) += nvdimm.o
>  common-obj-$(CONFIG_ACPI_VMGENID) += vmgenid.o
> +common-obj-$(CONFIG_ACPI_APEI_GENERATION) += hest_ghes.o
>  common-obj-$(call lnot,$(CONFIG_ACPI_X86)) += acpi-stub.o
>  
>  common-obj-y += acpi_interface.o
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index c6f2032..802b98d 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -1560,6 +1560,7 @@ void acpi_build_tables_init(AcpiBuildTables *tables)
>      tables->table_data = g_array_new(false, true /* clear */, 1);
>      tables->tcpalog = g_array_new(false, true /* clear */, 1);
>      tables->vmgenid = g_array_new(false, true /* clear */, 1);
> +    tables->hardware_errors = g_array_new(false, true /* clear */, 1);
>      tables->linker = bios_linker_loader_init();
>  }
>  
> @@ -1570,6 +1571,7 @@ void acpi_build_tables_cleanup(AcpiBuildTables *tables, bool mfre)
>      g_array_free(tables->table_data, true);
>      g_array_free(tables->tcpalog, mfre);
>      g_array_free(tables->vmgenid, mfre);
> +    g_array_free(tables->hardware_errors, mfre);
>  }
>  
>  /* Build rsdt table */
> diff --git a/hw/acpi/hest_ghes.c b/hw/acpi/hest_ghes.c
> new file mode 100644
> index 0000000..91d382e
> --- /dev/null
> +++ b/hw/acpi/hest_ghes.c
> @@ -0,0 +1,203 @@
> +/*
> + *  APEI GHES table Generation
> + *
> + *  Copyright (C) 2017 huawei.
> + *
> + *  Author: Dongjiu Geng <gengdongjiu@huawei.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qmp-commands.h"
> +#include "hw/acpi/acpi.h"
> +#include "hw/acpi/aml-build.h"
> +#include "hw/acpi/hest_ghes.h"
> +#include "hw/nvram/fw_cfg.h"
> +#include "sysemu/sysemu.h"
> +
> +static int ghes_generate_cper_record(uint64_t block_error_address,
> +                                    uint64_t error_physical_addr)
> +{
> +    AcpiGenericErrorStatus block;
> +    AcpiGenericErrorData *gdata;
> +    struct cper_sec_mem_err *mem_err;
> +    uint64_t block_data_length;
> +    unsigned char *buffer;
> +
> +    cpu_physical_memory_read(block_error_address, &block,
> +                                sizeof(AcpiGenericErrorStatus));
> +
> +    block_data_length = sizeof(AcpiGenericErrorStatus) + block.data_length;
> +
> +    /* If the Generic Error Status Block is NULL, update
> +     * the block header
> +     */
> +    if (!block.block_status) {
> +        block.block_status = ACPI_BERT_UNCORRECTABLE;
> +        block.error_severity = CPER_SEV_FATAL;
> +    }
> +
> +    block.data_length += sizeof(AcpiGenericErrorData);
> +    block.data_length += sizeof(struct cper_sec_mem_err);
> +
> +    /* Write back the Generic Error Status Block to guest memory */
> +    cpu_physical_memory_write(block_error_address, &block,
> +                        sizeof(AcpiGenericErrorStatus));
> +
> +    /* Fill in Generic Error Data Entry */
> +    buffer = g_malloc(sizeof(AcpiGenericErrorData) + sizeof(cper_sec_mem_err));
> +    memset(buffer, 0, sizeof(AcpiGenericErrorData) + sizeof(cper_sec_mem_err));
> +    gdata = (AcpiGenericErrorData *)buffer;
> +
> +    memcpy(gdata->section_type, (void *) &CPER_SEC_PLATFORM_MEM,
> +                sizeof(uuid_le));
> +    gdata->error_data_length = sizeof(struct cper_sec_mem_err);
> +
> +    mem_err = (struct cper_sec_mem_err *) (gdata + 1);
> +
> +    /* In order to simplify simulation, hardcode the CPER section to memory
> +     * section.
> +     */
> +    mem_err->validation_bits |= CPER_MEM_VALID_ERROR_TYPE;
> +    mem_err->error_type = 3;
> +
> +    mem_err->validation_bits |= CPER_MEM_VALID_PA;
> +    mem_err->physical_addr = error_physical_addr;
> +
> +    mem_err->validation_bits |= CPER_MEM_VALID_CARD | CPER_MEM_VALID_MODULE |
> +            CPER_MEM_VALID_BANK | CPER_MEM_VALID_ROW |
> +            CPER_MEM_VALID_COLUMN | CPER_MEM_VALID_BIT_POSITION;
> +    mem_err->card = 1;
> +    mem_err->module = 2;
> +    mem_err->bank = 3;
> +    mem_err->row = 1;
> +    mem_err->column = 2;
> +    mem_err->bit_pos = 5;
> +
> +    mem_err->validation_bits |= CPER_MEM_VALID_ERROR_STATUS;
> +    mem_err->error_status = 4 << 8;
> +
> +    /* Write back the Generic Error Data Entry to guest memory */
> +    cpu_physical_memory_write(block_error_address + block_data_length, buffer,
> +                    sizeof(AcpiGenericErrorData) + sizeof(cper_sec_mem_err));
> +
> +    g_free(buffer);
> +    return BFAPEI_OK;
> +}
> +
> +void ghes_build_acpi(GArray *table_data, GArray *hardware_error,
> +                                            BIOSLinker *linker)
> +{
> +    Aml *hest;
> +    uint32_t address_registers_offset;
> +    AcpiTableHeader *header;
> +    AcpiGenericHardwareErrorSource *error_source;
> +    int i;
> +
> +    int block_reqr_size = sizeof(uint64_t) + MAX_RAW_DATA_LENGTH;
> +
> +    /* New address register and Error status block table size*/
> +    g_array_set_size(hardware_error, MAX_ERROR_SOURCE_COUNT_V6
> +                                        * block_reqr_size);
> +
> +    /* Put this in a HEST table */
> +    hest = init_aml_allocator();
> +    address_registers_offset = table_data->len
> +                                + sizeof(AcpiHardwareErrorSourceTable)
> +                                + ERROR_STATUS_ADDRESS_OFFSET
> +                                + GAS_ADDRESS_OFFSET;
> +    /* Reserve space for HEST table size*/
> +    acpi_data_push(hest->buf, sizeof(AcpiHardwareErrorSourceTable)
> +                                + MAX_ERROR_SOURCE_COUNT_V6
> +                                * sizeof(AcpiGenericHardwareErrorSource));
> +
> +    g_array_append_vals(table_data, hest->buf->data, hest->buf->len);
> +    /* Allocate guest memory for the Data fw_cfg blob */
> +    bios_linker_loader_alloc(linker, GHES_ERRORS_FW_CFG_FILE,
> +                            hardware_error, 4096,
> +                            false /* page boundary, high memory */);
> +    header = (AcpiTableHeader *)(table_data->data
> +                        + table_data->len - hest->buf->len);
> +    *(uint32_t *)(header + 1) = MAX_ERROR_SOURCE_COUNT_V6;
> +    error_source = (AcpiGenericHardwareErrorSource *)((char *)header
> +                                    + sizeof(AcpiHardwareErrorSourceTable));
> +
> +    for (i = 0; i < MAX_ERROR_SOURCE_COUNT_V6; i++) {
> +        error_source->type = ACPI_HEST_TYPE_GENERIC_ERROR;
> +        error_source->source_id = 0;
> +        error_source->related_source_id = 0xffff;
> +        error_source->flags = 0;
> +        error_source->enabled = 1;
> +        error_source->number_of_records = 1;
> +        error_source->max_sections_per_record = 1;
> +        error_source->max_raw_data_length = MAX_RAW_DATA_LENGTH;
> +        error_source->error_status_address.space_id =
> +                                    ACPI_ADR_SPACE_SYSTEM_MEMORY;
> +        error_source->error_status_address.bit_width = 64;
> +        error_source->error_status_address.bit_offset = 0;
> +        error_source->error_status_address.access_width = 4;
> +        error_source->notify.type = i;
> +        error_source->notify.length = sizeof(AcpiGenericHardwareErrorSource);
> +
> +        bios_linker_loader_add_pointer(linker, GHES_ERRORS_FW_CFG_FILE,
> +                                sizeof(uint64_t) * i, sizeof(uint64_t),
> +                                GHES_ERRORS_FW_CFG_FILE,
> +                                MAX_ERROR_SOURCE_COUNT_V6 * sizeof(uint64_t) +
> +                                i * MAX_RAW_DATA_LENGTH);
> +        bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
> +                    address_registers_offset
> +                    + i * sizeof(AcpiGenericHardwareErrorSource),
> +                    sizeof(uint32_t), GHES_ERRORS_FW_CFG_FILE,
> +                    i * sizeof(uint64_t));
> +
> +        bios_linker_loader_write_pointer(linker, GHES_DATA_ADDR_FW_CFG_FILE,
> +                                i * sizeof(uint64_t), sizeof(uint64_t),
> +                                GHES_ERRORS_FW_CFG_FILE,
> +                                MAX_ERROR_SOURCE_COUNT_V6 * sizeof(uint64_t) +
> +                                i * MAX_RAW_DATA_LENGTH);
> +         error_source++;
> +    }
> +
> +     build_header(linker, table_data,
> +        (void *)header, "HEST", hest->buf->len, 1, NULL, "GHES");
> +
> +    free_aml_allocator();
> +}
> +
> +static GhesErrorState ges;
> +void ghes_add_fw_cfg(FWCfgState *s, GArray *hardware_error)
> +{
> +
> +    int block_reqr_size = sizeof(uint64_t) + MAX_RAW_DATA_LENGTH;
> +    int size = MAX_ERROR_SOURCE_COUNT_V6 * block_reqr_size;
> +
> +    /* Create a read-only fw_cfg file for GHES */
> +    fw_cfg_add_file(s, GHES_ERRORS_FW_CFG_FILE, hardware_error->data,
> +                    size);
> +    /* Create a read-write fw_cfg file for Address */
> +    fw_cfg_add_file_callback(s, GHES_DATA_ADDR_FW_CFG_FILE, NULL, NULL,
> +                            &(ges.ghes_addr_le[0]),
> +                            sizeof(uint64_t) * MAX_ERROR_SOURCE_COUNT_V6,
> +                            false);
> +}
> +
> +void ghes_update_guest(uint32_t notify, uint64_t physical_address)
> +{
> +    uint64_t block_error_addr;
> +
> +    if (physical_address) {
> +        ges.physical_addr = physical_address;
> +        block_error_addr = ges.ghes_addr_le[notify];
> +        block_error_addr = le32_to_cpu(block_error_addr);
> +
> +        /* A zero value in ghes_addr means that BIOS has not yet written
> +         * the address
> +         */
> +        if (block_error_addr) {
> +            ghes_generate_cper_record(block_error_addr, physical_address);
> +        }
> +    }
> +}
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 0835e59..e7ab5dc 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -45,6 +45,8 @@
>  #include "hw/arm/virt.h"
>  #include "sysemu/numa.h"
>  #include "kvm_arm.h"
> +#include "hw/acpi/vmgenid.h"
> +#include "hw/acpi/hest_ghes.h"
>  
>  #define ARM_SPI_BASE 32
>  #define ACPI_POWER_BUTTON_DEVICE "PWRB"
> @@ -778,6 +780,9 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>      acpi_add_table(table_offsets, tables_blob);
>      build_spcr(tables_blob, tables->linker, vms);
>  
> +    acpi_add_table(table_offsets, tables_blob);
> +    ghes_build_acpi(tables_blob, tables->hardware_errors, tables->linker);
> +
>      if (nb_numa_nodes > 0) {
>          acpi_add_table(table_offsets, tables_blob);
>          build_srat(tables_blob, tables->linker, vms);
> @@ -892,6 +897,7 @@ void virt_acpi_setup(VirtMachineState *vms)
>  
>      build_state->rsdp_mr = acpi_add_rom_blob(build_state, tables.rsdp,
>                                                ACPI_BUILD_RSDP_FILE, 0);
> +    ghes_add_fw_cfg(vms->fw_cfg, tables.hardware_errors);
>  
>      qemu_register_reset(virt_acpi_build_reset, build_state);
>      virt_acpi_build_reset(build_state);
> diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
> index 4cc3630..27adede 100644
> --- a/include/hw/acpi/acpi-defs.h
> +++ b/include/hw/acpi/acpi-defs.h
> @@ -295,6 +295,58 @@ typedef struct AcpiMultipleApicTable AcpiMultipleApicTable;
>  #define ACPI_APIC_GENERIC_TRANSLATOR    15
>  #define ACPI_APIC_RESERVED              16   /* 16 and greater are reserved */
>  
> +#define CPER_MEM_VALID_ERROR_STATUS     0x0001
> +#define CPER_MEM_VALID_PA               0x0002
> +#define CPER_MEM_VALID_PA_MASK          0x0004
> +#define CPER_MEM_VALID_NODE             0x0008
> +#define CPER_MEM_VALID_CARD             0x0010
> +#define CPER_MEM_VALID_MODULE           0x0020
> +#define CPER_MEM_VALID_BANK             0x0040
> +#define CPER_MEM_VALID_DEVICE           0x0080
> +#define CPER_MEM_VALID_ROW              0x0100
> +#define CPER_MEM_VALID_COLUMN           0x0200
> +#define CPER_MEM_VALID_BIT_POSITION     0x0400
> +#define CPER_MEM_VALID_REQUESTOR_ID     0x0800
> +#define CPER_MEM_VALID_RESPONDER_ID     0x1000
> +#define CPER_MEM_VALID_TARGET_ID        0x2000
> +#define CPER_MEM_VALID_ERROR_TYPE       0x4000
> +#define CPER_MEM_VALID_RANK_NUMBER      0x8000
> +#define CPER_MEM_VALID_CARD_HANDLE      0x10000
> +#define CPER_MEM_VALID_MODULE_HANDLE    0x20000
> +
> +typedef struct {
> +    uint8_t b[16];
> +} uuid_le;
> +
> +#define UUID_LE(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)        \
> +((uuid_le)                              \
> +{{ (a) & 0xff, ((a) >> 8) & 0xff, ((a) >> 16) & 0xff, ((a) >> 24) & 0xff, \
> +    (b) & 0xff, ((b) >> 8) & 0xff,                   \
> +    (c) & 0xff, ((c) >> 8) & 0xff,                   \
> +    (d0), (d1), (d2), (d3), (d4), (d5), (d6), (d7) } })
> +
> +/* Platform Memory */
> +#define CPER_SEC_PLATFORM_MEM                   \
> +    UUID_LE(0xA5BC1114, 0x6F64, 0x4EDE, 0xB8, 0x63, 0x3E, 0x83, \
> +        0xED, 0x7C, 0x83, 0xB1)
> +

There's no reason to define these messy one-time use macros.
They just make it hard to look things up in the spec.


You can use build_append_int_noprefix to add data of
any length in LE format.


> +/* Values for Notify Type field above */
> +
> +enum acpi_hest_notify_types {
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
> +};
> +

these are never reused, it's best

>  /*
>   * MADT sub-structures (Follow MULTIPLE_APIC_DESCRIPTION_TABLE)
>   */
> @@ -475,6 +527,181 @@ struct AcpiSystemResourceAffinityTable
>  } QEMU_PACKED;
>  typedef struct AcpiSystemResourceAffinityTable AcpiSystemResourceAffinityTable;
>  
> +#define ACPI_ADR_SPACE_SYSTEM_MEMORY    (uint8_t) 0
> +#define ACPI_ADR_SPACE_SYSTEM_IO        (uint8_t) 1
> +#define ACPI_ADR_SPACE_PCI_CONFIG       (uint8_t) 2
> +#define ACPI_ADR_SPACE_EC               (uint8_t) 3
> +#define ACPI_ADR_SPACE_SMBUS            (uint8_t) 4
> +#define ACPI_ADR_SPACE_CMOS             (uint8_t) 5
> +#define ACPI_ADR_SPACE_PCI_BAR_TARGET   (uint8_t) 6
> +#define ACPI_ADR_SPACE_IPMI             (uint8_t) 7
> +#define ACPI_ADR_SPACE_GPIO             (uint8_t) 8
> +#define ACPI_ADR_SPACE_GSBUS            (uint8_t) 9
> +#define ACPI_ADR_SPACE_PLATFORM_COMM    (uint8_t) 10
> +

We already have macros for some of these and APIs to
format it.

> +/* GAS - Generic Address Structure */
> +struct acpi_generic_address {
> +    uint8_t space_id;       /* Address space where
> +                             *struct or register exists
> +                             */
> +    uint8_t bit_width;      /* Size in bits of given register */
> +    uint8_t bit_offset;     /* Bit offset within the register */
> +    uint8_t access_width;   /* Minimum Access size (ACPI 3.0) */
> +    uint64_t address;       /* 64-bit address of struct or register */
> +} __attribute__ ((packed));
> +
> +/* Hardware Error Notification */
> +struct acpi_hest_notify {
> +    uint8_t type;
> +    uint8_t length;
> +    uint16_t config_write_enable;
> +    uint32_t poll_interval;
> +    uint32_t vector;
> +    uint32_t polling_threshold_value;
> +    uint32_t polling_threshold_window;
> +    uint32_t error_threshold_value;
> +    uint32_t error_threshold_window;
> +};
> +
> +enum acpi_hest_types {
> +    ACPI_HEST_TYPE_IA32_CHECK = 0,
> +    ACPI_HEST_TYPE_IA32_CORRECTED_CHECK = 1,
> +    ACPI_HEST_TYPE_IA32_NMI = 2,
> +    ACPI_HEST_TYPE_NOT_USED3 = 3,
> +    ACPI_HEST_TYPE_NOT_USED4 = 4,
> +    ACPI_HEST_TYPE_NOT_USED5 = 5,
> +    ACPI_HEST_TYPE_AER_ROOT_PORT = 6,
> +    ACPI_HEST_TYPE_AER_ENDPOINT = 7,
> +    ACPI_HEST_TYPE_AER_BRIDGE = 8,
> +    ACPI_HEST_TYPE_GENERIC_ERROR = 9,
> +    ACPI_HEST_TYPE_GENERIC_ERROR_V2 = 10,
> +    ACPI_HEST_TYPE_RESERVED = 11    /* 11 and greater are reserved */
> +};
> +
> +/* Values for block_status flags above */
> +#define ACPI_BERT_UNCORRECTABLE             (1)
> +#define ACPI_BERT_CORRECTABLE               (1 << 1)
> +#define ACPI_BERT_MULTIPLE_UNCORRECTABLE    (1 << 2)
> +#define ACPI_BERT_MULTIPLE_CORRECTABLE      (1 << 3)
> +/* 8 bits, error count */
> +#define ACPI_BERT_ERROR_ENTRY_COUNT         (0xFF << 4)
> +
> +/* Generic Hardware Error Source Structure */
> +struct AcpiGenericHardwareErrorSource {
> +    uint16_t type;
> +    uint16_t source_id;
> +    uint16_t related_source_id;
> +    uint8_t flags;
> +    uint8_t enabled;
> +    uint32_t number_of_records;
> +    uint32_t max_sections_per_record;
> +    uint32_t max_raw_data_length;
> +    struct acpi_generic_address error_status_address;
> +    struct acpi_hest_notify notify;
> +    uint32_t error_status_block_length;
> +} QEMU_PACKED;
> +typedef struct AcpiGenericHardwareErrorSource AcpiGenericHardwareErrorSource;
> +
> +/* Generic Hardware Error Source , version 2 */
> +struct AcpiGenericHardwareErrorSourceV2 {
> +    uint16_t type;
> +    uint16_t source_id;
> +    uint16_t related_source_id;
> +    uint8_t flags;
> +    uint8_t enabled;
> +    uint32_t number_of_records;
> +    uint32_t max_sections_per_record;
> +    uint32_t max_raw_data_length;
> +    struct acpi_generic_address error_status_address;
> +    struct acpi_hest_notify notify;
> +    uint32_t error_status_block_length;
> +    struct acpi_generic_address read_ack_register;
> +    uint64_t read_ack_preserve;
> +    uint64_t read_ack_write;
> +} QEMU_PACKED;
> +typedef struct AcpiGenericHardwareErrorSourceV2
> +            AcpiGenericHardwareErrorSourceV2;
> +
> +/* Generic Error Status block */
> +
> +struct AcpiGenericErrorStatus {
> +    uint32_t block_status;
> +    uint32_t raw_data_offset;
> +    uint32_t raw_data_length;
> +    uint32_t data_length;
> +    uint32_t error_severity;
> +};
> +typedef struct AcpiGenericErrorStatus AcpiGenericErrorStatus;
> +
> +/* Generic Error Data entry */
> +
> +struct AcpiGenericErrorData {
> +    uint8_t section_type[16];
> +    uint32_t error_severity;
> +    uint16_t revision;
> +    uint8_t validation_bits;
> +    uint8_t flags;
> +    uint32_t error_data_length;
> +    uint8_t fru_id[16];
> +    uint8_t fru_text[20];
> +};
> +typedef struct AcpiGenericErrorData AcpiGenericErrorData;
> +
> +/* Extension for revision 0x0300  */
> +struct AcpiGenericErrorDataV300 {
> +    uint8_t section_type[16];
> +    uint32_t error_severity;
> +    uint16_t revision;
> +    uint8_t validation_bits;
> +    uint8_t flags;
> +    uint32_t error_data_length;
> +    uint8_t fru_id[16];
> +    uint8_t fru_text[20];
> +    uint64_t time_stamp;
> +};
> +typedef struct AcpiGenericErrorDataV300 AcpiGenericErrorDataV300;
> +
> +enum {
> +    CPER_SEV_RECOVERABLE,
> +    CPER_SEV_FATAL,
> +    CPER_SEV_CORRECTED,
> +    CPER_SEV_INFORMATIONAL,
> +};
> +
> +/* Memory Error Section */
> +struct cper_sec_mem_err {
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
> +};
> + typedef struct cper_sec_mem_err cper_sec_mem_err;
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
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index 00c21f1..c1d15b3 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -211,6 +211,7 @@ struct AcpiBuildTables {
>      GArray *rsdp;
>      GArray *tcpalog;
>      GArray *vmgenid;
> +    GArray *hardware_errors;
>      BIOSLinker *linker;
>  } AcpiBuildTables;
>  
> diff --git a/include/hw/acpi/hest_ghes.h b/include/hw/acpi/hest_ghes.h
> new file mode 100644
> index 0000000..0cadc2b
> --- /dev/null
> +++ b/include/hw/acpi/hest_ghes.h
> @@ -0,0 +1,43 @@
> +#ifndef ACPI_GHES_H
> +#define ACPI_GHES_H
> +
> +#include "hw/acpi/bios-linker-loader.h"
> +
> +#define GHES_ERRORS_FW_CFG_FILE      "etc/hardware_errors"
> +#define GHES_DATA_ADDR_FW_CFG_FILE      "etc/hardware_errors_addr"
> +
> +#define GAS_ADDRESS_OFFSET              4
> +#define ERROR_STATUS_ADDRESS_OFFSET     20
> +#define NOTIFICATION_STRUCTURE          32
> +
> +#define BFAPEI_OK   0
> +#define BFAPEI_FAIL 1
> +
> +/* The max number of error source, the error sources
> + * are classified by notification type, below is the definition
> + * 0 - Polled
> + * 1 - External Interrupt
> + * 2 - Local Interrupt
> + * 3 - SCI
> + * 4 - NMI
> + * 5 - CMCI
> + * 6 - MCE
> + * 7 - GPIO-Signal
> + * 8 - ARMv8 SEA
> + * 9 - ARMv8 SEI
> + * 10 - External Interrupt - GSIV
> + */
> +#define MAX_ERROR_SOURCE_COUNT_V6           11
> +/* The max size in Bytes for one error block */
> +#define MAX_RAW_DATA_LENGTH                 0x1000
> +
> +typedef struct GhesErrorState {
> +    uint64_t physical_addr;
> +    uint64_t ghes_addr_le[8];
> +} GhesErrorState;
> +
> +void ghes_build_acpi(GArray *table_data, GArray *hardware_error,
> +                            BIOSLinker *linker);
> +void ghes_add_fw_cfg(FWCfgState *s, GArray *guid);
> +void ghes_update_guest(uint32_t notify, uint64_t physical_address);
> +#endif
> -- 
> 1.8.3.1
