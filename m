Received: from eggs.gnu.org ([2001:4830:134:3::10]:54940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjcHb-0004jO-Eg
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 20:45:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjcHX-0006xH-G4
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 20:45:23 -0500
Date: Fri, 3 Mar 2017 12:18:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170303011815.GB4067@umbus.fritz.box>
References: <1488463829-26839-1-git-send-email-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yEPQxsgoJgBvi8ip"
Content-Disposition: inline
In-Reply-To: <1488463829-26839-1-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2] target/ppc: rewrite f[n]m[add,
 sub] using float64_muladd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, rth@twiddle.net, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com


--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 02, 2017 at 07:40:29PM +0530, Nikunj A Dadhania wrote:
> Use the softfloat api for fused multiply-add.
> Introduce routine to set the FPSCR flags VXNAN, VXIMZ nad VMISI.
>=20
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

Merged, thanks.

>=20
> ---
>=20
> v1:
> * Removed float64_madd_set_vxisi()
> * Introduced float64_maddsub_update_excp() will updated required flags
> * Changed layout of error handling
>=20
> v0:
> * Use MADD/MSUB_FLAGS as used by VSX instructions
> * Introduce helper float64_madd_set_vxisi()
> ---
>  target/ppc/fpu_helper.c | 213 +++++++++++-------------------------------=
------
>  1 file changed, 46 insertions(+), 167 deletions(-)
>=20
> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
> index 58aee64..0535ad0 100644
> --- a/target/ppc/fpu_helper.c
> +++ b/target/ppc/fpu_helper.c
> @@ -743,178 +743,62 @@ uint64_t helper_frim(CPUPPCState *env, uint64_t ar=
g)
>      return do_fri(env, arg, float_round_down);
>  }
> =20
> -/* fmadd - fmadd. */
> -uint64_t helper_fmadd(CPUPPCState *env, uint64_t arg1, uint64_t arg2,
> -                      uint64_t arg3)
> +static void float64_maddsub_update_excp(CPUPPCState *env, float64 arg1,
> +                                        float64 arg2, float64 arg3,
> +                                        unsigned int madd_flags)
>  {
> -    CPU_DoubleU farg1, farg2, farg3;
> -
> -    farg1.ll =3D arg1;
> -    farg2.ll =3D arg2;
> -    farg3.ll =3D arg3;
> -
> -    if (unlikely((float64_is_infinity(farg1.d) && float64_is_zero(farg2.=
d)) ||
> -                 (float64_is_zero(farg1.d) && float64_is_infinity(farg2.=
d)))) {
> -        /* Multiplication of zero by infinity */
> -        farg1.ll =3D float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIMZ, 1=
);
> -    } else {
> -        if (unlikely(float64_is_signaling_nan(farg1.d, &env->fp_status) =
||
> -                     float64_is_signaling_nan(farg2.d, &env->fp_status) =
||
> -                     float64_is_signaling_nan(farg3.d, &env->fp_status))=
) {
> -            /* sNaN operation */
> -            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
> -        }
> -        /* This is the way the PowerPC specification defines it */
> -        float128 ft0_128, ft1_128;
> -
> -        ft0_128 =3D float64_to_float128(farg1.d, &env->fp_status);
> -        ft1_128 =3D float64_to_float128(farg2.d, &env->fp_status);
> -        ft0_128 =3D float128_mul(ft0_128, ft1_128, &env->fp_status);
> -        if (unlikely(float128_is_infinity(ft0_128) &&
> -                     float64_is_infinity(farg3.d) &&
> -                     float128_is_neg(ft0_128) !=3D float64_is_neg(farg3.=
d))) {
> -            /* Magnitude subtraction of infinities */
> -            farg1.ll =3D float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIS=
I, 1);
> -        } else {
> -            ft1_128 =3D float64_to_float128(farg3.d, &env->fp_status);
> -            ft0_128 =3D float128_add(ft0_128, ft1_128, &env->fp_status);
> -            farg1.d =3D float128_to_float64(ft0_128, &env->fp_status);
> -        }
> -    }
> -
> -    return farg1.ll;
> -}
> -
> -/* fmsub - fmsub. */
> -uint64_t helper_fmsub(CPUPPCState *env, uint64_t arg1, uint64_t arg2,
> -                      uint64_t arg3)
> -{
> -    CPU_DoubleU farg1, farg2, farg3;
> -
> -    farg1.ll =3D arg1;
> -    farg2.ll =3D arg2;
> -    farg3.ll =3D arg3;
> -
> -    if (unlikely((float64_is_infinity(farg1.d) && float64_is_zero(farg2.=
d)) ||
> -                 (float64_is_zero(farg1.d) &&
> -                  float64_is_infinity(farg2.d)))) {
> +    if (unlikely((float64_is_infinity(arg1) && float64_is_zero(arg2)) ||
> +                 (float64_is_zero(arg1) && float64_is_infinity(arg2)))) {
>          /* Multiplication of zero by infinity */
> -        farg1.ll =3D float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIMZ, 1=
);
> -    } else {
> -        if (unlikely(float64_is_signaling_nan(farg1.d, &env->fp_status) =
||
> -                     float64_is_signaling_nan(farg2.d, &env->fp_status) =
||
> -                     float64_is_signaling_nan(farg3.d, &env->fp_status))=
) {
> -            /* sNaN operation */
> -            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
> +        arg1 =3D float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIMZ, 1);
> +    } else if (unlikely(float64_is_signaling_nan(arg1, &env->fp_status) =
||
> +                        float64_is_signaling_nan(arg2, &env->fp_status) =
||
> +                        float64_is_signaling_nan(arg3, &env->fp_status))=
) {
> +        /* sNaN operation */
> +        float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
> +    } else if ((float64_is_infinity(arg1) || float64_is_infinity(arg2)) =
&&
> +               float64_is_infinity(arg3)) {
> +        uint8_t aSign, bSign, cSign;
> +
> +        aSign =3D float64_is_neg(arg1);
> +        bSign =3D float64_is_neg(arg2);
> +        cSign =3D float64_is_neg(arg3);
> +        if (madd_flags & float_muladd_negate_c) {
> +            cSign ^=3D 1;
>          }
> -        /* This is the way the PowerPC specification defines it */
> -        float128 ft0_128, ft1_128;
> -
> -        ft0_128 =3D float64_to_float128(farg1.d, &env->fp_status);
> -        ft1_128 =3D float64_to_float128(farg2.d, &env->fp_status);
> -        ft0_128 =3D float128_mul(ft0_128, ft1_128, &env->fp_status);
> -        if (unlikely(float128_is_infinity(ft0_128) &&
> -                     float64_is_infinity(farg3.d) &&
> -                     float128_is_neg(ft0_128) =3D=3D float64_is_neg(farg=
3.d))) {
> -            /* Magnitude subtraction of infinities */
> -            farg1.ll =3D float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIS=
I, 1);
> -        } else {
> -            ft1_128 =3D float64_to_float128(farg3.d, &env->fp_status);
> -            ft0_128 =3D float128_sub(ft0_128, ft1_128, &env->fp_status);
> -            farg1.d =3D float128_to_float64(ft0_128, &env->fp_status);
> +        if (aSign ^ bSign ^ cSign) {
> +            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXISI, 1);
>          }
>      }
> -    return farg1.ll;
>  }
> =20
> -/* fnmadd - fnmadd. */
> -uint64_t helper_fnmadd(CPUPPCState *env, uint64_t arg1, uint64_t arg2,
> -                       uint64_t arg3)
> -{
> -    CPU_DoubleU farg1, farg2, farg3;
> -
> -    farg1.ll =3D arg1;
> -    farg2.ll =3D arg2;
> -    farg3.ll =3D arg3;
> -
> -    if (unlikely((float64_is_infinity(farg1.d) && float64_is_zero(farg2.=
d)) ||
> -                 (float64_is_zero(farg1.d) && float64_is_infinity(farg2.=
d)))) {
> -        /* Multiplication of zero by infinity */
> -        farg1.ll =3D float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIMZ, 1=
);
> -    } else {
> -        if (unlikely(float64_is_signaling_nan(farg1.d, &env->fp_status) =
||
> -                     float64_is_signaling_nan(farg2.d, &env->fp_status) =
||
> -                     float64_is_signaling_nan(farg3.d, &env->fp_status))=
) {
> -            /* sNaN operation */
> -            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
> -        }
> -        /* This is the way the PowerPC specification defines it */
> -        float128 ft0_128, ft1_128;
> -
> -        ft0_128 =3D float64_to_float128(farg1.d, &env->fp_status);
> -        ft1_128 =3D float64_to_float128(farg2.d, &env->fp_status);
> -        ft0_128 =3D float128_mul(ft0_128, ft1_128, &env->fp_status);
> -        if (unlikely(float128_is_infinity(ft0_128) &&
> -                     float64_is_infinity(farg3.d) &&
> -                     float128_is_neg(ft0_128) !=3D float64_is_neg(farg3.=
d))) {
> -            /* Magnitude subtraction of infinities */
> -            farg1.ll =3D float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIS=
I, 1);
> -        } else {
> -            ft1_128 =3D float64_to_float128(farg3.d, &env->fp_status);
> -            ft0_128 =3D float128_add(ft0_128, ft1_128, &env->fp_status);
> -            farg1.d =3D float128_to_float64(ft0_128, &env->fp_status);
> -        }
> -        if (likely(!float64_is_any_nan(farg1.d))) {
> -            farg1.d =3D float64_chs(farg1.d);
> -        }
> -    }
> -    return farg1.ll;
> +#define FPU_FMADD(op, madd_flags)                                       \
> +uint64_t helper_##op(CPUPPCState *env, uint64_t arg1,                   \
> +                     uint64_t arg2, uint64_t arg3)                      \
> +{                                                                       \
> +    uint32_t flags;                                                     \
> +    float64 ret =3D float64_muladd(arg1, arg2, arg3, madd_flags,        =
  \
> +                                 &env->fp_status);                      \
> +    flags =3D get_float_exception_flags(&env->fp_status);               =
  \
> +    if (flags) {                                                        \
> +        if (flags & float_flag_invalid) {                               \
> +            float64_maddsub_update_excp(env, arg1, arg2, arg3,          \
> +                                        madd_flags);                    \
> +        }                                                               \
> +        float_check_status(env);                                        \
> +    }                                                                   \
> +    return ret;                                                         \
>  }
> =20
> -/* fnmsub - fnmsub. */
> -uint64_t helper_fnmsub(CPUPPCState *env, uint64_t arg1, uint64_t arg2,
> -                       uint64_t arg3)
> -{
> -    CPU_DoubleU farg1, farg2, farg3;
> -
> -    farg1.ll =3D arg1;
> -    farg2.ll =3D arg2;
> -    farg3.ll =3D arg3;
> +#define MADD_FLGS 0
> +#define MSUB_FLGS float_muladd_negate_c
> +#define NMADD_FLGS float_muladd_negate_result
> +#define NMSUB_FLGS (float_muladd_negate_c | float_muladd_negate_result)
> =20
> -    if (unlikely((float64_is_infinity(farg1.d) && float64_is_zero(farg2.=
d)) ||
> -                 (float64_is_zero(farg1.d) &&
> -                  float64_is_infinity(farg2.d)))) {
> -        /* Multiplication of zero by infinity */
> -        farg1.ll =3D float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIMZ, 1=
);
> -    } else {
> -        if (unlikely(float64_is_signaling_nan(farg1.d, &env->fp_status) =
||
> -                     float64_is_signaling_nan(farg2.d, &env->fp_status) =
||
> -                     float64_is_signaling_nan(farg3.d, &env->fp_status))=
) {
> -            /* sNaN operation */
> -            float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
> -        }
> -        /* This is the way the PowerPC specification defines it */
> -        float128 ft0_128, ft1_128;
> -
> -        ft0_128 =3D float64_to_float128(farg1.d, &env->fp_status);
> -        ft1_128 =3D float64_to_float128(farg2.d, &env->fp_status);
> -        ft0_128 =3D float128_mul(ft0_128, ft1_128, &env->fp_status);
> -        if (unlikely(float128_is_infinity(ft0_128) &&
> -                     float64_is_infinity(farg3.d) &&
> -                     float128_is_neg(ft0_128) =3D=3D float64_is_neg(farg=
3.d))) {
> -            /* Magnitude subtraction of infinities */
> -            farg1.ll =3D float_invalid_op_excp(env, POWERPC_EXCP_FP_VXIS=
I, 1);
> -        } else {
> -            ft1_128 =3D float64_to_float128(farg3.d, &env->fp_status);
> -            ft0_128 =3D float128_sub(ft0_128, ft1_128, &env->fp_status);
> -            farg1.d =3D float128_to_float64(ft0_128, &env->fp_status);
> -        }
> -        if (likely(!float64_is_any_nan(farg1.d))) {
> -            farg1.d =3D float64_chs(farg1.d);
> -        }
> -    }
> -    return farg1.ll;
> -}
> +FPU_FMADD(fmadd, MADD_FLGS)
> +FPU_FMADD(fnmadd, NMADD_FLGS)
> +FPU_FMADD(fmsub, MSUB_FLGS)
> +FPU_FMADD(fnmsub, NMSUB_FLGS)
> =20
>  /* frsp - frsp. */
>  uint64_t helper_frsp(CPUPPCState *env, uint64_t arg)
> @@ -2384,11 +2268,6 @@ void helper_##op(CPUPPCState *env, uint32_t opcode=
)                           \
>      float_check_status(env);                                            =
      \
