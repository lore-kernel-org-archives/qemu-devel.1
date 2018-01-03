Received: from eggs.gnu.org ([2001:4830:134:3::10]:53211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eWYgZ-0002GY-8x
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 21:21:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eWYgX-00083m-9v
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 21:21:43 -0500
References: <1514440458-10515-1-git-send-email-gengdongjiu@huawei.com>
	<1514440458-10515-3-git-send-email-gengdongjiu@huawei.com>
	<20171228151809.10495a90@igors-macbook-pro.local>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <10087bbd-28b0-b5ad-101a-e6d5ac648548@huawei.com>
Date: Wed, 3 Jan 2018 10:21:06 +0800
MIME-Version: 1.0
In-Reply-To: <20171228151809.10495a90@igors-macbook-pro.local>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: pbonzini@redhat.com, mst@redhat.com, zhaoshenglong@huawei.com, peter.maydell@linaro.org, mtosatti@redhat.com, rth@twiddle.net, ehabkost@redhat.com, james.morse@arm.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, huangshaoyu@huawei.com, zhengqiang10@huawei.com, xuwei5@hisilicon.com

Hi Igor,
   sorry for my late response due to new year holiday.

On 2017/12/28 22:18, Igor Mammedov wrote:
> On Thu, 28 Dec 2017 13:54:11 +0800
> Dongjiu Geng <gengdongjiu@huawei.com> wrote:
>=20
>> This implements APEI GHES Table generation and record CPER in
>> runtime via fw_cfg blobs.Now we only support two types of GHESv2,
>> which are GPIO-Signal and ARMv8 SEA. Afterwards, we can extend the
>> supported type if needed. For the CPER section type, currently it
> s/type/types/
Ok

>=20
>> is memory section because kernel manly wants userspace to handle
> s/manly/mainly/
Ok

>=20
>> the memory errors.=20
>=20
>> In order to simulation, we hard code the error
>> type to Multi-bit ECC.
> Not sure what this is about, care to elaborate?

please see Memory Error Record in [1], in which the "Memory Error Type" f=
ield is used to describe the
error type, such as  Multi-bit ECC or Parity Error etc. Because KVM or ho=
st does not pass the memory
error type to Qemu, so Qemu does not know what is the error type for the =
memory section. Hence we let QEMU simulate
the error type to Multi-bit ECC.

[1]:
UEFI Spec 2.6 Errata A:

"N.2.5 Memory Error Section"
-----------------+---------------+--------------+------------------------=
-------------------+
        Mnemonic |   Byte Offset |  Byte Length |        Description     =
                   |
-----------------+---------------+--------------+------------------------=
-------------------+
        ........ |  ............ |  .........   |        ...........     =
                   |
-----------------+---------------+--------------+------------------------=
-------------------+
Memory Error Type|     72        |       1      |Identifies the type of e=
rror that occurred:|
		 |		 |		| 0 =E2=80=93 Unknown                              |
		 |		 |		| 1 =E2=80=93 No error                             |
		 |		 |		| 2 =E2=80=93 Single-bit ECC                       |
		 |		 |		| 3 =E2=80=93 Multi-bit ECC                        |
		 |		 |		| 4 =E2=80=93 Single-symbol ChipKill ECC           |
		 |		 |		| 5 =E2=80=93 Multi-symbol ChipKill ECC            |
		 |		 |		| 6 =E2=80=93 Master abort			    |
		 |		 |		| 7 =E2=80=93 Target abort			    |
		 |		 |		| 8 =E2=80=93 Parity Error			    |
		 |		 |		| 9 =E2=80=93 Watchdog timeout			    |
		 |		 |		| 10 =E2=80=93 Invalid address			    |
		 |		 |		| 11 =E2=80=93 Mirror Broken			    |
		 |		 |		| 12 =E2=80=93 Memory Sparing			    |
		 |		 |		| 13 - Scrub corrected error		    |
		 |		 |		| 14 - Scrub uncorrected error		    |
		 |		 |		| 15 - Physical Memory Map-out event	    |
		 |		 |		| All other values reserved.		    |
-----------------+---------------+--------------+------------------------=
-------------------+
        ........ |  ............ |  .........   |        ...........     =
                   |
-----------------+---------------+--------------+------------------------=
-------------------+
>=20
>=20
>> For GHESv2 error source, the OSPM must acknowledges the error via
>> Read ACK register. So user space must check the ACK value before
>> recording a new CPER to avoid read-write race condition.
>>
>> Suggested-by: Laszlo Ersek <lersek@redhat.com>
>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>> ---
>> The basic solution is suggested by Laszlo in [1]
>> [1]: https://lkml.org/lkml/2017/3/29/342
>=20
>=20
> patch is too big, it would be better if it were split in several parts.
Ok, I will split it.

>=20
>> ---
>>  hw/acpi/aml-build.c         |   2 +
>>  hw/acpi/hest_ghes.c         | 390 +++++++++++++++++++++++++++++++++++=
+++++++++
>>  hw/arm/virt-acpi-build.c    |   8 +
>>  include/hw/acpi/aml-build.h |   1 +
>>  include/hw/acpi/hest_ghes.h |  82 ++++++++++
>>  5 files changed, 483 insertions(+)
>>  create mode 100644 hw/acpi/hest_ghes.c
>>  create mode 100644 include/hw/acpi/hest_ghes.h
>>
>> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
>> index 36a6cc4..6849e5f 100644
>> --- a/hw/acpi/aml-build.c
>> +++ b/hw/acpi/aml-build.c
>> @@ -1561,6 +1561,7 @@ void acpi_build_tables_init(AcpiBuildTables *tab=
les)
>>      tables->table_data =3D g_array_new(false, true /* clear */, 1);
>>      tables->tcpalog =3D g_array_new(false, true /* clear */, 1);
>>      tables->vmgenid =3D g_array_new(false, true /* clear */, 1);
>> +    tables->hardware_errors =3D g_array_new(false, true /* clear */, =
1);
>>      tables->linker =3D bios_linker_loader_init();
>>  }
>> =20
>> @@ -1571,6 +1572,7 @@ void acpi_build_tables_cleanup(AcpiBuildTables *=
tables, bool mfre)
>>      g_array_free(tables->table_data, true);
>>      g_array_free(tables->tcpalog, mfre);
>>      g_array_free(tables->vmgenid, mfre);
>> +    g_array_free(tables->hardware_errors, mfre);
>>  }
>> =20
>>  /* Build rsdt table */
>> diff --git a/hw/acpi/hest_ghes.c b/hw/acpi/hest_ghes.c
>> new file mode 100644
>> index 0000000..86ec99e
>> --- /dev/null
>> +++ b/hw/acpi/hest_ghes.c
>> @@ -0,0 +1,390 @@
>> +/* Support for generating APEI tables and record CPER for Guests
>> + *
>> + * Copyright (C) 2017 HuaWei Corporation.
>> + *
>> + * Author: Dongjiu Geng <gengdongjiu@huawei.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modi=
fy
>> + * it under the terms of the GNU General Public License as published =
by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> +
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> +
>> + * You should have received a copy of the GNU General Public License =
along
>> + * with this program; if not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/acpi/acpi.h"
>> +#include "hw/acpi/aml-build.h"
>> +#include "hw/acpi/hest_ghes.h"
>> +#include "hw/nvram/fw_cfg.h"
>> +#include "sysemu/sysemu.h"
>> +#include "qemu/error-report.h"
>> +
>> +/* Generic Address Structure (GAS)
>> + * ACPI 2.0/3.0: 5.2.3.1 Generic Address Structure
>> + * 2.0 compat note:
>> + *    @access_width must be 0, see ACPI 2.0:Table 5-1
>> + */
>> +static void build_append_gas(GArray *table, AmlRegionSpace as,
>> +                      uint8_t bit_width, uint8_t bit_offset,
>> +                      uint8_t access_width, uint64_t address)
>> +{
>> +    build_append_int_noprefix(table, as, 1);
>> +    build_append_int_noprefix(table, bit_width, 1);
>> +    build_append_int_noprefix(table, bit_offset, 1);
>> +    build_append_int_noprefix(table, access_width, 1);
>> +    build_append_int_noprefix(table, address, 8);
>> +}
> all build_append_foo() primitives should go into aml-build.c
> you can reuse take following patches for build_append_gas() from my git=
hub repo
> https://github.com/imammedo/qemu/commit/ff35b4ae1ec286f5f11830d504467f5=
ad243995b
> https://github.com/imammedo/qemu/commit/3d2fd6d13a3ea298d2ee814835495ce=
6241d085c

