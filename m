Received: from eggs.gnu.org ([2001:4830:134:3::10]:48677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d0dYD-0002n5-9q
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 20:32:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d0dYA-0005uh-6Y
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 20:32:53 -0400
Received: from ozlabs.org ([103.22.144.67]:38659)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1d0dY9-0005tk-E9
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 20:32:50 -0400
Date: Wed, 19 Apr 2017 10:23:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170419002314.GB23273@umbus.fritz.box>
References: <20170418221724.5707-1-ehabkost@redhat.com>
	<20170418221724.5707-3-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gj572EiMnwbLXET9"
Content-Disposition: inline
In-Reply-To: <20170418221724.5707-3-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 2/6] pci: Move pci_bus_init() logic to
 pci_bus_new_inplace()
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


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 18, 2017 at 07:17:20PM -0300, Eduardo Habkost wrote:
> Instead of having 3 separate functions, just make pci_bus_new() a
> wrapper that allocates the object and calls pci_bus_new_inplace().
>=20
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/pci/pci.c | 39 +++++++++++++++++----------------------
>  1 file changed, 17 insertions(+), 22 deletions(-)
>=20
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 328f36cd21..0d28ee4e3f 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -357,24 +357,6 @@ const char *pci_root_bus_path(PCIDevice *dev)
>      return rootbus->qbus.name;
>  }
> =20
> -static void pci_bus_init(PCIBus *bus, DeviceState *parent,
> -                         MemoryRegion *address_space_mem,
> -                         MemoryRegion *address_space_io,
> -                         uint8_t devfn_min)
> -{
> -    PCIHostState *phb =3D PCI_HOST_BRIDGE(parent);
> -
> -    assert(PCI_FUNC(devfn_min) =3D=3D 0);
> -    bus->devfn_min =3D devfn_min;
> -    bus->address_space_mem =3D address_space_mem;
> -    bus->address_space_io =3D address_space_io;
> -
> -    /* host bridge */
> -    QLIST_INIT(&bus->child);
> -
> -    QLIST_INSERT_HEAD(&pci_host_bridges, phb, next);
> -}
> -
>  bool pci_bus_is_express(PCIBus *bus)
>  {
>      return object_dynamic_cast(OBJECT(bus), TYPE_PCIE_BUS);
> @@ -391,8 +373,20 @@ void pci_bus_new_inplace(PCIBus *bus, size_t bus_siz=
e, DeviceState *parent,
>                           MemoryRegion *address_space_io,
>                           uint8_t devfn_min, const char *typename)
>  {
> +    PCIHostState *phb =3D PCI_HOST_BRIDGE(parent);
> +
>      qbus_create_inplace(bus, bus_size, typename, parent, name);
> -    pci_bus_init(bus, parent, address_space_mem, address_space_io, devfn=
_min);
> +
> +    assert(PCI_FUNC(devfn_min) =3D=3D 0);
> +    bus->devfn_min =3D devfn_min;
> +    bus->address_space_mem =3D address_space_mem;
> +    bus->address_space_io =3D address_space_io;
> +
> +    /* host bridge */
> +    QLIST_INIT(&bus->child);
> +
> +    QLIST_INSERT_HEAD(&pci_host_bridges, phb, next);
> +
>  }
> =20
>  PCIBus *pci_bus_new(DeviceState *parent, const char *name,
> @@ -400,10 +394,11 @@ PCIBus *pci_bus_new(DeviceState *parent, const char=
 *name,
>                      MemoryRegion *address_space_io,
>                      uint8_t devfn_min, const char *typename)
>  {
> -    PCIBus *bus;
> +    size_t bus_size =3D object_type_get_instance_size(typename);
> +    PCIBus *bus =3D g_malloc(bus_size);
> =20
> -    bus =3D PCI_BUS(qbus_create(typename, parent, name));
> -    pci_bus_init(bus, parent, address_space_mem, address_space_io, devfn=
_min);
> +    pci_bus_new_inplace(bus, bus_size, parent, name, address_space_mem,
> +                        address_space_io, devfn_min, typename);
>      return bus;
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gj572EiMnwbLXET9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY9q3yAAoJEGw4ysog2bOSZzkQAMxvuaf7ZPJKx1nx2xPh0QrQ
OYHtx3eV2sbCnIyV3IA/3w9kCd6s7Qsk4kN7OwwhCemjHp2enaincLSWIupnE6vg
ZTkoM9eFaWuL7IcVva3lP+wIx8pP20ViGlslvn+eOZZwJyF4IumscM1ee2r1ZwMs
cpV7TGYen7Z607MNe3TDHCij6OQYctoF9kZ6L5LkJj3Fh+d2GD5nvNoMmmeAkGqK
c0Uo57E+ygHUJwW5AT665sPCymSq3ah9klFY3gWxkpOic8Axr+S58YKEqcAM5vrH
r9sO+IruQVUHe2CGnVF18W3cNFnK8LkN28laVBy8ZpU+qwqMqjcETMbc/xyzSSIA
m+Pq1+d5vxBcuUk4FScv7hZh+Op0MXuIZOuQOHo7/gPKLVNbv8Dqp1xaO6ic9IrA
M+Ykiis0awojBFQf5z7V+JsP7C9MxS0EqO9LHhWG7V82peTDaJ0e2hb/BwAHsoxV
5+gki63PpN+ezaB/j+suHKv+t5XYI14fU4OeOff50NTe/G2yP5UDXHo5SoEm7gig
lMiWxFTlH+zt6cmV7kBp3xsRyWZ9WbjEr1UuZmMER8mziMJErpzWJBcw91FHAIJK
UxhqdoW4YeMcAyzzpja7Jx5U2AimW/cUhJzjafzLoAVLp6H5axFk/KlZGFRr0wkY
/XvRcz46hHW8jbYXrvSh
=zQ3q
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--
