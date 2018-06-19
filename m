Received: from eggs.gnu.org ([2001:4830:134:3::10]:45363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fVJ2q-0002eY-To
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:59:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fVJ2m-0006Y7-1v
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:59:48 -0400
Date: Tue, 19 Jun 2018 17:59:40 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180619175940.00ae5e70@redhat.com>
In-Reply-To: <20180618144800.555-3-david@redhat.com>
References: <20180618144800.555-1-david@redhat.com>
	<20180618144800.555-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 2/4] machine: factor out
 enforce_aligned_dimm into memory_device_align
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S
	. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On Mon, 18 Jun 2018 16:47:58 +0200
David Hildenbrand <david@redhat.com> wrote:

> We want to handle memory device address assignment without passing
> compatibility parameters ("*align").
> 
> As x86 and Power use different strategies to determine an alignment and
> we need clean support for compat handling, let's introduce an enum on
> the machine class level. This is the machine configuration on how to
> align memory devices in guest physical memory.
> 
> The three introduced types represent what is being done on x86 and Power
> right now.

commit message doesn't deliver purpose of the path,
So I'm no conviced it's necessary.
we probably discussed it in previous revisions but could you reiterate
it here WHY do you need this and 3/4

 

> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/core/machine.c    |  3 +++
>  hw/i386/pc.c         | 13 +++++++------
>  hw/i386/pc_piix.c    |  2 +-
>  include/hw/boards.h  | 13 +++++++++++++
>  include/hw/i386/pc.h |  3 ---
>  5 files changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 617e5f8d75..d34b205125 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -531,6 +531,9 @@ static void machine_class_init(ObjectClass *oc, void *data)
>      mc->numa_mem_align_shift = 23;
>      mc->numa_auto_assign_ram = numa_default_auto_assign_ram;
>  
> +    /* Default: use memory region alignment as memory devices alignment */
> +    mc->memory_device_align = MEMORY_DEVICE_ALIGN_REGION;
> +
>      object_class_property_add_str(oc, "accel",
>          machine_get_accel, machine_set_accel, &error_abort);
>      object_class_property_set_description(oc, "accel",
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index bf986baf91..04a97e89e7 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1331,6 +1331,7 @@ void pc_memory_init(PCMachineState *pcms,
>      FWCfgState *fw_cfg;
>      MachineState *machine = MACHINE(pcms);
>      PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
> +    MachineClass *mc = MACHINE_GET_CLASS(machine);
>  
>      assert(machine->ram_size == pcms->below_4g_mem_size +
>                                  pcms->above_4g_mem_size);
> @@ -1363,8 +1364,6 @@ void pc_memory_init(PCMachineState *pcms,
>      if (!pcmc->has_reserved_memory &&
>          (machine->ram_slots ||
>           (machine->maxram_size > machine->ram_size))) {
> -        MachineClass *mc = MACHINE_GET_CLASS(machine);
> -
>          error_report("\"-memory 'slots|maxmem'\" is not supported by: %s",
>                       mc->name);
>          exit(EXIT_FAILURE);
> @@ -1394,7 +1393,7 @@ void pc_memory_init(PCMachineState *pcms,
>          machine->device_memory->base =
>              ROUND_UP(0x100000000ULL + pcms->above_4g_mem_size, 1ULL << 30);
>  
> -        if (pcmc->enforce_aligned_dimm) {
> +        if (mc->memory_device_align != MEMORY_DEVICE_ALIGN_PAGE) {
>              /* size device region assuming 1G page max alignment per slot */
>              device_mem_size += (1ULL << 30) * machine->ram_slots;
>          }
> @@ -1705,14 +1704,16 @@ static void pc_memory_plug(HotplugHandler *hotplug_dev,
>      HotplugHandlerClass *hhc;
>      Error *local_err = NULL;
>      PCMachineState *pcms = PC_MACHINE(hotplug_dev);
> -    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
> +    MachineClass *mc = MACHINE_GET_CLASS(hotplug_dev);
>      PCDIMMDevice *dimm = PC_DIMM(dev);
>      PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
>      MemoryRegion *mr = ddc->get_memory_region(dimm, &error_abort);
>      uint64_t align = TARGET_PAGE_SIZE;
>      bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
>  
> -    if (memory_region_get_alignment(mr) && pcmc->enforce_aligned_dimm) {
> +
> +    if (memory_region_get_alignment(mr) &&
> +        mc->memory_device_align != MEMORY_DEVICE_ALIGN_PAGE) {
>          align = memory_region_get_alignment(mr);
>      }
>  
> @@ -2374,7 +2375,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
>      pcmc->gigabyte_align = true;
>      pcmc->has_reserved_memory = true;
>      pcmc->kvmclock_enabled = true;
> -    pcmc->enforce_aligned_dimm = true;
>      /* BIOS ACPI tables: 128K. Other BIOS datastructures: less than 4K reported
>       * to be used at the moment, 32K should be enough for a while.  */
>      pcmc->acpi_data_size = 0x20000 + 0x8000;
> @@ -2398,6 +2398,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
>      hc->unplug = pc_machine_device_unplug_cb;
>      nc->nmi_monitor_handler = x86_nmi;
>      mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
> +    mc->memory_device_align = MEMORY_DEVICE_ALIGN_REGION_OR_PAGE;
>  
>      object_class_property_add(oc, PC_MACHINE_DEVMEM_REGION_SIZE, "int",
>          pc_machine_get_device_memory_region_size, NULL,
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 3b87f3cedb..cc11856c24 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -566,7 +566,7 @@ static void pc_i440fx_2_1_machine_options(MachineClass *m)
>      m->default_display = NULL;
>      SET_MACHINE_COMPAT(m, PC_COMPAT_2_1);
>      pcmc->smbios_uuid_encoded = false;
> -    pcmc->enforce_aligned_dimm = false;
> +    m->memory_device_align = MEMORY_DEVICE_ALIGN_PAGE;
>  }
>  
>  DEFINE_I440FX_MACHINE(v2_1, "pc-i440fx-2.1", pc_compat_2_1,
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index ef7457f5dd..3f151207c1 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -105,6 +105,15 @@ typedef struct {
>      CPUArchId cpus[0];
>  } CPUArchIdList;
>  
> +typedef enum MemoryDeviceAlign {
> +    /* use specified memory region alignment */
> +    MEMORY_DEVICE_ALIGN_REGION = 0,
> +    /* use target page size as alignment */
> +    MEMORY_DEVICE_ALIGN_PAGE,
> +    /* use target page size if no memory region alignment has been specified */
> +    MEMORY_DEVICE_ALIGN_REGION_OR_PAGE,
> +} MemoryDeviceAlign;
> +
>  /**
>   * MachineClass:
>   * @max_cpus: maximum number of CPUs supported. Default: 1
> @@ -156,6 +165,9 @@ typedef struct {
>   *    should instead use "unimplemented-device" for all memory ranges where
>   *    the guest will attempt to probe for a device that QEMU doesn't
>   *    implement and a stub device is required.
> + * @memory_device_align: The alignment that will be used as default when
> + *    searching for a guest physical memory address while plugging a
> + *    memory device. This is relevant for compatibility handling.
>   */
>  struct MachineClass {
>      /*< private >*/
> @@ -202,6 +214,7 @@ struct MachineClass {
>      const char **valid_cpu_types;
>      strList *allowed_dynamic_sysbus_devices;
>      bool auto_enable_numa_with_memhp;
> +    MemoryDeviceAlign memory_device_align;
>      void (*numa_auto_assign_ram)(MachineClass *mc, NodeInfo *nodes,
>                                   int nb_nodes, ram_addr_t size);
>  
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index fc8dedca12..ffb4654fc8 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -86,8 +86,6 @@ struct PCMachineState {
>   *
>   * Compat fields:
>   *
> - * @enforce_aligned_dimm: check that DIMM's address/size is aligned by
> - *                        backend's alignment value if provided
>   * @acpi_data_size: Size of the chunk of memory at the top of RAM
>   *                  for the BIOS ACPI tables and other BIOS
>   *                  datastructures.
> @@ -124,7 +122,6 @@ struct PCMachineClass {
>      /* RAM / address space compat: */
>      bool gigabyte_align;
>      bool has_reserved_memory;
> -    bool enforce_aligned_dimm;
>      bool broken_reserved_end;
>  
>      /* TSC rate migration: */
