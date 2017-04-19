Received: from eggs.gnu.org ([2001:4830:134:3::10]:56650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d0nkU-00041Z-Uk
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 07:26:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d0nkR-0007cC-KU
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 07:26:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1d0nkR-0007c0-B5
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 07:26:11 -0400
Date: Wed, 19 Apr 2017 13:26:03 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170419132603.369ebb50@nial.brq.redhat.com>
In-Reply-To: <20170407144138.12871-1-ard.biesheuvel@linaro.org>
References: <20170407144138.12871-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] hw/arm/virt: generate 64-bit
 addressable ACPI objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, lersek@redhat.com, phil@philjordan.eu, mst@redhat.com, drjones@redhat.com, zhaoshenglong@huawei.com

On Fri,  7 Apr 2017 15:41:38 +0100
Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> Our current ACPI table generation code limits the placement of ACPI
> tables to 32-bit addressable memory, in order to be able to emit the
> root pointer (RSDP) and root table (RSDT) using table types from the
> ACPI 1.0 days.
> 
> Since ARM was not supported by ACPI before version 5.0, it makes sense
> to lift this restriction. This is not crucial for mach-virt, which is
> guaranteed to have some memory available below the 4 GB mark, but it
> is a nice to have for QEMU machines that do not have any 32-bit
> addressable memory, which is not uncommon for real world 64-bit ARM
> systems.
> 
> Since we already emit a version of the RSDP root pointer that has a
> secondary 64-bit wide address field for the 64-bit root table (XSDT),
> all we need to do is replace the RSDT generation with the generation
> of an XSDT table, and use a different slot in the FADT table to refer
> to the DSDT.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> Acked-by: Laszlo Ersek <lersek@redhat.com>
> ---
> v2: - move new build_xsdt() function to hw/acpi/aml-build.c
>     - tweak commit log text
>     - add Drew's and Laszlo's acks
> 
>  hw/acpi/aml-build.c         | 27 ++++++++++++++++++++
>  hw/arm/virt-acpi-build.c    | 26 +++++++++----------
>  include/hw/acpi/acpi-defs.h | 11 ++++++++
>  include/hw/acpi/aml-build.h |  3 +++
>  4 files changed, 54 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index c6f2032decb1..4ddfb68b247f 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -1599,6 +1599,33 @@ build_rsdt(GArray *table_data, BIOSLinker *linker, GArray *table_offsets,
>                   (void *)rsdt, "RSDT", rsdt_len, 1, oem_id, oem_table_id);
>  }
>  
> +/* Build xsdt table */
> +void
> +build_xsdt(GArray *table_data, BIOSLinker *linker, GArray *table_offsets,
> +           const char *oem_id, const char *oem_table_id)
> +{
> +    int i;
> +    unsigned xsdt_entries_offset;
> +    AcpiXsdtDescriptorRev2 *xsdt;

> +    const unsigned table_data_len = (sizeof(uint64_t) * table_offsets->len);
> +    const unsigned xsdt_entry_size = sizeof(xsdt->table_offset_entry[0]);
nit, I know it was mostly copy/paste but how about:

const unsigned xsdt_entry_size = sizeof(xsdt->table_offset_entry[0]);
const unsigned table_data_len = xsdt_entry_size * table_offsets->len;

> +    const size_t xsdt_len = sizeof(*xsdt) + table_data_len;
> +
> +    xsdt = acpi_data_push(table_data, xsdt_len);
> +    xsdt_entries_offset = (char *)xsdt->table_offset_entry - table_data->data;
> +    for (i = 0; i < table_offsets->len; ++i) {
> +        uint64_t ref_tbl_offset = g_array_index(table_offsets, uint32_t, i);
> +        uint64_t xsdt_entry_offset = xsdt_entries_offset + xsdt_entry_size * i;
> +
> +        /* xsdt->table_offset_entry to be filled by Guest linker */
> +        bios_linker_loader_add_pointer(linker,
> +            ACPI_BUILD_TABLE_FILE, xsdt_entry_offset, xsdt_entry_size,
> +            ACPI_BUILD_TABLE_FILE, ref_tbl_offset);
> +    }
> +    build_header(linker, table_data,
> +                 (void *)xsdt, "XSDT", xsdt_len, 1, oem_id, oem_table_id);
> +}
> +

The rest looks fine to me, so with above fixup

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
