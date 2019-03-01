Received: from eggs.gnu.org ([209.51.188.92]:56503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gzkg6-00046e-Cr
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:06:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gzkg5-0000wd-IA
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:06:26 -0500
Date: Fri, 1 Mar 2019 17:06:05 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190301170605.55e5abdb@redhat.com>
In-Reply-To: <20190301134709.4695-11-eric.auger@redhat.com>
References: <20190301134709.4695-1-eric.auger@redhat.com>
	<20190301134709.4695-11-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v11 10/10] hw/arm/virt: Bump the 255GB
 initial RAM limit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, david@redhat.com, pbonzini@redhat.com, drjones@redhat.com, dgilbert@redhat.com, david@gibson.dropbear.id.au

On Fri,  1 Mar 2019 14:47:09 +0100
Eric Auger <eric.auger@redhat.com> wrote:

> Now we have the extended memory map (high IO regions beyond the
> scalable RAM) and dynamic IPA range support at KVM/ARM level
> we can bump the legacy 255GB initial RAM limit. The actual maximum
> RAM size now depends on the physical CPU and host kernel, in
> accelerated mode. In TCG mode, it depends on the VCPU
> AA64MMFR0.PARANGE.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> 
> ---
> v7 -> v8:
> - TCG PAMAX check moved in a separate patch
> 
> v6 -> v7
> - handle TCG case
> - set_memmap modifications moved to previous patches
> ---
>  hw/arm/virt.c | 21 +--------------------
>  1 file changed, 1 insertion(+), 20 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index ab70e4a657..aa06570050 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -95,20 +95,7 @@
>  
>  #define PLATFORM_BUS_NUM_IRQS 64
>  
> -/* RAM limit in GB. Since VIRT_MEM starts at the 1GB mark, this means
> - * RAM can go up to the 256GB mark, leaving 256GB of the physical
> - * address space unallocated and free for future use between 256G and 512G.
> - * If we need to provide more RAM to VMs in the future then we need to:
> - *  * allocate a second bank of RAM starting at 2TB and working up
> - *  * fix the DT and ACPI table generation code in QEMU to correctly
> - *    report two split lumps of RAM to the guest
> - *  * fix KVM in the host kernel to allow guests with >40 bit address spaces
> - * (We don't want to fill all the way up to 512GB with RAM because
> - * we might want it for non-RAM purposes later. Conversely it seems
> - * reasonable to assume that anybody configuring a VM with a quarter
> - * of a terabyte of RAM will be doing it on a host with more than a
> - * terabyte of physical address space.)
> - */
> +/* Legacy RAM limit in GB (< version 4.0) */
>  #define LEGACY_RAMLIMIT_GB 255
>  #define LEGACY_RAMLIMIT_BYTES (LEGACY_RAMLIMIT_GB * GiB)
>  
> @@ -1516,12 +1503,6 @@ static void machvirt_init(MachineState *machine)
>  
>      vms->smp_cpus = smp_cpus;
>  
> -    if (machine->ram_size > vms->memmap[VIRT_MEM].size) {
> -        error_report("mach-virt: cannot model more than %dGB RAM",
> -                     LEGACY_RAMLIMIT_GB);
> -        exit(1);
> -    }
> -
>      if (vms->virt && kvm_enabled()) {
>          error_report("mach-virt: KVM does not support providing "
>                       "Virtualization extensions to the guest CPU");
