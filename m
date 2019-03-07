Received: from eggs.gnu.org ([209.51.188.92]:53793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1jay-0008Hu-SF
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 22:21:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1jaw-0006zE-Mx
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 22:21:20 -0500
Date: Thu, 7 Mar 2019 12:46:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190307014615.GA7722@umbus.fritz.box>
References: <20190306085032.15744-1-clg@kaod.org>
	<20190306085032.15744-9-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <20190306085032.15744-9-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 08/27] ppc/pnv: introduce a new
 pic_print_info() operation to the chip model
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


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2019 at 09:50:13AM +0100, C=E9dric Le Goater wrote:
> The POWER9 and POWER8 processors have different interrupt controllers,
> and reporting their state requires calling different helper routines.
>=20
> However, the interrupt presenters are still handled in the higher
> level pic_print_info() routine because they are not related to the
> chip.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied, thanks.

> ---
>  include/hw/ppc/pnv.h |  1 +
>  hw/ppc/pnv.c         | 27 ++++++++++++++++++++++++---
>  2 files changed, 25 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index fa9ec50fd5be..eb4bba25b3e9 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -103,6 +103,7 @@ typedef struct PnvChipClass {
>      void (*intc_create)(PnvChip *chip, PowerPCCPU *cpu, Error **errp);
>      ISABus *(*isa_create)(PnvChip *chip, Error **errp);
>      void (*dt_populate)(PnvChip *chip, void *fdt);
> +    void (*pic_print_info)(PnvChip *chip, Monitor *mon);
>  } PnvChipClass;
> =20
>  #define PNV_CHIP_TYPE_SUFFIX "-" TYPE_PNV_CHIP
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 087541a91a72..7660eaa22cf9 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -567,6 +567,20 @@ static ISABus *pnv_isa_create(PnvChip *chip, Error *=
*errp)
>      return PNV_CHIP_GET_CLASS(chip)->isa_create(chip, errp);
>  }
> =20
> +static void pnv_chip_power8_pic_print_info(PnvChip *chip, Monitor *mon)
> +{
> +    Pnv8Chip *chip8 =3D PNV8_CHIP(chip);
> +
> +    ics_pic_print_info(&chip8->psi.ics, mon);
> +}
> +
> +static void pnv_chip_power9_pic_print_info(PnvChip *chip, Monitor *mon)
> +{
> +    Pnv9Chip *chip9 =3D PNV9_CHIP(chip);
> +
> +    pnv_xive_pic_print_info(&chip9->xive, mon);
> +}
> +
>  static void pnv_init(MachineState *machine)
>  {
>      PnvMachineState *pnv =3D PNV_MACHINE(machine);
> @@ -878,6 +892,7 @@ static void pnv_chip_power8e_class_init(ObjectClass *=
klass, void *data)
>      k->intc_create =3D pnv_chip_power8_intc_create;
>      k->isa_create =3D pnv_chip_power8_isa_create;
>      k->dt_populate =3D pnv_chip_power8_dt_populate;
> +    k->pic_print_info =3D pnv_chip_power8_pic_print_info;
>      k->xscom_base =3D 0x003fc0000000000ull;
>      dc->desc =3D "PowerNV Chip POWER8E";
> =20
> @@ -897,6 +912,7 @@ static void pnv_chip_power8_class_init(ObjectClass *k=
lass, void *data)
>      k->intc_create =3D pnv_chip_power8_intc_create;
>      k->isa_create =3D pnv_chip_power8_isa_create;
>      k->dt_populate =3D pnv_chip_power8_dt_populate;
> +    k->pic_print_info =3D pnv_chip_power8_pic_print_info;
>      k->xscom_base =3D 0x003fc0000000000ull;
>      dc->desc =3D "PowerNV Chip POWER8";
> =20
> @@ -916,6 +932,7 @@ static void pnv_chip_power8nvl_class_init(ObjectClass=
 *klass, void *data)
>      k->intc_create =3D pnv_chip_power8_intc_create;
>      k->isa_create =3D pnv_chip_power8nvl_isa_create;
>      k->dt_populate =3D pnv_chip_power8_dt_populate;
> +    k->pic_print_info =3D pnv_chip_power8_pic_print_info;
>      k->xscom_base =3D 0x003fc0000000000ull;
>      dc->desc =3D "PowerNV Chip POWER8NVL";
> =20
> @@ -977,6 +994,7 @@ static void pnv_chip_power9_class_init(ObjectClass *k=
lass, void *data)
>      k->intc_create =3D pnv_chip_power9_intc_create;
>      k->isa_create =3D pnv_chip_power9_isa_create;
>      k->dt_populate =3D pnv_chip_power9_dt_populate;
> +    k->pic_print_info =3D pnv_chip_power9_pic_print_info;
>      k->xscom_base =3D 0x00603fc00000000ull;
>      dc->desc =3D "PowerNV Chip POWER9";
> =20
> @@ -1164,12 +1182,15 @@ static void pnv_pic_print_info(InterruptStatsProv=
ider *obj,
>      CPU_FOREACH(cs) {
>          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> =20
> -        icp_pic_print_info(ICP(pnv_cpu_state(cpu)->intc), mon);
> +        if (pnv_chip_is_power9(pnv->chips[0])) {
> +            xive_tctx_pic_print_info(XIVE_TCTX(pnv_cpu_state(cpu)->intc)=
, mon);
> +        } else {
> +            icp_pic_print_info(ICP(pnv_cpu_state(cpu)->intc), mon);
> +        }
>      }
> =20
>      for (i =3D 0; i < pnv->num_chips; i++) {
> -        Pnv8Chip *chip8 =3D PNV8_CHIP(pnv->chips[i]);
> -        ics_pic_print_info(&chip8->psi.ics, mon);
> +        PNV_CHIP_GET_CLASS(pnv->chips[i])->pic_print_info(pnv->chips[i],=
 mon);
>      }
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyAd+YACgkQbDjKyiDZ
s5LOaxAApVRJoASxkUeB3LBU5CaoIKZGTdxsNT+mRKuW5WRlIuQskLdBd/mAPJ7s
FcowQ5i96Zo8nkNebyQVzo5aYCbhzsHKp9gi2vjQQDFrgbQLIiwbMpnAcXJKWYrj
OqrYJ/ETzrO0VEIeXaK2fbdWSIJOY7myGjnxYW3ulPWV/vVcDxjM7jorqW4hv1TB
A6EYpNnMjT06n1g8x6TLkBEgipwIbR/ESqPufi1ivvdDLYz6E93lCX+nws9Kl4xt
QD+RZPbk9Cge6g1yCUai9czejG2YW73Qc/zFycH/ZlryfbZASPqPEcpW6gQzwpDH
sPkIc/5/xuCehkz3hSlIAKvrBdGrpc9/t0oWtPWW6ebfSemSGCEGgHiCiapgpf1B
JlA4k+zSnaM0pOqWWvZa3TEVxUQo7Dx1BUzcwId1kcRL3H9Yezwd0cNvtJnhj1GU
y15LvTd57pK+QA/VeFfjOeWJQLtGYrr0HEt7nERiZpMXo/owkn1ByUwstceTlFCA
h3++gicyQTJPO3wtVvLg/nL0hY1BFmfEIikRnjzNVA0RXNHnRmGjwS8iYRg5mtok
ZvKKYaXg+G+Lh3nZiiEDrGkRx3K6xUZXCxjPop2lavr2pdaGdqdZUEnqHEuXvR9u
pAqkkB1DT06d6GS3z02Ll4069DrDlwfZ3pTOnILG6Q9YdczNECA=
=3MVw
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
