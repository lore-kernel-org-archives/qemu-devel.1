Received: from eggs.gnu.org ([2001:4830:134:3::10]:45047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dBNEE-0007KI-6K
	for qemu-devel@nongnu.org; Thu, 18 May 2017 11:20:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dBNEA-0004rj-R9
	for qemu-devel@nongnu.org; Thu, 18 May 2017 11:20:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34498)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dBNEA-0004rQ-Dq
	for qemu-devel@nongnu.org; Thu, 18 May 2017 11:20:34 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 12ABB7700
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 15:20:33 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
	<20170509173559.31598-16-marcandre.lureau@redhat.com>
Date: Thu, 18 May 2017 17:20:28 +0200
In-Reply-To: <20170509173559.31598-16-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 9 May 2017
	20:35:57 +0300")
Message-ID: <877f1ep4xv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 15/17] Use uint property getter/setter
 where appropriate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> All those property usages are associated with unsigned integers, so use
> appropriate getter/setter.

"Usages"?  I think this is a question of whether the property value is
signed or unsigned.  I guess "those properties are" would work.

How did you find the ones that need changing?

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/hw/isa/isa.h         |  2 +-
>  hw/acpi/memory_hotplug.c     | 10 ++++----
>  hw/acpi/nvdimm.c             | 10 ++++----
>  hw/acpi/pcihp.c              |  6 ++---
>  hw/arm/aspeed.c              |  4 ++--
>  hw/arm/bcm2835_peripherals.c |  9 ++++----
>  hw/arm/raspi.c               |  4 ++--
>  hw/core/platform-bus.c       |  2 +-
>  hw/i386/acpi-build.c         | 55 ++++++++++++++++++++++----------------=
------
>  hw/i386/pc.c                 |  6 ++---
>  hw/i386/xen/xen-hvm.c        |  6 ++---
>  hw/intc/arm_gicv3_common.c   |  2 +-
>  hw/mem/pc-dimm.c             |  5 ++--
>  hw/misc/auxbus.c             |  2 +-
>  hw/misc/pvpanic.c            |  2 +-
>  hw/ppc/pnv_core.c            |  2 +-
>  hw/ppc/spapr.c               |  8 ++++---
>  numa.c                       |  6 ++---
>  target/i386/cpu.c            |  4 ++--
>  ui/console.c                 |  4 ++--
>  20 files changed, 77 insertions(+), 72 deletions(-)
>
> diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
> index c2fdd70cdc..95593408ef 100644
> --- a/include/hw/isa/isa.h
> +++ b/include/hw/isa/isa.h
> @@ -29,7 +29,7 @@ static inline uint16_t applesmc_port(void)
>      Object *obj =3D object_resolve_path_type("", TYPE_APPLE_SMC, NULL);
>=20=20
>      if (obj) {
> -        return object_property_get_int(obj, APPLESMC_PROP_IO_BASE, NULL);
> +        return object_property_get_uint(obj, APPLESMC_PROP_IO_BASE, NULL=
);
>      }
>      return 0;
>  }

The property is defined with DEFINE_PROP_UINT32().  Okay.

> diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
> index 210073d283..db3c89ceab 100644
> --- a/hw/acpi/memory_hotplug.c
> +++ b/hw/acpi/memory_hotplug.c
> @@ -83,11 +83,12 @@ static uint64_t acpi_memory_hotplug_read(void *opaque=
, hwaddr addr,
>      o =3D OBJECT(mdev->dimm);
>      switch (addr) {
>      case 0x0: /* Lo part of phys address where DIMM is mapped */
> -        val =3D o ? object_property_get_int(o, PC_DIMM_ADDR_PROP, NULL) =
: 0;
> +        val =3D o ? object_property_get_uint(o, PC_DIMM_ADDR_PROP, NULL)=
 : 0;
>          trace_mhp_acpi_read_addr_lo(mem_st->selector, val);
>          break;
>      case 0x4: /* Hi part of phys address where DIMM is mapped */
> -        val =3D o ? object_property_get_int(o, PC_DIMM_ADDR_PROP, NULL) =
>> 32 : 0;
> +        val =3D
> +            o ? object_property_get_uint(o, PC_DIMM_ADDR_PROP, NULL) >> =
32 : 0;
>          trace_mhp_acpi_read_addr_hi(mem_st->selector, val);
>          break;
>      case 0x8: /* Lo part of DIMM size */

TYPE_PC_DIMM's property PC_DIMM_ADDR_PROP is defined with
DEFINE_PROP_UINT64().  Okay.

> @@ -95,11 +96,12 @@ static uint64_t acpi_memory_hotplug_read(void *opaque=
, hwaddr addr,
>          trace_mhp_acpi_read_size_lo(mem_st->selector, val);
>          break;
>      case 0xc: /* Hi part of DIMM size */
> -        val =3D o ? object_property_get_int(o, PC_DIMM_SIZE_PROP, NULL) =
>> 32 : 0;
> +        val =3D
> +            o ? object_property_get_int(o, PC_DIMM_SIZE_PROP, NULL) >> 3=
2 : 0;

pc_dimm_get_size() uses visit_type_int().  Does that need a matching
update?

>          trace_mhp_acpi_read_size_hi(mem_st->selector, val);
>          break;
>      case 0x10: /* node proximity for _PXM method */
> -        val =3D o ? object_property_get_int(o, PC_DIMM_NODE_PROP, NULL) =
: 0;
> +        val =3D o ? object_property_get_uint(o, PC_DIMM_NODE_PROP, NULL)=
 : 0;
>          trace_mhp_acpi_read_pxm(mem_st->selector, val);
>          break;
>      case 0x14: /* pack and return is_* fields */

TYPE_PC_DIMM's property PC_DIMM_NODE_PROP is defined with
DEFINE_PROP_UINT32().  Okay.

> diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
> index 8e7d6ec034..e57027149d 100644
> --- a/hw/acpi/nvdimm.c
> +++ b/hw/acpi/nvdimm.c
> @@ -236,14 +236,14 @@ static void
>  nvdimm_build_structure_spa(GArray *structures, DeviceState *dev)
>  {
>      NvdimmNfitSpa *nfit_spa;
> -    uint64_t addr =3D object_property_get_int(OBJECT(dev), PC_DIMM_ADDR_=
PROP,
> -                                            NULL);
> +    uint64_t addr =3D object_property_get_uint(OBJECT(dev), PC_DIMM_ADDR=
_PROP,
> +                                             NULL);
>      uint64_t size =3D object_property_get_int(OBJECT(dev), PC_DIMM_SIZE_=
PROP,
>                                              NULL);

Here, you leave PC_DIMM_SIZE_PROP alone.  The code gets it signed and
assigns it to unsigned.  Needs cleanup.

> -    uint32_t node =3D object_property_get_int(OBJECT(dev), PC_DIMM_NODE_=
PROP,
> -                                            NULL);
> +    uint32_t node =3D object_property_get_uint(OBJECT(dev), PC_DIMM_NODE=
_PROP,
> +                                             NULL);
>      int slot =3D object_property_get_int(OBJECT(dev), PC_DIMM_SLOT_PROP,
> -                                            NULL);
> +                                       NULL);
>=20=20
>      nfit_spa =3D acpi_data_push(structures, sizeof(*nfit_spa));
>=20=20

More of the same.

> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index 3a531a4416..c420a388ea 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -62,10 +62,10 @@ typedef struct AcpiPciHpFind {
>  static int acpi_pcihp_get_bsel(PCIBus *bus)
>  {
>      Error *local_err =3D NULL;
> -    int64_t bsel =3D object_property_get_int(OBJECT(bus), ACPI_PCIHP_PRO=
P_BSEL,
> -                                           &local_err);
> +    uint64_t bsel =3D object_property_get_uint(OBJECT(bus), ACPI_PCIHP_P=
ROP_BSEL,
> +                                             &local_err);
>=20=20
> -    if (local_err || bsel < 0 || bsel >=3D ACPI_PCIHP_MAX_HOTPLUG_BUS) {
> +    if (local_err || bsel >=3D ACPI_PCIHP_MAX_HOTPLUG_BUS) {
>          if (local_err) {
>              error_free(local_err);
>          }

Haven't I seen ACPI_PCIHP_PROP_BSEL before?  Yes, in PATCH 13.  I think
splitting along subsystems rather than functions changed would be easier
to review, because the what the reviewer needs to understand is not so
much the functions but the underlying properties.

> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 283c038814..4af422909f 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -187,8 +187,8 @@ static void aspeed_board_init(MachineState *machine,
>       * Allocate RAM after the memory controller has checked the size
>       * was valid. If not, a default value is used.
>       */
> -    ram_size =3D object_property_get_int(OBJECT(&bmc->soc), "ram-size",
> -                                       &error_abort);
> +    ram_size =3D object_property_get_uint(OBJECT(&bmc->soc), "ram-size",
> +                                        &error_abort);

The assignment to global ram_size looks nasty, but that particular
nastiness is outside this patch's scope.

If I understand the aspeed code correctly, then this property is an
alias for device TYPE_ASPEED_SDMC's property "ram-size", which is
defined with DEFINE_PROP_UINT64().  Okay.

However, a few lines further up, we have:

       object_property_set_int(OBJECT(&bmc->soc), ram_size, "ram-size",
                              &error_abort);

The two should be kept consistent.

Adds urgency to my question how you found the ones that need changing.

>=20=20
>      memory_region_allocate_system_memory(&bmc->ram, NULL, "ram", ram_siz=
e);
>      memory_region_add_subregion(get_system_memory(), sc->info->sdram_bas=
e,
> diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
> index 369ef1e3bd..b168c6f83e 100644
> --- a/hw/arm/bcm2835_peripherals.c
> +++ b/hw/arm/bcm2835_peripherals.c
> @@ -126,7 +126,7 @@ static void bcm2835_peripherals_realize(DeviceState *=
dev, Error **errp)
>      Object *obj;
>      MemoryRegion *ram;
>      Error *err =3D NULL;
> -    uint32_t ram_size, vcram_size;
> +    uint64_t ram_size, vcram_size;
>      int n;
>=20=20
>      obj =3D object_property_get_link(OBJECT(dev), "ram", &err);
> @@ -208,15 +208,14 @@ static void bcm2835_peripherals_realize(DeviceState=
 *dev, Error **errp)
>                                 INTERRUPT_ARM_MAILBOX));
>=20=20
>      /* Framebuffer */
> -    vcram_size =3D (uint32_t)object_property_get_int(OBJECT(s), "vcram-s=
ize",
> -                                                   &err);
> +    vcram_size =3D object_property_get_uint(OBJECT(s), "vcram-size", &er=
r);

This one appears to be an alias of TYPE_BCM2835_FB's property
"vcram-size", which is defined with DEFINE_PROP_UINT32().  Okay.

>      if (err) {
>          error_propagate(errp, err);
>          return;
>      }
>=20=20
> -    object_property_set_int(OBJECT(&s->fb), ram_size - vcram_size,
> -                            "vcram-base", &err);
> +    object_property_set_uint(OBJECT(&s->fb), ram_size - vcram_size,
> +                             "vcram-base", &err);
>      if (err) {
>          error_propagate(errp, err);
>          return;

Defined with DEFINE_PROP_UINT32().  Okay.

> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index 2b295f14c4..32cdc98c6d 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -153,8 +153,8 @@ static void raspi2_init(MachineState *machine)
>      qdev_prop_set_drive(carddev, "drive", blk, &error_fatal);
>      object_property_set_bool(OBJECT(carddev), true, "realized", &error_f=
atal);
>=20=20
> -    vcram_size =3D object_property_get_int(OBJECT(&s->soc), "vcram-size",
> -                                         &error_abort);
> +    vcram_size =3D object_property_get_uint(OBJECT(&s->soc), "vcram-size=
",
> +                                          &error_abort);
>      setup_boot(machine, 2, machine->ram_size - vcram_size);
>  }

Same property as above.  Okay.

>=20=20
> diff --git a/hw/core/platform-bus.c b/hw/core/platform-bus.c
> index 329ac670c0..33d32fbf22 100644
> --- a/hw/core/platform-bus.c
> +++ b/hw/core/platform-bus.c
> @@ -71,7 +71,7 @@ hwaddr platform_bus_get_mmio_addr(PlatformBusDevice *pb=
us, SysBusDevice *sbdev,
>          return -1;
>      }
>=20=20
> -    return object_property_get_int(OBJECT(sbdev_mr), "addr", NULL);
> +    return object_property_get_uint(OBJECT(sbdev_mr), "addr", NULL);
>  }

I figure this is TYPE_MEMORY_REGION's property.  Its getter
memory_region_get_addr() uses visit_type_uint64().  Okay.

>=20=20
>  static void platform_bus_count_irqs(SysBusDevice *sbdev, void *opaque)
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 27ad420914..76d27ff024 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -137,9 +137,9 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
>          obj =3D piix;
>          pm->cpu_hp_io_base =3D PIIX4_CPU_HOTPLUG_IO_BASE;
>          pm->pcihp_io_base =3D
> -            object_property_get_int(obj, ACPI_PCIHP_IO_BASE_PROP, NULL);
> +            object_property_get_uint(obj, ACPI_PCIHP_IO_BASE_PROP, NULL);
>          pm->pcihp_io_len =3D
> -            object_property_get_int(obj, ACPI_PCIHP_IO_LEN_PROP, NULL);
> +            object_property_get_uint(obj, ACPI_PCIHP_IO_LEN_PROP, NULL);
>      }
>      if (lpc) {
>          obj =3D lpc;

These appear to be defined with object_property_add_uint16_ptr().  Okay,
I think.

> @@ -171,20 +171,21 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
>      qobject_decref(o);
>=20=20
>      /* Fill in mandatory properties */
> -    pm->sci_int =3D object_property_get_int(obj, ACPI_PM_PROP_SCI_INT, N=
ULL);
> -
> -    pm->acpi_enable_cmd =3D object_property_get_int(obj,
> -                                                  ACPI_PM_PROP_ACPI_ENAB=
LE_CMD,
> -                                                  NULL);
> -    pm->acpi_disable_cmd =3D object_property_get_int(obj,
> -                                                  ACPI_PM_PROP_ACPI_DISA=
BLE_CMD,
> -                                                  NULL);
> -    pm->io_base =3D object_property_get_int(obj, ACPI_PM_PROP_PM_IO_BASE,
> -                                          NULL);
> -    pm->gpe0_blk =3D object_property_get_int(obj, ACPI_PM_PROP_GPE0_BLK,
> +    pm->sci_int =3D object_property_get_uint(obj, ACPI_PM_PROP_SCI_INT, =
NULL);
> +
> +    pm->acpi_enable_cmd =3D object_property_get_uint(obj,
> +                                                   ACPI_PM_PROP_ACPI_ENA=
BLE_CMD,
> +                                                   NULL);
> +    pm->acpi_disable_cmd =3D
> +        object_property_get_uint(obj,
> +                                 ACPI_PM_PROP_ACPI_DISABLE_CMD,
> +                                 NULL);
> +    pm->io_base =3D object_property_get_uint(obj, ACPI_PM_PROP_PM_IO_BAS=
E,
>                                             NULL);
> -    pm->gpe0_blk_len =3D object_property_get_int(obj, ACPI_PM_PROP_GPE0_=
BLK_LEN,
> -                                               NULL);
> +    pm->gpe0_blk =3D object_property_get_uint(obj, ACPI_PM_PROP_GPE0_BLK,
> +                                            NULL);
> +    pm->gpe0_blk_len =3D object_property_get_uint(obj, ACPI_PM_PROP_GPE0=
_BLK_LEN,
> +                                                NULL);
>      pm->pcihp_bridge_en =3D
>          object_property_get_bool(obj, "acpi-pci-hotplug-with-bridge-supp=
ort",
>                                   NULL);

PIIX4: piix4_pm_add_propeties() defines these with
object_property_add_uint*_ptr().

Q35: ich9_lpc_add_properties() and ich9_pm_add_properties() define them
similarly, except for ACPI_PM_PROP_GPE0_BLK().  That one's getter
ich9_pm_get_gpe0_blk() uses visit_type_uint32().

Okay.

> @@ -237,19 +238,19 @@ static void acpi_get_pci_holes(Range *hole, Range *=
hole64)
>      g_assert(pci_host);
>=20=20
>      range_set_bounds1(hole,
> -                      object_property_get_int(pci_host,
> -                                              PCI_HOST_PROP_PCI_HOLE_STA=
RT,
> -                                              NULL),
> -                      object_property_get_int(pci_host,
> -                                              PCI_HOST_PROP_PCI_HOLE_END,
> -                                              NULL));
> +                      object_property_get_uint(pci_host,
> +                                               PCI_HOST_PROP_PCI_HOLE_ST=
ART,
> +                                               NULL),
> +                      object_property_get_uint(pci_host,
> +                                               PCI_HOST_PROP_PCI_HOLE_EN=
D,
> +                                               NULL));
>      range_set_bounds1(hole64,
> -                      object_property_get_int(pci_host,
> -                                              PCI_HOST_PROP_PCI_HOLE64_S=
TART,
> -                                              NULL),
> -                      object_property_get_int(pci_host,
> -                                              PCI_HOST_PROP_PCI_HOLE64_E=
ND,
> -                                              NULL));
> +                      object_property_get_uint(pci_host,
> +                                               PCI_HOST_PROP_PCI_HOLE64_=
START,
> +                                               NULL),
> +                      object_property_get_uint(pci_host,
> +                                               PCI_HOST_PROP_PCI_HOLE64_=
END,
> +                                               NULL));
>  }
>=20=20

Deja vu again, this time PATCH 11.  Okay.

>  #define ACPI_PORT_SMI_CMD           0x00b2 /* TODO: this is APM_CNT_IOPO=
RT */
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index f3b372a18f..8dc4507aa5 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -347,7 +347,7 @@ static int check_fdc(Object *obj, void *opaque)
>          return 0;
>      }
>=20=20
> -    iobase =3D object_property_get_int(obj, "iobase", &local_err);
> +    iobase =3D object_property_get_uint(obj, "iobase", &local_err);
>      if (local_err || iobase !=3D 0x3f0) {
>          error_free(local_err);
>          return 0;

TYPE_ISA_FDC's property "iobase" is defined with DEFINE_PROP_UINT32().
Okay.

> @@ -1100,7 +1100,7 @@ static void pc_new_cpu(const char *typename, int64_=
t apic_id, Error **errp)
>=20=20
>      cpu =3D object_new(typename);
>=20=20
> -    object_property_set_int(cpu, apic_id, "apic-id", &local_err);
> +    object_property_set_uint(cpu, apic_id, "apic-id", &local_err);
>      object_property_set_bool(cpu, true, "realized", &local_err);
>=20=20

TYPE_X86_CPU's property "apic-id" is defined with DEFINE_PROP_UINT32().
Okay.

>      object_unref(cpu);
> @@ -1560,7 +1560,7 @@ void pc_basic_device_init(ISABus *isa_bus, qemu_irq=
 *gsi,
>               * and earlier, use IRQ2 for compat. Otherwise, use IRQ16~23,
>               * IRQ8 and IRQ2.
>               */
> -            uint8_t compat =3D object_property_get_int(OBJECT(hpet),
> +            uint8_t compat =3D object_property_get_uint(OBJECT(hpet),
>                      HPET_INTCAP, NULL);
>              if (!compat) {
>                  qdev_prop_set_uint32(hpet, HPET_INTCAP, hpet_irqs);

TYPE_HPET's property HPET_INTCAP is defined with DEFINE_PROP_UINT32().
Okay.

> diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
> index b1c05ffb86..cec259f82d 100644
> --- a/hw/i386/xen/xen-hvm.c
> +++ b/hw/i386/xen/xen-hvm.c
> @@ -183,9 +183,9 @@ static void xen_ram_init(PCMachineState *pcms,
>  {
>      MemoryRegion *sysmem =3D get_system_memory();
>      ram_addr_t block_len;
> -    uint64_t user_lowmem =3D object_property_get_int(qdev_get_machine(),
> -                                                   PC_MACHINE_MAX_RAM_BE=
LOW_4G,
> -                                                   &error_abort);
> +    uint64_t user_lowmem =3D object_property_get_uint(qdev_get_machine(),
> +                                                    PC_MACHINE_MAX_RAM_B=
ELOW_4G,
> +                                                    &error_abort);
>=20=20
>      /* Handle the machine opt max-ram-below-4g.  It is basically doing
>       * min(xen limit, user limit).

TYPE_PC_MACHINE's property PC_MACHINE_MAX_RAM_BELOW_4G's getter and
setter pc_machine_get_max_ram_below_4g() and
pc_machine_set_max_ram_below_4g() use visit_type_size().  Okay.

> diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
> index c6493d6c07..e2064cd8c5 100644
> --- a/hw/intc/arm_gicv3_common.c
> +++ b/hw/intc/arm_gicv3_common.c
> @@ -267,7 +267,7 @@ static void arm_gicv3_common_realize(DeviceState *dev=
, Error **errp)
>           *  VLPIS =3D=3D 0 (virtual LPIs not supported)
>           *  PLPIS =3D=3D 0 (physical LPIs not supported)
>           */
> -        cpu_affid =3D object_property_get_int(OBJECT(cpu), "mp-affinity"=
, NULL);
> +        cpu_affid =3D object_property_get_uint(OBJECT(cpu), "mp-affinity=
", NULL);
>          last =3D (i =3D=3D s->num_cpu - 1);
>=20=20
>          /* The CPU mp-affinity property is in MPIDR register format; squ=
ash

TYPE_ARM_CPU's property "mp-affinity" is defined with
DEFINE_PROP_UINT64().  Okay.

> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index 9e8dab0e89..f6def8c239 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -46,7 +46,8 @@ void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplu=
gState *hpms,
>      uint64_t existing_dimms_capacity =3D 0;
>      uint64_t addr;
>=20=20
> -    addr =3D object_property_get_int(OBJECT(dimm), PC_DIMM_ADDR_PROP, &l=
ocal_err);
> +    addr =3D object_property_get_uint(OBJECT(dimm),
> +                                    PC_DIMM_ADDR_PROP, &local_err);
>      if (local_err) {
>          goto out;
>      }

Discussed above.

> @@ -73,7 +74,7 @@ void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplu=
gState *hpms,
>          goto out;
>      }
>=20=20
> -    object_property_set_int(OBJECT(dev), addr, PC_DIMM_ADDR_PROP, &local=
_err);
> +    object_property_set_uint(OBJECT(dev), addr, PC_DIMM_ADDR_PROP, &loca=
l_err);
>      if (local_err) {
>          goto out;
>      }

Same.

> diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
> index e4a7ba41de..8a90ddda84 100644
> --- a/hw/misc/auxbus.c
> +++ b/hw/misc/auxbus.c
> @@ -244,7 +244,7 @@ static void aux_slave_dev_print(Monitor *mon, DeviceS=
tate *dev, int indent)
>=20=20
>      monitor_printf(mon, "%*smemory " TARGET_FMT_plx "/" TARGET_FMT_plx "=
\n",
>                     indent, "",
> -                   object_property_get_int(OBJECT(s->mmio), "addr", NULL=
),
> +                   object_property_get_uint(OBJECT(s->mmio), "addr", NUL=
L),
>                     memory_region_size(s->mmio));
>  }
>=20=20

I figure this is again TYPE_MEMORY_REGION's property.

> diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
> index 57da7f2199..2b1e9a6450 100644
> --- a/hw/misc/pvpanic.c
> +++ b/hw/misc/pvpanic.c
> @@ -111,7 +111,7 @@ uint16_t pvpanic_port(void)
>      if (!o) {
>          return 0;
>      }
> -    return object_property_get_int(o, PVPANIC_IOPORT_PROP, NULL);
> +    return object_property_get_uint(o, PVPANIC_IOPORT_PROP, NULL);
>  }
>=20=20

TYPE_ISA_PVPANIC_DEVICE's property PVPANIC_IOPORT_PROP is defined with
DEFINE_PROP_UINT16().  Okay.

>  static Property pvpanic_isa_properties[] =3D {
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 1b7ec70f03..142bad1e57 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -51,7 +51,7 @@ static void powernv_cpu_init(PowerPCCPU *cpu, Error **e=
rrp)
>      int thread_index =3D 0; /* TODO: TCG supports only one thread */
>      ppc_spr_t *pir =3D &env->spr_cb[SPR_PIR];
>=20=20
> -    core_pir =3D object_property_get_int(OBJECT(cpu), "core-pir", &error=
_abort);
> +    core_pir =3D object_property_get_uint(OBJECT(cpu), "core-pir", &erro=
r_abort);
>=20=20
>      /*
>       * The PIR of a thread is the core PIR + the thread index. We will

This seems to be an alias of TYPE_PNV_CORE's property "pir", which is
defined with DEFINE_PROP_UINT32().  Okay.

> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 80d12d005c..9b9a4e8817 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2582,7 +2582,8 @@ static void spapr_memory_plug(HotplugHandler *hotpl=
ug_dev, DeviceState *dev,
>          goto out;
>      }
>=20=20
> -    addr =3D object_property_get_int(OBJECT(dimm), PC_DIMM_ADDR_PROP, &l=
ocal_err);
> +    addr =3D object_property_get_uint(OBJECT(dimm),
> +                                    PC_DIMM_ADDR_PROP, &local_err);
>      if (local_err) {
>          pc_dimm_memory_unplug(dev, &ms->hotplug_memory, mr);
>          goto out;

Discussed above.

> @@ -2670,7 +2671,8 @@ static void spapr_memory_unplug_request(HotplugHand=
ler *hotplug_dev,
>      uint64_t size =3D memory_region_size(mr);
>      uint64_t addr;
>=20=20
> -    addr =3D object_property_get_int(OBJECT(dimm), PC_DIMM_ADDR_PROP, &l=
ocal_err);
> +    addr =3D object_property_get_uint(OBJECT(dimm),
> +                                    PC_DIMM_ADDR_PROP, &local_err);
>      if (local_err) {
>          goto out;
>      }

Same.

> @@ -2878,7 +2880,7 @@ static void spapr_machine_device_plug(HotplugHandle=
r *hotplug_dev,
>              error_setg(errp, "Memory hotplug not supported for this mach=
ine");
>              return;
>          }
> -        node =3D object_property_get_int(OBJECT(dev), PC_DIMM_NODE_PROP,=
 errp);
> +        node =3D object_property_get_uint(OBJECT(dev), PC_DIMM_NODE_PROP=
, errp);
>          if (*errp) {
>              return;
>          }

Same.

> diff --git a/numa.c b/numa.c
> index 6fc2393ddd..e32259fedb 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -205,7 +205,7 @@ static void numa_node_parse(NumaNodeOptions *node, Qe=
muOpts *opts, Error **errp)
>          }
>=20=20
>          object_ref(o);
> -        numa_info[nodenr].node_mem =3D object_property_get_int(o, "size"=
, NULL);
> +        numa_info[nodenr].node_mem =3D object_property_get_uint(o, "size=
", NULL);
>          numa_info[nodenr].node_memdev =3D MEMORY_BACKEND(o);
>      }
>      numa_info[nodenr].present =3D true;
> @@ -527,8 +527,8 @@ static int query_memdev(Object *obj, void *opaque)
>          m->value->id =3D object_property_get_str(obj, "id", NULL);
>          m->value->has_id =3D !!m->value->id;
>=20=20
> -        m->value->size =3D object_property_get_int(obj, "size",
> -                                                 &error_abort);
> +        m->value->size =3D object_property_get_uint(obj, "size",
> +                                                  &error_abort);
>          m->value->merge =3D object_property_get_bool(obj, "merge",
>                                                     &error_abort);
>          m->value->dump =3D object_property_get_bool(obj, "dump",

I figure "size" is a property of TYPE_MEMORY_BACKEND.
host_memory_backend_get_size() and host_memory_backend_set_size() use
visit_type_size().  Okay.

> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 5bb8131bb8..eb200ef58b 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2324,8 +2324,8 @@ static void x86_cpu_load_def(X86CPU *cpu, X86CPUDef=
inition *def, Error **errp)
>       */
>=20=20
>      /* CPU models only set _minimum_ values for level/xlevel: */
> -    object_property_set_int(OBJECT(cpu), def->level, "min-level", errp);
> -    object_property_set_int(OBJECT(cpu), def->xlevel, "min-xlevel", errp=
);
> +    object_property_set_uint(OBJECT(cpu), def->level, "min-level", errp);
> +    object_property_set_uint(OBJECT(cpu), def->xlevel, "min-xlevel", err=
p);
>=20=20
>      object_property_set_int(OBJECT(cpu), def->family, "family", errp);
>      object_property_set_int(OBJECT(cpu), def->model, "model", errp);

I figure these are properties of TYPE_X86_CPU, defined with
DEFINE_PROP_UINT32().  Okay.

> diff --git a/ui/console.c b/ui/console.c
> index ac66b3c910..ad3f7c6a2c 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -1872,8 +1872,8 @@ QemuConsole *qemu_console_lookup_by_device(DeviceSt=
ate *dev, uint32_t head)
>          if (DEVICE(obj) !=3D dev) {
>              continue;
>          }
> -        h =3D object_property_get_int(OBJECT(consoles[i]),
> -                                    "head", &error_abort);
> +        h =3D object_property_get_uint(OBJECT(consoles[i]),
> +                                     "head", &error_abort);
>          if (h !=3D head) {
>              continue;
>          }

TYPE_QEMU_CONSOLE property "head" is defined with
object_property_add_uint*_ptr().  Okay.


Not your patch's fault, but I need to vent: to read a QOM property, we
call a suitable object_property_get_FOO(), which uses the property's
getter with a new QObject output visitor to get the property value as a
QObject, converts the QObject to the C type for FOO, frees the QObject,
and returns the converted value.

The getter knows the property's C type.

The code reading the property has to know the appropriate FOO for this C
type.

The conversion from QObject to C type does a bit of dynamic type
checking, so the code reading the property screws up too badly, we get
at least a run time failure.  There is no protection against messing up
signedness or width, and of course we mess up in places.

Writing is just as convoluted, opaque and error-prone.

This looks like a severe case of OOPitis to me.  There must be a better
way!  The signedness issues you correct should have been flagged by the
compiler or at least by Coverity.  Our OOPitis muddies the waters
sufficiently to defeat both.
