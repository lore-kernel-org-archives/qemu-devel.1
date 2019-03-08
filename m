Received: from eggs.gnu.org ([209.51.188.92]:50472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1h2I8B-0001Ag-14
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:13:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1h2I8A-0003Rs-5u
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:13:55 -0500
References: <20190308114218.26692-1-shameerali.kolothum.thodi@huawei.com>
	<20190308114218.26692-3-shameerali.kolothum.thodi@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <e2e5a025-34bb-7a34-80c7-99d8cef37f2c@redhat.com>
Date: Fri, 8 Mar 2019 17:13:42 +0100
MIME-Version: 1.0
In-Reply-To: <20190308114218.26692-3-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 02/11] hw/acpi: Make ACPI IO address
 space configurable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, imammedo@redhat.com, peter.maydell@linaro.org, shannon.zhaosl@gmail.com, sameo@linux.intel.com, sebastien.boeuf@intel.com
Cc: linuxarm@huawei.com, xuwei5@hisilicon.com

Hi,

On 3/8/19 12:42 PM, Shameer Kolothum wrote:
> This is in preparation for adding support for ARM64 platforms
> where it doesn't use port mapped IO for ACPI IO space.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  hw/acpi/memory_hotplug.c         | 22 ++++++++++++++--------
>  hw/i386/acpi-build.c             |  3 ++-
>  include/hw/acpi/memory_hotplug.h |  5 +++--
>  3 files changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
> index a6beb10..77ff0af 100644
> --- a/hw/acpi/memory_hotplug.c
> +++ b/hw/acpi/memory_hotplug.c
> @@ -8,7 +8,7 @@
>  #include "qapi/error.h"
>  #include "qapi/qapi-events-misc.h"
>  
> -static uint16_t memhp_io_base;
> +static hwaddr memhp_io_base;
>  
>  static ACPIOSTInfo *acpi_memory_device_status(int slot, MemStatus *mdev)
>  {
> @@ -182,7 +182,7 @@ static const MemoryRegionOps acpi_memory_hotplug_ops = {
>  };
>  
>  void acpi_memory_hotplug_init(MemoryRegion *as, Object *owner,
> -                              MemHotplugState *state, uint16_t io_base)
> +                              MemHotplugState *state, hwaddr io_base)
>  {
>      MachineState *machine = MACHINE(qdev_get_machine());
>  
> @@ -315,7 +315,8 @@ const VMStateDescription vmstate_memory_hotplug = {
>  
>  void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
>                                const char *res_root,
> -                              const char *event_handler_method)
> +                              const char *event_handler_method,
> +                              AmlRegionSpace rs)
>  {
>      int i;
>      Aml *ifctx;
> @@ -338,14 +339,19 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
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
> index 622ccb9..d9b554f 100644
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
> index fbfcbe6..52f9027 100644
> --- a/include/hw/acpi/memory_hotplug.h
> +++ b/include/hw/acpi/memory_hotplug.h
> @@ -55,7 +55,7 @@ typedef struct MemHotplugState {
>  } MemHotplugState;
>  
>  void acpi_memory_hotplug_init(MemoryRegion *as, Object *owner,
> -                              MemHotplugState *state, uint16_t io_base);
> +                              MemHotplugState *state, hwaddr io_base);
>  
>  void acpi_memory_plug_cb(HotplugHandler *hotplug_dev, MemHotplugState *mem_st,
>                           DeviceState *dev, Error **errp);
> @@ -74,5 +74,6 @@ void acpi_memory_ospm_status(MemHotplugState *mem_st, ACPIOSTInfoList ***list);
>  
>  void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
>                                const char *res_root,
> -                              const char *event_handler_method);
> +                              const char *event_handler_method,
> +                              AmlRegionSpace rs);
>  #endif
> 