Ok, got it, thanks Igor's comments.

>=20
>=20
>> +/* Hardware Error Notification
>> + * ACPI 4.0: 17.3.2.7 Hardware Error Notification
>> + */
>> +static void build_append_notify(GArray *table, const uint8_t type,
>> +                                uint8_t length)
>> +{
>> +        build_append_int_noprefix(table, type, 1); /* type */
>> +        build_append_int_noprefix(table, length, 1);
>> +        build_append_int_noprefix(table, 0, 26);
>> +}
> split all build_append_foo() into separate patches /a patch per functio=
n/,
>=20
> probably for GHES related primitives it would be better use 'ghes'
> domain prefix in function names, like
>=20
>   s/build_append_notify/build_append_ghes_notify/
>=20
> the same applies to other build_append_foo() below
sure, thanks Igor's good suggestion.

>=20
>=20
>> +/* Generic Error Status Block
>> + * ACPI 4.0: 17.3.2.6.1 Generic Error Data
>> + */
>> +static void build_append_gesb_header(GArray *table, uint32_t block_st=
atus,
>> +                      uint32_t raw_data_offset, uint32_t raw_data_len=
gth,
>> +                      uint32_t data_length, uint32_t error_severity)
>> +{
>> +    build_append_int_noprefix(table, block_status, 4);
>> +    build_append_int_noprefix(table, raw_data_offset, 4);
>> +    build_append_int_noprefix(table, raw_data_length, 4);
>> +    build_append_int_noprefix(table, data_length, 4);
>> +    build_append_int_noprefix(table, error_severity, 4);
>> +}
>> +
>> +/* Generic Error Data Entry
>> + * ACPI 4.0: 17.3.2.6.1 Generic Error Data
>> + */
>> +static void build_append_gede_header(GArray *table, const char *secti=
on_type,
>> +                      const uint32_t error_severity, const uint16_t r=
evision,
>> +                      const uint32_t error_data_length)
>> +{
>> +    int i;
>> +
>> +    for (i =3D 0; i < 16; i++) {
>> +        build_append_int_noprefix(table, section_type[i], 1);
>> +    }
>> +
>> +    build_append_int_noprefix(table, error_severity, 4);
>> +    build_append_int_noprefix(table, revision, 2);
>> +    build_append_int_noprefix(table, 0, 2);
>> +    build_append_int_noprefix(table, error_data_length, 4);
>> +    build_append_int_noprefix(table, 0, 44);
>> +}
>> +
>> +/* Memory section CPER record */
> comment missing reference to related spec item
Ok, thanks for the reminder.

