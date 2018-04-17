Received: from eggs.gnu.org ([2001:4830:134:3::10]:42542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f8FE6-00020N-4F
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 21:16:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f8FE3-00054T-U9
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 21:16:06 -0400
Date: Tue, 17 Apr 2018 11:15:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180417011549.GF20551@umbus.fritz.box>
References: <1523551221-11612-1-git-send-email-imammedo@redhat.com>
	<1523551221-11612-3-git-send-email-imammedo@redhat.com>
	<20180416024355.GA20551@umbus.fritz.box>
	<20180416101914.1184e90e@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="924gEkU1VlJlwnwX"
Content-Disposition: inline
In-Reply-To: <20180416101914.1184e90e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.13 2/4] platform-bus-device: use
 device plug callback instead of machine_done notifier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, eric.auger@redhat.com, agraf@suse.de, qemu-ppc@nongnu.org


--924gEkU1VlJlwnwX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 16, 2018 at 10:19:14AM +0200, Igor Mammedov wrote:
> On Mon, 16 Apr 2018 12:43:55 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Thu, Apr 12, 2018 at 06:40:19PM +0200, Igor Mammedov wrote:
> > > platform-bus were using machine_done notifier to get and map
> > > (assign irq/mmio resources) dynamically added sysbus devices
> > > after all '-device' options had been processed.
> > > That however creates non obvious dependencies on ordering of
> > > machine_done notifiers and requires carefull line juggling
> > > to keep it working. For example see comment above
> > > create_platform_bus() and 'straitforward' arm_load_kernel()
> > > had to converted to machine_done notifier and that lead to
> > > yet another machine_done notifier to keep it working
> > > arm_register_platform_bus_fdt_creator().
> > >=20
> > > Instead of hiding resource assignment in platform-bus-device
> > > to magically initialize sysbus devices, use device plug
> > > callback and assign resources explicitly at board level
> > > at the moment each -device option is being processed.
> > >=20
> > > That adds a bunch of machine declaration boiler plate to
> > > e500plat board, similar to ARM/x86 but gets rid of hidden
> > > machine_done notifier and would allow to remove the dependent
> > > notifiers in ARM code simplifying it and making code flow
> > > easier to follow.
> > >=20
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > ---
> > > CC: agraf@suse.de
> > > CC: david@gibson.dropbear.id.au
> > > CC: qemu-ppc@nongnu.org
> > > ---
> > >  hw/ppc/e500.h             |  3 +++
> > >  include/hw/arm/virt.h     |  3 +++
> > >  include/hw/platform-bus.h |  4 ++--
> > >  hw/arm/sysbus-fdt.c       |  3 ---
> > >  hw/arm/virt.c             | 36 ++++++++++++++++++++++++++++
> > >  hw/core/platform-bus.c    | 29 ++++-------------------
> > >  hw/ppc/e500.c             | 37 +++++++++++++++++------------
> > >  hw/ppc/e500plat.c         | 60 +++++++++++++++++++++++++++++++++++++=
++++++++--
> > >  8 files changed, 129 insertions(+), 46 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/e500.h b/hw/ppc/e500.h
> > > index 70ba1d8..d0f8ddd 100644
> > > --- a/hw/ppc/e500.h
> > > +++ b/hw/ppc/e500.h
> > > @@ -2,6 +2,7 @@
> > >  #define PPCE500_H
> > > =20
> > >  #include "hw/boards.h"
> > > +#include "hw/sysbus.h"
> > > =20
> > >  typedef struct PPCE500Params {
> > >      int pci_first_slot;
> > > @@ -26,6 +27,8 @@ typedef struct PPCE500Params {
> > > =20
> > >  void ppce500_init(MachineState *machine, PPCE500Params *params);
> > > =20
> > > +void ppce500_plug_dynamic_sysbus_device(SysBusDevice *sbdev);
> > > +
> > >  hwaddr booke206_page_size_to_tlb(uint64_t size);
> > > =20
> > >  #endif
> > > diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> > > index ba0c1a4..5535760 100644
> > > --- a/include/hw/arm/virt.h
> > > +++ b/include/hw/arm/virt.h
> > > @@ -86,11 +86,14 @@ typedef struct {
> > >      bool no_pmu;
> > >      bool claim_edge_triggered_timers;
> > >      bool smbios_old_sys_ver;
> > > +    HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
> > > +                                           DeviceState *dev);
> > >  } VirtMachineClass;
> > > =20
> > >  typedef struct {
> > >      MachineState parent;
> > >      Notifier machine_done;
> > > +    DeviceState *platform_bus_dev;
> > >      FWCfgState *fw_cfg;
> > >      bool secure;
> > >      bool highmem;
> > > diff --git a/include/hw/platform-bus.h b/include/hw/platform-bus.h
> > > index a00775c..19e20c5 100644
> > > --- a/include/hw/platform-bus.h
> > > +++ b/include/hw/platform-bus.h
> > > @@ -37,8 +37,6 @@ typedef struct PlatformBusDevice PlatformBusDevice;
> > >  struct PlatformBusDevice {
> > >      /*< private >*/
> > >      SysBusDevice parent_obj;
> > > -    Notifier notifier;
> > > -    bool done_gathering;
> > > =20
> > >      /*< public >*/
> > >      uint32_t mmio_size;
> > > @@ -54,4 +52,6 @@ int platform_bus_get_irqn(PlatformBusDevice *platfo=
rm_bus, SysBusDevice *sbdev,
> > >  hwaddr platform_bus_get_mmio_addr(PlatformBusDevice *pbus, SysBusDev=
ice *sbdev,
> > >                                    int n);
> > > =20
> > > +void platform_bus_link_device(PlatformBusDevice *pbus, SysBusDevice =
*sbdev);
> > > +
> > >  #endif /* HW_PLATFORM_BUS_H */
> > > diff --git a/hw/arm/sysbus-fdt.c b/hw/arm/sysbus-fdt.c
> > > index d68e3dc..80ff70e 100644
> > > --- a/hw/arm/sysbus-fdt.c
> > > +++ b/hw/arm/sysbus-fdt.c
> > > @@ -506,9 +506,6 @@ static void add_all_platform_bus_fdt_nodes(ARMPla=
tformBusFDTParams *fdt_params)
> > >      dev =3D qdev_find_recursive(sysbus_get_default(), TYPE_PLATFORM_=
BUS_DEVICE);
> > >      pbus =3D PLATFORM_BUS_DEVICE(dev);
> > > =20
> > > -    /* We can only create dt nodes for dynamic devices when they're =
ready */
> > > -    assert(pbus->done_gathering);
> > > -
> > >      PlatformBusFDTData data =3D {
> > >          .fdt =3D fdt,
> > >          .irq_start =3D irq_start,
> > > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > > index 94dcb12..2e10d8b 100644
> > > --- a/hw/arm/virt.c
> > > +++ b/hw/arm/virt.c
> > > @@ -1087,6 +1087,7 @@ static void create_platform_bus(VirtMachineStat=
e *vms, qemu_irq *pic)
> > >      qdev_prop_set_uint32(dev, "mmio_size",
> > >          platform_bus_params.platform_bus_size);
> > >      qdev_init_nofail(dev);
> > > +    vms->platform_bus_dev =3D dev;
> > >      s =3D SYS_BUS_DEVICE(dev);
> > > =20
> > >      for (i =3D 0; i < platform_bus_params.platform_bus_num_irqs; i++=
) {
> > > @@ -1536,9 +1537,37 @@ static const CPUArchIdList *virt_possible_cpu_=
arch_ids(MachineState *ms)
> > >      return ms->possible_cpus;
> > >  }
> > > =20
> > > +static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
> > > +                                        DeviceState *dev, Error **er=
rp)
> > > +{
> > > +    VirtMachineState *vms =3D VIRT_MACHINE(hotplug_dev);
> > > +
> > > +    if (object_dynamic_cast(OBJECT(dev), TYPE_SYS_BUS_DEVICE)) {
> > > +        if (vms->platform_bus_dev) {
> > > +            platform_bus_link_device(PLATFORM_BUS_DEVICE(vms->platfo=
rm_bus_dev),
> > > +                                     SYS_BUS_DEVICE(dev));
> > > +        }
> > > +    }
> > > +}
> > > +
> > > +static HotplugHandler *virt_machine_get_hotpug_handler(MachineState =
*machine,
> > > +                                                       DeviceState *=
dev)
> > > +{
> > > +    VirtMachineClass *vmc =3D VIRT_MACHINE_GET_CLASS(machine);
> > > +
> > > +    if (object_dynamic_cast(OBJECT(dev), TYPE_SYS_BUS_DEVICE)) {
> > > +        return HOTPLUG_HANDLER(machine);
> > > +    }
> > > +
> > > +    return vmc->get_hotplug_handler ?
> > > +        vmc->get_hotplug_handler(machine, dev) : NULL;
> > > +}
> > > +
> > >  static void virt_machine_class_init(ObjectClass *oc, void *data)
> > >  {
> > >      MachineClass *mc =3D MACHINE_CLASS(oc);
> > > +    VirtMachineClass *vmc =3D VIRT_MACHINE_CLASS(oc);
> > > +    HotplugHandlerClass *hc =3D HOTPLUG_HANDLER_CLASS(oc);
> > > =20
> > >      mc->init =3D machvirt_init;
> > >      /* Start max_cpus at the maximum QEMU supports. We'll further re=
strict
> > > @@ -1557,6 +1586,9 @@ static void virt_machine_class_init(ObjectClass=
 *oc, void *data)
> > >      mc->cpu_index_to_instance_props =3D virt_cpu_index_to_props;
> > >      mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a15");
> > >      mc->get_default_cpu_node_id =3D virt_get_default_cpu_node_id;
> > > +    vmc->get_hotplug_handler =3D mc->get_hotplug_handler;
> > > +    mc->get_hotplug_handler =3D virt_machine_get_hotpug_handler;
> > > +    hc->plug =3D virt_machine_device_plug_cb;
> > >  }
> > > =20
> > >  static const TypeInfo virt_machine_info =3D {
> > > @@ -1566,6 +1598,10 @@ static const TypeInfo virt_machine_info =3D {
> > >      .instance_size =3D sizeof(VirtMachineState),
> > >      .class_size    =3D sizeof(VirtMachineClass),
> > >      .class_init    =3D virt_machine_class_init,
> > > +    .interfaces =3D (InterfaceInfo[]) {
> > > +         { TYPE_HOTPLUG_HANDLER },
> > > +         { }
> > > +    },
> > >  };
> > > =20
> > >  static void machvirt_machine_init(void)
> > > diff --git a/hw/core/platform-bus.c b/hw/core/platform-bus.c
> > > index 33d32fb..807cb5c 100644
> > > --- a/hw/core/platform-bus.c
> > > +++ b/hw/core/platform-bus.c
> > > @@ -103,7 +103,6 @@ static void plaform_bus_refresh_irqs(PlatformBusD=
evice *pbus)
> > >  {
> > >      bitmap_zero(pbus->used_irqs, pbus->num_irqs);
> > >      foreach_dynamic_sysbus_device(platform_bus_count_irqs, pbus);
> > > -    pbus->done_gathering =3D true;
> > >  }
> > > =20
> > >  static void platform_bus_map_irq(PlatformBusDevice *pbus, SysBusDevi=
ce *sbdev,
> > > @@ -163,12 +162,11 @@ static void platform_bus_map_mmio(PlatformBusDe=
vice *pbus, SysBusDevice *sbdev,
> > >  }
> > > =20
> > >  /*
> > > - * For each sysbus device, look for unassigned IRQ lines as well as
> > > - * unassociated MMIO regions. Connect them to the platform bus if av=
ailable.
> > > + * Look for unassigned IRQ lines as well as unassociated MMIO region=
s.
> > > + * Connect them to the platform bus if available.
> > >   */
> > > -static void link_sysbus_device(SysBusDevice *sbdev, void *opaque)
> > > +void platform_bus_link_device(PlatformBusDevice *pbus, SysBusDevice =
*sbdev)
> > >  {
> > > -    PlatformBusDevice *pbus =3D opaque;
> > >      int i;
> > > =20
> > >      for (i =3D 0; sysbus_has_irq(sbdev, i); i++) {
> > > @@ -180,19 +178,6 @@ static void link_sysbus_device(SysBusDevice *sbd=
ev, void *opaque)
> > >      }
> > >  }
> > > =20
> > > -static void platform_bus_init_notify(Notifier *notifier, void *data)
> > > -{
> > > -    PlatformBusDevice *pb =3D container_of(notifier, PlatformBusDevi=
ce, notifier);
> > > -
> > > -    /*
> > > -     * Generate a bitmap of used IRQ lines, as the user might have s=
pecified
> > > -     * them on the command line.
> > > -     */
> > > -    plaform_bus_refresh_irqs(pb);
> > > -
> > > -    foreach_dynamic_sysbus_device(link_sysbus_device, pb);
> > > -}
> > > -
> > >  static void platform_bus_realize(DeviceState *dev, Error **errp)
> > >  {
> > >      PlatformBusDevice *pbus;
> > > @@ -211,12 +196,8 @@ static void platform_bus_realize(DeviceState *de=
v, Error **errp)
> > >          sysbus_init_irq(d, &pbus->irqs[i]);
> > >      }
> > > =20
> > > -    /*
> > > -     * Register notifier that allows us to gather dangling devices o=
nce the
> > > -     * machine is completely assembled
> > > -     */
> > > -    pbus->notifier.notify =3D platform_bus_init_notify;
> > > -    qemu_add_machine_init_done_notifier(&pbus->notifier);
> > > +    /* some devices might be initialized before so update used IRQs =
map */
> > > +    plaform_bus_refresh_irqs(pbus);
> > >  }
> > > =20
> > >  static Property platform_bus_properties[] =3D {
> > > diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> > > index 9a85a41..e2829db 100644
> > > --- a/hw/ppc/e500.c
> > > +++ b/hw/ppc/e500.c
> > > @@ -64,6 +64,8 @@
> > >  #define MPC8XXX_GPIO_OFFSET        0x000FF000ULL
> > >  #define MPC8XXX_GPIO_IRQ           47
> > > =20
> > > +static SysBusDevice *pbus_dev; =20
> >=20
> > I'm not thrilled about adding a new global for information that really
> > belongs in the machine state.  Although I do recognize that adding an
> > actual MachineState subtype that didn't previously exist is a bit of a =
pain.
> yep, adding MachineState seemed too much for the task that's why I've use=
d global.
> I can switch to actual MachineState here if you'd prefer it.

I would prefer that, please.  The code's already pretty ugly, let's
not make it uglier.

>=20
> > >  struct boot_info
> > >  {
> > >      uint32_t dt_base;
> > > @@ -248,23 +250,28 @@ static void platform_bus_create_devtree(PPCE500=
Params *params, void *fdt,
> > >      dev =3D qdev_find_recursive(sysbus_get_default(), TYPE_PLATFORM_=
BUS_DEVICE);
> > >      pbus =3D PLATFORM_BUS_DEVICE(dev);
> > > =20
> > > -    /* We can only create dt nodes for dynamic devices when they're =
ready */
> > > -    if (pbus->done_gathering) {
> > > -        PlatformDevtreeData data =3D {
> > > -            .fdt =3D fdt,
> > > -            .mpic =3D mpic,
> > > -            .irq_start =3D irq_start,
> > > -            .node =3D node,
> > > -            .pbus =3D pbus,
> > > -        };
> > > +    /* Create dt nodes for dynamic devices */
> > > +    PlatformDevtreeData data =3D {
> > > +        .fdt =3D fdt,
> > > +        .mpic =3D mpic,
> > > +        .irq_start =3D irq_start,
> > > +        .node =3D node,
> > > +        .pbus =3D pbus,
> > > +    };
> > > =20
> > > -        /* Loop through all dynamic sysbus devices and create nodes =
for them */
> > > -        foreach_dynamic_sysbus_device(sysbus_device_create_devtree, =
&data);
> > > -    }
> > > +    /* Loop through all dynamic sysbus devices and create nodes for =
them */
> > > +    foreach_dynamic_sysbus_device(sysbus_device_create_devtree, &dat=
a);
> > > =20
> > >      g_free(node);
> > >  }
> > > =20
> > > +void ppce500_plug_dynamic_sysbus_device(SysBusDevice *sbdev)
> > > +{
> > > +    if (pbus_dev) {
> > > +        platform_bus_link_device(PLATFORM_BUS_DEVICE(pbus_dev), sbde=
v);
> > > +    }
> > > +}
> > > +
> > >  static int ppce500_load_device_tree(MachineState *machine,
> > >                                      PPCE500Params *params,
> > >                                      hwaddr addr,
> > > @@ -945,16 +952,16 @@ void ppce500_init(MachineState *machine, PPCE50=
0Params *params)
> > >          qdev_prop_set_uint32(dev, "num_irqs", params->platform_bus_n=
um_irqs);
> > >          qdev_prop_set_uint32(dev, "mmio_size", params->platform_bus_=
size);
> > >          qdev_init_nofail(dev);
> > > -        s =3D SYS_BUS_DEVICE(dev);
> > > +        pbus_dev =3D SYS_BUS_DEVICE(dev);
> > > =20
> > >          for (i =3D 0; i < params->platform_bus_num_irqs; i++) {
> > >              int irqn =3D params->platform_bus_first_irq + i;
> > > -            sysbus_connect_irq(s, i, qdev_get_gpio_in(mpicdev, irqn)=
);
> > > +            sysbus_connect_irq(pbus_dev, i, qdev_get_gpio_in(mpicdev=
, irqn));
> > >          }
> > > =20
> > >          memory_region_add_subregion(address_space_mem,
> > >                                      params->platform_bus_base,
> > > -                                    sysbus_mmio_get_region(s, 0));
> > > +                                    sysbus_mmio_get_region(pbus_dev,=
 0));
> > >      }
> > > =20
> > >      /*
> > > diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
> > > index 81d03e1..2f014cc 100644
> > > --- a/hw/ppc/e500plat.c
> > > +++ b/hw/ppc/e500plat.c
> > > @@ -60,8 +60,49 @@ static void e500plat_init(MachineState *machine)
> > >      ppce500_init(machine, &params);
> > >  }
> > > =20
> > > -static void e500plat_machine_init(MachineClass *mc)
> > > +typedef struct {
> > > +    MachineClass parent;
> > > +    HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
> > > +                                           DeviceState *dev);
> > > +} E500PlatMachineClass;
> > > +
> > > +#define TYPE_E500PLAT_MACHINE  MACHINE_TYPE_NAME("ppce500")
> > > +#define E500PLAT_MACHINE_GET_CLASS(obj) \
> > > +    OBJECT_GET_CLASS(E500PlatMachineClass, obj, TYPE_E500PLAT_MACHIN=
E)
> > > +#define E500PLAT_MACHINE_CLASS(klass) \
> > > +    OBJECT_CLASS_CHECK(E500PlatMachineClass, klass, TYPE_E500PLAT_MA=
CHINE)
> > > +
> > > +static void e500plat_machine_device_plug_cb(HotplugHandler *hotplug_=
dev,
> > > +                                            DeviceState *dev, Error =
**errp)
> > >  {
> > > +    if (object_dynamic_cast(OBJECT(dev), TYPE_SYS_BUS_DEVICE)) {
> > > +        ppce500_plug_dynamic_sysbus_device(SYS_BUS_DEVICE(dev));
> > > +    }
> > > +}
> > > +
> > > +static
> > > +HotplugHandler *e500plat_machine_get_hotpug_handler(MachineState *ma=
chine,
> > > +                                                    DeviceState *dev)
> > > +{
> > > +    E500PlatMachineClass *emc =3D E500PLAT_MACHINE_GET_CLASS(machine=
);
> > > +    if (object_dynamic_cast(OBJECT(dev), TYPE_SYS_BUS_DEVICE)) {
> > > +        return HOTPLUG_HANDLER(machine);
> > > +    }
> > > +
> > > +    return emc->get_hotplug_handler ?
> > > +        emc->get_hotplug_handler(machine, dev) : NULL;
> > > +}
> > > +
> > > +static void e500plat_machine_class_init(ObjectClass *oc, void *data)
> > > +{
> > > +    E500PlatMachineClass *emc =3D E500PLAT_MACHINE_CLASS(oc);
> > > +    HotplugHandlerClass *hc =3D HOTPLUG_HANDLER_CLASS(oc);
> > > +    MachineClass *mc =3D MACHINE_CLASS(oc);
> > > +
> > > +    emc->get_hotplug_handler =3D mc->get_hotplug_handler;
> > > +    mc->get_hotplug_handler =3D e500plat_machine_get_hotpug_handler;=
 =20
> >=20
> > I'm pretty sure the parent type will never have a handler, so I'm not
> > sure this is really necessary.
> It seems that only PC machine handles chain correctly while other
> targets /spapr,s390x/ don't.
>=20
> Perhaps we should just drop caching original
> MachineClass::get_hotplug_handler (which is NULL) everywhere
> so it will be consistent across boards.
> If we ever need chaining here, we could add it then and do
> it consistently for every board that uses it.

Sounds reasonable to me.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--924gEkU1VlJlwnwX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrVSsUACgkQbDjKyiDZ
s5I1GhAA4aPj+bboHCLqIB+q1QUd6WGwUxc35g7gpbtTJxwC4mk+cx9wpLp9KALh
nxW73GJZqFylW8+qK4kbKZwy/6LbHwBjHQBiRKJ8CBfjb1QFdIV1joExjzoiDcZv
MDR6BWcdj7lpMTceChGq/pogVQNgrWcj0RdffbfjcU8FxKORipncr4iWntO1hoCf
P9ijgx5BGYejFPeqxDm6+1XOfayusyWSFpOxhRVIprvVBNOxW+2s0eE/83DtetmQ
yG4W+OWsXe5PIf5iIvD9uW9vXbiNNdt0i5lVOK9v0i6rD1K2xyFs0oAzdftLvyda
Inr4WlWePfR8fi7ZJ9iORYn2+BJU0wMLj0Wpfl20TkO7TIaQijQyc5KUw363JSgZ
5/XJWDgsubpX0OCtq5mWzTQ2HTW6dfHwzkjUD0nZ+AlfvJKW/zZaz7TefHvSm1p+
SJoCeGPPECYOShHcxe5baTjuayvLMpkC7XUZ/V5Lujy9Tfmyl89q42Ewy/D3146V
qG2dpEot1Kcq/BvSQ2fagIqhG44ylFCV9z26G65Kq5mKdCWmFrnmFwppYtX86Uvg
NKAR0GNf2BiZKBO8RoIAsueREDqBP0CczDSUSFJOUS76hbQHzfChY3M8ZOyKfDAT
moXs063bIfszK8eCSu1iStOfPFCbeGWBrf72IYkA7ArzA+yUYp8=
=N3FR
-----END PGP SIGNATURE-----

--924gEkU1VlJlwnwX--