>  }
> =20
> -#define MADD_FLGS 0
> -#define MSUB_FLGS float_muladd_negate_c
> -#define NMADD_FLGS float_muladd_negate_result
> -#define NMSUB_FLGS (float_muladd_negate_c | float_muladd_negate_result)
> -
>  VSX_MADD(xsmaddadp, 1, float64, VsrD(0), MADD_FLGS, 1, 1, 0)
>  VSX_MADD(xsmaddmdp, 1, float64, VsrD(0), MADD_FLGS, 0, 1, 0)
>  VSX_MADD(xsmsubadp, 1, float64, VsrD(0), MSUB_FLGS, 1, 1, 0)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--yEPQxsgoJgBvi8ip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYuMRVAAoJEGw4ysog2bOSN5QQAMe6WX7aickMZqhZmLtNBNlk
qKw+/Jxw/ey4/U45Gp+ioYU7bKMZFg3xYqxImxwfb16tQiHBFTS3nI6wsL/Pzllc
He91ZsmmQEeaUkOCA2ok93+B9TTEzB0MXE1/q7efj6fvd4XqxUX+BpM5mxuo9F6I
QGNsNXL1Q2sNXf62DhibpDHXqXBdexRl8QSq/VvEdq38gD+JVKs/s2L1RmWVO2jh
fkkqP9JCoGdbm7QIP1NgOT5VX0U8LkbPxOM5d0Y5p7ROELePuQhYXvG9UceLunBW
Vh3xIzRfXPILsnZrDqqf4sUa3vzE9I6Nxu7luIFNAf/XKrWdwzH8xLQfsxFx60Mv
cxKGmIDhwo6z64owYoPfalKHpDWAM9JWG5D86pwlTV/Y0vo7yJm0mydd622cMZXS
0SdjfRxHCEbAOQip/Dl09itQMe8a1BVzL+NLJRpHC5jLv05f20BHTA4xWp8efldP
gUv0aSZkJcBS50L9dUeDrGZ/GfEwEEgxPqRf25Vj7VdvJ6Krr0UKOjxnLsLvgHMr
j8rm6J5XDJpv5a5Wp69o2tanSwV5ff+aRCwUoYhDiu+vEmsHsUq4aDcdNm+3d1mw
zk42YRwzR4bWbw+beoSSkLDfMhMRepxicl30GDUcDnHV0vUSpDgqr93BjHA919WY
k/BfiGBxbRrfcLZr+uos
=ylXJ
-----END PGP SIGNATURE-----

--yEPQxsgoJgBvi8ip--
