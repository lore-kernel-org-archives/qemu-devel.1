Received: from eggs.gnu.org ([2001:4830:134:3::10]:45369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fW2mM-0005f7-OB
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:49:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fW2mK-0004qx-Py
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:49:50 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:35213)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <whois.zihan.yang@gmail.com>)
	id 1fW2mK-0004qI-D9
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:49:48 -0400
Received: by mail-lf0-x241.google.com with SMTP id i15-v6so5321205lfc.2
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 09:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <1528794804-6289-1-git-send-email-whois.zihan.yang@gmail.com>
	<1528794804-6289-2-git-send-email-whois.zihan.yang@gmail.com>
	<a6014b3a-0e1c-47e6-7b10-4873358864c3@gmail.com>
In-Reply-To: <a6014b3a-0e1c-47e6-7b10-4873358864c3@gmail.com>
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Fri, 22 Jun 2018 00:49:34 +0800
Message-ID: <CAKwiv-jnGkCWqkMKB+osxBG1vfu5jERHO6D90M=dPfvbS+J5CQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 2/3] acpi-build: allocate mcfg for
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
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

Thanks for your review.

Marcel Apfelbaum <marcel.apfelbaum@gmail.com> =E4=BA=8E2018=E5=B9=B46=E6=9C=
=8820=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=883:41=E5=86=99=E9=81=93=
=EF=BC=9A
>
>
>
> On 06/12/2018 12:13 PM, Zihan Yang wrote:
> > Allocate new segment for pxb-pcie host bridges in MCFG table, and reser=
ve
> > corresponding MCFG space for them. This allows user-defined pxb-pcie
> > host bridges to be placed in different pci domain than q35 host
> >
> > Signed-off-by: Zihan Yang <whois.zihan.yang@gmail.com>
> > ---
> >   hw/i386/acpi-build.c                        | 97 ++++++++++++++++++++=
+++------
> >   hw/i386/pc.c                                | 14 ++++-
> >   hw/pci-bridge/pci_expander_bridge.c         | 52 +++++++++++-----
> >   hw/pci-host/q35.c                           |  2 +
> >   include/hw/i386/pc.h                        |  1 +
> >   include/hw/pci-bridge/pci_expander_bridge.h |  6 ++
> >   include/hw/pci-host/q35.h                   |  1 +
> >   7 files changed, 137 insertions(+), 36 deletions(-)
> >   create mode 100644 include/hw/pci-bridge/pci_expander_bridge.h
> >
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index 9bc6d97..104e52d 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -89,6 +89,8 @@
> >   typedef struct AcpiMcfgInfo {
> >       uint64_t mcfg_base;
> >       uint32_t mcfg_size;
> > +    uint32_t domain_nr;
> > +    struct AcpiMcfgInfo *next;
> >   } AcpiMcfgInfo;
> >
> >   typedef struct AcpiPmInfo {
> > @@ -2427,14 +2429,16 @@ build_mcfg_q35(GArray *table_data, BIOSLinker *=
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
> > -    mcfg->allocation[0].pci_segment =3D cpu_to_le16(0);
> > -    mcfg->allocation[0].start_bus_number =3D 0;
> > -    mcfg->allocation[0].end_bus_number =3D PCIE_MMCFG_BUS(info->mcfg_s=
ize - 1);
> >
> >       /* MCFG is used for ECAM which can be enabled or disabled by gues=
t.
> >        * To avoid table size changes (which create migration issues),
> > @@ -2448,6 +2452,15 @@ build_mcfg_q35(GArray *table_data, BIOSLinker *l=
inker, AcpiMcfgInfo *info)
> >       } else {
> >           sig =3D "MCFG";
> >       }
> > +
> > +    while (info) {
> > +        mcfg[count].allocation[0].address =3D cpu_to_le64(info->mcfg_b=
ase);
> > +        mcfg[count].allocation[0].pci_segment =3D cpu_to_le16(info->do=
main_nr);
> > +        mcfg[count].allocation[0].start_bus_number =3D 0;
> > +        mcfg[count++].allocation[0].end_bus_number =3D PCIE_MMCFG_BUS(=
info->mcfg_size - 1);
>
> I think you want to use here max_bus property defined in the prev patch.

mcfg_size is calculated by the max_bus, but it does seems more readable
to use max_bus here.

> > +        info =3D info->next;
> > +    }
> > +
> >       build_header(linker, table_data, (void *)mcfg, sig, len, 1, NULL,=
 NULL);
> >   }
> >
> > @@ -2602,26 +2615,69 @@ struct AcpiBuildState {
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
> > +        o =3D object_property_get_qobject(pci_host, "domain_nr", NULL)=
;
> > +        if (!o) {
>
> If every pci_host is supposed to have a domain_nr is better to assert her=
e.

OK, I get it.

> > +            cleanup_mcfg(head);
> > +            return NULL;
> > +        }
> > +        domain_nr =3D qnum_get_uint(qobject_to(QNum, o));
> > +        qobject_unref(o);
> > +        /* skip q35 host and bridges that reside in the same domain wi=
th it */
> > +        if (domain_nr =3D=3D 0) {
> > +            pci_host =3D OBJECT(QLIST_NEXT(PCI_HOST_BRIDGE(pci_host), =
next));
> > +            continue;
>
> The default q35 pci host will not have a MMCFG?

I must have got my brain messed up.. The original purpose was to let q35hos=
t
reside in pci domain 0, and all the expander host bridges that have non-zer=
o
domain_nr reside in their corresponding domains. Expander bridges whose
domain_nr equals to 0 are skipped because they don't actually specify a dom=
ain.

I thought I added q35 host when I wrote the code at the beginning, there mi=
ght
be some mistakes when I fotmat  the code later on. I will correct them in n=
ext
version.

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
> > +        mcfg->domain_nr =3D domain_nr;
> > +
> > +        o =3D object_property_get_qobject(pci_host, PCIE_HOST_MCFG_BAS=
E, NULL);
> > +        assert(o);
> > +        mcfg->mcfg_base =3D qnum_get_uint(qobject_to(QNum, o));
> > +        qobject_unref(o);
> > +
> > +        /* firmware will overwrite it */
> > +        o =3D object_property_get_qobject(pci_host, PCIE_HOST_MCFG_SIZ=
E, NULL);
> > +        assert(o);
> > +        mcfg->mcfg_size =3D qnum_get_uint(qobject_to(QNum, o));
> > +        qobject_unref(o);
> > +
> > +        o =3D object_property_get_qobject(pci_host, "domain_nr", NULL)=
;
> > +        assert(o);
> > +        mcfg->domain_nr =3D qnum_get_uint(qobject_to(QNum, o));
>
> You already have the domain_nr.

That seems a mistake, I will recode this piece of code in next version.

> > +
> > +        pci_host =3D OBJECT(QLIST_NEXT(PCI_HOST_BRIDGE(pci_host), next=
));
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
> > @@ -2633,7 +2689,7 @@ void acpi_build(AcpiBuildTables *tables, MachineS=
tate *machine)
> >       unsigned facs, dsdt, rsdt, fadt;
> >       AcpiPmInfo pm;
> >       AcpiMiscInfo misc;
> > -    AcpiMcfgInfo mcfg;
> > +    AcpiMcfgInfo *mcfg;
> >       Range pci_hole, pci_hole64;
> >       uint8_t *u;
> >       size_t aml_len =3D 0;
> > @@ -2714,10 +2770,11 @@ void acpi_build(AcpiBuildTables *tables, Machin=
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
> >       if (x86_iommu_get_default()) {
> >           IommuType IOMMUType =3D x86_iommu_get_type();
> >           if (IOMMUType =3D=3D TYPE_AMD) {
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index f3befe6..95f6c34 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -34,6 +34,7 @@
> >   #include "hw/ide.h"
> >   #include "hw/pci/pci.h"
> >   #include "hw/pci/pci_bus.h"
> > +#include "hw/pci-bridge/pci_expander_bridge.h"
> >   #include "hw/nvram/fw_cfg.h"
> >   #include "hw/timer/hpet.h"
> >   #include "hw/smbios/smbios.h"
> > @@ -1469,15 +1470,24 @@ uint64_t pc_pci_hole64_start(void)
> >       if (pcmc->has_reserved_memory && ms->device_memory->base) {
> >           hole64_start =3D ms->device_memory->base;
> >           if (!pcmc->broken_reserved_end) {
> > -            hole64_start +=3D memory_region_size(&ms->device_memory->m=
r);
> > +            hole64_start +=3D (memory_region_size(&ms->device_memory->=
mr) + \
> > +                            pxb_pcie_mcfg_hole());
> >           }
> >       } else {
> > -        hole64_start =3D 0x100000000ULL + pcms->above_4g_mem_size;
> > +        /* memory layout [RAM Hotplug][MCFG][..ROUND UP..][PCI HOLE] *=
/
> > +        hole64_start =3D pc_pci_mcfg_start() + pxb_pcie_mcfg_hole();
> >       }
> >
> >       return ROUND_UP(hole64_start, 1ULL << 30);
> >   }
> >
> > +uint64_t pc_pci_mcfg_start(void)
> > +{
> > +    PCMachineState *pcms =3D PC_MACHINE(qdev_get_machine());
> > +
> > +    return ROUND_UP(0x100000000ULL + pcms->above_4g_mem_size, 1ULL << =
12);
> > +}
> > +
> >   qemu_irq pc_allocate_cpu_irq(void)
> >   {
> >       return qemu_allocate_irq(pic_irq_request, NULL, 0);
> > diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_ex=
pander_bridge.c
> > index 448b9fb..14f0447 100644
> > --- a/hw/pci-bridge/pci_expander_bridge.c
> > +++ b/hw/pci-bridge/pci_expander_bridge.c
> > @@ -12,11 +12,14 @@
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
> > @@ -118,6 +121,25 @@ static const TypeInfo pxb_pcie_bus_info =3D {
> >       .class_init    =3D pxb_bus_class_init,
> >   };
> >
> > +static uint64_t pxb_mcfg_hole_size =3D 0;
> > +
>
> No need to initialize a static to 0.
>
> > +static void pxb_pcie_foreach(gpointer data, gpointer user_data)
> > +{
> > +    PXBDev *pxb =3D (PXBDev *)data;
> > +
> > +    if (pxb->sep_domain && pxb->domain_nr > 0) {
> > +        // only reserve what users ask for to reduce memory cost
> > +        pxb_mcfg_hole_size +=3D ((pxb->max_bus + 1ULL) << 20);
>
> Why "+ 1" ?
> Please replace 20 with a MACRO explaining it.

Sorry for the confusion. This is because max_bus specify the maximum
bus number that will be used. For example, if max_bus is 255(0xff),
then the actual bus numbers are (255 + 1) =3D 256. But since max_bus
is uint8_t, I can't initialize it to 256, therefore it should +1 when
calculating the bus numbers in use.

left shift 20 bits means 1MB, I will add a macro for it.


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
> > @@ -145,14 +167,6 @@ static const char *pxb_pcie_host_root_bus_path(PCI=
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
> > -
> >   static char *pxb_host_ofw_unit_address(const SysBusDevice *dev)
> >   {
> >       const PCIHostState *pxb_host;
> > @@ -192,16 +206,12 @@ static void pxb_pcie_host_initfn(Object *obj)
> >                             "pci-conf-idx", 4);
> >       memory_region_init_io(&phb->data_mem, obj, &pci_host_data_le_ops,=
 phb,
> >                             "pci-conf-data", 4);
> > -
> > -    object_property_add(obj, PCIE_HOST_MCFG_SIZE, "uint64",
> > -                         pxb_pcie_host_get_mmcfg_size,
> > -                         NULL, NULL, NULL, NULL);
> > -
> >   }
> >
> >   static Property pxb_pcie_host_props[] =3D {
> >       DEFINE_PROP_UINT64(PCIE_HOST_MCFG_BASE, PXBPCIEHost, parent_obj.b=
ase_addr,
> > -                        PCIE_BASE_ADDR_UNMAPPED),
> > +                       PCIE_BASE_ADDR_UNMAPPED),
> > +    DEFINE_PROP_UINT64(PCIE_HOST_MCFG_SIZE, PXBPCIEHost, parent_obj.si=
ze, 0),
> >       DEFINE_PROP_UINT32("domain_nr", PXBPCIEHost, domain_nr, 0),
> >       DEFINE_PROP_UINT8("bus_nr", PXBPCIEHost, bus_nr, 0),
> >       DEFINE_PROP_UINT8("max_bus", PXBPCIEHost, max_bus, 255),
> > @@ -301,6 +311,8 @@ static gint pxb_compare(gconstpointer a, gconstpoin=
ter b)
> >              0;
> >   }
> >
> > +static uint64_t pxb_pcie_mcfg_base =3D 0;
> > +
> >   static void pxb_dev_realize_common(PCIDevice *dev, bool pcie, Error *=
*errp)
> >   {
> >       PXBDev *pxb =3D convert_to_pxb(dev);
> > @@ -327,6 +339,15 @@ static void pxb_dev_realize_common(PCIDevice *dev,=
 bool pcie, Error **errp)
> >           qdev_prop_set_uint8(ds, "bus_nr", pxb->bus_nr); //TODO.
> >           qdev_prop_set_uint8(ds, "max_bus", pxb->max_bus);
> >           qdev_prop_set_uint8(ds, "domain_nr", pxb->domain_nr);
> > +
> > +        /* will be overwritten by firmware, but kept for readability *=
/
> > +        qdev_prop_set_uint64(ds, PCIE_HOST_MCFG_BASE,
> > +            pxb->domain_nr ? pxb_pcie_mcfg_base : MCH_HOST_BRIDGE_PCIE=
XBAR_DEFAULT);
> > +        qdev_prop_set_uint64(ds, PCIE_HOST_MCFG_SIZE,
> > +            pxb->domain_nr ? (pxb->max_bus + 1ULL) << 20 : 0);
> > +        if (pxb->domain_nr)
> > +            pxb_pcie_mcfg_base +=3D ((pxb->max_bus + 1ULL) << 20);
> > +
> >           bus =3D pci_root_bus_new(ds, dev_name, NULL, NULL, 0, TYPE_PX=
B_PCIE_BUS);
> >       } else {
> >           ds =3D qdev_create(NULL, TYPE_PXB_HOST);
> > @@ -438,6 +459,9 @@ static void pxb_pcie_dev_realize(PCIDevice *dev, Er=
ror **errp)
> >           return;
> >       }
> >
> > +    if (0 =3D=3D pxb_pcie_mcfg_base)
> > +        pxb_pcie_mcfg_base =3D pc_pci_mcfg_start();
> > +
> >       pxb_dev_realize_common(dev, true, errp);
> >   }
> >
> > diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> > index 02f9576..a76029d 100644
> > --- a/hw/pci-host/q35.c
> > +++ b/hw/pci-host/q35.c
> > @@ -178,6 +178,8 @@ static Property q35_host_props[] =3D {
> >       DEFINE_PROP_SIZE(PCI_HOST_ABOVE_4G_MEM_SIZE, Q35PCIHost,
> >                        mch.above_4g_mem_size, 0),
> >       DEFINE_PROP_BOOL("x-pci-hole64-fix", Q35PCIHost, pci_hole64_fix, =
true),
> > +    /* q35 host bridge should always stay in pci domain 0 */
> > +    DEFINE_PROP_UINT32("domain_nr", Q35PCIHost, domain_nr, 0),
> >       DEFINE_PROP_END_OF_LIST(),
> >   };
> >
> > diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> > index 04d1f8c..81ba010 100644
> > --- a/include/hw/i386/pc.h
> > +++ b/include/hw/i386/pc.h
> > @@ -212,6 +212,7 @@ void pc_memory_init(PCMachineState *pcms,
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
> > index 0000000..bb1462c
> > --- /dev/null
> > +++ b/include/hw/pci-bridge/pci_expander_bridge.h
> > @@ -0,0 +1,6 @@
> > +#ifndef HW_PCI_EXPANDER_H
> > +#define HW_PCI_EXPANDER_H
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
>
> Thanks,
> Marcel
>
