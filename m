Received: from eggs.gnu.org ([209.51.188.92]:36827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hG1Ch-0002iR-OA
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 08:59:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hG1Cg-0002Bt-Kf
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 08:59:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38561)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hG1Cg-0002Af-Ci
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 08:59:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id k11so21850758wro.5
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 05:59:18 -0700 (PDT)
References: <20190415070307.13668-1-richardw.yang@linux.intel.com>
	<20190415070307.13668-4-richardw.yang@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <97d23905-4c51-070b-f58a-b627cb13ba11@redhat.com>
Date: Mon, 15 Apr 2019 14:59:15 +0200
MIME-Version: 1.0
In-Reply-To: <20190415070307.13668-4-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 3/4] hw/arm/virt-acpi-build: pass
 AcpiMcfgInfo to build_mcfg()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, mst@redhat.com, shannon.zhaosl@gmail.com, imammedo@redhat.com

On 4/15/19 9:03 AM, Wei Yang wrote:
> To build MCFG, two information is necessary:
> 
>     * bus number
>     * base address
> 
> Abstract these two information to AcpiMcfgInfo so that build_mcfg and
> build_mcfg_q35 will have the same declaration.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> 
> ---
> v2:
>   * for arm platform, construct a AcpiMcfgInfo directly
> ---
>  hw/arm/virt-acpi-build.c    | 17 ++++++++++-------
>  hw/i386/acpi-build.c        |  5 -----
>  include/hw/acpi/aml-build.h |  5 +++++
>  3 files changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index e09e7eff8d..7350f207b5 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -546,21 +546,18 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>  }
>  
>  static void
> -build_mcfg(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> +build_mcfg(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
>  {
>      AcpiTableMcfg *mcfg;
> -    const MemMapEntry *memmap = vms->memmap;
> -    int ecam_id = VIRT_ECAM_ID(vms->highmem_ecam);
>      int len = sizeof(*mcfg) + sizeof(mcfg->allocation[0]);
>  
>      mcfg = acpi_data_push(table_data, len);
> -    mcfg->allocation[0].address = cpu_to_le64(memmap[ecam_id].base);
> +    mcfg->allocation[0].address = cpu_to_le64(info->base);
>  
>      /* Only a single allocation so no need to play with segments */
>      mcfg->allocation[0].pci_segment = cpu_to_le16(0);
>      mcfg->allocation[0].start_bus_number = 0;
> -    mcfg->allocation[0].end_bus_number =
> -        PCIE_MMCFG_BUS(memmap[ecam_id].size - 1);
> +    mcfg->allocation[0].end_bus_number = PCIE_MMCFG_BUS(info->size - 1);
>  
>      build_header(linker, table_data, (void *)mcfg, "MCFG", len, 1, NULL, NULL);
>  }
> @@ -801,7 +798,13 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>      build_gtdt(tables_blob, tables->linker, vms);
>  
>      acpi_add_table(table_offsets, tables_blob);
> -    build_mcfg(tables_blob, tables->linker, vms);
> +    {
> +        AcpiMcfgInfo mcfg = {
> +           .base = vms->memmap[VIRT_ECAM_ID(vms->highmem_ecam)].base,
> +           .size = vms->memmap[VIRT_ECAM_ID(vms->highmem_ecam)].size,
> +        };
> +        build_mcfg(tables_blob, tables->linker, &mcfg);
> +    }
>  
>      acpi_add_table(table_offsets, tables_blob);
>      build_spcr(tables_blob, tables->linker, vms);
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index f0d27bffd6..7613b245cf 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -86,11 +86,6 @@
>  /* Default IOAPIC ID */
>  #define ACPI_BUILD_IOAPIC_ID 0x0
>  
> -typedef struct AcpiMcfgInfo {
> -    uint64_t base;
> -    uint32_t size;
> -} AcpiMcfgInfo;
> -
>  typedef struct AcpiPmInfo {
>      bool s3_disabled;
>      bool s4_disabled;
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index 1a563ad756..22dd593068 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -223,6 +223,11 @@ struct AcpiBuildTables {
>      BIOSLinker *linker;
>  } AcpiBuildTables;
>  
> +typedef struct AcpiMcfgInfo {
> +    uint64_t base;
> +    uint32_t size;
> +} AcpiMcfgInfo;
> +
>  /**
>   * init_aml_allocator:
>   *
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
