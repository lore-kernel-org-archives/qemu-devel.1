Received: from eggs.gnu.org ([209.51.188.92]:58433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ghkpa-0005ZP-9g
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 19:37:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ghkpZ-0003SN-7e
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 19:37:50 -0500
Date: Fri, 11 Jan 2019 11:25:05 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190111002505.GM6682@umbus.fritz.box>
References: <20190109143119.9972-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GoZzJvFfKjxI3RhA"
Content-Disposition: inline
In-Reply-To: <20190109143119.9972-1-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2] spapr/vio: remove the "irq" property"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Thomas Huth <thuth@redhat.com>, Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--GoZzJvFfKjxI3RhA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 09, 2019 at 03:31:19PM +0100, C=E9dric Le Goater wrote:
> commit efe2add7cb7f ("spapr/vio: deprecate the "irq" property") was
> merged in QEMU version 3.0. The "irq" property" can be removed for
> QEMU version 4.0.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>

Applied, thanks.

> ---
>  qemu-deprecated.texi |  6 ------
>  hw/ppc/spapr_vio.c   | 47 ++++++--------------------------------------
>  2 files changed, 6 insertions(+), 47 deletions(-)
>=20
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index c3735b698ee4..eb5cd2a72d41 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -168,9 +168,3 @@ Example of legacy encoding:
>  The above, converted to the current supported format:
> =20
>  @code{json:@{"file.driver":"rbd", "file.pool":"rbd", "file.image":"name"=
@}}
> -
> -@subsection vio-spapr-device device options
> -
> -@subsubsection "irq": "" (since 3.0.0)
> -
> -The ``irq'' property is obsoleted.
> diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
> index 7e8a9ad09337..414673d31341 100644
> --- a/hw/ppc/spapr_vio.c
> +++ b/hw/ppc/spapr_vio.c
> @@ -44,38 +44,6 @@
> =20
>  #define SPAPR_VIO_REG_BASE 0x71000000
> =20
> -static void spapr_vio_get_irq(Object *obj, Visitor *v, const char *name,
> -                              void *opaque, Error **errp)
> -{
> -    Property *prop =3D opaque;
> -    uint32_t *ptr =3D qdev_get_prop_ptr(DEVICE(obj), prop);
> -
> -    visit_type_uint32(v, name, ptr, errp);
> -}
> -
> -static void spapr_vio_set_irq(Object *obj, Visitor *v, const char *name,
> -                              void *opaque, Error **errp)
> -{
> -    Property *prop =3D opaque;
> -    uint32_t *ptr =3D qdev_get_prop_ptr(DEVICE(obj), prop);
> -
> -    if (!qtest_enabled()) {
> -        warn_report(TYPE_VIO_SPAPR_DEVICE " '%s' property is deprecated"=
, name);
> -    }
> -    visit_type_uint32(v, name, ptr, errp);
> -}
> -
> -static const PropertyInfo spapr_vio_irq_propinfo =3D {
> -    .name =3D "irq",
> -    .get =3D spapr_vio_get_irq,
> -    .set =3D spapr_vio_set_irq,
> -};
> -
> -static Property spapr_vio_props[] =3D {
> -    DEFINE_PROP("irq", VIOsPAPRDevice, irq, spapr_vio_irq_propinfo, uint=
32_t),
> -    DEFINE_PROP_END_OF_LIST(),
> -};
> -
>  static char *spapr_vio_get_dev_name(DeviceState *qdev)
>  {
>      VIOsPAPRDevice *dev =3D VIO_SPAPR_DEVICE(qdev);
> @@ -534,15 +502,13 @@ static void spapr_vio_busdev_realize(DeviceState *q=
dev, Error **errp)
>          dev->qdev.id =3D id;
>      }
> =20
> -    if (!dev->irq) {
> -        dev->irq =3D spapr_vio_reg_to_irq(dev->reg);
> +    dev->irq =3D spapr_vio_reg_to_irq(dev->reg);
> =20
> -        if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
> -            dev->irq =3D spapr_irq_findone(spapr, &local_err);
> -            if (local_err) {
> -                error_propagate(errp, local_err);
> -                return;
> -            }
> +    if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
> +        dev->irq =3D spapr_irq_findone(spapr, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            return;
>          }
>      }
> =20
> @@ -668,7 +634,6 @@ static void vio_spapr_device_class_init(ObjectClass *=
klass, void *data)
>      k->realize =3D spapr_vio_busdev_realize;
>      k->reset =3D spapr_vio_busdev_reset;
>      k->bus_type =3D TYPE_SPAPR_VIO_BUS;
> -    k->props =3D spapr_vio_props;
>  }
> =20
>  static const TypeInfo spapr_vio_type_info =3D {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GoZzJvFfKjxI3RhA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlw34mEACgkQbDjKyiDZ
s5LyMQ/9G15hKAKeYmgdr28xPWBSOv1pU9vtrSsXz7ENPQ1cRPGOeEo6Y6vV2pXa
p9g0bRcCTDtC8cTY2HiWX5cj7VW4AoWoxIDo2R7RbaX1Iq0eaREIBVGlpD1uHD1e
sXWNAXZDUV7k9BdhBFiAUPHAie7ghIKlIq2L8HAQ/M3M6r5oYpiZDd7Z+7bUkJI7
WXDLKNFcDMXQU4WVX5eeeQVOTJlFNaB8PbsG601mJWyi53jpgDZUhi6EEBIJVhnD
y3XYF8ooRry0cklacI8FUVtqe5gH0JS7OIOBjVz1nCDvnwApZ7Xrkv4DuwCLMtXg
lH4usNTHLwP/tKwjMZqYRW1JXB6r8Hq17O+UFkWCRKIDht+AFMAGr/Ab7FKJlzmR
sFJKlRX0xeVuzV6TXUOuVB52Y+rphT9pPeHxL3wD9tR9zmoPmFbpfQ0fPfQnnS2i
vCVBDXCrPJFfd0kMoQgz2sUU8ylN4QuPnj2omZGo/er51p1LsK5qTANZSDA/k7I4
UU9LXo9fZthmJQwg126xssB+vr0fdsNBmHqdKxijmp/D9HCtnRrt3Ci9za+zmasn
mDHyY6D/XZK1zmKUSvfgiMRHb6/kzJa4Oq6+225Sxf1U7b9ACHL4FwMKtoiu76aJ
wtvWZFZxAHX21mdb3MlaH5thQs1WBXow4F6keXjgNxtNLlHajs4=
=gFpk
-----END PGP SIGNATURE-----

--GoZzJvFfKjxI3RhA--
