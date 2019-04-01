Received: from eggs.gnu.org ([209.51.188.92]:58467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hAwWE-0006en-3N
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 08:58:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hAwWC-0003eI-PF
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 08:58:30 -0400
Date: Mon, 1 Apr 2019 14:58:09 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190401145809.55643fc6@redhat.com>
In-Reply-To: <20190321104745.28068-2-shameerali.kolothum.thodi@huawei.com>
References: <20190321104745.28068-1-shameerali.kolothum.thodi@huawei.com>
	<20190321104745.28068-2-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 01/10] hw/acpi: Make ACPI IO address
 space configurable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, shannon.zhaosl@gmail.com, sameo@linux.intel.com, sebastien.boeuf@intel.com, linuxarm@huawei.com, xuwei5@hisilicon.com

On Thu, 21 Mar 2019 10:47:36 +0000
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:

> This is in preparation for adding support for ARM64 platforms
> where it doesn't use port mapped IO for ACPI IO space.
> 
> Also move the MEMORY_SLOT_SCAN_METHOD/MEMORY_DEVICES_CONTAINER
> definitions to header so that other memory hotplug event
> signalling mechanisms (eg. Generic Event Device on HW-reduced
> acpi platforms) can use the same from their respective event
> handler aml code.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/memory_hotplug.c         | 24 ++++++++++++++----------
>  hw/i386/acpi-build.c             |  3 ++-
>  include/hw/acpi/memory_hotplug.h |  8 ++++++--
>  3 files changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
> index 297812d..80e25f0 100644
> --- a/hw/acpi/memory_hotplug.c
> +++ b/hw/acpi/memory_hotplug.c
> @@ -29,12 +29,10 @@
>  #define MEMORY_SLOT_PROXIMITY_METHOD "MPXM"
>  #define MEMORY_SLOT_EJECT_METHOD     "MEJ0"
>  #define MEMORY_SLOT_NOTIFY_METHOD    "MTFY"
> -#define MEMORY_SLOT_SCAN_METHOD      "MSCN"
>  #define MEMORY_HOTPLUG_DEVICE        "MHPD"
>  #define MEMORY_HOTPLUG_IO_LEN         24
> -#define MEMORY_DEVICES_CONTAINER     "\\_SB.MHPC"
>  
> -static uint16_t memhp_io_base;
> +static hwaddr memhp_io_base;
>  
>  static ACPIOSTInfo *acpi_memory_device_status(int slot, MemStatus *mdev)
>  {
> @@ -209,7 +207,7 @@ static const MemoryRegionOps acpi_memory_hotplug_ops = {
>  };
>  
>  void acpi_memory_hotplug_init(MemoryRegion *as, Object *owner,
> -                              MemHotplugState *state, uint16_t io_base)
> +                              MemHotplugState *state, hwaddr io_base)
>  {
>      MachineState *machine = MACHINE(qdev_get_machine());
>  
> @@ -342,7 +340,8 @@ const VMStateDescription vmstate_memory_hotplug = {
>  
>  void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
>                                const char *res_root,
> -                              const char *event_handler_method)
> +                              const char *event_handler_method,
> +                              AmlRegionSpace rs)
>  {
>      int i;
>      Aml *ifctx;
> @@ -365,14 +364,19 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
>              aml_name_decl("_UID", aml_string("Memory hotplug resources")));
>  
>          crs = aml_resource_template();
> -        aml_append(crs,
> -            aml_io(AML_DECODE16, memhp_io_base, memhp_io_base, 0,
> -                   MEMORY_HOTPLUG_IO_LEN)
> -        );
> +        if (rs == AML_SYSTEM_IO) {
> +            aml_append(crs,
> +                aml_io(AML_DECODE16, memhp_io_base, memhp_io_base, 0,
> +                       MEMORY_HOTPLUG_IO_LEN)
> +            );
> +        } else {
> +            aml_append(crs, aml_memory32_fixed(memhp_io_base,
> +                            MEMORY_HOTPLUG_IO_LEN, AML_READ_WRITE));
> +        }
>          aml_append(mem_ctrl_dev, aml_name_decl("_CRS", crs));
>  
>          aml_append(mem_ctrl_dev, aml_operation_region(
> -            MEMORY_HOTPLUG_IO_REGION, AML_SYSTEM_IO,
> +            MEMORY_HOTPLUG_IO_REGION, rs,
>              aml_int(memhp_io_base), MEMORY_HOTPLUG_IO_LEN)
>          );
>  
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 416da31..6d6de44 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1852,7 +1852,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          build_cpus_aml(dsdt, machine, opts, pm->cpu_hp_io_base,
>                         "\\_SB.PCI0", "\\_GPE._E02");
>      }
> -    build_memory_hotplug_aml(dsdt, nr_mem, "\\_SB.PCI0", "\\_GPE._E03");
> +    build_memory_hotplug_aml(dsdt, nr_mem, "\\_SB.PCI0",
> +                             "\\_GPE._E03", AML_SYSTEM_IO);
>  
>      scope =  aml_scope("_GPE");
>      {
> diff --git a/include/hw/acpi/memory_hotplug.h b/include/hw/acpi/memory_hotplug.h
> index 77c6576..f95aa1f 100644
> --- a/include/hw/acpi/memory_hotplug.h
> +++ b/include/hw/acpi/memory_hotplug.h
> @@ -5,6 +5,9 @@
>  #include "hw/acpi/acpi.h"
>  #include "hw/acpi/aml-build.h"
>  
> +#define MEMORY_SLOT_SCAN_METHOD      "MSCN"
> +#define MEMORY_DEVICES_CONTAINER     "\\_SB.MHPC"
> +
>  /**
>   * MemStatus:
>   * @is_removing: the memory device in slot has been requested to be ejected.
> @@ -29,7 +32,7 @@ typedef struct MemHotplugState {
>  } MemHotplugState;
>  
>  void acpi_memory_hotplug_init(MemoryRegion *as, Object *owner,
> -                              MemHotplugState *state, uint16_t io_base);
> +                              MemHotplugState *state, hwaddr io_base);
>  
>  void acpi_memory_plug_cb(HotplugHandler *hotplug_dev, MemHotplugState *mem_st,
>                           DeviceState *dev, Error **errp);
> @@ -48,5 +51,6 @@ void acpi_memory_ospm_status(MemHotplugState *mem_st, ACPIOSTInfoList ***list);
>  
>  void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
>                                const char *res_root,
> -                              const char *event_handler_method);
> +                              const char *event_handler_method,
> +                              AmlRegionSpace rs);
>  #endif
