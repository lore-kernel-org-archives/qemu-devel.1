Received: from eggs.gnu.org ([2001:4830:134:3::10]:38552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f8l7i-00059p-B6
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 07:19:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f8l7f-0005sk-EQ
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 07:19:38 -0400
Date: Wed, 18 Apr 2018 19:38:47 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180418093847.GH2317@umbus.fritz.box>
References: <20180417011549.GF20551@umbus.fritz.box>
	<1523982845-249379-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CEUtFxTsmBsHRLs3"
Content-Disposition: inline
In-Reply-To: <1523982845-249379-1-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ppc: e500: switch E500 based machines to
 full machine definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, "open list:e500" <qemu-ppc@nongnu.org>


--CEUtFxTsmBsHRLs3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 17, 2018 at 06:34:05PM +0200, Igor Mammedov wrote:
> Convert PPCE500Params to PCCE500MachineClass which it essentially is,
> and introduce PCCE500MachineState to keep track of E500 specific
> state instead of adding global variables or extra parameters to
> functions when we need to keep data beyond machine init
> (i.e. make it look like typical fully defined machine).
>=20
> It's pretty shallow conversion instead of currently used trivial
> DEFINE_MACHINE() macro. It adds extra 60LOC of boilerplate code
> of full machine definition.
>=20
> The patch on top[1] will use PCCE500MachineState to keep track of
> platform_bus device and add E500Plate specific machine class
> to use HOTPLUG_HANDLER for explicitly initializing dynamic
> sysbus devices at the time they are added instead of delaying
> it to machine done time by platform_bus_init_notify() which is
> being removed.
>=20
>  1)  <1523551221-11612-3-git-send-email-imammedo@redhat.com>
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Suggested-by: David Gibson <david@gibson.dropbear.id.au>

Applied to ppc-for-2.13, thanks.

