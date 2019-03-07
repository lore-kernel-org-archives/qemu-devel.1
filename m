Received: from eggs.gnu.org ([209.51.188.92]:53765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1jaw-0008Hi-Ua
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 22:21:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1jau-0006yf-Gb
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 22:21:18 -0500
Date: Thu, 7 Mar 2019 12:44:27 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190307014427.GG25123@umbus.fritz.box>
References: <20190306085032.15744-1-clg@kaod.org>
	<20190306085032.15744-8-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NPukt5Otb9an/u20"
Content-Disposition: inline
In-Reply-To: <20190306085032.15744-8-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 07/27] ppc/pnv: introduce a new
 dt_populate() operation to the chip model
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


--NPukt5Otb9an/u20
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2019 at 09:50:12AM +0100, C=E9dric Le Goater wrote:
> The POWER9 and POWER8 processors have a different set of devices and a
> different device tree layout.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied, thanks.

> ---
>  include/hw/ppc/pnv.h |  1 +
>  hw/ppc/pnv.c         | 27 +++++++++++++++++++++++++--
>  2 files changed, 26 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index ebbb3d0e9aa7..fa9ec50fd5be 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -102,6 +102,7 @@ typedef struct PnvChipClass {
>      uint32_t (*core_pir)(PnvChip *chip, uint32_t core_id);
>      void (*intc_create)(PnvChip *chip, PowerPCCPU *cpu, Error **errp);
>      ISABus *(*isa_create)(PnvChip *chip, Error **errp);
> +    void (*dt_populate)(PnvChip *chip, void *fdt);
>  } PnvChipClass;
> =20
>  #define PNV_CHIP_TYPE_SUFFIX "-" TYPE_PNV_CHIP
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index a7ec76dbd6c7..087541a91a72 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -267,7 +267,7 @@ static void pnv_dt_icp(PnvChip *chip, void *fdt, uint=
32_t pir,
>      g_free(reg);
>  }
> =20
> -static void pnv_dt_chip(PnvChip *chip, void *fdt)
> +static void pnv_chip_power8_dt_populate(PnvChip *chip, void *fdt)
>  {
>      const char *typename =3D pnv_chip_core_typename(chip);
>      size_t typesize =3D object_type_get_instance_size(typename);
> @@ -289,6 +289,25 @@ static void pnv_dt_chip(PnvChip *chip, void *fdt)
>      }
>  }
> =20
> +static void pnv_chip_power9_dt_populate(PnvChip *chip, void *fdt)
> +{
> +    const char *typename =3D pnv_chip_core_typename(chip);
> +    size_t typesize =3D object_type_get_instance_size(typename);
> +    int i;
> +
> +    pnv_dt_xscom(chip, fdt, 0);
> +
> +    for (i =3D 0; i < chip->nr_cores; i++) {
> +        PnvCore *pnv_core =3D PNV_CORE(chip->cores + i * typesize);
> +
> +        pnv_dt_core(chip, pnv_core, fdt);
> +    }
> +
> +    if (chip->ram_size) {
> +        pnv_dt_memory(fdt, chip->chip_id, chip->ram_start, chip->ram_siz=
e);
> +    }
> +}
> +
>  static void pnv_dt_rtc(ISADevice *d, void *fdt, int lpc_off)
>  {
>      uint32_t io_base =3D d->ioport_id;
> @@ -474,7 +493,7 @@ static void *pnv_dt_create(MachineState *machine)
> =20
>      /* Populate device tree for each chip */
>      for (i =3D 0; i < pnv->num_chips; i++) {
> -        pnv_dt_chip(pnv->chips[i], fdt);
> +        PNV_CHIP_GET_CLASS(pnv->chips[i])->dt_populate(pnv->chips[i], fd=
t);
>      }
> =20
>      /* Populate ISA devices on chip 0 */
> @@ -858,6 +877,7 @@ static void pnv_chip_power8e_class_init(ObjectClass *=
klass, void *data)
>      k->core_pir =3D pnv_chip_core_pir_p8;
>      k->intc_create =3D pnv_chip_power8_intc_create;
>      k->isa_create =3D pnv_chip_power8_isa_create;
> +    k->dt_populate =3D pnv_chip_power8_dt_populate;
>      k->xscom_base =3D 0x003fc0000000000ull;
>      dc->desc =3D "PowerNV Chip POWER8E";
> =20
> @@ -876,6 +896,7 @@ static void pnv_chip_power8_class_init(ObjectClass *k=
lass, void *data)
>      k->core_pir =3D pnv_chip_core_pir_p8;
>      k->intc_create =3D pnv_chip_power8_intc_create;
>      k->isa_create =3D pnv_chip_power8_isa_create;
> +    k->dt_populate =3D pnv_chip_power8_dt_populate;
>      k->xscom_base =3D 0x003fc0000000000ull;
>      dc->desc =3D "PowerNV Chip POWER8";
> =20
> @@ -894,6 +915,7 @@ static void pnv_chip_power8nvl_class_init(ObjectClass=
 *klass, void *data)
>      k->core_pir =3D pnv_chip_core_pir_p8;
>      k->intc_create =3D pnv_chip_power8_intc_create;
>      k->isa_create =3D pnv_chip_power8nvl_isa_create;
> +    k->dt_populate =3D pnv_chip_power8_dt_populate;
>      k->xscom_base =3D 0x003fc0000000000ull;
>      dc->desc =3D "PowerNV Chip POWER8NVL";
> =20
> @@ -954,6 +976,7 @@ static void pnv_chip_power9_class_init(ObjectClass *k=
lass, void *data)
>      k->core_pir =3D pnv_chip_core_pir_p9;
>      k->intc_create =3D pnv_chip_power9_intc_create;
>      k->isa_create =3D pnv_chip_power9_isa_create;
> +    k->dt_populate =3D pnv_chip_power9_dt_populate;
>      k->xscom_base =3D 0x00603fc00000000ull;
>      dc->desc =3D "PowerNV Chip POWER9";
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NPukt5Otb9an/u20
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyAd3sACgkQbDjKyiDZ
s5KFLw/+MtOVA2lUSlJtY1cwCDcp5WvTMXA40awgohH0qrlzDc7ZcV+y5DJRffiy
2L822rVZ8pJ+FLQWP0FbsTvQRRUSyp9TUb8Er4mUMqRKfxtpGJjgBp50f1MfTnj1
nn6bzLiWx1GODeTI361VH2n84KbJWsiLZUW2gm9XXB/Xp3PmHXunrlto4F7r4y1n
Cy/6iyd+VWoShF5BdyVT+KN7RgUEwwXOGXS3I8TVXt5RwgUT03WXjibAOsUeJR/1
JjWTcbglJVEPibgpQJehyFfL3ZutTc+erOERO/iM87qF12lzcbeFewDn//cJbm5C
NzX0ocX4b3d89xWlhtZgaYt65NdZso/3qsH00l0Mv/c3MxpQSkqVBZrUQMt9Nm88
dP+kLsFOvzdwNKj/xAsfaQmPHWXh+zAOC+u2h2hVfsW5qlx/8M1HXmAzaOV7C6h4
mP/X5wM6lqShs40qh7wHewxToMS+hK9+CJLwn0bovSgHKa8ABB2gGPrJ2OaEUiRu
lUhxt4ws85mzwXoeZBUwMD5I76xlF9v80njLzLadIe9GhuXuHaRBP+Dv4Ma0p7VZ
8jEcR4vQhkqxZ7ir6yJ1ZXbiPX18vcKuLHvBl+plqeZpIxgDuuCJ7j5t/tRo9fab
PZu+PoWRpW8jA3oNsYFmKygcuGE5dYN7rXHdviqH+8xSmO0XvUY=
=1vb4
-----END PGP SIGNATURE-----

--NPukt5Otb9an/u20--
