Received: from eggs.gnu.org ([2001:4830:134:3::10]:52270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1frD3E-0000tS-Q7
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 22:02:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1frD3D-0000A8-Tu
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 22:02:44 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:38794)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <whois.zihan.yang@gmail.com>)
	id 1frD3D-00009w-NB
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 22:02:43 -0400
Received: by mail-lf1-x144.google.com with SMTP id a4-v6so8468339lff.5
	for <qemu-devel@nongnu.org>; Sat, 18 Aug 2018 19:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <1533796538-24173-1-git-send-email-whois.zihan.yang@gmail.com>
	<ac8e9422-e432-fd44-7416-540a8653dde3@gmail.com>
In-Reply-To: <ac8e9422-e432-fd44-7416-540a8653dde3@gmail.com>
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Sun, 19 Aug 2018 10:02:30 +0800
Message-ID: <CAKwiv-gJP=M4d=diFa3Ohm5p6nKiFPL=2b7Kd373d_HRzns=Yw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 6/6] i386/acpi-build: pxb-pcie start bus
 should always be 0 in separate pci domain
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
=8818=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=881:54=E5=86=99=E9=81=93=
=EF=BC=9A
>
>
>
> On 08/09/2018 09:35 AM, Zihan Yang wrote:
> > The bus_nr indicates the bus number of pxb-pcie under pcie.0, but since=
 pxb
> > host can be put into different pci domain, the start bus should always =
be 0
>
> I am  not sure about this limitation. Do you know where is coming from?
> Why do we must start a different pci_domain from 0? (Maybe we do, I just
> want to be sure)

I'm not sure about it either, for the same reason in previous patch. I thou=
ght
we should start from bus 0 always. I think I'll bring start_bus back
in next version.

> Thanks,
> Marcel
>
> >
> > Signed-off-by: Zihan Yang <whois.zihan.yang@gmail.com>
> > ---
> >   hw/i386/acpi-build.c                | 14 ++------------
> >   hw/pci-bridge/pci_expander_bridge.c | 10 +++++-----
> >   2 files changed, 7 insertions(+), 17 deletions(-)
> >
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index a7d9af2..0911008 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -91,7 +91,6 @@ typedef struct AcpiMcfgInfo {
> >       uint64_t mcfg_base;
> >       uint32_t mcfg_size;
> >       uint32_t domain_nr;
> > -    uint8_t bus_nr; // start bus number
> >       struct AcpiMcfgInfo *next;
> >   } AcpiMcfgInfo;
> >
> > @@ -2470,8 +2469,8 @@ build_mcfg_q35(GArray *table_data, BIOSLinker *li=
nker, AcpiMcfgInfo *info)
> >       while (info) {
> >           mcfg[0].allocation[count].address =3D cpu_to_le64(info->mcfg_=
base);
> >           mcfg[0].allocation[count].pci_segment =3D cpu_to_le16(info->d=
omain_nr);
> > -        mcfg[0].allocation[count].start_bus_number =3D info->bus_nr;
> > -        mcfg[0].allocation[count++].end_bus_number =3D info->bus_nr + =
\
> > +        mcfg[0].allocation[count].start_bus_number =3D 0;
> > +        mcfg[0].allocation[count++].end_bus_number =3D \
> >                                       PCIE_MMCFG_BUS(info->mcfg_size - =
1);
> >           info =3D info->next;
> >       }
> > @@ -2694,15 +2693,6 @@ static AcpiMcfgInfo *acpi_get_mcfg(void)
> >           mcfg->mcfg_size =3D qnum_get_uint(qobject_to(QNum, o));
> >           qobject_unref(o);
> >
> > -        o =3D object_property_get_qobject(obj, PROP_PXB_BUS_NR, NULL);
> > -        if (!o) {
> > -            /* we are in q35 host again */
> > -            mcfg->bus_nr =3D 0;
> > -        } else {
> > -            mcfg->bus_nr =3D qnum_get_uint(qobject_to(QNum, o));
> > -            qobject_unref(o);
> > -        }
> > -
> >           pci_host =3D OBJECT(QTAILQ_NEXT(PCI_HOST_BRIDGE(pci_host), ne=
xt));
> >       }
> >
> > diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_ex=
pander_bridge.c
> > index 686b026..53f5776 100644
> > --- a/hw/pci-bridge/pci_expander_bridge.c
> > +++ b/hw/pci-bridge/pci_expander_bridge.c
> > @@ -91,7 +91,7 @@ static int pxb_bus_num(PCIBus *bus)
> >   {
> >       PXBDev *pxb =3D convert_to_pxb(bus->parent_dev);
> >
> > -    return pxb->bus_nr;
> > +    return pxb->domain_nr ? 0 : pxb->bus_nr;
> >   }
> >
> >   static int pxb_domain_num(PCIBus *bus)
> > @@ -145,8 +145,8 @@ static void pxb_pcie_foreach(gpointer data, gpointe=
r user_data)
> >
> >       if (pxb->domain_nr > 0) {
> >           /* only reserve what users ask for to reduce memory cost. Plu=
s one
> > -         * as the interval [bus_nr, max_bus] has (max_bus-bus_nr+1) bu=
ses */
> > -        pxb_mcfg_hole_size +=3D ((pxb->max_bus - pxb->bus_nr + 1ULL) *=
 MiB);
> > +         * as the interval [0, max_bus] has (max_bus+1) buses */
> > +        pxb_mcfg_hole_size +=3D ((pxb->max_bus + 1ULL) * MiB);
> >       }
> >   }
> >
> > @@ -385,9 +385,9 @@ static void pxb_dev_realize_common(PCIDevice *dev, =
bool pcie, Error **errp)
> >           /* will be overwritten by firmware, but kept for readability =
*/
> >           qdev_prop_set_uint64(ds, PCIE_HOST_MCFG_BASE,
> >               pxb->domain_nr ? pxb_pcie_mcfg_base : MCH_HOST_BRIDGE_PCI=
EXBAR_DEFAULT);
> > -        /* +1 because [bus_nr, max_bus] has (max_bus-bus_nr+1) buses *=
/
> > +        /* +1 because [0, max_bus] has (max_bus+1) buses */
> >           qdev_prop_set_uint64(ds, PCIE_HOST_MCFG_SIZE,
> > -            pxb->domain_nr ? (pxb->max_bus - pxb->bus_nr + 1ULL) * MiB=
 : 0);
> > +            pxb->domain_nr ? (pxb->max_bus + 1ULL) * MiB : 0);
> >           if (pxb->domain_nr)
> >               pxb_pcie_mcfg_base +=3D ((pxb->max_bus + 1ULL) * MiB);
> >
>