> ---
> tested only with make check.
>=20
> CC: Alexander Graf <agraf@suse.de> (supporter:e500)
> CC: David Gibson <david@gibson.dropbear.id.au> (maintainer:PowerPC)
> CC: qemu-ppc@nongnu.org (open list:e500)
> ---
>  hw/ppc/e500.h      |  29 ++++++++++---
>  hw/ppc/e500.c      | 119 ++++++++++++++++++++++++++++-------------------=
------
>  hw/ppc/e500plat.c  |  64 +++++++++++++++++-----------
>  hw/ppc/mpc8544ds.c |  47 +++++++++++++--------
>  4 files changed, 156 insertions(+), 103 deletions(-)
>=20
> diff --git a/hw/ppc/e500.h b/hw/ppc/e500.h
> index 70ba1d8..621403b 100644
> --- a/hw/ppc/e500.h
> +++ b/hw/ppc/e500.h
> @@ -3,12 +3,21 @@
> =20
>  #include "hw/boards.h"
> =20
> -typedef struct PPCE500Params {
> -    int pci_first_slot;
> -    int pci_nr_slots;
> +typedef struct PPCE500MachineState {
> +    /*< private >*/
> +    MachineState parent_obj;
> +
> +} PPCE500MachineState;
> +
> +typedef struct PPCE500MachineClass {
> +    /*< private >*/
> +    MachineClass parent_class;
> =20
>      /* required -- must at least add toplevel board compatible */
> -    void (*fixup_devtree)(struct PPCE500Params *params, void *fdt);
> +    void (*fixup_devtree)(void *fdt);
> +
> +    int pci_first_slot;
> +    int pci_nr_slots;
> =20
>      int mpic_version;
>      bool has_mpc8xxx_gpio;
> @@ -22,10 +31,18 @@ typedef struct PPCE500Params {
>      hwaddr pci_mmio_base;
>      hwaddr pci_mmio_bus_base;
>      hwaddr spin_base;
> -} PPCE500Params;
> +} PPCE500MachineClass;
> =20
> -void ppce500_init(MachineState *machine, PPCE500Params *params);
> +void ppce500_init(MachineState *machine);
> =20
>  hwaddr booke206_page_size_to_tlb(uint64_t size);
> =20
> +#define TYPE_PPCE500_MACHINE      "ppce500-base-machine"
> +#define PPCE500_MACHINE(obj) \
> +    OBJECT_CHECK(PPCE500MachineState, (obj), TYPE_PPCE500_MACHINE)
> +#define PPCE500_MACHINE_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(PPCE500MachineClass, obj, TYPE_PPCE500_MACHINE)
> +#define PPCE500_MACHINE_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(PPCE500MachineClass, klass, TYPE_PPCE500_MACHINE)
> +
>  #endif
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 9a85a41..30b42a8 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -221,14 +221,14 @@ static void sysbus_device_create_devtree(SysBusDevi=
ce *sbdev, void *opaque)
>      }
>  }
> =20
> -static void platform_bus_create_devtree(PPCE500Params *params, void *fdt,
> -                                        const char *mpic)
> +static void platform_bus_create_devtree(const PPCE500MachineClass *pmc,
> +                                        void *fdt, const char *mpic)
>  {
> -    gchar *node =3D g_strdup_printf("/platform@%"PRIx64, params->platfor=
m_bus_base);
> +    gchar *node =3D g_strdup_printf("/platform@%"PRIx64, pmc->platform_b=
us_base);
>      const char platcomp[] =3D "qemu,platform\0simple-bus";
> -    uint64_t addr =3D params->platform_bus_base;
> -    uint64_t size =3D params->platform_bus_size;
> -    int irq_start =3D params->platform_bus_first_irq;
> +    uint64_t addr =3D pmc->platform_bus_base;
> +    uint64_t size =3D pmc->platform_bus_size;
> +    int irq_start =3D pmc->platform_bus_first_irq;
>      PlatformBusDevice *pbus;
>      DeviceState *dev;
> =20
> @@ -265,8 +265,7 @@ static void platform_bus_create_devtree(PPCE500Params=
 *params, void *fdt,
>      g_free(node);
>  }
> =20
> -static int ppce500_load_device_tree(MachineState *machine,
> -                                    PPCE500Params *params,
> +static int ppce500_load_device_tree(PPCE500MachineState *pms,
>                                      hwaddr addr,
>                                      hwaddr initrd_base,
>                                      hwaddr initrd_size,
> @@ -274,6 +273,8 @@ static int ppce500_load_device_tree(MachineState *mac=
hine,
>                                      hwaddr kernel_size,
>                                      bool dry_run)
>  {
> +    MachineState *machine =3D MACHINE(pms);
> +    const PPCE500MachineClass *pmc =3D PPCE500_MACHINE_GET_CLASS(pms);
>      CPUPPCState *env =3D first_cpu->env_ptr;
>      int ret =3D -1;
>      uint64_t mem_reg_property[] =3D { 0, cpu_to_be64(machine->ram_size) =
};
> @@ -295,12 +296,12 @@ static int ppce500_load_device_tree(MachineState *m=
achine,
>      int len;
>      uint32_t pci_ranges[14] =3D
>          {
> -            0x2000000, 0x0, params->pci_mmio_bus_base,
> -            params->pci_mmio_base >> 32, params->pci_mmio_base,
> +            0x2000000, 0x0, pmc->pci_mmio_bus_base,
> +            pmc->pci_mmio_base >> 32, pmc->pci_mmio_base,
>              0x0, 0x20000000,
> =20
>              0x1000000, 0x0, 0x0,
> -            params->pci_pio_base >> 32, params->pci_pio_base,
> +            pmc->pci_pio_base >> 32, pmc->pci_pio_base,
>              0x0, 0x10000,
>          };
>      QemuOpts *machine_opts =3D qemu_get_machine_opts();
> @@ -391,7 +392,7 @@ static int ppce500_load_device_tree(MachineState *mac=
hine,
>      for (i =3D smp_cpus - 1; i >=3D 0; i--) {
>          CPUState *cpu;
>          char cpu_name[128];
> -        uint64_t cpu_release_addr =3D params->spin_base + (i * 0x20);
> +        uint64_t cpu_release_addr =3D pmc->spin_base + (i * 0x20);
> =20
>          cpu =3D qemu_get_cpu(i);
>          if (cpu =3D=3D NULL) {
> @@ -425,7 +426,7 @@ static int ppce500_load_device_tree(MachineState *mac=
hine,
> =20
>      qemu_fdt_add_subnode(fdt, "/aliases");
>      /* XXX These should go into their respective devices' code */
> -    snprintf(soc, sizeof(soc), "/soc@%"PRIx64, params->ccsrbar_base);
> +    snprintf(soc, sizeof(soc), "/soc@%"PRIx64, pmc->ccsrbar_base);
>      qemu_fdt_add_subnode(fdt, soc);
>      qemu_fdt_setprop_string(fdt, soc, "device_type", "soc");
>      qemu_fdt_setprop(fdt, soc, "compatible", compatible_sb,
> @@ -433,7 +434,7 @@ static int ppce500_load_device_tree(MachineState *mac=
hine,
>      qemu_fdt_setprop_cell(fdt, soc, "#address-cells", 1);
>      qemu_fdt_setprop_cell(fdt, soc, "#size-cells", 1);
>      qemu_fdt_setprop_cells(fdt, soc, "ranges", 0x0,
> -                           params->ccsrbar_base >> 32, params->ccsrbar_b=
ase,
> +                           pmc->ccsrbar_base >> 32, pmc->ccsrbar_base,
>                             MPC8544_CCSRBAR_SIZE);
>      /* XXX should contain a reasonable value */
>      qemu_fdt_setprop_cell(fdt, soc, "bus-frequency", 0);
> @@ -493,7 +494,7 @@ static int ppce500_load_device_tree(MachineState *mac=
hine,
>      qemu_fdt_setprop_cell(fdt, msi, "linux,phandle", msi_ph);
> =20
>      snprintf(pci, sizeof(pci), "/pci@%llx",
> -             params->ccsrbar_base + MPC8544_PCI_REGS_OFFSET);
> +             pmc->ccsrbar_base + MPC8544_PCI_REGS_OFFSET);
>      qemu_fdt_add_subnode(fdt, pci);
>      qemu_fdt_setprop_cell(fdt, pci, "cell-index", 0);
>      qemu_fdt_setprop_string(fdt, pci, "compatible", "fsl,mpc8540-pci");
> @@ -501,7 +502,7 @@ static int ppce500_load_device_tree(MachineState *mac=
hine,
>      qemu_fdt_setprop_cells(fdt, pci, "interrupt-map-mask", 0xf800, 0x0,
>                             0x0, 0x7);
>      pci_map =3D pci_map_create(fdt, qemu_fdt_get_phandle(fdt, mpic),
> -                             params->pci_first_slot, params->pci_nr_slot=
s,
> +                             pmc->pci_first_slot, pmc->pci_nr_slots,
>                               &len);
>      qemu_fdt_setprop(fdt, pci, "interrupt-map", pci_map, len);
>      qemu_fdt_setprop_phandle(fdt, pci, "interrupt-parent", mpic);
> @@ -513,8 +514,8 @@ static int ppce500_load_device_tree(MachineState *mac=
hine,
>      qemu_fdt_setprop_cell(fdt, pci, "fsl,msi", msi_ph);
>      qemu_fdt_setprop(fdt, pci, "ranges", pci_ranges, sizeof(pci_ranges));
>      qemu_fdt_setprop_cells(fdt, pci, "reg",
> -                           (params->ccsrbar_base + MPC8544_PCI_REGS_OFFS=
ET) >> 32,
> -                           (params->ccsrbar_base + MPC8544_PCI_REGS_OFFS=
ET),
> +                           (pmc->ccsrbar_base + MPC8544_PCI_REGS_OFFSET)=
 >> 32,
> +                           (pmc->ccsrbar_base + MPC8544_PCI_REGS_OFFSET),
>                             0, 0x1000);
>      qemu_fdt_setprop_cell(fdt, pci, "clock-frequency", 66666666);
>      qemu_fdt_setprop_cell(fdt, pci, "#interrupt-cells", 1);
> @@ -522,15 +523,15 @@ static int ppce500_load_device_tree(MachineState *m=
achine,
>      qemu_fdt_setprop_cell(fdt, pci, "#address-cells", 3);
>      qemu_fdt_setprop_string(fdt, "/aliases", "pci0", pci);
> =20
> -    if (params->has_mpc8xxx_gpio) {
> +    if (pmc->has_mpc8xxx_gpio) {
>          create_dt_mpc8xxx_gpio(fdt, soc, mpic);
>      }
> =20
> -    if (params->has_platform_bus) {
> -        platform_bus_create_devtree(params, fdt, mpic);
> +    if (pmc->has_platform_bus) {
> +        platform_bus_create_devtree(pmc, fdt, mpic);
>      }
> =20
> -    params->fixup_devtree(params, fdt);
> +    pmc->fixup_devtree(fdt);
> =20
>      if (toplevel_compat) {
>          qemu_fdt_setprop(fdt, "/", "compatible", toplevel_compat,
> @@ -551,8 +552,7 @@ out:
>  }
> =20
>  typedef struct DeviceTreeParams {
> -    MachineState *machine;
> -    PPCE500Params params;
> +    PPCE500MachineState *machine;
>      hwaddr addr;
>      hwaddr initrd_base;
>      hwaddr initrd_size;
> @@ -564,7 +564,7 @@ typedef struct DeviceTreeParams {
>  static void ppce500_reset_device_tree(void *opaque)
>  {
>      DeviceTreeParams *p =3D opaque;
> -    ppce500_load_device_tree(p->machine, &p->params, p->addr, p->initrd_=
base,
> +    ppce500_load_device_tree(p->machine, p->addr, p->initrd_base,
>                               p->initrd_size, p->kernel_base, p->kernel_s=
ize,
>                               false);
>  }
> @@ -575,8 +575,7 @@ static void ppce500_init_notify(Notifier *notifier, v=
oid *data)
>      ppce500_reset_device_tree(p);
>  }
> =20
> -static int ppce500_prep_device_tree(MachineState *machine,
> -                                    PPCE500Params *params,
> +static int ppce500_prep_device_tree(PPCE500MachineState *machine,
>                                      hwaddr addr,
>                                      hwaddr initrd_base,
>                                      hwaddr initrd_size,
> @@ -585,7 +584,6 @@ static int ppce500_prep_device_tree(MachineState *mac=
hine,
>  {
>      DeviceTreeParams *p =3D g_new(DeviceTreeParams, 1);
>      p->machine =3D machine;
> -    p->params =3D *params;
>      p->addr =3D addr;
>      p->initrd_base =3D initrd_base;
>      p->initrd_size =3D initrd_size;
> @@ -597,9 +595,8 @@ static int ppce500_prep_device_tree(MachineState *mac=
hine,
>      qemu_add_machine_init_done_notifier(&p->notifier);
> =20
>      /* Issue the device tree loader once, so that we get the size of the=
 blob */
> -    return ppce500_load_device_tree(machine, params, addr, initrd_base,
> -                                    initrd_size, kernel_base, kernel_siz=
e,
> -                                    true);
> +    return ppce500_load_device_tree(machine, addr, initrd_base, initrd_s=
ize,
> +                                    kernel_base, kernel_size, true);
>  }
> =20
>  /* Create -kernel TLB entries for BookE.  */
> @@ -685,17 +682,19 @@ static void ppce500_cpu_reset(void *opaque)
>      mmubooke_create_initial_mapping(env);
>  }
> =20
> -static DeviceState *ppce500_init_mpic_qemu(PPCE500Params *params,
> +static DeviceState *ppce500_init_mpic_qemu(PPCE500MachineState *pms,
>                                             qemu_irq **irqs)
>  {
>      DeviceState *dev;
>      SysBusDevice *s;
>      int i, j, k;
> +    MachineState *machine =3D MACHINE(pms);
> +    const PPCE500MachineClass *pmc =3D PPCE500_MACHINE_GET_CLASS(pms);
> =20
>      dev =3D qdev_create(NULL, TYPE_OPENPIC);
> -    object_property_add_child(qdev_get_machine(), "pic", OBJECT(dev),
> +    object_property_add_child(OBJECT(machine), "pic", OBJECT(dev),
>                                &error_fatal);
> -    qdev_prop_set_uint32(dev, "model", params->mpic_version);
> +    qdev_prop_set_uint32(dev, "model", pmc->mpic_version);
>      qdev_prop_set_uint32(dev, "nb_cpus", smp_cpus);
> =20
>      qdev_init_nofail(dev);
> @@ -711,7 +710,7 @@ static DeviceState *ppce500_init_mpic_qemu(PPCE500Par=
ams *params,
>      return dev;
>  }
> =20
> -static DeviceState *ppce500_init_mpic_kvm(PPCE500Params *params,
> +static DeviceState *ppce500_init_mpic_kvm(const PPCE500MachineClass *pmc,
>                                            qemu_irq **irqs, Error **errp)
>  {
>      Error *err =3D NULL;
> @@ -719,7 +718,7 @@ static DeviceState *ppce500_init_mpic_kvm(PPCE500Para=
ms *params,
>      CPUState *cs;
> =20
>      dev =3D qdev_create(NULL, TYPE_KVM_OPENPIC);
> -    qdev_prop_set_uint32(dev, "model", params->mpic_version);
> +    qdev_prop_set_uint32(dev, "model", pmc->mpic_version);
> =20
>      object_property_set_bool(OBJECT(dev), true, "realized", &err);
>      if (err) {
> @@ -739,11 +738,12 @@ static DeviceState *ppce500_init_mpic_kvm(PPCE500Pa=
rams *params,
>      return dev;
>  }
> =20
> -static DeviceState *ppce500_init_mpic(MachineState *machine,
> -                                      PPCE500Params *params,
> +static DeviceState *ppce500_init_mpic(PPCE500MachineState *pms,
>                                        MemoryRegion *ccsr,
>                                        qemu_irq **irqs)
>  {
> +    MachineState *machine =3D MACHINE(pms);
> +    const PPCE500MachineClass *pmc =3D PPCE500_MACHINE_GET_CLASS(pms);
>      DeviceState *dev =3D NULL;
>      SysBusDevice *s;
> =20
> @@ -751,7 +751,7 @@ static DeviceState *ppce500_init_mpic(MachineState *m=
achine,
>          Error *err =3D NULL;
> =20
>          if (machine_kernel_irqchip_allowed(machine)) {
> -            dev =3D ppce500_init_mpic_kvm(params, irqs, &err);
> +            dev =3D ppce500_init_mpic_kvm(pmc, irqs, &err);
>          }
>          if (machine_kernel_irqchip_required(machine) && !dev) {
>              error_reportf_err(err,
> @@ -761,7 +761,7 @@ static DeviceState *ppce500_init_mpic(MachineState *m=
achine,
>      }
> =20
>      if (!dev) {
> -        dev =3D ppce500_init_mpic_qemu(params, irqs);
> +        dev =3D ppce500_init_mpic_qemu(pms, irqs);
>      }
> =20
>      s =3D SYS_BUS_DEVICE(dev);
> @@ -778,10 +778,12 @@ static void ppce500_power_off(void *opaque, int lin=
e, int on)
>      }
>  }
> =20
> -void ppce500_init(MachineState *machine, PPCE500Params *params)
> +void ppce500_init(MachineState *machine)
>  {
>      MemoryRegion *address_space_mem =3D get_system_memory();
>      MemoryRegion *ram =3D g_new(MemoryRegion, 1);
> +    PPCE500MachineState *pms =3D PPCE500_MACHINE(machine);
> +    const PPCE500MachineClass *pmc =3D PPCE500_MACHINE_GET_CLASS(machine=
);
>      PCIBus *pci_bus;
>      CPUPPCState *env =3D NULL;
>      uint64_t loadaddr;
> @@ -835,8 +837,7 @@ void ppce500_init(MachineState *machine, PPCE500Param=
s *params)
>          irqs[i][OPENPIC_OUTPUT_INT] =3D input[PPCE500_INPUT_INT];
>          irqs[i][OPENPIC_OUTPUT_CINT] =3D input[PPCE500_INPUT_CINT];
>          env->spr_cb[SPR_BOOKE_PIR].default_value =3D cs->cpu_index =3D i;
> -        env->mpic_iack =3D params->ccsrbar_base +
> -                         MPC8544_MPIC_REGS_OFFSET + 0xa0;
> +        env->mpic_iack =3D pmc->ccsrbar_base + MPC8544_MPIC_REGS_OFFSET =
+ 0xa0;
> =20
>          ppc_booke_timers_init(cpu, 400000000, PPC_TIMER_E500);
> =20
> @@ -869,10 +870,10 @@ void ppce500_init(MachineState *machine, PPCE500Par=
ams *params)
>      qdev_init_nofail(dev);
>      ccsr =3D CCSR(dev);
>      ccsr_addr_space =3D &ccsr->ccsr_space;
> -    memory_region_add_subregion(address_space_mem, params->ccsrbar_base,
> +    memory_region_add_subregion(address_space_mem, pmc->ccsrbar_base,
>                                  ccsr_addr_space);
> =20
> -    mpicdev =3D ppce500_init_mpic(machine, params, ccsr_addr_space, irqs=
);
> +    mpicdev =3D ppce500_init_mpic(pms, ccsr_addr_space, irqs);
> =20
>      /* Serial */
>      if (serial_hds[0]) {
> @@ -898,7 +899,7 @@ void ppce500_init(MachineState *machine, PPCE500Param=
s *params)
>      dev =3D qdev_create(NULL, "e500-pcihost");
>      object_property_add_child(qdev_get_machine(), "pci-host", OBJECT(dev=
),
>                                &error_abort);
> -    qdev_prop_set_uint32(dev, "first_slot", params->pci_first_slot);
> +    qdev_prop_set_uint32(dev, "first_slot", pmc->pci_first_slot);
>      qdev_prop_set_uint32(dev, "first_pin_irq", pci_irq_nrs[0]);
>      qdev_init_nofail(dev);
>      s =3D SYS_BUS_DEVICE(dev);
> @@ -921,9 +922,9 @@ void ppce500_init(MachineState *machine, PPCE500Param=
s *params)
>      }
> =20
>      /* Register spinning region */
> -    sysbus_create_simple("e500-spin", params->spin_base, NULL);
> +    sysbus_create_simple("e500-spin", pmc->spin_base, NULL);
> =20
> -    if (params->has_mpc8xxx_gpio) {
> +    if (pmc->has_mpc8xxx_gpio) {
>          qemu_irq poweroff_irq;
> =20
>          dev =3D qdev_create(NULL, "mpc8xxx_gpio");
> @@ -939,21 +940,21 @@ void ppce500_init(MachineState *machine, PPCE500Par=
ams *params)
>      }
> =20
>      /* Platform Bus Device */
> -    if (params->has_platform_bus) {
> +    if (pmc->has_platform_bus) {
>          dev =3D qdev_create(NULL, TYPE_PLATFORM_BUS_DEVICE);
>          dev->id =3D TYPE_PLATFORM_BUS_DEVICE;
> -        qdev_prop_set_uint32(dev, "num_irqs", params->platform_bus_num_i=
rqs);
> -        qdev_prop_set_uint32(dev, "mmio_size", params->platform_bus_size=
);
> +        qdev_prop_set_uint32(dev, "num_irqs", pmc->platform_bus_num_irqs=
);
> +        qdev_prop_set_uint32(dev, "mmio_size", pmc->platform_bus_size);
>          qdev_init_nofail(dev);
>          s =3D SYS_BUS_DEVICE(dev);
> =20
> -        for (i =3D 0; i < params->platform_bus_num_irqs; i++) {
> -            int irqn =3D params->platform_bus_first_irq + i;
> +        for (i =3D 0; i < pmc->platform_bus_num_irqs; i++) {
> +            int irqn =3D pmc->platform_bus_first_irq + i;
>              sysbus_connect_irq(s, i, qdev_get_gpio_in(mpicdev, irqn));
>          }
> =20
>          memory_region_add_subregion(address_space_mem,
> -                                    params->platform_bus_base,
> +                                    pmc->platform_bus_base,
>                                      sysbus_mmio_get_region(s, 0));
>      }
> =20
> @@ -1056,7 +1057,7 @@ void ppce500_init(MachineState *machine, PPCE500Par=
ams *params)
>              exit(1);
>      }
> =20
> -    dt_size =3D ppce500_prep_device_tree(machine, params, dt_base,
> +    dt_size =3D ppce500_prep_device_tree(pms, dt_base,
>                                         initrd_base, initrd_size,
>                                         kernel_base, kernel_size);
>      if (dt_size < 0) {
> @@ -1085,9 +1086,17 @@ static const TypeInfo e500_ccsr_info =3D {
>      .instance_init =3D e500_ccsr_initfn,
>  };
> =20
> +static const TypeInfo ppce500_info =3D {
> +    .name          =3D TYPE_PPCE500_MACHINE,
> +    .parent        =3D TYPE_MACHINE,
> +    .abstract      =3D true,
> +    .class_size    =3D sizeof(PPCE500MachineClass),
> +};
> +
>  static void e500_register_types(void)
>  {
>      type_register_static(&e500_ccsr_info);
> +    type_register_static(&ppce500_info);
>  }
> =20
>  type_init(e500_register_types)
> diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
> index 81d03e1..f69aadb 100644
> --- a/hw/ppc/e500plat.c
> +++ b/hw/ppc/e500plat.c
> @@ -21,7 +21,7 @@
>  #include "hw/ppc/openpic.h"
>  #include "kvm_ppc.h"
> =20
> -static void e500plat_fixup_devtree(PPCE500Params *params, void *fdt)
> +static void e500plat_fixup_devtree(void *fdt)
>  {
>      const char model[] =3D "QEMU ppce500";
>      const char compatible[] =3D "fsl,qemu-e500";
> @@ -33,40 +33,54 @@ static void e500plat_fixup_devtree(PPCE500Params *par=
ams, void *fdt)
> =20
>  static void e500plat_init(MachineState *machine)
>  {
> -    PPCE500Params params =3D {
> -        .pci_first_slot =3D 0x1,
> -        .pci_nr_slots =3D PCI_SLOT_MAX - 1,
> -        .fixup_devtree =3D e500plat_fixup_devtree,
> -        .mpic_version =3D OPENPIC_MODEL_FSL_MPIC_42,
> -        .has_mpc8xxx_gpio =3D true,
> -        .has_platform_bus =3D true,
> -        .platform_bus_base =3D 0xf00000000ULL,
> -        .platform_bus_size =3D (128ULL * 1024 * 1024),
> -        .platform_bus_first_irq =3D 5,
> -        .platform_bus_num_irqs =3D 10,
> -        .ccsrbar_base =3D 0xFE0000000ULL,
> -        .pci_pio_base =3D 0xFE1000000ULL,
> -        .pci_mmio_base =3D 0xC00000000ULL,
> -        .pci_mmio_bus_base =3D 0xE0000000ULL,
> -        .spin_base =3D 0xFEF000000ULL,
> -    };
> -
> +    PPCE500MachineClass *pmc =3D PPCE500_MACHINE_GET_CLASS(machine);
>      /* Older KVM versions don't support EPR which breaks guests when we =
announce
>         MPIC variants that support EPR. Revert to an older one for those =
*/
>      if (kvm_enabled() && !kvmppc_has_cap_epr()) {
> -        params.mpic_version =3D OPENPIC_MODEL_FSL_MPIC_20;
> +        pmc->mpic_version =3D OPENPIC_MODEL_FSL_MPIC_20;
>      }
> =20
> -    ppce500_init(machine, &params);
> +    ppce500_init(machine);
>  }
> =20
> -static void e500plat_machine_init(MachineClass *mc)
> +#define TYPE_E500PLAT_MACHINE  MACHINE_TYPE_NAME("ppce500")
> +
> +static void e500plat_machine_class_init(ObjectClass *oc, void *data)
>  {
> +    PPCE500MachineClass *pmc =3D PPCE500_MACHINE_CLASS(oc);
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +
> +    pmc->pci_first_slot =3D 0x1;
> +    pmc->pci_nr_slots =3D PCI_SLOT_MAX - 1;
> +    pmc->fixup_devtree =3D e500plat_fixup_devtree;
> +    pmc->mpic_version =3D OPENPIC_MODEL_FSL_MPIC_42;
> +    pmc->has_mpc8xxx_gpio =3D true;
> +    pmc->has_platform_bus =3D true;
> +    pmc->platform_bus_base =3D 0xf00000000ULL;
> +    pmc->platform_bus_size =3D (128ULL * 1024 * 1024);
> +    pmc->platform_bus_first_irq =3D 5;
> +    pmc->platform_bus_num_irqs =3D 10;
> +    pmc->ccsrbar_base =3D 0xFE0000000ULL;
> +    pmc->pci_pio_base =3D 0xFE1000000ULL;
> +    pmc->pci_mmio_base =3D 0xC00000000ULL;
> +    pmc->pci_mmio_bus_base =3D 0xE0000000ULL;
> +    pmc->spin_base =3D 0xFEF000000ULL;
> +
>      mc->desc =3D "generic paravirt e500 platform";
>      mc->init =3D e500plat_init;
>      mc->max_cpus =3D 32;
> -    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_ETSEC_COMMON);
>      mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("e500v2_v30");
> -}
> +    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_ETSEC_COMMON);
> + }
> +
> +static const TypeInfo e500plat_info =3D {
> +    .name          =3D TYPE_E500PLAT_MACHINE,
> +    .parent        =3D TYPE_PPCE500_MACHINE,
> +    .class_init    =3D e500plat_machine_class_init,
> +};
> =20
> -DEFINE_MACHINE("ppce500", e500plat_machine_init)
> +static void e500plat_register_types(void)
> +{
> +    type_register_static(&e500plat_info);
> +}
> +type_init(e500plat_register_types)
> diff --git a/hw/ppc/mpc8544ds.c b/hw/ppc/mpc8544ds.c
> index 1717953..ab30a2a 100644
> --- a/hw/ppc/mpc8544ds.c
> +++ b/hw/ppc/mpc8544ds.c
> @@ -18,7 +18,7 @@
>  #include "qemu/error-report.h"
>  #include "cpu.h"
> =20
> -static void mpc8544ds_fixup_devtree(PPCE500Params *params, void *fdt)
> +static void mpc8544ds_fixup_devtree(void *fdt)
>  {
>      const char model[] =3D "MPC8544DS";
>      const char compatible[] =3D "MPC8544DS\0MPC85xxDS";
> @@ -30,33 +30,46 @@ static void mpc8544ds_fixup_devtree(PPCE500Params *pa=
rams, void *fdt)
> =20
>  static void mpc8544ds_init(MachineState *machine)
>  {
> -    PPCE500Params params =3D {
> -        .pci_first_slot =3D 0x11,
> -        .pci_nr_slots =3D 2,
> -        .fixup_devtree =3D mpc8544ds_fixup_devtree,
> -        .mpic_version =3D OPENPIC_MODEL_FSL_MPIC_20,
> -        .ccsrbar_base =3D 0xE0000000ULL,
> -        .pci_mmio_base =3D 0xC0000000ULL,
> -        .pci_mmio_bus_base =3D 0xC0000000ULL,
> -        .pci_pio_base =3D 0xE1000000ULL,
> -        .spin_base =3D 0xEF000000ULL,
> -    };
> -
>      if (machine->ram_size > 0xc0000000) {
>          error_report("The MPC8544DS board only supports up to 3GB of RAM=
");
>          exit(1);
>      }
> =20
> -    ppce500_init(machine, &params);
> +    ppce500_init(machine);
>  }
> =20
> -
> -static void ppce500_machine_init(MachineClass *mc)
> +static void e500plat_machine_class_init(ObjectClass *oc, void *data)
>  {
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +    PPCE500MachineClass *pmc =3D PPCE500_MACHINE_CLASS(oc);
> +
> +    pmc->pci_first_slot =3D 0x11;
> +    pmc->pci_nr_slots =3D 2;
> +    pmc->fixup_devtree =3D mpc8544ds_fixup_devtree;
> +    pmc->mpic_version =3D OPENPIC_MODEL_FSL_MPIC_20;
> +    pmc->ccsrbar_base =3D 0xE0000000ULL;
> +    pmc->pci_mmio_base =3D 0xC0000000ULL;
> +    pmc->pci_mmio_bus_base =3D 0xC0000000ULL;
> +    pmc->pci_pio_base =3D 0xE1000000ULL;
> +    pmc->spin_base =3D 0xEF000000ULL;
> +
>      mc->desc =3D "mpc8544ds";
>      mc->init =3D mpc8544ds_init;
>      mc->max_cpus =3D 15;
>      mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("e500v2_v30");
>  }
> =20
> -DEFINE_MACHINE("mpc8544ds", ppce500_machine_init)
> +#define TYPE_MPC8544DS_MACHINE  MACHINE_TYPE_NAME("mpc8544ds")
> +
> +static const TypeInfo mpc8544ds_info =3D {
> +    .name          =3D TYPE_MPC8544DS_MACHINE,
> +    .parent        =3D TYPE_PPCE500_MACHINE,
> +    .class_init    =3D e500plat_machine_class_init,
> +};
> +
> +static void mpc8544ds_register_types(void)
> +{
> +    type_register_static(&mpc8544ds_info);
> +}
> +
> +type_init(mpc8544ds_register_types)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--CEUtFxTsmBsHRLs3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrXEiQACgkQbDjKyiDZ
s5JxMA//Y3UWTzmFLi4msepl/e6Rf+mq2pHYAIIB95aPFVC2w6/zfkjw/TpaQBtB
AoMXrXd9DHCld0d1fcWAoB6V/8BwwevS6a2bVbF9/ZXJWp+MiRQEdt/sNa4rsxaQ
+0OHm0wdG6CXdUeedi3VUyfoiF/aQ5UqQbkr13JZLLNYelkRrylQR/HgjNajC7og
r/gvabfInPVVXJrKPaSF3CK5+EiKdMoOZYulUxaiJG2jYR10A9TavcMd1meUN6DI
A0kP7dLeUTa3kZA/vQJUdMFl6VPEiy2UYoUwzNzd6xCuo6a1oIK9GuK/+1NCi2BC
OS7se2dn9gTTkfFObzeEs2dwBLDsQ1y+vPLMHQFJf4JMu/x4RyTRUcm0wJCcVsc0
Znk8SAkyCn+qS2KML6JsihmYXoTjuVdjIMv9kXU1DFOitBj1/GtiFTj0ppghlwOH
paNAce7XIlV+V92XmcdrdUtfj0nxOBwVCR6DlTGuiZy42IUz0hnfuWA7TeAuo/jR
nRKcCM1yepEjvZt3RoeZ/Mup9qrFgMjCg0cj6urMz9n5rkU8rKKsT0eIKpGPJqLu
QZfXEG4eEBJBVx7twIHCHC+IICLmp/Vvi+FKlQ7wtb1Yh/XrHgcyfe7id88CTFS1
fofTbI+ehqtSwXSJY/ONCxF1DiU3TodpktvvqTflGjhsv3Cz/eE=
=85sK
-----END PGP SIGNATURE-----

--CEUtFxTsmBsHRLs3--
