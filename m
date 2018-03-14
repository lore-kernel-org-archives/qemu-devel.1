Received: from eggs.gnu.org ([2001:4830:134:3::10]:53334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ew02n-0004EE-Qw
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 02:37:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ew02m-0002Cx-D6
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 02:37:49 -0400
Date: Wed, 14 Mar 2018 17:20:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180314062009.GM4182@umbus.fritz.box>
References: <20180306203103.25563-1-mark.cave-ayland@ilande.co.uk>
	<20180306203103.25563-9-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5LiOUhUlsRX0HDkW"
Content-Disposition: inline
In-Reply-To: <20180306203103.25563-9-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 08/19] uninorth: introduce temporary
 pic_irqs device property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--5LiOUhUlsRX0HDkW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 06, 2018 at 08:30:52PM +0000, Mark Cave-Ayland wrote:
> This is in preparation for moving the PCI bus wiring inside the uninorth
> host bridge devices. In the future it will be possible to remove this onc=
e the
> PICs have been switched to use qdev GPIOs.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

It's not worth changing now, but for future reference.  For an interim
hack like this, it's probably simpler to just make it a field in the
object and have the "callers" just reach in and set it, rather than
making it a formal property.

Yes, that's an abstraction violation, but as a temporary measure to a
better place I think it's acceptable, and avoids a little bit of extra
churn creating then removing the property.

