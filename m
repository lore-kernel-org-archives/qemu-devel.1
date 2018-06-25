Received: from eggs.gnu.org ([2001:4830:134:3::10]:46552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fXFzx-0007vv-8Y
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 21:08:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fXFzv-0000LL-Lk
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 21:08:53 -0400
Date: Mon, 25 Jun 2018 10:46:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180625004658.GB22971@umbus.fritz.box>
References: <20180623022258.22158-1-programmingkidx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cmJC7u66zC7hs+87"
Content-Disposition: inline
In-Reply-To: <20180623022258.22158-1-programmingkidx@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] fix fdiv instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 22, 2018 at 10:22:58PM -0400, John Arbuckle wrote:
> When the fdiv instruction divides a finite number by zero,
> the result actually depends on the FPSCR[ZE] bit. If this
> bit is set, the return value is zero. If it is not set
> the result should be either positive or negative infinity.
> The sign of this result would depend on the sign of the
> two inputs. What currently happens is only infinity is
> returned even if the FPSCR[ZE] bit is set. This patch
> fixes this problem by actually checking the FPSCR[ZE] bit
> when deciding what the answer should be.
>=20
> fdiv is suppose to only set the FPSCR's FPRF bits during a
> division by zero situation when the FPSCR[ZE] is not set.
> What currently happens is these bits are always set. This
> patch fixes this problem by checking the FPSCR[ZE] bit to
> decide if the FPRF bits should be set.=20
>=20
> https://www.pdfdrive.net/powerpc-microprocessor-family-the-programming-en=
vironments-for-32-e3087633.html
> This document has the information on the fdiv. Page 133 has the
> information on what action is executed when a division by zero
> situation takes place.

I'm looking at that table and there is definitely no mention of a 0
*result* in any situation.  So this patch is definitely wrong on that
point.  If there's something else this is fixing, then the commit
message needs to describe that.

>=20
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---
>  target/ppc/fpu_helper.c            | 16 ++++++++++++++++
>  target/ppc/translate/fp-impl.inc.c | 28 +++++++++++++++++++++++++++-
>  2 files changed, 43 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
> index 7714bfe0f9..de694604fb 100644
> --- a/target/ppc/fpu_helper.c
> +++ b/target/ppc/fpu_helper.c
> @@ -658,6 +658,20 @@ uint64_t helper_fdiv(CPUPPCState *env, uint64_t arg1=
, uint64_t arg2)
>      } else if (unlikely(float64_is_zero(farg1.d) && float64_is_zero(farg=
2.d))) {
>          /* Division of zero by zero */
>          farg1.ll =3D float_invalid_op_excp(env, POWERPC_EXCP_FP_VXZDZ, 1=
);
> +    } else if (arg2 =3D=3D 0) {
> +        /* Division by zero */
> +        float_zero_divide_excp(env, GETPC());
> +        if (fpscr_ze) { /* if zero divide exception is enabled */
> +            farg1.ll =3D 0;
> +        } else {
> +            uint64_t sign =3D (farg1.ll ^ farg2.ll) >> 63;
> +            if (sign) { /* Negative sign bit */
> +                farg1.ll =3D 0xfff0000000000000; /* Negative Infinity */
> +            } else { /* Positive sign bit */
> +                farg1.ll =3D 0x7ff0000000000000; /* Positive Infinity */
> +            }
> +            helper_compute_fprf_float64(env, farg1.d);
> +        }
>      } else {
>          if (unlikely(float64_is_signaling_nan(farg1.d, &env->fp_status) =
||
>                       float64_is_signaling_nan(farg2.d, &env->fp_status))=
) {
> @@ -665,6 +679,8 @@ uint64_t helper_fdiv(CPUPPCState *env, uint64_t arg1,=
 uint64_t arg2)
>              float_invalid_op_excp(env, POWERPC_EXCP_FP_VXSNAN, 1);
>          }
>          farg1.d =3D float64_div(farg1.d, farg2.d, &env->fp_status);
> +        helper_compute_fprf_float64(env, farg1.d);
> +        helper_float_check_status(env);
>      }
> =20
>      return farg1.ll;
> diff --git a/target/ppc/translate/fp-impl.inc.c b/target/ppc/translate/fp=
-impl.inc.c
> index 2fbd4d4f38..4e20bcceb4 100644
> --- a/target/ppc/translate/fp-impl.inc.c
> +++ b/target/ppc/translate/fp-impl.inc.c
> @@ -84,6 +84,32 @@ static void gen_f##name(DisasContext *ctx)            =
                        \
>  _GEN_FLOAT_AB(name, name, 0x3F, op2, inval, 0, set_fprf, type);         =
      \
