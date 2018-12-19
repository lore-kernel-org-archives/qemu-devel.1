Received: from eggs.gnu.org ([2001:4830:134:3::10]:41686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZWbj-0001wP-8T
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:49:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZWbh-0005q7-0E
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:49:31 -0500
Date: Wed, 19 Dec 2018 17:29:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181219062925.GM30570@umbus.fritz.box>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
	<20181218063911.2112-18-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8c07nsHwQobhlezh"
Content-Disposition: inline
In-Reply-To: <20181218063911.2112-18-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 17/34] target/ppc: convert VMX logical
 instructions to use vector operations
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


--8c07nsHwQobhlezh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2018 at 10:38:54PM -0800, Richard Henderson wrote:
> From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> Message-Id: <20181217122405.18732-9-mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/translate.c              |  1 +
>  target/ppc/translate/vmx-impl.inc.c | 63 ++++++++++++++++-------------
>  2 files changed, 37 insertions(+), 27 deletions(-)
>=20
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 8e89aec14d..1b61bfa093 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -24,6 +24,7 @@
>  #include "disas/disas.h"
>  #include "exec/exec-all.h"
>  #include "tcg-op.h"
> +#include "tcg-op-gvec.h"
>  #include "qemu/host-utils.h"
>  #include "exec/cpu_ldst.h"
> =20
> diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/v=
mx-impl.inc.c
> index 75d2b2280f..c13828a09d 100644
> --- a/target/ppc/translate/vmx-impl.inc.c
> +++ b/target/ppc/translate/vmx-impl.inc.c
> @@ -262,41 +262,50 @@ GEN_VX_VMUL10(vmul10euq, 1, 0);
>  GEN_VX_VMUL10(vmul10cuq, 0, 1);
>  GEN_VX_VMUL10(vmul10ecuq, 1, 1);
> =20
> -/* Logical operations */
> -#define GEN_VX_LOGICAL(name, tcg_op, opc2, opc3)                        \
> -static void glue(gen_, name)(DisasContext *ctx)                         =
        \