> ---
>  hw/pci-host/uninorth.c         | 25 +++++++++++++++++++++++--
>  include/hw/pci-host/uninorth.h |  1 +
>  2 files changed, 24 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
> index 5b8fc3aa16..fc59698f06 100644
> --- a/hw/pci-host/uninorth.c
> +++ b/hw/pci-host/uninorth.c
> @@ -188,6 +188,7 @@ UNINState *pci_pmac_init(qemu_irq *pic,
>      /* Use values found on a real PowerMac */
>      /* Uninorth main bus */
>      dev =3D qdev_create(NULL, TYPE_UNI_NORTH_PCI_HOST_BRIDGE);
> +    qdev_prop_set_ptr(dev, "pic-irqs", pic);
>      qdev_init_nofail(dev);
>      s =3D SYS_BUS_DEVICE(dev);
>      h =3D PCI_HOST_BRIDGE(s);
> @@ -199,7 +200,7 @@ UNINState *pci_pmac_init(qemu_irq *pic,
> =20
>      h->bus =3D pci_register_root_bus(dev, NULL,
>                                     pci_unin_set_irq, pci_unin_map_irq,
> -                                   pic,
> +                                   d->pic_irqs,
>                                     &d->pci_mmio,
>                                     address_space_io,
>                                     PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
> @@ -220,6 +221,7 @@ UNINState *pci_pmac_init(qemu_irq *pic,
>      /* Uninorth AGP bus */
>      pci_create_simple(h->bus, PCI_DEVFN(11, 0), "uni-north-agp");
>      dev =3D qdev_create(NULL, TYPE_UNI_NORTH_AGP_HOST_BRIDGE);
> +    qdev_prop_set_ptr(dev, "pic-irqs", pic);
>      qdev_init_nofail(dev);
>      s =3D SYS_BUS_DEVICE(dev);
>      sysbus_mmio_map(s, 0, 0xf0800000);
> @@ -251,6 +253,7 @@ UNINState *pci_pmac_u3_init(qemu_irq *pic,
> =20
>      /* Uninorth AGP bus */
>      dev =3D qdev_create(NULL, TYPE_U3_AGP_HOST_BRIDGE);
> +    qdev_prop_set_ptr(dev, "pic-irqs", pic);
>      qdev_init_nofail(dev);
>      s =3D SYS_BUS_DEVICE(dev);
>      h =3D PCI_HOST_BRIDGE(dev);
> @@ -263,7 +266,7 @@ UNINState *pci_pmac_u3_init(qemu_irq *pic,
> =20
>      h->bus =3D pci_register_root_bus(dev, NULL,
>                                     pci_unin_set_irq, pci_unin_map_irq,
> -                                   pic,
> +                                   d->pic_irqs,
>                                     &d->pci_mmio,
>                                     address_space_io,
>                                     PCI_DEVFN(11, 0), 4, TYPE_PCI_BUS);
> @@ -436,10 +439,16 @@ static const TypeInfo unin_internal_pci_host_info =
=3D {
>      },
>  };
> =20
> +static Property pci_unin_main_properties[] =3D {
> +    DEFINE_PROP_PTR("pic-irqs", UNINState, pic_irqs),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  static void pci_unin_main_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> =20
> +    dc->props =3D pci_unin_main_properties;
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>  }
> =20
> @@ -451,10 +460,16 @@ static const TypeInfo pci_unin_main_info =3D {
>      .class_init    =3D pci_unin_main_class_init,
>  };
> =20
> +static Property pci_u3_agp_properties[] =3D {
> +    DEFINE_PROP_PTR("pic-irqs", UNINState, pic_irqs),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  static void pci_u3_agp_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> =20
> +    dc->props =3D pci_u3_agp_properties;
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>  }
> =20
> @@ -466,10 +481,16 @@ static const TypeInfo pci_u3_agp_info =3D {
>      .class_init    =3D pci_u3_agp_class_init,
>  };
> =20
> +static Property pci_unin_agp_class_properties[] =3D {
> +    DEFINE_PROP_PTR("pic-irqs", UNINState, pic_irqs),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  static void pci_unin_agp_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> =20
> +    dc->props =3D pci_unin_agp_class_properties;
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>  }
> =20
> diff --git a/include/hw/pci-host/uninorth.h b/include/hw/pci-host/uninort=
h.h
> index 9364c14bdd..12979712d0 100644
> --- a/include/hw/pci-host/uninorth.h
> +++ b/include/hw/pci-host/uninorth.h
> @@ -42,6 +42,7 @@
>  typedef struct UNINState {
>      PCIHostState parent_obj;
> =20
> +    void *pic_irqs;
>      MemoryRegion pci_mmio;
>      MemoryRegion pci_hole;
>  } UNINState;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5LiOUhUlsRX0HDkW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqovxcACgkQbDjKyiDZ
s5KUyxAAnQq9EB8aXg37E/veR21IFOupvD7DH7OlIgEYY0fgCSzNwz7JVDuyeYcu
gbCdrs0ReBEmXlMxRiPM1xsVueqLYIGiXp6ut/w68X+wGyqTIJqMPrIftXYfBrKO
TJDe+MR9/GJ8RjCq1r8BEAYZIkx2AA2ofP3g+FldaiM3V09NgXRs7eVd/xAt7hxc
O73FfONR8nWMoBJvGPR5nJKQchrvsUdfdibX/Ux5ywL/Bk7AVnGByIpf8bqGJTQ0
ykq7VNVOR0wmmX6Ib7IAXNp4QEfWm3g5xkN0LE5IJUV+lQrUUTNNOte2eBUu2Fo9
zch907C0ZEquWbhgAorVbcti121YKI9smpJ8S64nYCc+/BVvO5dBW6zSZ7VUVFVs
0Tto/5XSMKDKsET2SreKFY8wg8J2zsKcut7MPm8LRUn/31rR3go++zJoMTwwoDKo
zIx49uM2AdQ97H7FsLKCAiqTHnuNDgg6yB97KxDaAF7AaBtf9awnoMkuR87IPK6L
IDJpjSAoHBMj7OVH8LNFKbjuyXleFElmS0BEea+e90+f9DU94xdoaeYxO0SPEOT/
EFSxUd6wE6+YJBATa+oWeWmReeJbs+DQlCQYLSzBGXzaIPMiFh1voVfY9EuTMwYd
6GWXhihy//Nn26mejrAwIiv6IffVVO3gyhndK11q8L3CdOJ2SYQ=
=XX3H
-----END PGP SIGNATURE-----

--5LiOUhUlsRX0HDkW--
