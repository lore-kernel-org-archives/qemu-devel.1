Received: from eggs.gnu.org ([2001:4830:134:3::10]:60338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d0KKi-0001th-GD
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 00:01:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d0KKh-0005Q8-CB
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 00:01:40 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:57039)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1d0KKg-0005NB-UE
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 00:01:39 -0400
Date: Tue, 18 Apr 2017 13:56:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170418035601.GN12235@umbus.fritz.box>
References: <20170417215916.12431-1-ehabkost@redhat.com>
	<20170417215916.12431-7-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="A2x6GFCQWVc4i5ud"
Content-Disposition: inline
In-Reply-To: <20170417215916.12431-7-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [RFC 6/7] pci: Set phb->bus inside pci_bus_new()
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


--A2x6GFCQWVc4i5ud
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 17, 2017 at 06:59:15PM -0300, Eduardo Habkost wrote:
> Every single caller of pci_bus_new() saves the return value inside
> phb->bus. Do that inside pci_bus_new() to avoid code duplication and
> make it harder to break.
>=20
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/pci-bridge/pci_expander_bridge.c | 2 --
>  hw/pci-host/piix.c                  | 1 -
>  hw/pci-host/q35.c                   | 6 +++---
>  hw/pci/pci.c                        | 2 +-
>  4 files changed, 4 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expa=
nder_bridge.c
> index 39d29d2230..8344ca1cc8 100644
> --- a/hw/pci-bridge/pci_expander_bridge.c
> +++ b/hw/pci-bridge/pci_expander_bridge.c
> @@ -245,8 +245,6 @@ static void pxb_dev_realize_common(PCIDevice *dev, bo=
ol pcie, Error **errp)
>      bus->address_space_io =3D dev->bus->address_space_io;
>      bus->map_irq =3D pxb_map_irq_fn;
> =20
> -    phb->bus =3D bus;
> -
>      pxb_register_bus(dev, bus, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
> diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
> index 91fec05b38..818e4979d8 100644
> --- a/hw/pci-host/piix.c
> +++ b/hw/pci-host/piix.c
> @@ -342,7 +342,6 @@ PCIBus *i440fx_init(const char *host_type, const char=
 *pci_type,
>      s =3D PCI_HOST_BRIDGE(dev);
>      b =3D pci_bus_new(s, NULL, pci_address_space,
>                      address_space_io, 0, TYPE_PCI_BUS);
> -    s->bus =3D b;
>      object_property_add_child(qdev_get_machine(), "i440fx", OBJECT(dev),=
 NULL);
>      qdev_init_nofail(dev);
> =20
> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> index 860b47a1ba..5b41412075 100644
> --- a/hw/pci-host/q35.c
> +++ b/hw/pci-host/q35.c
> @@ -49,9 +49,9 @@ static void q35_host_realize(DeviceState *dev, Error **=
errp)
>      sysbus_add_io(sbd, MCH_HOST_BRIDGE_CONFIG_DATA, &pci->data_mem);
>      sysbus_init_ioports(sbd, MCH_HOST_BRIDGE_CONFIG_DATA, 4);
> =20
> -    pci->bus =3D pci_bus_new(pci, "pcie.0",
> -                           s->mch.pci_address_space, s->mch.address_spac=
e_io,
> -                           0, TYPE_PCIE_BUS);
> +    pci_bus_new(pci, "pcie.0",
> +                s->mch.pci_address_space, s->mch.address_space_io,
> +                0, TYPE_PCIE_BUS);
>      PC_MACHINE(qdev_get_machine())->bus =3D pci->bus;
>      qdev_set_parent_bus(DEVICE(&s->mch), BUS(pci->bus));
>      qdev_init_nofail(DEVICE(&s->mch));
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index d3adf806e5..486aeb7514 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -408,6 +408,7 @@ PCIBus *pci_bus_new(PCIHostState *phb, const char *na=
me,
> =20
>      bus =3D PCI_BUS(qbus_create(typename, DEVICE(phb), name));
>      pci_bus_init(bus, phb, address_space_mem, address_space_io, devfn_mi=
n);
> +    phb->bus =3D bus;
>      return bus;
>  }
> =20
> @@ -433,7 +434,6 @@ void pci_register_bus(PCIHostState *phb, const char *=
name,
>      bus =3D pci_bus_new(phb, name, address_space_mem,
>                        address_space_io, devfn_min, typename);
>      pci_bus_irqs(bus, set_irq, map_irq, irq_opaque, nirq);
> -    phb->bus =3D bus;
>  }
> =20
>  int pci_bus_num(PCIBus *s)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--A2x6GFCQWVc4i5ud
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY9Y5RAAoJEGw4ysog2bOS4qwP/08d+wC2R9865VSp/qGPMApG
JiAblrIzqpCnOlW2b7lovCOp96ZsDiGGp7TRHop3Y90JPhsUd7GEeRd5Ln4TnE0K
mMU3kQVo4i1c38uZq4cP+bMU72wcTij/LdayfAoMuBWAAMPaywfRQPg7rfO1lW2m
vcQa4aeRsV7ZK/t528DKJ0zuSZQFDuDP1xD+9i15kHNFm8ZZ0mhYH35xqBRTF+Qa
97ki5emn6qAl9+3gYBpZCYIalTyERumfFF+PFugqqsB5b8r21RofR6wRjl+IObdM
ksPgaUJr61uoEPU3rSoLzspw46FQJlpr7HDXfpJx03DpFv5AHHv+kFHc34gnCNON
npfIXnjAn5e+cPhmZ0H1QJOHqE+qbBZKHkZjK/FG+pPEsP/Qrnpb/T8R01PsEQrh
+5NiHMognZKvm9dSwsjqa5kqIf6qatyGVokIkwNNZ/6gx3d6pNans1zv1Xz4GTYp
p5zzd/1375fs77QSkDj27goakSBqE1VCw899haiNhkKtAgqO1liAy2VMier8XEqu
5o5kMw0vAtbt+eIxm0JMLPvTtUQ6dnDuWImOvVqM5Ri62KMY8vxkHJ3qHOH8AQOr
iL2+JS/wbRxFNwU4B/1BW4X5jcvSslh3O1jvWLrAYsrNLSUhs1VEMN42Smlnl1qC
NYg04zKDJonpOssUixyk
=aMYO
-----END PGP SIGNATURE-----

--A2x6GFCQWVc4i5ud--
