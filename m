Received: from eggs.gnu.org ([209.51.188.92]:36228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gxCI0-0001XC-E0
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:59:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gxCHy-0003qK-QQ
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:59:00 -0500
Date: Fri, 22 Feb 2019 15:58:31 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190222155831.7b534b5d@redhat.com>
In-Reply-To: <7e584e86-1099-a014-c23c-bd2feb4e50ba@redhat.com>
References: <20190220224003.4420-1-eric.auger@redhat.com>
	<20190220224003.4420-14-eric.auger@redhat.com>
	<20190222144846.0a891948@redhat.com>
	<7e584e86-1099-a014-c23c-bd2feb4e50ba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 13/17] hw/arm/virt: Allocate
 device_memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: peter.maydell@linaro.org, drjones@redhat.com, david@redhat.com, qemu-devel@nongnu.org, shameerali.kolothum.thodi@huawei.com, dgilbert@redhat.com, qemu-arm@nongnu.org, david@gibson.dropbear.id.au, eric.auger.pro@gmail.com

On Fri, 22 Feb 2019 15:15:36 +0100
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Igor,
> 
> On 2/22/19 2:48 PM, Igor Mammedov wrote:
> > On Wed, 20 Feb 2019 23:39:59 +0100
> > Eric Auger <eric.auger@redhat.com> wrote:
> >   
> >> The device memory region is located after the initial RAM.
> >> its start/size are 1GB aligned.
> >>
> >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >> Signed-off-by: Kwangwoo Lee <kwangwoo.lee@sk.com>
> >>
> >> ---
> >> v6 -> v7:
> >> - check the device memory top does not wrap
> >> - check the device memory can fit the slots
> >>
> >> v4 -> v5:
> >> - device memory set after the initial RAM
> >>
> >> v3 -> v4:
> >> - remove bootinfo.device_memory_start/device_memory_size
> >> - rename VIRT_HOTPLUG_MEM into VIRT_DEVICE_MEM
> >> ---
> >>  hw/arm/virt.c | 33 +++++++++++++++++++++++++++++++++
> >>  1 file changed, 33 insertions(+)
> >>
> >> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> >> index 470ca0ce2d..33ad9b3f63 100644
> >> --- a/hw/arm/virt.c
> >> +++ b/hw/arm/virt.c
> >> @@ -62,6 +62,7 @@
> >>  #include "target/arm/internals.h"
> >>  #include "hw/mem/pc-dimm.h"
> >>  #include "hw/mem/nvdimm.h"
> >> +#include "hw/acpi/acpi.h"
> >>  
> >>  #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
> >>      static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
> >> @@ -1263,6 +1264,34 @@ static void create_secure_ram(VirtMachineState *vms,
> >>      g_free(nodename);
> >>  }
> >>  
> >> +static void create_device_memory(VirtMachineState *vms, MemoryRegion *sysmem)
> >> +{
> >> +    MachineState *ms = MACHINE(vms);
> >> +
> >> +    if (!vms->device_memory_size) {  
> > having vms->device_memory_size seems like duplicate, why not to reuse
> > memory_region_size(MachineState::device_memory::mr) like we do elsewhere.  
> OK so you mean allocating the ms->device_memory in virt_setmmap? In that
> case, I wonder if all that code shouldn't land in set_memmap directly?
> > 
> > Also it would be better to all device_memory allocation/initialization
> > compact and close to each other like it's done in pc/spapr.  
> I am not sure I get your point here. alloc & init are done in this
> function. Or do you mean I should rather move that into set_memmap?
I don't have a preference where to put it, could be here or in set_memmap,
what I do care is to keep all device_memory related parts together
(like calculating device_memory base and size and allocating/initializing
structure itself, it's much easier to read when one doesn't have to jump
around code and could see all related code in one place)

> 
> Thanks
> 
> Eric
> >   
> >> +        return;
> >> +    }
> >> +
> >> +    if (ms->ram_slots > ACPI_MAX_RAM_SLOTS) {
> >> +        error_report("unsupported number of memory slots: %"PRIu64,
> >> +                     ms->ram_slots);
> >> +        exit(EXIT_FAILURE);
> >> +    }
> >> +
> >> +    if (QEMU_ALIGN_UP(ms->maxram_size, GiB) != ms->maxram_size) {
> >> +        error_report("maximum memory size must be GiB aligned");
> >> +        exit(EXIT_FAILURE);
> >> +    }
> >> +
> >> +    ms->device_memory = g_malloc0(sizeof(*ms->device_memory));
> >> +    ms->device_memory->base = vms->device_memory_base;
> >> +
> >> +    memory_region_init(&ms->device_memory->mr, OBJECT(vms),
> >> +                       "device-memory", vms->device_memory_size);
> >> +    memory_region_add_subregion(sysmem, ms->device_memory->base,
> >> +                                &ms->device_memory->mr);
> >> +}
> >> +
> >>  static void *machvirt_dtb(const struct arm_boot_info *binfo, int *fdt_size)
> >>  {
> >>      const VirtMachineState *board = container_of(binfo, VirtMachineState,
> >> @@ -1610,6 +1639,10 @@ static void machvirt_init(MachineState *machine)
> >>                                           machine->ram_size);
> >>      memory_region_add_subregion(sysmem, vms->memmap[VIRT_MEM].base, ram);
> >>  
> >> +    if (vms->extended_memmap) {
> >> +        create_device_memory(vms, sysmem);
> >> +    }
> >> +
> >>      create_flash(vms, sysmem, secure_sysmem ? secure_sysmem : sysmem);
> >>  
> >>      create_gic(vms, pic);  
> >   
> 
