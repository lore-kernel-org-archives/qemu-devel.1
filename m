Received: from eggs.gnu.org ([2001:4830:134:3::10]:45181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fNJ1s-0007sd-2d
	for qemu-devel@nongnu.org; Mon, 28 May 2018 10:21:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fNJ1q-0006Kf-84
	for qemu-devel@nongnu.org; Mon, 28 May 2018 10:21:44 -0400
References: <20180516152026.2920-1-shameerali.kolothum.thodi@huawei.com>
	<20180516152026.2920-7-shameerali.kolothum.thodi@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <bd67ed40-81d6-58dc-ccaf-efd8a40ca96f@redhat.com>
Date: Mon, 28 May 2018 16:21:33 +0200
MIME-Version: 1.0
In-Reply-To: <20180516152026.2920-7-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 6/6] hw/arm: Populate non-contiguous
 memory regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: drjones@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org, alex.williamson@redhat.com, zhaoshenglong@huawei.com, jonathan.cameron@huawei.com, linuxarm@huawei.com

Hi Shameer,

On 05/16/2018 05:20 PM, Shameer Kolothum wrote:
> In case valid iova regions are non-contiguous, split the
> RAM mem into a 1GB non-pluggable dimm and remaining as a
> single pc-dimm mem.

Please can you explain where does this split come from? Currently we
have 254 GB non pluggable RAM. I read the discussion started with Drew
on RFC v1 where he explained we cannot change the RAM base without
crashing the FW. However we should at least document this  1GB split.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/virt.c | 261 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 256 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index be3ad14..562e389 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -58,6 +58,12 @@
>  #include "hw/smbios/smbios.h"
>  #include "qapi/visitor.h"
>  #include "standard-headers/linux/input.h"
> +#include "hw/vfio/vfio-common.h"
> +#include "qemu/config-file.h"
> +#include "monitor/qdev.h"
> +#include "qom/object_interfaces.h"
> +#include "qapi/qmp/qdict.h"
> +#include "qemu/option.h"

