Received: from eggs.gnu.org ([209.51.188.92]:53791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1jay-0008Ht-Rm
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 22:21:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1jaw-0006zR-Tl
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 22:21:20 -0500
Date: Thu, 7 Mar 2019 12:19:05 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190307011905.GD25123@umbus.fritz.box>
References: <20190306085032.15744-1-clg@kaod.org>
	<20190306085032.15744-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bjuZg6miEcdLYP6q"
Content-Disposition: inline
In-Reply-To: <20190306085032.15744-2-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 01/27] ppc/xive: hardwire the Physical CAM
 line of the thread context
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


--bjuZg6miEcdLYP6q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2019 at 09:50:06AM +0100, C=E9dric Le Goater wrote:
> By default on P9, the HW CAM line (23bits) is hardwired to :
>=20
>       0x000||0b1||4Bit chip number||7Bit Thread number.
>=20
> When the block group mode is enabled at the controller level (PowerNV),
> the CAM line is changed for CAM compares to :
>=20
>       4Bit chip number||0x001||7Bit Thread number
>=20
> This will require changes in xive_presenter_tctx_match() possibly.
> This is a lowlevel functionality of the HW controller and it is not
> strictly needed. Leave it for later.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-4.0, thanks.

> ---
>  hw/intc/xive.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index daa7badc8492..b21759c93856 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -1112,6 +1112,30 @@ XiveTCTX *xive_router_get_tctx(XiveRouter *xrtr, C=
PUState *cs)
>      return xrc->get_tctx(xrtr, cs);
>  }
> =20
> +/*
> + * By default on P9, the HW CAM line (23bits) is hardwired to :
> + *
> + *   0x000||0b1||4Bit chip number||7Bit Thread number.
> + *
> + * When the block grouping is enabled, the CAM line is changed to :
> + *
> + *   4Bit chip number||0x001||7Bit Thread number.
> + */
> +static uint32_t hw_cam_line(uint8_t chip_id, uint8_t tid)
> +{
> +    return 1 << 11 | (chip_id & 0xf) << 7 | (tid & 0x7f);
> +}
> +
> +static bool xive_presenter_tctx_match_hw(XiveTCTX *tctx,
> +                                         uint8_t nvt_blk, uint32_t nvt_i=
dx)
> +{
> +    CPUPPCState *env =3D &POWERPC_CPU(tctx->cs)->env;
> +    uint32_t pir =3D env->spr_cb[SPR_PIR].default_value;
> +
> +    return hw_cam_line((pir >> 8) & 0xf, pir & 0x7f) =3D=3D
> +        hw_cam_line(nvt_blk, nvt_idx);
> +}
> +
>  /*
>   * The thread context register words are in big-endian format.
>   */
> @@ -1120,6 +1144,7 @@ static int xive_presenter_tctx_match(XiveTCTX *tctx=
, uint8_t format,
>                                       bool cam_ignore, uint32_t logic_ser=
v)
>  {
>      uint32_t cam =3D xive_nvt_cam_line(nvt_blk, nvt_idx);
> +    uint32_t qw3w2 =3D xive_tctx_word2(&tctx->regs[TM_QW3_HV_PHYS]);
>      uint32_t qw2w2 =3D xive_tctx_word2(&tctx->regs[TM_QW2_HV_POOL]);
>      uint32_t qw1w2 =3D xive_tctx_word2(&tctx->regs[TM_QW1_OS]);
>      uint32_t qw0w2 =3D xive_tctx_word2(&tctx->regs[TM_QW0_USER]);
> @@ -1142,7 +1167,11 @@ static int xive_presenter_tctx_match(XiveTCTX *tct=
x, uint8_t format,
> =20
>          /* F=3D0 & i=3D0: Specific NVT notification */
> =20
> -        /* TODO (PowerNV) : PHYS ring */
> +        /* PHYS ring */
> +        if ((be32_to_cpu(qw3w2) & TM_QW3W2_VT) &&
> +            xive_presenter_tctx_match_hw(tctx, nvt_blk, nvt_idx)) {
> +            return TM_QW3_HV_PHYS;
> +        }
> =20
>          /* HV POOL ring */
>          if ((be32_to_cpu(qw2w2) & TM_QW2W2_VP) &&

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bjuZg6miEcdLYP6q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyAcYYACgkQbDjKyiDZ
s5Lfug/+IwzT3FjbrU+8foLXiHGlyr4zjrx49tXlQKhwemFQY8SIKAwSAokVzcuc
S/1yUmcrWlDxHwKX5V+aiAXj4lPH4nZ4m0z85miFZQOasQd2nOMYWlZfxz1sEXqU
ZKDowJXsGu/Bw//DFJRRIY1x9ftb/HvlKz+KSQ+pFnmamh9/d5nYFWlJ6xxrfXuP
1C664vwLR2uhIUQA8+9FMzNnNFLShSf3ewRXgse+mX+rfYva4u38A7jVW5r/XOic
p6xHFYNdZeFWx0OOAeSlJF2i7cuXfthUpRR0Ev1aBO25u3PHrpgHXn58FJqlsP12
MA/MwKUSY+sAEkbC+GFj1g4S5mc430LnpWpwOMy9PJ2/f+2k56ceBATOzmqhvOvL
Z3aD1mUr/tz4i2I22cEjL/pxUAT7jUAvKYa9OGnKc7jNRVTetrn0o/19gbW3+OX2
cQ321QTvzXFBCPcyAONvZapxYTiaALzz2L+AwvmlgdpO1fAnW7iMxfh8GgCfwoUd
Ikd0MwFUuj0zopvW9GlneDTD3dbf2KnrI3DPiXFRoL5Yoa7wnGxOQ8TXtj2vDXgn
4AXo+J4inmsGzcdoWnhh50f/s4vynWRSawemP9/15oKlyolrjLam8ncowzXkqoeb
jy2fwTgRJg73gRiCsOstfzuNu6Vg/HgRrYFfjVieB07tbCxGevc=
=V/rT
-----END PGP SIGNATURE-----

--bjuZg6miEcdLYP6q--
