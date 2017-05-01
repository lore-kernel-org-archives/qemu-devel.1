Received: from eggs.gnu.org ([2001:4830:134:3::10]:52981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d55K3-0005Pg-6P
	for qemu-devel@nongnu.org; Mon, 01 May 2017 03:00:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d55K0-0007PJ-4B
	for qemu-devel@nongnu.org; Mon, 01 May 2017 03:00:39 -0400
Date: Mon, 1 May 2017 16:53:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170501065338.GA9514@umbus.fritz.box>
References: <20170328021651.19350-1-david@gibson.dropbear.id.au>
	<20170328021651.19350-2-david@gibson.dropbear.id.au>
	<20170426182155-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
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


--xHFwDpU9dbj6ez1V
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

So, I agree the current name isn't great, but that suggestion doesn't
make sense to me.  The function is determining if the hybrid device
should present as PCIe rather than PCI, not whether it's permitted at
all.

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

Nothing.  I need to fix this for the next spin.

>=20
> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > index f9b7244..9b34673 100644
> > --- a/hw/virtio/virtio-pci.c
> > +++ b/hw/virtio/virtio-pci.c
> > @@ -1737,8 +1737,7 @@ static void virtio_pci_realize(PCIDevice *pci_dev=
, Error **errp)
> >  {
> >      VirtIOPCIProxy *proxy =3D VIRTIO_PCI(pci_dev);
> >      VirtioPCIClass *k =3D VIRTIO_PCI_GET_CLASS(pci_dev);
> > -    bool pcie_port =3D pci_bus_is_express(pci_dev->bus) &&
> > -                     !pci_bus_is_root(pci_dev->bus);
> > +    bool pcie_port =3D pci_allow_hybrid_pcie(pci_dev);
> > =20
> >      if (!kvm_has_many_ioeventfds()) {
> >          proxy->flags &=3D ~VIRTIO_PCI_FLAG_USE_IOEVENTFD;
>=20
> I don't actually remember why do we disable pcie on a root port.
> Marcel, do you happen to know?

I assume you mean on a root bus rather than on a root port (in the
sense of under the root port's fake P2P bridge).  I was told it breaks
firmware and/or some guests on x86.

> > diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> > index a37a2d5..7b9a40f 100644
> > --- a/include/hw/pci/pci.h
> > +++ b/include/hw/pci/pci.h
> > @@ -453,6 +453,7 @@ void pci_for_each_bus(PCIBus *bus,
> > =20
> >  PCIBus *pci_find_primary_bus(void);
> >  PCIBus *pci_device_root_bus(const PCIDevice *d);
> > +bool pci_allow_hybrid_pcie(PCIDevice *pci_dev);
> >  const char *pci_root_bus_path(PCIDevice *dev);
> >  PCIDevice *pci_find_device(PCIBus *bus, int bus_num, uint8_t devfn);
> >  int pci_qdev_find_device(const char *id, PCIDevice **pdev);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZBttyAAoJEGw4ysog2bOSI1cQAMXJvcVoo+56W3yif77w3Ye/
ugMxJ3E5LRWNGjhGcAxKdMPDeDX8kd6DkeTcnihyKsCJa2oZ4zH+ayPrw8lqY85N
Yc8c3Pq3PK6SKkkemRjShsRgwxgCCd81qjhktUzRZDjFyBo7RIXGEZBm5ZBrcj9A
XeUksEwtfTAwT70xxRtZ7SxRYt8MZVi+gFfChRC8Vcvx+TKIeB/HNpzTipyvvOIf
3rFzAuzGVdb88rYyTQWF/93xYnr5qc7L3AyXlPju2wf1tVLY0hoPYR07MeFPXRsN
Wqbc10605pIJaM+s3ijpbsg/P/xu32X9HyzBEl5l5bQ4B9zkf+0+mBwuApH0XWVx
8hWc80RC+5fAK6/j+DFw1V3y0IduTjKW7owmj6ZYchdScGC7xHRowjRUsyXTXrwT
LadploAXFH2cKwdivkM08waNGHvUnsPPn2BXkLmjJENWkbQrqqg20oCZIRZPUN6/
xUwRACZhY1YR0i74eEawVKye2unse9y5E2kbLPUFnzl7ZurV4Hx8/BC/uoA9G+em
dKBW1OhRDXVeSrjfvaSPy86d48UzArckGaPLpzbIlzl7zRkTuZOsfaT9WdIrCeWA
x+Nz1BRVOezjNyljIiQyLLutizmq2rVNyGfGunHRAiX5KTWT4Do2+3NI7pi4LeEh
9gY8kxAelN53KCePHLpU
=YqLS
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