The comment at the beginning of virt.c would need to be reworked with
your changes.
>  
>  #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
>      static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
> @@ -110,7 +116,10 @@ static ARMPlatformBusSystemParams platform_bus_params;
>   * terabyte of physical address space.)
>   */
>  #define RAMLIMIT_GB 255
> -#define RAMLIMIT_BYTES (RAMLIMIT_GB * 1024ULL * 1024 * 1024)
> +#define SZ_1G (1024ULL * 1024 * 1024)
> +#define RAMLIMIT_BYTES (RAMLIMIT_GB * SZ_1G)
> +
> +#define ALIGN_1G (1ULL << 30)
>  
>  /* Addresses and sizes of our components.
>   * 0..128MB is space for a flash device so we can run bootrom code such as UEFI.
> @@ -1171,6 +1180,236 @@ void virt_machine_done(Notifier *notifier, void *data)
>      virt_build_smbios(vms);
>  }
>  
> +static void free_iova_copy(struct vfio_iova_head *iova_copy)
> +{
> +    VFIOIovaRange *iova, *tmp;
> +
> +    QLIST_FOREACH_SAFE(iova, iova_copy, next, tmp) {
> +        QLIST_REMOVE(iova, next);
> +        g_free(iova);
> +    }
> +}
> +
> +static void get_iova_copy(struct vfio_iova_head *iova_copy)
> +{
> +    VFIOIovaRange *iova, *new, *prev_iova = NULL;
> +
> +    QLIST_FOREACH(iova, &vfio_iova_regions, next) {
> +        new = g_malloc0(sizeof(*iova));
> +        new->start = iova->start;
> +        new->end = iova->end;
> +
> +        if (prev_iova) {
> +            QLIST_INSERT_AFTER(prev_iova, new, next);
> +        } else {
> +            QLIST_INSERT_HEAD(iova_copy, new, next);
> +        }
> +        prev_iova = new;
> +    }
> +}
> +
> +static hwaddr find_memory_chunk(VirtMachineState *vms,
> +                   struct vfio_iova_head *iova_copy,
> +                   hwaddr req_size, bool pcdimm)
> +{
> +    VFIOIovaRange *iova, *tmp;
> +    hwaddr new_start, new_size, sz_align;
> +    hwaddr virt_start = vms->memmap[VIRT_MEM].base;
> +    hwaddr addr_align = ALIGN_1G; /* Set to max ARM64 hugepage size */
> +
> +    /* Size alignment */
> +    sz_align = (pcdimm) ? MAX(TARGET_PAGE_SIZE, QEMU_VMALLOC_ALIGN) :
> +                                                      TARGET_PAGE_SIZE;
> +
> +    QLIST_FOREACH_SAFE(iova, iova_copy, next, tmp) {
> +        if (virt_start >= iova->end) {
> +            continue;
> +        }
> +
> +        /* Align addr */
> +        new_start = ROUND_UP(MAX(virt_start, iova->start), addr_align);
> +        if (new_start >= iova->end) {
> +            continue;
> +        }
> +
> +        if (req_size > iova->end - new_start + 1) {
> +            continue;
> +        }
don't you want to check directly with new_size?
> +
> +        /*
> +         * Check the region can hold any size alignment requirement.
> +         */
> +        new_size = QEMU_ALIGN_UP(req_size, sz_align);
> +
> +        if ((new_start + new_size - 1 > iova->end) ||
> +                 (new_start + new_size >= virt_start + RAMLIMIT_BYTES)) {
> +            continue;
> +        }
> +
> +        /*
> +         * Modify the iova list entry for non pc-dimm case so that it
> +         * is not used again for pc-dimm allocation.
> +         */
> +        if (!pcdimm) {
> +            if (new_size - req_size) {
I don't get this check, Don't you want to check the node's range is
fully consumed and in the positive remove the node?

(new_size != iova->end - iova-> start + 1)
> +                iova->start = new_start + new_size;
> +            } else {
> +                QLIST_REMOVE(iova, next);
> +            }
> +        }
> +        return new_start;
> +    }
> +
> +    return -1;
> +}
> +
> +static void update_memory_regions(VirtMachineState *vms)
> +{
> +    hwaddr addr;
> +    VFIOIovaRange *iova;
> +    MachineState *machine = MACHINE(vms);
> +    hwaddr virt_start = vms->memmap[VIRT_MEM].base;
> +    hwaddr req_size, ram_size = machine->ram_size;
> +    struct vfio_iova_head iova_copy = QLIST_HEAD_INITIALIZER(iova_copy);
> +
> +    /* No valid iova regions, use default */
> +    if (QLIST_EMPTY(&vfio_iova_regions)) {
> +        vms->bootinfo.loader_start = vms->memmap[VIRT_MEM].base;
> +        vms->bootinfo.ram_size = ram_size;
> +        return;
> +    }
> +
> +    /*
> +     * If valid iovas has only one entry, check the req size fits in
> +     * and can have the loader start < 4GB. This will make sure platforms
> +     * with no holes in mem will have the same mem model as before.
> +     */
> +    req_size = ram_size;
> +    iova = QLIST_NEXT(QLIST_FIRST(&vfio_iova_regions), next);
> +    if (!iova) {
> +        iova = QLIST_FIRST(&vfio_iova_regions);
> +        addr = ROUND_UP(MAX(virt_start, iova->start), ALIGN_1G);
> +        if ((addr < 4 * SZ_1G) && (ram_size <= iova->end - addr + 1) &&
> +                  (addr + ram_size < virt_start + RAMLIMIT_BYTES)) {
> +            vms->bootinfo.loader_start = addr;
> +            vms->bootinfo.ram_size = ram_size;
> +            return;
> +        }
> +    }
> +
> +    /* Get a copy of valid iovas and work on it */
> +    get_iova_copy(&iova_copy);
> +
> +    /* Split the mem as first 1GB non-pluggable and rest as pc-dimm */
> +    req_size = MIN(ram_size, SZ_1G);
> +    addr = find_memory_chunk(vms, &iova_copy, req_size, false);
According to what Drew reported, the base address of the cold-plug RAM
must stay at 1GB otherwise the FW will be lost. So I think you must
check the addr = 1GB
> +    if (addr == -1 || addr >= 4 * SZ_1G) {
> +        goto out;
> +    }
> +
> +    /*Update non-pluggable mem details */
> +    machine->ram_size = req_size;
> +    vms->bootinfo.loader_start = addr;
> +    vms->bootinfo.ram_size = machine->ram_size;
> +
> +    req_size = ram_size - req_size;
> +    if (!req_size) {
> +        goto done;
> +    }
> +
> +    /* Remaining memory is modeled as a pc-dimm. */
> +    addr = find_memory_chunk(vms, &iova_copy, req_size, true);
> +    if (addr == -1) {
> +        goto out;
> +    }
> +
> +    /*Update pc-dimm mem details */
> +    vms->bootinfo.dimm_mem = g_new(struct dimm_mem_info, 1);
> +    vms->bootinfo.dimm_mem->base = addr;
> +    vms->bootinfo.dimm_mem->size = req_size;
> +    machine->maxram_size = machine->ram_size + req_size;
> +    machine->ram_slots += 1;
> +
> +done:
> +    free_iova_copy(&iova_copy);
> +    return;
> +
> +out:
> +    free_iova_copy(&iova_copy);
> +    error_report("mach-virt: Not enough contiguous memory to model ram");
Output the requested size would help debug (and maybe the available IOVA
ranges)

Thanks

Eric
> +    exit(1);
> +}
> +
> +static void create_pcdimms(VirtMachineState *vms,
> +                             MemoryRegion *sysmem,
> +                             MemoryRegion *ram)
> +{
> +    hwaddr addr, size;
> +    Error *local_err = NULL;
> +    QDict *qdict;
> +    QemuOpts *opts;
> +    char *tmp;
> +
> +    if (!vms->bootinfo.dimm_mem) {
> +        return;
> +    }
> +
> +    addr = vms->bootinfo.dimm_mem->base;
> +    size = vms->bootinfo.dimm_mem->size;
> +
> +    /*Create hotplug address space */
> +    vms->hotplug_memory.base = ROUND_UP(addr, ALIGN_1G);
> +    size = ROUND_UP(size, MAX(TARGET_PAGE_SIZE, QEMU_VMALLOC_ALIGN));
> +
> +    memory_region_init(&vms->hotplug_memory.mr, OBJECT(vms),
> +                                      "hotplug-memory", size);
> +    memory_region_add_subregion(sysmem, vms->hotplug_memory.base,
> +                                        &vms->hotplug_memory.mr);
> +    /* Create backend mem object */
> +    qdict = qdict_new();
> +    qdict_put_str(qdict, "qom-type", "memory-backend-ram");
> +    qdict_put_str(qdict, "id", "mem1");
> +    tmp = g_strdup_printf("%"PRIu64 "M", size / (1024 * 1024));
> +    qdict_put_str(qdict, "size", tmp);
> +    g_free(tmp);
> +
> +    opts = qemu_opts_from_qdict(qemu_find_opts("object"), qdict, &local_err);
> +    if (local_err) {
> +        goto err;
> +    }
> +
> +    user_creatable_add_opts(opts, &local_err);
> +    qemu_opts_del(opts);
> +    QDECREF(qdict);
> +    if (local_err) {
> +        goto err;
> +    }
> +
> +    /* Create pc-dimm dev*/
> +    qdict = qdict_new();
> +    qdict_put_str(qdict, "driver", "pc-dimm");
> +    qdict_put_str(qdict, "id", "dimm1");
> +    qdict_put_str(qdict, "memdev", "mem1");
> +
> +    opts = qemu_opts_from_qdict(qemu_find_opts("device"), qdict, &local_err);
> +    if (local_err) {
> +        goto err;
> +    }
> +
> +    qdev_device_add(opts, &local_err);
> +    qemu_opts_del(opts);
> +    QDECREF(qdict);
> +    if (local_err) {
> +        goto err;
> +    }
> +
> +    return;
> +
> +err:
> +    error_report_err(local_err);
> +    exit(1);
> +}
> +
>  static void virt_ram_memory_region_init(Notifier *notifier, void *data)
>  {
>      MemoryRegion *sysmem = get_system_memory();
> @@ -1179,9 +1418,14 @@ static void virt_ram_memory_region_init(Notifier *notifier, void *data)
>                                           ram_memory_region_init);
>      MachineState *machine = MACHINE(vms);
>  
> +    update_memory_regions(vms);
>      memory_region_allocate_system_memory(ram, NULL, "mach-virt.ram",
>                                           machine->ram_size);
> -    memory_region_add_subregion(sysmem, vms->memmap[VIRT_MEM].base, ram);
> +    memory_region_add_subregion(sysmem, vms->bootinfo.loader_start, ram);
> +
> +    if (vms->bootinfo.dimm_mem) {
> +        create_pcdimms(vms, sysmem, ram);
> +    }
>  }
>  
>  static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
> @@ -1404,13 +1648,11 @@ static void machvirt_init(MachineState *machine)
>      vms->machine_done.notify = virt_machine_done;
>      qemu_add_machine_init_done_notifier(&vms->machine_done);
>  
> -    vms->bootinfo.ram_size = machine->ram_size;
>      vms->bootinfo.kernel_filename = machine->kernel_filename;
>      vms->bootinfo.kernel_cmdline = machine->kernel_cmdline;
>      vms->bootinfo.initrd_filename = machine->initrd_filename;
>      vms->bootinfo.nb_cpus = smp_cpus;
>      vms->bootinfo.board_id = -1;
> -    vms->bootinfo.loader_start = vms->memmap[VIRT_MEM].base;
>      vms->bootinfo.get_dtb = machvirt_dtb;
>      vms->bootinfo.firmware_loaded = firmware_loaded;
>  
> @@ -1559,7 +1801,7 @@ static void virt_dimm_plug(HotplugHandler *hotplug_dev,
>      PCDIMMDevice *dimm = PC_DIMM(dev);
>      PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
>      MemoryRegion *mr;
> -    uint64_t align;
> +    uint64_t align, addr;
>      Error *local_err = NULL;
>  
>      mr = ddc->get_memory_region(dimm, &local_err);
> @@ -1573,6 +1815,15 @@ static void virt_dimm_plug(HotplugHandler *hotplug_dev,
>          goto out;
>      }
>  
> +    addr = object_property_get_uint(OBJECT(dimm), PC_DIMM_ADDR_PROP,
> +                                                       &error_fatal);
> +    /* Assign the node for pc-dimm initial ram */
> +    if (vms->bootinfo.dimm_mem && (addr == vms->bootinfo.dimm_mem->base)
> +                                                 && (nb_numa_nodes > 0)) {
> +        vms->bootinfo.dimm_mem->node = object_property_get_uint(OBJECT(dev),
> +                                           PC_DIMM_NODE_PROP, &error_fatal);
> +    }
> +
>  out:
>      error_propagate(errp, local_err);
>  }
> 
