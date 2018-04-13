Received: from eggs.gnu.org ([2001:4830:134:3::10]:34844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1f6z3R-0000eO-Ss
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 09:47:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1f6z3R-00083h-2j
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 09:47:53 -0400
Date: Fri, 13 Apr 2018 15:47:34 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180413134734.ooeu36abnlafglwi@hawk.localdomain>
References: <1522160122-10744-1-git-send-email-eric.auger@redhat.com>
	<1522160122-10744-8-git-send-email-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522160122-10744-8-git-send-email-eric.auger@redhat.com>
Subject: Re: [Qemu-devel] [RFC 7/8] hw/arm/virt-acpi-build: Handle multiple
 GICR structures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, wei@redhat.com, marc.zyngier@arm.com, cdall@kernel.org, zhaoshenglong@huawei.com

On Tue, Mar 27, 2018 at 04:15:21PM +0200, Eric Auger wrote:
> In case multiple redistributor regions were registered,
> let's add the corresponding GICR structures in the MADT
> ACPI table.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/arm/virt-acpi-build.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index c7c6a57..aefc1b4 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -43,6 +43,7 @@
>  #include "hw/pci/pcie_host.h"
>  #include "hw/pci/pci.h"
>  #include "hw/arm/virt.h"
> +#include "hw/intc/arm_gicv3.h"
>  #include "sysemu/numa.h"
>  #include "kvm_arm.h"
>  
> @@ -618,14 +619,22 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      }
>  
>      if (vms->gic_version == 3) {
> +        GICv3State *s = (GICv3State *)vms->gic;
> +        int r;
> +
>          AcpiMadtGenericTranslator *gic_its;
> -        AcpiMadtGenericRedistributor *gicr = acpi_data_push(table_data,
> -                                                         sizeof *gicr);
>  
> -        gicr->type = ACPI_APIC_GENERIC_REDISTRIBUTOR;
> -        gicr->length = sizeof(*gicr);
> -        gicr->base_address = cpu_to_le64(memmap[VIRT_GIC_REDIST].base);
> -        gicr->range_length = cpu_to_le32(memmap[VIRT_GIC_REDIST].size);
> +        for (r = 0; r <  s->nb_redist_regions; r++) {
                           ^ extra space
> +            AcpiMadtGenericRedistributor *gicr = acpi_data_push(table_data,
> +                                                                sizeof *gicr);
> +
> +            gicr->type = ACPI_APIC_GENERIC_REDISTRIBUTOR;
> +            gicr->length = sizeof(*gicr);

This file has inconsistent use of () with sizeof. If you want to start
it on its path to using ()'s, like the majority of QEMU code, then you
could add them to the acpi_data_push() above.

> +            gicr->base_address = cpu_to_le64(s->redist_region[r].base);
> +            /* count redistributors of 2 x 64kB pages */
> +            gicr->range_length =
> +                cpu_to_le64((uint64_t)s->redist_region[r].count << 17);
                            ^^ range_length is only 4 bytes.

It might be nice to have a define of some sort for the 2*64K to avoid it
getting scattered everywhere. 

> +        }
>  
>          if (its_class_name() && !vmc->no_its) {
>              gic_its = acpi_data_push(table_data, sizeof *gic_its);
> -- 
> 2.5.5
> 
>

Thanks,
drew 
