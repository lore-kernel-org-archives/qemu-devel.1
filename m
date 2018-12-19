Received: from eggs.gnu.org ([2001:4830:134:3::10]:41678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZWbj-0001wO-0T
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:49:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZWbg-0005pl-Sq
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:49:30 -0500
Date: Wed, 19 Dec 2018 17:31:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181219063113.GO30570@umbus.fritz.box>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
	<20181218063911.2112-20-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ctUzwJm0i+kwMBIK"
Content-Disposition: inline
In-Reply-To: <20181218063911.2112-20-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 19/34] target/ppc: convert vspltis[bhw] to
 use vector operations
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


--ctUzwJm0i+kwMBIK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2018 at 10:38:56PM -0800, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/ppc/helper.h                 |  3 ---
>  target/ppc/int_helper.c             | 15 ------------
>  target/ppc/translate/vmx-impl.inc.c | 36 +++++++----------------------
>  3 files changed, 8 insertions(+), 46 deletions(-)
>=20
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index 553ff500c8..2aa60e5d36 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -246,9 +246,6 @@ DEF_HELPER_3(vrld, void, avr, avr, avr)
>  DEF_HELPER_3(vsl, void, avr, avr, avr)
>  DEF_HELPER_3(vsr, void, avr, avr, avr)
>  DEF_HELPER_4(vsldoi, void, avr, avr, avr, i32)
> -DEF_HELPER_2(vspltisb, void, avr, i32)
> -DEF_HELPER_2(vspltish, void, avr, i32)
> -DEF_HELPER_2(vspltisw, void, avr, i32)
>  DEF_HELPER_3(vspltb, void, avr, avr, i32)
>  DEF_HELPER_3(vsplth, void, avr, avr, i32)
>  DEF_HELPER_3(vspltw, void, avr, avr, i32)
> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> index 4547453ef1..e44c0d90ee 100644
> --- a/target/ppc/int_helper.c
> +++ b/target/ppc/int_helper.c
> @@ -2066,21 +2066,6 @@ VNEG(vnegw, s32)
>  VNEG(vnegd, s64)
>  #undef VNEG
> =20
> -#define VSPLTI(suffix, element, splat_type)                     \
> -    void helper_vspltis##suffix(ppc_avr_t *r, uint32_t splat)   \
> -    {                                                           \
> -        splat_type x =3D (int8_t)(splat << 3) >> 3;               \
> -        int i;                                                  \
> -                                                                \
> -        for (i =3D 0; i < ARRAY_SIZE(r->element); i++) {          \
> -            r->element[i] =3D x;                                  \
> -        }                                                       \
> -    }
> -VSPLTI(b, s8, int8_t)
> -VSPLTI(h, s16, int16_t)
> -VSPLTI(w, s32, int32_t)
> -#undef VSPLTI
> -
>  #define VSR(suffix, element, mask)                                      \
>      void helper_vsr##suffix(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)   \
>      {                                                                   \
> diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/v=
mx-impl.inc.c
> index e353d3f174..be638cdb1a 100644
> --- a/target/ppc/translate/vmx-impl.inc.c
> +++ b/target/ppc/translate/vmx-impl.inc.c
> @@ -720,25 +720,21 @@ GEN_VXRFORM_DUAL(vcmpbfp, PPC_ALTIVEC, PPC_NONE, \
>  GEN_VXRFORM_DUAL(vcmpgtfp, PPC_ALTIVEC, PPC_NONE, \
>                   vcmpgtud, PPC_NONE, PPC2_ALTIVEC_207)
> =20
> -#define GEN_VXFORM_SIMM(name, opc2, opc3)                               \
> +#define GEN_VXFORM_DUPI(name, tcg_op, opc2, opc3)                       \
>  static void glue(gen_, name)(DisasContext *ctx)                         \
>      {                                                                   \
> -        TCGv_ptr rd;                                                    \
> -        TCGv_i32 simm;                                                  \
> +        int simm;                                                       \
>          if (unlikely(!ctx->altivec_enabled)) {                          \
>              gen_exception(ctx, POWERPC_EXCP_VPU);                       \
>              return;                                                     \
>          }                                                               \
> -        simm =3D tcg_const_i32(SIMM5(ctx->opcode));                     =
  \
> -        rd =3D gen_avr_ptr(rD(ctx->opcode));                            =
  \
> -        gen_helper_##name (rd, simm);                                   \
> -        tcg_temp_free_i32(simm);                                        \
> -        tcg_temp_free_ptr(rd);                                          \
> +        simm =3D SIMM5(ctx->opcode);                                    =
  \
> +        tcg_op(avr64_offset(rD(ctx->opcode), true), 16, 16, simm);      \
>      }
> =20
> -GEN_VXFORM_SIMM(vspltisb, 6, 12);
> -GEN_VXFORM_SIMM(vspltish, 6, 13);
> -GEN_VXFORM_SIMM(vspltisw, 6, 14);
> +GEN_VXFORM_DUPI(vspltisb, tcg_gen_gvec_dup8i, 6, 12);
> +GEN_VXFORM_DUPI(vspltish, tcg_gen_gvec_dup16i, 6, 13);
> +GEN_VXFORM_DUPI(vspltisw, tcg_gen_gvec_dup32i, 6, 14);
> =20
>  #define GEN_VXFORM_NOA(name, opc2, opc3)                                \
>  static void glue(gen_, name)(DisasContext *ctx)                         =
        \
> @@ -818,22 +814,6 @@ GEN_VXFORM_NOA(vprtybw, 1, 24);
>  GEN_VXFORM_NOA(vprtybd, 1, 24);
>  GEN_VXFORM_NOA(vprtybq, 1, 24);
> =20
> -#define GEN_VXFORM_SIMM(name, opc2, opc3)                               \
> -static void glue(gen_, name)(DisasContext *ctx)                         =
        \
> -    {                                                                   \
> -        TCGv_ptr rd;                                                    \
> -        TCGv_i32 simm;                                                  \
> -        if (unlikely(!ctx->altivec_enabled)) {                          \
> -            gen_exception(ctx, POWERPC_EXCP_VPU);                       \
> -            return;                                                     \
> -        }                                                               \
> -        simm =3D tcg_const_i32(SIMM5(ctx->opcode));                     =
  \
> -        rd =3D gen_avr_ptr(rD(ctx->opcode));                            =
  \
> -        gen_helper_##name (rd, simm);                                   \
> -        tcg_temp_free_i32(simm);                                        \
> -        tcg_temp_free_ptr(rd);                                          \
> -    }
> -
>  #define GEN_VXFORM_UIMM(name, opc2, opc3)                               \
>  static void glue(gen_, name)(DisasContext *ctx)                         =
        \
>      {                                                                   \
> @@ -1255,7 +1235,7 @@ GEN_VXFORM_DUAL(vsldoi, PPC_ALTIVEC, PPC_NONE,
>  #undef GEN_VXRFORM_DUAL
>  #undef GEN_VXRFORM1
>  #undef GEN_VXRFORM
> -#undef GEN_VXFORM_SIMM
> +#undef GEN_VXFORM_DUPI
>  #undef GEN_VXFORM_NOA
>  #undef GEN_VXFORM_UIMM
>  #undef GEN_VAFORM_PAIRED

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ctUzwJm0i+kwMBIK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwZ5bEACgkQbDjKyiDZ
s5Jthw//R45ghhBcryt+bOtBsLjOXClfapjbhzZWT/71t2WuaUCei7Z/F4nUK7eJ
aPMXvvNCdkhtIsjvXRLFd7OX50Inn1zPEXa7wnQqKAM40ma2FAJRbX1feoeImF8C
PS31wuwydhbAHQqgow3PfPXZLLWopeizz3NmR8pyIxnWYk9xomWDR5S7MkdmOzfS
MwfetXV13mf4lIoW+uxPW8Q9teZag1cQ0vYgFaGce9BS2cMb1GRLAuwT8jJI7blo
XHS8J6xE7De43K6oDdYHoAerQ2P7qOEYWtFKAkqyOPOe0bMHrVp9iIYHvWsYX2pp
wuCt7WTjAX8kTWQhrfpQb9LH0O6V9oRHc2TfBd7NviwnlQCdFR6Gc1EeIxuqm0H0
DWQ/Lzq7GIlyPbCDZk4vc1YBs92/oMSX1wy4CZtQ5NVCLsOC/hdzaYsXv4iS5Xvc
T3lvmLe0FmWSd7Tz32k9z18TIzIZ+ohM+4vGZPOEdCykFjJh95Ra72ugvVX8FMbg
tVcHbndwi9UNSrZui+IlnTtMjVK5Sxg51NfEmO7HY5y2QoU4s/AXbAUGxt8G7pFZ
lrT7jZXHUq6hirdzG0wZ119/s1R00bBhfXSRHCYFY7O9p7rrTB7UR5Ni7mXnuYnh
4N5694gpwPWvEPhYzbCglCd7adBlWbOq2//y43Sk+1qd7uosluI=
=jZzf
-----END PGP SIGNATURE-----

--ctUzwJm0i+kwMBIK--
