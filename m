Received: from eggs.gnu.org ([2001:4830:134:3::10]:42663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhuyijun@huawei.com>) id 1eGinS-0003Bq-C2
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 04:55:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhuyijun@huawei.com>) id 1eGinO-00052t-5v
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 04:55:22 -0500
Message-ID: <5A12A65A.5060202@huawei.com>
Date: Mon, 20 Nov 2017 17:54:34 +0800
From: Zhu Yijun <zhuyijun@huawei.com>
MIME-Version: 1.0
References: <1510622154-17224-1-git-send-email-zhuyijun@huawei.com>
	<1510622154-17224-4-git-send-email-zhuyijun@huawei.com>
	<20171114145002.jbrw7k4n2m2rfwes@kamzik.brq.redhat.com>
In-Reply-To: <20171114145002.jbrw7k4n2m2rfwes@kamzik.brq.redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 3/5] hw/arm: add scattered RAM memory region
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, zhaoshenglong@huawei.com

On 2017/11/14 22:50, Andrew Jones wrote:
> On Tue, Nov 14, 2017 at 09:15:52AM +0800, zhuyijun@huawei.com wrote:
>> From: Zhu Yijun <zhuyijun@huawei.com>
>>
>> Dig out reserved memory holes and collect scattered RAM memory
>> regions by adding mem_list member in arm_boot_info struct.
>>
>> Signed-off-by: Zhu Yijun <zhuyijun@huawei.com>
>> ---
>>  hw/arm/boot.c        |   8 ++++
>>  hw/arm/virt.c        | 101 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>>  include/hw/arm/arm.h |   1 +
>>  3 files changed, 108 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
>> index c2720c8..30438f4 100644
>> --- a/hw/arm/boot.c
>> +++ b/hw/arm/boot.c
>> @@ -836,6 +836,14 @@ static void arm_load_kernel_notify(Notifier *notifier, void *data)
>>       */
>>      assert(!(info->secure_board_setup && kvm_enabled()));
>>  
>> +    /* If machine is not virt, the mem_list will empty. */
>> +    if (QLIST_EMPTY(&vms->bootinfo.mem_list)) {
>> +        RAMRegion *new = g_new(RAMRegion, 1);
>> +        new->base = info->loader_start;
>> +        new->size = info->ram_size;
>> +        QLIST_INSERT_HEAD(&vms->bootinfo.mem_list, new, next);
>> +    }
>> +
>>      info->dtb_filename = qemu_opt_get(qemu_get_machine_opts(), "dtb");
>>  
>>      /* Load the kernel.  */
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index ddde5e1..ff334c1 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -56,6 +56,7 @@
>>  #include "hw/smbios/smbios.h"
>>  #include "qapi/visitor.h"
>>  #include "standard-headers/linux/input.h"
>> +#include "hw/vfio/vfio-common.h"
>>  
>>  #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
>>      static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
>> @@ -1225,6 +1226,98 @@ void virt_machine_done(Notifier *notifier, void *data)
>>      virt_build_smbios(vms);
>>  }
>>  
>> +static void handle_reserved_ram_region_overlap(void)
>> +{
>> +    hwaddr cur_end, next_end;
>> +    RAMRegion *reg, *next_reg, *tmp_reg;
>> +
>> +    QLIST_FOREACH(reg, &reserved_ram_regions, next) {
>> +        next_reg = QLIST_NEXT(reg, next);
>> +
>> +        while (next_reg && next_reg->base <= (reg->base + reg->size)) {
>> +            next_end = next_reg->base + next_reg->size;
>> +            cur_end = reg->base + reg->size;
>> +            if (next_end > cur_end) {
>> +                reg->size += (next_end - cur_end);
>> +            }
>> +
>> +            tmp_reg = QLIST_NEXT(next_reg, next);
>> +            QLIST_REMOVE(next_reg, next);
>> +            g_free(next_reg);
>> +            next_reg = tmp_reg;
>> +        }
>> +    }
>> +}
> Why isn't the above integrated into the reserved ram region insertion?

We can do it once all the reserved regions are captured and then update the list once for any overlaps.

