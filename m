Received: from eggs.gnu.org ([2001:4830:134:3::10]:52135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1frD1v-00006A-2y
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 22:01:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1frD1u-0008HM-Cj
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 22:01:23 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:46553)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <whois.zihan.yang@gmail.com>)
	id 1frD1u-0008Gt-68
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 22:01:22 -0400
Received: by mail-lj1-x242.google.com with SMTP id 203-v6so9068085ljj.13
	for <qemu-devel@nongnu.org>; Sat, 18 Aug 2018 19:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <1533796513-23419-1-git-send-email-whois.zihan.yang@gmail.com>
	<74915968-f058-0a8b-1947-59b65e931e25@gmail.com>
In-Reply-To: <74915968-f058-0a8b-1947-59b65e931e25@gmail.com>
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Sun, 19 Aug 2018 10:01:09 +0800
Message-ID: <CAKwiv-hf_0xPgUUK2J48x691MPP8P_vWSz5SWBuzKFwK2CFkyA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 5/6] pci_expander_bridge: Add ioport for
 pxb host bus
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
=8818=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=881:52=E5=86=99=E9=81=93=
=EF=BC=9A
>
>
>
> On 08/09/2018 09:35 AM, Zihan Yang wrote:
> > This enables seabios to read config file in pxb host bus other than sys=
bus
> >
> > Signed-off-by: Zihan Yang <whois.zihan.yang@gmail.com>
> > ---
> >   hw/pci-bridge/pci_expander_bridge.c         | 15 +++++++++++++++
> >   include/hw/pci-bridge/pci_expander_bridge.h |  3 +++
> >   2 files changed, 18 insertions(+)
> >
> > diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_ex=
pander_bridge.c
> > index c685c75..686b026 100644
> > --- a/hw/pci-bridge/pci_expander_bridge.c
> > +++ b/hw/pci-bridge/pci_expander_bridge.c
> > @@ -234,6 +234,20 @@ static void pxb_pcie_host_initfn(Object *obj)
> >                            qdev_prop_allow_set_link_before_realize, 0, =
NULL);
> >   }
> >
> > +static void pxb_pcie_host_realize(DeviceState *dev, Error **errp)
> > +{
> > +    PCIHostState *pci =3D PCI_HOST_BRIDGE(dev);
> > +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> > +
> > +    // FIX ME! Use specific port number for pxb-pcie host bridge, not =
scalable!
> > +    /* port layout is | pxb1_cmd | pxb1_data | pxb2_cmd | pxb2_data | =
... | */
> > +    sysbus_add_io(sbd, PXB_PCIE_HOST_BRIDGE_CONFIG_ADDR_BASE, &pci->co=
nf_mem);
> > +    sysbus_init_ioports(sbd, PXB_PCIE_HOST_BRIDGE_CONFIG_ADDR_BASE + g=
_list_length(pxb_dev_list) * 8, 4);
> > +
> > +    sysbus_add_io(sbd, PXB_PCIE_HOST_BRIDGE_CONFIG_DATA_BASE, &pci->da=
ta_mem);
> > +    sysbus_init_ioports(sbd, PXB_PCIE_HOST_BRIDGE_CONFIG_DATA_BASE + g=
_list_length(pxb_dev_list) * 8, 4);
>
> Why do we need this functionality? Can't we access the pxb-pcie config
> space only with
> MMCFG?

This is for the same reason as mentioned in previous patch.

> Thanks,
> Marcel
>
> > +}
> > +
> >   static Property pxb_pcie_host_props[] =3D {
> >       DEFINE_PROP_UINT64(PCIE_HOST_MCFG_BASE, PXBPCIEHost, parent_obj.b=
ase_addr,
> >                           PCIE_BASE_ADDR_UNMAPPED),
> > @@ -262,6 +276,7 @@ static void pxb_pcie_host_class_init(ObjectClass *c=
lass, void *data)
> >
> >       dc->fw_name =3D "pcie";
> >       dc->props =3D pxb_pcie_host_props;
> > +    dc->realize =3D pxb_pcie_host_realize;
> >       /* Reason: Internal part of the pxb/pxb-pcie device, not usable b=
y itself */
> >       dc->user_creatable =3D false;
> >       sbc->explicit_ofw_unit_address =3D pxb_host_ofw_unit_address;
> > diff --git a/include/hw/pci-bridge/pci_expander_bridge.h b/include/hw/p=
ci-bridge/pci_expander_bridge.h
> > index 1119210..e6d3b67 100644
> > --- a/include/hw/pci-bridge/pci_expander_bridge.h
> > +++ b/include/hw/pci-bridge/pci_expander_bridge.h
> > @@ -7,6 +7,9 @@
> >   #define PROP_PXB_PCIE_DOMAIN_NR "domain_nr"
> >   #define PROP_PXB_BUS_NR "bus_nr"
> >
> > +#define PXB_PCIE_HOST_BRIDGE_CONFIG_ADDR_BASE 0x1000
> > +#define PXB_PCIE_HOST_BRIDGE_CONFIG_DATA_BASE 0x1004
> > +
> >   uint64_t pxb_pcie_mcfg_hole(void);
> >
> >   #endif
>
