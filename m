Received: from eggs.gnu.org ([2001:4830:134:3::10]:38039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1dnikG-0002VP-R2
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 06:00:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1dnik6-0006NX-BS
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 06:00:12 -0400
References: <1503066227-18251-1-git-send-email-gengdongjiu@huawei.com>
	<1503066227-18251-3-git-send-email-gengdongjiu@huawei.com>
	<20170829122053.36cf550c@nial.brq.redhat.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <dfaeb539-8006-85d6-35b2-0af31f5a0675@huawei.com>
Date: Fri, 1 Sep 2017 17:58:55 +0800
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
Cc: mst@redhat.com, zhaoshenglong@huawei.com, lersek@redhat.com, peter.maydell@linaro.org, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org, edk2-devel@lists.01.org, christoffer.dall@linaro.org, marc.zyngier@arm.com, will.deacon@arm.com, james.morse@arm.com, ard.biesheuvel@linaro.org, mingo@kernel.org, bp@suse.de, shiju.jose@huawei.com, zjzhang@codeaurora.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, john.garry@huawei.com, jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com, huangdaode@hisilicon.com, wangzhou1@hisilicon.com, zhengqiang10@huawei.com, wuquanming@huawei.com, huangshaoyu@huawei.com, linuxarm@huawei.com

Hi Igor,

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

I will make it more structured and review-able, so that it is easily readable.

> 
> I'd suggest to add doc patch first which will describe how it's
> supposed to work between QEMU/firmware/guest OS with expected
> flows.
It is sure, I will add a doc patch.

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
Maybe not yet. it shows how the table is generated and how the CPER is recorded through fw_cfg blob
between Qemu and guest firmware. for example: etc/acpi/tables and etc/hardware_errors
anyway I will move it to the spec/doc.

>  * Probably there is not much sense to have HEST table here, it's described
>    well enough in spec. You might just put reference here.
>  * these diagrams should go into doc/spec patch
I will move these diagrams to doc/spec patch

>  * when you describe layout you need to show what and at what offsets
>    in which order in which blob/file is located. See ACPI spec for example
>    and/or docs/specs/acpi_nvdimm.txt docs/specs/acpi_mem_hotplug.txt for inspiration.
Ok, thanks for the suggestion.

> 
>> For GHESv2 error source, the OSPM must acknowledges the error via Read Ack register.
>> so user space must check the ack value to avoid read-write race condition.
>>
>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>> ---

cut----

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
   I will remove it.

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
  I will use build_append_int_noprefix() API to compose the block status

> 
> and try to get rid of most structures you introduce in patch 1/6,
> as they will be left unused after that.
I will clear the structures and remove the unused structures that this patch does not used.

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
thanks, OK.

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
 it is because other people have concern about where does the "unsigned 64 bit integer"
 come from, they are confused about the "unsigned 64 bit integer"
 so they suggested use sizeof. anyway I will directly use unsigned 64 bit integer.

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
I will find method to make it easily readable.

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
thanks for the suggestion, I will make the table independently as far as possible

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
thanks for the suggestion, I will use your suggested name.

> 
> also, beside build_append_int_noprefix() you need to at least
> add comment that exactly matches field from spec.
> 
> the same applies to other fields you are adding in this patch
  OK, will add it.

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
Thanks for the suggestion.

> 
> also register width 0x40 looks suspicious, where does it come from?
> While at it do you have a real hardware which has HEST table that you re trying to model after?
> I'd like to see HEST and other related tables from it.

Igor, what is your suspicious point? The register width 0x40 come from our host BIOS record to the System Memory space.

For the SEA/SEI, the Qemu(user space) only handle the memory section hardware error, not include processor error. so it may not
involve other Address Space, such as System I/O space

it is sure we have hardware. I share our BIOS code that generate HEST and other related table here.
https://github.com/hisilicon/uefi.git
Now we have also submitted the host BIOS code to open source for review, this code generated the HEST and other related table
thanks.

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
cut -----
