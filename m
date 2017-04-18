Received: from eggs.gnu.org ([2001:4830:134:3::10]:60335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d0KKi-0001tg-FB
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 00:01:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d0KKh-0005Pz-BG
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 00:01:40 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:43603)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1d0KKg-0005N9-Tm
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 00:01:39 -0400
Date: Tue, 18 Apr 2017 13:51:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170418035101.GJ12235@umbus.fritz.box>
References: <20170417215916.12431-1-ehabkost@redhat.com>
	<20170417215916.12431-3-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dwWFXG4JqVa0wfCP"
Content-Disposition: inline
In-Reply-To: <20170417215916.12431-3-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [RFC 2/7] pci: Change pci_bus_init() 'parent'
 parameter to PCIHostState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, aik@ozlabs.ru, David Gibson <dgibson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>


--dwWFXG4JqVa0wfCP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 17, 2017 at 06:59:11PM -0300, Eduardo Habkost wrote:
> pci_bus_init() already requires 'parent' to be a PCI_HOST_BRIDGE object,
> so change the parameter type to reflect that.
>=20
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

I had to do some looking to convince myself this wouldn't break P2P
bridges.

I wonder if we should rename pci_bus_init() / pci_bus_new() to make it
clearer that they're about creating a whole new PCI domain, and not
for a new bus within an existing domain.

> ---
>  hw/pci/pci.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 25118fb91d..d9535c0bdc 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -362,7 +362,7 @@ const char *pci_root_bus_path(PCIDevice *dev)
>      return rootbus->qbus.name;
>  }
> =20
> -static void pci_bus_init(PCIBus *bus, DeviceState *parent,
> +static void pci_bus_init(PCIBus *bus, PCIHostState *phb,
>                           MemoryRegion *address_space_mem,
>                           MemoryRegion *address_space_io,
>                           uint8_t devfn_min)
> @@ -375,7 +375,7 @@ static void pci_bus_init(PCIBus *bus, DeviceState *pa=
rent,
>      /* host bridge */
>      QLIST_INIT(&bus->child);
> =20
> -    pci_host_bus_register(PCI_HOST_BRIDGE(host));
> +    pci_host_bus_register(phb);
>  }
> =20
>  bool pci_bus_is_express(PCIBus *bus)
> @@ -394,8 +394,9 @@ void pci_bus_new_inplace(PCIBus *bus, size_t bus_size=
, DeviceState *parent,
>                           MemoryRegion *address_space_io,
>                           uint8_t devfn_min, const char *typename)
>  {
> +    PCIHostState *phb =3D PCI_HOST_BRIDGE(parent);
>      qbus_create_inplace(bus, bus_size, typename, parent, name);
> -    pci_bus_init(bus, parent, address_space_mem, address_space_io, devfn=
_min);
> +    pci_bus_init(bus, phb, address_space_mem, address_space_io, devfn_mi=
n);
>  }
> =20
>  PCIBus *pci_bus_new(DeviceState *parent, const char *name,
> @@ -403,10 +404,11 @@ PCIBus *pci_bus_new(DeviceState *parent, const char=
 *name,
>                      MemoryRegion *address_space_io,
>                      uint8_t devfn_min, const char *typename)
>  {
> +    PCIHostState *phb =3D PCI_HOST_BRIDGE(parent);
>      PCIBus *bus;
> =20
>      bus =3D PCI_BUS(qbus_create(typename, parent, name));
> -    pci_bus_init(bus, parent, address_space_mem, address_space_io, devfn=
_min);
> +    pci_bus_init(bus, phb, address_space_mem, address_space_io, devfn_mi=
n);
>      return bus;
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dwWFXG4JqVa0wfCP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY9Y0lAAoJEGw4ysog2bOSHGkP/RI48hMFx3TypTm+tWIEx+/V
lGNr8+3TaWjYZOhT3GXMl4g9nFp2HXMavMlLQczjJbbknDMkl890HrZqZ83XlQII
drcWKNr64pKlQ5g7wrnHRALiJx/eal2wTYHiOG++y1dpfZOk7TusIJzIrU1/eW1n
AEbnIdc8xy2A7T7BJw+pVGJ01vQtRyN1YLmil5ylD7VDPkPaGcaTu/jCqP31paQs
4WTSSozGTQEgARqBtMQIxR7GrGg0Ng4xd0WlgEVFKE62KBQvw6mIl9KBRy6Aub1f
AZdM0+JgQfUyBuecBFhnIn3Vnkk8LjWaT4traA9cVZLYqBLTkHCZBl2Ig8i4QL/J
NeSgsWFzXmjZL5sA4AP6qujX8YdX2hvxarGd4Js7wvdO+ZD+sdlFgdbGynf0ylUZ
Q0hdkbTMYw9hfno9UX3VO2efNAYQovl1R0RO3kotUN9akDLOQTUEOwu+VQVy24G7
B47OBqdoKPy4sCMyjQ8MYcPLCv7vG6t5oDtz+iQ1JNrqgqP54agJfWMgmathPMhr
RpIEv+BikdsqymEavsUuyN1i5dYwR/cnj7x5wqaCP01ZsGYAPsW1R9rgAyjWqYVo
2SZuVrFc/3ojcEaQpQWH5q715hL+oXxW/B9RrFyZo/ZJ/ji6tBdSXuEnC7FKHqVL
cA/ubwl2HeCk40kAbUhx
=IAuH
-----END PGP SIGNATURE-----

--dwWFXG4JqVa0wfCP--
