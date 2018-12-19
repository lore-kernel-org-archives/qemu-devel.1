Received: from eggs.gnu.org ([2001:4830:134:3::10]:42281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZWcI-0002Vs-He
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:50:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZWcE-0006K8-Sr
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:50:06 -0500
Date: Wed, 19 Dec 2018 17:42:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181219064255.GD30570@umbus.fritz.box>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
	<20181218063911.2112-35-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ax5Xc7LkAiI0IBI6"
Content-Disposition: inline
In-Reply-To: <20181218063911.2112-35-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 34/34] target/ppc: convert vmin* and vmax*
 to vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org


--Ax5Xc7LkAiI0IBI6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2018 at 10:39:11PM -0800, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/ppc/helper.h                 | 16 ---------------
>  target/ppc/int_helper.c             | 27 ------------------------
>  target/ppc/translate/vmx-impl.inc.c | 32 ++++++++++++++---------------
>  3 files changed, 16 insertions(+), 59 deletions(-)
>=20
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index 3daf6bf863..18910d18a4 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -117,22 +117,6 @@ DEF_HELPER_3(vabsduw, void, avr, avr, avr)
>  DEF_HELPER_3(vavgsb, void, avr, avr, avr)
>  DEF_HELPER_3(vavgsh, void, avr, avr, avr)
>  DEF_HELPER_3(vavgsw, void, avr, avr, avr)
> -DEF_HELPER_3(vminsb, void, avr, avr, avr)
> -DEF_HELPER_3(vminsh, void, avr, avr, avr)
> -DEF_HELPER_3(vminsw, void, avr, avr, avr)
> -DEF_HELPER_3(vminsd, void, avr, avr, avr)
> -DEF_HELPER_3(vmaxsb, void, avr, avr, avr)
> -DEF_HELPER_3(vmaxsh, void, avr, avr, avr)
> -DEF_HELPER_3(vmaxsw, void, avr, avr, avr)
> -DEF_HELPER_3(vmaxsd, void, avr, avr, avr)
> -DEF_HELPER_3(vminub, void, avr, avr, avr)
> -DEF_HELPER_3(vminuh, void, avr, avr, avr)
> -DEF_HELPER_3(vminuw, void, avr, avr, avr)
> -DEF_HELPER_3(vminud, void, avr, avr, avr)
> -DEF_HELPER_3(vmaxub, void, avr, avr, avr)
> -DEF_HELPER_3(vmaxuh, void, avr, avr, avr)
> -DEF_HELPER_3(vmaxuw, void, avr, avr, avr)
> -DEF_HELPER_3(vmaxud, void, avr, avr, avr)
>  DEF_HELPER_4(vcmpequb, void, env, avr, avr, avr)
>  DEF_HELPER_4(vcmpequh, void, env, avr, avr, avr)
>  DEF_HELPER_4(vcmpequw, void, env, avr, avr, avr)
> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> index 22671c71e5..b9793364fd 100644
> --- a/target/ppc/int_helper.c
> +++ b/target/ppc/int_helper.c
> @@ -937,33 +937,6 @@ void helper_vmhraddshs(CPUPPCState *env, ppc_avr_t *=
r, ppc_avr_t *a,
>      }
>  }
> =20
> -#define VMINMAX_DO(name, compare, element)                              \
> -    void helper_v##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)       \
> -    {                                                                   \
> -        int i;                                                          \
> -                                                                        \
> -        for (i =3D 0; i < ARRAY_SIZE(r->element); i++) {                =
  \
> -            if (a->element[i] compare b->element[i]) {                  \
> -                r->element[i] =3D b->element[i];                        =
  \
> -            } else {                                                    \
> -                r->element[i] =3D a->element[i];                        =
  \
> -            }                                                           \
> -        }                                                               \
> -    }
> -#define VMINMAX(suffix, element)                \
> -    VMINMAX_DO(min##suffix, >, element)         \
> -    VMINMAX_DO(max##suffix, <, element)
> -VMINMAX(sb, s8)
> -VMINMAX(sh, s16)
> -VMINMAX(sw, s32)
> -VMINMAX(sd, s64)
> -VMINMAX(ub, u8)
> -VMINMAX(uh, u16)
> -VMINMAX(uw, u32)
> -VMINMAX(ud, u64)
> -#undef VMINMAX_DO
> -#undef VMINMAX
> -
>  void helper_vmladduhm(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_=
t *c)
>  {
>      int i;
> diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/v=
mx-impl.inc.c
> index c6a53a9f63..399d18707f 100644
> --- a/target/ppc/translate/vmx-impl.inc.c
> +++ b/target/ppc/translate/vmx-impl.inc.c
> @@ -412,22 +412,22 @@ GEN_VXFORM_V(vsububm, MO_8, tcg_gen_gvec_sub, 0, 16=
);
>  GEN_VXFORM_V(vsubuhm, MO_16, tcg_gen_gvec_sub, 0, 17);
>  GEN_VXFORM_V(vsubuwm, MO_32, tcg_gen_gvec_sub, 0, 18);
>  GEN_VXFORM_V(vsubudm, MO_64, tcg_gen_gvec_sub, 0, 19);
> -GEN_VXFORM(vmaxub, 1, 0);
> -GEN_VXFORM(vmaxuh, 1, 1);
> -GEN_VXFORM(vmaxuw, 1, 2);
> -GEN_VXFORM(vmaxud, 1, 3);
> -GEN_VXFORM(vmaxsb, 1, 4);
> -GEN_VXFORM(vmaxsh, 1, 5);
> -GEN_VXFORM(vmaxsw, 1, 6);
> -GEN_VXFORM(vmaxsd, 1, 7);
> -GEN_VXFORM(vminub, 1, 8);
> -GEN_VXFORM(vminuh, 1, 9);
> -GEN_VXFORM(vminuw, 1, 10);
> -GEN_VXFORM(vminud, 1, 11);
> -GEN_VXFORM(vminsb, 1, 12);
> -GEN_VXFORM(vminsh, 1, 13);
> -GEN_VXFORM(vminsw, 1, 14);
> -GEN_VXFORM(vminsd, 1, 15);
> +GEN_VXFORM_V(vmaxub, MO_8, tcg_gen_gvec_umax, 1, 0);
> +GEN_VXFORM_V(vmaxuh, MO_16, tcg_gen_gvec_umax, 1, 1);
> +GEN_VXFORM_V(vmaxuw, MO_32, tcg_gen_gvec_umax, 1, 2);
> +GEN_VXFORM_V(vmaxud, MO_64, tcg_gen_gvec_umax, 1, 3);
> +GEN_VXFORM_V(vmaxsb, MO_8, tcg_gen_gvec_smax, 1, 4);
> +GEN_VXFORM_V(vmaxsh, MO_16, tcg_gen_gvec_smax, 1, 5);
> +GEN_VXFORM_V(vmaxsw, MO_32, tcg_gen_gvec_smax, 1, 6);
> +GEN_VXFORM_V(vmaxsd, MO_64, tcg_gen_gvec_smax, 1, 7);
> +GEN_VXFORM_V(vminub, MO_8, tcg_gen_gvec_umin, 1, 8);
> +GEN_VXFORM_V(vminuh, MO_16, tcg_gen_gvec_umin, 1, 9);
> +GEN_VXFORM_V(vminuw, MO_32, tcg_gen_gvec_umin, 1, 10);
> +GEN_VXFORM_V(vminud, MO_64, tcg_gen_gvec_umin, 1, 11);
> +GEN_VXFORM_V(vminsb, MO_8, tcg_gen_gvec_smin, 1, 12);
> +GEN_VXFORM_V(vminsh, MO_16, tcg_gen_gvec_smin, 1, 13);
> +GEN_VXFORM_V(vminsw, MO_32, tcg_gen_gvec_smin, 1, 14);
> +GEN_VXFORM_V(vminsd, MO_64, tcg_gen_gvec_smin, 1, 15);
>  GEN_VXFORM(vavgub, 1, 16);
>  GEN_VXFORM(vabsdub, 1, 16);
>  GEN_VXFORM_DUAL(vavgub, PPC_ALTIVEC, PPC_NONE, \

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Ax5Xc7LkAiI0IBI6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwZ6G8ACgkQbDjKyiDZ
s5LdkhAArKs3upF5DLgFqArWECk0apKLEIqA8efiLzcqX/dtB8J9sPMbF9rHKpv2
bYLr8+279WYj/f9DcLCYomyEx1+gkRfnz1cV7g25L5f/amJFqYSb01sL2Q/aRY7W
qFcaTU6zH+B7kmPTtfQBovSvRnJ7J2sp+qinaO111ouIPBHa69AW3R5ByYXUTkA2
XF2CvUayy5Fj00b5UASkDZAEj2JKAfvt+6opim2oFAx1q+6kDBGzDBQ+v+jYrnhc
L1pZt76K4h3euTBzQyC3ypdyjmnmNY55Y1RPn861AJViSjYofzrHFRm1PTz2rkV5
SmC0sxH0lQX4K9X28vx93PKtCSNdIiVFACqhSujUTwM3YmLQzdQWt6bg6gE9jku5
rhi/nbJjqp1Sr6niDxzYe+5Ms2oOiwMf7dl7hxuFyo3m4DDSvCkn9eJJz6Ypo7nS
T9sO4lazhaqVQBdoTqh3ON1rDSGCuErAUEZOY1XeJyTY4WP6G5THy1j/BuhQMY18
iEhqxhKGon5OAGjVVtNDl4rfZeTW7mXvMOLEEiuPgjkGcsBBD16tIf4g/Gp7eEfk
kNSg0Vf5ivsjLshv28AR0Z9F+DuTOOeMGHd0INnvUqpn+KqB9wXs3HpEKdMehtLp
Yb6L1jAqDQJlvI03JXdza8qjll93J3QfriVp696MIY/DRlBQaOY=
=2I53
-----END PGP SIGNATURE-----

--Ax5Xc7LkAiI0IBI6--
