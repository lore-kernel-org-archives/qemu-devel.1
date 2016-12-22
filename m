Received: from eggs.gnu.org ([2001:4830:134:3::10]:37930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cK12G-0004cP-LM
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 05:55:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cK12D-0001G8-Eb
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 05:55:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1cK12D-0001FU-5n
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 05:55:41 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3985C3DEEB
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 10:55:40 +0000 (UTC)
References: <1480980749-182204-1-git-send-email-imammedo@redhat.com>
	<1480980749-182204-10-git-send-email-imammedo@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <72ca867b-65b1-e636-5026-72aacb84f979@redhat.com>
Date: Thu, 22 Dec 2016 12:55:37 +0200
MIME-Version: 1.0
In-Reply-To: <1480980749-182204-10-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9 09/10] memhp: don't generate memory
 hotplug AML if it's not enabled/supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 12/06/2016 01:32 AM, Igor Mammedov wrote:
> That reduces DSDT by 910 bytes when memory hotplug
> isn't enabled.
>
> While doing so drop intermediate variables/arguments
> passing around ACPI_MEMORY_HOTPLUG_IO_LEN and making
> it local to memory_hotplug.c, hardcoding it there as
> it can't change.
>
> Also don't pass around ACPI_MEMORY_HOTPLUG_BASE through
> intermediate variables/arguments where it's not needed.
> Instead initialize in module static variable when MMIO
> region is mapped and use that within memory_hotplug.c
> whenever it's required.
> That way MMIO base specified only at one place and AML
> with MMIO would always use the same value.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  include/hw/acpi/memory_hotplug.h |  3 +--
>  include/hw/acpi/pc-hotplug.h     |  1 -
>  hw/acpi/ich9.c                   |  3 ++-
>  hw/acpi/memory_hotplug.c         | 24 +++++++++++++++++-------
>  hw/acpi/piix4.c                  |  3 ++-
>  hw/i386/acpi-build.c             |  9 +--------
>  6 files changed, 23 insertions(+), 20 deletions(-)
>
> diff --git a/include/hw/acpi/memory_hotplug.h b/include/hw/acpi/memory_hotplug.h
> index 91d4045..db8ebc9 100644
> --- a/include/hw/acpi/memory_hotplug.h
> +++ b/include/hw/acpi/memory_hotplug.h
> @@ -30,7 +30,7 @@ typedef struct MemHotplugState {
>  } MemHotplugState;
>
>  void acpi_memory_hotplug_init(MemoryRegion *as, Object *owner,
> -                              MemHotplugState *state);
> +                              MemHotplugState *state, uint16_t io_base);
>
>  void acpi_memory_plug_cb(HotplugHandler *hotplug_dev, MemHotplugState *mem_st,
>                           DeviceState *dev, Error **errp);
> @@ -48,7 +48,6 @@ extern const VMStateDescription vmstate_memory_hotplug;
>  void acpi_memory_ospm_status(MemHotplugState *mem_st, ACPIOSTInfoList ***list);
>
>  void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
> -                              uint16_t io_base, uint16_t io_len,
>                                const char *res_root,
>                                const char *event_handler_method);
>  #endif
> diff --git a/include/hw/acpi/pc-hotplug.h b/include/hw/acpi/pc-hotplug.h
> index a4f513d..31bc919 100644
> --- a/include/hw/acpi/pc-hotplug.h
> +++ b/include/hw/acpi/pc-hotplug.h
> @@ -29,7 +29,6 @@
>  #define PIIX4_CPU_HOTPLUG_IO_BASE 0xaf00
>  #define CPU_HOTPLUG_RESOURCE_DEVICE PRES
>
> -#define ACPI_MEMORY_HOTPLUG_IO_LEN 24
>  #define ACPI_MEMORY_HOTPLUG_BASE 0x0a00
>
>  #endif
> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> index 830c475..5c279bb 100644
> --- a/hw/acpi/ich9.c
> +++ b/hw/acpi/ich9.c
> @@ -306,7 +306,8 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm,
>
>      if (pm->acpi_memory_hotplug.is_enabled) {
>          acpi_memory_hotplug_init(pci_address_space_io(lpc_pci), OBJECT(lpc_pci),
> -                                 &pm->acpi_memory_hotplug);
> +                                 &pm->acpi_memory_hotplug,
> +                                 ACPI_MEMORY_HOTPLUG_BASE);
>      }
>  }
>
> diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
> index da29332..fb04d24 100644
> --- a/hw/acpi/memory_hotplug.c
> +++ b/hw/acpi/memory_hotplug.c
> @@ -30,6 +30,9 @@
>  #define MEMORY_SLOT_NOTIFY_METHOD    "MTFY"
>  #define MEMORY_SLOT_SCAN_METHOD      "MSCN"
>  #define MEMORY_HOTPLUG_DEVICE        "MHPD"
> +#define MEMORY_HOTPLUG_IO_LEN         24
> +
> +static uint16_t memhp_io_base;
>
>  static ACPIOSTInfo *acpi_memory_device_status(int slot, MemStatus *mdev)
>  {
> @@ -202,7 +205,7 @@ static const MemoryRegionOps acpi_memory_hotplug_ops = {
>  };
>
>  void acpi_memory_hotplug_init(MemoryRegion *as, Object *owner,
> -                              MemHotplugState *state)
> +                              MemHotplugState *state, uint16_t io_base)
>  {
>      MachineState *machine = MACHINE(qdev_get_machine());
>
> @@ -211,10 +214,12 @@ void acpi_memory_hotplug_init(MemoryRegion *as, Object *owner,
>          return;
>      }
>
> +    assert(!memhp_io_base);
> +    memhp_io_base = io_base;
>      state->devs = g_malloc0(sizeof(*state->devs) * state->dev_count);
>      memory_region_init_io(&state->io, owner, &acpi_memory_hotplug_ops, state,
> -                          "acpi-mem-hotplug", ACPI_MEMORY_HOTPLUG_IO_LEN);
> -    memory_region_add_subregion(as, ACPI_MEMORY_HOTPLUG_BASE, &state->io);
> +                          "acpi-mem-hotplug", MEMORY_HOTPLUG_IO_LEN);
> +    memory_region_add_subregion(as, memhp_io_base, &state->io);
>  }
>
>  /**
> @@ -332,7 +337,6 @@ const VMStateDescription vmstate_memory_hotplug = {
>  };
>
>  void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
> -                              uint16_t io_base, uint16_t io_len,
>                                const char *res_root,
>                                const char *event_handler_method)
>  {
> @@ -342,8 +346,13 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
>      Aml *sb_scope;
>      Aml *mem_ctrl_dev;
>      char *scan_path;
> -    char *mhp_res_path = g_strdup_printf("%s." MEMORY_HOTPLUG_DEVICE, res_root);
> +    char *mhp_res_path;
> +
> +    if (!memhp_io_base) {
> +        return;
> +    }
>

I would split the functional change from the refactoring  code,
but if Michael is OK with it:

Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Thanks,
Marcel

> +    mhp_res_path = g_strdup_printf("%s." MEMORY_HOTPLUG_DEVICE, res_root);
>      mem_ctrl_dev = aml_device("%s", mhp_res_path);
>      {
>          Aml *crs;
> @@ -367,13 +376,14 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
>
>          crs = aml_resource_template();
>          aml_append(crs,
> -            aml_io(AML_DECODE16, io_base, io_base, 0, io_len)
> +            aml_io(AML_DECODE16, memhp_io_base, memhp_io_base, 0,
> +                   MEMORY_HOTPLUG_IO_LEN)
>          );
>          aml_append(mem_ctrl_dev, aml_name_decl("_CRS", crs));
>
>          aml_append(mem_ctrl_dev, aml_operation_region(
>              MEMORY_HOTPLUG_IO_REGION, AML_SYSTEM_IO,
> -            aml_int(io_base), io_len)
> +            aml_int(memhp_io_base), MEMORY_HOTPLUG_IO_LEN)
>          );
>
>          field = aml_field(MEMORY_HOTPLUG_IO_REGION, AML_DWORD_ACC,
> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> index 17d36bd..6d99fe4 100644
> --- a/hw/acpi/piix4.c
> +++ b/hw/acpi/piix4.c
> @@ -644,7 +644,8 @@ static void piix4_acpi_system_hot_add_init(MemoryRegion *parent,
>                                   PIIX4_CPU_HOTPLUG_IO_BASE);
>
>      if (s->acpi_memory_hotplug.is_enabled) {
> -        acpi_memory_hotplug_init(parent, OBJECT(s), &s->acpi_memory_hotplug);
> +        acpi_memory_hotplug_init(parent, OBJECT(s), &s->acpi_memory_hotplug,
> +                                 ACPI_MEMORY_HOTPLUG_BASE);
>      }
>  }
>
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index b7f4682..f207d4f 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -101,8 +101,6 @@ typedef struct AcpiPmInfo {
>      uint32_t gpe0_blk_len;
>      uint32_t io_base;
>      uint16_t cpu_hp_io_base;
> -    uint16_t mem_hp_io_base;
> -    uint16_t mem_hp_io_len;
>      uint16_t pcihp_io_base;
>      uint16_t pcihp_io_len;
>  } AcpiPmInfo;
> @@ -148,9 +146,6 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
>      }
>      assert(obj);
>
> -    pm->mem_hp_io_base = ACPI_MEMORY_HOTPLUG_BASE;
> -    pm->mem_hp_io_len = ACPI_MEMORY_HOTPLUG_IO_LEN;
> -
>      /* Fill in optional s3/s4 related properties */
>      o = object_property_get_qobject(obj, ACPI_PM_PROP_S3_DISABLED, NULL);
>      if (o) {
> @@ -1925,9 +1920,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          build_cpus_aml(dsdt, machine, opts, pm->cpu_hp_io_base,
>                         "\\_SB.PCI0", "\\_GPE._E02");
>      }
> -    build_memory_hotplug_aml(dsdt, nr_mem, pm->mem_hp_io_base,
> -                             pm->mem_hp_io_len,
> -                             "\\_SB.PCI0", "\\_GPE._E03");
> +    build_memory_hotplug_aml(dsdt, nr_mem, "\\_SB.PCI0", "\\_GPE._E03");
>
>      scope =  aml_scope("_GPE");
>      {
>
