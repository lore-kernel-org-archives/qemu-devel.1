Received: from eggs.gnu.org ([2001:4830:134:3::10]:57646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ej19n-0005P6-5B
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:11:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ej19h-0004wg-JS
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:11:23 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:34987)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ej19h-0004wC-8g
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:11:17 -0500
Received: by mail-wr0-x241.google.com with SMTP id w50so1467105wrc.2
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 03:11:17 -0800 (PST)
References: <20180126045742.5487-1-richard.henderson@linaro.org>
	<20180126045742.5487-18-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180126045742.5487-18-richard.henderson@linaro.org>
Date: Tue, 06 Feb 2018 11:11:14 +0000
Message-ID: <87inbawey5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 17/20] target/arm: Use vector
 infrastructure for aa64 multiplies
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/translate-a64.c | 154 +++++++++++++++++++++++++++++++++++++--=
------
>  1 file changed, 129 insertions(+), 25 deletions(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index c928c4787c..64a2c2df59 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -9753,6 +9753,66 @@ static void disas_simd_3same_float(DisasContext *s=
, uint32_t insn)
>      }
>  }
>
> +static void gen_mla8_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
> +{
> +    gen_helper_neon_mul_u8(a, a, b);
> +    gen_helper_neon_add_u8(d, d, a);
> +}
> +
> +static void gen_mla16_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
> +{
> +    gen_helper_neon_mul_u16(a, a, b);
> +    gen_helper_neon_add_u16(d, d, a);
> +}
> +
> +static void gen_mla32_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
> +{
> +    tcg_gen_mul_i32(a, a, b);
> +    tcg_gen_add_i32(d, d, a);
> +}
> +
> +static void gen_mla64_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
> +{
> +    tcg_gen_mul_i64(a, a, b);
> +    tcg_gen_add_i64(d, d, a);
> +}
> +
> +static void gen_mla_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec =
b)
> +{
> +    tcg_gen_mul_vec(vece, a, a, b);
> +    tcg_gen_add_vec(vece, d, d, a);
> +}
> +
> +static void gen_mls8_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
> +{
> +    gen_helper_neon_mul_u8(a, a, b);
> +    gen_helper_neon_sub_u8(d, d, a);
> +}
> +
> +static void gen_mls16_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
> +{
> +    gen_helper_neon_mul_u16(a, a, b);
> +    gen_helper_neon_sub_u16(d, d, a);
> +}
> +
> +static void gen_mls32_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
> +{
> +    tcg_gen_mul_i32(a, a, b);
> +    tcg_gen_sub_i32(d, d, a);
> +}
> +
> +static void gen_mls64_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
> +{
> +    tcg_gen_mul_i64(a, a, b);
> +    tcg_gen_sub_i64(d, d, a);
> +}
> +
> +static void gen_mls_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec =
b)
> +{
> +    tcg_gen_mul_vec(vece, a, a, b);
> +    tcg_gen_sub_vec(vece, d, d, a);
> +}
> +
>  /* Integer op subgroup of C3.6.16. */
>  static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
>  {
> @@ -9771,6 +9831,52 @@ static void disas_simd_3same_int(DisasContext *s, =
uint32_t insn)
>            .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
>            .vece =3D MO_64 },
>      };
> +    static const GVecGen3 mla_op[4] =3D {
> +        { .fni4 =3D gen_mla8_i32,
> +          .fniv =3D gen_mla_vec,
> +          .opc =3D INDEX_op_mul_vec,
> +          .load_dest =3D true,
> +          .vece =3D MO_8 },
> +        { .fni4 =3D gen_mla16_i32,
> +          .fniv =3D gen_mla_vec,
> +          .opc =3D INDEX_op_mul_vec,
> +          .load_dest =3D true,
> +          .vece =3D MO_16 },
> +        { .fni4 =3D gen_mla32_i32,
> +          .fniv =3D gen_mla_vec,
> +          .opc =3D INDEX_op_mul_vec,
> +          .load_dest =3D true,
> +          .vece =3D MO_32 },
> +        { .fni8 =3D gen_mla64_i64,
> +          .fniv =3D gen_mla_vec,
> +          .opc =3D INDEX_op_mul_vec,
> +          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
> +          .load_dest =3D true,
> +          .vece =3D MO_64 },
> +    };
> +    static const GVecGen3 mls_op[4] =3D {
> +        { .fni4 =3D gen_mls8_i32,
> +          .fniv =3D gen_mls_vec,
> +          .opc =3D INDEX_op_mul_vec,
> +          .load_dest =3D true,
> +          .vece =3D MO_8 },
> +        { .fni4 =3D gen_mls16_i32,
> +          .fniv =3D gen_mls_vec,
> +          .opc =3D INDEX_op_mul_vec,
> +          .load_dest =3D true,
> +          .vece =3D MO_16 },
> +        { .fni4 =3D gen_mls32_i32,
> +          .fniv =3D gen_mls_vec,
> +          .opc =3D INDEX_op_mul_vec,
> +          .load_dest =3D true,
> +          .vece =3D MO_32 },
> +        { .fni8 =3D gen_mls64_i64,
> +          .fniv =3D gen_mls_vec,
> +          .opc =3D INDEX_op_mul_vec,
> +          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
> +          .load_dest =3D true,
> +          .vece =3D MO_64 },
> +    };
>
>      int is_q =3D extract32(insn, 30, 1);
>      int u =3D extract32(insn, 29, 1);
> @@ -9828,6 +9934,19 @@ static void disas_simd_3same_int(DisasContext *s, =
uint32_t insn)
>              gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_add, size);
>          }
>          return;
> +    case 0x13: /* MUL, PMUL */
> +        if (!u) { /* MUL */
> +            gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_mul, size);
> +            return;
> +        }
> +        break;
> +    case 0x12: /* MLA, MLS */
> +        if (u) {
> +            gen_gvec_op3(s, is_q, rd, rn, rm, &mls_op[size]);
> +        } else {
> +            gen_gvec_op3(s, is_q, rd, rn, rm, &mla_op[size]);
> +        }
> +        return;
>      case 0x11:
>          if (!u) { /* CMTST */
>              gen_gvec_op3(s, is_q, rd, rn, rm, &cmtst_op[size]);
> @@ -10002,23 +10121,10 @@ static void disas_simd_3same_int(DisasContext *=
s, uint32_t insn)
>                  break;
>              }
>              case 0x13: /* MUL, PMUL */
> -                if (u) {
> -                    /* PMUL */
> -                    assert(size =3D=3D 0);
> -                    genfn =3D gen_helper_neon_mul_p8;
> -                    break;
> -                }
> -                /* fall through : MUL */
> -            case 0x12: /* MLA, MLS */
> -            {
> -                static NeonGenTwoOpFn * const fns[3] =3D {
> -                    gen_helper_neon_mul_u8,
> -                    gen_helper_neon_mul_u16,
> -                    tcg_gen_mul_i32,
> -                };
> -                genfn =3D fns[size];
> +                assert(u); /* PMUL */
> +                assert(size =3D=3D 0);
> +                genfn =3D gen_helper_neon_mul_p8;
>                  break;
> -            }
>              case 0x16: /* SQDMULH, SQRDMULH */
>              {
>                  static NeonGenTwoOpEnvFn * const fns[2][2] =3D {
> @@ -10039,18 +10145,16 @@ static void disas_simd_3same_int(DisasContext *=
s, uint32_t insn)
>                  genfn(tcg_res, tcg_op1, tcg_op2);
>              }
>
> -            if (opcode =3D=3D 0xf || opcode =3D=3D 0x12) {
> -                /* SABA, UABA, MLA, MLS: accumulating ops */
> -                static NeonGenTwoOpFn * const fns[3][2] =3D {
> -                    { gen_helper_neon_add_u8, gen_helper_neon_sub_u8 },
> -                    { gen_helper_neon_add_u16, gen_helper_neon_sub_u16 },
> -                    { tcg_gen_add_i32, tcg_gen_sub_i32 },
> +            if (opcode =3D=3D 0xf) {
> +                /* SABA, UABA: accumulating ops */
> +                static NeonGenTwoOpFn * const fns[3] =3D {
> +                    gen_helper_neon_add_u8,
> +                    gen_helper_neon_add_u16,
> +                    tcg_gen_add_i32,
>                  };
> -                bool is_sub =3D (opcode =3D=3D 0x12 && u); /* MLS */
>
> -                genfn =3D fns[size][is_sub];
>                  read_vec_element_i32(s, tcg_op1, rd, pass, MO_32);
> -                genfn(tcg_res, tcg_op1, tcg_res);
> +                fns[size](tcg_res, tcg_op1, tcg_res);
>              }
>
>              write_vec_element_i32(s, tcg_res, rd, pass, MO_32);


--
Alex Benn=C3=A9e
