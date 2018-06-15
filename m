Received: from eggs.gnu.org ([2001:4830:134:3::10]:49802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTfBJ-0005Y5-Q0
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 23:13:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTfBF-0000bd-OL
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 23:13:45 -0400
Date: Fri, 15 Jun 2018 12:55:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180615025554.GN4129@umbus.fritz.box>
References: <20180614140043.9231-1-clg@kaod.org>
	<20180614140043.9231-6-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nRwNdQxTdQ7rZk9A"
Content-Disposition: inline
In-Reply-To: <20180614140043.9231-6-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 5/6] ppc/pnv: introduce a new intc_create()
 operation to the chip model
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


--nRwNdQxTdQ7rZk9A
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2018 at 04:00:42PM +0200, C=E9dric Le Goater wrote:
> On Power9, the thread interrupt presenter has a different type and is
> linked to the chip owning the cores.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

(but not applied for now, since it depends on earlier patches I had
comments on)

> ---
>  include/hw/ppc/pnv.h |  1 +
>  hw/ppc/pnv.c         | 21 +++++++++++++++++++--
>  hw/ppc/pnv_core.c    | 18 +++++++++---------
>  3 files changed, 29 insertions(+), 11 deletions(-)
>=20
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index 90759240a7b1..e934e84f555e 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -76,6 +76,7 @@ typedef struct PnvChipClass {
>      hwaddr       xscom_base;
> =20
>      uint32_t (*core_pir)(PnvChip *chip, uint32_t core_id);
> +    Object *(*intc_create)(PnvChip *chip, Object *child, Error **errp);
>  } PnvChipClass;
> =20
>  #define PNV_CHIP_TYPE_SUFFIX "-" TYPE_PNV_CHIP
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index b3b0dd44582f..7d99366daf90 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -641,6 +641,13 @@ static uint32_t pnv_chip_core_pir_p8(PnvChip *chip, =
uint32_t core_id)
>      return (chip->chip_id << 7) | (core_id << 3);
>  }
> =20
> +static Object *pnv_chip_power8_intc_create(PnvChip *chip, Object *child,
> +                                           Error **errp)
> +{
> +    return icp_create(child, TYPE_PNV_ICP, XICS_FABRIC(qdev_get_machine(=
)),
> +                      errp);
> +}
> +
>  /*
>   *    0:48  Reserved - Read as zeroes
>   *   49:52  Node ID
> @@ -656,6 +663,12 @@ static uint32_t pnv_chip_core_pir_p9(PnvChip *chip, =
uint32_t core_id)
>      return (chip->chip_id << 8) | (core_id << 2);
>  }
> =20
> +static Object *pnv_chip_power9_intc_create(PnvChip *chip, Object *child,
> +                                           Error **errp)
> +{
> +    return NULL;
> +}
> +
>  /* Allowed core identifiers on a POWER8 Processor Chip :
>   *
>   * <EX0 reserved>
> @@ -691,6 +704,7 @@ static void pnv_chip_power8e_class_init(ObjectClass *=
klass, void *data)
>      k->chip_cfam_id =3D 0x221ef04980000000ull;  /* P8 Murano DD2.1 */
>      k->cores_mask =3D POWER8E_CORE_MASK;
>      k->core_pir =3D pnv_chip_core_pir_p8;
> +    k->intc_create =3D pnv_chip_power8_intc_create;
>      k->xscom_base =3D 0x003fc0000000000ull;
>      dc->desc =3D "PowerNV Chip POWER8E";
>  }
> @@ -704,6 +718,7 @@ static void pnv_chip_power8_class_init(ObjectClass *k=
lass, void *data)
>      k->chip_cfam_id =3D 0x220ea04980000000ull; /* P8 Venice DD2.0 */
>      k->cores_mask =3D POWER8_CORE_MASK;
>      k->core_pir =3D pnv_chip_core_pir_p8;
> +    k->intc_create =3D pnv_chip_power8_intc_create;
>      k->xscom_base =3D 0x003fc0000000000ull;
>      dc->desc =3D "PowerNV Chip POWER8";
>  }
> @@ -717,6 +732,7 @@ static void pnv_chip_power8nvl_class_init(ObjectClass=
 *klass, void *data)
