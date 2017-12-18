Received: from eggs.gnu.org ([2001:4830:134:3::10]:55972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eQmzu-0005cw-FX
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 23:25:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eQmzq-0003TG-Vv
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 23:25:50 -0500
Date: Mon, 18 Dec 2017 15:24:02 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171218042402.GT7753@umbus.fritz.box>
References: <20171215135601.13179-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VjP/dwTbBl6I9PQk"
Content-Disposition: inline
In-Reply-To: <20171215135601.13179-1-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2] ppc/pnv: change powernv_ prefix to pnv_
 for overall naming consistency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>


--VjP/dwTbBl6I9PQk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2017 at 02:56:01PM +0100, C=E9dric Le Goater wrote:
> The 'pnv' prefix is now used for all and the routines populating the
> device tree start with 'pnv_dt'. The handler of the PnvXScomInterface
> is also renamed to 'dt_xscom' which should reflect that it is
> populating the device tree under the 'xscom@' node of the chip.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-2.12.

> ---
>=20
>  Changes since v2:
>=20
>  - fixed code alignment
>  - renamed device tree routines also.
>=20
>  hw/ppc/pnv.c               | 94 ++++++++++++++++++++++------------------=
------
>  hw/ppc/pnv_bmc.c           |  2 +-
>  hw/ppc/pnv_core.c          |  8 ++--
>  hw/ppc/pnv_lpc.c           |  6 +--
>  hw/ppc/pnv_psi.c           |  4 +-
>  hw/ppc/pnv_xscom.c         | 10 ++---
>  include/hw/ppc/pnv.h       | 10 ++---
>  include/hw/ppc/pnv_xscom.h |  4 +-
>  8 files changed, 67 insertions(+), 71 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index c35c439d816b..6ed72ad335d1 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -77,8 +77,7 @@ static const char *pnv_chip_core_typename(const PnvChip=
 *o)
