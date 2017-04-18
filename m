Received: from eggs.gnu.org ([2001:4830:134:3::10]:60388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d0KKk-0001uo-Rz
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 00:01:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d0KKj-0005RY-OW
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 00:01:42 -0400
Date: Tue, 18 Apr 2017 13:56:30 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170418035630.GO12235@umbus.fritz.box>
References: <20170417215916.12431-1-ehabkost@redhat.com>
	<20170417215916.12431-8-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IpgPcFyQO6wM49Um"
Content-Disposition: inline
In-Reply-To: <20170417215916.12431-8-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [RFC 7/7] pci: Set phb->bus inside
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
Cc: qemu-devel@nongnu.org, aik@ozlabs.ru, David Gibson <dgibson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org


--IpgPcFyQO6wM49Um
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 17, 2017 at 06:59:16PM -0300, Eduardo Habkost wrote:
> Every single caller of pci_bus_new_inplace() sets phb->bus to point to
> 'bus'. Do that inside pci_bus_new_inplace() to avoid code duplication
> and make it harder to break.
>=20
> Cc: "Herv=E9 Poussineau" <hpoussin@reactos.org>
> Cc: Marcel Apfelbaum <marcel@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-arm@nongnu.org
> Cc: qemu-ppc@nongnu.org
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/pci-host/prep.c      | 2 --
>  hw/pci-host/versatile.c | 1 -
>  hw/pci/pci.c            | 1 +
>  3 files changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
> index 2e2cd267f4..6efa5bc5ef 100644
> --- a/hw/pci-host/prep.c
> +++ b/hw/pci-host/prep.c
> @@ -284,8 +284,6 @@ static void raven_pcihost_initfn(Object *obj)
>      address_space_init(&s->bm_as, &s->bm, "raven-bm");
>      pci_setup_iommu(&s->pci_bus, raven_pcihost_set_iommu, s);
> =20
> -    h->bus =3D &s->pci_bus;
> -
>      object_initialize(&s->pci_dev, sizeof(s->pci_dev), TYPE_RAVEN_PCI_DE=
VICE);
>      pci_dev =3D DEVICE(&s->pci_dev);
>      qdev_set_parent_bus(pci_dev, BUS(&s->pci_bus));
> diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
> index 24ef87610b..630f1ac1c5 100644
> --- a/hw/pci-host/versatile.c
> +++ b/hw/pci-host/versatile.c
> @@ -389,7 +389,6 @@ static void pci_vpb_init(Object *obj)
>      pci_bus_new_inplace(&s->pci_bus, sizeof(s->pci_bus), h, "pci",
>                          &s->pci_mem_space, &s->pci_io_space,
>                          PCI_DEVFN(11, 0), TYPE_PCI_BUS);
> -    h->bus =3D &s->pci_bus;
> =20
>      object_initialize(&s->pci_dev, sizeof(s->pci_dev), TYPE_VERSATILE_PC=
I_HOST);
>      qdev_set_parent_bus(DEVICE(&s->pci_dev), BUS(&s->pci_bus));
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 486aeb7514..ef226f8b41 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -397,6 +397,7 @@ void pci_bus_new_inplace(PCIBus *bus, size_t bus_size,
>  {
>      qbus_create_inplace(bus, bus_size, typename, DEVICE(phb), name);
>      pci_bus_init(bus, phb, address_space_mem, address_space_io, devfn_mi=
n);
> +    phb->bus =3D bus;
>  }
> =20
>  PCIBus *pci_bus_new(PCIHostState *phb, const char *name,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--IpgPcFyQO6wM49Um
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY9Y5uAAoJEGw4ysog2bOScxcP/3T7dGJRK5cFLxdlFQqDxNfa
eKLsjltGWV5nJT0F8M27CBKyC/z4T1b0ZMQPWukhRBlp/prXx/Rh++476O/nVXGP
0Gkb6dR2T2k3hyDfzaHf4VG7s+0gOtEgGDabqsqLzIBoynW2MgtiJCOANvMnBCM2
V0y/f6fQ87kV+g+fBW1WvIoeog4rM9iQR5K9Yd1a8DdEYYSrcxHwEJgA8ezR5ZKb
oLb2DSG/SXjI7S4wCu0AylNm2OCoU0nMBJ00fz/Dk1myxrbehMKwwhBBkv6OF4oO
r78er3ruFAOkh4uZPoGuqnChvNCUykvn5ieFeFWwpYhka4oRezVEjir/1LWD0uqZ
NhZJfVoAje+USaO9+ywp4CaQEsU7cIDgjJHhLTQ93Z47GAsi5nSSLmWgztlYKHuz
pnRL7A8xwpEPkvTf152rpTjVWJmyasLAK0l7FhEr5pKeOMeIGjh+uzs39vAYDD94
tsEtJWxjVFqjXFOaM0xst+aN1nyaWCv0bGKBND8Hq0loxaYvFd53I1blnHg8Mi8h
LxflVQHQZvryM7sk/vH1vIHTbrbw4/mxr5D8jzE5YFSvI42wp81TRUUu9FQgesj3
BJavuyKn+WDmgEg8BVoAMPbJwrVqBlEJXHdJEer1VHpCEIzCto6h5rX92ug9Nirr
mMBfqsiKzQVczUSXOgap
=JN1d
-----END PGP SIGNATURE-----

--IpgPcFyQO6wM49Um--
