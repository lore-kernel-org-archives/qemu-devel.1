Received: from eggs.gnu.org ([2001:4830:134:3::10]:55527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eUZ0y-0000TQ-Os
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 09:18:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eUZ0w-0002dk-NO
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 09:18:32 -0500
Date: Thu, 28 Dec 2017 15:18:09 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171228151809.10495a90@igors-macbook-pro.local>
In-Reply-To: <1514440458-10515-3-git-send-email-gengdongjiu@huawei.com>
References: <1514440458-10515-1-git-send-email-gengdongjiu@huawei.com>
	<1514440458-10515-3-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v14 2/9] ACPI: Add APEI GHES table
 generation and CPER record support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: pbonzini@redhat.com, mst@redhat.com, zhaoshenglong@huawei.com, peter.maydell@linaro.org, mtosatti@redhat.com, rth@twiddle.net, ehabkost@redhat.com, james.morse@arm.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, huangshaoyu@huawei.com, zhengqiang10@huawei.com, xuwei5@hisilicon.com

On Thu, 28 Dec 2017 13:54:11 +0800
Dongjiu Geng <gengdongjiu@huawei.com> wrote:

> This implements APEI GHES Table generation and record CPER in
> runtime via fw_cfg blobs.Now we only support two types of GHESv2,
> which are GPIO-Signal and ARMv8 SEA. Afterwards, we can extend the
> supported type if needed. For the CPER section type, currently it
s/type/types/

> is memory section because kernel manly wants userspace to handle
s/manly/mainly/

> the memory errors. 

>In order to simulation, we hard code the error
> type to Multi-bit ECC.
Not sure what this is about, care to elaborate?


> For GHESv2 error source, the OSPM must acknowledges the error via
> Read ACK register. So user space must check the ACK value before
> recording a new CPER to avoid read-write race condition.
> 
> Suggested-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> ---
> The basic solution is suggested by Laszlo in [1]
> [1]: https://lkml.org/lkml/2017/3/29/342


patch is too big, it would be better if it were split in several parts.

> ---
>  hw/acpi/aml-build.c         |   2 +
>  hw/acpi/hest_ghes.c         | 390 ++++++++++++++++++++++++++++++++++++++++++++
>  hw/arm/virt-acpi-build.c    |   8 +
>  include/hw/acpi/aml-build.h |   1 +
>  include/hw/acpi/hest_ghes.h |  82 ++++++++++
>  5 files changed, 483 insertions(+)
>  create mode 100644 hw/acpi/hest_ghes.c
>  create mode 100644 include/hw/acpi/hest_ghes.h
> 
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 36a6cc4..6849e5f 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -1561,6 +1561,7 @@ void acpi_build_tables_init(AcpiBuildTables *tables)
>      tables->table_data = g_array_new(false, true /* clear */, 1);
>      tables->tcpalog = g_array_new(false, true /* clear */, 1);
>      tables->vmgenid = g_array_new(false, true /* clear */, 1);
> +    tables->hardware_errors = g_array_new(false, true /* clear */, 1);
>      tables->linker = bios_linker_loader_init();
>  }
>  
> @@ -1571,6 +1572,7 @@ void acpi_build_tables_cleanup(AcpiBuildTables *tables, bool mfre)
>      g_array_free(tables->table_data, true);
>      g_array_free(tables->tcpalog, mfre);
>      g_array_free(tables->vmgenid, mfre);
> +    g_array_free(tables->hardware_errors, mfre);
>  }
>  
>  /* Build rsdt table */
> diff --git a/hw/acpi/hest_ghes.c b/hw/acpi/hest_ghes.c
> new file mode 100644
> index 0000000..86ec99e
> --- /dev/null
> +++ b/hw/acpi/hest_ghes.c
> @@ -0,0 +1,390 @@
> +/* Support for generating APEI tables and record CPER for Guests
> + *
> + * Copyright (C) 2017 HuaWei Corporation.
> + *
> + * Author: Dongjiu Geng <gengdongjiu@huawei.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> +
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> +
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/acpi/acpi.h"
> +#include "hw/acpi/aml-build.h"
> +#include "hw/acpi/hest_ghes.h"
> +#include "hw/nvram/fw_cfg.h"
> +#include "sysemu/sysemu.h"
> +#include "qemu/error-report.h"
> +
> +/* Generic Address Structure (GAS)
> + * ACPI 2.0/3.0: 5.2.3.1 Generic Address Structure
> + * 2.0 compat note:
> + *    @access_width must be 0, see ACPI 2.0:Table 5-1
> + */
> +static void build_append_gas(GArray *table, AmlRegionSpace as,
> +                      uint8_t bit_width, uint8_t bit_offset,
> +                      uint8_t access_width, uint64_t address)
> +{
> +    build_append_int_noprefix(table, as, 1);
> +    build_append_int_noprefix(table, bit_width, 1);
> +    build_append_int_noprefix(table, bit_offset, 1);
> +    build_append_int_noprefix(table, access_width, 1);
> +    build_append_int_noprefix(table, address, 8);
> +}
all build_append_foo() primitives should go into aml-build.c
you can reuse take following patches for build_append_gas() from my github repo
https://github.com/imammedo/qemu/commit/ff35b4ae1ec286f5f11830d504467f5ad243995b
https://github.com/imammedo/qemu/commit/3d2fd6d13a3ea298d2ee814835495ce6241d085c


