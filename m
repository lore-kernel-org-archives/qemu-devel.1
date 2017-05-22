Received: from eggs.gnu.org ([2001:4830:134:3::10]:37918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dCoFK-0004FV-RD
	for qemu-devel@nongnu.org; Mon, 22 May 2017 10:23:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dCoFI-0000gY-5j
	for qemu-devel@nongnu.org; Mon, 22 May 2017 10:23:42 -0400
From: Laszlo Ersek <lersek@redhat.com>
References: <1493530506-26833-1-git-send-email-gengdongjiu@huawei.com>
	<4dde45bb-a730-82b1-dc49-ad00a6b73d85@redhat.com>
Message-ID: <accf8880-f4b0-85f1-9f33-4103c8c26d7a@redhat.com>
Date: Mon, 22 May 2017 16:23:23 +0200
MIME-Version: 1.0
In-Reply-To: <4dde45bb-a730-82b1-dc49-ad00a6b73d85@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Dongjiu Geng <gengdongjiu@huawei.com>, james.morse@arm.com, marc.zyngier@arm.com, christoffer.dall@linaro.org, rkrcmar@redhat.com, linux@armlinux.org.uk, tbaicar@codeaurora.org, imammedo@redhat.com, zhaoshenglong@huawei.com, peter.maydell@linaro.org, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, ard.biesheuvel@linaro.org, mtsirkin@redhat.com, drjones@redhat.com, ben@skyportsystems.com, kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Cc: songwenjun@huawei.com, wuquanming@huawei.com, huangshaoyu@huawei.com, wangxiongfeng2@huawei.com, xiexiuqi@huawei.com

Keeping some context:

On 05/12/17 23:00, Laszlo Ersek wrote:
> On 04/30/17 07:35, Dongjiu Geng wrote:
>> This implements APEI GHES Table by passing the error cper info
>> to the guest via a fw_cfg_blob. After a CPER info is added, an
>> SEA/SEI exception will be injected into the guest OS.
>>
>> Below is the table layout, the max number of error soure is 11,
>> which is classified by notification type.
>>
>> etc/acpi/tables                 etc/hardware_errors
>> ================     ==========================================
>>                      +-----------+
>> +--------------+     | address   |         +-> +--------------+
>> |    HEST      +     | registers |         |   | Error Status |
>> + +------------+     | +---------+         |   | Data Block 1 |
>> | | GHES1      | --> | |address1 | --------+   | +------------+
>> | | GHES2      | --> | |address2 | ------+     | |  CPER      |
>> | | GHES3      | --> | |address3 | ----+ |     | |  CPER      |
>> | |  ....      | --> | | ....... |     | |     | |  CPER      |
>> | | GHES10     | --> | |address10| -+  | |     | |  CPER      |
>> +-+------------+     +-+---------+  |  | |     +-+------------+
>>                                     |  | |
>>                                     |  | +---> +--------------+
>>                                     |  |       | Error Status |
>>                                     |  |       | Data Block 2 |
>>                                     |  |       | +------------+
>>                                     |  |       | |  CPER      |
>>                                     |  |       | |  CPER      |
>>                                     |  |       +-+------------+
>>                                     |  |
>>                                     |  +-----> +--------------+
>>                                     |          | Error Status |
>>                                     |          | Data Block 3 |
>>                                     |          | +------------+
>>                                     |          | |  CPER      |
>>                                     |          +-+------------+
>>                                     |            ...........
>>                                     +--------> +--------------+
>>                                                | Error Status |
>>                                                | Data Block 10|
>>                                                | +------------+
>>                                                | |  CPER      |
>>                                                | |  CPER      |
>>                                                | |  CPER      |
>>                                                +-+------------+
>>
>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>> ---
>>  default-configs/arm-softmmu.mak |   1 +
>>  hw/acpi/Makefile.objs           |   1 +
>>  hw/acpi/aml-build.c             |   2 +
>>  hw/acpi/hest_ghes.c             | 203 +++++++++++++++++++++++++++++++++++
>>  hw/arm/virt-acpi-build.c        |   6 ++
>>  include/hw/acpi/acpi-defs.h     | 227 ++++++++++++++++++++++++++++++++++++++++
>>  include/hw/acpi/aml-build.h     |   1 +
>>  include/hw/acpi/hest_ghes.h     |  43 ++++++++
>>  8 files changed, 484 insertions(+)
>>  create mode 100644 hw/acpi/hest_ghes.c
>>  create mode 100644 include/hw/acpi/hest_ghes.h

> Next file:
>
>> diff --git a/include/hw/acpi/hest_ghes.h b/include/hw/acpi/hest_ghes.h
>> new file mode 100644
>> index 0000000..0cadc2b
>> --- /dev/null
>> +++ b/include/hw/acpi/hest_ghes.h
>> @@ -0,0 +1,43 @@
>> +#ifndef ACPI_GHES_H
>> +#define ACPI_GHES_H
>> +
>> +#include "hw/acpi/bios-linker-loader.h"
>> +
>> +#define GHES_ERRORS_FW_CFG_FILE      "etc/hardware_errors"
>> +#define GHES_DATA_ADDR_FW_CFG_FILE      "etc/hardware_errors_addr"
>> +
>> +#define GAS_ADDRESS_OFFSET              4
>> +#define ERROR_STATUS_ADDRESS_OFFSET     20
>> +#define NOTIFICATION_STRUCTURE          32
>> +
>> +#define BFAPEI_OK   0
>> +#define BFAPEI_FAIL 1
>> +
>> +/* The max number of error source, the error sources
>> + * are classified by notification type, below is the definition
>> + * 0 - Polled
>> + * 1 - External Interrupt
>> + * 2 - Local Interrupt
>> + * 3 - SCI
>> + * 4 - NMI
>> + * 5 - CMCI
>> + * 6 - MCE
>> + * 7 - GPIO-Signal
>> + * 8 - ARMv8 SEA
>> + * 9 - ARMv8 SEI
>> + * 10 - External Interrupt - GSIV
>> + */
>> +#define MAX_ERROR_SOURCE_COUNT_V6           11
>
> I'll have to review this header file more thoroughly, once I see the
> code that references these macros. For now, I have one comment:
>
> (42) I think the notification type list should be removed from this
> location. Also, the open-coded value 11 should be replaced with
> the ACPI_HEST_NOTIFY_RESERVED enumeration constant.
>
> I will try to continue reviewing this patch sometime next week (second
> half of the week at the earliest, I think).

(43) I think all macros introduced in this header should all start with
"GHES_".

>
>> +/* The max size in Bytes for one error block */
>> +#define MAX_RAW_DATA_LENGTH                 0x1000
>> +
>> +typedef struct GhesErrorState {
>> +    uint64_t physical_addr;
>> +    uint64_t ghes_addr_le[8];
>> +} GhesErrorState;

(44) Should this be called "GhesState" instead (dropping "Error")?

(45) (This is a question for other reviewers) I have no idea if this
abstraction should be a device (sysbus or otherwise). Should it be a
device? Below we have a static ("global") variable of this type, which
is quite unusual.

(46) What is "physical_addr" good for? Below I can only see an
assignment to it, in ghes_update_guest(). Where is the field read?

(47) "ghes_addr_le" should be an array of eight uint8_t elements (for
representing a single uint64_t in little endian). The declaration above
has a typo; the element type is currently specified as uint64_t.

It suffices for the firmware to pass the base address of
"etc/hardware_errors" back to QEMU, all the other addresses can be
computed in QEMU as needed.

(If, for some reason you *do* need to pass back multiple addresses, then
you should use

  uint8_t xxxx_addr_le[N][8];

But even in this case, setting N to 8 doesn't look useful, because we
have 11 error sources / notification types.)

>> +
>> +void ghes_build_acpi(GArray *table_data, GArray *hardware_error,
>> +                            BIOSLinker *linker);
>> +void ghes_add_fw_cfg(FWCfgState *s, GArray *guid);

(48) The second parameter should be called "hardware_errors", not
"guid".

>> +void ghes_update_guest(uint32_t notify, uint64_t physical_address);

(49) Can you call the second parameter "error_physical_addr"?

>> +#endif
>>

>> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
>> index 1e3bd2b..d5f1552 100644
>> --- a/default-configs/arm-softmmu.mak
>> +++ b/default-configs/arm-softmmu.mak
>> @@ -121,3 +121,4 @@ CONFIG_ACPI=y
>>  CONFIG_SMBIOS=y
>>  CONFIG_ASPEED_SOC=y
>>  CONFIG_GPIO_KEY=y
>> +CONFIG_ACPI_APEI_GENERATION=y

>> diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
>> index 11c35bc..776b46e 100644
>> --- a/hw/acpi/Makefile.objs
>> +++ b/hw/acpi/Makefile.objs
>> @@ -6,6 +6,7 @@ common-obj-$(CONFIG_ACPI_MEMORY_HOTPLUG) += memory_hotplug.o
>>  common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) += cpu.o
>>  common-obj-$(CONFIG_ACPI_NVDIMM) += nvdimm.o
>>  common-obj-$(CONFIG_ACPI_VMGENID) += vmgenid.o
>> +common-obj-$(CONFIG_ACPI_APEI_GENERATION) += hest_ghes.o
>>  common-obj-$(call lnot,$(CONFIG_ACPI_X86)) += acpi-stub.o
>>
>>  common-obj-y += acpi_interface.o