>  _GEN_FLOAT_AB(name##s, name, 0x3B, op2, inval, 1, set_fprf, type);
> =20
> +
> +#define _GEN_FLOAT_DIV(name, op, op1, op2, inval, isfloat, set_fprf, typ=
e)    \
> +static void gen_f##name(DisasContext *ctx)                              =
      \
> +{                                                                       =
      \
> +    if (unlikely(!ctx->fpu_enabled)) {                                  =
      \
> +        gen_exception(ctx, POWERPC_EXCP_FPU);                           =
      \
> +        return;                                                         =
      \
> +    }                                                                   =
      \
> +    gen_reset_fpstatus();                                               =
      \
> +    gen_helper_f##op(cpu_fpr[rD(ctx->opcode)], cpu_env,                 =
      \
> +                     cpu_fpr[rA(ctx->opcode)],                          =
      \
> +                     cpu_fpr[rB(ctx->opcode)]);                         =
      \
> +    if (isfloat) {                                                      =
      \
> +        gen_helper_frsp(cpu_fpr[rD(ctx->opcode)], cpu_env,              =
      \
> +                        cpu_fpr[rD(ctx->opcode)]);                      =
      \
> +    }                                                                   =
      \
> +    if (unlikely(Rc(ctx->opcode) !=3D 0)) {                             =
        \
> +        gen_set_cr1_from_fpscr(ctx);                                    =
      \
> +    }                                                                   =
      \
> +}
> +
> +#define GEN_FLOAT_DIV(name, op2, inval, set_fprf, type)                 =
      \
> +_GEN_FLOAT_DIV(name, name, 0x3F, op2, inval, 0, set_fprf, type);        =
      \
> +_GEN_FLOAT_DIV(name##s, name, 0x3B, op2, inval, 1, set_fprf, type);
> +
> +
>  #define _GEN_FLOAT_AC(name, op, op1, op2, inval, isfloat, set_fprf, type=
)     \
>  static void gen_f##name(DisasContext *ctx)                              =
      \
>  {                                                                       =
      \
> @@ -149,7 +175,7 @@ static void gen_f##name(DisasContext *ctx)           =
                         \
>  /* fadd - fadds */
>  GEN_FLOAT_AB(add, 0x15, 0x000007C0, 1, PPC_FLOAT);
>  /* fdiv - fdivs */
> -GEN_FLOAT_AB(div, 0x12, 0x000007C0, 1, PPC_FLOAT);
> +GEN_FLOAT_DIV(div, 0x12, 0x000007C0, 1, PPC_FLOAT);
>  /* fmul - fmuls */
>  GEN_FLOAT_AC(mul, 0x19, 0x0000F800, 1, PPC_FLOAT);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cmJC7u66zC7hs+87
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlswO4IACgkQbDjKyiDZ
s5Je9hAAtC/tT2HM5MHngczwqOs8KtuKNX0JLHKiE7yNqVbcfRenN6IYKY4tX/Pl
/q7UmJbmIkkju+tCKxGKohXH/GwB+sjSRfsbMXhyMelv1zGxCh4LbCrShwQo3kKz
Zz1H9y0StDtbSQsu5LJsMtuYnGd+hcWY36vYWU/t3nIaPUgZ1sZUb5Utw/Z/Gpyj
i7PYMLt6JG7I2aYqIG+y0mOluZFjyC44sID6smPzDK89GeEkd7MlIgAtnhMK/fAq
KyEd8s3mIrCGHcvSVMxWbqpyfAHEQni7VOu82RkAD7jKWqM3t8jy2BoErUkCrZ/I
49m/01L7EHtYjlYxcS9NrnQIN5qkgfr2BsoaQOnx2bTRajTWKOs974FmgLK6keN1
j9hwvhRwnSSlFNjHL9/P3xbuOu2x/EqXKCM1muyU0mDrpuGhhDNocEeCGFZPZxvg
U6fqsRA/CyCqWPRx7BEenSguVVZiptYmOfVNLzQX4IiTnASSg+JkjReeCsnF9/+V
kQQrCP03IPXLOCuIATzW2cKr/q9AxEb3+zPohj/Q7LYoRK4ftg8FphduGOQ6DIQF
SdaGePv6XOLfteuo6k+ddUmvOGAIF4GhvcfCCB8VADyeDx+VE+mXMfWtbEDHcDh1
5twJK2OA+pOgjyFxaBhEmB+smL5zH+59H6BMce4H6p1N7V9ofgs=
=+RBc
-----END PGP SIGNATURE-----

--cmJC7u66zC7hs+87--