>> +
>> +static void update_memory_regions(VirtMachineState *vms, hwaddr ram_size)
>> +{
>> +
>> +    RAMRegion *new, *reg, *last = NULL;
>> +    hwaddr virt_start, virt_end;
> Either need a blank line here, or to initialize virt_start/end on the
> declaration lines.

OK

>> +    virt_start = vms->memmap[VIRT_MEM].base;
>> +    virt_end = virt_start + ram_size - 1;
>> +
>> +    handle_reserved_ram_region_overlap();
>> +
>> +    QLIST_FOREACH(reg, &reserved_ram_regions, next) {
>> +        if (reg->base >= virt_start && reg->base < virt_end) {
> What about the case where reg->base + reg->size > virt_start?

I will add the case next version.

>> +            if (reg->base == virt_start) {
>> +                virt_start += reg->size;
> We can't move virt_start without breaking AAVMF.

But it may exist reserved memory region which begins at 0x40000000 in theory.
>
>> +                virt_end += reg->size;
> We can't increase virt_end without checking it against RAMLIMIT.
>
>> +                continue;
>> +            } else {
>> +                new = g_new(RAMRegion, 1);
>> +                new->base = virt_start;
>> +                new->size = reg->base - virt_start;
>> +                virt_start = reg->base + reg->size;
>> +            }
>> +
>> +            if (QLIST_EMPTY(&vms->bootinfo.mem_list)) {
>> +                QLIST_INSERT_HEAD(&vms->bootinfo.mem_list, new, next);
>> +            } else {
>> +                QLIST_INSERT_AFTER(last, new, next);
>> +            }
>> +
>> +            last = new;
>> +            ram_size -= new->size;
>> +            virt_end += reg->size;
>> +        }
>> +    }
>> +
>> +    if (ram_size > 0) {
>> +        new = g_new(RAMRegion, 1);
>> +        new->base = virt_start;
>> +        new->size = ram_size;
>> +
>> +        if (QLIST_EMPTY(&vms->bootinfo.mem_list)) {
>> +            QLIST_INSERT_HEAD(&vms->bootinfo.mem_list, new, next);
>> +        } else {
>> +            QLIST_INSERT_AFTER(last, new, next);
>> +        }
>> +    }
> Where's the else? ram_size <= 0 is not likely something we should ignore.

ok, will add it.

>> +}
>> +
>> +static void create_ram_alias(VirtMachineState *vms,
>> +                             MemoryRegion *sysmem,
>> +                             MemoryRegion *ram)
>> +{
>> +    RAMRegion *reg;
>> +    MemoryRegion *ram_memory;
>> +    char *nodename;
>> +    hwaddr sz = 0;
>> +
>> +    QLIST_FOREACH(reg, &vms->bootinfo.mem_list, next) {
>> +        nodename = g_strdup_printf("ram@%" PRIx64, reg->base);
>> +        ram_memory = g_new(MemoryRegion, 1);
>> +        memory_region_init_alias(ram_memory, NULL, nodename, ram, sz,
>> +                                 reg->size);
>> +        memory_region_add_subregion(sysmem, reg->base, ram_memory);
>> +        sz += reg->size;
>> +
>> +        g_free(nodename);
>> +    }
>> +}
> Instead of using memory region aliases, it would be best if each RAM
> region was modeled with pc-dimms, as that would move us towards supporting
> memory hotplug and allow the regions to be explicitly identified
> (start/size) on the command line - supporting migration. Actually, how
> does this series address migration? What if the host we migrate to doesn't
> have the same reserved regions in sysfs?

I  did not consider memory hotplug and migration before, thinks for pointing it out to me.

>> +
>>  static void virt_ram_memory_region_init(Notifier *notifier, void *data)
>>  {
>>      MachineState *machine = MACHINE(qdev_get_machine());
>> @@ -1232,10 +1325,15 @@ static void virt_ram_memory_region_init(Notifier *notifier, void *data)
>>      MemoryRegion *ram = g_new(MemoryRegion, 1);
>>      VirtMachineState *vms = container_of(notifier, VirtMachineState,
>>                                           ram_memory_region_init);
>> +    RAMRegion *first_mem_reg;
>>  
>>      memory_region_allocate_system_memory(ram, NULL, "mach-virt.ram",
>>                                           machine->ram_size);
>> -    memory_region_add_subregion(sysmem, vms->memmap[VIRT_MEM].base, ram);
>> +    update_memory_regions(vms, machine->ram_size);
>> +    create_ram_alias(vms, sysmem, ram);
>> +
>> +    first_mem_reg = QLIST_FIRST(&vms->bootinfo.mem_list);
>> +    vms->bootinfo.loader_start = first_mem_reg->base;
>>  }
>>  
>>  static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
>> @@ -1458,7 +1556,6 @@ static void machvirt_init(MachineState *machine)
>>      vms->bootinfo.initrd_filename = machine->initrd_filename;
>>      vms->bootinfo.nb_cpus = smp_cpus;
>>      vms->bootinfo.board_id = -1;
>> -    vms->bootinfo.loader_start = vms->memmap[VIRT_MEM].base;
>>      vms->bootinfo.get_dtb = machvirt_dtb;
>>      vms->bootinfo.firmware_loaded = firmware_loaded;
>>      arm_load_kernel(ARM_CPU(first_cpu), &vms->bootinfo);
>> diff --git a/include/hw/arm/arm.h b/include/hw/arm/arm.h
>> index ce769bd..d953026 100644
>> --- a/include/hw/arm/arm.h
>> +++ b/include/hw/arm/arm.h
>> @@ -124,6 +124,7 @@ struct arm_boot_info {
>>      bool secure_board_setup;
>>  
>>      arm_endianness endianness;
>> +    QLIST_HEAD(, RAMRegion) mem_list;
>>  };
>>  
>>  /**
>> -- 
>> 1.8.3.1
>>
>>
>>
> Thanks,
> drew
>
> .
>
