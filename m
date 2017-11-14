Received: from eggs.gnu.org ([2001:4830:134:3::10]:41203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1eEcUl-00019G-47
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 09:47:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1eEcUk-0004lO-2s
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 09:47:23 -0500
Date: Tue, 14 Nov 2017 15:47:08 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20171114144708.uzh6mkmjygojfpbu@kamzik.brq.redhat.com>
References: <1510622154-17224-1-git-send-email-zhuyijun@huawei.com>
	<1510622154-17224-3-git-send-email-zhuyijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1510622154-17224-3-git-send-email-zhuyijun@huawei.com>
Subject: Re: [Qemu-devel] [RFC 2/5] hw/arm/virt: Enable dynamic generation
 of guest RAM memory regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhuyijun@huawei.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, zhaoshenglong@huawei.com

On Tue, Nov 14, 2017 at 09:15:51AM +0800, zhuyijun@huawei.com wrote:
> From: Zhu Yijun <zhuyijun@huawei.com>
> 
> Register a ram_memory_region_init notify to allocate memory region
> from system memory and add them as subregions.
> 
> Signed-off-by: Zhu Yijun <zhuyijun@huawei.com>
> ---
>  hw/arm/virt.c         | 21 ++++++++++++++++-----
>  include/hw/arm/virt.h |  1 +
>  2 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 9e18b41..ddde5e1 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1225,6 +1225,19 @@ void virt_machine_done(Notifier *notifier, void *data)
>      virt_build_smbios(vms);
>  }
>  
> +static void virt_ram_memory_region_init(Notifier *notifier, void *data)
> +{
> +    MachineState *machine = MACHINE(qdev_get_machine());

No need to use qdev_get_machine(), you can get it with MACHINE(vms).

> +    MemoryRegion *sysmem = get_system_memory();
> +    MemoryRegion *ram = g_new(MemoryRegion, 1);
> +    VirtMachineState *vms = container_of(notifier, VirtMachineState,
> +                                         ram_memory_region_init);
> +
> +    memory_region_allocate_system_memory(ram, NULL, "mach-virt.ram",
> +                                         machine->ram_size);
> +    memory_region_add_subregion(sysmem, vms->memmap[VIRT_MEM].base, ram);
> +}
> +
>  static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
>  {
>      uint8_t clustersz = ARM_DEFAULT_CPUS_PER_CLUSTER;
> @@ -1258,7 +1271,6 @@ static void machvirt_init(MachineState *machine)
>      MemoryRegion *sysmem = get_system_memory();
>      MemoryRegion *secure_sysmem = NULL;
>      int n, virt_max_cpus;
> -    MemoryRegion *ram = g_new(MemoryRegion, 1);
>      bool firmware_loaded = bios_name || drive_get(IF_PFLASH, 0, 0);
>  
>      /* We can probe only here because during property set
> @@ -1409,10 +1421,6 @@ static void machvirt_init(MachineState *machine)
>      fdt_add_cpu_nodes(vms);
>      fdt_add_psci_node(vms);
>  
> -    memory_region_allocate_system_memory(ram, NULL, "mach-virt.ram",
> -                                         machine->ram_size);
> -    memory_region_add_subregion(sysmem, vms->memmap[VIRT_MEM].base, ram);
> -
>      create_flash(vms, sysmem, secure_sysmem ? secure_sysmem : sysmem);
>  
>      create_gic(vms, pic);
> @@ -1462,6 +1470,9 @@ static void machvirt_init(MachineState *machine)
>       * Notifiers are executed in registration reverse order.
>       */
>      create_platform_bus(vms, pic);
> +
> +    vms->ram_memory_region_init.notify = virt_ram_memory_region_init;
> +    qemu_add_machine_init_done_notifier(&vms->ram_memory_region_init);

Does this notifier need to be the first one executed? If so, then a
comment should be added to state that. Actually the comment above
create_platform_bus() could be replaced with a comment above the first
notifier that states all notifier dependencies.

>  }
>  
>  static bool virt_get_secure(Object *obj, Error **errp)
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 33b0ff3..38906b8 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -90,6 +90,7 @@ typedef struct {
>  typedef struct {
>      MachineState parent;
>      Notifier machine_done;
> +    Notifier ram_memory_region_init;
>      FWCfgState *fw_cfg;
>      bool secure;
>      bool highmem;
> -- 
> 1.8.3.1
> 
> 
>

Thanks,
drew 