(50) I think "CONFIG_ACPI_APEI" would be more succinct.

>> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
>> index 00c21f1..c1d15b3 100644
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

>> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
>> index c6f2032..802b98d 100644
>> --- a/hw/acpi/aml-build.c
>> +++ b/hw/acpi/aml-build.c
>> @@ -1560,6 +1560,7 @@ void acpi_build_tables_init(AcpiBuildTables *tables)
>>      tables->table_data = g_array_new(false, true /* clear */, 1);
>>      tables->tcpalog = g_array_new(false, true /* clear */, 1);
>>      tables->vmgenid = g_array_new(false, true /* clear */, 1);
>> +    tables->hardware_errors = g_array_new(false, true /* clear */, 1);
>>      tables->linker = bios_linker_loader_init();
>>  }
>>
>> @@ -1570,6 +1571,7 @@ void acpi_build_tables_cleanup(AcpiBuildTables *tables, bool mfre)
>>      g_array_free(tables->table_data, true);
>>      g_array_free(tables->tcpalog, mfre);
>>      g_array_free(tables->vmgenid, mfre);
>> +    g_array_free(tables->hardware_errors, mfre);
>>  }
>>
>>  /* Build rsdt table */

Looks good to me.

>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>> index 0835e59..e7ab5dc 100644
>> --- a/hw/arm/virt-acpi-build.c
>> +++ b/hw/arm/virt-acpi-build.c
>> @@ -45,6 +45,8 @@
>>  #include "hw/arm/virt.h"
>>  #include "sysemu/numa.h"
>>  #include "kvm_arm.h"
>> +#include "hw/acpi/vmgenid.h"

