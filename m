Received: from eggs.gnu.org ([209.51.188.92]:60891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gvfHw-0008Fp-8M
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 04:32:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gvfHq-000867-De
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 04:32:32 -0500
Date: Mon, 18 Feb 2019 10:31:55 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190218103155.2b74e0a2@Igors-MacBook-Pro.local>
In-Reply-To: <20190205173306.20483-15-eric.auger@redhat.com>
References: <20190205173306.20483-1-eric.auger@redhat.com>
	<20190205173306.20483-15-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 14/18] hw/arm/virt: Allocate
 device_memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, david@redhat.com, drjones@redhat.com, dgilbert@redhat.com, david@gibson.dropbear.id.au

On Tue,  5 Feb 2019 18:33:02 +0100
Eric Auger <eric.auger@redhat.com> wrote:

> The device memory region is located after the initial RAM.
> its start/size are 1GB aligned.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Kwangwoo Lee <kwangwoo.lee@sk.com>
> 
> ---
> v4 -> v5:
> - device memory set after the initial RAM
> 
> v3 -> v4:
> - remove bootinfo.device_memory_start/device_memory_size
> - rename VIRT_HOTPLUG_MEM into VIRT_DEVICE_MEM
> ---
>  hw/arm/virt.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 783468ba77..b683902991 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -61,6 +61,7 @@
>  #include "hw/arm/smmuv3.h"
>  #include "hw/mem/pc-dimm.h"
>  #include "hw/mem/nvdimm.h"
> +#include "hw/acpi/acpi.h"
>  
>  #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
>      static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
> @@ -1260,6 +1261,37 @@ static void create_secure_ram(VirtMachineState *vms,
>      g_free(nodename);
>  }
>  
> +static void create_device_memory(VirtMachineState *vms, MemoryRegion *sysmem)
> +{
> +    MachineState *ms = MACHINE(vms);
> +    uint64_t device_memory_size = ms->maxram_size - ms->ram_size;
should size it with 1Gb alignment per slot from the start (to avoid x86 mistakes),
see enforce_aligned_dimm usage and associated commit for more details

> +    uint64_t align = GiB;
> +
> +    if (!device_memory_size) {
> +        return;
> +    }
> +
> +    if (ms->ram_slots > ACPI_MAX_RAM_SLOTS) {
> +        error_report("unsupported number of memory slots: %"PRIu64,
> +                     ms->ram_slots);
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    if (QEMU_ALIGN_UP(ms->maxram_size, align) != ms->maxram_size) {
> +        error_report("maximum memory size must be aligned to multiple of 0x%"
> +                     PRIx64, align);
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    ms->device_memory = g_malloc0(sizeof(*ms->device_memory));
> +    ms->device_memory->base = QEMU_ALIGN_UP(GiB + ms->ram_size, GiB);
                                               ^^^ where does this come from?


> +
> +    memory_region_init(&ms->device_memory->mr, OBJECT(vms),
> +                       "device-memory", device_memory_size);
> +    memory_region_add_subregion(sysmem, ms->device_memory->base,
> +                                &ms->device_memory->mr);
> +}
> +
>  static void *machvirt_dtb(const struct arm_boot_info *binfo, int *fdt_size)
>  {
>      const VirtMachineState *board = container_of(binfo, VirtMachineState,
> @@ -1569,6 +1601,10 @@ static void machvirt_init(MachineState *machine)
>                                           machine->ram_size);
>      memory_region_add_subregion(sysmem, vms->memmap[VIRT_MEM].base, ram);
>  
> +    if (vms->extended_memmap) {
> +        create_device_memory(vms, sysmem);
> +    }
> +
>      create_flash(vms, sysmem, secure_sysmem ? secure_sysmem : sysmem);
>  
>      create_gic(vms, pic);
