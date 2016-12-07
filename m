Received: from eggs.gnu.org ([2001:4830:134:3::10]:43748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cEXug-0004Oc-ME
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 03:49:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cEXuf-0005c5-Ax
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 03:49:18 -0500
Date: Wed, 7 Dec 2016 16:47:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20161207054715.GE12489@umbus.fritz.box>
References: <1481053210-26821-1-git-send-email-joserz@linux.vnet.ibm.com>
	<1481053210-26821-7-git-send-email-joserz@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0QFb0wBpEddLcDHQ"
Content-Disposition: inline
In-Reply-To: <1481053210-26821-7-git-send-email-joserz@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 6/7] target-ppc: Implement bcdtrunc.
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, nikunj@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com


--0QFb0wBpEddLcDHQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 06, 2016 at 05:40:09PM -0200, Jose Ricardo Ziviani wrote:
> bcdtrunc.: Decimal integer truncate. Given a BCD number in vrb and the
> number of bytes to truncate in vra, the return register will have vrb
> with such bits truncated.
>=20
> Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> ---
>  target-ppc/helper.h                 |  1 +
>  target-ppc/int_helper.c             | 43 +++++++++++++++++++++++++++++++=
++++++
>  target-ppc/translate/vmx-impl.inc.c |  5 +++++
>  target-ppc/translate/vmx-ops.inc.c  |  4 ++--
>  4 files changed, 51 insertions(+), 2 deletions(-)
>=20
> diff --git a/target-ppc/helper.h b/target-ppc/helper.h
> index d9528eb..49965b0 100644
> --- a/target-ppc/helper.h
> +++ b/target-ppc/helper.h
> @@ -395,6 +395,7 @@ DEF_HELPER_3(bcdsetsgn, i32, avr, avr, i32)
>  DEF_HELPER_4(bcds, i32, avr, avr, avr, i32)
>  DEF_HELPER_4(bcdus, i32, avr, avr, avr, i32)
>  DEF_HELPER_4(bcdsr, i32, avr, avr, avr, i32)
> +DEF_HELPER_4(bcdtrunc, i32, avr, avr, avr, i32)
> =20
>  DEF_HELPER_2(xsadddp, void, env, i32)
>  DEF_HELPER_2(xssubdp, void, env, i32)
> diff --git a/target-ppc/int_helper.c b/target-ppc/int_helper.c
> index cfef25f..faf34c1 100644
> --- a/target-ppc/int_helper.c
> +++ b/target-ppc/int_helper.c
> @@ -3169,6 +3169,49 @@ uint32_t helper_bcdsr(ppc_avr_t *r, ppc_avr_t *a, =
ppc_avr_t *b, uint32_t ps)
>      return cr;
>  }
> =20
> +uint32_t helper_bcdtrunc(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, uint3=
2_t ps)
> +{
> +    int i;
> +    int cr;
> +    int ox_flag;
> +    uint8_t digit;
> +    uint8_t trunc;
> +    int invalid =3D 0;
> +    int sgnb =3D bcd_get_sgn(b);
> +    ppc_avr_t ret =3D *b;
> +
> +#if defined(HOST_WORDS_BIGENDIAN)
> +    int upper =3D ARRAY_SIZE(a->u16) - 1;
> +#else
> +    int upper =3D 0;
> +#endif
> +
> +    trunc =3D 32 - (a->u16[upper] & 31);
> +    for (i =3D 1; i < 32; i++) {
> +        digit =3D bcd_get_digit(b, i, &invalid);
> +
> +        if (unlikely(invalid)) {
> +            return CRF_SO;
> +        }
> +
> +        if (i >=3D trunc) {
> +            if (!ox_flag && digit > 0x0) {
> +                ox_flag =3D 1;
> +            }
> +            bcd_put_digit(&ret, 0, i);
> +        }
> +    }

You should be able to do this by generating a couple of masks and
bitwise ands, rather than having to loop through all the digis.

> +    bcd_put_digit(&ret, bcd_preferred_sgn(sgnb, ps), 0);
> +
> +    cr =3D bcd_cmp_zero(&ret);
> +    if (unlikely(ox_flag)) {
> +        cr |=3D CRF_SO;
> +    }
> +    *r =3D ret;
> +
> +    return cr;
> +}
> +
>  void helper_vsbox(ppc_avr_t *r, ppc_avr_t *a)
>  {
>      int i;
> diff --git a/target-ppc/translate/vmx-impl.inc.c b/target-ppc/translate/v=
mx-impl.inc.c
> index 451abb5..1683f42 100644
> --- a/target-ppc/translate/vmx-impl.inc.c
> +++ b/target-ppc/translate/vmx-impl.inc.c
> @@ -1019,6 +1019,7 @@ GEN_BCD(bcdcpsgn);
>  GEN_BCD(bcds);
>  GEN_BCD(bcdus);
>  GEN_BCD(bcdsr);
> +GEN_BCD(bcdtrunc);
> =20
>  static void gen_xpnd04_1(DisasContext *ctx)
>  {
> @@ -1097,6 +1098,10 @@ GEN_VXFORM_DUAL(vsubudm, PPC2_ALTIVEC_207, PPC_NON=
E, \
>                  bcds, PPC_NONE, PPC2_ISA300)
>  GEN_VXFORM_DUAL(vsubuwm, PPC_ALTIVEC, PPC_NONE, \
>                  bcdus, PPC_NONE, PPC2_ISA300)
> +GEN_VXFORM_DUAL(vsubsbs, PPC_ALTIVEC, PPC_NONE, \
> +                bcdtrunc, PPC_NONE, PPC2_ISA300)
> +GEN_VXFORM_DUAL(vsubuqm, PPC2_ALTIVEC_207, PPC_NONE, \
> +                bcdtrunc, PPC_NONE, PPC2_ISA300)
> =20
>  static void gen_vsbox(DisasContext *ctx)
>  {
> diff --git a/target-ppc/translate/vmx-ops.inc.c b/target-ppc/translate/vm=
x-ops.inc.c
> index fa9c996..e6167a4 100644
> --- a/target-ppc/translate/vmx-ops.inc.c
> +++ b/target-ppc/translate/vmx-ops.inc.c
> @@ -143,14 +143,14 @@ GEN_VXFORM(vaddsws, 0, 14),
>  GEN_VXFORM_DUAL(vsububs, bcdadd, 0, 24, PPC_ALTIVEC, PPC_NONE),
>  GEN_VXFORM_DUAL(vsubuhs, bcdsub, 0, 25, PPC_ALTIVEC, PPC_NONE),
>  GEN_VXFORM(vsubuws, 0, 26),
> -GEN_VXFORM(vsubsbs, 0, 28),
> +GEN_VXFORM_DUAL(vsubsbs, bcdtrunc, 0, 28, PPC_NONE, PPC2_ISA300),
>  GEN_VXFORM(vsubshs, 0, 29),
>  GEN_VXFORM_DUAL(vsubsws, xpnd04_2, 0, 30, PPC_ALTIVEC, PPC_NONE),
>  GEN_VXFORM_207(vadduqm, 0, 4),
>  GEN_VXFORM_207(vaddcuq, 0, 5),
>  GEN_VXFORM_DUAL(vaddeuqm, vaddecuq, 30, 0xFF, PPC_NONE, PPC2_ALTIVEC_207=
),
> -GEN_VXFORM_207(vsubuqm, 0, 20),
>  GEN_VXFORM_207(vsubcuq, 0, 21),
> +GEN_VXFORM_DUAL(vsubuqm, bcdtrunc, 0, 20, PPC2_ALTIVEC_207, PPC2_ISA300),
>  GEN_VXFORM_DUAL(vsubeuqm, vsubecuq, 31, 0xFF, PPC_NONE, PPC2_ALTIVEC_207=
),
>  GEN_VXFORM(vrlb, 2, 0),
>  GEN_VXFORM(vrlh, 2, 1),

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0QFb0wBpEddLcDHQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYR6JjAAoJEGw4ysog2bOSk7oP/AuaoDr6MV9d0UFW64HYjeIF
t4mPnVeD1N/2d2HNycVJFNloSFROn+PICYrWL2eEmVXwDeO8v5fxY7AwZ6oBFbAn
DpOMUKjlLq04RqNyy/1DjHVVLpIGiWKfeqIYpZegTingoBqmGAm0nFrjgT1p+bWi
z+SZWrR0RGK/4MvRg06d0p2U7wOPJx5h6/UBz7m3x4W1Mic1f2mJYDt4g9hM44eM
B5KuOwS1FVJ+BtCCeCNEUxSV/AbWVxX+u+hHWIb7O7blOPXRd1HrRpEhAlvRxPd/
6WvlarAsNcGc+buePzCeX9vbnDD2biNEOkGdql43ZieTmgdOL74piu5MxSxECiP8
BbWdB3KVnicRta4dnJOR2sSVCENRGsTQsJX+sqHR81Nd3iiSDpu5zIddSvC5ZxdQ
ve05P7iTHuzITVR11iSIYHeEulknBo+0Sg4BPg/wU0OYZNk+rwI3af6yxOOGRLZH
hb6gA7hhQiO0H1hTjd3Ac+0KybvVqi0OKZcbB/BARObPsrZrzlXUppjjdKpE+Zms
3/L3pvSiiNUm04RfBpxDs2Sn99ZAsoxKmksAb56uROOlPmq5D9ag9yNraWXeyLgL
lC4Tdkl+6KJgpjDwFoWtowgKp/FEoOc6zy6oQOh45rXQM67yWnn+awk5k3fHJtSm
sMEEAV7LYVOq6Dl5fl6o
=QR0G
-----END PGP SIGNATURE-----

--0QFb0wBpEddLcDHQ--
