Received: from eggs.gnu.org ([209.51.188.92]:56250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gzkf6-0003B8-Iz
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:05:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gzkf4-0008VD-J1
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:05:23 -0500
Date: Fri, 1 Mar 2019 17:04:51 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190301170451.7bc5504a@redhat.com>
In-Reply-To: <20190301134709.4695-10-eric.auger@redhat.com>
References: <20190301134709.4695-1-eric.auger@redhat.com>
	<20190301134709.4695-10-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v11 09/10] hw/arm/virt: Check the VCPU PA
 range in TCG mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, david@redhat.com, dgilbert@redhat.com, david@gibson.dropbear.id.au, drjones@redhat.com, pbonzini@redhat.com

On Fri,  1 Mar 2019 14:47:08 +0100
Eric Auger <eric.auger@redhat.com> wrote:

> We are about to allow the memory map to grow beyond 1TB and
> potentially overshoot the VCPU AA64MMFR0.PARANGE.
> 
> In aarch64 mode and when highmem is set, let's check the VCPU
> PA range is sufficient to address the highest GPA of the memory
> map.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/arm/virt.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 300eaae26f..ab70e4a657 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -60,6 +60,7 @@
>  #include "standard-headers/linux/input.h"
>  #include "hw/arm/smmuv3.h"
>  #include "hw/acpi/acpi.h"
> +#include "target/arm/internals.h"
>  
>  #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
>      static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
> @@ -1608,6 +1609,22 @@ static void machvirt_init(MachineState *machine)
>      fdt_add_timer_nodes(vms);
>      fdt_add_cpu_nodes(vms);
>  
> +   if (!kvm_enabled()) {
> +        ARMCPU *cpu = ARM_CPU(first_cpu);
> +        bool aarch64 = object_property_get_bool(OBJECT(cpu), "aarch64", NULL);
> +
> +        if (aarch64 && vms->highmem) {
> +            int requested_pa_size, pamax = arm_pamax(cpu);
> +
> +            requested_pa_size = 64 - clz64(vms->highest_gpa);
> +            if (pamax < requested_pa_size) {
> +                error_report("VCPU supports less PA bits (%d) than requested "
> +                            "by the memory map (%d)", pamax, requested_pa_size);
> +                exit(1);
> +            }
> +        }
> +    }
> +
>      memory_region_allocate_system_memory(ram, NULL, "mach-virt.ram",
>                                           machine->ram_size);
>      memory_region_add_subregion(sysmem, vms->memmap[VIRT_MEM].base, ram);
