Received: from eggs.gnu.org ([2001:4830:134:3::10]:48676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d0dYD-0002n4-9u
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 20:32:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d0dYA-0005ug-6g
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 20:32:53 -0400
Date: Wed, 19 Apr 2017 10:30:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170419003003.GD23273@umbus.fritz.box>
References: <20170418221724.5707-1-ehabkost@redhat.com>
	<20170418221724.5707-5-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3Gf/FFewwPeBMqCJ"
Content-Disposition: inline
In-Reply-To: <20170418221724.5707-5-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 4/6] pci: Manually simplify QOM casts at
 pci_host_bus_init*() calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, aik@ozlabs.ru, David Gibson <dgibson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Alexander Graf <agraf@suse.de>, Aurelien Jarno <aurelien@aurel32.net>, qemu-ppc@nongnu.org


--3Gf/FFewwPeBMqCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 18, 2017 at 07:17:22PM -0300, Eduardo Habkost wrote:
> Those redundant casts were not detected by the Coccinelle patch because
> there are multiple variables and casts involved. Fix them manually.
>=20
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: qemu-ppc@nongnu.org
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/pci-host/q35.c      | 2 +-
>  hw/pci-host/uninorth.c | 2 +-
>  hw/ppc/spapr_pci.c     | 2 +-
>  hw/sh4/sh_pci.c        | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> index 947dc3f124..4258076979 100644
> --- a/hw/pci-host/q35.c
> +++ b/hw/pci-host/q35.c
> @@ -49,7 +49,7 @@ static void q35_host_realize(DeviceState *dev, Error **=
errp)
>      sysbus_add_io(sbd, MCH_HOST_BRIDGE_CONFIG_DATA, &pci->data_mem);
>      sysbus_init_ioports(sbd, MCH_HOST_BRIDGE_CONFIG_DATA, 4);
> =20
> -    pci->bus =3D pci_host_bus_init(PCI_HOST_BRIDGE(s), "pcie.0",
> +    pci->bus =3D pci_host_bus_init(pci, "pcie.0",
>                                   s->mch.pci_address_space,
>                                   s->mch.address_space_io, 0, TYPE_PCIE_B=
US);
>      PC_MACHINE(qdev_get_machine())->bus =3D pci->bus;
> diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
> index 079faad6ff..d9fb5fdc93 100644
> --- a/hw/pci-host/uninorth.c
> +++ b/hw/pci-host/uninorth.c
> @@ -233,7 +233,7 @@ PCIBus *pci_pmac_init(qemu_irq *pic,
>      memory_region_add_subregion(address_space_mem, 0x80000000ULL,
>                                  &d->pci_hole);
> =20
> -    h->bus =3D pci_host_bus_init_irqs(PCI_HOST_BRIDGE(dev), NULL,
> +    h->bus =3D pci_host_bus_init_irqs(h, NULL,
>                                      pci_unin_set_irq, pci_unin_map_irq, =
pic,
>                                      &d->pci_mmio, address_space_io,
>                                      PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 7f29cc77b0..ce132c5eea 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1697,7 +1697,7 @@ static void spapr_phb_realize(DeviceState *dev, Err=
or **errp)
>      memory_region_add_subregion(get_system_memory(), sphb->io_win_addr,
>                                  &sphb->iowindow);
> =20
> -    bus =3D pci_host_bus_init_irqs(PCI_HOST_BRIDGE(dev), NULL,
> +    bus =3D pci_host_bus_init_irqs(phb, NULL,
>                                   pci_spapr_set_irq, pci_spapr_map_irq, s=
phb,
>                                   &sphb->memspace, &sphb->iospace,
>                                   PCI_DEVFN(0, 0), PCI_NUM_PINS, TYPE_PCI=
_BUS);
> diff --git a/hw/sh4/sh_pci.c b/hw/sh4/sh_pci.c
> index f589b1628e..8be2e830e9 100644
> --- a/hw/sh4/sh_pci.c
> +++ b/hw/sh4/sh_pci.c
> @@ -131,7 +131,7 @@ static int sh_pci_device_init(SysBusDevice *dev)
>      for (i =3D 0; i < 4; i++) {
>          sysbus_init_irq(dev, &s->irq[i]);
>      }
> -    phb->bus =3D pci_host_bus_init_irqs(PCI_HOST_BRIDGE(dev), "pci",
> +    phb->bus =3D pci_host_bus_init_irqs(phb, "pci",
>                                        sh_pci_set_irq, sh_pci_map_irq, s-=
>irq,
>                                        get_system_memory(), get_system_io=
(),
>                                        PCI_DEVFN(0, 0), 4, TYPE_PCI_BUS);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3Gf/FFewwPeBMqCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY9q+LAAoJEGw4ysog2bOSzfIP/jwNiEk+Jb7+tG1AeKWlKD4V
A7mdgD56UmJH7DwoMk7CgNg2F2L0BzP2LtFcfHN5XiJUbC9mdUe5TpoD1ZB4f20C
p5um89fJCqopxkDNiFVred3ew0AI+Lg6Oe4F3o+39iOL8MfkfW4Ug7xXe4giJBpL
Fno/pbh6mcRVhF5yHWplGo2PKesn2pMk4hn8V+6KoN6mBFP1Ny1fC8FxKqReHXAD
KMDkH0EMTCYiCXvvdShtRbNA6SZjZE75ovCdl5CU6m07D2z96R6wUQwPPLURW7vr
FX90U8lm1CDYjdsOiY2qUG1oHe8GQD/zZyfybtMinHp+rGr/5Gaq/nlDmJvSricH
V97aQ4pfI2vbEPeDaWJvVIk4LYttTDaw3S54zRwLDlN/h7SfnCWaJd5azxHjqIKX
YYE4TNxW+DqP6r2QzbW8LKAg3Zrh4qCTtz9YdsssMCMefd7L2WX/Q4b5QrcddbNE
IKR49GgEa9dc4oLElFcsxsnAbKfVe4rFse77voo4qzDMBl9zHYnH/iQ4S4BVLMVx
NJBQwOixqup5ptjoEqi3DQrwSz2kgy8qjlQWb/ZRWoxw//lrux2tgmotnl1UUvWN
CBW4VGrCy2vfv4rqTW94yQoQKRTTkPx6IBtonHmD0nwkOsBqVano94h8VLmx85IF
WtQfkD2cKdq3kX9oikjU
=QooD
-----END PGP SIGNATURE-----

--3Gf/FFewwPeBMqCJ--
