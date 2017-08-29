Received: from eggs.gnu.org ([2001:4830:134:3::10]:41999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dmfYo-0003t7-O4
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 08:24:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dmfYl-00019R-KR
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 08:24:02 -0400
Date: Tue, 29 Aug 2017 21:42:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170829114239.GP2578@umbus.fritz.box>
References: <20170328021651.19350-1-david@gibson.dropbear.id.au>
	<20170328021651.19350-2-david@gibson.dropbear.id.au>
	<20170426182155-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2/+Vq7w28QOSGzSM"
Content-Disposition: inline
In-Reply-To: <20170426182155-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [RFC for-2.10 1/3] pci/pcie: Make a consistent
 helper for switching PCI/PCIe "hybrid" devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: ehabkost@redhat.com, aik@ozlabs.ru, marcel@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lersek@redhat.com


--2/+Vq7w28QOSGzSM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 26, 2017 at 06:23:58PM +0300, Michael S. Tsirkin wrote:
> On Tue, Mar 28, 2017 at 01:16:49PM +1100, David Gibson wrote:
> > virtio-pci and XHCI are "hybrid" devices in the sense that they can pre=
sent
> > themselves as either PCIe or plain PCI devices depending on the machine
> > and bus they're connected to.
> >=20
> > For virtio-pci to present as PCIe it requires that it's connected to a =
PCIe
> > bus and that it's not a root bus - this is to ensure that the device is
> > connected via a PCIe root port or downstream port rather than being a
> > integrated endpoint.  Some guests (Windows in particular AIUI) don't re=
ally
> > cope with PCIe integrated endpoints.
> >=20
> > For XHCI it only checks that the bus is PCIe, but that probably means it
> > would cause problems if attached as an integrated devices directly to a
> > PCIe root bus.
> >=20
> > This patch makes the test consistent between XHCI and virtio-pci, and
> > clarifies things by having them both use a new 'pci_allow_hybrid_pcie()'
> > helper which performs the same check as virtio-pci.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/pci/pci.c           | 7 +++++++
> >  hw/usb/hcd-xhci.c      | 2 +-
> >  hw/virtio/virtio-pci.c | 3 +--
> >  include/hw/pci/pci.h   | 1 +
> >  4 files changed, 10 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index bd8043c..779787b 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -390,6 +390,13 @@ bool pci_bus_is_root(PCIBus *bus)
> >      return PCI_BUS_GET_CLASS(bus)->is_root(bus);
> >  }
> > =20
> > +bool pci_allow_hybrid_pcie(PCIDevice *pci_dev)
> > +{
> > +    PCIBus *bus =3D pci_dev->bus;
> > +
> > +    return pci_bus_is_express(bus) && !pci_bus_is_root(bus);
> > +}
> > +
> >  void pci_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceState *pa=
rent,
> >                           const char *name,
> >                           MemoryRegion *address_space_mem,
>=20
> I'd prefer pci_allow_hybrid_pci_pcie.

Ok, I've made that change for the next spin (aimed at 2.11, obviously).

>=20
> > diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> > index f0af852..a7ff4fd 100644
> > --- a/hw/usb/hcd-xhci.c
> > +++ b/hw/usb/hcd-xhci.c
> > @@ -3619,7 +3619,7 @@ static void usb_xhci_realize(struct PCIDevice *de=
v, Error **errp)
> >                       PCI_BASE_ADDRESS_SPACE_MEMORY|PCI_BASE_ADDRESS_ME=
M_TYPE_64,
> >                       &xhci->mem);
> > =20
> > -    if (pci_bus_is_express(dev->bus) ||
> > +    if (pci_allow_hybrid_pcie(dev) ||
> >          xhci_get_flag(xhci, XHCI_FLAG_FORCE_PCIE_ENDCAP)) {
> >          ret =3D pcie_endpoint_cap_init(dev, 0xa0);
> >          assert(ret >=3D 0);
>=20
> This seems to change the behaviour for xhci on a root bus - what
> am I missing?

Nothing.  I didn't consider the backwards compat implications; I'll
fix it for the next spin.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2/+Vq7w28QOSGzSM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmlUy0ACgkQbDjKyiDZ
s5K1gw//eek2Gy3xwqstfcQQnCnkaBvv3rEUnBR792WjfLsFJc/UbIK4saqEnXmo
HcDEDBHhcNWKGGBheghCS9i6mykdBgb8jO2lN6ca9ykJ3hX8nChR2LgAxnNMTQun
zI+QXFllqcg5eTk8QMu03fclY/287cJzHhGXtN5H9wLBgKxXvlIXJIJjydEcQiAu
oZSal9sIA+ObZGKiWMW5PPmDlHrq6G7G4e4D3WUhNepFsFQ/UtPt/M0amMehMq5r
LZO239RBB+YKrerbUrd2FWJUHBf0Ivof0UoogTicM5ZFFfaWwkiZGSISEYMZUz6h
JaNxT532d+aZ0LQNRTCz6e1CmtwiBi+mFiGq9qmSA0zjZPaz4EgdSW7NLrClkIqm
F1n6YiJvN1STYNVVEZLk95Nn196cI43JVQbX4rq8COE8fEXZwEtt2FojDMBAnpKN
cREneU+7IWsZtfOiDIZhy9nEONw19y6AZ/MGm20EbayH4ZYUuFydKVlHOCBnqugg
NEruaqHRiLNkKMELGt8ss3jUd5ERhFTgFEYHu52ewB9qrK08h4GT5uwTtXTFSfLH
YqP9MP6CsKJlAZBRCdbY87ZkX4sut9bRaP7WcrvBlOjeF8QHAtC1FMs8X8AVNoR1
WUSU2h9GqqhyYTmLzomtaIyMRBH31CqCLS1FyMUMPNT/IIymrPU=
=Tx15
-----END PGP SIGNATURE-----

--2/+Vq7w28QOSGzSM--
