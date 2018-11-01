Received: from eggs.gnu.org ([2001:4830:134:3::10]:46049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gIH7J-0002Dj-B7
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:50:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gIH7F-0003qz-86
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:50:49 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39767)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gIH7F-0003qX-0Y
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:50:45 -0400
Received: by mail-wm1-f68.google.com with SMTP id u13-v6so2021568wmc.4
	for <qemu-devel@nongnu.org>; Thu, 01 Nov 2018 10:50:44 -0700 (PDT)
References: <20181101102303.16439-1-sameo@linux.intel.com>
	<20181101102303.16439-4-sameo@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1f8b7079-111a-4aee-cd18-fde69a49f359@redhat.com>
Date: Thu, 1 Nov 2018 18:50:41 +0100
MIME-Version: 1.0
In-Reply-To: <20181101102303.16439-4-sameo@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 03/23] hw: acpi: Export the RSDP build
 API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Igor Mammedov <imammedo@redhat.com>, "open list:ARM ACPI Subsystem" <qemu-arm@nongnu.org>, Richard Henderson <rth@twiddle.net>

Hey Samuel,

On 1/11/18 11:22, Samuel Ortiz wrote:
> The hardware-reduced API will need to build RSDP as well, so we should
> export this routine. While doing so, we also slightly change the
> function prototype. Since no caller needs it, and to make it more
> consistent with the rest of the AML build API, the function no longer
> returns its RSDP table.
> 
> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> ---
>   hw/acpi/aml-build.c         | 24 ++++++++++++++++++++++++
>   hw/arm/virt-acpi-build.c    |  2 +-

When you modify files from architectures you are not custom to use, you 
should verify your changes don't break them ;)

>   hw/i386/acpi-build.c        | 26 --------------------------
>   include/hw/acpi/aml-build.h |  3 +++
>   4 files changed, 28 insertions(+), 27 deletions(-)
> 
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 51b608432f..2d6f538f9d 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -1651,6 +1651,30 @@ build_xsdt(GArray *table_data, BIOSLinker *linker, GArray *table_offsets,
>                    (void *)xsdt, "XSDT", xsdt_len, 1, oem_id, oem_table_id);
>   }
>   
> +void
> +build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned rsdt_tbl_offset)
> +{
> +    AcpiRsdpDescriptor *rsdp = acpi_data_push(rsdp_table, sizeof *rsdp);
> +    unsigned rsdt_pa_size = sizeof(rsdp->rsdt_physical_address);
> +    unsigned rsdt_pa_offset =
> +        (char *)&rsdp->rsdt_physical_address - rsdp_table->data;
> +
> +    bios_linker_loader_alloc(linker, ACPI_BUILD_RSDP_FILE, rsdp_table, 16,
> +                             true /* fseg memory */);
> +
> +    memcpy(&rsdp->signature, "RSD PTR ", 8);
> +    memcpy(rsdp->oem_id, ACPI_BUILD_APPNAME6, 6);
> +    /* Address to be filled by Guest linker */
> +    bios_linker_loader_add_pointer(linker,
> +        ACPI_BUILD_RSDP_FILE, rsdt_pa_offset, rsdt_pa_size,
> +        ACPI_BUILD_TABLE_FILE, rsdt_tbl_offset);
> +
> +    /* Checksum to be filled by Guest linker */
> +    bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
> +        (char *)rsdp - rsdp_table->data, sizeof *rsdp,
> +        (char *)&rsdp->checksum - rsdp_table->data);
> +}
> +
>   void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_t base,
>                          uint64_t len, int node, MemoryAffinityFlags flags)
>   {
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index f28a2faa53..0ed132b79b 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -367,7 +367,7 @@ static void acpi_dsdt_add_power_button(Aml *scope)
>   }
>   
>   /* RSDP */
> -static GArray *
> +static void
>   build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned xsdt_tbl_offset)
>   {

Since this function doesn't return anything now, you can simply remove 
the last line to avoid:

hw/arm/virt-acpi-build.c: In function ‘build_rsdp’:
hw/arm/virt-acpi-build.c:396:12: error: ‘return’ with a value, in 
function returning void [-Werror]
      return rsdp_table;
             ^~~~~~~~~~

(I used 'make subdir-aarch64-softmmu' to build).

Also since you declare the prototype in "hw/acpi/aml-build.h", you have 
to remove the 'static' keyword:

hw/arm/virt-acpi-build.c:371:1: error: static declaration of 
‘build_rsdp’ follows non-static declaration
  build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned 
xsdt_tbl_offset)
  ^~~~~~~~~~
hw/arm/virt-acpi-build.c:42:
include/hw/acpi/aml-build.h:393:1: note: previous declaration of 
‘build_rsdp’ was here
  build_rsdp(GArray *table_data,
  ^~~~~~~~~~

Maybe I was not clear enough in my previous review, I suggest doing this 
in 3 steps:

1: both functions return void (still static)
2: expose the prototype declaration in "hw/acpi/aml-build.h" (remove 
static keyword)
3: unify codebase moving build_rsdp() to hw/acpi/aml-build.c

steps 1+2 could be merged, but IMHO 3 steps are cleaner.

>       AcpiRsdpDescriptor *rsdp = acpi_data_push(rsdp_table, sizeof *rsdp);
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 81d98fa34f..d7b47e05b5 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2513,32 +2513,6 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker)
>                    "IVRS", table_data->len - iommu_start, 1, NULL, NULL);
>   }
>   
> -static GArray *
> -build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned rsdt_tbl_offset)
> -{
> -    AcpiRsdpDescriptor *rsdp = acpi_data_push(rsdp_table, sizeof *rsdp);
> -    unsigned rsdt_pa_size = sizeof(rsdp->rsdt_physical_address);
> -    unsigned rsdt_pa_offset =
> -        (char *)&rsdp->rsdt_physical_address - rsdp_table->data;
> -
> -    bios_linker_loader_alloc(linker, ACPI_BUILD_RSDP_FILE, rsdp_table, 16,
> -                             true /* fseg memory */);
> -
> -    memcpy(&rsdp->signature, "RSD PTR ", 8);
> -    memcpy(rsdp->oem_id, ACPI_BUILD_APPNAME6, 6);
> -    /* Address to be filled by Guest linker */
> -    bios_linker_loader_add_pointer(linker,
> -        ACPI_BUILD_RSDP_FILE, rsdt_pa_offset, rsdt_pa_size,
> -        ACPI_BUILD_TABLE_FILE, rsdt_tbl_offset);
> -
> -    /* Checksum to be filled by Guest linker */
> -    bios_linker_loader_add_checksum(linker, ACPI_BUILD_RSDP_FILE,
> -        (char *)rsdp - rsdp_table->data, sizeof *rsdp,
> -        (char *)&rsdp->checksum - rsdp_table->data);
> -
> -    return rsdp_table;
> -}
> -
>   static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
>   {
>       Object *pci_host;
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index 73fc6659f2..c9bcb32d81 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -390,6 +390,9 @@ void acpi_add_table(GArray *table_offsets, GArray *table_data);
>   void acpi_build_tables_init(AcpiBuildTables *tables);
>   void acpi_build_tables_cleanup(AcpiBuildTables *tables, bool mfre);
>   void
> +build_rsdp(GArray *table_data,
> +           BIOSLinker *linker, unsigned rsdt_tbl_offset);
> +void
>   build_rsdt(GArray *table_data, BIOSLinker *linker, GArray *table_offsets,
>              const char *oem_id, const char *oem_table_id);
>   void
> 
