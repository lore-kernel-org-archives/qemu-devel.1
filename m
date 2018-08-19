Received: from eggs.gnu.org ([2001:4830:134:3::10]:51449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1frCwQ-0006d9-Bw
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 21:55:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1frCwM-0006b8-RX
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 21:55:41 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:39499)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <whois.zihan.yang@gmail.com>)
	id 1frCwM-0006aQ-0Q
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 21:55:38 -0400
Received: by mail-lj1-x244.google.com with SMTP id l15-v6so9075374lji.6
	for <qemu-devel@nongnu.org>; Sat, 18 Aug 2018 18:55:37 -0700 (PDT)
MIME-Version: 1.0
References: <1533796423-21114-1-git-send-email-whois.zihan.yang@gmail.com>
	<d07d57ed-12d0-f077-5d5a-5a8e44cb215f@gmail.com>
In-Reply-To: <d07d57ed-12d0-f077-5d5a-5a8e44cb215f@gmail.com>
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Sun, 19 Aug 2018 09:55:24 +0800
Message-ID: <CAKwiv-jmCoExXo6eNj+4xPpt_8K__1QtYgrg=HBr1qcPhKj3gA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 2/6] acpi-build: allocate mcfg for
 pxb-pcie host bridges
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
=8818=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=881:41=E5=86=99=E9=81=93=
=EF=BC=9A
>
> Hi Zihan,
>
> On 08/09/2018 09:33 AM, Zihan Yang wrote:
> > Allocate new segment for pxb-pcie host bridges in MCFG table, and reser=
ve
> > corresponding MCFG space for them. This allows user-defined pxb-pcie
> > host bridges to be placed in different pci domain than q35 host.
> >
> > The pci_host_bridges list is changed to be tail list to ensure the q35 =
host
> > is always the first element when traversing the list, because q35 host =
is
> > inserted beofre pxb-pcie hosts
> >
> > Signed-off-by: Zihan Yang <whois.zihan.yang@gmail.com>
> > ---
> >   hw/i386/acpi-build.c                        | 116 +++++++++++++++++++=
++++-----
> >   hw/i386/pc.c                                |  14 +++-
> >   hw/pci-bridge/pci_expander_bridge.c         |  57 ++++++++++----
> >   hw/pci-host/q35.c                           |   2 +
> >   hw/pci/pci.c                                |   9 ++-
> >   include/hw/i386/pc.h                        |   1 +
> >   include/hw/pci-bridge/pci_expander_bridge.h |  11 +++
> >   include/hw/pci-host/q35.h                   |   1 +
> >   include/hw/pci/pci_host.h                   |   2 +-
> >   9 files changed, 169 insertions(+), 44 deletions(-)
> >   create mode 100644 include/hw/pci-bridge/pci_expander_bridge.h
> >
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index e1ee8ae..c0fc2b4 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -55,6 +55,7 @@
> >   #include "hw/i386/ich9.h"
> >   #include "hw/pci/pci_bus.h"
> >   #include "hw/pci-host/q35.h"
> > +#include "hw/pci-bridge/pci_expander_bridge.h"
> >   #include "hw/i386/x86-iommu.h"
> >
> >   #include "hw/acpi/aml-build.h"
> > @@ -89,6 +90,9 @@
> >   typedef struct AcpiMcfgInfo {
> >       uint64_t mcfg_base;
> >       uint32_t mcfg_size;
> > +    uint32_t domain_nr;
> > +    uint8_t bus_nr; // start bus number
> > +    struct AcpiMcfgInfo *next;
> >   } AcpiMcfgInfo;
> >
> >   typedef struct AcpiPmInfo {
> > @@ -2431,14 +2435,16 @@ build_mcfg_q35(GArray *table_data, BIOSLinker *=
linker, AcpiMcfgInfo *info)
> >   {
> >       AcpiTableMcfg *mcfg;
> >       const char *sig;
> > -    int len =3D sizeof(*mcfg) + 1 * sizeof(mcfg->allocation[0]);
> > +    int len, count =3D 0;
> > +    AcpiMcfgInfo *cfg =3D info;
> > +
> > +    while (cfg) {
> > +        ++count;
> > +        cfg =3D cfg->next;
> > +    }
> > +    len =3D sizeof(*mcfg) + count * sizeof(mcfg->allocation[0]);
> >
> >       mcfg =3D acpi_data_push(table_data, len);
> > -    mcfg->allocation[0].address =3D cpu_to_le64(info->mcfg_base);
> > -    /* Only a single allocation so no need to play with segments */
>
> Now we do play :)

I will delete old comments in next version.

> > -    mcfg->allocation[0].pci_segment =3D cpu_to_le16(0);
> > -    mcfg->allocation[0].start_bus_number =3D 0;
> > -    mcfg->allocation[0].end_bus_number =3D PCIE_MMCFG_BUS(info->mcfg_s=
ize - 1);
> >
> >       /* MCFG is used for ECAM which can be enabled or disabled by gues=
t.
> >        * To avoid table size changes (which create migration issues),
> > @@ -2452,6 +2458,17 @@ build_mcfg_q35(GArray *table_data, BIOSLinker *l=
inker, AcpiMcfgInfo *info)
> >       } else {
> >           sig =3D "MCFG";
> >       }
> > +
> > +    count =3D 0;
> > +    while (info) {
> > +        mcfg[0].allocation[count].address =3D cpu_to_le64(info->mcfg_b=
ase);
> > +        mcfg[0].allocation[count].pci_segment =3D cpu_to_le16(info->do=
main_nr);
> > +        mcfg[0].allocation[count].start_bus_number =3D info->bus_nr;
> > +        mcfg[0].allocation[count++].end_bus_number =3D info->bus_nr + =
\
> > +                                    PCIE_MMCFG_BUS(info->mcfg_size - 1=
);
>
> I don't understand this. It appears we have a max_bus_nr property in pxb,
> why don't we use it here? Or the mcfg_size is already computed based on
> that?

The mcfg_size is computed based on that, and I think this can explicitly sh=
ow
the relationship of end bus and start bus, though max_bus seems shorter.

> > +        info =3D info->next;
> > +    }
> > +
> >       build_header(linker, table_data, (void *)mcfg, sig, len, 1, NULL,=
 NULL);
> >   }
> >
> > @@ -2606,26 +2623,83 @@ struct AcpiBuildState {
> >       MemoryRegion *linker_mr;
> >   } AcpiBuildState;
> >
> > -static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
> > +static inline void cleanup_mcfg(AcpiMcfgInfo *mcfg)
> > +{
> > +    AcpiMcfgInfo *tmp;
> > +    while (mcfg) {
> > +        tmp =3D mcfg->next;
> > +        g_free(mcfg);
> > +        mcfg =3D tmp;
> > +    }
> > +}
> > +
> > +static AcpiMcfgInfo *acpi_get_mcfg(void)
> >   {
> >       Object *pci_host;
> >       QObject *o;
> > +    uint32_t domain_nr;
> > +    AcpiMcfgInfo *head =3D NULL, *tail, *mcfg;
> >
> >       pci_host =3D acpi_get_i386_pci_host();
> >       g_assert(pci_host);
> >
> > -    o =3D object_property_get_qobject(pci_host, PCIE_HOST_MCFG_BASE, N=
ULL);
> > -    if (!o) {
> > -        return false;
> > +    while (pci_host) {
> > +        /* pxb-pcie-hosts does not have domain_nr property, but a link
> > +         * to PXBDev. We first try to get pxbdev property, if NULL,
> > +         * then it is q35 host, otherwise it is pxb-pcie-host */
>
> I think it will be cleaner if you check for the pxb-pcie-host type,
> then looking for a pxb device.

I will change it in next version.

> > +        Object *obj =3D object_property_get_link(pci_host,
> > +                                           PROP_PXB_PCIE_DEV, NULL);
> > +        if (!obj) {
> > +            /* we are in q35 host */
> > +            obj =3D pci_host;
> > +        }
> > +        o =3D object_property_get_qobject(obj, PROP_PXB_PCIE_DOMAIN_NR=
, NULL);
>
> Now I understand why you need to link the pxb to the host.
>
> > +        assert(o);
> > +        domain_nr =3D qnum_get_uint(qobject_to(QNum, o));
> > +        qobject_unref(o);
> > +
>
> Please add a function to the pci_host class that returns the pci_domain n=
r.
> For Q35 host bridge (and others) will return 0, while for the PXB host
> will return the domain nr.
> We don't want to pollute the apci building code with PXB specific interna=
ls.

OK, I will update the implementation

> > +        /* Skip bridges that reside in the same domain with q35 host.
> > +         * Q35 always stays in pci domain 0, and is the first element
> > +         * in the pci_host_bridges list */
> > +        if (head && domain_nr =3D=3D 0) {
> > +            pci_host =3D OBJECT(QTAILQ_NEXT(PCI_HOST_BRIDGE(pci_host),=
 next));
> > +            continue;
> > +        }
> > +
> > +        mcfg =3D g_new0(AcpiMcfgInfo, 1);
> > +        mcfg->next =3D NULL;
> > +        if (!head) {
> > +            tail =3D head =3D mcfg;
> > +        } else {
> > +            tail->next =3D mcfg;
> > +            tail =3D mcfg;
> > +        }
>
> Don't we have some "insert/add" macros? (I am not sure we have)

Maybe we can use QTAILQ, I will try that.

> > +        mcfg->domain_nr =3D domain_nr;
> > +
> > +        o =3D object_property_get_qobject(pci_host, PCIE_HOST_MCFG_BAS=
E, NULL);
> > +        assert(o);
> > +        mcfg->mcfg_base =3D qnum_get_uint(qobject_to(QNum, o));
> > +        qobject_unref(o);
> > +
> > +        /* firmware will overwrite it */
>
> What do you mean?

In q35, the acpi table will be built twice, the first time qemu builds
an initial table,
then seabios will update the config space of q35 host, overwriting
several properties,
thus casuing a rebuild of acpi table.

> > +        o =3D object_property_get_qobject(pci_host, PCIE_HOST_MCFG_SIZ=
E, NULL);
> > +        assert(o);
> > +        mcfg->mcfg_size =3D qnum_get_uint(qobject_to(QNum, o));
> > +        qobject_unref(o);
> > +
> > +        o =3D object_property_get_qobject(obj, PROP_PXB_BUS_NR, NULL);
> > +        if (!o) {
> > +            /* we are in q35 host again */
> > +            mcfg->bus_nr =3D 0;
> > +        } else {
> > +            mcfg->bus_nr =3D qnum_get_uint(qobject_to(QNum, o));
> > +            qobject_unref(o);
> > +        }
> > +
> > +        pci_host =3D OBJECT(QTAILQ_NEXT(PCI_HOST_BRIDGE(pci_host), nex=
t));
> >       }
> > -    mcfg->mcfg_base =3D qnum_get_uint(qobject_to(QNum, o));
> > -    qobject_unref(o);
> >
> > -    o =3D object_property_get_qobject(pci_host, PCIE_HOST_MCFG_SIZE, N=
ULL);
> > -    assert(o);
> > -    mcfg->mcfg_size =3D qnum_get_uint(qobject_to(QNum, o));
> > -    qobject_unref(o);
> > -    return true;
> > +    return head;
> >   }
> >
> >   static
> > @@ -2637,7 +2711,7 @@ void acpi_build(AcpiBuildTables *tables, MachineS=
tate *machine)
> >       unsigned facs, dsdt, rsdt, fadt;
> >       AcpiPmInfo pm;
> >       AcpiMiscInfo misc;
> > -    AcpiMcfgInfo mcfg;
> > +    AcpiMcfgInfo *mcfg;
> >       Range pci_hole, pci_hole64;
> >       uint8_t *u;
> >       size_t aml_len =3D 0;
> > @@ -2718,10 +2792,12 @@ void acpi_build(AcpiBuildTables *tables, Machin=
eState *machine)
> >               build_slit(tables_blob, tables->linker);
> >           }
> >       }
> > -    if (acpi_get_mcfg(&mcfg)) {
> > +    if ((mcfg =3D acpi_get_mcfg()) !=3D NULL) {
> >           acpi_add_table(table_offsets, tables_blob);
> > -        build_mcfg_q35(tables_blob, tables->linker, &mcfg);
> > +        build_mcfg_q35(tables_blob, tables->linker, mcfg);
> >       }
> > +    cleanup_mcfg(mcfg);
> > +
> >       if (x86_iommu_get_default()) {
> >           IommuType IOMMUType =3D x86_iommu_get_type();
> >           if (IOMMUType =3D=3D TYPE_AMD) {
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index 83a4444..a7e51af 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -35,6 +35,7 @@
> >   #include "hw/ide.h"
> >   #include "hw/pci/pci.h"
> >   #include "hw/pci/pci_bus.h"
> > +#include "hw/pci-bridge/pci_expander_bridge.h"
> >   #include "hw/nvram/fw_cfg.h"
> >   #include "hw/timer/hpet.h"
> >   #include "hw/smbios/smbios.h"
> > @@ -1470,15 +1471,24 @@ uint64_t pc_pci_hole64_start(void)
> >       if (pcmc->has_reserved_memory && ms->device_memory->base) {
> >           hole64_start =3D ms->device_memory->base;
> >           if (!pcmc->broken_reserved_end) {
> > -            hole64_start +=3D memory_region_size(&ms->device_memory->m=
r);
> > +            hole64_start +=3D (memory_region_size(&ms->device_memory->=
mr) + \
> > +                             pxb_pcie_mcfg_hole());
> >           }
> >       } else {
> > -        hole64_start =3D 0x100000000ULL + pcms->above_4g_mem_size;
> > +        /* memory layout [RAM Hotplug][MCFG][..ROUND UP..][PCI HOLE] *=
/
>
> The layout looks OK
>
> > +        hole64_start =3D pc_pci_mcfg_start() + pxb_pcie_mcfg_hole();
> >       }
> >
> >       return ROUND_UP(hole64_start, 1 * GiB);
> >   }
> >
> > +uint64_t pc_pci_mcfg_start(void)
> > +{
> > +    PCMachineState *pcms =3D PC_MACHINE(qdev_get_machine());
> > +
> > +    return ROUND_UP(0x100000000ULL + pcms->above_4g_mem_size, 4 * KiB)=
;
>
> Why do you round it up? (I am not saying is wrong)

It is not mandatory, but unaligned address seems uncommon. Perhaps aligning=
 up
to reduce potential false sharing?

> > +}
> > +
> >   qemu_irq pc_allocate_cpu_irq(void)
> >   {
> >       return qemu_allocate_irq(pic_irq_request, NULL, 0);
> > diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_ex=
pander_bridge.c
> > index 6dd38de..f50938f 100644
> > --- a/hw/pci-bridge/pci_expander_bridge.c
> > +++ b/hw/pci-bridge/pci_expander_bridge.c
> > @@ -12,15 +12,19 @@
> >
> >   #include "qemu/osdep.h"
> >   #include "qapi/error.h"
> > +#include "hw/i386/pc.h"
> >   #include "hw/pci/pci.h"
> >   #include "hw/pci/pci_bus.h"
> >   #include "hw/pci/pci_host.h"
> >   #include "hw/pci/pcie_host.h"
> >   #include "hw/pci/pci_bridge.h"
> > +#include "hw/pci-host/q35.h"
> > +#include "hw/pci-bridge/pci_expander_bridge.h"
> >   #include "qemu/range.h"
> >   #include "qemu/error-report.h"
> >   #include "sysemu/numa.h"
> >   #include "qapi/visitor.h"
> > +#include "qemu/units.h"
> >
> >   #define TYPE_PXB_BUS "pxb-bus"
> >   #define PXB_BUS(obj) OBJECT_CHECK(PXBBus, (obj), TYPE_PXB_BUS)
> > @@ -42,11 +46,7 @@ typedef struct PXBBus {
> >   #define TYPE_PXB_PCIE_DEVICE "pxb-pcie"
> >   #define PXB_PCIE_DEV(obj) OBJECT_CHECK(PXBDev, (obj), TYPE_PXB_PCIE_D=
EVICE)
> >
> > -#define PROP_PXB_PCIE_DEV "pxbdev"
> > -
> > -#define PROP_PXB_PCIE_DOMAIN_NR "domain_nr"
> >   #define PROP_PXB_PCIE_MAX_BUS "max_bus"
> > -#define PROP_PXB_BUS_NR "bus_nr"
> >   #define PROP_PXB_NUMA_NODE "numa_node"
> >
> >   typedef struct PXBDev {
> > @@ -122,6 +122,26 @@ static const TypeInfo pxb_pcie_bus_info =3D {
> >       .class_init    =3D pxb_bus_class_init,
> >   };
> >
> > +static uint64_t pxb_mcfg_hole_size =3D 0;
> > +
> > +static void pxb_pcie_foreach(gpointer data, gpointer user_data)
> > +{
> > +    PXBDev *pxb =3D (PXBDev *)data;
> > +
> > +    if (pxb->domain_nr > 0) {
> > +        /* only reserve what users ask for to reduce memory cost. Plus=
 one
> > +         * as the interval [bus_nr, max_bus] has (max_bus-bus_nr+1) bu=
ses */
> > +        pxb_mcfg_hole_size +=3D ((pxb->max_bus - pxb->bus_nr + 1ULL) *=
 MiB);
>
> Please find a way to do it without the global pxb_ncfg_hole_size.
> Do we really need it?

OK, I'll look at it.

> > +    }
> > +}
> > +
> > +uint64_t pxb_pcie_mcfg_hole(void)
> > +{
> > +    /* foreach is necessary as some pxb still reside in domain 0 */
> > +    g_list_foreach(pxb_dev_list, pxb_pcie_foreach, NULL);
> > +    return pxb_mcfg_hole_size;
> > +}
> > +
> >   static const char *pxb_host_root_bus_path(PCIHostState *host_bridge,
> >                                             PCIBus *rootbus)
> >   {
> > @@ -153,14 +173,6 @@ static const char *pxb_pcie_host_root_bus_path(PCI=
HostState *host_bridge,
> >       return bus->bus_path;
> >   }
> >
> > -static void pxb_pcie_host_get_mmcfg_size(Object *obj, Visitor *v, cons=
t char *name,
> > -                                    void *opaque, Error **errp)
> > -{
> > -    PCIExpressHost *e =3D PCIE_HOST_BRIDGE(obj);
> > -
> > -    visit_type_uint64(v, name, &e->size, errp);
> > -}
>
> Wasn't this function added in the prev patch?

Yes, my mistake. I decided to put it into PROPS because this makes code
look simpler, but I wasn't thinking about the libvirt.

> > -
> >   static char *pxb_host_ofw_unit_address(const SysBusDevice *dev)
> >   {
> >       const PCIHostState *pxb_host;
> > @@ -202,10 +214,6 @@ static void pxb_pcie_host_initfn(Object *obj)
> >       memory_region_init_io(&phb->data_mem, obj, &pci_host_data_le_ops,=
 phb,
> >                             "pci-conf-data", 4);
> >
> > -    object_property_add(obj, PCIE_HOST_MCFG_SIZE, "uint64",
> > -                         pxb_pcie_host_get_mmcfg_size,
> > -                         NULL, NULL, NULL, NULL);
>
> Same question
>
> > -
> >       object_property_add_link(obj, PROP_PXB_PCIE_DEV, TYPE_PXB_PCIE_DE=
VICE,
> >                            (Object **)&s->pxbdev,
> >                            qdev_prop_allow_set_link_before_realize, 0, =
NULL);
> > @@ -214,6 +222,7 @@ static void pxb_pcie_host_initfn(Object *obj)
> >   static Property pxb_pcie_host_props[] =3D {
> >       DEFINE_PROP_UINT64(PCIE_HOST_MCFG_BASE, PXBPCIEHost, parent_obj.b=
ase_addr,
> >                           PCIE_BASE_ADDR_UNMAPPED),
> > +    DEFINE_PROP_UINT64(PCIE_HOST_MCFG_SIZE, PXBPCIEHost, parent_obj.si=
ze, 0),
> >       DEFINE_PROP_END_OF_LIST(),
> >   };
> >
> > @@ -310,6 +319,8 @@ static gint pxb_compare(gconstpointer a, gconstpoin=
ter b)
> >              0;
> >   }
> >
> > +static uint64_t pxb_pcie_mcfg_base;
> > +
> >   static void pxb_dev_realize_common(PCIDevice *dev, bool pcie, Error *=
*errp)
> >   {
> >       PXBDev *pxb =3D convert_to_pxb(dev);
> > @@ -333,7 +344,16 @@ static void pxb_dev_realize_common(PCIDevice *dev,=
 bool pcie, Error **errp)
> >           ds =3D qdev_create(NULL, TYPE_PXB_PCIE_HOST);
> >
> >           object_property_set_link(OBJECT(ds), OBJECT(pxb),
> > -                                 PROP_PXB_PCIE_DEV, NULL);
> > +                                 PROP_PXB_PCIE_DEV, errp);
> > +
> > +        /* will be overwritten by firmware, but kept for readability *=
/
>
> Why bother the users to add this property if is the firmware responsibili=
ty
>   to provide it?

This is a dirty workaround, the problem is seabios has not loaded RSDP when
doing pci_setup. Since we specify different mcfg_base for pxb hosts, we can=
't
use hardcoded values  like q35 anymore. Therefore, we don't know the
mcfg_base in pci_setup, and we can't access it with MMCFG yet. Currently I
still use the ioport method to read the property as stated in previous patc=
h.

That is to say, in the patch seabios actually reads mcfg_base and mcfg_size
of pxb host from QEMU through ioport. I reserve the property so that seabio=
s
can get the mcfg_base and mcfg_size of all the pxb hosts and reserve them
in e820 table.

Am I misunderstanding it? I would like to know a better solution.

> > +        qdev_prop_set_uint64(ds, PCIE_HOST_MCFG_BASE,
> > +            pxb->domain_nr ? pxb_pcie_mcfg_base : MCH_HOST_BRIDGE_PCIE=
XBAR_DEFAULT);
>
> We can't take Q35 PCIEXBAR address for "no domain" case. In this case put
> some "none" value. 0 ?

I will change it to UNMAPPED value.

> > +        /* +1 because [bus_nr, max_bus] has (max_bus-bus_nr+1) buses *=
/
> > +        qdev_prop_set_uint64(ds, PCIE_HOST_MCFG_SIZE,
> > +            pxb->domain_nr ? (pxb->max_bus - pxb->bus_nr + 1ULL) * MiB=
 : 0);
> > +        if (pxb->domain_nr)
> > +            pxb_pcie_mcfg_base +=3D ((pxb->max_bus + 1ULL) * MiB);
> Can you provide the explanation for the computation? Why do we multiply
> by Mib?

A bus allows 32 devices and 8 slots, which is 32 * 8 * 4KB =3D 1MB, therefo=
re for
each bus we need to reserve 1MB in MCFG.

> >
> >           bus =3D pci_root_bus_new(ds, dev_name, NULL, NULL, 0, TYPE_PX=
B_PCIE_BUS);
> >       } else {
> > @@ -445,6 +465,9 @@ static void pxb_pcie_dev_realize(PCIDevice *dev, Er=
ror **errp)
> >           return;
> >       }
> >
> > +    if (0 =3D=3D pxb_pcie_mcfg_base)
>
> Please run scripts/checkpatch on the patches.

OK, I will run for following versions.

> > +        pxb_pcie_mcfg_base =3D pc_pci_mcfg_start();
> > +
> >       pxb_dev_realize_common(dev, true, errp);
> >   }
> >
> > diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> > index 02f9576..10e4801 100644
> > --- a/hw/pci-host/q35.c
> > +++ b/hw/pci-host/q35.c
> > @@ -177,6 +177,8 @@ static Property q35_host_props[] =3D {
> >                        mch.below_4g_mem_size, 0),
> >       DEFINE_PROP_SIZE(PCI_HOST_ABOVE_4G_MEM_SIZE, Q35PCIHost,
> >                        mch.above_4g_mem_size, 0),
> > +    /* q35 host bridge should always stay in pci domain 0 */
> > +    DEFINE_PROP_UINT32("domain_nr", Q35PCIHost, domain_nr, 0),
>
> Why do you need the property, if is always 0 ?

This is used to avoid special judge when building mcfg and AML, so that we =
just
need ot get this property without judging whether we are operating on
q35 host or
pxb host.

> >       DEFINE_PROP_BOOL("x-pci-hole64-fix", Q35PCIHost, pci_hole64_fix, =
true),
> >       DEFINE_PROP_END_OF_LIST(),
> >   };
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index 80bc459..ddc27ba 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -196,7 +196,8 @@ static void pci_del_option_rom(PCIDevice *pdev);
> >   static uint16_t pci_default_sub_vendor_id =3D PCI_SUBVENDOR_ID_REDHAT=
_QUMRANET;
> >   static uint16_t pci_default_sub_device_id =3D PCI_SUBDEVICE_ID_QEMU;
> >
> > -static QLIST_HEAD(, PCIHostState) pci_host_bridges;
> > +static QTAILQ_HEAD(, PCIHostState) pci_host_bridges =3D
> > +    QTAILQ_HEAD_INITIALIZER(pci_host_bridges);
> >
> >   int pci_bar(PCIDevice *d, int reg)
> >   {
> > @@ -330,7 +331,7 @@ static void pci_host_bus_register(DeviceState *host=
)
> >   {
> >       PCIHostState *host_bridge =3D PCI_HOST_BRIDGE(host);
> >
> > -    QLIST_INSERT_HEAD(&pci_host_bridges, host_bridge, next);
> > +    QTAILQ_INSERT_TAIL(&pci_host_bridges, host_bridge, next);
> >   }
> >
> >   PCIBus *pci_device_root_bus(const PCIDevice *d)
> > @@ -1798,7 +1799,7 @@ PciInfoList *qmp_query_pci(Error **errp)
> >       PciInfoList *info, *head =3D NULL, *cur_item =3D NULL;
> >       PCIHostState *host_bridge;
> >
> > -    QLIST_FOREACH(host_bridge, &pci_host_bridges, next) {
> > +    QTAILQ_FOREACH(host_bridge, &pci_host_bridges, next) {
> >           info =3D g_malloc0(sizeof(*info));
> >           info->value =3D qmp_query_pci_bus(host_bridge->bus,
> >                                           pci_bus_num(host_bridge->bus)=
);
> > @@ -2493,7 +2494,7 @@ int pci_qdev_find_device(const char *id, PCIDevic=
e **pdev)
> >       PCIHostState *host_bridge;
> >       int rc =3D -ENODEV;
> >
> > -    QLIST_FOREACH(host_bridge, &pci_host_bridges, next) {
> > +    QTAILQ_FOREACH(host_bridge, &pci_host_bridges, next) {
> >           int tmp =3D pci_qdev_find_recursive(host_bridge->bus, id, pde=
v);
> >           if (!tmp) {
> >               rc =3D 0;
> > diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> > index 6894f37..7955ef9 100644
> > --- a/include/hw/i386/pc.h
> > +++ b/include/hw/i386/pc.h
> > @@ -209,6 +209,7 @@ void pc_memory_init(PCMachineState *pcms,
> >                       MemoryRegion *rom_memory,
> >                       MemoryRegion **ram_memory);
> >   uint64_t pc_pci_hole64_start(void);
> > +uint64_t pc_pci_mcfg_start(void);
> >   qemu_irq pc_allocate_cpu_irq(void);
> >   DeviceState *pc_vga_init(ISABus *isa_bus, PCIBus *pci_bus);
> >   void pc_basic_device_init(ISABus *isa_bus, qemu_irq *gsi,
> > diff --git a/include/hw/pci-bridge/pci_expander_bridge.h b/include/hw/p=
ci-bridge/pci_expander_bridge.h
> > new file mode 100644
> > index 0000000..870c4cd
> > --- /dev/null
> > +++ b/include/hw/pci-bridge/pci_expander_bridge.h
> > @@ -0,0 +1,11 @@
> > +#ifndef HW_PCI_EXPANDER_H
> > +#define HW_PCI_EXPANDER_H
> > +
> > +#define PROP_PXB_PCIE_DEV "pxbdev"
> > +
> > +#define PROP_PXB_PCIE_DOMAIN_NR "domain_nr"
> > +#define PROP_PXB_BUS_NR "bus_nr"
> > +
> > +uint64_t pxb_pcie_mcfg_hole(void);
> > +
> > +#endif
> > diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
> > index 8f4ddde..432e569 100644
> > --- a/include/hw/pci-host/q35.h
> > +++ b/include/hw/pci-host/q35.h
> > @@ -69,6 +69,7 @@ typedef struct Q35PCIHost {
> >       /*< public >*/
> >
> >       bool pci_hole64_fix;
> > +    uint32_t domain_nr;
> >       MCHPCIState mch;
> >   } Q35PCIHost;
> >
> > diff --git a/include/hw/pci/pci_host.h b/include/hw/pci/pci_host.h
> > index ba31595..a5617cf 100644
> > --- a/include/hw/pci/pci_host.h
> > +++ b/include/hw/pci/pci_host.h
> > @@ -47,7 +47,7 @@ struct PCIHostState {
> >       uint32_t config_reg;
> >       PCIBus *bus;
> >
> > -    QLIST_ENTRY(PCIHostState) next;
> > +    QTAILQ_ENTRY(PCIHostState) next;
> >   };
> >
> >   typedef struct PCIHostBridgeClass {
>
> Please see if you can split this patch into several for the next version.

I will see that.

> Thanks,
> Marcel
>