>=20
>> +static void build_append_mem_cper(GArray *table, uint64_t error_physi=
cal_addr)
>> +{
>> +    /*
>> +     * Memory Error Record
>> +     */
>> +    build_append_int_noprefix(table,
>> +                 (1UL << 14) | /* Type Valid */
>> +                 (1UL << 1) /* Physical Address Valid */,
>> +                 8);
>> +    /* Memory error status information */
>> +    build_append_int_noprefix(table, 0, 8);
>> +    /* The physical address at which the memory error occurred */
>> +    build_append_int_noprefix(table, error_physical_addr, 8);
>> +    build_append_int_noprefix(table, 0, 48);
>> +    /* Hard code to Multi-bit ECC error */
>> +    build_append_int_noprefix(table, 3 /* Multi-bit ECC */, 1);
>> +    build_append_int_noprefix(table, 0, 7);
>> +}
>> +
>> +static int ghes_record_mem_error(uint64_t error_block_address,
>> +                                    uint64_t error_physical_addr)
> probably function should be part of 9/9 patch, as the others that's cal=
led
> only from ghes_record_errors().
>=20
> i.e. split this patch into acpi tables generation and actual error gene=
ration patches.
Ok, thanks Igor's good suggestion and review comments.

>=20
>> +{
>> +    GArray *block;
>> +    uint64_t current_block_length;
>> +    uint32_t data_length;
>> +    /* Memory section */
>> +    char mem_section_id_le[] =3D {0x14, 0x11, 0xBC, 0xA5, 0x64, 0x6F,=
 0xDE,
>> +                                0x4E, 0xB8, 0x63, 0x3E, 0x83, 0xED, 0=
x7C,
>> +                                0x83, 0xB1};
>> +
>> +    block =3D g_array_new(false, true /* clear */, 1);
>> +
>> +    /* Read the current length in bytes of the generic error data */
>> +    cpu_physical_memory_read(error_block_address +
>> +        offsetof(AcpiGenericErrorStatus, data_length), &data_length, =
4);
>> +
>> +    /* The current whole length in bytes of the generic error status =
block */
>> +    current_block_length =3D sizeof(AcpiGenericErrorStatus) + data_le=
ngth;
> missing le32_to_cpu() here
>=20
> also check other sites where you call cpu_physical_memory_foo()
>=20
> it would be good to have a 'make check' test case included in this seri=
es,
> then when you can spot these errors during test on BE host, before post=
ing patches.
Ok, sure, thanks.


>=20
>> +
>> +    /* Add a new generic error data entry*/
>> +    data_length +=3D GHES_DATA_LENGTH;
>> +    data_length +=3D GHES_CPER_LENGTH;
>> +
>> +    /* Check whether it will run out of the preallocated memory if ad=
ding a new
>> +     * generic error data entry
>> +     */
>> +    if ((data_length + sizeof(AcpiGenericErrorStatus)) > GHES_MAX_RAW=
_DATA_LENGTH) {
>> +        error_report("Record CPER out of boundary!!!");
>> +        return GHES_CPER_FAIL;
> you return values here and from ghes_record_errors() but not actually
> handle them, so it's rather pointless thing to do,
> more over it's called on nofail path so one should either abort on erro=
r o ignore it
yes, it should, thanks for the point out. I will make it abort if it is f=
ailed.

>=20
>> +    }
>> +    /* Build the new generic error status block header */
>> +    build_append_gesb_header(block, cpu_to_le32(ACPI_GEBS_UNCORRECTAB=
LE), 0, 0,
>> +        cpu_to_le32(data_length), cpu_to_le32(ACPI_CPER_SEV_RECOVERAB=
LE));
>> +
>> +    /* Write back above generic error status block header to guest me=
mory */
>> +    cpu_physical_memory_write(error_block_address, block->data,
>> +                              block->len);
>> +
>> +    /* Build the generic error data entries */
>> +
>> +    data_length =3D block->len;
>> +    /* Build the new generic error data entry header */
>> +    build_append_gede_header(block, mem_section_id_le,
>> +                    cpu_to_le32(ACPI_CPER_SEV_RECOVERABLE), cpu_to_le=
32(0x300),
>> +                    cpu_to_le32(80)/* the total size of Memory Error =
Record */);
>> +
>> +    /* Build the memory section CPER */
>> +    build_append_mem_cper(block, error_physical_addr);
>> +
>> +    /* Write back above whole new generic error data entry to guest m=
emory */
>> +    cpu_physical_memory_write(error_block_address + current_block_len=
gth,
>> +                    block->data + data_length, block->len - data_leng=
th);
>> +
>> +    g_array_free(block, true);
>> +
>> +    return GHES_CPER_OK;
>> +}
> [...]
>=20
> I'll try to make another round of review on this once patch is split
Ok, thanks in advance.

>=20
> .
>=20