>      k->chip_cfam_id =3D 0x120d304980000000ull;  /* P8 Naples DD1.0 */
>      k->cores_mask =3D POWER8_CORE_MASK;
>      k->core_pir =3D pnv_chip_core_pir_p8;
> +    k->intc_create =3D pnv_chip_power8_intc_create;
>      k->xscom_base =3D 0x003fc0000000000ull;
>      dc->desc =3D "PowerNV Chip POWER8NVL";
>  }
> @@ -730,6 +746,7 @@ static void pnv_chip_power9_class_init(ObjectClass *k=
lass, void *data)
>      k->chip_cfam_id =3D 0x220d104900008000ull; /* P9 Nimbus DD2.0 */
>      k->cores_mask =3D POWER9_CORE_MASK;
>      k->core_pir =3D pnv_chip_core_pir_p9;
> +    k->intc_create =3D pnv_chip_power9_intc_create;
>      k->xscom_base =3D 0x00603fc00000000ull;
>      dc->desc =3D "PowerNV Chip POWER9";
>  }
> @@ -865,8 +882,8 @@ static void pnv_chip_core_realize(PnvChip *chip, Erro=
r **errp)
>          object_property_set_int(OBJECT(pnv_core),
>                                  pcc->core_pir(chip, core_hwid),
>                                  "pir", &error_fatal);
> -        object_property_add_const_link(OBJECT(pnv_core), "xics",
> -                                       qdev_get_machine(), &error_fatal);
> +        object_property_add_const_link(OBJECT(pnv_core), "chip",
> +                                       OBJECT(chip), &error_fatal);
>          object_property_set_bool(OBJECT(pnv_core), true, "realized",
>                                   &error_fatal);
>          object_unref(OBJECT(pnv_core));
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 13ad7d9e0470..5805bcd10abf 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -121,11 +121,12 @@ static const MemoryRegionOps pnv_core_xscom_ops =3D=
 {
>      .endianness =3D DEVICE_BIG_ENDIAN,
>  };
> =20
> -static void pnv_core_realize_child(Object *child, XICSFabric *xi, Error =
**errp)
> +static void pnv_core_realize_child(Object *child, PnvChip *chip, Error *=
*errp)
>  {
>      Error *local_err =3D NULL;
>      CPUState *cs =3D CPU(child);
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +    PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
> =20
>      object_property_set_bool(child, true, "realized", &local_err);
>      if (local_err) {
> @@ -133,7 +134,7 @@ static void pnv_core_realize_child(Object *child, XIC=
SFabric *xi, Error **errp)
>          return;
>      }
> =20
> -    cpu->intc =3D icp_create(child, TYPE_PNV_ICP, xi, &local_err);
> +    cpu->intc =3D pcc->intc_create(chip, child, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
> @@ -156,13 +157,12 @@ static void pnv_core_realize(DeviceState *dev, Erro=
r **errp)
>      void *obj;
>      int i, j;
>      char name[32];
> -    Object *xi;
> +    Object *chip;
> =20
> -    xi =3D object_property_get_link(OBJECT(dev), "xics", &local_err);
> -    if (!xi) {
> -        error_setg(errp, "%s: required link 'xics' not found: %s",
> -                   __func__, error_get_pretty(local_err));
> -        return;
> +    chip =3D object_property_get_link(OBJECT(dev), "chip", &local_err);
> +    if (!chip) {
> +        error_propagate(errp, local_err);
> +        error_prepend(errp, "required link 'chip' not found: ");
>      }
> =20
>      pc->threads =3D g_malloc0(size * cc->nr_threads);
> @@ -184,7 +184,7 @@ static void pnv_core_realize(DeviceState *dev, Error =
**errp)
>      for (j =3D 0; j < cc->nr_threads; j++) {
>          obj =3D pc->threads + j * size;
> =20
> -        pnv_core_realize_child(obj, XICS_FABRIC(xi), &local_err);
> +        pnv_core_realize_child(obj, PNV_CHIP(chip), &local_err);
>          if (local_err) {
>              goto err;
>          }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nRwNdQxTdQ7rZk9A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsjKroACgkQbDjKyiDZ
s5Jbdg//cM0rP+v0oC0d+9nfbd8swj6Uxn/UTUd7JOR3G/tv3NxVrm0mKDszPgN6
zNol5EbjtrX0vJ++cldiMoIYwuZlDzhoIcuJ5Ix748l7u3fWXSWIndBjIXZhuTjm
hO2ExqBwUPfrgQ0DizNsDWr2rsIjKjaDrSSv7I69ffHYMX0dpfdLDywRhgN0aGmK
AIoug0OPRp7wKpTPxKxv4ek9p4zwP9de5SuPaxyTdf1UJN2RgNmNPIcCYJLY0VlJ
F40ATWXgEfJPMyHlJ11gAJYoP43HKXCvN9HtU4tWm5FeRy1OPjBI2KD9nTf5XaqD
OLBI4n/WqngHfKg3Nh4bZbg/jYLMZVZk3Tw8ilhdFXvytE7rKJW0m5KeWhefOnoy
BlTgTOx9WwfUGZdw1NlV5zIez+g/MlIijuaIJ7RG78iRZF1J8E6rBkO8IeVAfdpy
kN9rjqPur9UJnxKkt8QzHrlhCXKN//i7Xi62VWgi6JsAT7aoG4e1Bn3dvqAXKbeh
4/Eq7s0SZCZyphspXDUVjqOKfCHVO/alYd/3++pibD45uQWk+y6c/kq3pqkd/6Wt
fQRYjluoZR3l3Jrs4iyPyd26LlkTVDH6+a/TymjgrOIXdXWGOuSFGkD2CJEFdZr3
SV96fQcHdFvJMhvo5Qkfm8tARYmToyy5kFqDcYIIA1May1CEpjk=
=0+ZP
-----END PGP SIGNATURE-----

--nRwNdQxTdQ7rZk9A--
