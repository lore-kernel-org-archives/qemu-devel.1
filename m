Received: from eggs.gnu.org ([2001:4830:134:3::10]:36644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dhTuk-0006lq-JA
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 00:57:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dhTuh-0004iY-Hg
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 00:57:14 -0400
Date: Tue, 15 Aug 2017 14:13:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170815041312.GP3452@umbus.fritz.box>
References: <cover.1502643878.git.balaton@eik.bme.hu>
	<a35170661f03bc19dbd2a5d6e9af626b83e2913d.1502643878.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="b5sSX5qSQrSInIHt"
Content-Disposition: inline
In-Reply-To: <a35170661f03bc19dbd2a5d6e9af626b83e2913d.1502643878.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [RFC PATCH 03/12] ohci: Allow sysbus version to be
 used as a companion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Francois Revol <revol@free.fr>


--b5sSX5qSQrSInIHt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 13, 2017 at 07:04:38PM +0200, BALATON Zoltan wrote:

Wants a commit message - why do you need this functionality.

Patch itself looks fine to me, but you should probably CC Gerd
<kraxel@redhat.com> for review.

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/usb/hcd-ohci.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
> index 267982e..17beedd 100644
> --- a/hw/usb/hcd-ohci.c
> +++ b/hw/usb/hcd-ohci.c
> @@ -1999,7 +1999,9 @@ typedef struct {
>      /*< public >*/
> =20
>      OHCIState ohci;
> +    char *masterbus;
>      uint32_t num_ports;
> +    uint32_t firstport;
>      dma_addr_t dma_offset;
>  } OHCISysBusState;
> =20
> @@ -2007,10 +2009,15 @@ static void ohci_realize_pxa(DeviceState *dev, Er=
ror **errp)
>  {
>      OHCISysBusState *s =3D SYSBUS_OHCI(dev);
>      SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> +    Error *err =3D NULL;
> =20
> -    /* Cannot fail as we pass NULL for masterbus */
> -    usb_ohci_init(&s->ohci, dev, s->num_ports, s->dma_offset, NULL, 0,
> -                  &address_space_memory, &error_abort);
> +    usb_ohci_init(&s->ohci, dev, s->num_ports, s->dma_offset,
> +                  s->masterbus, s->firstport,
> +                  &address_space_memory, &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
>      sysbus_init_irq(sbd, &s->ohci.irq);
>      sysbus_init_mmio(sbd, &s->ohci.mem);
>  }
> @@ -2142,7 +2149,9 @@ static const TypeInfo ohci_pci_info =3D {
>  };
> =20
>  static Property ohci_sysbus_properties[] =3D {
> +    DEFINE_PROP_STRING("masterbus", OHCISysBusState, masterbus),
>      DEFINE_PROP_UINT32("num-ports", OHCISysBusState, num_ports, 3),
> +    DEFINE_PROP_UINT32("firstport", OHCISysBusState, firstport, 0),
>      DEFINE_PROP_DMAADDR("dma-offset", OHCISysBusState, dma_offset, 0),
>      DEFINE_PROP_END_OF_LIST(),
>  };

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--b5sSX5qSQrSInIHt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmSdNgACgkQbDjKyiDZ
s5I8YQ//TkbN3GxFLpBJCRPrM7E/MOAla30elDfvtEyVUCsRwHfOwo9H5pcr7mds
CQM8EiiA4wWMNbzQZwuno0E+X7g0uV6bd+gSUtYNFXJAfNSIFREjIufVVTL8krz4
ej609GqY5OQfIoBjf6UrKI+g4yZueGdk0l/LJPDGjHrt/gxg+CASAsOSe896FW5P
4GeA3nQ9OBr/LYy+SqK3zhvGx8RAi6vJRabrQTOsQuRaiFcZZ6gqKAW0aO7tCD1u
cJHk8W8fX45vZXv7HWWnkCFYovw9T3fEgmHuKGDptzz07vREVzKyioNpq5tAQ+4u
BbtiwBNGzvWCvCzqPQcworJkjGCztBEfaIFcYNVVhcEJ5w+o0lgQWY6dX4/rdk7E
4G+OZ6GhKYUUX/gv1KcsGcqnFAr19Cc3fhW68BmubXiRdxRw9yXD/XxoKNcls5w8
DIsZfzJ6hfTqRrXifKNr5ftTZ1EaZIPmMLTlOdk8zUdcU4FETErEaY8Mda/jySwk
MNcd8KdiUmjVGtPVBFx/vHPWjGfWUjcXWzNDWVh4AAWiIPy74rFEclh4Nb29lxVr
yhyR19vouH/eF+SBkQJzmtizNAf2jkuV7fivtqGCQGJbE8KJkGNdsLsuG58XXrqa
qwFZHbi4FWAF4Gm5kg/TWTEYajcOR6HC2j+2y/2oSRTS9gun630=
=0pdZ
-----END PGP SIGNATURE-----

--b5sSX5qSQrSInIHt--