> +/* Hardware Error Notification
> + * ACPI 4.0: 17.3.2.7 Hardware Error Notification
> + */
> +static void build_append_notify(GArray *table, const uint8_t type,
> +                                uint8_t length)
> +{
> +        build_append_int_noprefix(table, type, 1); /* type */
> +        build_append_int_noprefix(table, length, 1);
> +        build_append_int_noprefix(table, 0, 26);
> +}
split all build_append_foo() into separate patches /a patch per function/,

probably for GHES related primitives it would be better use 'ghes'
domain prefix in function names, like

  s/build_append_notify/build_append_ghes_notify/

the same applies to other build_append_foo() below


> +/* Generic Error Status Block
> + * ACPI 4.0: 17.3.2.6.1 Generic Error Data
> + */
> +static void build_append_gesb_header(GArray *table, uint32_t block_status,
> +                      uint32_t raw_data_offset, uint32_t raw_data_length,
> +                      uint32_t data_length, uint32_t error_severity)
> +{
> +    build_append_int_noprefix(table, block_status, 4);
> +    build_append_int_noprefix(table, raw_data_offset, 4);
> +    build_append_int_noprefix(table, raw_data_length, 4);
> +    build_append_int_noprefix(table, data_length, 4);
> +    build_append_int_noprefix(table, error_severity, 4);
> +}
> +
> +/* Generic Error Data Entry
> + * ACPI 4.0: 17.3.2.6.1 Generic Error Data
> + */
> +static void build_append_gede_header(GArray *table, const char *section_type,
> +                      const uint32_t error_severity, const uint16_t revision,
> +                      const uint32_t error_data_length)
> +{
> +    int i;
> +
> +    for (i = 0; i < 16; i++) {
> +        build_append_int_noprefix(table, section_type[i], 1);
> +    }
> +
> +    build_append_int_noprefix(table, error_severity, 4);
> +    build_append_int_noprefix(table, revision, 2);
> +    build_append_int_noprefix(table, 0, 2);
> +    build_append_int_noprefix(table, error_data_length, 4);
> +    build_append_int_noprefix(table, 0, 44);
> +}
> +
> +/* Memory section CPER record */
comment missing reference to related spec item

