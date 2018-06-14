Received: from eggs.gnu.org ([2001:4830:134:3::10]:50215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fTSXf-0008E1-Tt
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:44:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fTSXf-00033e-22
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:43:59 -0400
Date: Thu, 14 Jun 2018 15:43:48 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180614134348.n32qcfr2hrsn7eri@kamzik.brq.redhat.com>
References: <1528879723-24675-1-git-send-email-eric.auger@redhat.com>
	<1528879723-24675-7-git-send-email-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528879723-24675-7-git-send-email-eric.auger@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 6/9] hw/arm/virt-acpi-build: Advertise one
 or two GICR structures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, wei@redhat.com, ard.biesheuvel@linaro.org, marc.zyngier@arm.com, christoffer.dall@arm.com, zhaoshenglong@huawei.com, lersek@redhat.com

On Wed, Jun 13, 2018 at 10:48:40AM +0200, Eric Auger wrote:
> Depending on the number of smp_cpus we now register one or two
> GICR structures.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/arm/virt-acpi-build.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 74f5744..eefd1d4 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -670,6 +670,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>  
>      if (vms->gic_version == 3) {
>          AcpiMadtGenericTranslator *gic_its;
> +        int nb_redist_regions = virt_gicv3_redist_region_count(vms);
>          AcpiMadtGenericRedistributor *gicr = acpi_data_push(table_data,
>                                                           sizeof *gicr);
>  
> @@ -678,6 +679,14 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          gicr->base_address = cpu_to_le64(memmap[VIRT_GIC_REDIST].base);
>          gicr->range_length = cpu_to_le32(memmap[VIRT_GIC_REDIST].size);
>  
> +        if (nb_redist_regions == 2) {
> +            gicr = acpi_data_push(table_data, sizeof(*gicr));
> +            gicr->type = ACPI_APIC_GENERIC_REDISTRIBUTOR;
> +            gicr->length = sizeof(*gicr);
> +            gicr->base_address = cpu_to_le64(memmap[VIRT_GIC_REDIST2].base);
> +            gicr->range_length = cpu_to_le32(memmap[VIRT_GIC_REDIST2].size);
> +        }
> +
>          if (its_class_name() && !vmc->no_its) {
>              gic_its = acpi_data_push(table_data, sizeof *gic_its);
>              gic_its->type = ACPI_APIC_GENERIC_TRANSLATOR;
> -- 
> 2.5.5
> 
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
