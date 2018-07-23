Received: from eggs.gnu.org ([2001:4830:134:3::10]:52688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fhatO-0000yx-LF
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 09:28:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fhatN-0003LW-EF
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 09:28:50 -0400
Date: Mon, 23 Jul 2018 15:28:36 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180723152836.47d3047f@redhat.com>
In-Reply-To: <20180704124923.32483-5-drjones@redhat.com>
References: <20180704124923.32483-1-drjones@redhat.com>
	<20180704124923.32483-5-drjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 4/6] hw/arm/virt-acpi-build:
 distinguish possible and present cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, wei@redhat.com, peter.maydell@linaro.org, eric.auger@redhat.com

On Wed,  4 Jul 2018 14:49:21 +0200
Andrew Jones <drjones@redhat.com> wrote:

> When building ACPI tables regarding CPUs we should always build
> them for the number of possible CPUs, not the number of present
> CPUs. We then ensure only the present CPUs are enabled.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  hw/arm/virt-acpi-build.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 6ea47e258832..1d1fc824da6f 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -49,14 +49,22 @@
>  #define ARM_SPI_BASE 32
>  #define ACPI_POWER_BUTTON_DEVICE "PWRB"
>  
> -static void acpi_dsdt_add_cpus(Aml *scope, int smp_cpus)
> +static int possible_cpus(VirtMachineState *vms)
> +{
> +    return MACHINE_GET_CLASS(vms)->possible_cpu_arch_ids(MACHINE(vms))->len;
> +}
> +
> +static void acpi_dsdt_add_cpus(Aml *scope, int possible, int present)
>  {
>      uint16_t i;
>  
> -    for (i = 0; i < smp_cpus; i++) {
> +    for (i = 0; i < possible; i++) {
>          Aml *dev = aml_device("C%.03X", i);
>          aml_append(dev, aml_name_decl("_HID", aml_string("ACPI0007")));
>          aml_append(dev, aml_name_decl("_UID", aml_int(i)));
> +        if (i >= present) {

acpi_dsdt_add_cpus(Aml *scope, const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(machine)) {
      for (i = 0; i < possible_cpus->len; i++) {
          ...
          if (possible_cpus->cpus[i].cpu == NULL)
               aml_append(dev, aml_name_decl("_STA", aml_int(0)));
      }
}

would be better to be consistent with x86 variant (well I prefer using a single source for CPU enumeration whenever possible) and drop helper above.

> +            aml_append(dev, aml_name_decl("_STA", aml_int(0)));
> +        }
>          aml_append(scope, dev);
>      }
>  }
> @@ -650,7 +658,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      gicd->base_address = cpu_to_le64(memmap[VIRT_GIC_DIST].base);
>      gicd->version = vms->gic_version;
>  
> -    for (i = 0; i < vms->smp_cpus; i++) {
> +    for (i = 0; i < possible_cpus(vms); i++) {
ditto

>          AcpiMadtGenericCpuInterface *gicc = acpi_data_push(table_data,
>                                                             sizeof(*gicc));
>          ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(i));
> @@ -663,7 +671,9 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          gicc->cpu_interface_number = cpu_to_le32(i);
>          gicc->arm_mpidr = cpu_to_le64(armcpu->mp_affinity);
>          gicc->uid = cpu_to_le32(i);
> -        gicc->flags = cpu_to_le32(ACPI_MADT_GICC_ENABLED);
> +        if (i < vms->smp_cpus) {
> +            gicc->flags = cpu_to_le32(ACPI_MADT_GICC_ENABLED);
> +        }
>  
>          if (arm_feature(&armcpu->env, ARM_FEATURE_PMU)) {
>              gicc->performance_interrupt = cpu_to_le32(PPI(VIRTUAL_PMU_IRQ));
> @@ -763,7 +773,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>       * the RTC ACPI device at all when using UEFI.
>       */
>      scope = aml_scope("\\_SB");
> -    acpi_dsdt_add_cpus(scope, vms->smp_cpus);
> +    acpi_dsdt_add_cpus(scope, possible_cpus(vms), vms->smp_cpus);
>      acpi_dsdt_add_uart(scope, &memmap[VIRT_UART],
>                         (irqmap[VIRT_UART] + ARM_SPI_BASE));
>      acpi_dsdt_add_flash(scope, &memmap[VIRT_FLASH]);
