Received: from eggs.gnu.org ([2001:4830:134:3::10]:45837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fW2op-0007hF-Jg
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:52:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fW2oo-0006lm-5w
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:52:23 -0400
Received: from mail-lf0-x22c.google.com ([2a00:1450:4010:c07::22c]:37362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <whois.zihan.yang@gmail.com>)
	id 1fW2on-0006l7-Pf
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:52:22 -0400
Received: by mail-lf0-x22c.google.com with SMTP id g21-v6so5319309lfb.4
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 09:52:21 -0700 (PDT)
MIME-Version: 1.0
References: <1528794804-6289-1-git-send-email-whois.zihan.yang@gmail.com>
	<1528794804-6289-3-git-send-email-whois.zihan.yang@gmail.com>
	<60e47271-dca6-2c7e-0a22-60b222051dad@gmail.com>
In-Reply-To: <60e47271-dca6-2c7e-0a22-60b222051dad@gmail.com>
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Fri, 22 Jun 2018 00:52:08 +0800
Message-ID: <CAKwiv-ghNpsysmS+bJRRwYfrQMSucsG4JsFPDXoSqyLNQ-nfqw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 3/3] acpi-build: describe new pci domain
 in AML
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

Marcel Apfelbaum <marcel.apfelbaum@gmail.com> =E4=BA=8E2018=E5=B9=B46=E6=9C=
=8820=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=883:46=E5=86=99=E9=81=93=
=EF=BC=9A
>
>
>
> On 06/12/2018 12:13 PM, Zihan Yang wrote:
> > Describe new pci segments of host bridges in AML. The host bridge list =
is
> > replaced by QTAILQ to let q35 host be processed first in every traverse
> >
> > Signed-off-by: Zihan Yang <whois.zihan.yang@gmail.com>
> > ---
> >   hw/i386/acpi-build.c      | 69 ++++++++++++++++++++++++++++++--------=
---------
> >   hw/pci/pci.c              |  9 ++++---
> >   include/hw/pci/pci_host.h |  2 +-
> >   3 files changed, 50 insertions(+), 30 deletions(-)
> >
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index 104e52d..a9f1503 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -2123,36 +2123,55 @@ build_dsdt(GArray *table_data, BIOSLinker *link=
er,
> >       sb_scope =3D aml_scope("\\_SB");
> >       {
> >           Object *pci_host;
> > +        QObject *o;
> >           PCIBus *bus =3D NULL;
> > +        uint32_t domain_nr;
> > +        bool q35host =3D true;
> >
> >           pci_host =3D acpi_get_i386_pci_host();
> > -        if (pci_host) {
> > +        while (pci_host) {
> > +            o =3D object_property_get_qobject(pci_host, "domain_nr", N=
ULL);
> > +            assert(o);
> > +            domain_nr =3D qnum_get_uint(qobject_to(QNum, o));
> > +            qobject_unref(o);
> > +
> > +            /* skip expander bridges that still reside in domain 0 */
> > +            if (!q35host && domain_nr =3D=3D 0) {
> > +                pci_host =3D OBJECT(QTAILQ_NEXT(PCI_HOST_BRIDGE(pci_ho=
st), next));
>
> Why do you skip pci_hosts without domain? We still want to add them to
> the DSDT, right ?

I think I might misunderstand it. Currently QEMU seems to treat expander
host bridge as normal a PCIe device under main system bus. I thought we
want to preserve current behavior, so my purpose is to only add expander
bridges with a non-zero domain_nr into DSDT, and let the other bridges
be the PCIe devices of these bridges. Do you mean we should add every
host bridge no matter we want it to reside in a different domain or not?

> > +                continue;
> > +            }
> >               bus =3D PCI_HOST_BRIDGE(pci_host)->bus;
> > -        }
> >
> > -        if (bus) {
> > -            Aml *scope =3D aml_scope("PCI0");
> > -            /* Scan all PCI buses. Generate tables to support hotplug.=
 */
> > -            build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_=
en);
> > +            if (bus) {
> > +                Aml *scope =3D aml_scope("PCI0");
> > +                aml_append(scope, aml_name_decl("_SEG", aml_int(domain=
_nr)));
> > +                /* For simplicity, base bus number starts from 0 */
> > +                aml_append(scope, aml_name_decl("_BBN", aml_int(0)));
>
> Nice. _SEG and _BBN should be enough to let the guest know we have multip=
le
> PCI domains.
>
> > +                /* Scan all PCI buses. Generate tables to support hotp=
lug. */
> > +                build_append_pci_bus_devices(scope, bus, pm->pcihp_bri=
dge_en);
> >
> > -            if (TPM_IS_TIS(tpm_find())) {
> > -                dev =3D aml_device("ISA.TPM");
> > -                aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0=
C31")));
> > -                aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
> > -                crs =3D aml_resource_template();
> > -                aml_append(crs, aml_memory32_fixed(TPM_TIS_ADDR_BASE,
> > -                           TPM_TIS_ADDR_SIZE, AML_READ_WRITE));
> > -                /*
> > -                    FIXME: TPM_TIS_IRQ=3D5 conflicts with PNP0C0F irqs=
,
> > -                    Rewrite to take IRQ from TPM device model and
> > -                    fix default IRQ value there to use some unused IRQ
> > -                 */
> > -                /* aml_append(crs, aml_irq_no_flags(TPM_TIS_IRQ)); */
> > -                aml_append(dev, aml_name_decl("_CRS", crs));
> > -                aml_append(scope, dev);
> > +                if (TPM_IS_TIS(tpm_find())) {
> > +                    dev =3D aml_device("ISA.TPM");
> > +                    aml_append(dev, aml_name_decl("_HID", aml_eisaid("=
PNP0C31")));
> > +                    aml_append(dev, aml_name_decl("_STA", aml_int(0xF)=
));
> > +                    crs =3D aml_resource_template();
> > +                    aml_append(crs, aml_memory32_fixed(TPM_TIS_ADDR_BA=
SE,
> > +                               TPM_TIS_ADDR_SIZE, AML_READ_WRITE));
> > +                    /*
> > +                        FIXME: TPM_TIS_IRQ=3D5 conflicts with PNP0C0F =
irqs,
> > +                        Rewrite to take IRQ from TPM device model and
> > +                        fix default IRQ value there to use some unused=
 IRQ
> > +                     */
> > +                    /* aml_append(crs, aml_irq_no_flags(TPM_TIS_IRQ));=
 */
> > +                    aml_append(dev, aml_name_decl("_CRS", crs));
> > +                    aml_append(scope, dev);
> > +                }
> > +
> > +                aml_append(sb_scope, scope);
> >               }
> > -
> > -            aml_append(sb_scope, scope);
> > +            /* q35 host is the first one in the tail queue */
> > +            q35host =3D false;
>
> I don't think you should use this hack. Add a domain_nr property to the
> q35 host
> and set it always to 0. Then you don't need special cases.

This looks the same as the problem above, if each host bridge will be added
into DSDT regardless of its domain_nr, then no special cases are needed.

> > +            pci_host =3D OBJECT(QTAILQ_NEXT(PCI_HOST_BRIDGE(pci_host),=
 next));
> >           }
> >       }
> >
> > @@ -2645,7 +2664,7 @@ static AcpiMcfgInfo *acpi_get_mcfg(void)
> >           qobject_unref(o);
> >           /* skip q35 host and bridges that reside in the same domain w=
ith it */
> >           if (domain_nr =3D=3D 0) {
> > -            pci_host =3D OBJECT(QLIST_NEXT(PCI_HOST_BRIDGE(pci_host), =
next));
> > +            pci_host =3D OBJECT(QTAILQ_NEXT(PCI_HOST_BRIDGE(pci_host),=
 next));
> >               continue;
> >           }
> >
> > @@ -2674,7 +2693,7 @@ static AcpiMcfgInfo *acpi_get_mcfg(void)
> >           assert(o);
> >           mcfg->domain_nr =3D qnum_get_uint(qobject_to(QNum, o));
> >
> > -        pci_host =3D OBJECT(QLIST_NEXT(PCI_HOST_BRIDGE(pci_host), next=
));
> > +        pci_host =3D OBJECT(QTAILQ_NEXT(PCI_HOST_BRIDGE(pci_host), nex=
t));
> >       }
> >
> >       return head;
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index 80bc459..f63385f 100644
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
> > +    QTAILQ_INSERT_HEAD(&pci_host_bridges, host_bridge, next);
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
> Looking good, do you have something working?

Not yet, but I will finish my last exam next week, then I will try to get
seabios part working as soon as possible. Sorry for the delay.

> Thanks,
> Marcel
>
