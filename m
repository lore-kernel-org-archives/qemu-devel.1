Received: from eggs.gnu.org ([2001:4830:134:3::10]:59500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1djePd-0005CO-AU
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 00:34:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1djePa-0005Y8-6M
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 00:34:05 -0400
Date: Mon, 21 Aug 2017 14:18:47 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170821041847.GG12356@umbus.fritz.box>
References: <cover.1503249785.git.balaton@eik.bme.hu>
	<e6021f12f4e245dc2162a6ab479d416374efc799.1503249785.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oOB74oR0WcNeq9Zb"
Content-Disposition: inline
In-Reply-To: <e6021f12f4e245dc2162a6ab479d416374efc799.1503249785.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH 04/15] ehci: Add ppc4xx-ehci for the USB
 2.0 controller in embedded PPC SoCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Francois Revol <revol@free.fr>, Gerd Hoffmann <kraxel@redhat.com>


--oOB74oR0WcNeq9Zb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 20, 2017 at 07:23:05PM +0200, BALATON Zoltan wrote:
> Some PPC SoCs have an EHCI with OHCI companion USB controller. Add a
> new type for this similar to types used for other embedded SoCs.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Gerd, again, if it's convenient to you, I can queue this for 2.11.

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

--oOB74oR0WcNeq9Zb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmaXycACgkQbDjKyiDZ
s5IgqRAAt+mt8UTMIsvkqS2Vnz3WlZSY5iUY4gK88/yDECcN4rQ+jY+fbAv0esC0
a9TVF8TXNpAOav96XLRbq3Ibv/FS5WPeI+sxmb99MrtMcqrAG+jtzbJFmtlErlPt
z5fLomTzDWjYSQmaGRILXVHLBJnGp9iBOR7CJ22hk4WxHgsl/g2r2JSOCawIGq4F
iqB/9IB9HjQGV0YrN5UvIykuy68gxKMAr8Rey1WooMwV5expjfLJfGf5LvWH6yS1
inQo1br+uPcsvwXyyuBrNYPxKgoDHt+ErgC75iJ9+fGcuTPmtEx1noh2h3AOS/fM
nVltQgXDog+EwHPpdhDSLRZ1qvJ16EHpdkxGHTiw60xvCsvqBLJBNHQCCrSHhLiz
gXx5tmOMcF5IzGkK8NPzM+Z3tEPKUxCFWxAmcHAsiniKJhjXALyLfvxS9twq5MGa
Cb5BW+FeS1PRwLNCt/b3Y9sRQgqwY/Y+pITzfL8rJLWojoXwi11AkJwNinz4kF5Z
pAiebrWn0aqsvzcfmshkzfJe3xO68lJ4CwtMSPtC8KwBRNLqnjdDbwu9ahK4Tie3
7N4BEDKHirZXrf0npqD1htU69Ro37PIU0HPNdDMHgdG9zasFOBj0gNMTOxFOURKz
cwSzclt83hq8fwV2dTmhl8GUoZfF6Nt5kSjeLrSrgGkzaerswYs=
=4xMF
-----END PGP SIGNATURE-----

--oOB74oR0WcNeq9Zb--
