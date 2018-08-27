Received: from eggs.gnu.org ([2001:4830:134:3::10]:35270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fu77O-0004bq-L3
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 22:19:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fu77N-0007Wr-1G
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 22:19:02 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:35970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <whois.zihan.yang@gmail.com>)
	id 1fu77L-0007Qf-52
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 22:19:00 -0400
Received: by mail-lf1-x142.google.com with SMTP id c21-v6so10698749lfh.3
	for <qemu-devel@nongnu.org>; Sun, 26 Aug 2018 19:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <1533796396-20483-1-git-send-email-whois.zihan.yang@gmail.com>
	<2130fbb3-0948-1f38-ead2-bb4a42577b10@gmail.com>
	<CAKwiv-hYuwofS4i8aW8Thqvt68emgAnJdVkiZ6CYR2Gdtkbatg@mail.gmail.com>
	<25bdcdf1-53e3-0845-a1b8-2cc6a00baba3@gmail.com>
In-Reply-To: <25bdcdf1-53e3-0845-a1b8-2cc6a00baba3@gmail.com>
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Mon, 27 Aug 2018 02:18:40 +0000
Message-ID: <CAKwiv-iR5rC5xPT6U6cDfuF2dT3Lndejs=MiCsvF3Li6yAf6EQ@mail.gmail.com>
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

