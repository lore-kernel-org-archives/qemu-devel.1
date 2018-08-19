Received: from eggs.gnu.org ([2001:4830:134:3::10]:50858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1frCs9-0004nd-7T
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 21:51:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1frCs7-0004Fv-TL
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 21:51:17 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:43048)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <whois.zihan.yang@gmail.com>)
	id 1frCs7-0004FI-IS
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 21:51:15 -0400
Received: by mail-lf1-x142.google.com with SMTP id f135-v6so8436947lfg.10
	for <qemu-devel@nongnu.org>; Sat, 18 Aug 2018 18:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <1533796396-20483-1-git-send-email-whois.zihan.yang@gmail.com>
	<2130fbb3-0948-1f38-ead2-bb4a42577b10@gmail.com>
In-Reply-To: <2130fbb3-0948-1f38-ead2-bb4a42577b10@gmail.com>
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Sun, 19 Aug 2018 09:51:01 +0800
Message-ID: <CAKwiv-hYuwofS4i8aW8Thqvt68emgAnJdVkiZ6CYR2Gdtkbatg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 1/6] pci_expander_bridge: add type
 TYPE_PXB_PCIE_HOST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

Hi Marcel,

Marcel Apfelbaum <marcel.apfelbaum@gmail.com> =E4=BA=8E2018=E5=B9=B48=E6=9C=
=8818=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=881:14=E5=86=99=E9=81=93=
=EF=BC=9A
>
> Hi Zihan,
>
> On 08/09/2018 09:33 AM, Zihan Yang wrote:
> > The inner host bridge created by pxb-pcie is TYPE_PXB_PCI_HOST by defau=
lt,
> > change it to a new type TYPE_PXB_PCIE_HOST to better utilize ECAM of PC=
Ie
> >
> > Signed-off-by: Zihan Yang <whois.zihan.yang@gmail.com>
> > ---
> >   hw/pci-bridge/pci_expander_bridge.c | 127 +++++++++++++++++++++++++++=
+++++++--
> >   1 file changed, 122 insertions(+), 5 deletions(-)
> >
> > diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_ex=
pander_bridge.c
> > index e62de42..6dd38de 100644
> > --- a/hw/pci-bridge/pci_expander_bridge.c
> > +++ b/hw/pci-bridge/pci_expander_bridge.c
> > @@ -15,10 +15,12 @@
> >   #include "hw/pci/pci.h"
> >   #include "hw/pci/pci_bus.h"
> >   #include "hw/pci/pci_host.h"
> > +#include "hw/pci/pcie_host.h"
> >   #include "hw/pci/pci_bridge.h"
> >   #include "qemu/range.h"
> >   #include "qemu/error-report.h"
> >   #include "sysemu/numa.h"
> > +#include "qapi/visitor.h"
> >
> >   #define TYPE_PXB_BUS "pxb-bus"
> >   #define PXB_BUS(obj) OBJECT_CHECK(PXBBus, (obj), TYPE_PXB_BUS)
> > @@ -40,11 +42,20 @@ typedef struct PXBBus {
> >   #define TYPE_PXB_PCIE_DEVICE "pxb-pcie"
> >   #define PXB_PCIE_DEV(obj) OBJECT_CHECK(PXBDev, (obj), TYPE_PXB_PCIE_D=
EVICE)
> >
> > +#define PROP_PXB_PCIE_DEV "pxbdev"
> > +
> > +#define PROP_PXB_PCIE_DOMAIN_NR "domain_nr"
> > +#define PROP_PXB_PCIE_MAX_BUS "max_bus"
> > +#define PROP_PXB_BUS_NR "bus_nr"
> > +#define PROP_PXB_NUMA_NODE "numa_node"
> > +
> >   typedef struct PXBDev {
> >       /*< private >*/
> >       PCIDevice parent_obj;
> >       /*< public >*/
> >
> > +    uint32_t domain_nr; /* PCI domain number, non-zero means separate =
domain */
>
> The commit message suggests this patch is only about
> re-factoring of the pxb host type, but you add here more fields.
> Please use two separate patches.
>
> > +    uint8_t max_bus;    /* max bus number to use(including this one) *=
/
>
> That's a great idea! Limiting the max_bus will save us a lot
> of resource space,  we will not need 256 buses on pxbs probably.
>
> My concern is what happens with the current mode.
> Currently bus_nr is used to divide PCI domain 0 buses between pxbs.
> So if you have a pxb with bus_nr 100, and another with bus_nr 200,
> we divide them like this:
>      main host bridge 0...99
>      pxb1 100 -199
>      pxb2 200-255
>
> What will be the meaning of max_bus if we don't use the domain_nr paramet=
er?
> Maybe it will mean that some bus numbers are not assigned at all, for
> example:
>    pxb1: bus_nr 100, max_bus 150
>    pxb2: bus_nr 200, max_bus 210
>
> It may work.

Yes, it should mean so. Actually max_bus does not have to be specified
if domain_nr
is not used, but if users decide to use domain_nr and want to save
space, max_bus
could be used.

> >       uint8_t bus_nr;
> >       uint16_t numa_node;
> >   } PXBDev;
> > @@ -58,6 +69,16 @@ static PXBDev *convert_to_pxb(PCIDevice *dev)
> >   static GList *pxb_dev_list;
> >
> >   #define TYPE_PXB_HOST "pxb-host"
> > +#define TYPE_PXB_PCIE_HOST "pxb-pcie-host"
> > +#define PXB_PCIE_HOST_DEVICE(obj) \
> > +     OBJECT_CHECK(PXBPCIEHost, (obj), TYPE_PXB_PCIE_HOST)
> > +
> > +typedef struct PXBPCIEHost {
> > +    PCIExpressHost parent_obj;
> > +
> > +    /* pointers to PXBDev */
> > +    PXBDev *pxbdev;
> > +} PXBPCIEHost;
> >
> >   static int pxb_bus_num(PCIBus *bus)
> >   {
> > @@ -111,6 +132,35 @@ static const char *pxb_host_root_bus_path(PCIHostS=
tate *host_bridge,
> >       return bus->bus_path;
> >   }
> >
> > +/* Use a dedicated function for PCIe since pxb-host does
> > + * not have a domain_nr field */
> > +static const char *pxb_pcie_host_root_bus_path(PCIHostState *host_brid=
ge,
> > +                                          PCIBus *rootbus)
> > +{
> > +    if (!pci_bus_is_express(rootbus)) {
> > +        /* pxb-pcie-host cannot reside on a PCI bus */
> > +        return NULL;
> > +    }
> > +    PXBBus *bus =3D PXB_PCIE_BUS(rootbus);
> > +
> > +    /* get the pointer to PXBDev */
> > +    Object *obj =3D object_property_get_link(OBJECT(host_bridge),
> > +                                           PROP_PXB_PCIE_DEV, NULL);
>
> I don't think you need a link here.
> I think rootbus->parent_dev returns the pxb device.
> (See the implementation of pxb_bus_num() )

OK, I'll change it in next version.

> > +
> > +    snprintf(bus->bus_path, 8, "%04lx:%02x",
> > +             object_property_get_uint(obj, PROP_PXB_PCIE_DOMAIN_NR, NU=
LL),
> > +             pxb_bus_num(rootbus));
> > +    return bus->bus_path;
> > +}
> > +
> > +static void pxb_pcie_host_get_mmcfg_size(Object *obj, Visitor *v, cons=
t char *name,
> > +                                    void *opaque, Error **errp)
> > +{
> > +    PCIExpressHost *e =3D PCIE_HOST_BRIDGE(obj);
> > +
> > +    visit_type_uint64(v, name, &e->size, errp);
> > +}
> > +
> >   static char *pxb_host_ofw_unit_address(const SysBusDevice *dev)
> >   {
> >       const PCIHostState *pxb_host;
> > @@ -142,6 +192,31 @@ static char *pxb_host_ofw_unit_address(const SysBu=
sDevice *dev)
> >       return NULL;
> >   }
> >
> > +static void pxb_pcie_host_initfn(Object *obj)
> > +{
> > +    PXBPCIEHost *s =3D PXB_PCIE_HOST_DEVICE(obj);
> > +    PCIHostState *phb =3D PCI_HOST_BRIDGE(obj);
> > +
> > +    memory_region_init_io(&phb->conf_mem, obj, &pci_host_conf_le_ops, =
phb,
> > +                          "pci-conf-idx", 4);
> > +    memory_region_init_io(&phb->data_mem, obj, &pci_host_data_le_ops, =
phb,
> > +                          "pci-conf-data", 4);
> > +
>
> I don't understand the above. Do you want the pxb to respond to
> legacy PCI configuration cycles?
> I don't think it will be possible since it is accessible only through
> addresses
> 0xcf8 and 0xcfc which are already "taken" by the Q35 host brigde.
>
> More importantly, we don't need them, we want to configure
> the PXB using MCFG.

I see your comment on later patch, there are two reasons.

The first is that seabios uses the port IO to read pci configuration space,
but 0xcf8 and 0xcfc is binded to pcie.0 bus as you have pointed out. I thin=
k
sticking with port io could minimize the modification of seabios, so I use
another port pair for pxb hosts. Are you suggesting we use mmio for pxb
devices specially?

The second is that seabios has not loaded RSDP when doing pci_setup,
therefore we don't have the base address of each mcfg entry yet. So I still
use the legacy ioport method as a temporary workaround.

> > +    object_property_add(obj, PCIE_HOST_MCFG_SIZE, "uint64",
> > +                         pxb_pcie_host_get_mmcfg_size,
> > +                         NULL, NULL, NULL, NULL);
> > +
> > +    object_property_add_link(obj, PROP_PXB_PCIE_DEV, TYPE_PXB_PCIE_DEV=
ICE,
> > +                         (Object **)&s->pxbdev,
> > +                         qdev_prop_allow_set_link_before_realize, 0, N=
ULL);
> > +}
> > +
> > +static Property pxb_pcie_host_props[] =3D {
> > +    DEFINE_PROP_UINT64(PCIE_HOST_MCFG_BASE, PXBPCIEHost, parent_obj.ba=
se_addr,
> > +                        PCIE_BASE_ADDR_UNMAPPED),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
>
> That means you expect the management software to provide the
> address... the libvirt guys will not like it :).
> But for the moment let's go with it.
>
> >   static void pxb_host_class_init(ObjectClass *class, void *data)
> >   {
> >       DeviceClass *dc =3D DEVICE_CLASS(class);
> > @@ -155,12 +230,34 @@ static void pxb_host_class_init(ObjectClass *clas=
s, void *data)
> >       hc->root_bus_path =3D pxb_host_root_bus_path;
> >   }
> >
> > +static void pxb_pcie_host_class_init(ObjectClass *class, void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(class);
> > +    SysBusDeviceClass *sbc =3D SYS_BUS_DEVICE_CLASS(class);
> > +    PCIHostBridgeClass *hc =3D PCI_HOST_BRIDGE_CLASS(class);
> > +
> > +    dc->fw_name =3D "pcie";
> > +    dc->props =3D pxb_pcie_host_props;
> > +    /* Reason: Internal part of the pxb/pxb-pcie device, not usable by=
 itself */
> > +    dc->user_creatable =3D false;
> > +    sbc->explicit_ofw_unit_address =3D pxb_host_ofw_unit_address;
> > +    hc->root_bus_path =3D pxb_pcie_host_root_bus_path;
> > +}
> > +
> >   static const TypeInfo pxb_host_info =3D {
> >       .name          =3D TYPE_PXB_HOST,
> >       .parent        =3D TYPE_PCI_HOST_BRIDGE,
> >       .class_init    =3D pxb_host_class_init,
> >   };
> >
> > +static const TypeInfo pxb_pcie_host_info =3D {
> > +    .name          =3D TYPE_PXB_PCIE_HOST,
> > +    .parent        =3D TYPE_PCIE_HOST_BRIDGE,
> > +    .instance_size =3D sizeof(PXBPCIEHost),
> > +    .instance_init =3D pxb_pcie_host_initfn,
> > +    .class_init    =3D pxb_pcie_host_class_init,
> > +};
> > +
> >   /*
> >    * Registers the PXB bus as a child of pci host root bus.
> >    */
> > @@ -205,7 +302,10 @@ static gint pxb_compare(gconstpointer a, gconstpoi=
nter b)
> >   {
> >       const PXBDev *pxb_a =3D a, *pxb_b =3D b;
> >
> > -    return pxb_a->bus_nr < pxb_b->bus_nr ? -1 :
> > +    /* check domain_nr, then bus_nr */
> > +    return pxb_a->domain_nr < pxb_b->domain_nr ? -1 :
> > +           pxb_a->domain_nr > pxb_b->domain_nr ?  1 :
> > +           pxb_a->bus_nr < pxb_b->bus_nr ? -1 :
> >              pxb_a->bus_nr > pxb_b->bus_nr ?  1 :
> >              0;
> >   }
> > @@ -228,10 +328,16 @@ static void pxb_dev_realize_common(PCIDevice *dev=
, bool pcie, Error **errp)
> >           dev_name =3D dev->qdev.id;
> >       }
> >
> > -    ds =3D qdev_create(NULL, TYPE_PXB_HOST);
> >       if (pcie) {
> > +        g_assert (pxb->max_bus >=3D pxb->bus_nr);
> > +        ds =3D qdev_create(NULL, TYPE_PXB_PCIE_HOST);
> > +
> > +        object_property_set_link(OBJECT(ds), OBJECT(pxb),
> > +                                 PROP_PXB_PCIE_DEV, NULL);
>
> Please see the comment above, I don't think you
> need this "link".

OK.

> > +
> >           bus =3D pci_root_bus_new(ds, dev_name, NULL, NULL, 0, TYPE_PX=
B_PCIE_BUS);
> >       } else {
> > +        ds =3D qdev_create(NULL, TYPE_PXB_HOST);
> >           bus =3D pci_root_bus_new(ds, "pxb-internal", NULL, NULL, 0, T=
YPE_PXB_BUS);
> >           bds =3D qdev_create(BUS(bus), "pci-bridge");
> >           bds->id =3D dev_name;
> > @@ -289,8 +395,18 @@ static void pxb_dev_exitfn(PCIDevice *pci_dev)
> >
> >   static Property pxb_dev_properties[] =3D {
> >       /* Note: 0 is not a legal PXB bus number. */
> > -    DEFINE_PROP_UINT8("bus_nr", PXBDev, bus_nr, 0),
> > -    DEFINE_PROP_UINT16("numa_node", PXBDev, numa_node, NUMA_NODE_UNASS=
IGNED),
> > +    DEFINE_PROP_UINT8(PROP_PXB_BUS_NR, PXBDev, bus_nr, 0),
> > +    DEFINE_PROP_UINT16(PROP_PXB_NUMA_NODE, PXBDev, numa_node, NUMA_NOD=
E_UNASSIGNED),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static Property pxb_pcie_dev_properties[] =3D {
> > +    DEFINE_PROP_UINT8(PROP_PXB_BUS_NR, PXBDev, bus_nr, 0),
> > +    DEFINE_PROP_UINT16(PROP_PXB_NUMA_NODE, PXBDev, numa_node, NUMA_NOD=
E_UNASSIGNED),
> > +    DEFINE_PROP_UINT32(PROP_PXB_PCIE_DOMAIN_NR, PXBDev, domain_nr, 0),
> > +    /* set a small default value, bus interval is [bus_nr, max_bus] */
> > +    DEFINE_PROP_UINT8(PROP_PXB_PCIE_MAX_BUS, PXBDev, max_bus, 16),
> > +
>
> You can unite the common PROPS using a macro, but is not
> a big deal.
>
> >       DEFINE_PROP_END_OF_LIST(),
> >   };
> >
> > @@ -344,7 +460,7 @@ static void pxb_pcie_dev_class_init(ObjectClass *kl=
ass, void *data)
> >       k->class_id =3D PCI_CLASS_BRIDGE_HOST;
> >
> >       dc->desc =3D "PCI Express Expander Bridge";
> > -    dc->props =3D pxb_dev_properties;
> > +    dc->props =3D pxb_pcie_dev_properties;
> >       dc->hotpluggable =3D false;
> >       set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> >   }
> > @@ -365,6 +481,7 @@ static void pxb_register_types(void)
> >       type_register_static(&pxb_bus_info);
> >       type_register_static(&pxb_pcie_bus_info);
> >       type_register_static(&pxb_host_info);
> > +    type_register_static(&pxb_pcie_host_info);
> >       type_register_static(&pxb_dev_info);
> >       type_register_static(&pxb_pcie_dev_info);
> >   }
>
> Thanks,
> Marcel
>
