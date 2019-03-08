Received: from eggs.gnu.org ([209.51.188.92]:42075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h240E-0006Bx-Iu
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:08:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h240C-0000tl-C5
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:08:46 -0500
Date: Fri, 8 Mar 2019 11:30:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190308003012.GM7722@umbus.fritz.box>
References: <20190307223548.20516-1-clg@kaod.org>
	<20190307223548.20516-10-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iIq+KTIB+xWY0FJy"
Content-Disposition: inline
In-Reply-To: <20190307223548.20516-10-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 09/15] ppc/pnv: add a OCC model for
 POWER9
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


--iIq+KTIB+xWY0FJy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 11:35:42PM +0100, C=E9dric Le Goater wrote:
> The OCC on POWER9 is very similar to the one found on POWER8. Provide
> the same routines with P9 values for the registers and IRQ number.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied, thanks.

> ---
>=20
>  Changes in v2 :
>=20
>  - made use of the new class attributes for POWER9
>=20
>  include/hw/ppc/pnv.h       |  1 +
>  include/hw/ppc/pnv_occ.h   |  2 ++
>  include/hw/ppc/pnv_xscom.h |  3 ++
>  hw/ppc/pnv.c               | 13 +++++++
>  hw/ppc/pnv_occ.c           | 72 ++++++++++++++++++++++++++++++++++++++
>  5 files changed, 91 insertions(+)
>=20
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index 1cd1ad622d0b..39888f9d52c1 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -88,6 +88,7 @@ typedef struct Pnv9Chip {
>      PnvXive      xive;
>      Pnv9Psi      psi;
>      PnvLpcController lpc;
> +    PnvOCC       occ;
>  } Pnv9Chip;
> =20
>  typedef struct PnvChipClass {
> diff --git a/include/hw/ppc/pnv_occ.h b/include/hw/ppc/pnv_occ.h
> index dab5a05f8e99..d22b65a71abe 100644
> --- a/include/hw/ppc/pnv_occ.h
> +++ b/include/hw/ppc/pnv_occ.h
> @@ -25,6 +25,8 @@
>  #define PNV_OCC(obj) OBJECT_CHECK(PnvOCC, (obj), TYPE_PNV_OCC)
>  #define TYPE_PNV8_OCC TYPE_PNV_OCC "-POWER8"
>  #define PNV8_OCC(obj) OBJECT_CHECK(PnvOCC, (obj), TYPE_PNV8_OCC)
> +#define TYPE_PNV9_OCC TYPE_PNV_OCC "-POWER9"
> +#define PNV9_OCC(obj) OBJECT_CHECK(PnvOCC, (obj), TYPE_PNV9_OCC)
> =20
>  typedef struct PnvOCC {
>      DeviceState xd;
> diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
> index 403a365ed274..3292459fbb78 100644
> --- a/include/hw/ppc/pnv_xscom.h
> +++ b/include/hw/ppc/pnv_xscom.h
> @@ -73,6 +73,9 @@ typedef struct PnvXScomInterfaceClass {
>  #define PNV_XSCOM_OCC_BASE        0x0066000
>  #define PNV_XSCOM_OCC_SIZE        0x6000
> =20
> +#define PNV9_XSCOM_OCC_BASE       PNV_XSCOM_OCC_BASE
> +#define PNV9_XSCOM_OCC_SIZE       0x8000
> +
>  #define PNV9_XSCOM_PSIHB_BASE     0x5012900
>  #define PNV9_XSCOM_PSIHB_SIZE     0x100
> =20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 6ae9ce679505..1559a733235b 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -956,6 +956,11 @@ static void pnv_chip_power9_instance_init(Object *ob=
j)
>                              TYPE_PNV9_LPC, &error_abort, NULL);
>      object_property_add_const_link(OBJECT(&chip9->lpc), "psi",
>                                     OBJECT(&chip9->psi), &error_abort);
> +
> +    object_initialize_child(obj, "occ",  &chip9->occ, sizeof(chip9->occ),
> +                            TYPE_PNV9_OCC, &error_abort, NULL);
> +    object_property_add_const_link(OBJECT(&chip9->occ), "psi",
> +                                   OBJECT(&chip9->psi), &error_abort);
>  }
> =20
>  static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
> @@ -1012,6 +1017,14 @@ static void pnv_chip_power9_realize(DeviceState *d=
ev, Error **errp)
> =20
>      chip->dt_isa_nodename =3D g_strdup_printf("/lpcm-opb@%" PRIx64 "/lpc=
@0",
>                                              (uint64_t) PNV9_LPCM_BASE(ch=
ip));
> +
> +    /* Create the simplified OCC model */
> +    object_property_set_bool(OBJECT(&chip9->occ), true, "realized", &loc=
al_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +    pnv_xscom_add_subregion(chip, PNV9_XSCOM_OCC_BASE, &chip9->occ.xscom=
_regs);
>  }
> =20
>  static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
> diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
> index ea725647c988..fdd9296e1bc7 100644
> --- a/hw/ppc/pnv_occ.c
> +++ b/hw/ppc/pnv_occ.c
> @@ -109,6 +109,77 @@ static const TypeInfo pnv_occ_power8_type_info =3D {
>      .class_init    =3D pnv_occ_power8_class_init,
>  };
> =20
> +#define P9_OCB_OCI_OCCMISC              0x6080
> +#define P9_OCB_OCI_OCCMISC_CLEAR        0x6081
> +#define P9_OCB_OCI_OCCMISC_OR           0x6082
> +
> +
> +static uint64_t pnv_occ_power9_xscom_read(void *opaque, hwaddr addr,
> +                                          unsigned size)
> +{
> +    PnvOCC *occ =3D PNV_OCC(opaque);
> +    uint32_t offset =3D addr >> 3;
> +    uint64_t val =3D 0;
> +
> +    switch (offset) {
> +    case P9_OCB_OCI_OCCMISC:
> +        val =3D occ->occmisc;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "OCC Unimplemented register: Ox%"
> +                      HWADDR_PRIx "\n", addr >> 3);
> +    }
> +    return val;
> +}
> +
> +static void pnv_occ_power9_xscom_write(void *opaque, hwaddr addr,
> +                                       uint64_t val, unsigned size)
> +{
> +    PnvOCC *occ =3D PNV_OCC(opaque);
> +    uint32_t offset =3D addr >> 3;
> +
> +    switch (offset) {
> +    case P9_OCB_OCI_OCCMISC_CLEAR:
> +        pnv_occ_set_misc(occ, 0);
> +        break;
> +    case P9_OCB_OCI_OCCMISC_OR:
> +        pnv_occ_set_misc(occ, occ->occmisc | val);
> +        break;
> +    case P9_OCB_OCI_OCCMISC:
> +        pnv_occ_set_misc(occ, val);
> +       break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "OCC Unimplemented register: Ox%"
> +                      HWADDR_PRIx "\n", addr >> 3);
> +    }
> +}
> +
> +static const MemoryRegionOps pnv_occ_power9_xscom_ops =3D {
> +    .read =3D pnv_occ_power9_xscom_read,
> +    .write =3D pnv_occ_power9_xscom_write,
> +    .valid.min_access_size =3D 8,
> +    .valid.max_access_size =3D 8,
> +    .impl.min_access_size =3D 8,
> +    .impl.max_access_size =3D 8,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
> +};
> +
> +static void pnv_occ_power9_class_init(ObjectClass *klass, void *data)
> +{
> +    PnvOCCClass *poc =3D PNV_OCC_CLASS(klass);
> +
> +    poc->xscom_size =3D PNV9_XSCOM_OCC_SIZE;
> +    poc->xscom_ops =3D &pnv_occ_power9_xscom_ops;
> +    poc->psi_irq =3D PSIHB9_IRQ_OCC;
> +}
> +
> +static const TypeInfo pnv_occ_power9_type_info =3D {
> +    .name          =3D TYPE_PNV9_OCC,
> +    .parent        =3D TYPE_PNV_OCC,
> +    .instance_size =3D sizeof(PnvOCC),
> +    .class_init    =3D pnv_occ_power9_class_init,
> +};
> +
>  static void pnv_occ_realize(DeviceState *dev, Error **errp)
>  {
>      PnvOCC *occ =3D PNV_OCC(dev);
> @@ -152,6 +223,7 @@ static void pnv_occ_register_types(void)
>  {
>      type_register_static(&pnv_occ_type_info);
>      type_register_static(&pnv_occ_power8_type_info);
> +    type_register_static(&pnv_occ_power9_type_info);
>  }
> =20
>  type_init(pnv_occ_register_types);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--iIq+KTIB+xWY0FJy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyBt5QACgkQbDjKyiDZ
s5KeRA/+IuWHMWjO0+SFRZSH5a31NekcitytQm4XlAuwEnSBj+YPFI8/+bq8TMUl
+Y3/2BE8+An4jFJPad3sRf3T2w0FVDxVJ8Sy2MZHbJ9HK7WlMSLM/SCMPIh+i1Fy
1QRO81UwwvSUr9rX74xkdsJO309vFqgNPAIV84057a+SQSxvDh9X3A4YfkeWHHUX
qQWhAZPFTITXXldhdOswT/2Ytgk4Ra/HUcaBCjQUlBnjqoFHU/az9rJRJFJYYFbz
Q26BnsuEVGo2mmSLxzbVbGZ8hxCWVJFrEUj7+rrmB+LH0SopRHTG1E123z1VBG/z
jGinI3qEJE32cSsYFYpEl36eV2AFgBUgquIaLnHrf8f550s/aEnlAAZFZmTYyNzu
fLsOQ7I2wkonqXn5txCCgm6XDecIkFA8EslD80IOSY38qKxjyWB34V/4Gh6vANu1
MtW8+wqnEz/iId6xM7bYFoOgT9xUh4OniMQOUFb8ISdvFUvMnh9SJjiukzbKNQvD
dKJDb5FcHIi2Wl6cNRk/iy1uXfc3oUyyrG4K5WbMmAtE5xV5vgB3aNsEjQOucNbo
wBssdl3O9UCYKWarPD6S4t5PhvlnixhCRMst8Da2VFxGMr1YQf3jdlPc7FqarzJ1
6EikVkE5DBtNipN0Jjl6zU09QOibxirnyYWYZypobajKqmLssQk=
=LQUA
-----END PGP SIGNATURE-----

--iIq+KTIB+xWY0FJy--
