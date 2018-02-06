Received: from eggs.gnu.org ([2001:4830:134:3::10]:57359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ej18y-0004eW-Am
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:10:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ej18x-0004Vj-1C
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:10:32 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:38059)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ej18w-0004UL-La
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:10:30 -0500
Received: by mail-wr0-x243.google.com with SMTP id t94so1458608wrc.5
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 03:10:30 -0800 (PST)
References: <20180126045742.5487-1-richard.henderson@linaro.org>
	<20180126045742.5487-17-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180126045742.5487-17-richard.henderson@linaro.org>
Date: Tue, 06 Feb 2018 11:10:28 +0000
Message-ID: <87k1vqwezf.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 16/20] target/arm: Use vector
 infrastructure for aa64 compares
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
>  target/arm/translate-a64.c | 93 +++++++++++++++++++++++++++++-----------=
------
>  1 file changed, 59 insertions(+), 34 deletions(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 38400560db..c928c4787c 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -7209,6 +7209,28 @@ static void disas_simd_scalar_three_reg_diff(Disas=
Context *s, uint32_t insn)
>      }
>  }
>
> +/* CMTST : test is "if (X & Y !=3D 0)". */
> +static void gen_cmtst_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
> +{
> +    tcg_gen_and_i32(d, a, b);
> +    tcg_gen_setcondi_i32(TCG_COND_NE, d, d, 0);
> +    tcg_gen_neg_i32(d, d);
> +}
> +
> +static void gen_cmtst_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
> +{
> +    tcg_gen_and_i64(d, a, b);
> +    tcg_gen_setcondi_i64(TCG_COND_NE, d, d, 0);
> +    tcg_gen_neg_i64(d, d);
> +}
> +
> +static void gen_cmtst_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_ve=
c b)
> +{
> +    tcg_gen_and_vec(vece, d, a, b);
> +    tcg_gen_dupi_vec(vece, a, 0);
> +    tcg_gen_cmp_vec(TCG_COND_NE, vece, d, d, a);
> +}
> +
>  static void handle_3same_64(DisasContext *s, int opcode, bool u,
>                              TCGv_i64 tcg_rd, TCGv_i64 tcg_rn, TCGv_i64 t=
cg_rm)
>  {
> @@ -7252,10 +7274,7 @@ static void handle_3same_64(DisasContext *s, int o=
pcode, bool u,
>              cond =3D TCG_COND_EQ;
>              goto do_cmop;
>          }
> -        /* CMTST : test is "if (X & Y !=3D 0)". */
> -        tcg_gen_and_i64(tcg_rd, tcg_rn, tcg_rm);
> -        tcg_gen_setcondi_i64(TCG_COND_NE, tcg_rd, tcg_rd, 0);
> -        tcg_gen_neg_i64(tcg_rd, tcg_rd);
> +        gen_cmtst_i64(tcg_rd, tcg_rn, tcg_rm);
>          break;
>      case 0x8: /* SSHL, USHL */
>          if (u) {
> @@ -9737,6 +9756,22 @@ static void disas_simd_3same_float(DisasContext *s=
, uint32_t insn)
>  /* Integer op subgroup of C3.6.16. */
>  static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
>  {
> +    static const GVecGen3 cmtst_op[4] =3D {
> +        { .fni4 =3D gen_helper_neon_tst_u8,
> +          .fniv =3D gen_cmtst_vec,
> +          .vece =3D MO_8 },
> +        { .fni4 =3D gen_helper_neon_tst_u16,
> +          .fniv =3D gen_cmtst_vec,
> +          .vece =3D MO_16 },
> +        { .fni4 =3D gen_cmtst_i32,
> +          .fniv =3D gen_cmtst_vec,
> +          .vece =3D MO_32 },
> +        { .fni8 =3D gen_cmtst_i64,
> +          .fniv =3D gen_cmtst_vec,
> +          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
> +          .vece =3D MO_64 },
> +    };
> +
>      int is_q =3D extract32(insn, 30, 1);
>      int u =3D extract32(insn, 29, 1);
>      int size =3D extract32(insn, 22, 2);
> @@ -9745,6 +9780,7 @@ static void disas_simd_3same_int(DisasContext *s, u=
int32_t insn)
>      int rn =3D extract32(insn, 5, 5);
>      int rd =3D extract32(insn, 0, 5);
>      int pass;
> +    TCGCond cond;
>
>      switch (opcode) {
>      case 0x13: /* MUL, PMUL */
> @@ -9792,6 +9828,25 @@ static void disas_simd_3same_int(DisasContext *s, =
uint32_t insn)
>              gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_add, size);
>          }
>          return;
> +    case 0x11:
> +        if (!u) { /* CMTST */
> +            gen_gvec_op3(s, is_q, rd, rn, rm, &cmtst_op[size]);
> +            return;
> +        }
> +        /* else CMEQ */
> +        cond =3D TCG_COND_EQ;
> +        goto do_gvec_cmp;
> +    case 0x06: /* CMGT, CMHI */
> +        cond =3D u ? TCG_COND_GTU : TCG_COND_GT;
> +        goto do_gvec_cmp;
> +    case 0x07: /* CMGE, CMHS */
> +        cond =3D u ? TCG_COND_GEU : TCG_COND_GE;
> +    do_gvec_cmp:
> +        tcg_gen_gvec_cmp(cond, size, vec_full_reg_offset(s, rd),
> +                         vec_full_reg_offset(s, rn),
> +                         vec_full_reg_offset(s, rm),
> +                         is_q ? 16 : 8, vec_full_reg_size(s));
> +        return;
>      }
>
>      if (size =3D=3D 3) {
> @@ -9874,26 +9929,6 @@ static void disas_simd_3same_int(DisasContext *s, =
uint32_t insn)
>                  genenvfn =3D fns[size][u];
>                  break;
>              }
> -            case 0x6: /* CMGT, CMHI */
> -            {
> -                static NeonGenTwoOpFn * const fns[3][2] =3D {
> -                    { gen_helper_neon_cgt_s8, gen_helper_neon_cgt_u8 },
> -                    { gen_helper_neon_cgt_s16, gen_helper_neon_cgt_u16 },
> -                    { gen_helper_neon_cgt_s32, gen_helper_neon_cgt_u32 },
> -                };
> -                genfn =3D fns[size][u];
> -                break;
> -            }
> -            case 0x7: /* CMGE, CMHS */
> -            {
> -                static NeonGenTwoOpFn * const fns[3][2] =3D {
> -                    { gen_helper_neon_cge_s8, gen_helper_neon_cge_u8 },
> -                    { gen_helper_neon_cge_s16, gen_helper_neon_cge_u16 },
> -                    { gen_helper_neon_cge_s32, gen_helper_neon_cge_u32 },
> -                };
> -                genfn =3D fns[size][u];
> -                break;
> -            }
>              case 0x8: /* SSHL, USHL */
>              {
>                  static NeonGenTwoOpFn * const fns[3][2] =3D {
> @@ -9966,16 +10001,6 @@ static void disas_simd_3same_int(DisasContext *s,=
 uint32_t insn)
>                  genfn =3D fns[size][u];
>                  break;
>              }
> -            case 0x11: /* CMTST, CMEQ */
> -            {
> -                static NeonGenTwoOpFn * const fns[3][2] =3D {
> -                    { gen_helper_neon_tst_u8, gen_helper_neon_ceq_u8 },
> -                    { gen_helper_neon_tst_u16, gen_helper_neon_ceq_u16 },
> -                    { gen_helper_neon_tst_u32, gen_helper_neon_ceq_u32 },
> -                };
> -                genfn =3D fns[size][u];
> -                break;
> -            }
>              case 0x13: /* MUL, PMUL */
>                  if (u) {
>                      /* PMUL */


--
Alex Benn=C3=A9e
