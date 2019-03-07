Received: from eggs.gnu.org ([209.51.188.92]:35713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1kfF-0007iQ-GQ
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 23:29:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1kfE-000674-Ah
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 23:29:49 -0500
Date: Thu, 7 Mar 2019 15:26:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190307042642.GM7722@umbus.fritz.box>
References: <20190306085032.15744-1-clg@kaod.org>
	<20190306085032.15744-21-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8m/hfNLtAhX2NvnO"
Content-Disposition: inline
In-Reply-To: <20190306085032.15744-21-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 20/27] ppc/pnv: add a OCC model class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--8m/hfNLtAhX2NvnO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2019 at 09:50:25AM +0100, C=E9dric Le Goater wrote:
> It will ease the introduction of the OCC model for POWER9.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/hw/ppc/pnv_occ.h | 14 ++++++++++++++
>  hw/ppc/pnv.c             |  2 +-
>  hw/ppc/pnv_occ.c         | 23 ++++++++++++++++++++---
>  3 files changed, 35 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/hw/ppc/pnv_occ.h b/include/hw/ppc/pnv_occ.h
> index 82f299dc76ff..ce2631e21f5e 100644
> --- a/include/hw/ppc/pnv_occ.h
> +++ b/include/hw/ppc/pnv_occ.h
> @@ -23,6 +23,9 @@
> =20
>  #define TYPE_PNV_OCC "pnv-occ"
>  #define PNV_OCC(obj) OBJECT_CHECK(PnvOCC, (obj), TYPE_PNV_OCC)
> +#define TYPE_PNV8_OCC TYPE_PNV_OCC "-POWER8"
> +#define PNV8_OCC(obj) \
> +    OBJECT_CHECK(PnvOCC, (obj), TYPE_PNV8_OCC)
> =20
>  typedef struct PnvOCC {
>      DeviceState xd;
> @@ -35,4 +38,15 @@ typedef struct PnvOCC {
>      MemoryRegion xscom_regs;
>  } PnvOCC;
> =20
> +#define PNV_OCC_CLASS(klass) \
> +     OBJECT_CLASS_CHECK(PnvOCCClass, (klass), TYPE_PNV_OCC)
> +#define PNV_OCC_GET_CLASS(obj) \
> +     OBJECT_GET_CLASS(PnvOCCClass, (obj), TYPE_PNV_OCC)
> +
> +typedef struct PnvOCCClass {
> +    DeviceClass parent_class;
> +
> +    int xscom_size;
> +} PnvOCCClass;
> +
>  #endif /* _PPC_PNV_OCC_H */
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 895be470af67..81ab53899dbc 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -808,7 +808,7 @@ static void pnv_chip_power8_instance_init(Object *obj)
>                                     OBJECT(&chip8->psi), &error_abort);
> =20
>      object_initialize_child(obj, "occ",  &chip8->occ, sizeof(chip8->occ),
> -                            TYPE_PNV_OCC, &error_abort, NULL);
> +                            TYPE_PNV8_OCC, &error_abort, NULL);
>      object_property_add_const_link(OBJECT(&chip8->occ), "psi",
>                                     OBJECT(&chip8->psi), &error_abort);
>  }
> diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
> index 04880f26d612..a210f44926aa 100644
> --- a/hw/ppc/pnv_occ.c
> +++ b/hw/ppc/pnv_occ.c
> @@ -54,7 +54,7 @@ static uint64_t pnv_occ_xscom_read(void *opaque, hwaddr=
 addr, unsigned size)
