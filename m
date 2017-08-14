Received: from eggs.gnu.org ([2001:4830:134:3::10]:45022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dh78l-0001pu-3F
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 00:38:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dh78j-0006Mc-Uc
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 00:38:11 -0400
Date: Mon, 14 Aug 2017 14:36:53 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170814043653.GB3452@umbus.fritz.box>
References: <cover.1502643878.git.balaton@eik.bme.hu>
	<ef250ee340d5ab61446e2888c6205988d493aa6a.1502643878.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Content-Disposition: inline
In-Reply-To: <ef250ee340d5ab61446e2888c6205988d493aa6a.1502643878.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [RFC PATCH 04/12] ehci: Add ppc4xx-ehci for the
 USB 2.0 controller in embedded PPC SoCs
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


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 13, 2017 at 07:04:38PM +0200, BALATON Zoltan wrote:

This needs a commit message.  AFAICT the new device is basically a
sysbus EHCI with some altered initial values.  Why do those values
need to be different?  Where do the new values come from?

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/usb/hcd-ehci-sysbus.c | 25 +++++++++++++++++++++++++
>  hw/usb/hcd-ehci.h        |  1 +
>  2 files changed, 26 insertions(+)
>=20
> diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
> index 6c20604..3b83beb 100644
> --- a/hw/usb/hcd-ehci-sysbus.c
> +++ b/hw/usb/hcd-ehci-sysbus.c
> @@ -142,6 +142,30 @@ static const TypeInfo ehci_tegra2_type_info =3D {
>      .class_init    =3D ehci_tegra2_class_init,
>  };
> =20
> +static void ehci_ppc4xx_init(Object *o)
> +{
> +    EHCISysBusState *s =3D SYS_BUS_EHCI(o);
> +
> +    s->ehci.companion_enable =3D true;
> +}
> +
> +static void ehci_ppc4xx_class_init(ObjectClass *oc, void *data)
> +{
> +    SysBusEHCIClass *sec =3D SYS_BUS_EHCI_CLASS(oc);
> +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> +
> +    sec->capsbase =3D 0x0;
> +    sec->opregbase =3D 0x10;
> +    set_bit(DEVICE_CATEGORY_USB, dc->categories);
> +}
> +
> +static const TypeInfo ehci_ppc4xx_type_info =3D {
> +    .name          =3D TYPE_PPC4xx_EHCI,
> +    .parent        =3D TYPE_SYS_BUS_EHCI,
> +    .class_init    =3D ehci_ppc4xx_class_init,
> +    .instance_init =3D ehci_ppc4xx_init,
> +};
> +
>  /*
>   * Faraday FUSBH200 USB 2.0 EHCI
>   */
> @@ -224,6 +248,7 @@ static void ehci_sysbus_register_types(void)
>      type_register_static(&ehci_xlnx_type_info);
>      type_register_static(&ehci_exynos4210_type_info);
>      type_register_static(&ehci_tegra2_type_info);
> +    type_register_static(&ehci_ppc4xx_type_info);
>      type_register_static(&ehci_fusbh200_type_info);
>  }
> =20
> diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
> index 821f1de..0bc364b 100644
> --- a/hw/usb/hcd-ehci.h
> +++ b/hw/usb/hcd-ehci.h
> @@ -344,6 +344,7 @@ typedef struct EHCIPCIState {
>  #define TYPE_SYS_BUS_EHCI "sysbus-ehci-usb"
>  #define TYPE_EXYNOS4210_EHCI "exynos4210-ehci-usb"
>  #define TYPE_TEGRA2_EHCI "tegra2-ehci-usb"
> +#define TYPE_PPC4xx_EHCI "ppc4xx-ehci-usb"
>  #define TYPE_FUSBH200_EHCI "fusbh200-ehci-usb"
> =20
>  #define SYS_BUS_EHCI(obj) \

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gatW/ieO32f1wygP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmRKOMACgkQbDjKyiDZ
s5JlSRAAv3Y0UdrzXmhPEWe4wWE27Loz0mjOfWulW6Xl5UsKZLyyqF1GHoGQkmuD
lnNcZ8fO7jB86q7k0bta7wCxekbSjdxDTHNNcHbA6S040sx4nwBUrv1ONO7uAWWr
5VUcDNI5evnlaqeCEt/fdw8mzcuuzcPeW21XRkDi/BlwtThQ94oOLY2tydeA8WyF
pwm9/qHGe5A9aQYCQBRcAUkG7Ablwd8kogf2U2CFaobxunTYozYmR8/1jI6TlEOD
Ox+PkSXnNBc5hcIJ4qhsNFkFgc3VDXnDmOQRfYnKS4idpFxhVGSqeSOLmQ3YQppe
exB4YeyzMHzJ+qRg83Wo0aMHHgoOvX0QqEMheQtmhCTtWvfgOgle94vZTZqdmU5j
p1/XyX8d+EUkwKGIYiM0BDgjmEp0TVVtLJGYbfXMjaLq6cI33OMEuYHwhmZeT4mH
gPF6dRvdrCnYVrLeIAayc3fWOQmENGWOZv14GKBS0/y7nNo5uaFAuJfmzDdBP8uv
jqXT3HOtPIWsTydl/lC4/RSsWq/M7Trl5Hp21wHucUAHXhSkE5Rv+4viNsaCxHvf
i1apHlGU//xEMrNONCHaTxsEg4KHy5cDrea+ZAKCz4K/bZ2L5ZBO8+fpDWKNtdr2
Ryli0chqswml7kRVfe9oswQS+JZuXXTFWoE++rY5/1w8OPxzEPc=
=dSZs
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--
