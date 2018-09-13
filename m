Received: from eggs.gnu.org ([2001:4830:134:3::10]:46904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g0SZL-0001Yd-Oa
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 10:26:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g0SZH-0001Ht-IB
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 10:26:07 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:46238)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g0SZH-0001HY-3v
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 10:26:03 -0400
Received: by mail-wr1-x42f.google.com with SMTP id a108-v6so5890624wrc.13
	for <qemu-devel@nongnu.org>; Thu, 13 Sep 2018 07:26:03 -0700 (PDT)
References: <20180911202823.21657-1-cota@braap.org>
	<20180911202823.21657-5-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180911202823.21657-5-cota@braap.org>
Date: Thu, 13 Sep 2018 15:26:00 +0100
Message-ID: <87a7olbhjb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 04/13] target/i386: move cpu_T1 to
 DisasContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>


Emilio G. Cota <cota@braap.org> writes:

> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/i386/translate.c | 341 ++++++++++++++++++++--------------------
>  1 file changed, 170 insertions(+), 171 deletions(-)
>
> diff --git a/target/i386/translate.c b/target/i386/translate.c
> index 73fd7e5b9a..bd27e65344 100644
> --- a/target/i386/translate.c
> +++ b/target/i386/translate.c
> @@ -78,8 +78,6 @@ static TCGv cpu_regs[CPU_NB_REGS];
>  static TCGv cpu_seg_base[6];
>  static TCGv_i64 cpu_bndl[4];
>  static TCGv_i64 cpu_bndu[4];
> -/* local temps */
> -static TCGv cpu_T1;
>  /* local register indexes (only used inside old micro ops) */
>  static TCGv cpu_tmp0, cpu_tmp4;
>  static TCGv_ptr cpu_ptr0, cpu_ptr1;
> @@ -139,6 +137,7 @@ typedef struct DisasContext {
>      TCGv cc_srcT;
>      TCGv A0;
>      TCGv T0;
> +    TCGv T1;
>
>      sigjmp_buf jmpbuf;
>  } DisasContext;
> @@ -656,20 +655,20 @@ static void gen_op_update1_cc(DisasContext *s)
>
>  static void gen_op_update2_cc(DisasContext *s)
>  {
> -    tcg_gen_mov_tl(cpu_cc_src, cpu_T1);
> +    tcg_gen_mov_tl(cpu_cc_src, s->T1);
>      tcg_gen_mov_tl(cpu_cc_dst, s->T0);
>  }
>
>  static void gen_op_update3_cc(DisasContext *s, TCGv reg)
>  {
>      tcg_gen_mov_tl(cpu_cc_src2, reg);
> -    tcg_gen_mov_tl(cpu_cc_src, cpu_T1);
> +    tcg_gen_mov_tl(cpu_cc_src, s->T1);
>      tcg_gen_mov_tl(cpu_cc_dst, s->T0);
>  }
>
>  static inline void gen_op_testl_T0_T1_cc(DisasContext *s)
>  {
> -    tcg_gen_and_tl(cpu_cc_dst, s->T0, cpu_T1);
> +    tcg_gen_and_tl(cpu_cc_dst, s->T0, s->T1);
>  }
>
>  static void gen_op_update_neg_cc(DisasContext *s)
> @@ -1090,7 +1089,7 @@ static inline void gen_lods(DisasContext *s, TCGMem=
Op ot)
>  static inline void gen_scas(DisasContext *s, TCGMemOp ot)
>  {
>      gen_string_movl_A0_EDI(s);
> -    gen_op_ld_v(s, ot, cpu_T1, s->A0);
> +    gen_op_ld_v(s, ot, s->T1, s->A0);
>      gen_op(s, OP_CMPL, ot, R_EAX);
>      gen_op_movl_T0_Dshift(s, ot);
>      gen_op_add_reg_T0(s, s->aflag, R_EDI);
> @@ -1099,7 +1098,7 @@ static inline void gen_scas(DisasContext *s, TCGMem=
Op ot)
>  static inline void gen_cmps(DisasContext *s, TCGMemOp ot)
>  {
>      gen_string_movl_A0_EDI(s);
> -    gen_op_ld_v(s, ot, cpu_T1, s->A0);
> +    gen_op_ld_v(s, ot, s->T1, s->A0);
>      gen_string_movl_A0_ESI(s);
>      gen_op(s, OP_CMPL, ot, OR_TMP0);
>      gen_op_movl_T0_Dshift(s, ot);
> @@ -1274,11 +1273,11 @@ static void gen_op(DisasContext *s1, int op, TCGM=
emOp ot, int d)
>      case OP_ADCL:
>          gen_compute_eflags_c(s1, cpu_tmp4);
>          if (s1->prefix & PREFIX_LOCK) {
> -            tcg_gen_add_tl(s1->T0, cpu_tmp4, cpu_T1);
> +            tcg_gen_add_tl(s1->T0, cpu_tmp4, s1->T1);
>              tcg_gen_atomic_add_fetch_tl(s1->T0, s1->A0, s1->T0,
>                                          s1->mem_index, ot | MO_LE);
>          } else {
> -            tcg_gen_add_tl(s1->T0, s1->T0, cpu_T1);
> +            tcg_gen_add_tl(s1->T0, s1->T0, s1->T1);
>              tcg_gen_add_tl(s1->T0, s1->T0, cpu_tmp4);
>              gen_op_st_rm_T0_A0(s1, ot, d);
>          }
> @@ -1288,12 +1287,12 @@ static void gen_op(DisasContext *s1, int op, TCGM=
emOp ot, int d)
>      case OP_SBBL:
>          gen_compute_eflags_c(s1, cpu_tmp4);
>          if (s1->prefix & PREFIX_LOCK) {
> -            tcg_gen_add_tl(s1->T0, cpu_T1, cpu_tmp4);
> +            tcg_gen_add_tl(s1->T0, s1->T1, cpu_tmp4);
>              tcg_gen_neg_tl(s1->T0, s1->T0);
>              tcg_gen_atomic_add_fetch_tl(s1->T0, s1->A0, s1->T0,
>                                          s1->mem_index, ot | MO_LE);
>          } else {
> -            tcg_gen_sub_tl(s1->T0, s1->T0, cpu_T1);
> +            tcg_gen_sub_tl(s1->T0, s1->T0, s1->T1);
>              tcg_gen_sub_tl(s1->T0, s1->T0, cpu_tmp4);
>              gen_op_st_rm_T0_A0(s1, ot, d);
>          }
> @@ -1302,10 +1301,10 @@ static void gen_op(DisasContext *s1, int op, TCGM=
emOp ot, int d)
>          break;
>      case OP_ADDL:
>          if (s1->prefix & PREFIX_LOCK) {
> -            tcg_gen_atomic_add_fetch_tl(s1->T0, s1->A0, cpu_T1,
> +            tcg_gen_atomic_add_fetch_tl(s1->T0, s1->A0, s1->T1,
>                                          s1->mem_index, ot | MO_LE);
>          } else {
> -            tcg_gen_add_tl(s1->T0, s1->T0, cpu_T1);
> +            tcg_gen_add_tl(s1->T0, s1->T0, s1->T1);
>              gen_op_st_rm_T0_A0(s1, ot, d);
>          }
>          gen_op_update2_cc(s1);
> @@ -1313,13 +1312,13 @@ static void gen_op(DisasContext *s1, int op, TCGM=
emOp ot, int d)
>          break;
>      case OP_SUBL:
>          if (s1->prefix & PREFIX_LOCK) {
> -            tcg_gen_neg_tl(s1->T0, cpu_T1);
> +            tcg_gen_neg_tl(s1->T0, s1->T1);
>              tcg_gen_atomic_fetch_add_tl(s1->cc_srcT, s1->A0, s1->T0,
>                                          s1->mem_index, ot | MO_LE);
> -            tcg_gen_sub_tl(s1->T0, s1->cc_srcT, cpu_T1);
> +            tcg_gen_sub_tl(s1->T0, s1->cc_srcT, s1->T1);
>          } else {
>              tcg_gen_mov_tl(s1->cc_srcT, s1->T0);
> -            tcg_gen_sub_tl(s1->T0, s1->T0, cpu_T1);
> +            tcg_gen_sub_tl(s1->T0, s1->T0, s1->T1);
>              gen_op_st_rm_T0_A0(s1, ot, d);
>          }
>          gen_op_update2_cc(s1);
> @@ -1328,10 +1327,10 @@ static void gen_op(DisasContext *s1, int op, TCGM=
emOp ot, int d)
>      default:
>      case OP_ANDL:
>          if (s1->prefix & PREFIX_LOCK) {
> -            tcg_gen_atomic_and_fetch_tl(s1->T0, s1->A0, cpu_T1,
> +            tcg_gen_atomic_and_fetch_tl(s1->T0, s1->A0, s1->T1,
>                                          s1->mem_index, ot | MO_LE);
>          } else {
> -            tcg_gen_and_tl(s1->T0, s1->T0, cpu_T1);
> +            tcg_gen_and_tl(s1->T0, s1->T0, s1->T1);
>              gen_op_st_rm_T0_A0(s1, ot, d);
>          }
>          gen_op_update1_cc(s1);
> @@ -1339,10 +1338,10 @@ static void gen_op(DisasContext *s1, int op, TCGM=
emOp ot, int d)
>          break;
>      case OP_ORL:
>          if (s1->prefix & PREFIX_LOCK) {
> -            tcg_gen_atomic_or_fetch_tl(s1->T0, s1->A0, cpu_T1,
> +            tcg_gen_atomic_or_fetch_tl(s1->T0, s1->A0, s1->T1,
>                                         s1->mem_index, ot | MO_LE);
>          } else {
> -            tcg_gen_or_tl(s1->T0, s1->T0, cpu_T1);
> +            tcg_gen_or_tl(s1->T0, s1->T0, s1->T1);
>              gen_op_st_rm_T0_A0(s1, ot, d);
>          }
>          gen_op_update1_cc(s1);
> @@ -1350,19 +1349,19 @@ static void gen_op(DisasContext *s1, int op, TCGM=
emOp ot, int d)
>          break;
>      case OP_XORL:
>          if (s1->prefix & PREFIX_LOCK) {
> -            tcg_gen_atomic_xor_fetch_tl(s1->T0, s1->A0, cpu_T1,
> +            tcg_gen_atomic_xor_fetch_tl(s1->T0, s1->A0, s1->T1,
>                                          s1->mem_index, ot | MO_LE);
>          } else {
> -            tcg_gen_xor_tl(s1->T0, s1->T0, cpu_T1);
> +            tcg_gen_xor_tl(s1->T0, s1->T0, s1->T1);
>              gen_op_st_rm_T0_A0(s1, ot, d);
>          }
>          gen_op_update1_cc(s1);
>          set_cc_op(s1, CC_OP_LOGICB + ot);
>          break;
>      case OP_CMPL:
> -        tcg_gen_mov_tl(cpu_cc_src, cpu_T1);
> +        tcg_gen_mov_tl(cpu_cc_src, s1->T1);
>          tcg_gen_mov_tl(s1->cc_srcT, s1->T0);
> -        tcg_gen_sub_tl(cpu_cc_dst, s1->T0, cpu_T1);
> +        tcg_gen_sub_tl(cpu_cc_dst, s1->T0, s1->T1);
>          set_cc_op(s1, CC_OP_SUBB + ot);
>          break;
>      }
> @@ -1447,28 +1446,28 @@ static void gen_shift_rm_T1(DisasContext *s, TCGM=
emOp ot, int op1,
>          gen_op_mov_v_reg(ot, s->T0, op1);
>      }
>
> -    tcg_gen_andi_tl(cpu_T1, cpu_T1, mask);
> -    tcg_gen_subi_tl(cpu_tmp0, cpu_T1, 1);
> +    tcg_gen_andi_tl(s->T1, s->T1, mask);
> +    tcg_gen_subi_tl(cpu_tmp0, s->T1, 1);
>
>      if (is_right) {
>          if (is_arith) {
>              gen_exts(ot, s->T0);
>              tcg_gen_sar_tl(cpu_tmp0, s->T0, cpu_tmp0);
> -            tcg_gen_sar_tl(s->T0, s->T0, cpu_T1);
> +            tcg_gen_sar_tl(s->T0, s->T0, s->T1);
>          } else {
>              gen_extu(ot, s->T0);
>              tcg_gen_shr_tl(cpu_tmp0, s->T0, cpu_tmp0);
> -            tcg_gen_shr_tl(s->T0, s->T0, cpu_T1);
> +            tcg_gen_shr_tl(s->T0, s->T0, s->T1);
>          }
>      } else {
>          tcg_gen_shl_tl(cpu_tmp0, s->T0, cpu_tmp0);
> -        tcg_gen_shl_tl(s->T0, s->T0, cpu_T1);
> +        tcg_gen_shl_tl(s->T0, s->T0, s->T1);
>      }
>
>      /* store */
>      gen_op_st_rm_T0_A0(s, ot, op1);
>
> -    gen_shift_flags(s, ot, s->T0, cpu_tmp0, cpu_T1, is_right);
> +    gen_shift_flags(s, ot, s->T0, cpu_tmp0, s->T1, is_right);
>  }
>
>  static void gen_shift_rm_im(DisasContext *s, TCGMemOp ot, int op1, int o=
p2,
> @@ -1523,7 +1522,7 @@ static void gen_rot_rm_T1(DisasContext *s, TCGMemOp=
 ot, int op1, int is_right)
>          gen_op_mov_v_reg(ot, s->T0, op1);
>      }
>
> -    tcg_gen_andi_tl(cpu_T1, cpu_T1, mask);
> +    tcg_gen_andi_tl(s->T1, s->T1, mask);
>
>      switch (ot) {
>      case MO_8:
> @@ -1539,7 +1538,7 @@ static void gen_rot_rm_T1(DisasContext *s, TCGMemOp=
 ot, int op1, int is_right)
>  #ifdef TARGET_X86_64
>      case MO_32:
>          tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
> -        tcg_gen_trunc_tl_i32(cpu_tmp3_i32, cpu_T1);
> +        tcg_gen_trunc_tl_i32(cpu_tmp3_i32, s->T1);
>          if (is_right) {
>              tcg_gen_rotr_i32(cpu_tmp2_i32, cpu_tmp2_i32, cpu_tmp3_i32);
>          } else {
> @@ -1550,9 +1549,9 @@ static void gen_rot_rm_T1(DisasContext *s, TCGMemOp=
 ot, int op1, int is_right)
>  #endif
>      default:
>          if (is_right) {
> -            tcg_gen_rotr_tl(s->T0, s->T0, cpu_T1);
> +            tcg_gen_rotr_tl(s->T0, s->T0, s->T1);
>          } else {
> -            tcg_gen_rotl_tl(s->T0, s->T0, cpu_T1);
> +            tcg_gen_rotl_tl(s->T0, s->T0, s->T1);
>          }
>          break;
>      }
> @@ -1584,7 +1583,7 @@ static void gen_rot_rm_T1(DisasContext *s, TCGMemOp=
 ot, int op1, int is_right)
>         exactly as we computed above.  */
>      t0 =3D tcg_const_i32(0);
>      t1 =3D tcg_temp_new_i32();
> -    tcg_gen_trunc_tl_i32(t1, cpu_T1);
> +    tcg_gen_trunc_tl_i32(t1, s->T1);
>      tcg_gen_movi_i32(cpu_tmp2_i32, CC_OP_ADCOX);
>      tcg_gen_movi_i32(cpu_tmp3_i32, CC_OP_EFLAGS);
>      tcg_gen_movcond_i32(TCG_COND_NE, cpu_cc_op, t1, t0,
> @@ -1689,17 +1688,17 @@ static void gen_rotc_rm_T1(DisasContext *s, TCGMe=
mOp ot, int op1,
>      if (is_right) {
>          switch (ot) {
>          case MO_8:
> -            gen_helper_rcrb(s->T0, cpu_env, s->T0, cpu_T1);
> +            gen_helper_rcrb(s->T0, cpu_env, s->T0, s->T1);
>              break;
>          case MO_16:
> -            gen_helper_rcrw(s->T0, cpu_env, s->T0, cpu_T1);
> +            gen_helper_rcrw(s->T0, cpu_env, s->T0, s->T1);
>              break;
>          case MO_32:
> -            gen_helper_rcrl(s->T0, cpu_env, s->T0, cpu_T1);
> +            gen_helper_rcrl(s->T0, cpu_env, s->T0, s->T1);
>              break;
>  #ifdef TARGET_X86_64
>          case MO_64:
> -            gen_helper_rcrq(s->T0, cpu_env, s->T0, cpu_T1);
> +            gen_helper_rcrq(s->T0, cpu_env, s->T0, s->T1);
>              break;
>  #endif
>          default:
> @@ -1708,17 +1707,17 @@ static void gen_rotc_rm_T1(DisasContext *s, TCGMe=
mOp ot, int op1,
>      } else {
>          switch (ot) {
>          case MO_8:
> -            gen_helper_rclb(s->T0, cpu_env, s->T0, cpu_T1);
> +            gen_helper_rclb(s->T0, cpu_env, s->T0, s->T1);
>              break;
>          case MO_16:
> -            gen_helper_rclw(s->T0, cpu_env, s->T0, cpu_T1);
> +            gen_helper_rclw(s->T0, cpu_env, s->T0, s->T1);
>              break;
>          case MO_32:
> -            gen_helper_rcll(s->T0, cpu_env, s->T0, cpu_T1);
> +            gen_helper_rcll(s->T0, cpu_env, s->T0, s->T1);
>              break;
>  #ifdef TARGET_X86_64
>          case MO_64:
> -            gen_helper_rclq(s->T0, cpu_env, s->T0, cpu_T1);
> +            gen_helper_rclq(s->T0, cpu_env, s->T0, s->T1);
>              break;
>  #endif
>          default:
> @@ -1752,11 +1751,11 @@ static void gen_shiftd_rm_T1(DisasContext *s, TCG=
MemOp ot, int op1,
>             This means "shrdw C, B, A" shifts A:B:A >> C.  Build the B:A
>             portion by constructing it as a 32-bit value.  */
>          if (is_right) {
> -            tcg_gen_deposit_tl(cpu_tmp0, s->T0, cpu_T1, 16, 16);
> -            tcg_gen_mov_tl(cpu_T1, s->T0);
> +            tcg_gen_deposit_tl(cpu_tmp0, s->T0, s->T1, 16, 16);
> +            tcg_gen_mov_tl(s->T1, s->T0);
>              tcg_gen_mov_tl(s->T0, cpu_tmp0);
>          } else {
> -            tcg_gen_deposit_tl(cpu_T1, s->T0, cpu_T1, 16, 16);
> +            tcg_gen_deposit_tl(s->T1, s->T0, s->T1, 16, 16);
>          }
>          /* FALLTHRU */
>  #ifdef TARGET_X86_64
> @@ -1764,11 +1763,11 @@ static void gen_shiftd_rm_T1(DisasContext *s, TCG=
MemOp ot, int op1,
>          /* Concatenate the two 32-bit values and use a 64-bit shift.  */
>          tcg_gen_subi_tl(cpu_tmp0, count, 1);
>          if (is_right) {
> -            tcg_gen_concat_tl_i64(s->T0, s->T0, cpu_T1);
> +            tcg_gen_concat_tl_i64(s->T0, s->T0, s->T1);
>              tcg_gen_shr_i64(cpu_tmp0, s->T0, cpu_tmp0);
>              tcg_gen_shr_i64(s->T0, s->T0, count);
>          } else {
> -            tcg_gen_concat_tl_i64(s->T0, cpu_T1, s->T0);
> +            tcg_gen_concat_tl_i64(s->T0, s->T1, s->T0);
>              tcg_gen_shl_i64(cpu_tmp0, s->T0, cpu_tmp0);
>              tcg_gen_shl_i64(s->T0, s->T0, count);
>              tcg_gen_shri_i64(cpu_tmp0, cpu_tmp0, 32);
> @@ -1783,24 +1782,24 @@ static void gen_shiftd_rm_T1(DisasContext *s, TCG=
MemOp ot, int op1,
>
>              tcg_gen_subfi_tl(cpu_tmp4, mask + 1, count);
>              tcg_gen_shr_tl(s->T0, s->T0, count);
> -            tcg_gen_shl_tl(cpu_T1, cpu_T1, cpu_tmp4);
> +            tcg_gen_shl_tl(s->T1, s->T1, cpu_tmp4);
>          } else {
>              tcg_gen_shl_tl(cpu_tmp0, s->T0, cpu_tmp0);
>              if (ot =3D=3D MO_16) {
>                  /* Only needed if count > 16, for Intel behaviour.  */
>                  tcg_gen_subfi_tl(cpu_tmp4, 33, count);
> -                tcg_gen_shr_tl(cpu_tmp4, cpu_T1, cpu_tmp4);
> +                tcg_gen_shr_tl(cpu_tmp4, s->T1, cpu_tmp4);
>                  tcg_gen_or_tl(cpu_tmp0, cpu_tmp0, cpu_tmp4);
>              }
>
>              tcg_gen_subfi_tl(cpu_tmp4, mask + 1, count);
>              tcg_gen_shl_tl(s->T0, s->T0, count);
> -            tcg_gen_shr_tl(cpu_T1, cpu_T1, cpu_tmp4);
> +            tcg_gen_shr_tl(s->T1, s->T1, cpu_tmp4);
>          }
>          tcg_gen_movi_tl(cpu_tmp4, 0);
> -        tcg_gen_movcond_tl(TCG_COND_EQ, cpu_T1, count, cpu_tmp4,
> -                           cpu_tmp4, cpu_T1);
> -        tcg_gen_or_tl(s->T0, s->T0, cpu_T1);
> +        tcg_gen_movcond_tl(TCG_COND_EQ, s->T1, count, cpu_tmp4,
> +                           cpu_tmp4, s->T1);
> +        tcg_gen_or_tl(s->T0, s->T0, s->T1);
>          break;
>      }
>
> @@ -1814,7 +1813,7 @@ static void gen_shiftd_rm_T1(DisasContext *s, TCGMe=
mOp ot, int op1,
>  static void gen_shift(DisasContext *s1, int op, TCGMemOp ot, int d, int =
s)
>  {
>      if (s !=3D OR_TMP1)
> -        gen_op_mov_v_reg(ot, cpu_T1, s);
> +        gen_op_mov_v_reg(ot, s1->T1, s);
>      switch(op) {
>      case OP_ROL:
>          gen_rot_rm_T1(s1, ot, d, 0);
> @@ -1862,7 +1861,7 @@ static void gen_shifti(DisasContext *s1, int op, TC=
GMemOp ot, int d, int c)
>          break;
>      default:
>          /* currently not optimized */
> -        tcg_gen_movi_tl(cpu_T1, c);
> +        tcg_gen_movi_tl(s1->T1, c);
>          gen_shift(s1, op, ot, d, OR_TMP1);
>          break;
>      }
> @@ -2242,7 +2241,7 @@ static void gen_cmovcc1(CPUX86State *env, DisasCont=
ext *s, TCGMemOp ot, int b,
>
>      gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
>
> -    cc =3D gen_prepare_cc(s, b, cpu_T1);
> +    cc =3D gen_prepare_cc(s, b, s->T1);
>      if (cc.mask !=3D -1) {
>          TCGv t0 =3D tcg_temp_new();
>          tcg_gen_andi_tl(t0, cc.reg, cc.mask);
> @@ -2416,8 +2415,8 @@ static void gen_enter(DisasContext *s, int esp_adde=
nd, int level)
>      int size =3D 1 << d_ot;
>
>      /* Push BP; compute FrameTemp into T1.  */
> -    tcg_gen_subi_tl(cpu_T1, cpu_regs[R_ESP], size);
> -    gen_lea_v_seg(s, a_ot, cpu_T1, R_SS, -1);
> +    tcg_gen_subi_tl(s->T1, cpu_regs[R_ESP], size);
> +    gen_lea_v_seg(s, a_ot, s->T1, R_SS, -1);
>      gen_op_st_v(s, d_ot, cpu_regs[R_EBP], s->A0);
>
>      level &=3D 31;
> @@ -2430,23 +2429,23 @@ static void gen_enter(DisasContext *s, int esp_ad=
dend, int level)
>              gen_lea_v_seg(s, a_ot, s->A0, R_SS, -1);
>              gen_op_ld_v(s, d_ot, cpu_tmp0, s->A0);
>
> -            tcg_gen_subi_tl(s->A0, cpu_T1, size * i);
> +            tcg_gen_subi_tl(s->A0, s->T1, size * i);
>              gen_lea_v_seg(s, a_ot, s->A0, R_SS, -1);
>              gen_op_st_v(s, d_ot, cpu_tmp0, s->A0);
>          }
>
>          /* Push the current FrameTemp as the last level.  */
> -        tcg_gen_subi_tl(s->A0, cpu_T1, size * level);
> +        tcg_gen_subi_tl(s->A0, s->T1, size * level);
>          gen_lea_v_seg(s, a_ot, s->A0, R_SS, -1);
> -        gen_op_st_v(s, d_ot, cpu_T1, s->A0);
> +        gen_op_st_v(s, d_ot, s->T1, s->A0);
>      }
>
>      /* Copy the FrameTemp value to EBP.  */
> -    gen_op_mov_reg_v(a_ot, R_EBP, cpu_T1);
> +    gen_op_mov_reg_v(a_ot, R_EBP, s->T1);
>
>      /* Compute the final value of ESP.  */
> -    tcg_gen_subi_tl(cpu_T1, cpu_T1, esp_addend + size * level);
> -    gen_op_mov_reg_v(a_ot, R_ESP, cpu_T1);
> +    tcg_gen_subi_tl(s->T1, s->T1, esp_addend + size * level);
> +    gen_op_mov_reg_v(a_ot, R_ESP, s->T1);
>  }
>
>  static void gen_leave(DisasContext *s)
> @@ -2457,10 +2456,10 @@ static void gen_leave(DisasContext *s)
>      gen_lea_v_seg(s, a_ot, cpu_regs[R_EBP], R_SS, -1);
>      gen_op_ld_v(s, d_ot, s->T0, s->A0);
>
> -    tcg_gen_addi_tl(cpu_T1, cpu_regs[R_EBP], 1 << d_ot);
> +    tcg_gen_addi_tl(s->T1, cpu_regs[R_EBP], 1 << d_ot);
>
>      gen_op_mov_reg_v(d_ot, R_EBP, s->T0);
> -    gen_op_mov_reg_v(a_ot, R_ESP, cpu_T1);
> +    gen_op_mov_reg_v(a_ot, R_ESP, s->T1);
>  }
>
>  static void gen_exception(DisasContext *s, int trapno, target_ulong cur_=
eip)
> @@ -3854,10 +3853,10 @@ static void gen_sse(CPUX86State *env, DisasContex=
t *s, int b,
>                      tcg_gen_movcond_tl(TCG_COND_LEU, s->A0, s->A0, bound,
>                                         s->A0, bound);
>                      tcg_temp_free(bound);
> -                    tcg_gen_movi_tl(cpu_T1, 1);
> -                    tcg_gen_shl_tl(cpu_T1, cpu_T1, s->A0);
> -                    tcg_gen_subi_tl(cpu_T1, cpu_T1, 1);
> -                    tcg_gen_and_tl(s->T0, s->T0, cpu_T1);
> +                    tcg_gen_movi_tl(s->T1, 1);
> +                    tcg_gen_shl_tl(s->T1, s->T1, s->A0);
> +                    tcg_gen_subi_tl(s->T1, s->T1, 1);
> +                    tcg_gen_and_tl(s->T0, s->T0, s->T1);
>
>                      gen_op_mov_reg_v(ot, reg, s->T0);
>                      gen_op_update1_cc(s);
> @@ -3873,19 +3872,19 @@ static void gen_sse(CPUX86State *env, DisasContex=
t *s, int b,
>                  }
>                  ot =3D mo_64_32(s->dflag);
>                  gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
> -                tcg_gen_ext8u_tl(cpu_T1, cpu_regs[s->vex_v]);
> +                tcg_gen_ext8u_tl(s->T1, cpu_regs[s->vex_v]);
>                  {
>                      TCGv bound =3D tcg_const_tl(ot =3D=3D MO_64 ? 63 : 3=
1);
>                      /* Note that since we're using BMILG (in order to ge=
t O
>                         cleared) we need to store the inverse into C.  */
>                      tcg_gen_setcond_tl(TCG_COND_LT, cpu_cc_src,
> -                                       cpu_T1, bound);
> -                    tcg_gen_movcond_tl(TCG_COND_GT, cpu_T1, cpu_T1,
> -                                       bound, bound, cpu_T1);
> +                                       s->T1, bound);
> +                    tcg_gen_movcond_tl(TCG_COND_GT, s->T1, s->T1,
> +                                       bound, bound, s->T1);
>                      tcg_temp_free(bound);
>                  }
>                  tcg_gen_movi_tl(s->A0, -1);
> -                tcg_gen_shl_tl(s->A0, s->A0, cpu_T1);
> +                tcg_gen_shl_tl(s->A0, s->A0, s->T1);
>                  tcg_gen_andc_tl(s->T0, s->T0, s->A0);
>                  gen_op_mov_reg_v(ot, reg, s->T0);
>                  gen_op_update1_cc(s);
> @@ -3911,10 +3910,10 @@ static void gen_sse(CPUX86State *env, DisasContex=
t *s, int b,
>                      break;
>  #ifdef TARGET_X86_64
>                  case MO_64:
> -                    tcg_gen_mulu2_i64(s->T0, cpu_T1,
> +                    tcg_gen_mulu2_i64(s->T0, s->T1,
>                                        s->T0, cpu_regs[R_EDX]);
>                      tcg_gen_mov_i64(cpu_regs[s->vex_v], s->T0);
> -                    tcg_gen_mov_i64(cpu_regs[reg], cpu_T1);
> +                    tcg_gen_mov_i64(cpu_regs[reg], s->T1);
>                      break;
>  #endif
>                  }
> @@ -3931,11 +3930,11 @@ static void gen_sse(CPUX86State *env, DisasContex=
t *s, int b,
>                  /* Note that by zero-extending the mask operand, we
>                     automatically handle zero-extending the result.  */
>                  if (ot =3D=3D MO_64) {
> -                    tcg_gen_mov_tl(cpu_T1, cpu_regs[s->vex_v]);
> +                    tcg_gen_mov_tl(s->T1, cpu_regs[s->vex_v]);
>                  } else {
> -                    tcg_gen_ext32u_tl(cpu_T1, cpu_regs[s->vex_v]);
> +                    tcg_gen_ext32u_tl(s->T1, cpu_regs[s->vex_v]);
>                  }
> -                gen_helper_pdep(cpu_regs[reg], s->T0, cpu_T1);
> +                gen_helper_pdep(cpu_regs[reg], s->T0, s->T1);
>                  break;
>
>              case 0x2f5: /* pext Gy, By, Ey */
> @@ -3949,11 +3948,11 @@ static void gen_sse(CPUX86State *env, DisasContex=
t *s, int b,
>                  /* Note that by zero-extending the mask operand, we
>                     automatically handle zero-extending the result.  */
>                  if (ot =3D=3D MO_64) {
> -                    tcg_gen_mov_tl(cpu_T1, cpu_regs[s->vex_v]);
> +                    tcg_gen_mov_tl(s->T1, cpu_regs[s->vex_v]);
>                  } else {
> -                    tcg_gen_ext32u_tl(cpu_T1, cpu_regs[s->vex_v]);
> +                    tcg_gen_ext32u_tl(s->T1, cpu_regs[s->vex_v]);
>                  }
> -                gen_helper_pext(cpu_regs[reg], s->T0, cpu_T1);
> +                gen_helper_pext(cpu_regs[reg], s->T0, s->T1);
>                  break;
>
>              case 0x1f6: /* adcx Gy, Ey */
> @@ -4045,22 +4044,22 @@ static void gen_sse(CPUX86State *env, DisasContex=
t *s, int b,
>                  ot =3D mo_64_32(s->dflag);
>                  gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
>                  if (ot =3D=3D MO_64) {
> -                    tcg_gen_andi_tl(cpu_T1, cpu_regs[s->vex_v], 63);
> +                    tcg_gen_andi_tl(s->T1, cpu_regs[s->vex_v], 63);
>                  } else {
> -                    tcg_gen_andi_tl(cpu_T1, cpu_regs[s->vex_v], 31);
> +                    tcg_gen_andi_tl(s->T1, cpu_regs[s->vex_v], 31);
>                  }
>                  if (b =3D=3D 0x1f7) {
> -                    tcg_gen_shl_tl(s->T0, s->T0, cpu_T1);
> +                    tcg_gen_shl_tl(s->T0, s->T0, s->T1);
>                  } else if (b =3D=3D 0x2f7) {
>                      if (ot !=3D MO_64) {
>                          tcg_gen_ext32s_tl(s->T0, s->T0);
>                      }
> -                    tcg_gen_sar_tl(s->T0, s->T0, cpu_T1);
> +                    tcg_gen_sar_tl(s->T0, s->T0, s->T1);
>                  } else {
>                      if (ot !=3D MO_64) {
>                          tcg_gen_ext32u_tl(s->T0, s->T0);
>                      }
> -                    tcg_gen_shr_tl(s->T0, s->T0, cpu_T1);
> +                    tcg_gen_shr_tl(s->T0, s->T0, s->T1);
>                  }
>                  gen_op_mov_reg_v(ot, reg, s->T0);
>                  break;
> @@ -4080,16 +4079,16 @@ static void gen_sse(CPUX86State *env, DisasContex=
t *s, int b,
>                  tcg_gen_mov_tl(cpu_cc_src, s->T0);
>                  switch (reg & 7) {
>                  case 1: /* blsr By,Ey */
> -                    tcg_gen_subi_tl(cpu_T1, s->T0, 1);
> -                    tcg_gen_and_tl(s->T0, s->T0, cpu_T1);
> +                    tcg_gen_subi_tl(s->T1, s->T0, 1);
> +                    tcg_gen_and_tl(s->T0, s->T0, s->T1);
>                      break;
>                  case 2: /* blsmsk By,Ey */
> -                    tcg_gen_subi_tl(cpu_T1, s->T0, 1);
> -                    tcg_gen_xor_tl(s->T0, s->T0, cpu_T1);
> +                    tcg_gen_subi_tl(s->T1, s->T0, 1);
> +                    tcg_gen_xor_tl(s->T0, s->T0, s->T1);
>                      break;
>                  case 3: /* blsi By, Ey */
> -                    tcg_gen_neg_tl(cpu_T1, s->T0);
> -                    tcg_gen_and_tl(s->T0, s->T0, cpu_T1);
> +                    tcg_gen_neg_tl(s->T1, s->T0);
> +                    tcg_gen_and_tl(s->T0, s->T0, s->T1);
>                      break;
>                  default:
>                      goto unknown_op;
> @@ -4677,7 +4676,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>                  } else {
>                      opreg =3D rm;
>                  }
> -                gen_op_mov_v_reg(ot, cpu_T1, reg);
> +                gen_op_mov_v_reg(ot, s->T1, reg);
>                  gen_op(s, op, ot, opreg);
>                  break;
>              case 1: /* OP Gv, Ev */
> @@ -4687,17 +4686,17 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>                  rm =3D (modrm & 7) | REX_B(s);
>                  if (mod !=3D 3) {
>                      gen_lea_modrm(env, s, modrm);
> -                    gen_op_ld_v(s, ot, cpu_T1, s->A0);
> +                    gen_op_ld_v(s, ot, s->T1, s->A0);
>                  } else if (op =3D=3D OP_XORL && rm =3D=3D reg) {
>                      goto xor_zero;
>                  } else {
> -                    gen_op_mov_v_reg(ot, cpu_T1, rm);
> +                    gen_op_mov_v_reg(ot, s->T1, rm);
>                  }
>                  gen_op(s, op, ot, reg);
>                  break;
>              case 2: /* OP A, Iv */
>                  val =3D insn_get(env, s, ot);
> -                tcg_gen_movi_tl(cpu_T1, val);
> +                tcg_gen_movi_tl(s->T1, val);
>                  gen_op(s, op, ot, OR_EAX);
>                  break;
>              }
> @@ -4743,7 +4742,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>                  val =3D (int8_t)insn_get(env, s, MO_8);
>                  break;
>              }
> -            tcg_gen_movi_tl(cpu_T1, val);
> +            tcg_gen_movi_tl(s->T1, val);
>              gen_op(s, op, ot, opreg);
>          }
>          break;
> @@ -4783,7 +4782,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>          switch(op) {
>          case 0: /* test */
>              val =3D insn_get(env, s, ot);
> -            tcg_gen_movi_tl(cpu_T1, val);
> +            tcg_gen_movi_tl(s->T1, val);
>              gen_op_testl_T0_T1_cc(s);
>              set_cc_op(s, CC_OP_LOGICB + ot);
>              break;
> @@ -4847,22 +4846,22 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>          case 4: /* mul */
>              switch(ot) {
>              case MO_8:
> -                gen_op_mov_v_reg(MO_8, cpu_T1, R_EAX);
> +                gen_op_mov_v_reg(MO_8, s->T1, R_EAX);
>                  tcg_gen_ext8u_tl(s->T0, s->T0);
> -                tcg_gen_ext8u_tl(cpu_T1, cpu_T1);
> +                tcg_gen_ext8u_tl(s->T1, s->T1);
>                  /* XXX: use 32 bit mul which could be faster */
> -                tcg_gen_mul_tl(s->T0, s->T0, cpu_T1);
> +                tcg_gen_mul_tl(s->T0, s->T0, s->T1);
>                  gen_op_mov_reg_v(MO_16, R_EAX, s->T0);
>                  tcg_gen_mov_tl(cpu_cc_dst, s->T0);
>                  tcg_gen_andi_tl(cpu_cc_src, s->T0, 0xff00);
>                  set_cc_op(s, CC_OP_MULB);
>                  break;
>              case MO_16:
> -                gen_op_mov_v_reg(MO_16, cpu_T1, R_EAX);
> +                gen_op_mov_v_reg(MO_16, s->T1, R_EAX);
>                  tcg_gen_ext16u_tl(s->T0, s->T0);
> -                tcg_gen_ext16u_tl(cpu_T1, cpu_T1);
> +                tcg_gen_ext16u_tl(s->T1, s->T1);
>                  /* XXX: use 32 bit mul which could be faster */
> -                tcg_gen_mul_tl(s->T0, s->T0, cpu_T1);
> +                tcg_gen_mul_tl(s->T0, s->T0, s->T1);
>                  gen_op_mov_reg_v(MO_16, R_EAX, s->T0);
>                  tcg_gen_mov_tl(cpu_cc_dst, s->T0);
>                  tcg_gen_shri_tl(s->T0, s->T0, 16);
> @@ -4896,11 +4895,11 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>          case 5: /* imul */
>              switch(ot) {
>              case MO_8:
> -                gen_op_mov_v_reg(MO_8, cpu_T1, R_EAX);
> +                gen_op_mov_v_reg(MO_8, s->T1, R_EAX);
>                  tcg_gen_ext8s_tl(s->T0, s->T0);
> -                tcg_gen_ext8s_tl(cpu_T1, cpu_T1);
> +                tcg_gen_ext8s_tl(s->T1, s->T1);
>                  /* XXX: use 32 bit mul which could be faster */
> -                tcg_gen_mul_tl(s->T0, s->T0, cpu_T1);
> +                tcg_gen_mul_tl(s->T0, s->T0, s->T1);
>                  gen_op_mov_reg_v(MO_16, R_EAX, s->T0);
>                  tcg_gen_mov_tl(cpu_cc_dst, s->T0);
>                  tcg_gen_ext8s_tl(cpu_tmp0, s->T0);
> @@ -4908,11 +4907,11 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>                  set_cc_op(s, CC_OP_MULB);
>                  break;
>              case MO_16:
> -                gen_op_mov_v_reg(MO_16, cpu_T1, R_EAX);
> +                gen_op_mov_v_reg(MO_16, s->T1, R_EAX);
>                  tcg_gen_ext16s_tl(s->T0, s->T0);
> -                tcg_gen_ext16s_tl(cpu_T1, cpu_T1);
> +                tcg_gen_ext16s_tl(s->T1, s->T1);
>                  /* XXX: use 32 bit mul which could be faster */
> -                tcg_gen_mul_tl(s->T0, s->T0, cpu_T1);
> +                tcg_gen_mul_tl(s->T0, s->T0, s->T1);
>                  gen_op_mov_reg_v(MO_16, R_EAX, s->T0);
>                  tcg_gen_mov_tl(cpu_cc_dst, s->T0);
>                  tcg_gen_ext16s_tl(cpu_tmp0, s->T0);
> @@ -5041,25 +5040,25 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>                  tcg_gen_ext16u_tl(s->T0, s->T0);
>              }
>              next_eip =3D s->pc - s->cs_base;
> -            tcg_gen_movi_tl(cpu_T1, next_eip);
> -            gen_push_v(s, cpu_T1);
> +            tcg_gen_movi_tl(s->T1, next_eip);
> +            gen_push_v(s, s->T1);
>              gen_op_jmp_v(s->T0);
>              gen_bnd_jmp(s);
>              gen_jr(s, s->T0);
>              break;
>          case 3: /* lcall Ev */
> -            gen_op_ld_v(s, ot, cpu_T1, s->A0);
> +            gen_op_ld_v(s, ot, s->T1, s->A0);
>              gen_add_A0_im(s, 1 << ot);
>              gen_op_ld_v(s, MO_16, s->T0, s->A0);
>          do_lcall:
>              if (s->pe && !s->vm86) {
>                  tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
> -                gen_helper_lcall_protected(cpu_env, cpu_tmp2_i32, cpu_T1,
> +                gen_helper_lcall_protected(cpu_env, cpu_tmp2_i32, s->T1,
>                                             tcg_const_i32(dflag - 1),
>                                             tcg_const_tl(s->pc - s->cs_ba=
se));
>              } else {
>                  tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
> -                gen_helper_lcall_real(cpu_env, cpu_tmp2_i32, cpu_T1,
> +                gen_helper_lcall_real(cpu_env, cpu_tmp2_i32, s->T1,
>                                        tcg_const_i32(dflag - 1),
>                                        tcg_const_i32(s->pc - s->cs_base));
>              }
> @@ -5075,17 +5074,17 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>              gen_jr(s, s->T0);
>              break;
>          case 5: /* ljmp Ev */
> -            gen_op_ld_v(s, ot, cpu_T1, s->A0);
> +            gen_op_ld_v(s, ot, s->T1, s->A0);
>              gen_add_A0_im(s, 1 << ot);
>              gen_op_ld_v(s, MO_16, s->T0, s->A0);
>          do_ljmp:
>              if (s->pe && !s->vm86) {
>                  tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
> -                gen_helper_ljmp_protected(cpu_env, cpu_tmp2_i32, cpu_T1,
> +                gen_helper_ljmp_protected(cpu_env, cpu_tmp2_i32, s->T1,
>                                            tcg_const_tl(s->pc - s->cs_bas=
e));
>              } else {
>                  gen_op_movl_seg_T0_vm(s, R_CS);
> -                gen_op_jmp_v(cpu_T1);
> +                gen_op_jmp_v(s->T1);
>              }
>              tcg_gen_ld_tl(cpu_tmp4, cpu_env, offsetof(CPUX86State, eip));
>              gen_jr(s, cpu_tmp4);
> @@ -5106,7 +5105,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>          reg =3D ((modrm >> 3) & 7) | rex_r;
>
>          gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
> -        gen_op_mov_v_reg(ot, cpu_T1, reg);
> +        gen_op_mov_v_reg(ot, s->T1, reg);
>          gen_op_testl_T0_T1_cc(s);
>          set_cc_op(s, CC_OP_LOGICB + ot);
>          break;
> @@ -5117,7 +5116,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>          val =3D insn_get(env, s, ot);
>
>          gen_op_mov_v_reg(ot, s->T0, OR_EAX);
> -        tcg_gen_movi_tl(cpu_T1, val);
> +        tcg_gen_movi_tl(s->T1, val);
>          gen_op_testl_T0_T1_cc(s);
>          set_cc_op(s, CC_OP_LOGICB + ot);
>          break;
> @@ -5183,25 +5182,25 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>          gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
>          if (b =3D=3D 0x69) {
>              val =3D insn_get(env, s, ot);
> -            tcg_gen_movi_tl(cpu_T1, val);
> +            tcg_gen_movi_tl(s->T1, val);
>          } else if (b =3D=3D 0x6b) {
>              val =3D (int8_t)insn_get(env, s, MO_8);
> -            tcg_gen_movi_tl(cpu_T1, val);
> +            tcg_gen_movi_tl(s->T1, val);
>          } else {
> -            gen_op_mov_v_reg(ot, cpu_T1, reg);
> +            gen_op_mov_v_reg(ot, s->T1, reg);
>          }
>          switch (ot) {
>  #ifdef TARGET_X86_64
>          case MO_64:
> -            tcg_gen_muls2_i64(cpu_regs[reg], cpu_T1, s->T0, cpu_T1);
> +            tcg_gen_muls2_i64(cpu_regs[reg], s->T1, s->T0, s->T1);
>              tcg_gen_mov_tl(cpu_cc_dst, cpu_regs[reg]);
>              tcg_gen_sari_tl(cpu_cc_src, cpu_cc_dst, 63);
> -            tcg_gen_sub_tl(cpu_cc_src, cpu_cc_src, cpu_T1);
> +            tcg_gen_sub_tl(cpu_cc_src, cpu_cc_src, s->T1);
>              break;
>  #endif
>          case MO_32:
>              tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
> -            tcg_gen_trunc_tl_i32(cpu_tmp3_i32, cpu_T1);
> +            tcg_gen_trunc_tl_i32(cpu_tmp3_i32, s->T1);
>              tcg_gen_muls2_i32(cpu_tmp2_i32, cpu_tmp3_i32,
>                                cpu_tmp2_i32, cpu_tmp3_i32);
>              tcg_gen_extu_i32_tl(cpu_regs[reg], cpu_tmp2_i32);
> @@ -5212,9 +5211,9 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>              break;
>          default:
>              tcg_gen_ext16s_tl(s->T0, s->T0);
> -            tcg_gen_ext16s_tl(cpu_T1, cpu_T1);
> +            tcg_gen_ext16s_tl(s->T1, s->T1);
>              /* XXX: use 32 bit mul which could be faster */
> -            tcg_gen_mul_tl(s->T0, s->T0, cpu_T1);
> +            tcg_gen_mul_tl(s->T0, s->T0, s->T1);
>              tcg_gen_mov_tl(cpu_cc_dst, s->T0);
>              tcg_gen_ext16s_tl(cpu_tmp0, s->T0);
>              tcg_gen_sub_tl(cpu_cc_src, s->T0, cpu_tmp0);
> @@ -5232,22 +5231,22 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>          gen_op_mov_v_reg(ot, s->T0, reg);
>          if (mod =3D=3D 3) {
>              rm =3D (modrm & 7) | REX_B(s);
> -            gen_op_mov_v_reg(ot, cpu_T1, rm);
> -            tcg_gen_add_tl(s->T0, s->T0, cpu_T1);
> -            gen_op_mov_reg_v(ot, reg, cpu_T1);
> +            gen_op_mov_v_reg(ot, s->T1, rm);
> +            tcg_gen_add_tl(s->T0, s->T0, s->T1);
> +            gen_op_mov_reg_v(ot, reg, s->T1);
>              gen_op_mov_reg_v(ot, rm, s->T0);
>          } else {
>              gen_lea_modrm(env, s, modrm);
>              if (s->prefix & PREFIX_LOCK) {
> -                tcg_gen_atomic_fetch_add_tl(cpu_T1, s->A0, s->T0,
> +                tcg_gen_atomic_fetch_add_tl(s->T1, s->A0, s->T0,
>                                              s->mem_index, ot | MO_LE);
> -                tcg_gen_add_tl(s->T0, s->T0, cpu_T1);
> +                tcg_gen_add_tl(s->T0, s->T0, s->T1);
>              } else {
> -                gen_op_ld_v(s, ot, cpu_T1, s->A0);
> -                tcg_gen_add_tl(s->T0, s->T0, cpu_T1);
> +                gen_op_ld_v(s, ot, s->T1, s->A0);
> +                tcg_gen_add_tl(s->T0, s->T0, s->T1);
>                  gen_op_st_v(s, ot, s->T0, s->A0);
>              }
> -            gen_op_mov_reg_v(ot, reg, cpu_T1);
> +            gen_op_mov_reg_v(ot, reg, s->T1);
>          }
>          gen_op_update2_cc(s);
>          set_cc_op(s, CC_OP_ADDB + ot);
> @@ -5653,16 +5652,16 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>              rm =3D (modrm & 7) | REX_B(s);
>          do_xchg_reg:
>              gen_op_mov_v_reg(ot, s->T0, reg);
> -            gen_op_mov_v_reg(ot, cpu_T1, rm);
> +            gen_op_mov_v_reg(ot, s->T1, rm);
>              gen_op_mov_reg_v(ot, rm, s->T0);
> -            gen_op_mov_reg_v(ot, reg, cpu_T1);
> +            gen_op_mov_reg_v(ot, reg, s->T1);
>          } else {
>              gen_lea_modrm(env, s, modrm);
>              gen_op_mov_v_reg(ot, s->T0, reg);
>              /* for xchg, lock is implicit */
> -            tcg_gen_atomic_xchg_tl(cpu_T1, s->A0, s->T0,
> +            tcg_gen_atomic_xchg_tl(s->T1, s->A0, s->T0,
>                                     s->mem_index, ot | MO_LE);
> -            gen_op_mov_reg_v(ot, reg, cpu_T1);
> +            gen_op_mov_reg_v(ot, reg, s->T1);
>          }
>          break;
>      case 0xc4: /* les Gv */
> @@ -5689,13 +5688,13 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>          if (mod =3D=3D 3)
>              goto illegal_op;
>          gen_lea_modrm(env, s, modrm);
> -        gen_op_ld_v(s, ot, cpu_T1, s->A0);
> +        gen_op_ld_v(s, ot, s->T1, s->A0);
>          gen_add_A0_im(s, 1 << ot);
>          /* load the segment first to handle exceptions properly */
>          gen_op_ld_v(s, MO_16, s->T0, s->A0);
>          gen_movl_seg_T0(s, op);
>          /* then put the data */
> -        gen_op_mov_reg_v(ot, reg, cpu_T1);
> +        gen_op_mov_reg_v(ot, reg, s->T1);
>          if (s->base.is_jmp) {
>              gen_jmp_im(s->pc - s->cs_base);
>              gen_eob(s);
> @@ -5774,7 +5773,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>          } else {
>              opreg =3D rm;
>          }
> -        gen_op_mov_v_reg(ot, cpu_T1, reg);
> +        gen_op_mov_v_reg(ot, s->T1, reg);
>
>          if (shift) {
>              TCGv imm =3D tcg_const_tl(x86_ldub_code(env, s));
> @@ -6387,8 +6386,8 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>              gen_io_start();
>  	}
>          tcg_gen_movi_i32(cpu_tmp2_i32, val);
> -        gen_helper_in_func(ot, cpu_T1, cpu_tmp2_i32);
> -        gen_op_mov_reg_v(ot, R_EAX, cpu_T1);
> +        gen_helper_in_func(ot, s->T1, cpu_tmp2_i32);
> +        gen_op_mov_reg_v(ot, R_EAX, s->T1);
>          gen_bpt_io(s, cpu_tmp2_i32, ot);
>          if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
>              gen_io_end();
> @@ -6402,13 +6401,13 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>          tcg_gen_movi_tl(s->T0, val);
>          gen_check_io(s, ot, pc_start - s->cs_base,
>                       svm_is_rep(prefixes));
> -        gen_op_mov_v_reg(ot, cpu_T1, R_EAX);
> +        gen_op_mov_v_reg(ot, s->T1, R_EAX);
>
>          if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
>              gen_io_start();
>  	}
>          tcg_gen_movi_i32(cpu_tmp2_i32, val);
> -        tcg_gen_trunc_tl_i32(cpu_tmp3_i32, cpu_T1);
> +        tcg_gen_trunc_tl_i32(cpu_tmp3_i32, s->T1);
>          gen_helper_out_func(ot, cpu_tmp2_i32, cpu_tmp3_i32);
>          gen_bpt_io(s, cpu_tmp2_i32, ot);
>          if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
> @@ -6426,8 +6425,8 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>              gen_io_start();
>  	}
>          tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
> -        gen_helper_in_func(ot, cpu_T1, cpu_tmp2_i32);
> -        gen_op_mov_reg_v(ot, R_EAX, cpu_T1);
> +        gen_helper_in_func(ot, s->T1, cpu_tmp2_i32);
> +        gen_op_mov_reg_v(ot, R_EAX, s->T1);
>          gen_bpt_io(s, cpu_tmp2_i32, ot);
>          if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
>              gen_io_end();
> @@ -6440,13 +6439,13 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>          tcg_gen_ext16u_tl(s->T0, cpu_regs[R_EDX]);
>          gen_check_io(s, ot, pc_start - s->cs_base,
>                       svm_is_rep(prefixes));
> -        gen_op_mov_v_reg(ot, cpu_T1, R_EAX);
> +        gen_op_mov_v_reg(ot, s->T1, R_EAX);
>
>          if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
>              gen_io_start();
>  	}
>          tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
> -        tcg_gen_trunc_tl_i32(cpu_tmp3_i32, cpu_T1);
> +        tcg_gen_trunc_tl_i32(cpu_tmp3_i32, s->T1);
>          gen_helper_out_func(ot, cpu_tmp2_i32, cpu_tmp3_i32);
>          gen_bpt_io(s, cpu_tmp2_i32, ot);
>          if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
> @@ -6552,7 +6551,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>              selector =3D insn_get(env, s, MO_16);
>
>              tcg_gen_movi_tl(s->T0, selector);
> -            tcg_gen_movi_tl(cpu_T1, offset);
> +            tcg_gen_movi_tl(s->T1, offset);
>          }
>          goto do_lcall;
>      case 0xe9: /* jmp im */
> @@ -6581,7 +6580,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>              selector =3D insn_get(env, s, MO_16);
>
>              tcg_gen_movi_tl(s->T0, selector);
> -            tcg_gen_movi_tl(cpu_T1, offset);
> +            tcg_gen_movi_tl(s->T1, offset);
>          }
>          goto do_ljmp;
>      case 0xeb: /* jmp Jb */
> @@ -6753,7 +6752,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>          }
>          /* load shift */
>          val =3D x86_ldub_code(env, s);
> -        tcg_gen_movi_tl(cpu_T1, val);
> +        tcg_gen_movi_tl(s->T1, val);
>          if (op < 4)
>              goto unknown_op;
>          op -=3D 4;
> @@ -6775,12 +6774,12 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>          reg =3D ((modrm >> 3) & 7) | rex_r;
>          mod =3D (modrm >> 6) & 3;
>          rm =3D (modrm & 7) | REX_B(s);
> -        gen_op_mov_v_reg(MO_32, cpu_T1, reg);
> +        gen_op_mov_v_reg(MO_32, s->T1, reg);
>          if (mod !=3D 3) {
>              AddressParts a =3D gen_lea_modrm_0(env, s, modrm);
>              /* specific case: we need to add a displacement */
> -            gen_exts(ot, cpu_T1);
> -            tcg_gen_sari_tl(cpu_tmp0, cpu_T1, 3 + ot);
> +            gen_exts(ot, s->T1);
> +            tcg_gen_sari_tl(cpu_tmp0, s->T1, 3 + ot);
>              tcg_gen_shli_tl(cpu_tmp0, cpu_tmp0, ot);
>              tcg_gen_add_tl(s->A0, gen_lea_modrm_1(s, a), cpu_tmp0);
>              gen_lea_v_seg(s, s->aflag, s->A0, a.def_seg, s->override);
> @@ -6791,9 +6790,9 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>              gen_op_mov_v_reg(ot, s->T0, rm);
>          }
>      bt_op:
> -        tcg_gen_andi_tl(cpu_T1, cpu_T1, (1 << (3 + ot)) - 1);
> +        tcg_gen_andi_tl(s->T1, s->T1, (1 << (3 + ot)) - 1);
>          tcg_gen_movi_tl(cpu_tmp0, 1);
> -        tcg_gen_shl_tl(cpu_tmp0, cpu_tmp0, cpu_T1);
> +        tcg_gen_shl_tl(cpu_tmp0, cpu_tmp0, s->T1);
>          if (s->prefix & PREFIX_LOCK) {
>              switch (op) {
>              case 0: /* bt */
> @@ -6816,9 +6815,9 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>                                              s->mem_index, ot | MO_LE);
>                  break;
>              }
> -            tcg_gen_shr_tl(cpu_tmp4, s->T0, cpu_T1);
> +            tcg_gen_shr_tl(cpu_tmp4, s->T0, s->T1);
>          } else {
> -            tcg_gen_shr_tl(cpu_tmp4, s->T0, cpu_T1);
> +            tcg_gen_shr_tl(cpu_tmp4, s->T0, s->T1);
>              switch (op) {
>              case 0: /* bt */
>                  /* Data already loaded; nothing to do.  */
> @@ -6914,8 +6913,8 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>              if (b & 1) {
>                  /* For bsr, return the bit index of the first 1 bit,
>                     not the count of leading zeros.  */
> -                tcg_gen_xori_tl(cpu_T1, cpu_regs[reg], TARGET_LONG_BITS =
- 1);
> -                tcg_gen_clz_tl(s->T0, s->T0, cpu_T1);
> +                tcg_gen_xori_tl(s->T1, cpu_regs[reg], TARGET_LONG_BITS -=
 1);
> +                tcg_gen_clz_tl(s->T0, s->T0, s->T1);
>                  tcg_gen_xori_tl(s->T0, s->T0, TARGET_LONG_BITS - 1);
>              } else {
>                  tcg_gen_ctz_tl(s->T0, s->T0, cpu_regs[reg]);
> @@ -7512,14 +7511,14 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>              }
>              gen_svm_check_intercept(s, pc_start, SVM_EXIT_GDTR_WRITE);
>              gen_lea_modrm(env, s, modrm);
> -            gen_op_ld_v(s, MO_16, cpu_T1, s->A0);
> +            gen_op_ld_v(s, MO_16, s->T1, s->A0);
>              gen_add_A0_im(s, 2);
>              gen_op_ld_v(s, CODE64(s) + MO_32, s->T0, s->A0);
>              if (dflag =3D=3D MO_16) {
>                  tcg_gen_andi_tl(s->T0, s->T0, 0xffffff);
>              }
>              tcg_gen_st_tl(s->T0, cpu_env, offsetof(CPUX86State, gdt.base=
));
> -            tcg_gen_st32_tl(cpu_T1, cpu_env, offsetof(CPUX86State, gdt.l=
imit));
> +            tcg_gen_st32_tl(s->T1, cpu_env, offsetof(CPUX86State, gdt.li=
mit));
>              break;
>
>          CASE_MODRM_MEM_OP(3): /* lidt */
> @@ -7529,14 +7528,14 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>              }
>              gen_svm_check_intercept(s, pc_start, SVM_EXIT_IDTR_WRITE);
>              gen_lea_modrm(env, s, modrm);
> -            gen_op_ld_v(s, MO_16, cpu_T1, s->A0);
> +            gen_op_ld_v(s, MO_16, s->T1, s->A0);
>              gen_add_A0_im(s, 2);
>              gen_op_ld_v(s, CODE64(s) + MO_32, s->T0, s->A0);
>              if (dflag =3D=3D MO_16) {
>                  tcg_gen_andi_tl(s->T0, s->T0, 0xffffff);
>              }
>              tcg_gen_st_tl(s->T0, cpu_env, offsetof(CPUX86State, idt.base=
));
> -            tcg_gen_st32_tl(cpu_T1, cpu_env, offsetof(CPUX86State, idt.l=
imit));
> +            tcg_gen_st32_tl(s->T1, cpu_env, offsetof(CPUX86State, idt.li=
mit));
>              break;
>
>          CASE_MODRM_OP(4): /* smsw */
> @@ -8471,7 +8470,7 @@ static void i386_tr_init_disas_context(DisasContext=
Base *dcbase, CPUState *cpu)
>  #endif
>
>      dc->T0 =3D tcg_temp_new();
> -    cpu_T1 =3D tcg_temp_new();
> +    dc->T1 =3D tcg_temp_new();
>      dc->A0 =3D tcg_temp_new();
>
>      cpu_tmp0 =3D tcg_temp_new();


--
Alex Benn=C3=A9e