(51) I think this include directive is not necessary.

>> +#include "hw/acpi/hest_ghes.h"
>>
>>  #define ARM_SPI_BASE 32
>>  #define ACPI_POWER_BUTTON_DEVICE "PWRB"
>> @@ -778,6 +780,9 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>>      acpi_add_table(table_offsets, tables_blob);
>>      build_spcr(tables_blob, tables->linker, vms);
>>
>> +    acpi_add_table(table_offsets, tables_blob);
>> +    ghes_build_acpi(tables_blob, tables->hardware_errors, tables->linker);
>> +
>>      if (nb_numa_nodes > 0) {
>>          acpi_add_table(table_offsets, tables_blob);
>>          build_srat(tables_blob, tables->linker, vms);
>> @@ -892,6 +897,7 @@ void virt_acpi_setup(VirtMachineState *vms)
>>
>>      build_state->rsdp_mr = acpi_add_rom_blob(build_state, tables.rsdp,
>>                                                ACPI_BUILD_RSDP_FILE, 0);
>> +    ghes_add_fw_cfg(vms->fw_cfg, tables.hardware_errors);
>>
>>      qemu_register_reset(virt_acpi_build_reset, build_state);
>>      virt_acpi_build_reset(build_state);

(52) I think for consistency with existing code, this function call
should be placed between the ACPI_BUILD_TPMLOG_FILE line and the
acpi_add_rom_blob() line.

>> diff --git a/hw/acpi/hest_ghes.c b/hw/acpi/hest_ghes.c
>> new file mode 100644
>> index 0000000..91d382e
>> --- /dev/null
>> +++ b/hw/acpi/hest_ghes.c
>> @@ -0,0 +1,203 @@
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
>> +
>> +static int ghes_generate_cper_record(uint64_t block_error_address,
>> +                                    uint64_t error_physical_addr)
>> +{
>> +    AcpiGenericErrorStatus block;
>> +    AcpiGenericErrorData *gdata;
>> +    struct cper_sec_mem_err *mem_err;
>> +    uint64_t block_data_length;
>> +    unsigned char *buffer;
>> +
>> +    cpu_physical_memory_read(block_error_address, &block,
>> +                                sizeof(AcpiGenericErrorStatus));
>> +
>> +    block_data_length = sizeof(AcpiGenericErrorStatus) + block.data_length;

(53) "block.data_length" must surely be converted from LE to
host-endian, so please wrap it with le32_to_cpu().

>> +
>> +    /* If the Generic Error Status Block is NULL, update
>> +     * the block header
>> +     */
>> +    if (!block.block_status) {
>> +        block.block_status = ACPI_BERT_UNCORRECTABLE;
>> +        block.error_severity = CPER_SEV_FATAL;
>> +    }
>> +
>> +    block.data_length += sizeof(AcpiGenericErrorData);
>> +    block.data_length += sizeof(struct cper_sec_mem_err);

(54) Conversion between LE and host-endian is missing.

(55) What happens if you run out of the preallocated memory?

>> +
>> +    /* Write back the Generic Error Status Block to guest memory */
>> +    cpu_physical_memory_write(block_error_address, &block,
>> +                        sizeof(AcpiGenericErrorStatus));
>> +
>> +    /* Fill in Generic Error Data Entry */
>> +    buffer = g_malloc(sizeof(AcpiGenericErrorData) + sizeof(cper_sec_mem_err));
>> +    memset(buffer, 0, sizeof(AcpiGenericErrorData) + sizeof(cper_sec_mem_err));

(56) Please use g_malloc0() instead.

>> +    gdata = (AcpiGenericErrorData *)buffer;
>> +
>> +    memcpy(gdata->section_type, (void *) &CPER_SEC_PLATFORM_MEM,
>> +                sizeof(uuid_le));
>> +    gdata->error_data_length = sizeof(struct cper_sec_mem_err);

(57) Endianness conversion missing (cpu_to_le32()).

>> +
>> +    mem_err = (struct cper_sec_mem_err *) (gdata + 1);
>> +
>> +    /* In order to simplify simulation, hardcode the CPER section to memory
>> +     * section.
>> +     */
>> +    mem_err->validation_bits |= CPER_MEM_VALID_ERROR_TYPE;
>> +    mem_err->error_type = 3;

(58) Is this supposed to stand for "Multi-bit ECC" (from "N.2.5 Memory
Error Section" in UEFI 2.6)? Should we have a macro for that?

>> +
>> +    mem_err->validation_bits |= CPER_MEM_VALID_PA;
>> +    mem_err->physical_addr = error_physical_addr;

(59) Conversion between host and little endian is missing on all four
lines above.

>> +
>> +    mem_err->validation_bits |= CPER_MEM_VALID_CARD | CPER_MEM_VALID_MODULE |
>> +            CPER_MEM_VALID_BANK | CPER_MEM_VALID_ROW |
>> +            CPER_MEM_VALID_COLUMN | CPER_MEM_VALID_BIT_POSITION;
>> +    mem_err->card = 1;
>> +    mem_err->module = 2;
>> +    mem_err->bank = 3;
>> +    mem_err->row = 1;
>> +    mem_err->column = 2;
>> +    mem_err->bit_pos = 5;

(60) I have no idea where these values come from.

>> +
>> +    mem_err->validation_bits |= CPER_MEM_VALID_ERROR_STATUS;
>> +    mem_err->error_status = 4 << 8;
>> +
>> +    /* Write back the Generic Error Data Entry to guest memory */
>> +    cpu_physical_memory_write(block_error_address + block_data_length, buffer,
>> +                    sizeof(AcpiGenericErrorData) + sizeof(cper_sec_mem_err));

(61) Please choose a better name for "block_data_length" -- it stands
for the length *before* the increment.

(62) Is it safe to write out the increased block length before writing
the new CPER data?

>> +
>> +    g_free(buffer);
>> +    return BFAPEI_OK;
>> +}

(63) This return code is not used. Can we remove it perhaps (together
with the BFAPEI_* macros)?

>> +
>> +void ghes_build_acpi(GArray *table_data, GArray *hardware_error,
>> +                                            BIOSLinker *linker)
>> +{
>> +    Aml *hest;
>> +    uint32_t address_registers_offset;
>> +    AcpiTableHeader *header;
>> +    AcpiGenericHardwareErrorSource *error_source;
>> +    int i;
>> +
>> +    int block_reqr_size = sizeof(uint64_t) + MAX_RAW_DATA_LENGTH;

(64) What does "reqr" stand for?

>> +
>> +    /* New address register and Error status block table size*/
>> +    g_array_set_size(hardware_error, MAX_ERROR_SOURCE_COUNT_V6
>> +                                        * block_reqr_size);

(65) The QEMU coding style is

    g_array_set_size(hardware_error, MAX_ERROR_SOURCE_COUNT_V6 *
                                     block_reqr_size);

That is, the operator is at the end of the line.

Several function calls below are affected by this; please fix them all
up.

Running "scripts/checkpatch.pl" on the patches before you post them
should help catch this kind of problem early.

>> +
>> +    /* Put this in a HEST table */
>> +    hest = init_aml_allocator();
>> +    address_registers_offset = table_data->len
>> +                                + sizeof(AcpiHardwareErrorSourceTable)
>> +                                + ERROR_STATUS_ADDRESS_OFFSET
>> +                                + GAS_ADDRESS_OFFSET;

(66) Please drop the ERROR_STATUS_ADDRESS_OFFSET and GAS_ADDRESS_OFFSET
macros (from the header file as well), and use the following expressions
instead:

  ...
  offsetof(AcpiGenericHardwareErrorSource, error_status_address) +
  offsetof(AcpiGenericAddress, address);

>> +    /* Reserve space for HEST table size*/
>> +    acpi_data_push(hest->buf, sizeof(AcpiHardwareErrorSourceTable)
>> +                                + MAX_ERROR_SOURCE_COUNT_V6
>> +                                * sizeof(AcpiGenericHardwareErrorSource));
>> +
>> +    g_array_append_vals(table_data, hest->buf->data, hest->buf->len);

(67) HEST is a data table, it contains no AML. Accordingly, you use
"hest" *only* for pushing zero bytes to "table_data".

But that's not a good enough reason to have "hest" at all, or to call
init_aml_allocator() / free_aml_allocator(). Instead, please just
calculate the needed size, and push that many bytes directly to
"table_data".

Your current code already populates those bytes within "table_data", so
that's good.

>> +    /* Allocate guest memory for the Data fw_cfg blob */
>> +    bios_linker_loader_alloc(linker, GHES_ERRORS_FW_CFG_FILE,
>> +                            hardware_error, 4096,
>> +                            false /* page boundary, high memory */);

(68) In the code below, you are not taking an "OVMF header probe
suppressor" into account.

But, we have already planned to replace that quirk with a separate,
dedicated allocation hint or command, so I'm not going to describe what
an "OVMF header probe suppressor" is; instead, I'll describe the
replacement for it.

So please add a new patch to the series that does the following:

- In "hw/acpi/bios-linker-loader.c", modify the documentation of
  "BiosLinkerLoaderEntry.alloc.zone". The most significant bit (i.e.,
  bit 7), when set, should mean that @alloc.file contains no ACPI
  tables. When the bit is clear, no information is given about the
  contents of @alloc.file (i.e., same as now).

- This will require a small patch for SeaBIOS: mask off bit 7 of
  "entry->alloc.zone" in the switch statement in
  romfile_loader_allocate(), "src/fw/romfile_loader.c". SeaBIOS does not
  have to care about this bit.

- OVMF will need some code to handle this bit specially, but I will
  write that.

- In QEMU, please modify the bios_linker_loader_alloc() function so that
  it takes a "noacpi" boolean as well, and set the high bit of
  "entry.alloc.zone" from it. The default value for "noacpi" should be
  false, at all currently existing call sites.

- And finally, in this patch, we should pass "true" as "noacpi".

>> +    header = (AcpiTableHeader *)(table_data->data
>> +                        + table_data->len - hest->buf->len);
>> +    *(uint32_t *)(header + 1) = MAX_ERROR_SOURCE_COUNT_V6;

(69) Ugh, this is ugly. Please access the error source count field
through "AcpiHardwareErrorSourceTable.error_source_count".

>> +    error_source = (AcpiGenericHardwareErrorSource *)((char *)header
>> +                                    + sizeof(AcpiHardwareErrorSourceTable));
>> +
>> +    for (i = 0; i < MAX_ERROR_SOURCE_COUNT_V6; i++) {
>> +        error_source->type = ACPI_HEST_TYPE_GENERIC_ERROR;
>> +        error_source->source_id = 0;

(70) I think this is wrong, this identifier should be unique among all
error sources. You should assign cpu_to_le16(i).

>> +        error_source->related_source_id = 0xffff;
>> +        error_source->flags = 0;
>> +        error_source->enabled = 1;
>> +        error_source->number_of_records = 1;

(71) Why do we pre-alloc only one record? Don't several CPER objects fit
in an error status data block (of size MAX_RAW_DATA_LENGTH, 0x1000)?

>> +        error_source->max_sections_per_record = 1;
>> +        error_source->max_raw_data_length = MAX_RAW_DATA_LENGTH;
>> +        error_source->error_status_address.space_id =
>> +                                    ACPI_ADR_SPACE_SYSTEM_MEMORY;
>> +        error_source->error_status_address.bit_width = 64;
>> +        error_source->error_status_address.bit_offset = 0;
>> +        error_source->error_status_address.access_width = 4;
>> +        error_source->notify.type = i;

OK, this is one byte wide only.

>> +        error_source->notify.length = sizeof(AcpiGenericHardwareErrorSource);

(72) This seems to be wrong. The right hand side should be
sizeof(AcpiHestNotify).

>> +
>> +        bios_linker_loader_add_pointer(linker, GHES_ERRORS_FW_CFG_FILE,
>> +                                sizeof(uint64_t) * i, sizeof(uint64_t),
>> +                                GHES_ERRORS_FW_CFG_FILE,
>> +                                MAX_ERROR_SOURCE_COUNT_V6 * sizeof(uint64_t) +
>> +                                i * MAX_RAW_DATA_LENGTH);

(73) Looks good, but please indent the arguments 1 position relative to
the opening paren.

>> +        bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
>> +                    address_registers_offset
>> +                    + i * sizeof(AcpiGenericHardwareErrorSource),
>> +                    sizeof(uint32_t), GHES_ERRORS_FW_CFG_FILE,
>> +                    i * sizeof(uint64_t));

(74) Passing "sizeof(uint32_t)" as "dst_patched_size" is wrong. The
address registers at the start of the "etc/hardware_errors" blob are
64-bit wide each.

>> +
>> +        bios_linker_loader_write_pointer(linker, GHES_DATA_ADDR_FW_CFG_FILE,
>> +                                i * sizeof(uint64_t), sizeof(uint64_t),
>> +                                GHES_ERRORS_FW_CFG_FILE,
>> +                                MAX_ERROR_SOURCE_COUNT_V6 * sizeof(uint64_t) +
>> +                                i * MAX_RAW_DATA_LENGTH);

(75) We should create only one WRITE_POINTER command, for the base
address of "etc/hardware_errors". This should be done outside of the
loop.

The base addresses of the individual error status data blocks should be
calculated in ghes_update_guest(), based on the error source /
notification type.

>> +         error_source++;
>> +    }
>> +
>> +     build_header(linker, table_data,
>> +        (void *)header, "HEST", hest->buf->len, 1, NULL, "GHES");

(76) Any particular reason for not passing NULL in "oem_table_id"?

>> +
>> +    free_aml_allocator();
>> +}
>> +
>> +static GhesErrorState ges;
>> +void ghes_add_fw_cfg(FWCfgState *s, GArray *hardware_error)
>> +{
>> +
>> +    int block_reqr_size = sizeof(uint64_t) + MAX_RAW_DATA_LENGTH;
>> +    int size = MAX_ERROR_SOURCE_COUNT_V6 * block_reqr_size;

(77) These variable should have type "size_t".

(78) What does "reqr" stand for?

(79) I just noticed that the commit message lists error sources /
notification types 1 through 10 (count=10 in total). However, we have 11
error sources actually. Can you update the commit message so that it
mentions sources 0 through 10?

>> +
>> +    /* Create a read-only fw_cfg file for GHES */
>> +    fw_cfg_add_file(s, GHES_ERRORS_FW_CFG_FILE, hardware_error->data,
>> +                    size);
>> +    /* Create a read-write fw_cfg file for Address */
>> +    fw_cfg_add_file_callback(s, GHES_DATA_ADDR_FW_CFG_FILE, NULL, NULL,
>> +                            &(ges.ghes_addr_le[0]),
>> +                            sizeof(uint64_t) * MAX_ERROR_SOURCE_COUNT_V6,
>> +                            false);
>> +}
>> +

(80) The size calculation for GHES_DATA_ADDR_FW_CFG_FILE is incorrect.
First, it does not match the element count 8 that I highlighted under
remark (47). Second (again), passing back just the base address is
sufficient, so 8 uint8_t elements (for representing a single uint64_t in
LE) are enough.

In other words, the size calculation should be
ARRAY_SIZE(ges.ghes_addr_le) here.

>> +void ghes_update_guest(uint32_t notify, uint64_t physical_address)
>> +{
>> +    uint64_t block_error_addr;
>> +
>> +    if (physical_address) {
>> +        ges.physical_addr = physical_address;
>> +        block_error_addr = ges.ghes_addr_le[notify];
>> +        block_error_addr = le32_to_cpu(block_error_addr);
>> +
>> +        /* A zero value in ghes_addr means that BIOS has not yet written
>> +         * the address
>> +         */
>> +        if (block_error_addr) {
>> +            ghes_generate_cper_record(block_error_addr, physical_address);
>> +        }
>> +    }
>> +}

(81) First, the value of "notify" should be range-checked before using it
as an array subscript. If it is outside of the permissible range,
nothing should be done. Second, in order to locate the affected error
status data block, we should move the offset calculation here, from
ghes_build_acpi().

Thanks
Laszlo