>   * that has a different "affinity". In practice, it means one range
>   * per chip.
>   */
> -static void powernv_populate_memory_node(void *fdt, int chip_id, hwaddr =
start,
> -                                         hwaddr size)
> +static void pnv_dt_memory(void *fdt, int chip_id, hwaddr start, hwaddr s=
ize)
>  {
>      char *mem_name;
>      uint64_t mem_reg_property[2];
> @@ -119,7 +118,7 @@ static int get_cpus_node(void *fdt)
>   * device tree, used in XSCOM to address cores and in interrupt
>   * servers.
>   */
> -static void powernv_create_core_node(PnvChip *chip, PnvCore *pc, void *f=
dt)
> +static void pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
>  {
>      CPUState *cs =3D CPU(DEVICE(pc->threads));
>      DeviceClass *dc =3D DEVICE_GET_CLASS(cs);
> @@ -228,8 +227,8 @@ static void powernv_create_core_node(PnvChip *chip, P=
nvCore *pc, void *fdt)
>                         servers_prop, sizeof(servers_prop))));
>  }
> =20
> -static void powernv_populate_icp(PnvChip *chip, void *fdt, uint32_t pir,
> -                                 uint32_t nr_threads)
> +static void pnv_dt_icp(PnvChip *chip, void *fdt, uint32_t pir,
> +                       uint32_t nr_threads)
>  {
>      uint64_t addr =3D PNV_ICP_BASE(chip) | (pir << 12);
>      char *name;
> @@ -277,13 +276,13 @@ static int pnv_chip_lpc_offset(PnvChip *chip, void =
*fdt)
>      return offset;
>  }
> =20
> -static void powernv_populate_chip(PnvChip *chip, void *fdt)
> +static void pnv_dt_chip(PnvChip *chip, void *fdt)
>  {
>      const char *typename =3D pnv_chip_core_typename(chip);
>      size_t typesize =3D object_type_get_instance_size(typename);
>      int i;
> =20
> -    pnv_xscom_populate(chip, fdt, 0);
> +    pnv_dt_xscom(chip, fdt, 0);
> =20
>      /* The default LPC bus of a multichip system is on chip 0. It's
>       * recognized by the firmware (skiboot) using a "primary"
> @@ -298,20 +297,18 @@ static void powernv_populate_chip(PnvChip *chip, vo=
id *fdt)
>      for (i =3D 0; i < chip->nr_cores; i++) {
>          PnvCore *pnv_core =3D PNV_CORE(chip->cores + i * typesize);
> =20
> -        powernv_create_core_node(chip, pnv_core, fdt);
> +        pnv_dt_core(chip, pnv_core, fdt);
> =20
>          /* Interrupt Control Presenters (ICP). One per core. */
> -        powernv_populate_icp(chip, fdt, pnv_core->pir,
> -                             CPU_CORE(pnv_core)->nr_threads);
> +        pnv_dt_icp(chip, fdt, pnv_core->pir, CPU_CORE(pnv_core)->nr_thre=
ads);
>      }
> =20
>      if (chip->ram_size) {
> -        powernv_populate_memory_node(fdt, chip->chip_id, chip->ram_start,
> -                                     chip->ram_size);
> +        pnv_dt_memory(fdt, chip->chip_id, chip->ram_start, chip->ram_siz=
e);
>      }
>  }
> =20
> -static void powernv_populate_rtc(ISADevice *d, void *fdt, int lpc_off)
> +static void pnv_dt_rtc(ISADevice *d, void *fdt, int lpc_off)
>  {
>      uint32_t io_base =3D d->ioport_id;
>      uint32_t io_regs[] =3D {
> @@ -331,7 +328,7 @@ static void powernv_populate_rtc(ISADevice *d, void *=
fdt, int lpc_off)
>      _FDT((fdt_setprop_string(fdt, node, "compatible", "pnpPNP,b00")));
>  }
> =20
> -static void powernv_populate_serial(ISADevice *d, void *fdt, int lpc_off)
> +static void pnv_dt_serial(ISADevice *d, void *fdt, int lpc_off)
>  {
>      const char compatible[] =3D "ns16550\0pnpPNP,501";
>      uint32_t io_base =3D d->ioport_id;
> @@ -362,7 +359,7 @@ static void powernv_populate_serial(ISADevice *d, voi=
d *fdt, int lpc_off)
>      _FDT((fdt_setprop_string(fdt, node, "device_type", "serial")));
>  }
> =20
> -static void powernv_populate_ipmi_bt(ISADevice *d, void *fdt, int lpc_of=
f)
> +static void pnv_dt_ipmi_bt(ISADevice *d, void *fdt, int lpc_off)
>  {
>      const char compatible[] =3D "bt\0ipmi-bt";
>      uint32_t io_base;
> @@ -401,17 +398,17 @@ typedef struct ForeachPopulateArgs {
>      int offset;
>  } ForeachPopulateArgs;
> =20
> -static int powernv_populate_isa_device(DeviceState *dev, void *opaque)
> +static int pnv_dt_isa_device(DeviceState *dev, void *opaque)
>  {
>      ForeachPopulateArgs *args =3D opaque;
>      ISADevice *d =3D ISA_DEVICE(dev);
> =20
>      if (object_dynamic_cast(OBJECT(dev), TYPE_MC146818_RTC)) {
> -        powernv_populate_rtc(d, args->fdt, args->offset);
> +        pnv_dt_rtc(d, args->fdt, args->offset);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_ISA_SERIAL)) {
> -        powernv_populate_serial(d, args->fdt, args->offset);
> +        pnv_dt_serial(d, args->fdt, args->offset);
>      } else if (object_dynamic_cast(OBJECT(dev), "isa-ipmi-bt")) {
> -        powernv_populate_ipmi_bt(d, args->fdt, args->offset);
> +        pnv_dt_ipmi_bt(d, args->fdt, args->offset);
>      } else {
>          error_report("unknown isa device %s@i%x", qdev_fw_name(dev),
>                       d->ioport_id);
> @@ -420,7 +417,7 @@ static int powernv_populate_isa_device(DeviceState *d=
ev, void *opaque)
>      return 0;
>  }
> =20
> -static void powernv_populate_isa(ISABus *bus, void *fdt, int lpc_offset)
> +static void pnv_dt_isa(ISABus *bus, void *fdt, int lpc_offset)
>  {
>      ForeachPopulateArgs args =3D {
>          .fdt =3D fdt,
> @@ -429,14 +426,13 @@ static void powernv_populate_isa(ISABus *bus, void =
*fdt, int lpc_offset)
> =20
>      /* ISA devices are not necessarily parented to the ISA bus so we
>       * can not use object_child_foreach() */
> -    qbus_walk_children(BUS(bus), powernv_populate_isa_device,
> -                       NULL, NULL, NULL, &args);
> +    qbus_walk_children(BUS(bus), pnv_dt_isa_device, NULL, NULL, NULL, &a=
rgs);
>  }
> =20
> -static void *powernv_create_fdt(MachineState *machine)
> +static void *pnv_dt_create(MachineState *machine)
>  {
>      const char plat_compat[] =3D "qemu,powernv\0ibm,powernv";
> -    PnvMachineState *pnv =3D POWERNV_MACHINE(machine);
> +    PnvMachineState *pnv =3D PNV_MACHINE(machine);
>      void *fdt;
>      char *buf;
>      int off;
> @@ -479,15 +475,15 @@ static void *powernv_create_fdt(MachineState *machi=
ne)
> =20
>      /* Populate device tree for each chip */
>      for (i =3D 0; i < pnv->num_chips; i++) {
> -        powernv_populate_chip(pnv->chips[i], fdt);
> +        pnv_dt_chip(pnv->chips[i], fdt);
>      }
> =20
>      /* Populate ISA devices on chip 0 */
>      lpc_offset =3D pnv_chip_lpc_offset(pnv->chips[0], fdt);
> -    powernv_populate_isa(pnv->isa_bus, fdt, lpc_offset);
> +    pnv_dt_isa(pnv->isa_bus, fdt, lpc_offset);
> =20
>      if (pnv->bmc) {
> -        pnv_bmc_populate_sensors(pnv->bmc, fdt);
> +        pnv_dt_bmc_sensors(pnv->bmc, fdt);
>      }
> =20
>      return fdt;
> @@ -495,17 +491,17 @@ static void *powernv_create_fdt(MachineState *machi=
ne)
> =20
>  static void pnv_powerdown_notify(Notifier *n, void *opaque)
>  {
> -    PnvMachineState *pnv =3D POWERNV_MACHINE(qdev_get_machine());
> +    PnvMachineState *pnv =3D PNV_MACHINE(qdev_get_machine());
> =20
>      if (pnv->bmc) {
>          pnv_bmc_powerdown(pnv->bmc);
>      }
>  }
> =20
> -static void ppc_powernv_reset(void)
> +static void pnv_reset(void)
>  {
>      MachineState *machine =3D MACHINE(qdev_get_machine());
> -    PnvMachineState *pnv =3D POWERNV_MACHINE(machine);
> +    PnvMachineState *pnv =3D PNV_MACHINE(machine);
>      void *fdt;
>      Object *obj;
> =20
> @@ -524,7 +520,7 @@ static void ppc_powernv_reset(void)
>          pnv->bmc =3D IPMI_BMC(obj);
>      }
> =20
> -    fdt =3D powernv_create_fdt(machine);
> +    fdt =3D pnv_dt_create(machine);
> =20
>      /* Pack resulting tree */
>      _FDT((fdt_pack(fdt)));
> @@ -552,9 +548,9 @@ static ISABus *pnv_isa_create(PnvChip *chip)
>      return isa_bus;
>  }
> =20
> -static void ppc_powernv_init(MachineState *machine)
> +static void pnv_init(MachineState *machine)
>  {
> -    PnvMachineState *pnv =3D POWERNV_MACHINE(machine);
> +    PnvMachineState *pnv =3D PNV_MACHINE(machine);
>      MemoryRegion *ram;
>      char *fw_filename;
>      long fw_size;
> @@ -567,7 +563,7 @@ static void ppc_powernv_init(MachineState *machine)
>      }
> =20
>      ram =3D g_new(MemoryRegion, 1);
> -    memory_region_allocate_system_memory(ram, NULL, "ppc_powernv.ram",
> +    memory_region_allocate_system_memory(ram, NULL, "pnv.ram",
>                                           machine->ram_size);
>      memory_region_add_subregion(get_system_memory(), 0, ram);
> =20
> @@ -974,7 +970,7 @@ static void pnv_chip_class_init(ObjectClass *klass, v=
oid *data)
> =20
>  static ICSState *pnv_ics_get(XICSFabric *xi, int irq)
>  {
> -    PnvMachineState *pnv =3D POWERNV_MACHINE(xi);
> +    PnvMachineState *pnv =3D PNV_MACHINE(xi);
>      int i;
> =20
>      for (i =3D 0; i < pnv->num_chips; i++) {
> @@ -987,7 +983,7 @@ static ICSState *pnv_ics_get(XICSFabric *xi, int irq)
> =20
>  static void pnv_ics_resend(XICSFabric *xi)
>  {
> -    PnvMachineState *pnv =3D POWERNV_MACHINE(xi);
> +    PnvMachineState *pnv =3D PNV_MACHINE(xi);
>      int i;
> =20
>      for (i =3D 0; i < pnv->num_chips; i++) {
> @@ -1021,7 +1017,7 @@ static ICPState *pnv_icp_get(XICSFabric *xi, int pi=
r)
>  static void pnv_pic_print_info(InterruptStatsProvider *obj,
>                                 Monitor *mon)
>  {
> -    PnvMachineState *pnv =3D POWERNV_MACHINE(obj);
> +    PnvMachineState *pnv =3D PNV_MACHINE(obj);
>      int i;
>      CPUState *cs;
> =20
> @@ -1039,13 +1035,13 @@ static void pnv_pic_print_info(InterruptStatsProv=
ider *obj,
>  static void pnv_get_num_chips(Object *obj, Visitor *v, const char *name,
>                                void *opaque, Error **errp)
>  {
> -    visit_type_uint32(v, name, &POWERNV_MACHINE(obj)->num_chips, errp);
> +    visit_type_uint32(v, name, &PNV_MACHINE(obj)->num_chips, errp);
>  }
> =20
>  static void pnv_set_num_chips(Object *obj, Visitor *v, const char *name,
>                                void *opaque, Error **errp)
>  {
> -    PnvMachineState *pnv =3D POWERNV_MACHINE(obj);
> +    PnvMachineState *pnv =3D PNV_MACHINE(obj);
>      uint32_t num_chips;
>      Error *local_err =3D NULL;
> =20
> @@ -1067,13 +1063,13 @@ static void pnv_set_num_chips(Object *obj, Visito=
r *v, const char *name,
>      pnv->num_chips =3D num_chips;
>  }
> =20
> -static void powernv_machine_initfn(Object *obj)
> +static void pnv_machine_initfn(Object *obj)
>  {
> -    PnvMachineState *pnv =3D POWERNV_MACHINE(obj);
> +    PnvMachineState *pnv =3D PNV_MACHINE(obj);
>      pnv->num_chips =3D 1;
>  }
> =20
> -static void powernv_machine_class_props_init(ObjectClass *oc)
> +static void pnv_machine_class_props_init(ObjectClass *oc)
>  {
>      object_class_property_add(oc, "num-chips", "uint32",
>                                pnv_get_num_chips, pnv_set_num_chips,
> @@ -1083,15 +1079,15 @@ static void powernv_machine_class_props_init(Obje=
ctClass *oc)
>                                NULL);
>  }
> =20
> -static void powernv_machine_class_init(ObjectClass *oc, void *data)
> +static void pnv_machine_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
>      XICSFabricClass *xic =3D XICS_FABRIC_CLASS(oc);
>      InterruptStatsProviderClass *ispc =3D INTERRUPT_STATS_PROVIDER_CLASS=
(oc);
> =20
>      mc->desc =3D "IBM PowerNV (Non-Virtualized)";
> -    mc->init =3D ppc_powernv_init;
> -    mc->reset =3D ppc_powernv_reset;
> +    mc->init =3D pnv_init;
> +    mc->reset =3D pnv_reset;
>      mc->max_cpus =3D MAX_CPUS;
>      mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8_v2.0");
>      mc->block_default_type =3D IF_IDE; /* Pnv provides a AHCI device for
> @@ -1104,7 +1100,7 @@ static void powernv_machine_class_init(ObjectClass =
*oc, void *data)
>      xic->ics_resend =3D pnv_ics_resend;
>      ispc->print_info =3D pnv_pic_print_info;
> =20
> -    powernv_machine_class_props_init(oc);
> +    pnv_machine_class_props_init(oc);
>  }
> =20
>  #define DEFINE_PNV_CHIP_TYPE(type, class_initfn) \
> @@ -1116,11 +1112,11 @@ static void powernv_machine_class_init(ObjectClas=
s *oc, void *data)
> =20
>  static const TypeInfo types[] =3D {
>      {
> -        .name          =3D TYPE_POWERNV_MACHINE,
> +        .name          =3D TYPE_PNV_MACHINE,
>          .parent        =3D TYPE_MACHINE,
>          .instance_size =3D sizeof(PnvMachineState),
> -        .instance_init =3D powernv_machine_initfn,
> -        .class_init    =3D powernv_machine_class_init,
> +        .instance_init =3D pnv_machine_initfn,
> +        .class_init    =3D pnv_machine_class_init,
>          .interfaces =3D (InterfaceInfo[]) {
>              { TYPE_XICS_FABRIC },
>              { TYPE_INTERRUPT_STATS_PROVIDER },
> diff --git a/hw/ppc/pnv_bmc.c b/hw/ppc/pnv_bmc.c
> index 7b60b4c36071..b2cf441ee7b2 100644
> --- a/hw/ppc/pnv_bmc.c
> +++ b/hw/ppc/pnv_bmc.c
> @@ -73,7 +73,7 @@ void pnv_bmc_powerdown(IPMIBmc *bmc)
>      pnv_gen_oem_sel(bmc, SOFT_OFF);
>  }
> =20
> -void pnv_bmc_populate_sensors(IPMIBmc *bmc, void *fdt)
> +void pnv_dt_bmc_sensors(IPMIBmc *bmc, void *fdt)
>  {
>      int offset;
>      int i;
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 82ff440b3334..78eeadbbb6a4 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -37,7 +37,7 @@ static const char *pnv_core_cpu_typename(PnvCore *pc)
>      return cpu_type;
>  }
> =20
> -static void powernv_cpu_reset(void *opaque)
> +static void pnv_cpu_reset(void *opaque)
>  {
>      PowerPCCPU *cpu =3D opaque;
>      CPUState *cs =3D CPU(cpu);
> @@ -54,7 +54,7 @@ static void powernv_cpu_reset(void *opaque)
>      env->msr |=3D MSR_HVB; /* Hypervisor mode */
>  }
> =20
> -static void powernv_cpu_init(PowerPCCPU *cpu, Error **errp)
> +static void pnv_cpu_init(PowerPCCPU *cpu, Error **errp)
>  {
>      CPUPPCState *env =3D &cpu->env;
>      int core_pir;
> @@ -73,7 +73,7 @@ static void powernv_cpu_init(PowerPCCPU *cpu, Error **e=
rrp)
>      /* Set time-base frequency to 512 MHz */
>      cpu_ppc_tb_init(env, PNV_TIMEBASE_FREQ);
> =20
> -    qemu_register_reset(powernv_cpu_reset, cpu);
> +    qemu_register_reset(pnv_cpu_reset, cpu);
>  }
> =20
>  /*
> @@ -146,7 +146,7 @@ static void pnv_core_realize_child(Object *child, XIC=
SFabric *xi, Error **errp)
>          return;
>      }
> =20
> -    powernv_cpu_init(cpu, &local_err);
> +    pnv_cpu_init(cpu, &local_err);
>      if (local_err) {
>          object_unparent(obj);
>          error_propagate(errp, local_err);
> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
> index f03a80a29bf6..b777b78e1837 100644
> --- a/hw/ppc/pnv_lpc.c
> +++ b/hw/ppc/pnv_lpc.c
> @@ -92,7 +92,7 @@ enum {
>  #define LPC_HC_REGS_OPB_SIZE    0x00001000
> =20
> =20
> -static int pnv_lpc_populate(PnvXScomInterface *dev, void *fdt, int xscom=
_offset)
> +static int pnv_lpc_dt_xscom(PnvXScomInterface *dev, void *fdt, int xscom=
_offset)
>  {
>      const char compat[] =3D "ibm,power8-lpc\0ibm,lpc";
>      char *name;
> @@ -482,7 +482,7 @@ static void pnv_lpc_class_init(ObjectClass *klass, vo=
id *data)
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>      PnvXScomInterfaceClass *xdc =3D PNV_XSCOM_INTERFACE_CLASS(klass);
> =20
> -    xdc->populate =3D pnv_lpc_populate;
> +    xdc->dt_xscom =3D pnv_lpc_dt_xscom;
> =20
>      dc->realize =3D pnv_lpc_realize;
>  }
> @@ -515,7 +515,7 @@ type_init(pnv_lpc_register_types)
>   */
>  static void pnv_lpc_isa_irq_handler_cpld(void *opaque, int n, int level)
>  {
> -    PnvMachineState *pnv =3D POWERNV_MACHINE(qdev_get_machine());
> +    PnvMachineState *pnv =3D PNV_MACHINE(qdev_get_machine());
>      uint32_t old_state =3D pnv->cpld_irqstate;
>      PnvLpcController *lpc =3D PNV_LPC(opaque);
> =20
> diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
> index 9876c266223d..5b969127c303 100644
> --- a/hw/ppc/pnv_psi.c
> +++ b/hw/ppc/pnv_psi.c
> @@ -510,7 +510,7 @@ static void pnv_psi_realize(DeviceState *dev, Error *=
*errp)
>      }
>  }
> =20
> -static int pnv_psi_populate(PnvXScomInterface *dev, void *fdt, int xscom=
_offset)
> +static int pnv_psi_dt_xscom(PnvXScomInterface *dev, void *fdt, int xscom=
_offset)
>  {
>      const char compat[] =3D "ibm,power8-psihb-x\0ibm,psihb-x";
>      char *name;
> @@ -546,7 +546,7 @@ static void pnv_psi_class_init(ObjectClass *klass, vo=
id *data)
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>      PnvXScomInterfaceClass *xdc =3D PNV_XSCOM_INTERFACE_CLASS(klass);
> =20
> -    xdc->populate =3D pnv_psi_populate;
> +    xdc->dt_xscom =3D pnv_psi_dt_xscom;
> =20
>      dc->realize =3D pnv_psi_realize;
>      dc->props =3D pnv_psi_properties;
> diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
> index 38bc85f117f6..e51d634f4062 100644
> --- a/hw/ppc/pnv_xscom.c
> +++ b/hw/ppc/pnv_xscom.c
> @@ -207,15 +207,15 @@ typedef struct ForeachPopulateArgs {
>      int xscom_offset;
>  } ForeachPopulateArgs;
> =20
> -static int xscom_populate_child(Object *child, void *opaque)
> +static int xscom_dt_child(Object *child, void *opaque)
>  {
>      if (object_dynamic_cast(child, TYPE_PNV_XSCOM_INTERFACE)) {
>          ForeachPopulateArgs *args =3D opaque;
>          PnvXScomInterface *xd =3D PNV_XSCOM_INTERFACE(child);
>          PnvXScomInterfaceClass *xc =3D PNV_XSCOM_INTERFACE_GET_CLASS(xd);
> =20
> -        if (xc->populate) {
> -            _FDT((xc->populate(xd, args->fdt, args->xscom_offset)));
> +        if (xc->dt_xscom) {
> +            _FDT((xc->dt_xscom(xd, args->fdt, args->xscom_offset)));
>          }
>      }
>      return 0;
> @@ -224,7 +224,7 @@ static int xscom_populate_child(Object *child, void *=
opaque)
>  static const char compat_p8[] =3D "ibm,power8-xscom\0ibm,xscom";
>  static const char compat_p9[] =3D "ibm,power9-xscom\0ibm,xscom";
> =20
> -int pnv_xscom_populate(PnvChip *chip, void *fdt, int root_offset)
> +int pnv_dt_xscom(PnvChip *chip, void *fdt, int root_offset)
>  {
>      uint64_t reg[] =3D { cpu_to_be64(PNV_XSCOM_BASE(chip)),
>                         cpu_to_be64(PNV_XSCOM_SIZE) };
> @@ -255,7 +255,7 @@ int pnv_xscom_populate(PnvChip *chip, void *fdt, int =
root_offset)
>      args.fdt =3D fdt;
>      args.xscom_offset =3D xscom_offset;
> =20
> -    object_child_foreach(OBJECT(chip), xscom_populate_child, &args);
> +    object_child_foreach(OBJECT(chip), xscom_dt_child, &args);
>      return 0;
>  }
> =20
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index 59524cd42b61..61896f9fd767 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -26,7 +26,7 @@
>  #include "hw/ppc/pnv_psi.h"
>  #include "hw/ppc/pnv_occ.h"
> =20
> -#define TYPE_PNV_CHIP "powernv-chip"
> +#define TYPE_PNV_CHIP "pnv-chip"
>  #define PNV_CHIP(obj) OBJECT_CHECK(PnvChip, (obj), TYPE_PNV_CHIP)
>  #define PNV_CHIP_CLASS(klass) \
>       OBJECT_CLASS_CHECK(PnvChipClass, (klass), TYPE_PNV_CHIP)
> @@ -117,9 +117,9 @@ typedef struct PnvChipClass {
>  #define PNV_CHIP_INDEX(chip)                                    \
>      (((chip)->chip_id >> 2) * 2 + ((chip)->chip_id & 0x3))
> =20
> -#define TYPE_POWERNV_MACHINE       MACHINE_TYPE_NAME("powernv")
> -#define POWERNV_MACHINE(obj) \
> -    OBJECT_CHECK(PnvMachineState, (obj), TYPE_POWERNV_MACHINE)
> +#define TYPE_PNV_MACHINE       MACHINE_TYPE_NAME("powernv")
> +#define PNV_MACHINE(obj) \
> +    OBJECT_CHECK(PnvMachineState, (obj), TYPE_PNV_MACHINE)
> =20
>  typedef struct PnvMachineState {
>      /*< private >*/
> @@ -144,7 +144,7 @@ typedef struct PnvMachineState {
>  /*
>   * BMC helpers
>   */
> -void pnv_bmc_populate_sensors(IPMIBmc *bmc, void *fdt);
> +void pnv_dt_bmc_sensors(IPMIBmc *bmc, void *fdt);
>  void pnv_bmc_powerdown(IPMIBmc *bmc);
> =20
>  /*
> diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
> index 38077b479699..7252e219e249 100644
> --- a/include/hw/ppc/pnv_xscom.h
> +++ b/include/hw/ppc/pnv_xscom.h
> @@ -36,7 +36,7 @@ typedef struct PnvXScomInterface {
> =20
>  typedef struct PnvXScomInterfaceClass {
>      InterfaceClass parent;
> -    int (*populate)(PnvXScomInterface *dev, void *fdt, int offset);
> +    int (*dt_xscom)(PnvXScomInterface *dev, void *fdt, int offset);
>  } PnvXScomInterfaceClass;
> =20
>  /*
> @@ -67,7 +67,7 @@ typedef struct PnvXScomInterfaceClass {
>  #define PNV_XSCOM_OCC_SIZE        0x6000
> =20
>  extern void pnv_xscom_realize(PnvChip *chip, Error **errp);
> -extern int pnv_xscom_populate(PnvChip *chip, void *fdt, int offset);
> +extern int pnv_dt_xscom(PnvChip *chip, void *fdt, int offset);
> =20
>  extern void pnv_xscom_add_subregion(PnvChip *chip, hwaddr offset,
>                                      MemoryRegion *mr);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VjP/dwTbBl6I9PQk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlo3QuAACgkQbDjKyiDZ
s5Lw1RAAyyg+V+YSFMTdvb/p2LNlUin53DSiQApmERmvetR00E1dKHmgHwOTFtim
tpTTUZcBEpmGYj9764m9OWAXiSqAMfBuIYSq5iW/M9mowT9ZgRcbomMZLjVb0wuy
N6b4E2vrqI7OUs1EfQU+/F4qVa43vUCJTOs2/3mbjpAmmSl1X1NQ9fi4845Hq/lT
icqkxaxwH9188b/VQKYw+UZsSAKzmIEH/TBnrUqkjI1Ar3aVbQjLWUlhbereZKmb
O1gqcf86wkIKN62WMEN/Tz/lMxvKhHKtkXvb0Fi2OyqjPSf2b46RTfiaMmodX1ME
1NA6zHg67et/4tjwgICC3JjbY7dyE1frIIwDSs9yBuwKqNkXRHdf2/GaS3Uk9W8Y
6KqPF2WtO56B7uIt2qdDPD413Vt91lm0urrIftL7yCuqzCQg4JIKexsI1Tktb4cF
AgoXWi3fqc/L7+FPq0fV5YeN+l0UIEAiIv3rLXhlec9+VGSgF7RY7G8DajxeF4O1
LcpCl7YxwVYhiotuDgRbqMr4iiSMTxJg+xyTctKPendiqc0pRAfIU7XcENZkJUP1
e4SZvPl1Ng2WZvZwLBIOKGaKSZdWBWJaciju/6wpGR7r+KYWozd8mfx1G37NcywC
CbVdZeqV875Iw8DI6zsAL4nIoSIdyQo+4Lhm7D/9exavdTXlZFc=
=sGln
-----END PGP SIGNATURE-----

--VjP/dwTbBl6I9PQk--