> +#define GEN_VXFORM_V(name, vece, tcg_op, opc2, opc3)                    \
> +static void glue(gen_, name)(DisasContext *ctx)                         \
>  {                                                                       \
> -    TCGv_i64 t0 =3D tcg_temp_new_i64();                                 =
  \
> -    TCGv_i64 t1 =3D tcg_temp_new_i64();                                 =
  \
> -    TCGv_i64 avr =3D tcg_temp_new_i64();                                =
  \
> -                                                                        \
>      if (unlikely(!ctx->altivec_enabled)) {                              \
>          gen_exception(ctx, POWERPC_EXCP_VPU);                           \
>          return;                                                         \
>      }                                                                   \
> -    get_avr64(t0, rA(ctx->opcode), true);                               \
> -    get_avr64(t1, rB(ctx->opcode), true);                               \
> -    tcg_op(avr, t0, t1);                                                \
> -    set_avr64(rD(ctx->opcode), avr, true);                              \
>                                                                          \
> -    get_avr64(t0, rA(ctx->opcode), false);                              \
> -    get_avr64(t1, rB(ctx->opcode), false);                              \
> -    tcg_op(avr, t0, t1);                                                \
> -    set_avr64(rD(ctx->opcode), avr, false);                             \
> -                                                                        \
> -    tcg_temp_free_i64(t0);                                              \
> -    tcg_temp_free_i64(t1);                                              \
> -    tcg_temp_free_i64(avr);                                             \
> +    tcg_op(vece,                                                        \
> +           avr64_offset(rD(ctx->opcode), true),                         \
> +           avr64_offset(rA(ctx->opcode), true),                         \
> +           avr64_offset(rB(ctx->opcode), true),                         \
> +           16, 16);                                                     \
>  }
> =20
> -GEN_VX_LOGICAL(vand, tcg_gen_and_i64, 2, 16);
> -GEN_VX_LOGICAL(vandc, tcg_gen_andc_i64, 2, 17);
> -GEN_VX_LOGICAL(vor, tcg_gen_or_i64, 2, 18);
> -GEN_VX_LOGICAL(vxor, tcg_gen_xor_i64, 2, 19);
> -GEN_VX_LOGICAL(vnor, tcg_gen_nor_i64, 2, 20);
> -GEN_VX_LOGICAL(veqv, tcg_gen_eqv_i64, 2, 26);
> -GEN_VX_LOGICAL(vnand, tcg_gen_nand_i64, 2, 22);
> -GEN_VX_LOGICAL(vorc, tcg_gen_orc_i64, 2, 21);
> +#define GEN_VXFORM_VN(name, vece, tcg_op, opc2, opc3)                   \
> +static void glue(gen_, name)(DisasContext *ctx)                         \
> +{                                                                       \
> +    if (unlikely(!ctx->altivec_enabled)) {                              \
> +        gen_exception(ctx, POWERPC_EXCP_VPU);                           \
> +        return;                                                         \
> +    }                                                                   \
> +                                                                        \
> +    tcg_op(vece,                                                        \
> +           avr64_offset(rD(ctx->opcode), true),                         \
> +           avr64_offset(rA(ctx->opcode), true),                         \
> +           avr64_offset(rB(ctx->opcode), true),                         \
> +           16, 16);                                                     \
> +                                                                        \
> +    tcg_gen_gvec_not(vece,                                              \
> +                     avr64_offset(rD(ctx->opcode), true),               \
> +                     avr64_offset(rD(ctx->opcode), true),               \
> +                     16, 16);                                           \
> +}
> +
> +/* Logical operations */
> +GEN_VXFORM_V(vand, MO_64, tcg_gen_gvec_and, 2, 16);
> +GEN_VXFORM_V(vandc, MO_64, tcg_gen_gvec_andc, 2, 17);
> +GEN_VXFORM_V(vor, MO_64, tcg_gen_gvec_or, 2, 18);
> +GEN_VXFORM_V(vxor, MO_64, tcg_gen_gvec_xor, 2, 19);
> +GEN_VXFORM_VN(vnor, MO_64, tcg_gen_gvec_or, 2, 20);
> +GEN_VXFORM_VN(veqv, MO_64, tcg_gen_gvec_xor, 2, 26);
> +GEN_VXFORM_VN(vnand, MO_64, tcg_gen_gvec_and, 2, 22);
> +GEN_VXFORM_V(vorc, MO_64, tcg_gen_gvec_orc, 2, 21);
> =20
>  #define GEN_VXFORM(name, opc2, opc3)                                    \
>  static void glue(gen_, name)(DisasContext *ctx)                         =
        \

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8c07nsHwQobhlezh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwZ5UUACgkQbDjKyiDZ
s5I6iw/9FmecQePYIYFOhDjP6n/Jpo9w2e4c9M1cl4KLAKGuz0F+s9GmVm/GvEZp
EtE1vn/ZzR177es/vgutfmuQ6m2OfHU3SEQdiLISlePphTrSbQj+AfCmmQO1PLWi
iYVezVyNqLCnMIjMlrjq8qamcrFSNjlfIjNNu7DyiD8GEOJssGC8tfR0Ffx6JptK
E/3oa1yCQx7+g+OpMfGShCZE16ygj/xh6OgHdWOi9OH1udhFt3jow6TA56EcYxgq
6uHIPkL6IayIzEQ8+4uwo87EN6J2R+kYGPlFpqo52CtSgfTjk05ZBmdfe+w/B+/o
T+g+XIvarmw80k4vwY2pDPniK1xgJRlJIoaLDIehCEwYURliM2kyYy3n66Gz5KzZ
9sL7oaTwVwaN9dRZOJNYpVG5HgrQwcWYP5jVMtLetekKDUcCj/go8dFsVTFZGHNh
rL1E4YXyFHng7bP3+MbwrvT4XoLmjXF2tl6u3OAaOWsE35mZZcEfdvWB5+LD04Bw
85X37U6ncWR+lm2afmtjAJMyNx2iIwp6JqOxH5KolO0FNMApNgkl67N1Wmfq6EUh
y37GY5c0qMAY3U8Q1+h829xFqvJCZI5NjpV+BorUGYDouHy9w1SZgDQzAOZlWhqc
2Uj6hEeZk/TtbCvsRxk4vqhjYUOXzQAW7gm67m7bdwvRU8Y9enk=
=EiRF
-----END PGP SIGNATURE-----

--8c07nsHwQobhlezh--