Marcel Apfelbaum <marcel.apfelbaum@gmail.com> =E4=BA=8E2018=E5=B9=B48=E6=9C=
=8825=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=888:08=E5=86=99=E9=81=93=
=EF=BC=9A
>
> Hi Zihan,
>
> On 08/19/2018 04:51 AM, Zihan Yang wrote:
> > Hi Marcel,
> >
> > Marcel Apfelbaum <marcel.apfelbaum@gmail.com> =E4=BA=8E2018=E5=B9=B48=
=E6=9C=8818=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=881:14=E5=86=99=E9=
=81=93=EF=BC=9A
> >> Hi Zihan,
> >>
> >> On 08/09/2018 09:33 AM, Zihan Yang wrote:
> >>> The inner host bridge created by pxb-pcie is TYPE_PXB_PCI_HOST by def=
ault,
> >>> change it to a new type TYPE_PXB_PCIE_HOST to better utilize ECAM of =
PCIe
> >>>
> >>> Signed-off-by: Zihan Yang <whois.zihan.yang@gmail.com>
> >>> ---
> >>>    hw/pci-bridge/pci_expander_bridge.c | 127 ++++++++++++++++++++++++=
++++++++++--
> >>>    1 file changed, 122 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_=
expander_bridge.c
> >>> index e62de42..6dd38de 100644
> >>> --- a/hw/pci-bridge/pci_expander_bridge.c
> >>> +++ b/hw/pci-bridge/pci_expander_bridge.c
> >>> @@ -15,10 +15,12 @@
> >>>    #include "hw/pci/pci.h"
> >>>    #include "hw/pci/pci_bus.h"
> >>>    #include "hw/pci/pci_host.h"
> >>> +#include "hw/pci/pcie_host.h"
> >>>    #include "hw/pci/pci_bridge.h"
> >>>    #include "qemu/range.h"
> >>>    #include "qemu/error-report.h"
> >>>    #include "sysemu/numa.h"
> >>> +#include "qapi/visitor.h"
> >>>
> >>>    #define TYPE_PXB_BUS "pxb-bus"
> >>>    #define PXB_BUS(obj) OBJECT_CHECK(PXBBus, (obj), TYPE_PXB_BUS)
> >>> @@ -40,11 +42,20 @@ typedef struct PXBBus {
> >>>    #define TYPE_PXB_PCIE_DEVICE "pxb-pcie"
> >>>    #define PXB_PCIE_DEV(obj) OBJECT_CHECK(PXBDev, (obj), TYPE_PXB_PCI=
E_DEVICE)
> >>>
> >>> +#define PROP_PXB_PCIE_DEV "pxbdev"
> >>> +
> >>> +#define PROP_PXB_PCIE_DOMAIN_NR "domain_nr"
> >>> +#define PROP_PXB_PCIE_MAX_BUS "max_bus"
> >>> +#define PROP_PXB_BUS_NR "bus_nr"
> >>> +#define PROP_PXB_NUMA_NODE "numa_node"
> >>> +
> >>>    typedef struct PXBDev {
> >>>        /*< private >*/
> >>>        PCIDevice parent_obj;
> >>>        /*< public >*/
> >>>
> >>> +    uint32_t domain_nr; /* PCI domain number, non-zero means separat=
e domain */
> >> The commit message suggests this patch is only about
> >> re-factoring of the pxb host type, but you add here more fields.
> >> Please use two separate patches.
> >>
> >>> +    uint8_t max_bus;    /* max bus number to use(including this one)=
 */
> >> That's a great idea! Limiting the max_bus will save us a lot
> >> of resource space,  we will not need 256 buses on pxbs probably.
> >>
> >> My concern is what happens with the current mode.
> >> Currently bus_nr is used to divide PCI domain 0 buses between pxbs.
> >> So if you have a pxb with bus_nr 100, and another with bus_nr 200,
> >> we divide them like this:
> >>       main host bridge 0...99
> >>       pxb1 100 -199
> >>       pxb2 200-255
> >>
> >> What will be the meaning of max_bus if we don't use the domain_nr para=
meter?
> >> Maybe it will mean that some bus numbers are not assigned at all, for
> >> example:
> >>     pxb1: bus_nr 100, max_bus 150
> >>     pxb2: bus_nr 200, max_bus 210
> >>
> >> It may work.
> > Yes, it should mean so. Actually max_bus does not have to be specified
> > if domain_nr
> > is not used, but if users decide to use domain_nr and want to save
> > space, max_bus
> > could be used.
> >
> >>>        uint8_t bus_nr;
> >>>        uint16_t numa_node;
> >>>    } PXBDev;
> >>> @@ -58,6 +69,16 @@ static PXBDev *convert_to_pxb(PCIDevice *dev)
> >>>    static GList *pxb_dev_list;
> >>>
> >>>    #define TYPE_PXB_HOST "pxb-host"
> >>> +#define TYPE_PXB_PCIE_HOST "pxb-pcie-host"
> >>> +#define PXB_PCIE_HOST_DEVICE(obj) \
> >>> +     OBJECT_CHECK(PXBPCIEHost, (obj), TYPE_PXB_PCIE_HOST)
> >>> +
> >>> +typedef struct PXBPCIEHost {
> >>> +    PCIExpressHost parent_obj;
> >>> +
> >>> +    /* pointers to PXBDev */
> >>> +    PXBDev *pxbdev;
> >>> +} PXBPCIEHost;
> >>>
> >>>    static int pxb_bus_num(PCIBus *bus)
> >>>    {
> >>> @@ -111,6 +132,35 @@ static const char *pxb_host_root_bus_path(PCIHos=
tState *host_bridge,
> >>>        return bus->bus_path;
> >>>    }
> >>>
> >>> +/* Use a dedicated function for PCIe since pxb-host does
> >>> + * not have a domain_nr field */
> >>> +static const char *pxb_pcie_host_root_bus_path(PCIHostState *host_br=
idge,
> >>> +                                          PCIBus *rootbus)
> >>> +{
> >>> +    if (!pci_bus_is_express(rootbus)) {
> >>> +        /* pxb-pcie-host cannot reside on a PCI bus */
> >>> +        return NULL;
> >>> +    }
> >>> +    PXBBus *bus =3D PXB_PCIE_BUS(rootbus);
> >>> +
> >>> +    /* get the pointer to PXBDev */
> >>> +    Object *obj =3D object_property_get_link(OBJECT(host_bridge),
> >>> +                                           PROP_PXB_PCIE_DEV, NULL);
> >> I don't think you need a link here.
> >> I think rootbus->parent_dev returns the pxb device.
> >> (See the implementation of pxb_bus_num() )
> > OK, I'll change it in next version.
> >
> >>> +
> >>> +    snprintf(bus->bus_path, 8, "%04lx:%02x",
> >>> +             object_property_get_uint(obj, PROP_PXB_PCIE_DOMAIN_NR, =
NULL),
> >>> +             pxb_bus_num(rootbus));
> >>> +    return bus->bus_path;
> >>> +}
> >>> +
> >>> +static void pxb_pcie_host_get_mmcfg_size(Object *obj, Visitor *v, co=
nst char *name,
> >>> +                                    void *opaque, Error **errp)
> >>> +{
> >>> +    PCIExpressHost *e =3D PCIE_HOST_BRIDGE(obj);
> >>> +
> >>> +    visit_type_uint64(v, name, &e->size, errp);
> >>> +}
> >>> +
> >>>    static char *pxb_host_ofw_unit_address(const SysBusDevice *dev)
> >>>    {
> >>>        const PCIHostState *pxb_host;
> >>> @@ -142,6 +192,31 @@ static char *pxb_host_ofw_unit_address(const Sys=
BusDevice *dev)
> >>>        return NULL;
> >>>    }
> >>>
> >>> +static void pxb_pcie_host_initfn(Object *obj)
> >>> +{
> >>> +    PXBPCIEHost *s =3D PXB_PCIE_HOST_DEVICE(obj);
> >>> +    PCIHostState *phb =3D PCI_HOST_BRIDGE(obj);
> >>> +
> >>> +    memory_region_init_io(&phb->conf_mem, obj, &pci_host_conf_le_ops=
, phb,
> >>> +                          "pci-conf-idx", 4);
> >>> +    memory_region_init_io(&phb->data_mem, obj, &pci_host_data_le_ops=
, phb,
> >>> +                          "pci-conf-data", 4);
> >>> +
> >> I don't understand the above. Do you want the pxb to respond to
> >> legacy PCI configuration cycles?
> >> I don't think it will be possible since it is accessible only through
> >> addresses
> >> 0xcf8 and 0xcfc which are already "taken" by the Q35 host brigde.
> >>
> >> More importantly, we don't need them, we want to configure
> >> the PXB using MCFG.
> > I see your comment on later patch, there are two reasons.
> >
> > The first is that seabios uses the port IO to read pci configuration sp=
ace,
> > but 0xcf8 and 0xcfc is binded to pcie.0 bus as you have pointed out. I =
think
> > sticking with port io could minimize the modification of seabios, so I =
use
> > another port pair for pxb hosts. Are you suggesting we use mmio for pxb
> > devices specially?
> >
> > The second is that seabios has not loaded RSDP when doing pci_setup,
> > therefore we don't have the base address of each mcfg entry yet. So I s=
till
> > use the legacy ioport method as a temporary workaround.
> >
>
> As I pointed out in the SeaBIOS series, this issue needs to be addressed
> before continuing.
>
> I repeat it here for QEMU developers, maybe somebody has an idea.
>
> If I understand correctly, the only way SeaBIOS lets us configure the
> devices
> is using the 0xcf8/0xcfc registers.
> Since we don't want at this point to support random IO ports for each PCI
> domain, maybe we can try a different angle:
>
> We don't have to configure the PCI devices residing in PCI domain > 0.
> The only drawback is we won't be able to boot from a PCI device
> belonging to such PCI domain, and maybe is OK.
>
> What we need from SeaBIOS is to 'assign' enough address space for each
> MMCFG and return their addresses to QEMU. Then QEMU can create the
> ACPI tables and let the guest OS configure the PCI devices.
>
> The problem remains the computation of the actual IO/MEM resources
> needed by these devices. (Not the MMCFG table).
> If SeaBIOS can't reach the PCI devices, it can't compute the  needed
> resources, so QEMU can't divide the IO/MEM address space between
> the PCI domains.
>
> Any idea would be welcomed.

It is welcomed by me too :)

> Thanks,
> Marcel
>
>
>
>
> [...]
