Received: from eggs.gnu.org ([2001:4830:134:3::10]:56742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ej17E-0002p0-D4
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:08:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ej17B-0002cn-4z
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:08:44 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:38048)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ej17A-0002cJ-TL
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:08:41 -0500
Received: by mail-wr0-x242.google.com with SMTP id t94so1452549wrc.5
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 03:08:40 -0800 (PST)
References: <20180126045742.5487-1-richard.henderson@linaro.org>
	<20180126045742.5487-14-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180126045742.5487-14-richard.henderson@linaro.org>
Date: Tue, 06 Feb 2018 11:08:37 +0000
Message-ID: <87mv0mwf2i.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 13/20] target/arm: Use vector
 infrastructure for aa64 mov/not/neg
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
>  target/arm/translate-a64.c | 42 ++++++++++++++++++++++++++++++++++++----=
--
>  1 file changed, 36 insertions(+), 6 deletions(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 5a4e62ae0f..11310f1a7a 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -86,6 +86,7 @@ typedef void CryptoThreeOpIntFn(TCGv_ptr, TCGv_ptr, TCG=
v_i32);
>  typedef void CryptoThreeOpFn(TCGv_ptr, TCGv_ptr, TCGv_ptr);
>
>  /* Note that the gvec expanders operate on offsets + sizes.  */
> +typedef void GVecGen2Fn(unsigned, uint32_t, uint32_t, uint32_t, uint32_t=
);
>  typedef void GVecGen3Fn(unsigned, uint32_t, uint32_t,
>                          uint32_t, uint32_t, uint32_t);
>
> @@ -631,6 +632,14 @@ static TCGv_ptr get_fpstatus_ptr(void)
>      return statusptr;
>  }
>
> +/* Expand a 2-operand AdvSIMD vector operation using an expander functio=
n.  */
> +static void gen_gvec_fn2(DisasContext *s, bool is_q, int rd, int rn,
> +                         GVecGen2Fn *gvec_fn, int vece)
> +{
> +    gvec_fn(vece, vec_full_reg_offset(s, rd), vec_full_reg_offset(s, rn),
> +            is_q ? 16 : 8, vec_full_reg_size(s));
> +}
> +
>  /* Expand a 3-operand AdvSIMD vector operation using an expander functio=
n.  */
>  static void gen_gvec_fn3(DisasContext *s, bool is_q, int rd, int rn, int=
 rm,
>                           GVecGen3Fn *gvec_fn, int vece)
> @@ -4596,14 +4605,17 @@ static void handle_fp_1src_double(DisasContext *s=
, int opcode, int rd, int rn)
>      TCGv_i64 tcg_op;
>      TCGv_i64 tcg_res;
>
> +    switch (opcode) {
> +    case 0x0: /* FMOV */
> +        gen_gvec_fn2(s, false, rd, rn, tcg_gen_gvec_mov, 0);
> +        return;
> +    }
> +
>      fpst =3D get_fpstatus_ptr();
>      tcg_op =3D read_fp_dreg(s, rn);
>      tcg_res =3D tcg_temp_new_i64();
>
>      switch (opcode) {
> -    case 0x0: /* FMOV */
> -        tcg_gen_mov_i64(tcg_res, tcg_op);
> -        break;
>      case 0x1: /* FABS */
>          gen_helper_vfp_absd(tcg_res, tcg_op);
>          break;
> @@ -9185,7 +9197,11 @@ static void disas_simd_3same_logic(DisasContext *s=
, uint32_t insn)
>          gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_andc, 0);
>          return;
>      case 2: /* ORR */
> -        gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_or, 0);
> +        if (rn =3D=3D rm) { /* MOV */
> +            gen_gvec_fn2(s, is_q, rd, rn, tcg_gen_gvec_mov, 0);
> +        } else {
> +            gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_or, 0);
> +        }
>          return;
>      case 3: /* ORN */
>          gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_orc, 0);
> @@ -10059,8 +10075,7 @@ static void disas_simd_two_reg_misc(DisasContext =
*s, uint32_t insn)
>          return;
>      case 0x5: /* CNT, NOT, RBIT */
>          if (u && size =3D=3D 0) {
> -            /* NOT: adjust size so we can use the 64-bits-at-a-time loop=
. */
> -            size =3D 3;
> +            /* NOT */
>              break;
>          } else if (u && size =3D=3D 1) {
>              /* RBIT */
> @@ -10312,6 +10327,21 @@ static void disas_simd_two_reg_misc(DisasContext=
 *s, uint32_t insn)
>          tcg_rmode =3D NULL;
>      }
>
> +    switch (opcode) {
> +    case 0x5:
> +        if (u && size =3D=3D 0) { /* NOT */
> +            gen_gvec_fn2(s, is_q, rd, rn, tcg_gen_gvec_not, 0);
> +            return;
> +        }
> +        break;
> +    case 0xb:
> +        if (u) { /* NEG */
> +            gen_gvec_fn2(s, is_q, rd, rn, tcg_gen_gvec_neg, size);
> +            return;
> +        }
> +        break;
> +    }
> +
>      if (size =3D=3D 3) {
>          /* All 64-bit element operations can be shared with scalar 2misc=
 */
>          int pass;


--
Alex Benn=C3=A9e