> +static void build_append_mem_cper(GArray *table, uint64_t error_physical_addr)
> +{
> +    /*
> +     * Memory Error Record
> +     */
> +    build_append_int_noprefix(table,
> +                 (1UL << 14) | /* Type Valid */
> +                 (1UL << 1) /* Physical Address Valid */,
> +                 8);
> +    /* Memory error status information */
> +    build_append_int_noprefix(table, 0, 8);
> +    /* The physical address at which the memory error occurred */
> +    build_append_int_noprefix(table, error_physical_addr, 8);
> +    build_append_int_noprefix(table, 0, 48);
> +    /* Hard code to Multi-bit ECC error */
> +    build_append_int_noprefix(table, 3 /* Multi-bit ECC */, 1);
> +    build_append_int_noprefix(table, 0, 7);
> +}
> +
> +static int ghes_record_mem_error(uint64_t error_block_address,
> +                                    uint64_t error_physical_addr)
probably function should be part of 9/9 patch, as the others that's called
only from ghes_record_errors().

i.e. split this patch into acpi tables generation and actual error generation patches.

> +{
> +    GArray *block;
> +    uint64_t current_block_length;
> +    uint32_t data_length;
> +    /* Memory section */
> +    char mem_section_id_le[] = {0x14, 0x11, 0xBC, 0xA5, 0x64, 0x6F, 0xDE,
> +                                0x4E, 0xB8, 0x63, 0x3E, 0x83, 0xED, 0x7C,
> +                                0x83, 0xB1};
> +
> +    block = g_array_new(false, true /* clear */, 1);
> +
> +    /* Read the current length in bytes of the generic error data */
> +    cpu_physical_memory_read(error_block_address +
> +        offsetof(AcpiGenericErrorStatus, data_length), &data_length, 4);
> +
> +    /* The current whole length in bytes of the generic error status block */
> +    current_block_length = sizeof(AcpiGenericErrorStatus) + data_length;
missing le32_to_cpu() here

also check other sites where you call cpu_physical_memory_foo()

it would be good to have a 'make check' test case included in this series,
then when you can spot these errors during test on BE host, before posting patches.

> +
> +    /* Add a new generic error data entry*/
> +    data_length += GHES_DATA_LENGTH;
> +    data_length += GHES_CPER_LENGTH;
> +
> +    /* Check whether it will run out of the preallocated memory if adding a new
> +     * generic error data entry
> +     */
> +    if ((data_length + sizeof(AcpiGenericErrorStatus)) > GHES_MAX_RAW_DATA_LENGTH) {
> +        error_report("Record CPER out of boundary!!!");
> +        return GHES_CPER_FAIL;
you return values here and from ghes_record_errors() but not actually
handle them, so it's rather pointless thing to do,
more over it's called on nofail path so one should either abort on error o ignore it

> +    }
> +    /* Build the new generic error status block header */
> +    build_append_gesb_header(block, cpu_to_le32(ACPI_GEBS_UNCORRECTABLE), 0, 0,
> +        cpu_to_le32(data_length), cpu_to_le32(ACPI_CPER_SEV_RECOVERABLE));
> +
> +    /* Write back above generic error status block header to guest memory */
> +    cpu_physical_memory_write(error_block_address, block->data,
> +                              block->len);
> +
> +    /* Build the generic error data entries */
> +
> +    data_length = block->len;
> +    /* Build the new generic error data entry header */
> +    build_append_gede_header(block, mem_section_id_le,
> +                    cpu_to_le32(ACPI_CPER_SEV_RECOVERABLE), cpu_to_le32(0x300),
> +                    cpu_to_le32(80)/* the total size of Memory Error Record */);
> +
> +    /* Build the memory section CPER */
> +    build_append_mem_cper(block, error_physical_addr);
> +
> +    /* Write back above whole new generic error data entry to guest memory */
> +    cpu_physical_memory_write(error_block_address + current_block_length,
> +                    block->data + data_length, block->len - data_length);
> +
> +    g_array_free(block, true);
> +
> +    return GHES_CPER_OK;
> +}
[...]

I'll try to make another round of review on this once patch is split
