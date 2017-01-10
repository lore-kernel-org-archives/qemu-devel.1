Received: from eggs.gnu.org ([2001:4830:134:3::10]:39307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cQmtR-00080Z-Ld
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 22:14:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cQmtN-0002xs-MH
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 22:14:37 -0500
Date: Tue, 10 Jan 2017 05:14:30 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170110051358-mutt-send-email-mst@kernel.org>
References: <1483049536-21548-1-git-send-email-hpoussin@reactos.org>
	<1483049536-21548-2-git-send-email-hpoussin@reactos.org>
	<20170102230125.GE12761@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170102230125.GE12761@umbus.fritz.box>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/6] pci: add pci_vga_type(),
 giving the device name of the chosen VGA device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, Giancarlo Teodori <gteodori@gmail.com>, Marcel Apfelbaum <marcel@redhat.com>

On Tue, Jan 03, 2017 at 10:01:25AM +1100, David Gibson wrote:
> On Thu, Dec 29, 2016 at 11:12:11PM +0100, Herv=E9 Poussineau wrote:
> > This is in fact a split of pci_vga_init() function in two parts.
> >=20
> > Signed-off-by: Herv=E9 Poussineau <hpoussin@reactos.org>
>=20
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> I think it needs Michael or someone to merge it though.

Do we have to keep poking at pci_vga_type?
I'd rather people just used -device for everything.

> > ---
> >  hw/pci/pci.c         | 22 ++++++++++++++++------
> >  include/hw/pci/pci.h |  1 +
> >  2 files changed, 17 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index 24fae16..0d5a862 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -1816,19 +1816,19 @@ PCIDevice *pci_nic_init_nofail(NICInfo *nd, P=
CIBus *rootbus,
> >      return pci_dev;
> >  }
> > =20
> > -PCIDevice *pci_vga_init(PCIBus *bus)
> > +const char *pci_vga_type(void)
> >  {
> >      switch (vga_interface_type) {
> >      case VGA_CIRRUS:
> > -        return pci_create_simple(bus, -1, "cirrus-vga");
> > +        return "cirrus-vga";
> >      case VGA_QXL:
> > -        return pci_create_simple(bus, -1, "qxl-vga");
> > +        return "qxl-vga";
> >      case VGA_STD:
> > -        return pci_create_simple(bus, -1, "VGA");
> > +        return "VGA";
> >      case VGA_VMWARE:
> > -        return pci_create_simple(bus, -1, "vmware-svga");
> > +        return "vmware-svga";
> >      case VGA_VIRTIO:
> > -        return pci_create_simple(bus, -1, "virtio-vga");
> > +        return "virtio-vga";
> >      case VGA_NONE:
> >      default: /* Other non-PCI types. Checking for unsupported types =
is already
> >                  done in vl.c. */
> > @@ -1836,6 +1836,16 @@ PCIDevice *pci_vga_init(PCIBus *bus)
> >      }
> >  }
> > =20
> > +PCIDevice *pci_vga_init(PCIBus *bus)
> > +{
> > +    const char *vga_type =3D pci_vga_type();
> > +    if (vga_type) {
> > +        return pci_create_simple(bus, -1, vga_type);
> > +    } else {
> > +        return NULL;
> > +    }
> > +}
> > +
> >  /* Whether a given bus number is in range of the secondary
> >   * bus of the given bridge device. */
> >  static bool pci_secondary_bus_in_range(PCIDevice *dev, int bus_num)
> > diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> > index 772692f..aa8d014 100644
> > --- a/include/hw/pci/pci.h
> > +++ b/include/hw/pci/pci.h
> > @@ -420,6 +420,7 @@ PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIBu=
s *rootbus,
> >                                 const char *default_model,
> >                                 const char *default_devaddr);
> > =20
> > +const char *pci_vga_type(void);
> >  PCIDevice *pci_vga_init(PCIBus *bus);
> > =20
> >  int pci_bus_num(PCIBus *s);
>=20
> --=20
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _oth=
er_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson
