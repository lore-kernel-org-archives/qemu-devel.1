Received: from eggs.gnu.org ([2001:4830:134:3::10]:41020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dxTl2-0000do-6D
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 04:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dxTkw-0007pm-6r
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 04:01:20 -0400
Date: Thu, 28 Sep 2017 17:53:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170928075331.GC6445@umbus.fritz.box>
References: <20170328021651.19350-1-david@gibson.dropbear.id.au>
	<20170328021651.19350-3-david@gibson.dropbear.id.au>
	<20170426182535-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GZVR6ND4mMseVXL/"
Content-Disposition: inline
In-Reply-To: <20170426182535-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [RFC for-2.10 2/3] pci: Allow host bridges to
 override PCI/PCIe hybrid device behaviour
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


--GZVR6ND4mMseVXL/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 26, 2017 at 06:29:05PM +0300, Michael S. Tsirkin wrote:
> On Tue, Mar 28, 2017 at 01:16:50PM +1100, David Gibson wrote:
> > Currently PCI/PCIe hybrid devices - that is, devices which can appear as
> > either plain PCI or PCIe depending on where they're attached - will only
> > appear in PCIe mode if they're attached to a PCIe bus via a root port or
> > downstream port.
> >=20
> > This is correct for "standard" PCIe setups, but there are some platforms
> > which need different behaviour (notably "pseries" whose paravirtualized
> > PCI host bridges have some idiosyncracies).
> >=20
> > This patch allows the host bridge to override the normal behaviour.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/pci/pci.c              | 11 +++++++++--
> >  include/hw/pci/pci_host.h |  1 +
> >  2 files changed, 10 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index 779787b..ac68065 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -392,9 +392,16 @@ bool pci_bus_is_root(PCIBus *bus)
> > =20
> >  bool pci_allow_hybrid_pcie(PCIDevice *pci_dev)
> >  {
> > -    PCIBus *bus =3D pci_dev->bus;
> > +    PCIHostState *host_bridge =3D PCI_HOST_BRIDGE(pci_device_root_bus(=
pci_dev)->qbus.parent);
> > +    PCIHostBridgeClass *hc =3D PCI_HOST_BRIDGE_GET_CLASS(host_bridge);
> > +
> > +    if (hc->allow_hybrid_pcie) {
> > +        return hc->allow_hybrid_pcie(host_bridge, pci_dev);
> > +    } else {
> > +        PCIBus *bus =3D pci_dev->bus;
> > =20
> > -    return pci_bus_is_express(bus) && !pci_bus_is_root(bus);
> > +        return pci_bus_is_express(bus) && !pci_bus_is_root(bus);
> > +    }
> >  }
> > =20
> >  void pci_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceState *pa=
rent,
>=20
> I think I'd prefer adding some flags in PCIBus. While we are at it,
> is_root can become a flag too.

Good idea!  Looking at it the is_root() method really is bogus, I have
a draft patch which replaces it with a flag.  (In fact the other
PCIBusClass methods look kind of bogus too, I'll see if I can find
time to do something about that).

>=20
> > diff --git a/include/hw/pci/pci_host.h b/include/hw/pci/pci_host.h
> > index ba31595..ad03cca 100644
> > --- a/include/hw/pci/pci_host.h
> > +++ b/include/hw/pci/pci_host.h
> > @@ -54,6 +54,7 @@ typedef struct PCIHostBridgeClass {
> >      SysBusDeviceClass parent_class;
> > =20
> >      const char *(*root_bus_path)(PCIHostState *, PCIBus *);
> > +    bool (*allow_hybrid_pcie)(PCIHostState *, PCIDevice *);
> >  } PCIHostBridgeClass;
> > =20
> >  /* common internal helpers for PCI/PCIe hosts, cut off overflows */
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GZVR6ND4mMseVXL/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnMqngACgkQbDjKyiDZ
s5L8XQ/8CNg7Vxn/bk1wDeuzjiFOUIEDMGc30MQpJ+NES00q4Ggz+T4Ms1ofLRBr
sG0Qz9nSXSnIJe19X6HM9MUg1quPP5RxjwFgRncUQRmlZ5ta2DbP8GeaKnJ/5kVY
5Y7wexFoyZRwVlNVp0DCZDSL/a7S2eWu7wgXZnBYeQrKoDdBTDiiuGtJjhcJaSps
VmwmSK0AzFZahkUvmAiU3sJJKzZn7GY7+CTu9qvCneZozCEyI541XWrGYrWlSiIH
2MpFhQGA1uB5FkxLkxbrRJ8iqKyVWw6FOpgHZWfChqTwkxUiEFtdebitN8gVm10A
mjKLeSMEd0M8wYfEVABfzjJRT+hNYrmo5b8DeuB1MuhkMqoztTxXpFOs34ZODXQw
R/R1tGNV6YFXw4h50FIvhoVJGpcsDRm7zA2nfOX4QSvVZWKMO0PN1bkXHWad4FQx
9eQDY5M56/KJcIDSKy/mo359b9qy3noUUagPH5rcNVY8JV0wawbAEgsBvZ6IvaT8
4lgAMzFTaKWtFJ0zKp94LoMTH7D3/3MGPcUiOh0PBqfu4JY6t4lItE30x9WWgi/z
ynu+cpjpqlx5eIZKe1h/O3c7sk8xCgcaLBBOIdpv97IwJleel7Lbj7b1YHculEQx
eGbaPvIxLWyIcoyN0Ahxq7LwiVTwZWxVU1A8Z3kNypaEry2luaY=
=nUZJ
-----END PGP SIGNATURE-----

--GZVR6ND4mMseVXL/--
