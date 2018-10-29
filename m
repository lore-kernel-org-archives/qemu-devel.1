Received: from eggs.gnu.org ([2001:4830:134:3::10]:33330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHCkN-0000eo-55
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 14:58:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHCkI-0000p8-1J
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 14:58:43 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37162)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gHCkH-0000kK-Pf
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 14:58:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id g9-v6so9901533wrq.4
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 11:58:37 -0700 (PDT)
References: <20181029170159.3801-1-sameo@linux.intel.com>
	<20181029170159.3801-4-sameo@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b6250035-60a0-2d03-bcb7-36a2d09e265a@redhat.com>
Date: Mon, 29 Oct 2018 19:58:34 +0100
MIME-Version: 1.0
In-Reply-To: <20181029170159.3801-4-sameo@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 03/19] hw: acpi: Export the RSDP build
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi Samuel,

On 29/10/18 18:01, Samuel Ortiz wrote:
> The hardware-reduced API will need to build RSDP as well, so we should
> export this routine. While doing so, we also slightly change the
> function prototype. Since no caller needs it, and to make it more
> consistent with the rest of the AML build API, the function no longer
> returns its RSDP table.
> 
> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> ---
>   hw/acpi/aml-build.c         | 24 ++++++++++++++++++++++++
>   hw/i386/acpi-build.c        | 26 --------------------------
>   include/hw/acpi/aml-build.h |  3 +++
>   3 files changed, 27 insertions(+), 26 deletions(-)
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
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 1bf02b6a93..9f1c9f4cf5 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2512,32 +2512,6 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker)
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
> index 813f51317c..865f5d23f5 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -390,6 +390,9 @@ void acpi_add_table(GArray *table_offsets, GArray *table_data);
>   void acpi_build_tables_init(AcpiBuildTables *tables);
>   void acpi_build_tables_cleanup(AcpiBuildTables *tables, bool mfre);
>   void
> +build_rsdp(GArray *table_data,
> +           BIOSLinker *linker, unsigned rsdt_tbl_offset);

You now need to update the prototype of build_rsdp() in 
hw/arm/virt-acpi-build.c to have this patch bisectable, even if you 
remove this function in your patch #5.

Maybe it is easier to first export it (removing bug in ARM),
then change the prototype.

> +void
>   build_rsdt(GArray *table_data, BIOSLinker *linker, GArray *table_offsets,
>              const char *oem_id, const char *oem_table_id);
>   void
> 