>          break;
>      default:
>          qemu_log_mask(LOG_UNIMP, "OCC Unimplemented register: Ox%"
> -                      HWADDR_PRIx "\n", addr);
> +                      HWADDR_PRIx "\n", addr >> 3);
>      }
>      return val;
>  }
> @@ -77,7 +77,7 @@ static void pnv_occ_xscom_write(void *opaque, hwaddr ad=
dr,
>          break;
>      default:
>          qemu_log_mask(LOG_UNIMP, "OCC Unimplemented register: Ox%"
> -                      HWADDR_PRIx "\n", addr);
> +                      HWADDR_PRIx "\n", addr >> 3);
>      }
>  }
> =20
> @@ -95,6 +95,7 @@ static const MemoryRegionOps pnv_occ_xscom_ops =3D {
>  static void pnv_occ_realize(DeviceState *dev, Error **errp)
>  {
>      PnvOCC *occ =3D PNV_OCC(dev);
> +    PnvOCCClass *poc =3D PNV_OCC_GET_CLASS(occ);
>      Object *obj;
>      Error *error =3D NULL;
> =20
> @@ -111,9 +112,23 @@ static void pnv_occ_realize(DeviceState *dev, Error =
**errp)
> =20
>      /* XScom region for OCC registers */
>      pnv_xscom_region_init(&occ->xscom_regs, OBJECT(dev), &pnv_occ_xscom_=
ops,
> -                  occ, "xscom-occ", PNV_XSCOM_OCC_SIZE);
> +                  occ, "xscom-occ", poc->xscom_size);
>  }
> =20
> +static void pnv_occ_power8_class_init(ObjectClass *klass, void *data)
> +{
> +    PnvOCCClass *poc =3D PNV_OCC_CLASS(klass);
> +
> +    poc->xscom_size =3D PNV_XSCOM_OCC_SIZE;
> +}
> +
> +static const TypeInfo pnv_occ_power8_type_info =3D {
> +    .name          =3D TYPE_PNV8_OCC,
> +    .parent        =3D TYPE_PNV_OCC,
> +    .instance_size =3D sizeof(PnvOCC),
> +    .class_init    =3D pnv_occ_power8_class_init,
> +};
> +
>  static void pnv_occ_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -124,6 +139,7 @@ static void pnv_occ_class_init(ObjectClass *klass, vo=
id *data)
>  static const TypeInfo pnv_occ_type_info =3D {
>      .name          =3D TYPE_PNV_OCC,
>      .parent        =3D TYPE_DEVICE,
> +    .abstract      =3D true,
>      .instance_size =3D sizeof(PnvOCC),
>      .class_init    =3D pnv_occ_class_init,
>  };
> @@ -131,6 +147,7 @@ static const TypeInfo pnv_occ_type_info =3D {
>  static void pnv_occ_register_types(void)
>  {
>      type_register_static(&pnv_occ_type_info);
> +    type_register_static(&pnv_occ_power8_type_info);
>  }
> =20
>  type_init(pnv_occ_register_types)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8m/hfNLtAhX2NvnO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyAnYIACgkQbDjKyiDZ
s5KUAxAAxg+fVQe6t6vQX0GB1H64opTMieleGoV3nfZkVOpvKhbc85M5d8WEYjbX
uW5P7S2geaMJa12pGKHXYRAPdlXAWK7PBDiKBMpUZ8LwsCbf/86915IzAFExd5Sk
LckAVnq1AT0S0bOwHwdtQGi3tTLbN1dUhKgbAxWZLQ2XNDR3xDgwyfMd5owLspBs
XAT3e621cWsDXY7DUsG2Yyus1KsuR0Uu6gE7PdW4NpEfBkL5AHHEV4dSRoJUR6mc
xaVX1xVCr7wki8a793CBau1yybOApDzojfDGEq6tXBIXuBwstvm8JGpFVc9nfxj/
jVS1gp1l3BRt5y4zxM2/gy/ghFwyOgdRu61bHEJQlTFNZPxyZCyKSR1SP91Vezgv
IppNBw+CepYhqkUg07vJQVMdHkjzmoTWsW6iJKgNwkLbrE/B44elIviWWRu01ORk
dhn8idCr2aoQ3pyIsGSxHCKW1w/NwZ/vmZm3KsfMyDY0H0pIvfNCg3MTTYAxdymx
TNdtIzL/6unNsGeGLFSxJ0YP7YzJPoqOW+3oKpLYZwES9QbIwRRcwt+TmSQvvlag
tIvkgu0dEesxOo2YPBP3VJWyz7VSI4c6ml4PPpJTfKtD6ox3bs641vFU/gNId6VG
xb4to9xZFbt4a/flzu/tCv/t51VvUoQlN5dYXv6I3hohzUE5jaA=
=ZxFL
-----END PGP SIGNATURE-----

--8m/hfNLtAhX2NvnO--
