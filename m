Received: from eggs.gnu.org ([2001:4830:134:3::10]:44804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHF0f-00033k-D2
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:23:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHF0b-0001NB-B0
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:23:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gHF0a-0001Mn-WD
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:23:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id r10-v6so10297787wrv.6
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 14:23:36 -0700 (PDT)
References: <20181029170159.3801-1-sameo@linux.intel.com>
	<20181029170159.3801-20-sameo@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8e7dac3b-1917-fb3c-e9af-d07aff7b892c@redhat.com>
Date: Mon, 29 Oct 2018 22:23:28 +0100
MIME-Version: 1.0
In-Reply-To: <20181029170159.3801-20-sameo@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 19/19] hw: i386: Implement the ACPI
 builder interface for PC
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

On 29/10/18 18:01, Samuel Ortiz wrote:
> All PC machine type derivatives will use the same ACPI table build
> methods. But with that change in place, any new x86 machine type will be
> able to re-use the acpi-build API and customize part of it by defining
> its own ACPI table build methods.
> 
> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> ---
>   hw/i386/acpi-build.c | 15 ++++++++++-----
>   hw/i386/pc.c         | 19 +++++++++++++++++++
>   2 files changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 5035dac556..d40599e6d1 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -35,6 +35,7 @@
>   #include "hw/acpi/acpi-defs.h"
>   #include "hw/acpi/acpi.h"
>   #include "hw/acpi/cpu.h"
> +#include "hw/acpi/builder.h"
>   #include "hw/nvram/fw_cfg.h"
>   #include "hw/acpi/bios-linker-loader.h"
>   #include "hw/loader.h"
> @@ -1556,6 +1557,7 @@ void acpi_build(AcpiBuildTables *tables,
>       GArray *tables_blob = tables->table_data;
>       AcpiSlicOem slic_oem = { .id = NULL, .table_id = NULL };
>       Object *vmgenid_dev;
> +    AcpiBuilder *ab = ACPI_BUILDER(machine);
>   
>       acpi_get_pm_info(&pm);
>       acpi_get_misc_info(&misc);
> @@ -1605,7 +1607,8 @@ void acpi_build(AcpiBuildTables *tables,
>       aml_len += tables_blob->len - fadt;
>   
>       acpi_add_table(table_offsets, tables_blob);
> -    build_madt(tables_blob, tables->linker, machine, conf);
> +    acpi_builder_madt(ab, tables_blob, tables->linker,
> +                      machine, conf);
>   
>       vmgenid_dev = find_vmgenid_dev();
>       if (vmgenid_dev) {
> @@ -1629,15 +1632,17 @@ void acpi_build(AcpiBuildTables *tables,
>       }
>       if (conf->numa_nodes) {
>           acpi_add_table(table_offsets, tables_blob);
> -        build_srat(tables_blob, tables->linker, machine, conf);
> +
> +        acpi_builder_srat(ab, tables_blob, tables->linker,
> +                          machine, conf);
>           if (have_numa_distance) {
>               acpi_add_table(table_offsets, tables_blob);
> -            build_slit(tables_blob, tables->linker);
> +            acpi_builder_slit(ab, tables_blob, tables->linker);
>           }
>       }
>       if (acpi_get_mcfg(&mcfg)) {
>           acpi_add_table(table_offsets, tables_blob);
> -        build_mcfg(tables_blob, tables->linker, &mcfg);
> +        acpi_builder_mcfg(ab, tables_blob, tables->linker, &mcfg);
>       }
>       if (x86_iommu_get_default()) {
>           IommuType IOMMUType = x86_iommu_get_type();
> @@ -1668,7 +1673,7 @@ void acpi_build(AcpiBuildTables *tables,
>                  slic_oem.id, slic_oem.table_id);
>   
>       /* RSDP is in FSEG memory, so allocate it separately */
> -    build_rsdp_rsdt(tables->rsdp, tables->linker, rsdt);
> +    acpi_builder_rsdp(ab, tables->rsdp, tables->linker, rsdt);
>   
>       /* We'll expose it all to Guest so we want to reduce
>        * chance of size changes.
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 1dcbbd5139..986ed0eabd 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -64,6 +64,7 @@
>   #include "qemu/option.h"
>   #include "hw/acpi/acpi.h"
>   #include "hw/acpi/cpu_hotplug.h"
> +#include "hw/acpi/builder.h"
>   #include "hw/boards.h"
>   #include "acpi-build.h"
>   #include "hw/mem/pc-dimm.h"
> @@ -75,6 +76,7 @@
>   #include "hw/nmi.h"
>   #include "hw/i386/intel_iommu.h"
>   #include "hw/net/ne2000-isa.h"
> +#include "hw/i386/acpi.h"
>   
>   /* debug PC/ISA interrupts */
>   //#define DEBUG_IRQ
> @@ -2403,12 +2405,20 @@ static void x86_nmi(NMIState *n, int cpu_index, Error **errp)
>       }
>   }
>   
> +static AcpiConfiguration *pc_acpi_configuration(AcpiBuilder *builder)
> +{
> +    PCMachineState *pcms = PC_MACHINE(builder);
> +
> +    return &pcms->acpi_configuration;
> +}
> +
>   static void pc_machine_class_init(ObjectClass *oc, void *data)
>   {
>       MachineClass *mc = MACHINE_CLASS(oc);
>       PCMachineClass *pcmc = PC_MACHINE_CLASS(oc);
>       HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
>       NMIClass *nc = NMI_CLASS(oc);
> +    AcpiBuilderMethods *abm = ACPI_BUILDER_METHODS(oc);
>   
>       pcmc->pci_enabled = true;
>       pcmc->has_acpi_build = true;
> @@ -2443,6 +2453,14 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
>       nc->nmi_monitor_handler = x86_nmi;
>       mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
>   
> +    /* ACPI building methods */
> +    abm->madt = build_madt;
> +    abm->rsdp = build_rsdp_rsdt;

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +    abm->mcfg = build_mcfg;
> +    abm->srat = build_srat;
> +    abm->slit = build_slit;
> +    abm->configuration = pc_acpi_configuration;
> +
>       object_class_property_add(oc, MEMORY_DEVICE_REGION_SIZE, "int",
>           pc_machine_get_device_memory_region_size, NULL,
>           NULL, NULL, &error_abort);
> @@ -2494,6 +2512,7 @@ static const TypeInfo pc_machine_info = {
>       .interfaces = (InterfaceInfo[]) {
>            { TYPE_HOTPLUG_HANDLER },
>            { TYPE_NMI },
> +         { TYPE_ACPI_BUILDER },
>            { }
>       },
>   };
> 
