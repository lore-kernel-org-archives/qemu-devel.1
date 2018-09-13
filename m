Received: from eggs.gnu.org ([2001:4830:134:3::10]:46828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g0SYw-0001IZ-Ob
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 10:25:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g0SYo-0000rt-Q3
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 10:25:42 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g0SYn-0000qF-Rs
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 10:25:34 -0400
Received: by mail-wr1-x441.google.com with SMTP id v16-v6so5888618wro.11
	for <qemu-devel@nongnu.org>; Thu, 13 Sep 2018 07:25:33 -0700 (PDT)
References: <20180911202823.21657-1-cota@braap.org>
	<20180911202823.21657-4-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180911202823.21657-4-cota@braap.org>
Date: Thu, 13 Sep 2018 15:25:30 +0100
Message-ID: <87bm91bhk5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 03/13] target/i386: move cpu_T0 to
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
>  target/i386/translate.c | 1174 ++++++++++++++++++++-------------------
>  1 file changed, 594 insertions(+), 580 deletions(-)
>
> diff --git a/target/i386/translate.c b/target/i386/translate.c
> index c6b1baab9d..73fd7e5b9a 100644
> --- a/target/i386/translate.c
> +++ b/target/i386/translate.c
> @@ -79,7 +79,7 @@ static TCGv cpu_seg_base[6];
>  static TCGv_i64 cpu_bndl[4];
>  static TCGv_i64 cpu_bndu[4];
>  /* local temps */
> -static TCGv cpu_T0, cpu_T1;
> +static TCGv cpu_T1;
>  /* local register indexes (only used inside old micro ops) */
>  static TCGv cpu_tmp0, cpu_tmp4;
>  static TCGv_ptr cpu_ptr0, cpu_ptr1;
> @@ -138,6 +138,7 @@ typedef struct DisasContext {
>      /* TCG local temps */
>      TCGv cc_srcT;
>      TCGv A0;
> +    TCGv T0;
>
>      sigjmp_buf jmpbuf;
>  } DisasContext;
> @@ -412,9 +413,9 @@ static inline void gen_op_add_reg_im(TCGMemOp size, i=
nt reg, int32_t val)
>      gen_op_mov_reg_v(size, reg, cpu_tmp0);
>  }
>
> -static inline void gen_op_add_reg_T0(TCGMemOp size, int reg)
> +static inline void gen_op_add_reg_T0(DisasContext *s, TCGMemOp size, int=
 reg)
>  {
> -    tcg_gen_add_tl(cpu_tmp0, cpu_regs[reg], cpu_T0);
> +    tcg_gen_add_tl(cpu_tmp0, cpu_regs[reg], s->T0);
>      gen_op_mov_reg_v(size, reg, cpu_tmp0);
>  }
>
> @@ -431,9 +432,9 @@ static inline void gen_op_st_v(DisasContext *s, int i=
dx, TCGv t0, TCGv a0)
>  static inline void gen_op_st_rm_T0_A0(DisasContext *s, int idx, int d)
>  {
>      if (d =3D=3D OR_TMP0) {
> -        gen_op_st_v(s, idx, cpu_T0, s->A0);
> +        gen_op_st_v(s, idx, s->T0, s->A0);
>      } else {
> -        gen_op_mov_reg_v(idx, d, cpu_T0);
> +        gen_op_mov_reg_v(idx, d, s->T0);
>      }
>  }
>
> @@ -509,10 +510,10 @@ static inline void gen_string_movl_A0_EDI(DisasCont=
ext *s)
>      gen_lea_v_seg(s, s->aflag, cpu_regs[R_EDI], R_ES, -1);
>  }
>
> -static inline void gen_op_movl_T0_Dshift(TCGMemOp ot)
> +static inline void gen_op_movl_T0_Dshift(DisasContext *s, TCGMemOp ot)
>  {
> -    tcg_gen_ld32s_tl(cpu_T0, cpu_env, offsetof(CPUX86State, df));
> -    tcg_gen_shli_tl(cpu_T0, cpu_T0, ot);
> +    tcg_gen_ld32s_tl(s->T0, cpu_env, offsetof(CPUX86State, df));
> +    tcg_gen_shli_tl(s->T0, s->T0, ot);
>  };
>
>  static TCGv gen_ext_tl(TCGv dst, TCGv src, TCGMemOp size, bool sign)
> @@ -610,7 +611,7 @@ static void gen_check_io(DisasContext *s, TCGMemOp ot=
, target_ulong cur_eip,
>      target_ulong next_eip;
>
>      if (s->pe && (s->cpl > s->iopl || s->vm86)) {
> -        tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_T0);
> +        tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
>          switch (ot) {
>          case MO_8:
>              gen_helper_check_iob(cpu_env, cpu_tmp2_i32);
> @@ -630,7 +631,7 @@ static void gen_check_io(DisasContext *s, TCGMemOp ot=
, target_ulong cur_eip,
>          gen_jmp_im(cur_eip);
>          svm_flags |=3D (1 << (4 + ot));
>          next_eip =3D s->pc - s->cs_base;
> -        tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_T0);
> +        tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
>          gen_helper_svm_check_io(cpu_env, cpu_tmp2_i32,
>                                  tcg_const_i32(svm_flags),
>                                  tcg_const_i32(next_eip - cur_eip));
> @@ -640,41 +641,41 @@ static void gen_check_io(DisasContext *s, TCGMemOp =
ot, target_ulong cur_eip,
>  static inline void gen_movs(DisasContext *s, TCGMemOp ot)
>  {
>      gen_string_movl_A0_ESI(s);
> -    gen_op_ld_v(s, ot, cpu_T0, s->A0);
> +    gen_op_ld_v(s, ot, s->T0, s->A0);
>      gen_string_movl_A0_EDI(s);
> -    gen_op_st_v(s, ot, cpu_T0, s->A0);
> -    gen_op_movl_T0_Dshift(ot);
> -    gen_op_add_reg_T0(s->aflag, R_ESI);
> -    gen_op_add_reg_T0(s->aflag, R_EDI);
> +    gen_op_st_v(s, ot, s->T0, s->A0);
> +    gen_op_movl_T0_Dshift(s, ot);
> +    gen_op_add_reg_T0(s, s->aflag, R_ESI);
> +    gen_op_add_reg_T0(s, s->aflag, R_EDI);
>  }
>
> -static void gen_op_update1_cc(void)
> +static void gen_op_update1_cc(DisasContext *s)
>  {
> -    tcg_gen_mov_tl(cpu_cc_dst, cpu_T0);
> +    tcg_gen_mov_tl(cpu_cc_dst, s->T0);
>  }
>
> -static void gen_op_update2_cc(void)
> +static void gen_op_update2_cc(DisasContext *s)
>  {
>      tcg_gen_mov_tl(cpu_cc_src, cpu_T1);
> -    tcg_gen_mov_tl(cpu_cc_dst, cpu_T0);
> +    tcg_gen_mov_tl(cpu_cc_dst, s->T0);
>  }
>
> -static void gen_op_update3_cc(TCGv reg)
> +static void gen_op_update3_cc(DisasContext *s, TCGv reg)
>  {
>      tcg_gen_mov_tl(cpu_cc_src2, reg);
>      tcg_gen_mov_tl(cpu_cc_src, cpu_T1);
> -    tcg_gen_mov_tl(cpu_cc_dst, cpu_T0);
> +    tcg_gen_mov_tl(cpu_cc_dst, s->T0);
>  }
>
> -static inline void gen_op_testl_T0_T1_cc(void)
> +static inline void gen_op_testl_T0_T1_cc(DisasContext *s)
>  {
> -    tcg_gen_and_tl(cpu_cc_dst, cpu_T0, cpu_T1);
> +    tcg_gen_and_tl(cpu_cc_dst, s->T0, cpu_T1);
>  }
>
>  static void gen_op_update_neg_cc(DisasContext *s)
>  {
> -    tcg_gen_mov_tl(cpu_cc_dst, cpu_T0);
> -    tcg_gen_neg_tl(cpu_cc_src, cpu_T0);
> +    tcg_gen_mov_tl(cpu_cc_dst, s->T0);
> +    tcg_gen_neg_tl(cpu_cc_src, s->T0);
>      tcg_gen_movi_tl(s->cc_srcT, 0);
>  }
>
> @@ -1022,11 +1023,11 @@ static inline void gen_compute_eflags_c(DisasCont=
ext *s, TCGv reg)
>     value 'b'. In the fast case, T0 is guaranted not to be used. */
>  static inline void gen_jcc1_noeob(DisasContext *s, int b, TCGLabel *l1)
>  {
> -    CCPrepare cc =3D gen_prepare_cc(s, b, cpu_T0);
> +    CCPrepare cc =3D gen_prepare_cc(s, b, s->T0);
>
>      if (cc.mask !=3D -1) {
> -        tcg_gen_andi_tl(cpu_T0, cc.reg, cc.mask);
> -        cc.reg =3D cpu_T0;
> +        tcg_gen_andi_tl(s->T0, cc.reg, cc.mask);
> +        cc.reg =3D s->T0;
>      }
>      if (cc.use_reg2) {
>          tcg_gen_brcond_tl(cc.cond, cc.reg, cc.reg2, l1);
> @@ -1040,12 +1041,12 @@ static inline void gen_jcc1_noeob(DisasContext *s=
, int b, TCGLabel *l1)
>     A translation block must end soon.  */
>  static inline void gen_jcc1(DisasContext *s, int b, TCGLabel *l1)
>  {
> -    CCPrepare cc =3D gen_prepare_cc(s, b, cpu_T0);
> +    CCPrepare cc =3D gen_prepare_cc(s, b, s->T0);
>
>      gen_update_cc_op(s);
>      if (cc.mask !=3D -1) {
> -        tcg_gen_andi_tl(cpu_T0, cc.reg, cc.mask);
> -        cc.reg =3D cpu_T0;
> +        tcg_gen_andi_tl(s->T0, cc.reg, cc.mask);
> +        cc.reg =3D s->T0;
>      }
>      set_cc_op(s, CC_OP_DYNAMIC);
>      if (cc.use_reg2) {
> @@ -1070,20 +1071,20 @@ static TCGLabel *gen_jz_ecx_string(DisasContext *=
s, target_ulong next_eip)
>
>  static inline void gen_stos(DisasContext *s, TCGMemOp ot)
>  {
> -    gen_op_mov_v_reg(MO_32, cpu_T0, R_EAX);
> +    gen_op_mov_v_reg(MO_32, s->T0, R_EAX);
>      gen_string_movl_A0_EDI(s);
> -    gen_op_st_v(s, ot, cpu_T0, s->A0);
> -    gen_op_movl_T0_Dshift(ot);
> -    gen_op_add_reg_T0(s->aflag, R_EDI);
> +    gen_op_st_v(s, ot, s->T0, s->A0);
> +    gen_op_movl_T0_Dshift(s, ot);
> +    gen_op_add_reg_T0(s, s->aflag, R_EDI);
>  }
>
>  static inline void gen_lods(DisasContext *s, TCGMemOp ot)
>  {
>      gen_string_movl_A0_ESI(s);
> -    gen_op_ld_v(s, ot, cpu_T0, s->A0);
> -    gen_op_mov_reg_v(ot, R_EAX, cpu_T0);
> -    gen_op_movl_T0_Dshift(ot);
> -    gen_op_add_reg_T0(s->aflag, R_ESI);
> +    gen_op_ld_v(s, ot, s->T0, s->A0);
> +    gen_op_mov_reg_v(ot, R_EAX, s->T0);
> +    gen_op_movl_T0_Dshift(s, ot);
> +    gen_op_add_reg_T0(s, s->aflag, R_ESI);
>  }
>
>  static inline void gen_scas(DisasContext *s, TCGMemOp ot)
> @@ -1091,8 +1092,8 @@ static inline void gen_scas(DisasContext *s, TCGMem=
Op ot)
>      gen_string_movl_A0_EDI(s);
>      gen_op_ld_v(s, ot, cpu_T1, s->A0);
>      gen_op(s, OP_CMPL, ot, R_EAX);
> -    gen_op_movl_T0_Dshift(ot);
> -    gen_op_add_reg_T0(s->aflag, R_EDI);
> +    gen_op_movl_T0_Dshift(s, ot);
> +    gen_op_add_reg_T0(s, s->aflag, R_EDI);
>  }
>
>  static inline void gen_cmps(DisasContext *s, TCGMemOp ot)
> @@ -1101,9 +1102,9 @@ static inline void gen_cmps(DisasContext *s, TCGMem=
Op ot)
>      gen_op_ld_v(s, ot, cpu_T1, s->A0);
>      gen_string_movl_A0_ESI(s);
>      gen_op(s, OP_CMPL, ot, OR_TMP0);
> -    gen_op_movl_T0_Dshift(ot);
> -    gen_op_add_reg_T0(s->aflag, R_ESI);
> -    gen_op_add_reg_T0(s->aflag, R_EDI);
> +    gen_op_movl_T0_Dshift(s, ot);
> +    gen_op_add_reg_T0(s, s->aflag, R_ESI);
> +    gen_op_add_reg_T0(s, s->aflag, R_EDI);
>  }
>
>  static void gen_bpt_io(DisasContext *s, TCGv_i32 t_port, int ot)
> @@ -1127,14 +1128,14 @@ static inline void gen_ins(DisasContext *s, TCGMe=
mOp ot)
>      gen_string_movl_A0_EDI(s);
>      /* Note: we must do this dummy write first to be restartable in
>         case of page fault. */
> -    tcg_gen_movi_tl(cpu_T0, 0);
> -    gen_op_st_v(s, ot, cpu_T0, s->A0);
> +    tcg_gen_movi_tl(s->T0, 0);
> +    gen_op_st_v(s, ot, s->T0, s->A0);
>      tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_regs[R_EDX]);
>      tcg_gen_andi_i32(cpu_tmp2_i32, cpu_tmp2_i32, 0xffff);
> -    gen_helper_in_func(ot, cpu_T0, cpu_tmp2_i32);
> -    gen_op_st_v(s, ot, cpu_T0, s->A0);
> -    gen_op_movl_T0_Dshift(ot);
> -    gen_op_add_reg_T0(s->aflag, R_EDI);
> +    gen_helper_in_func(ot, s->T0, cpu_tmp2_i32);
> +    gen_op_st_v(s, ot, s->T0, s->A0);
> +    gen_op_movl_T0_Dshift(s, ot);
> +    gen_op_add_reg_T0(s, s->aflag, R_EDI);
>      gen_bpt_io(s, cpu_tmp2_i32, ot);
>      if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
>          gen_io_end();
> @@ -1147,14 +1148,14 @@ static inline void gen_outs(DisasContext *s, TCGM=
emOp ot)
>          gen_io_start();
>      }
>      gen_string_movl_A0_ESI(s);
> -    gen_op_ld_v(s, ot, cpu_T0, s->A0);
> +    gen_op_ld_v(s, ot, s->T0, s->A0);
>
>      tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_regs[R_EDX]);
>      tcg_gen_andi_i32(cpu_tmp2_i32, cpu_tmp2_i32, 0xffff);
> -    tcg_gen_trunc_tl_i32(cpu_tmp3_i32, cpu_T0);
> +    tcg_gen_trunc_tl_i32(cpu_tmp3_i32, s->T0);
>      gen_helper_out_func(ot, cpu_tmp2_i32, cpu_tmp3_i32);
> -    gen_op_movl_T0_Dshift(ot);
> -    gen_op_add_reg_T0(s->aflag, R_ESI);
> +    gen_op_movl_T0_Dshift(s, ot);
> +    gen_op_add_reg_T0(s, s->aflag, R_ESI);
>      gen_bpt_io(s, cpu_tmp2_i32, ot);
>      if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
>          gen_io_end();
> @@ -1265,103 +1266,103 @@ static void gen_helper_fp_arith_STN_ST0(int op,=
 int opreg)
>  static void gen_op(DisasContext *s1, int op, TCGMemOp ot, int d)
>  {
>      if (d !=3D OR_TMP0) {
> -        gen_op_mov_v_reg(ot, cpu_T0, d);
> +        gen_op_mov_v_reg(ot, s1->T0, d);
>      } else if (!(s1->prefix & PREFIX_LOCK)) {
> -        gen_op_ld_v(s1, ot, cpu_T0, s1->A0);
> +        gen_op_ld_v(s1, ot, s1->T0, s1->A0);
>      }
>      switch(op) {
>      case OP_ADCL:
>          gen_compute_eflags_c(s1, cpu_tmp4);
>          if (s1->prefix & PREFIX_LOCK) {
> -            tcg_gen_add_tl(cpu_T0, cpu_tmp4, cpu_T1);
> -            tcg_gen_atomic_add_fetch_tl(cpu_T0, s1->A0, cpu_T0,
> +            tcg_gen_add_tl(s1->T0, cpu_tmp4, cpu_T1);
> +            tcg_gen_atomic_add_fetch_tl(s1->T0, s1->A0, s1->T0,
>                                          s1->mem_index, ot | MO_LE);
>          } else {
> -            tcg_gen_add_tl(cpu_T0, cpu_T0, cpu_T1);
> -            tcg_gen_add_tl(cpu_T0, cpu_T0, cpu_tmp4);
> +            tcg_gen_add_tl(s1->T0, s1->T0, cpu_T1);
> +            tcg_gen_add_tl(s1->T0, s1->T0, cpu_tmp4);
>              gen_op_st_rm_T0_A0(s1, ot, d);
>          }
> -        gen_op_update3_cc(cpu_tmp4);
> +        gen_op_update3_cc(s1, cpu_tmp4);
>          set_cc_op(s1, CC_OP_ADCB + ot);
>          break;
>      case OP_SBBL:
>          gen_compute_eflags_c(s1, cpu_tmp4);
>          if (s1->prefix & PREFIX_LOCK) {
> -            tcg_gen_add_tl(cpu_T0, cpu_T1, cpu_tmp4);
> -            tcg_gen_neg_tl(cpu_T0, cpu_T0);
> -            tcg_gen_atomic_add_fetch_tl(cpu_T0, s1->A0, cpu_T0,
> +            tcg_gen_add_tl(s1->T0, cpu_T1, cpu_tmp4);
> +            tcg_gen_neg_tl(s1->T0, s1->T0);
> +            tcg_gen_atomic_add_fetch_tl(s1->T0, s1->A0, s1->T0,
>                                          s1->mem_index, ot | MO_LE);
>          } else {
> -            tcg_gen_sub_tl(cpu_T0, cpu_T0, cpu_T1);
> -            tcg_gen_sub_tl(cpu_T0, cpu_T0, cpu_tmp4);
> +            tcg_gen_sub_tl(s1->T0, s1->T0, cpu_T1);
> +            tcg_gen_sub_tl(s1->T0, s1->T0, cpu_tmp4);
>              gen_op_st_rm_T0_A0(s1, ot, d);
>          }
> -        gen_op_update3_cc(cpu_tmp4);
> +        gen_op_update3_cc(s1, cpu_tmp4);
>          set_cc_op(s1, CC_OP_SBBB + ot);
>          break;
>      case OP_ADDL:
>          if (s1->prefix & PREFIX_LOCK) {
> -            tcg_gen_atomic_add_fetch_tl(cpu_T0, s1->A0, cpu_T1,
> +            tcg_gen_atomic_add_fetch_tl(s1->T0, s1->A0, cpu_T1,
>                                          s1->mem_index, ot | MO_LE);
>          } else {
> -            tcg_gen_add_tl(cpu_T0, cpu_T0, cpu_T1);
> +            tcg_gen_add_tl(s1->T0, s1->T0, cpu_T1);
>              gen_op_st_rm_T0_A0(s1, ot, d);
>          }
> -        gen_op_update2_cc();
> +        gen_op_update2_cc(s1);
>          set_cc_op(s1, CC_OP_ADDB + ot);
>          break;
>      case OP_SUBL:
>          if (s1->prefix & PREFIX_LOCK) {
> -            tcg_gen_neg_tl(cpu_T0, cpu_T1);
> -            tcg_gen_atomic_fetch_add_tl(s1->cc_srcT, s1->A0, cpu_T0,
> +            tcg_gen_neg_tl(s1->T0, cpu_T1);
> +            tcg_gen_atomic_fetch_add_tl(s1->cc_srcT, s1->A0, s1->T0,
>                                          s1->mem_index, ot | MO_LE);
> -            tcg_gen_sub_tl(cpu_T0, s1->cc_srcT, cpu_T1);
> +            tcg_gen_sub_tl(s1->T0, s1->cc_srcT, cpu_T1);
>          } else {
> -            tcg_gen_mov_tl(s1->cc_srcT, cpu_T0);
> -            tcg_gen_sub_tl(cpu_T0, cpu_T0, cpu_T1);
> +            tcg_gen_mov_tl(s1->cc_srcT, s1->T0);
> +            tcg_gen_sub_tl(s1->T0, s1->T0, cpu_T1);
>              gen_op_st_rm_T0_A0(s1, ot, d);
>          }
> -        gen_op_update2_cc();
> +        gen_op_update2_cc(s1);
>          set_cc_op(s1, CC_OP_SUBB + ot);
>          break;
>      default:
>      case OP_ANDL:
>          if (s1->prefix & PREFIX_LOCK) {
> -            tcg_gen_atomic_and_fetch_tl(cpu_T0, s1->A0, cpu_T1,
> +            tcg_gen_atomic_and_fetch_tl(s1->T0, s1->A0, cpu_T1,
>                                          s1->mem_index, ot | MO_LE);
>          } else {
> -            tcg_gen_and_tl(cpu_T0, cpu_T0, cpu_T1);
> +            tcg_gen_and_tl(s1->T0, s1->T0, cpu_T1);
>              gen_op_st_rm_T0_A0(s1, ot, d);
>          }
> -        gen_op_update1_cc();
> +        gen_op_update1_cc(s1);
>          set_cc_op(s1, CC_OP_LOGICB + ot);
>          break;
>      case OP_ORL:
>          if (s1->prefix & PREFIX_LOCK) {
> -            tcg_gen_atomic_or_fetch_tl(cpu_T0, s1->A0, cpu_T1,
> +            tcg_gen_atomic_or_fetch_tl(s1->T0, s1->A0, cpu_T1,
>                                         s1->mem_index, ot | MO_LE);
>          } else {
> -            tcg_gen_or_tl(cpu_T0, cpu_T0, cpu_T1);
> +            tcg_gen_or_tl(s1->T0, s1->T0, cpu_T1);
>              gen_op_st_rm_T0_A0(s1, ot, d);
>          }
> -        gen_op_update1_cc();
> +        gen_op_update1_cc(s1);
>          set_cc_op(s1, CC_OP_LOGICB + ot);
>          break;
>      case OP_XORL:
>          if (s1->prefix & PREFIX_LOCK) {
> -            tcg_gen_atomic_xor_fetch_tl(cpu_T0, s1->A0, cpu_T1,
> +            tcg_gen_atomic_xor_fetch_tl(s1->T0, s1->A0, cpu_T1,
>                                          s1->mem_index, ot | MO_LE);
>          } else {
> -            tcg_gen_xor_tl(cpu_T0, cpu_T0, cpu_T1);
> +            tcg_gen_xor_tl(s1->T0, s1->T0, cpu_T1);
>              gen_op_st_rm_T0_A0(s1, ot, d);
>          }
> -        gen_op_update1_cc();
> +        gen_op_update1_cc(s1);
>          set_cc_op(s1, CC_OP_LOGICB + ot);
>          break;
>      case OP_CMPL:
>          tcg_gen_mov_tl(cpu_cc_src, cpu_T1);
> -        tcg_gen_mov_tl(s1->cc_srcT, cpu_T0);
> -        tcg_gen_sub_tl(cpu_cc_dst, cpu_T0, cpu_T1);
> +        tcg_gen_mov_tl(s1->cc_srcT, s1->T0);
> +        tcg_gen_sub_tl(cpu_cc_dst, s1->T0, cpu_T1);
>          set_cc_op(s1, CC_OP_SUBB + ot);
>          break;
>      }
> @@ -1371,21 +1372,21 @@ static void gen_op(DisasContext *s1, int op, TCGM=
emOp ot, int d)
>  static void gen_inc(DisasContext *s1, TCGMemOp ot, int d, int c)
>  {
>      if (s1->prefix & PREFIX_LOCK) {
> -        tcg_gen_movi_tl(cpu_T0, c > 0 ? 1 : -1);
> -        tcg_gen_atomic_add_fetch_tl(cpu_T0, s1->A0, cpu_T0,
> +        tcg_gen_movi_tl(s1->T0, c > 0 ? 1 : -1);
> +        tcg_gen_atomic_add_fetch_tl(s1->T0, s1->A0, s1->T0,
>                                      s1->mem_index, ot | MO_LE);
>      } else {
>          if (d !=3D OR_TMP0) {
> -            gen_op_mov_v_reg(ot, cpu_T0, d);
> +            gen_op_mov_v_reg(ot, s1->T0, d);
>          } else {
> -            gen_op_ld_v(s1, ot, cpu_T0, s1->A0);
> +            gen_op_ld_v(s1, ot, s1->T0, s1->A0);
>          }
> -        tcg_gen_addi_tl(cpu_T0, cpu_T0, (c > 0 ? 1 : -1));
> +        tcg_gen_addi_tl(s1->T0, s1->T0, (c > 0 ? 1 : -1));
>          gen_op_st_rm_T0_A0(s1, ot, d);
>      }
>
>      gen_compute_eflags_c(s1, cpu_cc_src);
> -    tcg_gen_mov_tl(cpu_cc_dst, cpu_T0);
> +    tcg_gen_mov_tl(cpu_cc_dst, s1->T0);
>      set_cc_op(s1, (c > 0 ? CC_OP_INCB : CC_OP_DECB) + ot);
>  }
>
> @@ -1441,9 +1442,9 @@ static void gen_shift_rm_T1(DisasContext *s, TCGMem=
Op ot, int op1,
>
>      /* load */
>      if (op1 =3D=3D OR_TMP0) {
> -        gen_op_ld_v(s, ot, cpu_T0, s->A0);
> +        gen_op_ld_v(s, ot, s->T0, s->A0);
>      } else {
> -        gen_op_mov_v_reg(ot, cpu_T0, op1);
> +        gen_op_mov_v_reg(ot, s->T0, op1);
>      }
>
>      tcg_gen_andi_tl(cpu_T1, cpu_T1, mask);
> @@ -1451,23 +1452,23 @@ static void gen_shift_rm_T1(DisasContext *s, TCGM=
emOp ot, int op1,
>
>      if (is_right) {
>          if (is_arith) {
> -            gen_exts(ot, cpu_T0);
> -            tcg_gen_sar_tl(cpu_tmp0, cpu_T0, cpu_tmp0);
> -            tcg_gen_sar_tl(cpu_T0, cpu_T0, cpu_T1);
> +            gen_exts(ot, s->T0);
> +            tcg_gen_sar_tl(cpu_tmp0, s->T0, cpu_tmp0);
> +            tcg_gen_sar_tl(s->T0, s->T0, cpu_T1);
>          } else {
> -            gen_extu(ot, cpu_T0);
> -            tcg_gen_shr_tl(cpu_tmp0, cpu_T0, cpu_tmp0);
> -            tcg_gen_shr_tl(cpu_T0, cpu_T0, cpu_T1);
> +            gen_extu(ot, s->T0);
> +            tcg_gen_shr_tl(cpu_tmp0, s->T0, cpu_tmp0);
> +            tcg_gen_shr_tl(s->T0, s->T0, cpu_T1);
>          }
>      } else {
> -        tcg_gen_shl_tl(cpu_tmp0, cpu_T0, cpu_tmp0);
> -        tcg_gen_shl_tl(cpu_T0, cpu_T0, cpu_T1);
> +        tcg_gen_shl_tl(cpu_tmp0, s->T0, cpu_tmp0);
> +        tcg_gen_shl_tl(s->T0, s->T0, cpu_T1);
>      }
>
>      /* store */
>      gen_op_st_rm_T0_A0(s, ot, op1);
>
> -    gen_shift_flags(s, ot, cpu_T0, cpu_tmp0, cpu_T1, is_right);
> +    gen_shift_flags(s, ot, s->T0, cpu_tmp0, cpu_T1, is_right);
>  }
>
>  static void gen_shift_rm_im(DisasContext *s, TCGMemOp ot, int op1, int o=
p2,
> @@ -1477,25 +1478,25 @@ static void gen_shift_rm_im(DisasContext *s, TCGM=
emOp ot, int op1, int op2,
>
>      /* load */
>      if (op1 =3D=3D OR_TMP0)
> -        gen_op_ld_v(s, ot, cpu_T0, s->A0);
> +        gen_op_ld_v(s, ot, s->T0, s->A0);
>      else
> -        gen_op_mov_v_reg(ot, cpu_T0, op1);
> +        gen_op_mov_v_reg(ot, s->T0, op1);
>
>      op2 &=3D mask;
>      if (op2 !=3D 0) {
>          if (is_right) {
>              if (is_arith) {
> -                gen_exts(ot, cpu_T0);
> -                tcg_gen_sari_tl(cpu_tmp4, cpu_T0, op2 - 1);
> -                tcg_gen_sari_tl(cpu_T0, cpu_T0, op2);
> +                gen_exts(ot, s->T0);
> +                tcg_gen_sari_tl(cpu_tmp4, s->T0, op2 - 1);
> +                tcg_gen_sari_tl(s->T0, s->T0, op2);
>              } else {
> -                gen_extu(ot, cpu_T0);
> -                tcg_gen_shri_tl(cpu_tmp4, cpu_T0, op2 - 1);
> -                tcg_gen_shri_tl(cpu_T0, cpu_T0, op2);
> +                gen_extu(ot, s->T0);
> +                tcg_gen_shri_tl(cpu_tmp4, s->T0, op2 - 1);
> +                tcg_gen_shri_tl(s->T0, s->T0, op2);
>              }
>          } else {
> -            tcg_gen_shli_tl(cpu_tmp4, cpu_T0, op2 - 1);
> -            tcg_gen_shli_tl(cpu_T0, cpu_T0, op2);
> +            tcg_gen_shli_tl(cpu_tmp4, s->T0, op2 - 1);
> +            tcg_gen_shli_tl(s->T0, s->T0, op2);
>          }
>      }
>
> @@ -1505,7 +1506,7 @@ static void gen_shift_rm_im(DisasContext *s, TCGMem=
Op ot, int op1, int op2,
>      /* update eflags if non zero shift */
>      if (op2 !=3D 0) {
>          tcg_gen_mov_tl(cpu_cc_src, cpu_tmp4);
> -        tcg_gen_mov_tl(cpu_cc_dst, cpu_T0);
> +        tcg_gen_mov_tl(cpu_cc_dst, s->T0);
>          set_cc_op(s, (is_right ? CC_OP_SARB : CC_OP_SHLB) + ot);
>      }
>  }
> @@ -1517,9 +1518,9 @@ static void gen_rot_rm_T1(DisasContext *s, TCGMemOp=
 ot, int op1, int is_right)
>
>      /* load */
>      if (op1 =3D=3D OR_TMP0) {
> -        gen_op_ld_v(s, ot, cpu_T0, s->A0);
> +        gen_op_ld_v(s, ot, s->T0, s->A0);
>      } else {
> -        gen_op_mov_v_reg(ot, cpu_T0, op1);
> +        gen_op_mov_v_reg(ot, s->T0, op1);
>      }
>
>      tcg_gen_andi_tl(cpu_T1, cpu_T1, mask);
> @@ -1527,31 +1528,31 @@ static void gen_rot_rm_T1(DisasContext *s, TCGMem=
Op ot, int op1, int is_right)
>      switch (ot) {
>      case MO_8:
>          /* Replicate the 8-bit input so that a 32-bit rotate works.  */
> -        tcg_gen_ext8u_tl(cpu_T0, cpu_T0);
> -        tcg_gen_muli_tl(cpu_T0, cpu_T0, 0x01010101);
> +        tcg_gen_ext8u_tl(s->T0, s->T0);
> +        tcg_gen_muli_tl(s->T0, s->T0, 0x01010101);
>          goto do_long;
>      case MO_16:
>          /* Replicate the 16-bit input so that a 32-bit rotate works.  */
> -        tcg_gen_deposit_tl(cpu_T0, cpu_T0, cpu_T0, 16, 16);
> +        tcg_gen_deposit_tl(s->T0, s->T0, s->T0, 16, 16);
>          goto do_long;
>      do_long:
>  #ifdef TARGET_X86_64
>      case MO_32:
> -        tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_T0);
> +        tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
>          tcg_gen_trunc_tl_i32(cpu_tmp3_i32, cpu_T1);
>          if (is_right) {
>              tcg_gen_rotr_i32(cpu_tmp2_i32, cpu_tmp2_i32, cpu_tmp3_i32);
>          } else {
>              tcg_gen_rotl_i32(cpu_tmp2_i32, cpu_tmp2_i32, cpu_tmp3_i32);
>          }
> -        tcg_gen_extu_i32_tl(cpu_T0, cpu_tmp2_i32);
> +        tcg_gen_extu_i32_tl(s->T0, cpu_tmp2_i32);
>          break;
>  #endif
>      default:
>          if (is_right) {
> -            tcg_gen_rotr_tl(cpu_T0, cpu_T0, cpu_T1);
> +            tcg_gen_rotr_tl(s->T0, s->T0, cpu_T1);
>          } else {
> -            tcg_gen_rotl_tl(cpu_T0, cpu_T0, cpu_T1);
> +            tcg_gen_rotl_tl(s->T0, s->T0, cpu_T1);
>          }
>          break;
>      }
> @@ -1567,12 +1568,12 @@ static void gen_rot_rm_T1(DisasContext *s, TCGMem=
Op ot, int op1, int is_right)
>         since we've computed the flags into CC_SRC, these variables are
>         currently dead.  */
>      if (is_right) {
> -        tcg_gen_shri_tl(cpu_cc_src2, cpu_T0, mask - 1);
> -        tcg_gen_shri_tl(cpu_cc_dst, cpu_T0, mask);
> +        tcg_gen_shri_tl(cpu_cc_src2, s->T0, mask - 1);
> +        tcg_gen_shri_tl(cpu_cc_dst, s->T0, mask);
>          tcg_gen_andi_tl(cpu_cc_dst, cpu_cc_dst, 1);
>      } else {
> -        tcg_gen_shri_tl(cpu_cc_src2, cpu_T0, mask);
> -        tcg_gen_andi_tl(cpu_cc_dst, cpu_T0, 1);
> +        tcg_gen_shri_tl(cpu_cc_src2, s->T0, mask);
> +        tcg_gen_andi_tl(cpu_cc_dst, s->T0, 1);
>      }
>      tcg_gen_andi_tl(cpu_cc_src2, cpu_cc_src2, 1);
>      tcg_gen_xor_tl(cpu_cc_src2, cpu_cc_src2, cpu_cc_dst);
> @@ -1603,9 +1604,9 @@ static void gen_rot_rm_im(DisasContext *s, TCGMemOp=
 ot, int op1, int op2,
>
>      /* load */
>      if (op1 =3D=3D OR_TMP0) {
> -        gen_op_ld_v(s, ot, cpu_T0, s->A0);
> +        gen_op_ld_v(s, ot, s->T0, s->A0);
>      } else {
> -        gen_op_mov_v_reg(ot, cpu_T0, op1);
> +        gen_op_mov_v_reg(ot, s->T0, op1);
>      }
>
>      op2 &=3D mask;
> @@ -1613,20 +1614,20 @@ static void gen_rot_rm_im(DisasContext *s, TCGMem=
Op ot, int op1, int op2,
>          switch (ot) {
>  #ifdef TARGET_X86_64
>          case MO_32:
> -            tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_T0);
> +            tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
>              if (is_right) {
>                  tcg_gen_rotri_i32(cpu_tmp2_i32, cpu_tmp2_i32, op2);
>              } else {
>                  tcg_gen_rotli_i32(cpu_tmp2_i32, cpu_tmp2_i32, op2);
>              }
> -            tcg_gen_extu_i32_tl(cpu_T0, cpu_tmp2_i32);
> +            tcg_gen_extu_i32_tl(s->T0, cpu_tmp2_i32);
>              break;
>  #endif
>          default:
>              if (is_right) {
> -                tcg_gen_rotri_tl(cpu_T0, cpu_T0, op2);
> +                tcg_gen_rotri_tl(s->T0, s->T0, op2);
>              } else {
> -                tcg_gen_rotli_tl(cpu_T0, cpu_T0, op2);
> +                tcg_gen_rotli_tl(s->T0, s->T0, op2);
>              }
>              break;
>          case MO_8:
> @@ -1639,10 +1640,10 @@ static void gen_rot_rm_im(DisasContext *s, TCGMem=
Op ot, int op1, int op2,
>              if (is_right) {
>                  shift =3D mask + 1 - shift;
>              }
> -            gen_extu(ot, cpu_T0);
> -            tcg_gen_shli_tl(cpu_tmp0, cpu_T0, shift);
> -            tcg_gen_shri_tl(cpu_T0, cpu_T0, mask + 1 - shift);
> -            tcg_gen_or_tl(cpu_T0, cpu_T0, cpu_tmp0);
> +            gen_extu(ot, s->T0);
> +            tcg_gen_shli_tl(cpu_tmp0, s->T0, shift);
> +            tcg_gen_shri_tl(s->T0, s->T0, mask + 1 - shift);
> +            tcg_gen_or_tl(s->T0, s->T0, cpu_tmp0);
>              break;
>          }
>      }
> @@ -1659,12 +1660,12 @@ static void gen_rot_rm_im(DisasContext *s, TCGMem=
Op ot, int op1, int op2,
>             since we've computed the flags into CC_SRC, these variables a=
re
>             currently dead.  */
>          if (is_right) {
> -            tcg_gen_shri_tl(cpu_cc_src2, cpu_T0, mask - 1);
> -            tcg_gen_shri_tl(cpu_cc_dst, cpu_T0, mask);
> +            tcg_gen_shri_tl(cpu_cc_src2, s->T0, mask - 1);
> +            tcg_gen_shri_tl(cpu_cc_dst, s->T0, mask);
>              tcg_gen_andi_tl(cpu_cc_dst, cpu_cc_dst, 1);
>          } else {
> -            tcg_gen_shri_tl(cpu_cc_src2, cpu_T0, mask);
> -            tcg_gen_andi_tl(cpu_cc_dst, cpu_T0, 1);
> +            tcg_gen_shri_tl(cpu_cc_src2, s->T0, mask);
> +            tcg_gen_andi_tl(cpu_cc_dst, s->T0, 1);
>          }
>          tcg_gen_andi_tl(cpu_cc_src2, cpu_cc_src2, 1);
>          tcg_gen_xor_tl(cpu_cc_src2, cpu_cc_src2, cpu_cc_dst);
> @@ -1681,24 +1682,24 @@ static void gen_rotc_rm_T1(DisasContext *s, TCGMe=
mOp ot, int op1,
>
>      /* load */
>      if (op1 =3D=3D OR_TMP0)
> -        gen_op_ld_v(s, ot, cpu_T0, s->A0);
> +        gen_op_ld_v(s, ot, s->T0, s->A0);
>      else
> -        gen_op_mov_v_reg(ot, cpu_T0, op1);
> +        gen_op_mov_v_reg(ot, s->T0, op1);
>
>      if (is_right) {
>          switch (ot) {
>          case MO_8:
> -            gen_helper_rcrb(cpu_T0, cpu_env, cpu_T0, cpu_T1);
> +            gen_helper_rcrb(s->T0, cpu_env, s->T0, cpu_T1);
>              break;
>          case MO_16:
> -            gen_helper_rcrw(cpu_T0, cpu_env, cpu_T0, cpu_T1);
> +            gen_helper_rcrw(s->T0, cpu_env, s->T0, cpu_T1);
>              break;
>          case MO_32:
> -            gen_helper_rcrl(cpu_T0, cpu_env, cpu_T0, cpu_T1);
> +            gen_helper_rcrl(s->T0, cpu_env, s->T0, cpu_T1);
>              break;
>  #ifdef TARGET_X86_64
>          case MO_64:
> -            gen_helper_rcrq(cpu_T0, cpu_env, cpu_T0, cpu_T1);
> +            gen_helper_rcrq(s->T0, cpu_env, s->T0, cpu_T1);
>              break;
>  #endif
>          default:
> @@ -1707,17 +1708,17 @@ static void gen_rotc_rm_T1(DisasContext *s, TCGMe=
mOp ot, int op1,
>      } else {
>          switch (ot) {
>          case MO_8:
> -            gen_helper_rclb(cpu_T0, cpu_env, cpu_T0, cpu_T1);
> +            gen_helper_rclb(s->T0, cpu_env, s->T0, cpu_T1);
>              break;
>          case MO_16:
> -            gen_helper_rclw(cpu_T0, cpu_env, cpu_T0, cpu_T1);
> +            gen_helper_rclw(s->T0, cpu_env, s->T0, cpu_T1);
>              break;
>          case MO_32:
> -            gen_helper_rcll(cpu_T0, cpu_env, cpu_T0, cpu_T1);
> +            gen_helper_rcll(s->T0, cpu_env, s->T0, cpu_T1);
>              break;
>  #ifdef TARGET_X86_64
>          case MO_64:
> -            gen_helper_rclq(cpu_T0, cpu_env, cpu_T0, cpu_T1);
> +            gen_helper_rclq(s->T0, cpu_env, s->T0, cpu_T1);
>              break;
>  #endif
>          default:
> @@ -1737,9 +1738,9 @@ static void gen_shiftd_rm_T1(DisasContext *s, TCGMe=
mOp ot, int op1,
>
>      /* load */
>      if (op1 =3D=3D OR_TMP0) {
> -        gen_op_ld_v(s, ot, cpu_T0, s->A0);
> +        gen_op_ld_v(s, ot, s->T0, s->A0);
>      } else {
> -        gen_op_mov_v_reg(ot, cpu_T0, op1);
> +        gen_op_mov_v_reg(ot, s->T0, op1);
>      }
>
>      count =3D tcg_temp_new();
> @@ -1751,11 +1752,11 @@ static void gen_shiftd_rm_T1(DisasContext *s, TCG=
MemOp ot, int op1,
>             This means "shrdw C, B, A" shifts A:B:A >> C.  Build the B:A
>             portion by constructing it as a 32-bit value.  */
>          if (is_right) {
> -            tcg_gen_deposit_tl(cpu_tmp0, cpu_T0, cpu_T1, 16, 16);
> -            tcg_gen_mov_tl(cpu_T1, cpu_T0);
> -            tcg_gen_mov_tl(cpu_T0, cpu_tmp0);
> +            tcg_gen_deposit_tl(cpu_tmp0, s->T0, cpu_T1, 16, 16);
> +            tcg_gen_mov_tl(cpu_T1, s->T0);
> +            tcg_gen_mov_tl(s->T0, cpu_tmp0);
>          } else {
> -            tcg_gen_deposit_tl(cpu_T1, cpu_T0, cpu_T1, 16, 16);
> +            tcg_gen_deposit_tl(cpu_T1, s->T0, cpu_T1, 16, 16);
>          }
>          /* FALLTHRU */
>  #ifdef TARGET_X86_64
> @@ -1763,28 +1764,28 @@ static void gen_shiftd_rm_T1(DisasContext *s, TCG=
MemOp ot, int op1,
>          /* Concatenate the two 32-bit values and use a 64-bit shift.  */
>          tcg_gen_subi_tl(cpu_tmp0, count, 1);
>          if (is_right) {
> -            tcg_gen_concat_tl_i64(cpu_T0, cpu_T0, cpu_T1);
> -            tcg_gen_shr_i64(cpu_tmp0, cpu_T0, cpu_tmp0);
> -            tcg_gen_shr_i64(cpu_T0, cpu_T0, count);
> +            tcg_gen_concat_tl_i64(s->T0, s->T0, cpu_T1);
> +            tcg_gen_shr_i64(cpu_tmp0, s->T0, cpu_tmp0);
> +            tcg_gen_shr_i64(s->T0, s->T0, count);
>          } else {
> -            tcg_gen_concat_tl_i64(cpu_T0, cpu_T1, cpu_T0);
> -            tcg_gen_shl_i64(cpu_tmp0, cpu_T0, cpu_tmp0);
> -            tcg_gen_shl_i64(cpu_T0, cpu_T0, count);
> +            tcg_gen_concat_tl_i64(s->T0, cpu_T1, s->T0);
> +            tcg_gen_shl_i64(cpu_tmp0, s->T0, cpu_tmp0);
> +            tcg_gen_shl_i64(s->T0, s->T0, count);
>              tcg_gen_shri_i64(cpu_tmp0, cpu_tmp0, 32);
> -            tcg_gen_shri_i64(cpu_T0, cpu_T0, 32);
> +            tcg_gen_shri_i64(s->T0, s->T0, 32);
>          }
>          break;
>  #endif
>      default:
>          tcg_gen_subi_tl(cpu_tmp0, count, 1);
>          if (is_right) {
> -            tcg_gen_shr_tl(cpu_tmp0, cpu_T0, cpu_tmp0);
> +            tcg_gen_shr_tl(cpu_tmp0, s->T0, cpu_tmp0);
>
>              tcg_gen_subfi_tl(cpu_tmp4, mask + 1, count);
> -            tcg_gen_shr_tl(cpu_T0, cpu_T0, count);
> +            tcg_gen_shr_tl(s->T0, s->T0, count);
>              tcg_gen_shl_tl(cpu_T1, cpu_T1, cpu_tmp4);
>          } else {
> -            tcg_gen_shl_tl(cpu_tmp0, cpu_T0, cpu_tmp0);
> +            tcg_gen_shl_tl(cpu_tmp0, s->T0, cpu_tmp0);
>              if (ot =3D=3D MO_16) {
>                  /* Only needed if count > 16, for Intel behaviour.  */
>                  tcg_gen_subfi_tl(cpu_tmp4, 33, count);
> @@ -1793,20 +1794,20 @@ static void gen_shiftd_rm_T1(DisasContext *s, TCG=
MemOp ot, int op1,
>              }
>
>              tcg_gen_subfi_tl(cpu_tmp4, mask + 1, count);
> -            tcg_gen_shl_tl(cpu_T0, cpu_T0, count);
> +            tcg_gen_shl_tl(s->T0, s->T0, count);
>              tcg_gen_shr_tl(cpu_T1, cpu_T1, cpu_tmp4);
>          }
>          tcg_gen_movi_tl(cpu_tmp4, 0);
>          tcg_gen_movcond_tl(TCG_COND_EQ, cpu_T1, count, cpu_tmp4,
>                             cpu_tmp4, cpu_T1);
> -        tcg_gen_or_tl(cpu_T0, cpu_T0, cpu_T1);
> +        tcg_gen_or_tl(s->T0, s->T0, cpu_T1);
>          break;
>      }
>
>      /* store */
>      gen_op_st_rm_T0_A0(s, ot, op1);
>
> -    gen_shift_flags(s, ot, cpu_T0, cpu_tmp0, count, is_right);
> +    gen_shift_flags(s, ot, s->T0, cpu_tmp0, count, is_right);
>      tcg_temp_free(count);
>  }
>
> @@ -2126,23 +2127,23 @@ static void gen_ldst_modrm(CPUX86State *env, Disa=
sContext *s, int modrm,
>      if (mod =3D=3D 3) {
>          if (is_store) {
>              if (reg !=3D OR_TMP0)
> -                gen_op_mov_v_reg(ot, cpu_T0, reg);
> -            gen_op_mov_reg_v(ot, rm, cpu_T0);
> +                gen_op_mov_v_reg(ot, s->T0, reg);
> +            gen_op_mov_reg_v(ot, rm, s->T0);
>          } else {
> -            gen_op_mov_v_reg(ot, cpu_T0, rm);
> +            gen_op_mov_v_reg(ot, s->T0, rm);
>              if (reg !=3D OR_TMP0)
> -                gen_op_mov_reg_v(ot, reg, cpu_T0);
> +                gen_op_mov_reg_v(ot, reg, s->T0);
>          }
>      } else {
>          gen_lea_modrm(env, s, modrm);
>          if (is_store) {
>              if (reg !=3D OR_TMP0)
> -                gen_op_mov_v_reg(ot, cpu_T0, reg);
> -            gen_op_st_v(s, ot, cpu_T0, s->A0);
> +                gen_op_mov_v_reg(ot, s->T0, reg);
> +            gen_op_st_v(s, ot, s->T0, s->A0);
>          } else {
> -            gen_op_ld_v(s, ot, cpu_T0, s->A0);
> +            gen_op_ld_v(s, ot, s->T0, s->A0);
>              if (reg !=3D OR_TMP0)
> -                gen_op_mov_reg_v(ot, reg, cpu_T0);
> +                gen_op_mov_reg_v(ot, reg, s->T0);
>          }
>      }
>  }
> @@ -2251,9 +2252,9 @@ static void gen_cmovcc1(CPUX86State *env, DisasCont=
ext *s, TCGMemOp ot, int b,
>          cc.reg2 =3D tcg_const_tl(cc.imm);
>      }
>
> -    tcg_gen_movcond_tl(cc.cond, cpu_T0, cc.reg, cc.reg2,
> -                       cpu_T0, cpu_regs[reg]);
> -    gen_op_mov_reg_v(ot, reg, cpu_T0);
> +    tcg_gen_movcond_tl(cc.cond, s->T0, cc.reg, cc.reg2,
> +                       s->T0, cpu_regs[reg]);
> +    gen_op_mov_reg_v(ot, reg, s->T0);
>
>      if (cc.mask !=3D -1) {
>          tcg_temp_free(cc.reg);
> @@ -2263,18 +2264,18 @@ static void gen_cmovcc1(CPUX86State *env, DisasCo=
ntext *s, TCGMemOp ot, int b,
>      }
>  }
>
> -static inline void gen_op_movl_T0_seg(int seg_reg)
> +static inline void gen_op_movl_T0_seg(DisasContext *s, int seg_reg)
>  {
> -    tcg_gen_ld32u_tl(cpu_T0, cpu_env,
> +    tcg_gen_ld32u_tl(s->T0, cpu_env,
>                       offsetof(CPUX86State,segs[seg_reg].selector));
>  }
>
> -static inline void gen_op_movl_seg_T0_vm(int seg_reg)
> +static inline void gen_op_movl_seg_T0_vm(DisasContext *s, int seg_reg)
>  {
> -    tcg_gen_ext16u_tl(cpu_T0, cpu_T0);
> -    tcg_gen_st32_tl(cpu_T0, cpu_env,
> +    tcg_gen_ext16u_tl(s->T0, s->T0);
> +    tcg_gen_st32_tl(s->T0, cpu_env,
>                      offsetof(CPUX86State,segs[seg_reg].selector));
> -    tcg_gen_shli_tl(cpu_seg_base[seg_reg], cpu_T0, 4);
> +    tcg_gen_shli_tl(cpu_seg_base[seg_reg], s->T0, 4);
>  }
>
>  /* move T0 to seg_reg and compute if the CPU state may change. Never
> @@ -2282,7 +2283,7 @@ static inline void gen_op_movl_seg_T0_vm(int seg_re=
g)
>  static void gen_movl_seg_T0(DisasContext *s, int seg_reg)
>  {
>      if (s->pe && !s->vm86) {
> -        tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_T0);
> +        tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
>          gen_helper_load_seg(cpu_env, tcg_const_i32(seg_reg), cpu_tmp2_i3=
2);
>          /* abort translation because the addseg value may change or
>             because ss32 may change. For R_SS, translation must always
> @@ -2292,7 +2293,7 @@ static void gen_movl_seg_T0(DisasContext *s, int se=
g_reg)
>              s->base.is_jmp =3D DISAS_TOO_MANY;
>          }
>      } else {
> -        gen_op_movl_seg_T0_vm(seg_reg);
> +        gen_op_movl_seg_T0_vm(s, seg_reg);
>          if (seg_reg =3D=3D R_SS) {
>              s->base.is_jmp =3D DISAS_TOO_MANY;
>          }
> @@ -2356,7 +2357,7 @@ static TCGMemOp gen_pop_T0(DisasContext *s)
>      TCGMemOp d_ot =3D mo_pushpop(s, s->dflag);
>
>      gen_lea_v_seg(s, mo_stacksize(s), cpu_regs[R_ESP], R_SS, -1);
> -    gen_op_ld_v(s, d_ot, cpu_T0, s->A0);
> +    gen_op_ld_v(s, d_ot, s->T0, s->A0);
>
>      return d_ot;
>  }
> @@ -2401,8 +2402,8 @@ static void gen_popa(DisasContext *s)
>          }
>          tcg_gen_addi_tl(s->A0, cpu_regs[R_ESP], i * size);
>          gen_lea_v_seg(s, s_ot, s->A0, R_SS, -1);
> -        gen_op_ld_v(s, d_ot, cpu_T0, s->A0);
> -        gen_op_mov_reg_v(d_ot, 7 - i, cpu_T0);
> +        gen_op_ld_v(s, d_ot, s->T0, s->A0);
> +        gen_op_mov_reg_v(d_ot, 7 - i, s->T0);
>      }
>
>      gen_stack_update(s, 8 * size);
> @@ -2454,11 +2455,11 @@ static void gen_leave(DisasContext *s)
>      TCGMemOp a_ot =3D mo_stacksize(s);
>
>      gen_lea_v_seg(s, a_ot, cpu_regs[R_EBP], R_SS, -1);
> -    gen_op_ld_v(s, d_ot, cpu_T0, s->A0);
> +    gen_op_ld_v(s, d_ot, s->T0, s->A0);
>
>      tcg_gen_addi_tl(cpu_T1, cpu_regs[R_EBP], 1 << d_ot);
>
> -    gen_op_mov_reg_v(d_ot, R_EBP, cpu_T0);
> +    gen_op_mov_reg_v(d_ot, R_EBP, s->T0);
>      gen_op_mov_reg_v(a_ot, R_ESP, cpu_T1);
>  }
>
> @@ -3126,23 +3127,24 @@ static void gen_sse(CPUX86State *env, DisasContex=
t *s, int b,
>                  gen_stq_env_A0(s, offsetof(CPUX86State,
>                                             xmm_regs[reg].ZMM_Q(0)));
>              } else {
> -                tcg_gen_ld32u_tl(cpu_T0, cpu_env, offsetof(CPUX86State,
> +                tcg_gen_ld32u_tl(s->T0, cpu_env, offsetof(CPUX86State,
>                      xmm_regs[reg].ZMM_L(0)));
> -                gen_op_st_v(s, MO_32, cpu_T0, s->A0);
> +                gen_op_st_v(s, MO_32, s->T0, s->A0);
>              }
>              break;
>          case 0x6e: /* movd mm, ea */
>  #ifdef TARGET_X86_64
>              if (s->dflag =3D=3D MO_64) {
>                  gen_ldst_modrm(env, s, modrm, MO_64, OR_TMP0, 0);
> -                tcg_gen_st_tl(cpu_T0, cpu_env, offsetof(CPUX86State,fpre=
gs[reg].mmx));
> +                tcg_gen_st_tl(s->T0, cpu_env,
> +                              offsetof(CPUX86State, fpregs[reg].mmx));
>              } else
>  #endif
>              {
>                  gen_ldst_modrm(env, s, modrm, MO_32, OR_TMP0, 0);
>                  tcg_gen_addi_ptr(cpu_ptr0, cpu_env,
>                                   offsetof(CPUX86State,fpregs[reg].mmx));
> -                tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_T0);
> +                tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
>                  gen_helper_movl_mm_T0_mmx(cpu_ptr0, cpu_tmp2_i32);
>              }
>              break;
> @@ -3152,14 +3154,14 @@ static void gen_sse(CPUX86State *env, DisasContex=
t *s, int b,
>                  gen_ldst_modrm(env, s, modrm, MO_64, OR_TMP0, 0);
>                  tcg_gen_addi_ptr(cpu_ptr0, cpu_env,
>                                   offsetof(CPUX86State,xmm_regs[reg]));
> -                gen_helper_movq_mm_T0_xmm(cpu_ptr0, cpu_T0);
> +                gen_helper_movq_mm_T0_xmm(cpu_ptr0, s->T0);
>              } else
>  #endif
>              {
>                  gen_ldst_modrm(env, s, modrm, MO_32, OR_TMP0, 0);
>                  tcg_gen_addi_ptr(cpu_ptr0, cpu_env,
>                                   offsetof(CPUX86State,xmm_regs[reg]));
> -                tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_T0);
> +                tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
>                  gen_helper_movl_mm_T0_xmm(cpu_ptr0, cpu_tmp2_i32);
>              }
>              break;
> @@ -3193,12 +3195,16 @@ static void gen_sse(CPUX86State *env, DisasContex=
t *s, int b,
>          case 0x210: /* movss xmm, ea */
>              if (mod !=3D 3) {
>                  gen_lea_modrm(env, s, modrm);
> -                gen_op_ld_v(s, MO_32, cpu_T0, s->A0);
> -                tcg_gen_st32_tl(cpu_T0, cpu_env, offsetof(CPUX86State,xm=
m_regs[reg].ZMM_L(0)));
> -                tcg_gen_movi_tl(cpu_T0, 0);
> -                tcg_gen_st32_tl(cpu_T0, cpu_env, offsetof(CPUX86State,xm=
m_regs[reg].ZMM_L(1)));
> -                tcg_gen_st32_tl(cpu_T0, cpu_env, offsetof(CPUX86State,xm=
m_regs[reg].ZMM_L(2)));
> -                tcg_gen_st32_tl(cpu_T0, cpu_env, offsetof(CPUX86State,xm=
m_regs[reg].ZMM_L(3)));
> +                gen_op_ld_v(s, MO_32, s->T0, s->A0);
> +                tcg_gen_st32_tl(s->T0, cpu_env,
> +                                offsetof(CPUX86State, xmm_regs[reg].ZMM_=
L(0)));
> +                tcg_gen_movi_tl(s->T0, 0);
> +                tcg_gen_st32_tl(s->T0, cpu_env,
> +                                offsetof(CPUX86State, xmm_regs[reg].ZMM_=
L(1)));
> +                tcg_gen_st32_tl(s->T0, cpu_env,
> +                                offsetof(CPUX86State, xmm_regs[reg].ZMM_=
L(2)));
> +                tcg_gen_st32_tl(s->T0, cpu_env,
> +                                offsetof(CPUX86State, xmm_regs[reg].ZMM_=
L(3)));
>              } else {
>                  rm =3D (modrm & 7) | REX_B(s);
>                  gen_op_movl(offsetof(CPUX86State,xmm_regs[reg].ZMM_L(0)),
> @@ -3210,9 +3216,11 @@ static void gen_sse(CPUX86State *env, DisasContext=
 *s, int b,
>                  gen_lea_modrm(env, s, modrm);
>                  gen_ldq_env_A0(s, offsetof(CPUX86State,
>                                             xmm_regs[reg].ZMM_Q(0)));
> -                tcg_gen_movi_tl(cpu_T0, 0);
> -                tcg_gen_st32_tl(cpu_T0, cpu_env, offsetof(CPUX86State,xm=
m_regs[reg].ZMM_L(2)));
> -                tcg_gen_st32_tl(cpu_T0, cpu_env, offsetof(CPUX86State,xm=
m_regs[reg].ZMM_L(3)));
> +                tcg_gen_movi_tl(s->T0, 0);
> +                tcg_gen_st32_tl(s->T0, cpu_env,
> +                                offsetof(CPUX86State, xmm_regs[reg].ZMM_=
L(2)));
> +                tcg_gen_st32_tl(s->T0, cpu_env,
> +                                offsetof(CPUX86State, xmm_regs[reg].ZMM_=
L(3)));
>              } else {
>                  rm =3D (modrm & 7) | REX_B(s);
>                  gen_op_movq(offsetof(CPUX86State,xmm_regs[reg].ZMM_Q(0)),
> @@ -3314,13 +3322,13 @@ static void gen_sse(CPUX86State *env, DisasContex=
t *s, int b,
>          case 0x7e: /* movd ea, mm */
>  #ifdef TARGET_X86_64
>              if (s->dflag =3D=3D MO_64) {
> -                tcg_gen_ld_i64(cpu_T0, cpu_env,
> +                tcg_gen_ld_i64(s->T0, cpu_env,
>                                 offsetof(CPUX86State,fpregs[reg].mmx));
>                  gen_ldst_modrm(env, s, modrm, MO_64, OR_TMP0, 1);
>              } else
>  #endif
>              {
> -                tcg_gen_ld32u_tl(cpu_T0, cpu_env,
> +                tcg_gen_ld32u_tl(s->T0, cpu_env,
>                                   offsetof(CPUX86State,fpregs[reg].mmx.MM=
X_L(0)));
>                  gen_ldst_modrm(env, s, modrm, MO_32, OR_TMP0, 1);
>              }
> @@ -3328,13 +3336,13 @@ static void gen_sse(CPUX86State *env, DisasContex=
t *s, int b,
>          case 0x17e: /* movd ea, xmm */
>  #ifdef TARGET_X86_64
>              if (s->dflag =3D=3D MO_64) {
> -                tcg_gen_ld_i64(cpu_T0, cpu_env,
> +                tcg_gen_ld_i64(s->T0, cpu_env,
>                                 offsetof(CPUX86State,xmm_regs[reg].ZMM_Q(=
0)));
>                  gen_ldst_modrm(env, s, modrm, MO_64, OR_TMP0, 1);
>              } else
>  #endif
>              {
> -                tcg_gen_ld32u_tl(cpu_T0, cpu_env,
> +                tcg_gen_ld32u_tl(s->T0, cpu_env,
>                                   offsetof(CPUX86State,xmm_regs[reg].ZMM_=
L(0)));
>                  gen_ldst_modrm(env, s, modrm, MO_32, OR_TMP0, 1);
>              }
> @@ -3379,8 +3387,9 @@ static void gen_sse(CPUX86State *env, DisasContext =
*s, int b,
>          case 0x211: /* movss ea, xmm */
>              if (mod !=3D 3) {
>                  gen_lea_modrm(env, s, modrm);
> -                tcg_gen_ld32u_tl(cpu_T0, cpu_env, offsetof(CPUX86State,x=
mm_regs[reg].ZMM_L(0)));
> -                gen_op_st_v(s, MO_32, cpu_T0, s->A0);
> +                tcg_gen_ld32u_tl(s->T0, cpu_env,
> +                                 offsetof(CPUX86State, xmm_regs[reg].ZMM=
_L(0)));
> +                gen_op_st_v(s, MO_32, s->T0, s->A0);
>              } else {
>                  rm =3D (modrm & 7) | REX_B(s);
>                  gen_op_movl(offsetof(CPUX86State,xmm_regs[rm].ZMM_L(0)),
> @@ -3429,16 +3438,20 @@ static void gen_sse(CPUX86State *env, DisasContex=
t *s, int b,
>              }
>              val =3D x86_ldub_code(env, s);
>              if (is_xmm) {
> -                tcg_gen_movi_tl(cpu_T0, val);
> -                tcg_gen_st32_tl(cpu_T0, cpu_env, offsetof(CPUX86State,xm=
m_t0.ZMM_L(0)));
> -                tcg_gen_movi_tl(cpu_T0, 0);
> -                tcg_gen_st32_tl(cpu_T0, cpu_env, offsetof(CPUX86State,xm=
m_t0.ZMM_L(1)));
> +                tcg_gen_movi_tl(s->T0, val);
> +                tcg_gen_st32_tl(s->T0, cpu_env,
> +                                offsetof(CPUX86State, xmm_t0.ZMM_L(0)));
> +                tcg_gen_movi_tl(s->T0, 0);
> +                tcg_gen_st32_tl(s->T0, cpu_env,
> +                                offsetof(CPUX86State, xmm_t0.ZMM_L(1)));
>                  op1_offset =3D offsetof(CPUX86State,xmm_t0);
>              } else {
> -                tcg_gen_movi_tl(cpu_T0, val);
> -                tcg_gen_st32_tl(cpu_T0, cpu_env, offsetof(CPUX86State,mm=
x_t0.MMX_L(0)));
> -                tcg_gen_movi_tl(cpu_T0, 0);
> -                tcg_gen_st32_tl(cpu_T0, cpu_env, offsetof(CPUX86State,mm=
x_t0.MMX_L(1)));
> +                tcg_gen_movi_tl(s->T0, val);
> +                tcg_gen_st32_tl(s->T0, cpu_env,
> +                                offsetof(CPUX86State, mmx_t0.MMX_L(0)));
> +                tcg_gen_movi_tl(s->T0, 0);
> +                tcg_gen_st32_tl(s->T0, cpu_env,
> +                                offsetof(CPUX86State, mmx_t0.MMX_L(1)));
>                  op1_offset =3D offsetof(CPUX86State,mmx_t0);
>              }
>              sse_fn_epp =3D sse_op_table2[((b - 1) & 3) * 8 +
> @@ -3503,12 +3516,12 @@ static void gen_sse(CPUX86State *env, DisasContex=
t *s, int b,
>              tcg_gen_addi_ptr(cpu_ptr0, cpu_env, op1_offset);
>              if (ot =3D=3D MO_32) {
>                  SSEFunc_0_epi sse_fn_epi =3D sse_op_table3ai[(b >> 8) & =
1];
> -                tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_T0);
> +                tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
>                  sse_fn_epi(cpu_env, cpu_ptr0, cpu_tmp2_i32);
>              } else {
>  #ifdef TARGET_X86_64
>                  SSEFunc_0_epl sse_fn_epl =3D sse_op_table3aq[(b >> 8) & =
1];
> -                sse_fn_epl(cpu_env, cpu_ptr0, cpu_T0);
> +                sse_fn_epl(cpu_env, cpu_ptr0, s->T0);
>  #else
>                  goto illegal_op;
>  #endif
> @@ -3555,8 +3568,9 @@ static void gen_sse(CPUX86State *env, DisasContext =
*s, int b,
>                  if ((b >> 8) & 1) {
>                      gen_ldq_env_A0(s, offsetof(CPUX86State, xmm_t0.ZMM_Q=
(0)));
>                  } else {
> -                    gen_op_ld_v(s, MO_32, cpu_T0, s->A0);
> -                    tcg_gen_st32_tl(cpu_T0, cpu_env, offsetof(CPUX86Stat=
e,xmm_t0.ZMM_L(0)));
> +                    gen_op_ld_v(s, MO_32, s->T0, s->A0);
> +                    tcg_gen_st32_tl(s->T0, cpu_env,
> +                                    offsetof(CPUX86State, xmm_t0.ZMM_L(0=
)));
>                  }
>                  op2_offset =3D offsetof(CPUX86State,xmm_t0);
>              } else {
> @@ -3568,17 +3582,17 @@ static void gen_sse(CPUX86State *env, DisasContex=
t *s, int b,
>                  SSEFunc_i_ep sse_fn_i_ep =3D
>                      sse_op_table3bi[((b >> 7) & 2) | (b & 1)];
>                  sse_fn_i_ep(cpu_tmp2_i32, cpu_env, cpu_ptr0);
> -                tcg_gen_extu_i32_tl(cpu_T0, cpu_tmp2_i32);
> +                tcg_gen_extu_i32_tl(s->T0, cpu_tmp2_i32);
>              } else {
>  #ifdef TARGET_X86_64
>                  SSEFunc_l_ep sse_fn_l_ep =3D
>                      sse_op_table3bq[((b >> 7) & 2) | (b & 1)];
> -                sse_fn_l_ep(cpu_T0, cpu_env, cpu_ptr0);
> +                sse_fn_l_ep(s->T0, cpu_env, cpu_ptr0);
>  #else
>                  goto illegal_op;
>  #endif
>              }
> -            gen_op_mov_reg_v(ot, reg, cpu_T0);
> +            gen_op_mov_reg_v(ot, reg, s->T0);
>              break;
>          case 0xc4: /* pinsrw */
>          case 0x1c4:
> @@ -3587,11 +3601,11 @@ static void gen_sse(CPUX86State *env, DisasContex=
t *s, int b,
>              val =3D x86_ldub_code(env, s);
>              if (b1) {
>                  val &=3D 7;
> -                tcg_gen_st16_tl(cpu_T0, cpu_env,
> +                tcg_gen_st16_tl(s->T0, cpu_env,
>                                  offsetof(CPUX86State,xmm_regs[reg].ZMM_W=
(val)));
>              } else {
>                  val &=3D 3;
> -                tcg_gen_st16_tl(cpu_T0, cpu_env,
> +                tcg_gen_st16_tl(s->T0, cpu_env,
>                                  offsetof(CPUX86State,fpregs[reg].mmx.MMX=
_W(val)));
>              }
>              break;
> @@ -3604,16 +3618,16 @@ static void gen_sse(CPUX86State *env, DisasContex=
t *s, int b,
>              if (b1) {
>                  val &=3D 7;
>                  rm =3D (modrm & 7) | REX_B(s);
> -                tcg_gen_ld16u_tl(cpu_T0, cpu_env,
> +                tcg_gen_ld16u_tl(s->T0, cpu_env,
>                                   offsetof(CPUX86State,xmm_regs[rm].ZMM_W=
(val)));
>              } else {
>                  val &=3D 3;
>                  rm =3D (modrm & 7);
> -                tcg_gen_ld16u_tl(cpu_T0, cpu_env,
> +                tcg_gen_ld16u_tl(s->T0, cpu_env,
>                                  offsetof(CPUX86State,fpregs[rm].mmx.MMX_=
W(val)));
>              }
>              reg =3D ((modrm >> 3) & 7) | rex_r;
> -            gen_op_mov_reg_v(ot, reg, cpu_T0);
> +            gen_op_mov_reg_v(ot, reg, s->T0);
>              break;
>          case 0x1d6: /* movq ea, xmm */
>              if (mod !=3D 3) {
> @@ -3760,11 +3774,11 @@ static void gen_sse(CPUX86State *env, DisasContex=
t *s, int b,
>
>                  tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_regs[reg]);
>                  gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
> -                gen_helper_crc32(cpu_T0, cpu_tmp2_i32,
> -                                 cpu_T0, tcg_const_i32(8 << ot));
> +                gen_helper_crc32(s->T0, cpu_tmp2_i32,
> +                                 s->T0, tcg_const_i32(8 << ot));
>
>                  ot =3D mo_64_32(s->dflag);
> -                gen_op_mov_reg_v(ot, reg, cpu_T0);
> +                gen_op_mov_reg_v(ot, reg, s->T0);
>                  break;
>
>              case 0x1f0: /* crc32 or movbe */
> @@ -3789,9 +3803,9 @@ static void gen_sse(CPUX86State *env, DisasContext =
*s, int b,
>
>                  gen_lea_modrm(env, s, modrm);
>                  if ((b & 1) =3D=3D 0) {
> -                    tcg_gen_qemu_ld_tl(cpu_T0, s->A0,
> +                    tcg_gen_qemu_ld_tl(s->T0, s->A0,
>                                         s->mem_index, ot | MO_BE);
> -                    gen_op_mov_reg_v(ot, reg, cpu_T0);
> +                    gen_op_mov_reg_v(ot, reg, s->T0);
>                  } else {
>                      tcg_gen_qemu_st_tl(cpu_regs[reg], s->A0,
>                                         s->mem_index, ot | MO_BE);
> @@ -3806,9 +3820,9 @@ static void gen_sse(CPUX86State *env, DisasContext =
*s, int b,
>                  }
>                  ot =3D mo_64_32(s->dflag);
>                  gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
> -                tcg_gen_andc_tl(cpu_T0, cpu_T0, cpu_regs[s->vex_v]);
> -                gen_op_mov_reg_v(ot, reg, cpu_T0);
> -                gen_op_update1_cc();
> +                tcg_gen_andc_tl(s->T0, s->T0, cpu_regs[s->vex_v]);
> +                gen_op_mov_reg_v(ot, reg, s->T0);
> +                gen_op_update1_cc(s);
>                  set_cc_op(s, CC_OP_LOGICB + ot);
>                  break;
>
> @@ -3826,12 +3840,12 @@ static void gen_sse(CPUX86State *env, DisasContex=
t *s, int b,
>                      /* Extract START, and shift the operand.
>                         Shifts larger than operand size get zeros.  */
>                      tcg_gen_ext8u_tl(s->A0, cpu_regs[s->vex_v]);
> -                    tcg_gen_shr_tl(cpu_T0, cpu_T0, s->A0);
> +                    tcg_gen_shr_tl(s->T0, s->T0, s->A0);
>
>                      bound =3D tcg_const_tl(ot =3D=3D MO_64 ? 63 : 31);
>                      zero =3D tcg_const_tl(0);
> -                    tcg_gen_movcond_tl(TCG_COND_LEU, cpu_T0, s->A0, boun=
d,
> -                                       cpu_T0, zero);
> +                    tcg_gen_movcond_tl(TCG_COND_LEU, s->T0, s->A0, bound,
> +                                       s->T0, zero);
>                      tcg_temp_free(zero);
>
>                      /* Extract the LEN into a mask.  Lengths larger than
> @@ -3843,10 +3857,10 @@ static void gen_sse(CPUX86State *env, DisasContex=
t *s, int b,
>                      tcg_gen_movi_tl(cpu_T1, 1);
>                      tcg_gen_shl_tl(cpu_T1, cpu_T1, s->A0);
>                      tcg_gen_subi_tl(cpu_T1, cpu_T1, 1);
> -                    tcg_gen_and_tl(cpu_T0, cpu_T0, cpu_T1);
> +                    tcg_gen_and_tl(s->T0, s->T0, cpu_T1);
>
> -                    gen_op_mov_reg_v(ot, reg, cpu_T0);
> -                    gen_op_update1_cc();
> +                    gen_op_mov_reg_v(ot, reg, s->T0);
> +                    gen_op_update1_cc(s);
>                      set_cc_op(s, CC_OP_LOGICB + ot);
>                  }
>                  break;
> @@ -3872,9 +3886,9 @@ static void gen_sse(CPUX86State *env, DisasContext =
*s, int b,
>                  }
>                  tcg_gen_movi_tl(s->A0, -1);
>                  tcg_gen_shl_tl(s->A0, s->A0, cpu_T1);
> -                tcg_gen_andc_tl(cpu_T0, cpu_T0, s->A0);
> -                gen_op_mov_reg_v(ot, reg, cpu_T0);
> -                gen_op_update1_cc();
> +                tcg_gen_andc_tl(s->T0, s->T0, s->A0);
> +                gen_op_mov_reg_v(ot, reg, s->T0);
> +                gen_op_update1_cc(s);
>                  set_cc_op(s, CC_OP_BMILGB + ot);
>                  break;
>
> @@ -3888,7 +3902,7 @@ static void gen_sse(CPUX86State *env, DisasContext =
*s, int b,
>                  gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
>                  switch (ot) {
>                  default:
> -                    tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_T0);
> +                    tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
>                      tcg_gen_trunc_tl_i32(cpu_tmp3_i32, cpu_regs[R_EDX]);
>                      tcg_gen_mulu2_i32(cpu_tmp2_i32, cpu_tmp3_i32,
>                                        cpu_tmp2_i32, cpu_tmp3_i32);
> @@ -3897,9 +3911,9 @@ static void gen_sse(CPUX86State *env, DisasContext =
*s, int b,
>                      break;
>  #ifdef TARGET_X86_64
>                  case MO_64:
> -                    tcg_gen_mulu2_i64(cpu_T0, cpu_T1,
> -                                      cpu_T0, cpu_regs[R_EDX]);
> -                    tcg_gen_mov_i64(cpu_regs[s->vex_v], cpu_T0);
> +                    tcg_gen_mulu2_i64(s->T0, cpu_T1,
> +                                      s->T0, cpu_regs[R_EDX]);
> +                    tcg_gen_mov_i64(cpu_regs[s->vex_v], s->T0);
>                      tcg_gen_mov_i64(cpu_regs[reg], cpu_T1);
>                      break;
>  #endif
> @@ -3921,7 +3935,7 @@ static void gen_sse(CPUX86State *env, DisasContext =
*s, int b,
>                  } else {
>                      tcg_gen_ext32u_tl(cpu_T1, cpu_regs[s->vex_v]);
>                  }
> -                gen_helper_pdep(cpu_regs[reg], cpu_T0, cpu_T1);
> +                gen_helper_pdep(cpu_regs[reg], s->T0, cpu_T1);
>                  break;
>
>              case 0x2f5: /* pext Gy, By, Ey */
> @@ -3939,7 +3953,7 @@ static void gen_sse(CPUX86State *env, DisasContext =
*s, int b,
>                  } else {
>                      tcg_gen_ext32u_tl(cpu_T1, cpu_regs[s->vex_v]);
>                  }
> -                gen_helper_pext(cpu_regs[reg], cpu_T0, cpu_T1);
> +                gen_helper_pext(cpu_regs[reg], s->T0, cpu_T1);
>                  break;
>
>              case 0x1f6: /* adcx Gy, Ey */
> @@ -3997,22 +4011,22 @@ static void gen_sse(CPUX86State *env, DisasContex=
t *s, int b,
>                          /* If we know TL is 64-bit, and we want a 32-bit
>                             result, just do everything in 64-bit arithmet=
ic.  */
>                          tcg_gen_ext32u_i64(cpu_regs[reg], cpu_regs[reg]);
> -                        tcg_gen_ext32u_i64(cpu_T0, cpu_T0);
> -                        tcg_gen_add_i64(cpu_T0, cpu_T0, cpu_regs[reg]);
> -                        tcg_gen_add_i64(cpu_T0, cpu_T0, carry_in);
> -                        tcg_gen_ext32u_i64(cpu_regs[reg], cpu_T0);
> -                        tcg_gen_shri_i64(carry_out, cpu_T0, 32);
> +                        tcg_gen_ext32u_i64(s->T0, s->T0);
> +                        tcg_gen_add_i64(s->T0, s->T0, cpu_regs[reg]);
> +                        tcg_gen_add_i64(s->T0, s->T0, carry_in);
> +                        tcg_gen_ext32u_i64(cpu_regs[reg], s->T0);
> +                        tcg_gen_shri_i64(carry_out, s->T0, 32);
>                          break;
>  #endif
>                      default:
>                          /* Otherwise compute the carry-out in two steps.=
  */
>                          zero =3D tcg_const_tl(0);
> -                        tcg_gen_add2_tl(cpu_T0, carry_out,
> -                                        cpu_T0, zero,
> +                        tcg_gen_add2_tl(s->T0, carry_out,
> +                                        s->T0, zero,
>                                          carry_in, zero);
>                          tcg_gen_add2_tl(cpu_regs[reg], carry_out,
>                                          cpu_regs[reg], carry_out,
> -                                        cpu_T0, zero);
> +                                        s->T0, zero);
>                          tcg_temp_free(zero);
>                          break;
>                      }
> @@ -4036,19 +4050,19 @@ static void gen_sse(CPUX86State *env, DisasContex=
t *s, int b,
>                      tcg_gen_andi_tl(cpu_T1, cpu_regs[s->vex_v], 31);
>                  }
>                  if (b =3D=3D 0x1f7) {
> -                    tcg_gen_shl_tl(cpu_T0, cpu_T0, cpu_T1);
> +                    tcg_gen_shl_tl(s->T0, s->T0, cpu_T1);
>                  } else if (b =3D=3D 0x2f7) {
>                      if (ot !=3D MO_64) {
> -                        tcg_gen_ext32s_tl(cpu_T0, cpu_T0);
> +                        tcg_gen_ext32s_tl(s->T0, s->T0);
>                      }
> -                    tcg_gen_sar_tl(cpu_T0, cpu_T0, cpu_T1);
> +                    tcg_gen_sar_tl(s->T0, s->T0, cpu_T1);
>                  } else {
>                      if (ot !=3D MO_64) {
> -                        tcg_gen_ext32u_tl(cpu_T0, cpu_T0);
> +                        tcg_gen_ext32u_tl(s->T0, s->T0);
>                      }
> -                    tcg_gen_shr_tl(cpu_T0, cpu_T0, cpu_T1);
> +                    tcg_gen_shr_tl(s->T0, s->T0, cpu_T1);
>                  }
> -                gen_op_mov_reg_v(ot, reg, cpu_T0);
> +                gen_op_mov_reg_v(ot, reg, s->T0);
>                  break;
>
>              case 0x0f3:
> @@ -4063,25 +4077,25 @@ static void gen_sse(CPUX86State *env, DisasContex=
t *s, int b,
>                  ot =3D mo_64_32(s->dflag);
>                  gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
>
> -                tcg_gen_mov_tl(cpu_cc_src, cpu_T0);
> +                tcg_gen_mov_tl(cpu_cc_src, s->T0);
>                  switch (reg & 7) {
>                  case 1: /* blsr By,Ey */
> -                    tcg_gen_subi_tl(cpu_T1, cpu_T0, 1);
> -                    tcg_gen_and_tl(cpu_T0, cpu_T0, cpu_T1);
> +                    tcg_gen_subi_tl(cpu_T1, s->T0, 1);
> +                    tcg_gen_and_tl(s->T0, s->T0, cpu_T1);
>                      break;
>                  case 2: /* blsmsk By,Ey */
> -                    tcg_gen_subi_tl(cpu_T1, cpu_T0, 1);
> -                    tcg_gen_xor_tl(cpu_T0, cpu_T0, cpu_T1);
> +                    tcg_gen_subi_tl(cpu_T1, s->T0, 1);
> +                    tcg_gen_xor_tl(s->T0, s->T0, cpu_T1);
>                      break;
>                  case 3: /* blsi By, Ey */
> -                    tcg_gen_neg_tl(cpu_T1, cpu_T0);
> -                    tcg_gen_and_tl(cpu_T0, cpu_T0, cpu_T1);
> +                    tcg_gen_neg_tl(cpu_T1, s->T0);
> +                    tcg_gen_and_tl(s->T0, s->T0, cpu_T1);
>                      break;
>                  default:
>                      goto unknown_op;
>                  }
> -                tcg_gen_mov_tl(cpu_cc_dst, cpu_T0);
> -                gen_op_mov_reg_v(ot, s->vex_v, cpu_T0);
> +                tcg_gen_mov_tl(cpu_cc_dst, s->T0);
> +                gen_op_mov_reg_v(ot, s->vex_v, s->T0);
>                  set_cc_op(s, CC_OP_BMILGB + ot);
>                  break;
>
> @@ -4119,22 +4133,22 @@ static void gen_sse(CPUX86State *env, DisasContex=
t *s, int b,
>                  val =3D x86_ldub_code(env, s);
>                  switch (b) {
>                  case 0x14: /* pextrb */
> -                    tcg_gen_ld8u_tl(cpu_T0, cpu_env, offsetof(CPUX86Stat=
e,
> +                    tcg_gen_ld8u_tl(s->T0, cpu_env, offsetof(CPUX86State,
>                                              xmm_regs[reg].ZMM_B(val & 15=
)));
>                      if (mod =3D=3D 3) {
> -                        gen_op_mov_reg_v(ot, rm, cpu_T0);
> +                        gen_op_mov_reg_v(ot, rm, s->T0);
>                      } else {
> -                        tcg_gen_qemu_st_tl(cpu_T0, s->A0,
> +                        tcg_gen_qemu_st_tl(s->T0, s->A0,
>                                             s->mem_index, MO_UB);
>                      }
>                      break;
>                  case 0x15: /* pextrw */
> -                    tcg_gen_ld16u_tl(cpu_T0, cpu_env, offsetof(CPUX86Sta=
te,
> +                    tcg_gen_ld16u_tl(s->T0, cpu_env, offsetof(CPUX86Stat=
e,
>                                              xmm_regs[reg].ZMM_W(val & 7)=
));
>                      if (mod =3D=3D 3) {
> -                        gen_op_mov_reg_v(ot, rm, cpu_T0);
> +                        gen_op_mov_reg_v(ot, rm, s->T0);
>                      } else {
> -                        tcg_gen_qemu_st_tl(cpu_T0, s->A0,
> +                        tcg_gen_qemu_st_tl(s->T0, s->A0,
>                                             s->mem_index, MO_LEUW);
>                      }
>                      break;
> @@ -4166,23 +4180,23 @@ static void gen_sse(CPUX86State *env, DisasContex=
t *s, int b,
>                      }
>                      break;
>                  case 0x17: /* extractps */
> -                    tcg_gen_ld32u_tl(cpu_T0, cpu_env, offsetof(CPUX86Sta=
te,
> +                    tcg_gen_ld32u_tl(s->T0, cpu_env, offsetof(CPUX86Stat=
e,
>                                              xmm_regs[reg].ZMM_L(val & 3)=
));
>                      if (mod =3D=3D 3) {
> -                        gen_op_mov_reg_v(ot, rm, cpu_T0);
> +                        gen_op_mov_reg_v(ot, rm, s->T0);
>                      } else {
> -                        tcg_gen_qemu_st_tl(cpu_T0, s->A0,
> +                        tcg_gen_qemu_st_tl(s->T0, s->A0,
>                                             s->mem_index, MO_LEUL);
>                      }
>                      break;
>                  case 0x20: /* pinsrb */
>                      if (mod =3D=3D 3) {
> -                        gen_op_mov_v_reg(MO_32, cpu_T0, rm);
> +                        gen_op_mov_v_reg(MO_32, s->T0, rm);
>                      } else {
> -                        tcg_gen_qemu_ld_tl(cpu_T0, s->A0,
> +                        tcg_gen_qemu_ld_tl(s->T0, s->A0,
>                                             s->mem_index, MO_UB);
>                      }
> -                    tcg_gen_st8_tl(cpu_T0, cpu_env, offsetof(CPUX86State,
> +                    tcg_gen_st8_tl(s->T0, cpu_env, offsetof(CPUX86State,
>                                              xmm_regs[reg].ZMM_B(val & 15=
)));
>                      break;
>                  case 0x21: /* insertps */
> @@ -4297,13 +4311,13 @@ static void gen_sse(CPUX86State *env, DisasContex=
t *s, int b,
>                  gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
>                  b =3D x86_ldub_code(env, s);
>                  if (ot =3D=3D MO_64) {
> -                    tcg_gen_rotri_tl(cpu_T0, cpu_T0, b & 63);
> +                    tcg_gen_rotri_tl(s->T0, s->T0, b & 63);
>                  } else {
> -                    tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_T0);
> +                    tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
>                      tcg_gen_rotri_i32(cpu_tmp2_i32, cpu_tmp2_i32, b & 31=
);
> -                    tcg_gen_extu_i32_tl(cpu_T0, cpu_tmp2_i32);
> +                    tcg_gen_extu_i32_tl(s->T0, cpu_tmp2_i32);
>                  }
> -                gen_op_mov_reg_v(ot, reg, cpu_T0);
> +                gen_op_mov_reg_v(ot, reg, s->T0);
>                  break;
>
>              default:
> @@ -4360,8 +4374,8 @@ static void gen_sse(CPUX86State *env, DisasContext =
*s, int b,
>                  switch (sz) {
>                  case 2:
>                      /* 32 bit access */
> -                    gen_op_ld_v(s, MO_32, cpu_T0, s->A0);
> -                    tcg_gen_st32_tl(cpu_T0, cpu_env,
> +                    gen_op_ld_v(s, MO_32, s->T0, s->A0);
> +                    tcg_gen_st32_tl(s->T0, cpu_env,
>                                      offsetof(CPUX86State,xmm_t0.ZMM_L(0)=
));
>                      break;
>                  case 3:
> @@ -4657,8 +4671,8 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>                  xor_zero:
>                      /* xor reg, reg optimisation */
>                      set_cc_op(s, CC_OP_CLR);
> -                    tcg_gen_movi_tl(cpu_T0, 0);
> -                    gen_op_mov_reg_v(ot, reg, cpu_T0);
> +                    tcg_gen_movi_tl(s->T0, 0);
> +                    gen_op_mov_reg_v(ot, reg, s->T0);
>                      break;
>                  } else {
>                      opreg =3D rm;
> @@ -4760,17 +4774,17 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>              /* For those below that handle locked memory, don't load her=
e.  */
>              if (!(s->prefix & PREFIX_LOCK)
>                  || op !=3D 2) {
> -                gen_op_ld_v(s, ot, cpu_T0, s->A0);
> +                gen_op_ld_v(s, ot, s->T0, s->A0);
>              }
>          } else {
> -            gen_op_mov_v_reg(ot, cpu_T0, rm);
> +            gen_op_mov_v_reg(ot, s->T0, rm);
>          }
>
>          switch(op) {
>          case 0: /* test */
>              val =3D insn_get(env, s, ot);
>              tcg_gen_movi_tl(cpu_T1, val);
> -            gen_op_testl_T0_T1_cc();
> +            gen_op_testl_T0_T1_cc(s);
>              set_cc_op(s, CC_OP_LOGICB + ot);
>              break;
>          case 2: /* not */
> @@ -4778,15 +4792,15 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>                  if (mod =3D=3D 3) {
>                      goto illegal_op;
>                  }
> -                tcg_gen_movi_tl(cpu_T0, ~0);
> -                tcg_gen_atomic_xor_fetch_tl(cpu_T0, s->A0, cpu_T0,
> +                tcg_gen_movi_tl(s->T0, ~0);
> +                tcg_gen_atomic_xor_fetch_tl(s->T0, s->A0, s->T0,
>                                              s->mem_index, ot | MO_LE);
>              } else {
> -                tcg_gen_not_tl(cpu_T0, cpu_T0);
> +                tcg_gen_not_tl(s->T0, s->T0);
>                  if (mod !=3D 3) {
> -                    gen_op_st_v(s, ot, cpu_T0, s->A0);
> +                    gen_op_st_v(s, ot, s->T0, s->A0);
>                  } else {
> -                    gen_op_mov_reg_v(ot, rm, cpu_T0);
> +                    gen_op_mov_reg_v(ot, rm, s->T0);
>                  }
>              }
>              break;
> @@ -4803,7 +4817,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>                  label1 =3D gen_new_label();
>
>                  tcg_gen_mov_tl(a0, s->A0);
> -                tcg_gen_mov_tl(t0, cpu_T0);
> +                tcg_gen_mov_tl(t0, s->T0);
>
>                  gen_set_label(label1);
>                  t1 =3D tcg_temp_new();
> @@ -4817,14 +4831,14 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>
>                  tcg_temp_free(t2);
>                  tcg_temp_free(a0);
> -                tcg_gen_mov_tl(cpu_T0, t0);
> +                tcg_gen_mov_tl(s->T0, t0);
>                  tcg_temp_free(t0);
>              } else {
> -                tcg_gen_neg_tl(cpu_T0, cpu_T0);
> +                tcg_gen_neg_tl(s->T0, s->T0);
>                  if (mod !=3D 3) {
> -                    gen_op_st_v(s, ot, cpu_T0, s->A0);
> +                    gen_op_st_v(s, ot, s->T0, s->A0);
>                  } else {
> -                    gen_op_mov_reg_v(ot, rm, cpu_T0);
> +                    gen_op_mov_reg_v(ot, rm, s->T0);
>                  }
>              }
>              gen_op_update_neg_cc(s);
> @@ -4834,31 +4848,31 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>              switch(ot) {
>              case MO_8:
>                  gen_op_mov_v_reg(MO_8, cpu_T1, R_EAX);
> -                tcg_gen_ext8u_tl(cpu_T0, cpu_T0);
> +                tcg_gen_ext8u_tl(s->T0, s->T0);
>                  tcg_gen_ext8u_tl(cpu_T1, cpu_T1);
>                  /* XXX: use 32 bit mul which could be faster */
> -                tcg_gen_mul_tl(cpu_T0, cpu_T0, cpu_T1);
> -                gen_op_mov_reg_v(MO_16, R_EAX, cpu_T0);
> -                tcg_gen_mov_tl(cpu_cc_dst, cpu_T0);
> -                tcg_gen_andi_tl(cpu_cc_src, cpu_T0, 0xff00);
> +                tcg_gen_mul_tl(s->T0, s->T0, cpu_T1);
> +                gen_op_mov_reg_v(MO_16, R_EAX, s->T0);
> +                tcg_gen_mov_tl(cpu_cc_dst, s->T0);
> +                tcg_gen_andi_tl(cpu_cc_src, s->T0, 0xff00);
>                  set_cc_op(s, CC_OP_MULB);
>                  break;
>              case MO_16:
>                  gen_op_mov_v_reg(MO_16, cpu_T1, R_EAX);
> -                tcg_gen_ext16u_tl(cpu_T0, cpu_T0);
> +                tcg_gen_ext16u_tl(s->T0, s->T0);
>                  tcg_gen_ext16u_tl(cpu_T1, cpu_T1);
>                  /* XXX: use 32 bit mul which could be faster */
> -                tcg_gen_mul_tl(cpu_T0, cpu_T0, cpu_T1);
> -                gen_op_mov_reg_v(MO_16, R_EAX, cpu_T0);
> -                tcg_gen_mov_tl(cpu_cc_dst, cpu_T0);
> -                tcg_gen_shri_tl(cpu_T0, cpu_T0, 16);
> -                gen_op_mov_reg_v(MO_16, R_EDX, cpu_T0);
> -                tcg_gen_mov_tl(cpu_cc_src, cpu_T0);
> +                tcg_gen_mul_tl(s->T0, s->T0, cpu_T1);
> +                gen_op_mov_reg_v(MO_16, R_EAX, s->T0);
> +                tcg_gen_mov_tl(cpu_cc_dst, s->T0);
> +                tcg_gen_shri_tl(s->T0, s->T0, 16);
> +                gen_op_mov_reg_v(MO_16, R_EDX, s->T0);
> +                tcg_gen_mov_tl(cpu_cc_src, s->T0);
>                  set_cc_op(s, CC_OP_MULW);
>                  break;
>              default:
>              case MO_32:
> -                tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_T0);
> +                tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
>                  tcg_gen_trunc_tl_i32(cpu_tmp3_i32, cpu_regs[R_EAX]);
>                  tcg_gen_mulu2_i32(cpu_tmp2_i32, cpu_tmp3_i32,
>                                    cpu_tmp2_i32, cpu_tmp3_i32);
> @@ -4871,7 +4885,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>  #ifdef TARGET_X86_64
>              case MO_64:
>                  tcg_gen_mulu2_i64(cpu_regs[R_EAX], cpu_regs[R_EDX],
> -                                  cpu_T0, cpu_regs[R_EAX]);
> +                                  s->T0, cpu_regs[R_EAX]);
>                  tcg_gen_mov_tl(cpu_cc_dst, cpu_regs[R_EAX]);
>                  tcg_gen_mov_tl(cpu_cc_src, cpu_regs[R_EDX]);
>                  set_cc_op(s, CC_OP_MULQ);
> @@ -4883,33 +4897,33 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>              switch(ot) {
>              case MO_8:
>                  gen_op_mov_v_reg(MO_8, cpu_T1, R_EAX);
> -                tcg_gen_ext8s_tl(cpu_T0, cpu_T0);
> +                tcg_gen_ext8s_tl(s->T0, s->T0);
>                  tcg_gen_ext8s_tl(cpu_T1, cpu_T1);
>                  /* XXX: use 32 bit mul which could be faster */
> -                tcg_gen_mul_tl(cpu_T0, cpu_T0, cpu_T1);
> -                gen_op_mov_reg_v(MO_16, R_EAX, cpu_T0);
> -                tcg_gen_mov_tl(cpu_cc_dst, cpu_T0);
> -                tcg_gen_ext8s_tl(cpu_tmp0, cpu_T0);
> -                tcg_gen_sub_tl(cpu_cc_src, cpu_T0, cpu_tmp0);
> +                tcg_gen_mul_tl(s->T0, s->T0, cpu_T1);
> +                gen_op_mov_reg_v(MO_16, R_EAX, s->T0);
> +                tcg_gen_mov_tl(cpu_cc_dst, s->T0);
> +                tcg_gen_ext8s_tl(cpu_tmp0, s->T0);
> +                tcg_gen_sub_tl(cpu_cc_src, s->T0, cpu_tmp0);
>                  set_cc_op(s, CC_OP_MULB);
>                  break;
>              case MO_16:
>                  gen_op_mov_v_reg(MO_16, cpu_T1, R_EAX);
> -                tcg_gen_ext16s_tl(cpu_T0, cpu_T0);
> +                tcg_gen_ext16s_tl(s->T0, s->T0);
>                  tcg_gen_ext16s_tl(cpu_T1, cpu_T1);
>                  /* XXX: use 32 bit mul which could be faster */
> -                tcg_gen_mul_tl(cpu_T0, cpu_T0, cpu_T1);
> -                gen_op_mov_reg_v(MO_16, R_EAX, cpu_T0);
> -                tcg_gen_mov_tl(cpu_cc_dst, cpu_T0);
> -                tcg_gen_ext16s_tl(cpu_tmp0, cpu_T0);
> -                tcg_gen_sub_tl(cpu_cc_src, cpu_T0, cpu_tmp0);
> -                tcg_gen_shri_tl(cpu_T0, cpu_T0, 16);
> -                gen_op_mov_reg_v(MO_16, R_EDX, cpu_T0);
> +                tcg_gen_mul_tl(s->T0, s->T0, cpu_T1);
> +                gen_op_mov_reg_v(MO_16, R_EAX, s->T0);
> +                tcg_gen_mov_tl(cpu_cc_dst, s->T0);
> +                tcg_gen_ext16s_tl(cpu_tmp0, s->T0);
> +                tcg_gen_sub_tl(cpu_cc_src, s->T0, cpu_tmp0);
> +                tcg_gen_shri_tl(s->T0, s->T0, 16);
> +                gen_op_mov_reg_v(MO_16, R_EDX, s->T0);
>                  set_cc_op(s, CC_OP_MULW);
>                  break;
>              default:
>              case MO_32:
> -                tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_T0);
> +                tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
>                  tcg_gen_trunc_tl_i32(cpu_tmp3_i32, cpu_regs[R_EAX]);
>                  tcg_gen_muls2_i32(cpu_tmp2_i32, cpu_tmp3_i32,
>                                    cpu_tmp2_i32, cpu_tmp3_i32);
> @@ -4924,7 +4938,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>  #ifdef TARGET_X86_64
>              case MO_64:
>                  tcg_gen_muls2_i64(cpu_regs[R_EAX], cpu_regs[R_EDX],
> -                                  cpu_T0, cpu_regs[R_EAX]);
> +                                  s->T0, cpu_regs[R_EAX]);
>                  tcg_gen_mov_tl(cpu_cc_dst, cpu_regs[R_EAX]);
>                  tcg_gen_sari_tl(cpu_cc_src, cpu_regs[R_EAX], 63);
>                  tcg_gen_sub_tl(cpu_cc_src, cpu_cc_src, cpu_regs[R_EDX]);
> @@ -4936,18 +4950,18 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>          case 6: /* div */
>              switch(ot) {
>              case MO_8:
> -                gen_helper_divb_AL(cpu_env, cpu_T0);
> +                gen_helper_divb_AL(cpu_env, s->T0);
>                  break;
>              case MO_16:
> -                gen_helper_divw_AX(cpu_env, cpu_T0);
> +                gen_helper_divw_AX(cpu_env, s->T0);
>                  break;
>              default:
>              case MO_32:
> -                gen_helper_divl_EAX(cpu_env, cpu_T0);
> +                gen_helper_divl_EAX(cpu_env, s->T0);
>                  break;
>  #ifdef TARGET_X86_64
>              case MO_64:
> -                gen_helper_divq_EAX(cpu_env, cpu_T0);
> +                gen_helper_divq_EAX(cpu_env, s->T0);
>                  break;
>  #endif
>              }
> @@ -4955,18 +4969,18 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>          case 7: /* idiv */
>              switch(ot) {
>              case MO_8:
> -                gen_helper_idivb_AL(cpu_env, cpu_T0);
> +                gen_helper_idivb_AL(cpu_env, s->T0);
>                  break;
>              case MO_16:
> -                gen_helper_idivw_AX(cpu_env, cpu_T0);
> +                gen_helper_idivw_AX(cpu_env, s->T0);
>                  break;
>              default:
>              case MO_32:
> -                gen_helper_idivl_EAX(cpu_env, cpu_T0);
> +                gen_helper_idivl_EAX(cpu_env, s->T0);
>                  break;
>  #ifdef TARGET_X86_64
>              case MO_64:
> -                gen_helper_idivq_EAX(cpu_env, cpu_T0);
> +                gen_helper_idivq_EAX(cpu_env, s->T0);
>                  break;
>  #endif
>              }
> @@ -5001,9 +5015,9 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>          if (mod !=3D 3) {
>              gen_lea_modrm(env, s, modrm);
>              if (op >=3D 2 && op !=3D 3 && op !=3D 5)
> -                gen_op_ld_v(s, ot, cpu_T0, s->A0);
> +                gen_op_ld_v(s, ot, s->T0, s->A0);
>          } else {
> -            gen_op_mov_v_reg(ot, cpu_T0, rm);
> +            gen_op_mov_v_reg(ot, s->T0, rm);
>          }
>
>          switch(op) {
> @@ -5024,27 +5038,27 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>          case 2: /* call Ev */
>              /* XXX: optimize if memory (no 'and' is necessary) */
>              if (dflag =3D=3D MO_16) {
> -                tcg_gen_ext16u_tl(cpu_T0, cpu_T0);
> +                tcg_gen_ext16u_tl(s->T0, s->T0);
>              }
>              next_eip =3D s->pc - s->cs_base;
>              tcg_gen_movi_tl(cpu_T1, next_eip);
>              gen_push_v(s, cpu_T1);
> -            gen_op_jmp_v(cpu_T0);
> +            gen_op_jmp_v(s->T0);
>              gen_bnd_jmp(s);
> -            gen_jr(s, cpu_T0);
> +            gen_jr(s, s->T0);
>              break;
>          case 3: /* lcall Ev */
>              gen_op_ld_v(s, ot, cpu_T1, s->A0);
>              gen_add_A0_im(s, 1 << ot);
> -            gen_op_ld_v(s, MO_16, cpu_T0, s->A0);
> +            gen_op_ld_v(s, MO_16, s->T0, s->A0);
>          do_lcall:
>              if (s->pe && !s->vm86) {
> -                tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_T0);
> +                tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
>                  gen_helper_lcall_protected(cpu_env, cpu_tmp2_i32, cpu_T1,
>                                             tcg_const_i32(dflag - 1),
>                                             tcg_const_tl(s->pc - s->cs_ba=
se));
>              } else {
> -                tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_T0);
> +                tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
>                  gen_helper_lcall_real(cpu_env, cpu_tmp2_i32, cpu_T1,
>                                        tcg_const_i32(dflag - 1),
>                                        tcg_const_i32(s->pc - s->cs_base));
> @@ -5054,30 +5068,30 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>              break;
>          case 4: /* jmp Ev */
>              if (dflag =3D=3D MO_16) {
> -                tcg_gen_ext16u_tl(cpu_T0, cpu_T0);
> +                tcg_gen_ext16u_tl(s->T0, s->T0);
>              }
> -            gen_op_jmp_v(cpu_T0);
> +            gen_op_jmp_v(s->T0);
>              gen_bnd_jmp(s);
> -            gen_jr(s, cpu_T0);
> +            gen_jr(s, s->T0);
>              break;
>          case 5: /* ljmp Ev */
>              gen_op_ld_v(s, ot, cpu_T1, s->A0);
>              gen_add_A0_im(s, 1 << ot);
> -            gen_op_ld_v(s, MO_16, cpu_T0, s->A0);
> +            gen_op_ld_v(s, MO_16, s->T0, s->A0);
>          do_ljmp:
>              if (s->pe && !s->vm86) {
> -                tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_T0);
> +                tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
>                  gen_helper_ljmp_protected(cpu_env, cpu_tmp2_i32, cpu_T1,
>                                            tcg_const_tl(s->pc - s->cs_bas=
e));
>              } else {
> -                gen_op_movl_seg_T0_vm(R_CS);
> +                gen_op_movl_seg_T0_vm(s, R_CS);
>                  gen_op_jmp_v(cpu_T1);
>              }
>              tcg_gen_ld_tl(cpu_tmp4, cpu_env, offsetof(CPUX86State, eip));
>              gen_jr(s, cpu_tmp4);
>              break;
>          case 6: /* push Ev */
> -            gen_push_v(s, cpu_T0);
> +            gen_push_v(s, s->T0);
>              break;
>          default:
>              goto unknown_op;
> @@ -5093,7 +5107,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>
>          gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
>          gen_op_mov_v_reg(ot, cpu_T1, reg);
> -        gen_op_testl_T0_T1_cc();
> +        gen_op_testl_T0_T1_cc(s);
>          set_cc_op(s, CC_OP_LOGICB + ot);
>          break;
>
> @@ -5102,9 +5116,9 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>          ot =3D mo_b_d(b, dflag);
>          val =3D insn_get(env, s, ot);
>
> -        gen_op_mov_v_reg(ot, cpu_T0, OR_EAX);
> +        gen_op_mov_v_reg(ot, s->T0, OR_EAX);
>          tcg_gen_movi_tl(cpu_T1, val);
> -        gen_op_testl_T0_T1_cc();
> +        gen_op_testl_T0_T1_cc(s);
>          set_cc_op(s, CC_OP_LOGICB + ot);
>          break;
>
> @@ -5112,20 +5126,20 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>          switch (dflag) {
>  #ifdef TARGET_X86_64
>          case MO_64:
> -            gen_op_mov_v_reg(MO_32, cpu_T0, R_EAX);
> -            tcg_gen_ext32s_tl(cpu_T0, cpu_T0);
> -            gen_op_mov_reg_v(MO_64, R_EAX, cpu_T0);
> +            gen_op_mov_v_reg(MO_32, s->T0, R_EAX);
> +            tcg_gen_ext32s_tl(s->T0, s->T0);
> +            gen_op_mov_reg_v(MO_64, R_EAX, s->T0);
>              break;
>  #endif
>          case MO_32:
> -            gen_op_mov_v_reg(MO_16, cpu_T0, R_EAX);
> -            tcg_gen_ext16s_tl(cpu_T0, cpu_T0);
> -            gen_op_mov_reg_v(MO_32, R_EAX, cpu_T0);
> +            gen_op_mov_v_reg(MO_16, s->T0, R_EAX);
> +            tcg_gen_ext16s_tl(s->T0, s->T0);
> +            gen_op_mov_reg_v(MO_32, R_EAX, s->T0);
>              break;
>          case MO_16:
> -            gen_op_mov_v_reg(MO_8, cpu_T0, R_EAX);
> -            tcg_gen_ext8s_tl(cpu_T0, cpu_T0);
> -            gen_op_mov_reg_v(MO_16, R_EAX, cpu_T0);
> +            gen_op_mov_v_reg(MO_8, s->T0, R_EAX);
> +            tcg_gen_ext8s_tl(s->T0, s->T0);
> +            gen_op_mov_reg_v(MO_16, R_EAX, s->T0);
>              break;
>          default:
>              tcg_abort();
> @@ -5135,22 +5149,22 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>          switch (dflag) {
>  #ifdef TARGET_X86_64
>          case MO_64:
> -            gen_op_mov_v_reg(MO_64, cpu_T0, R_EAX);
> -            tcg_gen_sari_tl(cpu_T0, cpu_T0, 63);
> -            gen_op_mov_reg_v(MO_64, R_EDX, cpu_T0);
> +            gen_op_mov_v_reg(MO_64, s->T0, R_EAX);
> +            tcg_gen_sari_tl(s->T0, s->T0, 63);
> +            gen_op_mov_reg_v(MO_64, R_EDX, s->T0);
>              break;
>  #endif
>          case MO_32:
> -            gen_op_mov_v_reg(MO_32, cpu_T0, R_EAX);
> -            tcg_gen_ext32s_tl(cpu_T0, cpu_T0);
> -            tcg_gen_sari_tl(cpu_T0, cpu_T0, 31);
> -            gen_op_mov_reg_v(MO_32, R_EDX, cpu_T0);
> +            gen_op_mov_v_reg(MO_32, s->T0, R_EAX);
> +            tcg_gen_ext32s_tl(s->T0, s->T0);
> +            tcg_gen_sari_tl(s->T0, s->T0, 31);
> +            gen_op_mov_reg_v(MO_32, R_EDX, s->T0);
>              break;
>          case MO_16:
> -            gen_op_mov_v_reg(MO_16, cpu_T0, R_EAX);
> -            tcg_gen_ext16s_tl(cpu_T0, cpu_T0);
> -            tcg_gen_sari_tl(cpu_T0, cpu_T0, 15);
> -            gen_op_mov_reg_v(MO_16, R_EDX, cpu_T0);
> +            gen_op_mov_v_reg(MO_16, s->T0, R_EAX);
> +            tcg_gen_ext16s_tl(s->T0, s->T0);
> +            tcg_gen_sari_tl(s->T0, s->T0, 15);
> +            gen_op_mov_reg_v(MO_16, R_EDX, s->T0);
>              break;
>          default:
>              tcg_abort();
> @@ -5179,14 +5193,14 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>          switch (ot) {
>  #ifdef TARGET_X86_64
>          case MO_64:
> -            tcg_gen_muls2_i64(cpu_regs[reg], cpu_T1, cpu_T0, cpu_T1);
> +            tcg_gen_muls2_i64(cpu_regs[reg], cpu_T1, s->T0, cpu_T1);
>              tcg_gen_mov_tl(cpu_cc_dst, cpu_regs[reg]);
>              tcg_gen_sari_tl(cpu_cc_src, cpu_cc_dst, 63);
>              tcg_gen_sub_tl(cpu_cc_src, cpu_cc_src, cpu_T1);
>              break;
>  #endif
>          case MO_32:
> -            tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_T0);
> +            tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
>              tcg_gen_trunc_tl_i32(cpu_tmp3_i32, cpu_T1);
>              tcg_gen_muls2_i32(cpu_tmp2_i32, cpu_tmp3_i32,
>                                cpu_tmp2_i32, cpu_tmp3_i32);
> @@ -5197,14 +5211,14 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>              tcg_gen_extu_i32_tl(cpu_cc_src, cpu_tmp2_i32);
>              break;
>          default:
> -            tcg_gen_ext16s_tl(cpu_T0, cpu_T0);
> +            tcg_gen_ext16s_tl(s->T0, s->T0);
>              tcg_gen_ext16s_tl(cpu_T1, cpu_T1);
>              /* XXX: use 32 bit mul which could be faster */
> -            tcg_gen_mul_tl(cpu_T0, cpu_T0, cpu_T1);
> -            tcg_gen_mov_tl(cpu_cc_dst, cpu_T0);
> -            tcg_gen_ext16s_tl(cpu_tmp0, cpu_T0);
> -            tcg_gen_sub_tl(cpu_cc_src, cpu_T0, cpu_tmp0);
> -            gen_op_mov_reg_v(ot, reg, cpu_T0);
> +            tcg_gen_mul_tl(s->T0, s->T0, cpu_T1);
> +            tcg_gen_mov_tl(cpu_cc_dst, s->T0);
> +            tcg_gen_ext16s_tl(cpu_tmp0, s->T0);
> +            tcg_gen_sub_tl(cpu_cc_src, s->T0, cpu_tmp0);
> +            gen_op_mov_reg_v(ot, reg, s->T0);
>              break;
>          }
>          set_cc_op(s, CC_OP_MULB + ot);
> @@ -5215,27 +5229,27 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>          modrm =3D x86_ldub_code(env, s);
>          reg =3D ((modrm >> 3) & 7) | rex_r;
>          mod =3D (modrm >> 6) & 3;
> -        gen_op_mov_v_reg(ot, cpu_T0, reg);
> +        gen_op_mov_v_reg(ot, s->T0, reg);
>          if (mod =3D=3D 3) {
>              rm =3D (modrm & 7) | REX_B(s);
>              gen_op_mov_v_reg(ot, cpu_T1, rm);
> -            tcg_gen_add_tl(cpu_T0, cpu_T0, cpu_T1);
> +            tcg_gen_add_tl(s->T0, s->T0, cpu_T1);
>              gen_op_mov_reg_v(ot, reg, cpu_T1);
> -            gen_op_mov_reg_v(ot, rm, cpu_T0);
> +            gen_op_mov_reg_v(ot, rm, s->T0);
>          } else {
>              gen_lea_modrm(env, s, modrm);
>              if (s->prefix & PREFIX_LOCK) {
> -                tcg_gen_atomic_fetch_add_tl(cpu_T1, s->A0, cpu_T0,
> +                tcg_gen_atomic_fetch_add_tl(cpu_T1, s->A0, s->T0,
>                                              s->mem_index, ot | MO_LE);
> -                tcg_gen_add_tl(cpu_T0, cpu_T0, cpu_T1);
> +                tcg_gen_add_tl(s->T0, s->T0, cpu_T1);
>              } else {
>                  gen_op_ld_v(s, ot, cpu_T1, s->A0);
> -                tcg_gen_add_tl(cpu_T0, cpu_T0, cpu_T1);
> -                gen_op_st_v(s, ot, cpu_T0, s->A0);
> +                tcg_gen_add_tl(s->T0, s->T0, cpu_T1);
> +                gen_op_st_v(s, ot, s->T0, s->A0);
>              }
>              gen_op_mov_reg_v(ot, reg, cpu_T1);
>          }
> -        gen_op_update2_cc();
> +        gen_op_update2_cc(s);
>          set_cc_op(s, CC_OP_ADDB + ot);
>          break;
>      case 0x1b0:
> @@ -5328,14 +5342,14 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>          /**************************/
>          /* push/pop */
>      case 0x50 ... 0x57: /* push */
> -        gen_op_mov_v_reg(MO_32, cpu_T0, (b & 7) | REX_B(s));
> -        gen_push_v(s, cpu_T0);
> +        gen_op_mov_v_reg(MO_32, s->T0, (b & 7) | REX_B(s));
> +        gen_push_v(s, s->T0);
>          break;
>      case 0x58 ... 0x5f: /* pop */
>          ot =3D gen_pop_T0(s);
>          /* NOTE: order is important for pop %sp */
>          gen_pop_update(s, ot);
> -        gen_op_mov_reg_v(ot, (b & 7) | REX_B(s), cpu_T0);
> +        gen_op_mov_reg_v(ot, (b & 7) | REX_B(s), s->T0);
>          break;
>      case 0x60: /* pusha */
>          if (CODE64(s))
> @@ -5354,8 +5368,8 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>              val =3D insn_get(env, s, ot);
>          else
>              val =3D (int8_t)insn_get(env, s, MO_8);
> -        tcg_gen_movi_tl(cpu_T0, val);
> -        gen_push_v(s, cpu_T0);
> +        tcg_gen_movi_tl(s->T0, val);
> +        gen_push_v(s, s->T0);
>          break;
>      case 0x8f: /* pop Ev */
>          modrm =3D x86_ldub_code(env, s);
> @@ -5365,7 +5379,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>              /* NOTE: order is important for pop %sp */
>              gen_pop_update(s, ot);
>              rm =3D (modrm & 7) | REX_B(s);
> -            gen_op_mov_reg_v(ot, rm, cpu_T0);
> +            gen_op_mov_reg_v(ot, rm, s->T0);
>          } else {
>              /* NOTE: order is important too for MMU exceptions */
>              s->popl_esp_hack =3D 1 << ot;
> @@ -5391,13 +5405,13 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>      case 0x1e: /* push ds */
>          if (CODE64(s))
>              goto illegal_op;
> -        gen_op_movl_T0_seg(b >> 3);
> -        gen_push_v(s, cpu_T0);
> +        gen_op_movl_T0_seg(s, b >> 3);
> +        gen_push_v(s, s->T0);
>          break;
>      case 0x1a0: /* push fs */
>      case 0x1a8: /* push gs */
> -        gen_op_movl_T0_seg((b >> 3) & 7);
> -        gen_push_v(s, cpu_T0);
> +        gen_op_movl_T0_seg(s, (b >> 3) & 7);
> +        gen_push_v(s, s->T0);
>          break;
>      case 0x07: /* pop es */
>      case 0x17: /* pop ss */
> @@ -5451,11 +5465,11 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>              gen_lea_modrm(env, s, modrm);
>          }
>          val =3D insn_get(env, s, ot);
> -        tcg_gen_movi_tl(cpu_T0, val);
> +        tcg_gen_movi_tl(s->T0, val);
>          if (mod !=3D 3) {
> -            gen_op_st_v(s, ot, cpu_T0, s->A0);
> +            gen_op_st_v(s, ot, s->T0, s->A0);
>          } else {
> -            gen_op_mov_reg_v(ot, (modrm & 7) | REX_B(s), cpu_T0);
> +            gen_op_mov_reg_v(ot, (modrm & 7) | REX_B(s), s->T0);
>          }
>          break;
>      case 0x8a:
> @@ -5465,7 +5479,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>          reg =3D ((modrm >> 3) & 7) | rex_r;
>
>          gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
> -        gen_op_mov_reg_v(ot, reg, cpu_T0);
> +        gen_op_mov_reg_v(ot, reg, s->T0);
>          break;
>      case 0x8e: /* mov seg, Gv */
>          modrm =3D x86_ldub_code(env, s);
> @@ -5491,7 +5505,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>          mod =3D (modrm >> 6) & 3;
>          if (reg >=3D 6)
>              goto illegal_op;
> -        gen_op_movl_T0_seg(reg);
> +        gen_op_movl_T0_seg(s, reg);
>          ot =3D mod =3D=3D 3 ? dflag : MO_16;
>          gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 1);
>          break;
> @@ -5518,30 +5532,30 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>
>              if (mod =3D=3D 3) {
>                  if (s_ot =3D=3D MO_SB && byte_reg_is_xH(rm)) {
> -                    tcg_gen_sextract_tl(cpu_T0, cpu_regs[rm - 4], 8, 8);
> +                    tcg_gen_sextract_tl(s->T0, cpu_regs[rm - 4], 8, 8);
>                  } else {
> -                    gen_op_mov_v_reg(ot, cpu_T0, rm);
> +                    gen_op_mov_v_reg(ot, s->T0, rm);
>                      switch (s_ot) {
>                      case MO_UB:
> -                        tcg_gen_ext8u_tl(cpu_T0, cpu_T0);
> +                        tcg_gen_ext8u_tl(s->T0, s->T0);
>                          break;
>                      case MO_SB:
> -                        tcg_gen_ext8s_tl(cpu_T0, cpu_T0);
> +                        tcg_gen_ext8s_tl(s->T0, s->T0);
>                          break;
>                      case MO_UW:
> -                        tcg_gen_ext16u_tl(cpu_T0, cpu_T0);
> +                        tcg_gen_ext16u_tl(s->T0, s->T0);
>                          break;
>                      default:
>                      case MO_SW:
> -                        tcg_gen_ext16s_tl(cpu_T0, cpu_T0);
> +                        tcg_gen_ext16s_tl(s->T0, s->T0);
>                          break;
>                      }
>                  }
> -                gen_op_mov_reg_v(d_ot, reg, cpu_T0);
> +                gen_op_mov_reg_v(d_ot, reg, s->T0);
>              } else {
>                  gen_lea_modrm(env, s, modrm);
> -                gen_op_ld_v(s, s_ot, cpu_T0, s->A0);
> -                gen_op_mov_reg_v(d_ot, reg, cpu_T0);
> +                gen_op_ld_v(s, s_ot, s->T0, s->A0);
> +                gen_op_mov_reg_v(d_ot, reg, s->T0);
>              }
>          }
>          break;
> @@ -5581,27 +5595,27 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>              tcg_gen_movi_tl(s->A0, offset_addr);
>              gen_add_A0_ds_seg(s);
>              if ((b & 2) =3D=3D 0) {
> -                gen_op_ld_v(s, ot, cpu_T0, s->A0);
> -                gen_op_mov_reg_v(ot, R_EAX, cpu_T0);
> +                gen_op_ld_v(s, ot, s->T0, s->A0);
> +                gen_op_mov_reg_v(ot, R_EAX, s->T0);
>              } else {
> -                gen_op_mov_v_reg(ot, cpu_T0, R_EAX);
> -                gen_op_st_v(s, ot, cpu_T0, s->A0);
> +                gen_op_mov_v_reg(ot, s->T0, R_EAX);
> +                gen_op_st_v(s, ot, s->T0, s->A0);
>              }
>          }
>          break;
>      case 0xd7: /* xlat */
>          tcg_gen_mov_tl(s->A0, cpu_regs[R_EBX]);
> -        tcg_gen_ext8u_tl(cpu_T0, cpu_regs[R_EAX]);
> -        tcg_gen_add_tl(s->A0, s->A0, cpu_T0);
> +        tcg_gen_ext8u_tl(s->T0, cpu_regs[R_EAX]);
> +        tcg_gen_add_tl(s->A0, s->A0, s->T0);
>          gen_extu(s->aflag, s->A0);
>          gen_add_A0_ds_seg(s);
> -        gen_op_ld_v(s, MO_8, cpu_T0, s->A0);
> -        gen_op_mov_reg_v(MO_8, R_EAX, cpu_T0);
> +        gen_op_ld_v(s, MO_8, s->T0, s->A0);
> +        gen_op_mov_reg_v(MO_8, R_EAX, s->T0);
>          break;
>      case 0xb0 ... 0xb7: /* mov R, Ib */
>          val =3D insn_get(env, s, MO_8);
> -        tcg_gen_movi_tl(cpu_T0, val);
> -        gen_op_mov_reg_v(MO_8, (b & 7) | REX_B(s), cpu_T0);
> +        tcg_gen_movi_tl(s->T0, val);
> +        gen_op_mov_reg_v(MO_8, (b & 7) | REX_B(s), s->T0);
>          break;
>      case 0xb8 ... 0xbf: /* mov R, Iv */
>  #ifdef TARGET_X86_64
> @@ -5610,16 +5624,16 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>              /* 64 bit case */
>              tmp =3D x86_ldq_code(env, s);
>              reg =3D (b & 7) | REX_B(s);
> -            tcg_gen_movi_tl(cpu_T0, tmp);
> -            gen_op_mov_reg_v(MO_64, reg, cpu_T0);
> +            tcg_gen_movi_tl(s->T0, tmp);
> +            gen_op_mov_reg_v(MO_64, reg, s->T0);
>          } else
>  #endif
>          {
>              ot =3D dflag;
>              val =3D insn_get(env, s, ot);
>              reg =3D (b & 7) | REX_B(s);
> -            tcg_gen_movi_tl(cpu_T0, val);
> -            gen_op_mov_reg_v(ot, reg, cpu_T0);
> +            tcg_gen_movi_tl(s->T0, val);
> +            gen_op_mov_reg_v(ot, reg, s->T0);
>          }
>          break;
>
> @@ -5638,15 +5652,15 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>          if (mod =3D=3D 3) {
>              rm =3D (modrm & 7) | REX_B(s);
>          do_xchg_reg:
> -            gen_op_mov_v_reg(ot, cpu_T0, reg);
> +            gen_op_mov_v_reg(ot, s->T0, reg);
>              gen_op_mov_v_reg(ot, cpu_T1, rm);
> -            gen_op_mov_reg_v(ot, rm, cpu_T0);
> +            gen_op_mov_reg_v(ot, rm, s->T0);
>              gen_op_mov_reg_v(ot, reg, cpu_T1);
>          } else {
>              gen_lea_modrm(env, s, modrm);
> -            gen_op_mov_v_reg(ot, cpu_T0, reg);
> +            gen_op_mov_v_reg(ot, s->T0, reg);
>              /* for xchg, lock is implicit */
> -            tcg_gen_atomic_xchg_tl(cpu_T1, s->A0, cpu_T0,
> +            tcg_gen_atomic_xchg_tl(cpu_T1, s->A0, s->T0,
>                                     s->mem_index, ot | MO_LE);
>              gen_op_mov_reg_v(ot, reg, cpu_T1);
>          }
> @@ -5678,7 +5692,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>          gen_op_ld_v(s, ot, cpu_T1, s->A0);
>          gen_add_A0_im(s, 1 << ot);
>          /* load the segment first to handle exceptions properly */
> -        gen_op_ld_v(s, MO_16, cpu_T0, s->A0);
> +        gen_op_ld_v(s, MO_16, s->T0, s->A0);
>          gen_movl_seg_T0(s, op);
>          /* then put the data */
>          gen_op_mov_reg_v(ot, reg, cpu_T1);
> @@ -6220,8 +6234,8 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>                  switch(rm) {
>                  case 0:
>                      gen_helper_fnstsw(cpu_tmp2_i32, cpu_env);
> -                    tcg_gen_extu_i32_tl(cpu_T0, cpu_tmp2_i32);
> -                    gen_op_mov_reg_v(MO_16, R_EAX, cpu_T0);
> +                    tcg_gen_extu_i32_tl(s->T0, cpu_tmp2_i32);
> +                    gen_op_mov_reg_v(MO_16, R_EAX, s->T0);
>                      break;
>                  default:
>                      goto unknown_op;
> @@ -6331,7 +6345,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>      case 0x6c: /* insS */
>      case 0x6d:
>          ot =3D mo_b_d32(b, dflag);
> -        tcg_gen_ext16u_tl(cpu_T0, cpu_regs[R_EDX]);
> +        tcg_gen_ext16u_tl(s->T0, cpu_regs[R_EDX]);
>          gen_check_io(s, ot, pc_start - s->cs_base,
>                       SVM_IOIO_TYPE_MASK | svm_is_rep(prefixes) | 4);
>          if (prefixes & (PREFIX_REPZ | PREFIX_REPNZ)) {
> @@ -6346,7 +6360,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>      case 0x6e: /* outsS */
>      case 0x6f:
>          ot =3D mo_b_d32(b, dflag);
> -        tcg_gen_ext16u_tl(cpu_T0, cpu_regs[R_EDX]);
> +        tcg_gen_ext16u_tl(s->T0, cpu_regs[R_EDX]);
>          gen_check_io(s, ot, pc_start - s->cs_base,
>                       svm_is_rep(prefixes) | 4);
>          if (prefixes & (PREFIX_REPZ | PREFIX_REPNZ)) {
> @@ -6366,7 +6380,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>      case 0xe5:
>          ot =3D mo_b_d32(b, dflag);
>          val =3D x86_ldub_code(env, s);
> -        tcg_gen_movi_tl(cpu_T0, val);
> +        tcg_gen_movi_tl(s->T0, val);
>          gen_check_io(s, ot, pc_start - s->cs_base,
>                       SVM_IOIO_TYPE_MASK | svm_is_rep(prefixes));
>          if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
> @@ -6385,7 +6399,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>      case 0xe7:
>          ot =3D mo_b_d32(b, dflag);
>          val =3D x86_ldub_code(env, s);
> -        tcg_gen_movi_tl(cpu_T0, val);
> +        tcg_gen_movi_tl(s->T0, val);
>          gen_check_io(s, ot, pc_start - s->cs_base,
>                       svm_is_rep(prefixes));
>          gen_op_mov_v_reg(ot, cpu_T1, R_EAX);
> @@ -6405,13 +6419,13 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>      case 0xec:
>      case 0xed:
>          ot =3D mo_b_d32(b, dflag);
> -        tcg_gen_ext16u_tl(cpu_T0, cpu_regs[R_EDX]);
> +        tcg_gen_ext16u_tl(s->T0, cpu_regs[R_EDX]);
>          gen_check_io(s, ot, pc_start - s->cs_base,
>                       SVM_IOIO_TYPE_MASK | svm_is_rep(prefixes));
>          if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
>              gen_io_start();
>  	}
> -        tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_T0);
> +        tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
>          gen_helper_in_func(ot, cpu_T1, cpu_tmp2_i32);
>          gen_op_mov_reg_v(ot, R_EAX, cpu_T1);
>          gen_bpt_io(s, cpu_tmp2_i32, ot);
> @@ -6423,7 +6437,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>      case 0xee:
>      case 0xef:
>          ot =3D mo_b_d32(b, dflag);
> -        tcg_gen_ext16u_tl(cpu_T0, cpu_regs[R_EDX]);
> +        tcg_gen_ext16u_tl(s->T0, cpu_regs[R_EDX]);
>          gen_check_io(s, ot, pc_start - s->cs_base,
>                       svm_is_rep(prefixes));
>          gen_op_mov_v_reg(ot, cpu_T1, R_EAX);
> @@ -6431,7 +6445,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>          if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
>              gen_io_start();
>  	}
> -        tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_T0);
> +        tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
>          tcg_gen_trunc_tl_i32(cpu_tmp3_i32, cpu_T1);
>          gen_helper_out_func(ot, cpu_tmp2_i32, cpu_tmp3_i32);
>          gen_bpt_io(s, cpu_tmp2_i32, ot);
> @@ -6448,17 +6462,17 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>          ot =3D gen_pop_T0(s);
>          gen_stack_update(s, val + (1 << ot));
>          /* Note that gen_pop_T0 uses a zero-extending load.  */
> -        gen_op_jmp_v(cpu_T0);
> +        gen_op_jmp_v(s->T0);
>          gen_bnd_jmp(s);
> -        gen_jr(s, cpu_T0);
> +        gen_jr(s, s->T0);
>          break;
>      case 0xc3: /* ret */
>          ot =3D gen_pop_T0(s);
>          gen_pop_update(s, ot);
>          /* Note that gen_pop_T0 uses a zero-extending load.  */
> -        gen_op_jmp_v(cpu_T0);
> +        gen_op_jmp_v(s->T0);
>          gen_bnd_jmp(s);
> -        gen_jr(s, cpu_T0);
> +        gen_jr(s, s->T0);
>          break;
>      case 0xca: /* lret im */
>          val =3D x86_ldsw_code(env, s);
> @@ -6471,14 +6485,14 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>          } else {
>              gen_stack_A0(s);
>              /* pop offset */
> -            gen_op_ld_v(s, dflag, cpu_T0, s->A0);
> +            gen_op_ld_v(s, dflag, s->T0, s->A0);
>              /* NOTE: keeping EIP updated is not a problem in case of
>                 exception */
> -            gen_op_jmp_v(cpu_T0);
> +            gen_op_jmp_v(s->T0);
>              /* pop selector */
>              gen_add_A0_im(s, 1 << dflag);
> -            gen_op_ld_v(s, dflag, cpu_T0, s->A0);
> -            gen_op_movl_seg_T0_vm(R_CS);
> +            gen_op_ld_v(s, dflag, s->T0, s->A0);
> +            gen_op_movl_seg_T0_vm(s, R_CS);
>              /* add stack offset */
>              gen_stack_update(s, val + (2 << dflag));
>          }
> @@ -6521,8 +6535,8 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>              } else if (!CODE64(s)) {
>                  tval &=3D 0xffffffff;
>              }
> -            tcg_gen_movi_tl(cpu_T0, next_eip);
> -            gen_push_v(s, cpu_T0);
> +            tcg_gen_movi_tl(s->T0, next_eip);
> +            gen_push_v(s, s->T0);
>              gen_bnd_jmp(s);
>              gen_jmp(s, tval);
>          }
> @@ -6537,7 +6551,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>              offset =3D insn_get(env, s, ot);
>              selector =3D insn_get(env, s, MO_16);
>
> -            tcg_gen_movi_tl(cpu_T0, selector);
> +            tcg_gen_movi_tl(s->T0, selector);
>              tcg_gen_movi_tl(cpu_T1, offset);
>          }
>          goto do_lcall;
> @@ -6566,7 +6580,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>              offset =3D insn_get(env, s, ot);
>              selector =3D insn_get(env, s, MO_16);
>
> -            tcg_gen_movi_tl(cpu_T0, selector);
> +            tcg_gen_movi_tl(s->T0, selector);
>              tcg_gen_movi_tl(cpu_T1, offset);
>          }
>          goto do_ljmp;
> @@ -6599,7 +6613,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>
>      case 0x190 ... 0x19f: /* setcc Gv */
>          modrm =3D x86_ldub_code(env, s);
> -        gen_setcc1(s, b, cpu_T0);
> +        gen_setcc1(s, b, s->T0);
>          gen_ldst_modrm(env, s, modrm, MO_8, OR_TMP0, 1);
>          break;
>      case 0x140 ... 0x14f: /* cmov Gv, Ev */
> @@ -6620,8 +6634,8 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>              gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
>          } else {
>              gen_update_cc_op(s);
> -            gen_helper_read_eflags(cpu_T0, cpu_env);
> -            gen_push_v(s, cpu_T0);
> +            gen_helper_read_eflags(s->T0, cpu_env);
> +            gen_push_v(s, s->T0);
>          }
>          break;
>      case 0x9d: /* popf */
> @@ -6632,13 +6646,13 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>              ot =3D gen_pop_T0(s);
>              if (s->cpl =3D=3D 0) {
>                  if (dflag !=3D MO_16) {
> -                    gen_helper_write_eflags(cpu_env, cpu_T0,
> +                    gen_helper_write_eflags(cpu_env, s->T0,
>                                              tcg_const_i32((TF_MASK | AC_=
MASK |
>                                                             ID_MASK | NT_=
MASK |
>                                                             IF_MASK |
>                                                             IOPL_MASK)));
>                  } else {
> -                    gen_helper_write_eflags(cpu_env, cpu_T0,
> +                    gen_helper_write_eflags(cpu_env, s->T0,
>                                              tcg_const_i32((TF_MASK | AC_=
MASK |
>                                                             ID_MASK | NT_=
MASK |
>                                                             IF_MASK | IOP=
L_MASK)
> @@ -6647,14 +6661,14 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>              } else {
>                  if (s->cpl <=3D s->iopl) {
>                      if (dflag !=3D MO_16) {
> -                        gen_helper_write_eflags(cpu_env, cpu_T0,
> +                        gen_helper_write_eflags(cpu_env, s->T0,
>                                                  tcg_const_i32((TF_MASK |
>                                                                 AC_MASK |
>                                                                 ID_MASK |
>                                                                 NT_MASK |
>                                                                 IF_MASK))=
);
>                      } else {
> -                        gen_helper_write_eflags(cpu_env, cpu_T0,
> +                        gen_helper_write_eflags(cpu_env, s->T0,
>                                                  tcg_const_i32((TF_MASK |
>                                                                 AC_MASK |
>                                                                 ID_MASK |
> @@ -6664,11 +6678,11 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>                      }
>                  } else {
>                      if (dflag !=3D MO_16) {
> -                        gen_helper_write_eflags(cpu_env, cpu_T0,
> +                        gen_helper_write_eflags(cpu_env, s->T0,
>                                             tcg_const_i32((TF_MASK | AC_M=
ASK |
>                                                            ID_MASK | NT_M=
ASK)));
>                      } else {
> -                        gen_helper_write_eflags(cpu_env, cpu_T0,
> +                        gen_helper_write_eflags(cpu_env, s->T0,
>                                             tcg_const_i32((TF_MASK | AC_M=
ASK |
>                                                            ID_MASK | NT_M=
ASK)
>                                                           & 0xffff));
> @@ -6685,19 +6699,19 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>      case 0x9e: /* sahf */
>          if (CODE64(s) && !(s->cpuid_ext3_features & CPUID_EXT3_LAHF_LM))
>              goto illegal_op;
> -        gen_op_mov_v_reg(MO_8, cpu_T0, R_AH);
> +        gen_op_mov_v_reg(MO_8, s->T0, R_AH);
>          gen_compute_eflags(s);
>          tcg_gen_andi_tl(cpu_cc_src, cpu_cc_src, CC_O);
> -        tcg_gen_andi_tl(cpu_T0, cpu_T0, CC_S | CC_Z | CC_A | CC_P | CC_C=
);
> -        tcg_gen_or_tl(cpu_cc_src, cpu_cc_src, cpu_T0);
> +        tcg_gen_andi_tl(s->T0, s->T0, CC_S | CC_Z | CC_A | CC_P | CC_C);
> +        tcg_gen_or_tl(cpu_cc_src, cpu_cc_src, s->T0);
>          break;
>      case 0x9f: /* lahf */
>          if (CODE64(s) && !(s->cpuid_ext3_features & CPUID_EXT3_LAHF_LM))
>              goto illegal_op;
>          gen_compute_eflags(s);
>          /* Note: gen_compute_eflags() only gives the condition codes */
> -        tcg_gen_ori_tl(cpu_T0, cpu_cc_src, 0x02);
> -        gen_op_mov_reg_v(MO_8, R_AH, cpu_T0);
> +        tcg_gen_ori_tl(s->T0, cpu_cc_src, 0x02);
> +        gen_op_mov_reg_v(MO_8, R_AH, s->T0);
>          break;
>      case 0xf5: /* cmc */
>          gen_compute_eflags(s);
> @@ -6732,10 +6746,10 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>              s->rip_offset =3D 1;
>              gen_lea_modrm(env, s, modrm);
>              if (!(s->prefix & PREFIX_LOCK)) {
> -                gen_op_ld_v(s, ot, cpu_T0, s->A0);
> +                gen_op_ld_v(s, ot, s->T0, s->A0);
>              }
>          } else {
> -            gen_op_mov_v_reg(ot, cpu_T0, rm);
> +            gen_op_mov_v_reg(ot, s->T0, rm);
>          }
>          /* load shift */
>          val =3D x86_ldub_code(env, s);
> @@ -6771,10 +6785,10 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>              tcg_gen_add_tl(s->A0, gen_lea_modrm_1(s, a), cpu_tmp0);
>              gen_lea_v_seg(s, s->aflag, s->A0, a.def_seg, s->override);
>              if (!(s->prefix & PREFIX_LOCK)) {
> -                gen_op_ld_v(s, ot, cpu_T0, s->A0);
> +                gen_op_ld_v(s, ot, s->T0, s->A0);
>              }
>          } else {
> -            gen_op_mov_v_reg(ot, cpu_T0, rm);
> +            gen_op_mov_v_reg(ot, s->T0, rm);
>          }
>      bt_op:
>          tcg_gen_andi_tl(cpu_T1, cpu_T1, (1 << (3 + ot)) - 1);
> @@ -6785,46 +6799,46 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>              case 0: /* bt */
>                  /* Needs no atomic ops; we surpressed the normal
>                     memory load for LOCK above so do it now.  */
> -                gen_op_ld_v(s, ot, cpu_T0, s->A0);
> +                gen_op_ld_v(s, ot, s->T0, s->A0);
>                  break;
>              case 1: /* bts */
> -                tcg_gen_atomic_fetch_or_tl(cpu_T0, s->A0, cpu_tmp0,
> +                tcg_gen_atomic_fetch_or_tl(s->T0, s->A0, cpu_tmp0,
>                                             s->mem_index, ot | MO_LE);
>                  break;
>              case 2: /* btr */
>                  tcg_gen_not_tl(cpu_tmp0, cpu_tmp0);
> -                tcg_gen_atomic_fetch_and_tl(cpu_T0, s->A0, cpu_tmp0,
> +                tcg_gen_atomic_fetch_and_tl(s->T0, s->A0, cpu_tmp0,
>                                              s->mem_index, ot | MO_LE);
>                  break;
>              default:
>              case 3: /* btc */
> -                tcg_gen_atomic_fetch_xor_tl(cpu_T0, s->A0, cpu_tmp0,
> +                tcg_gen_atomic_fetch_xor_tl(s->T0, s->A0, cpu_tmp0,
>                                              s->mem_index, ot | MO_LE);
>                  break;
>              }
> -            tcg_gen_shr_tl(cpu_tmp4, cpu_T0, cpu_T1);
> +            tcg_gen_shr_tl(cpu_tmp4, s->T0, cpu_T1);
>          } else {
> -            tcg_gen_shr_tl(cpu_tmp4, cpu_T0, cpu_T1);
> +            tcg_gen_shr_tl(cpu_tmp4, s->T0, cpu_T1);
>              switch (op) {
>              case 0: /* bt */
>                  /* Data already loaded; nothing to do.  */
>                  break;
>              case 1: /* bts */
> -                tcg_gen_or_tl(cpu_T0, cpu_T0, cpu_tmp0);
> +                tcg_gen_or_tl(s->T0, s->T0, cpu_tmp0);
>                  break;
>              case 2: /* btr */
> -                tcg_gen_andc_tl(cpu_T0, cpu_T0, cpu_tmp0);
> +                tcg_gen_andc_tl(s->T0, s->T0, cpu_tmp0);
>                  break;
>              default:
>              case 3: /* btc */
> -                tcg_gen_xor_tl(cpu_T0, cpu_T0, cpu_tmp0);
> +                tcg_gen_xor_tl(s->T0, s->T0, cpu_tmp0);
>                  break;
>              }
>              if (op !=3D 0) {
>                  if (mod !=3D 3) {
> -                    gen_op_st_v(s, ot, cpu_T0, s->A0);
> +                    gen_op_st_v(s, ot, s->T0, s->A0);
>                  } else {
> -                    gen_op_mov_reg_v(ot, rm, cpu_T0);
> +                    gen_op_mov_reg_v(ot, rm, s->T0);
>                  }
>              }
>          }
> @@ -6865,7 +6879,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>          modrm =3D x86_ldub_code(env, s);
>          reg =3D ((modrm >> 3) & 7) | rex_r;
>          gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
> -        gen_extu(ot, cpu_T0);
> +        gen_extu(ot, s->T0);
>
>          /* Note that lzcnt and tzcnt are in different extensions.  */
>          if ((prefixes & PREFIX_REPZ)
> @@ -6874,23 +6888,23 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>                  : s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_BMI1)) {
>              int size =3D 8 << ot;
>              /* For lzcnt/tzcnt, C bit is defined related to the input. */
> -            tcg_gen_mov_tl(cpu_cc_src, cpu_T0);
> +            tcg_gen_mov_tl(cpu_cc_src, s->T0);
>              if (b & 1) {
>                  /* For lzcnt, reduce the target_ulong result by the
>                     number of zeros that we expect to find at the top.  */
> -                tcg_gen_clzi_tl(cpu_T0, cpu_T0, TARGET_LONG_BITS);
> -                tcg_gen_subi_tl(cpu_T0, cpu_T0, TARGET_LONG_BITS - size);
> +                tcg_gen_clzi_tl(s->T0, s->T0, TARGET_LONG_BITS);
> +                tcg_gen_subi_tl(s->T0, s->T0, TARGET_LONG_BITS - size);
>              } else {
>                  /* For tzcnt, a zero input must return the operand size.=
  */
> -                tcg_gen_ctzi_tl(cpu_T0, cpu_T0, size);
> +                tcg_gen_ctzi_tl(s->T0, s->T0, size);
>              }
>              /* For lzcnt/tzcnt, Z bit is defined related to the result. =
 */
> -            gen_op_update1_cc();
> +            gen_op_update1_cc(s);
>              set_cc_op(s, CC_OP_BMILGB + ot);
>          } else {
>              /* For bsr/bsf, only the Z bit is defined and it is related
>                 to the input and not the result.  */
> -            tcg_gen_mov_tl(cpu_cc_dst, cpu_T0);
> +            tcg_gen_mov_tl(cpu_cc_dst, s->T0);
>              set_cc_op(s, CC_OP_LOGICB + ot);
>
>              /* ??? The manual says that the output is undefined when the
> @@ -6901,13 +6915,13 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>                  /* For bsr, return the bit index of the first 1 bit,
>                     not the count of leading zeros.  */
>                  tcg_gen_xori_tl(cpu_T1, cpu_regs[reg], TARGET_LONG_BITS =
- 1);
> -                tcg_gen_clz_tl(cpu_T0, cpu_T0, cpu_T1);
> -                tcg_gen_xori_tl(cpu_T0, cpu_T0, TARGET_LONG_BITS - 1);
> +                tcg_gen_clz_tl(s->T0, s->T0, cpu_T1);
> +                tcg_gen_xori_tl(s->T0, s->T0, TARGET_LONG_BITS - 1);
>              } else {
> -                tcg_gen_ctz_tl(cpu_T0, cpu_T0, cpu_regs[reg]);
> +                tcg_gen_ctz_tl(s->T0, s->T0, cpu_regs[reg]);
>              }
>          }
> -        gen_op_mov_reg_v(ot, reg, cpu_T0);
> +        gen_op_mov_reg_v(ot, reg, s->T0);
>          break;
>          /************************/
>          /* bcd */
> @@ -7047,9 +7061,9 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>          mod =3D (modrm >> 6) & 3;
>          if (mod =3D=3D 3)
>              goto illegal_op;
> -        gen_op_mov_v_reg(ot, cpu_T0, reg);
> +        gen_op_mov_v_reg(ot, s->T0, reg);
>          gen_lea_modrm(env, s, modrm);
> -        tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_T0);
> +        tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
>          if (ot =3D=3D MO_16) {
>              gen_helper_boundw(cpu_env, s->A0, cpu_tmp2_i32);
>          } else {
> @@ -7060,24 +7074,24 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>          reg =3D (b & 7) | REX_B(s);
>  #ifdef TARGET_X86_64
>          if (dflag =3D=3D MO_64) {
> -            gen_op_mov_v_reg(MO_64, cpu_T0, reg);
> -            tcg_gen_bswap64_i64(cpu_T0, cpu_T0);
> -            gen_op_mov_reg_v(MO_64, reg, cpu_T0);
> +            gen_op_mov_v_reg(MO_64, s->T0, reg);
> +            tcg_gen_bswap64_i64(s->T0, s->T0);
> +            gen_op_mov_reg_v(MO_64, reg, s->T0);
>          } else
>  #endif
>          {
> -            gen_op_mov_v_reg(MO_32, cpu_T0, reg);
> -            tcg_gen_ext32u_tl(cpu_T0, cpu_T0);
> -            tcg_gen_bswap32_tl(cpu_T0, cpu_T0);
> -            gen_op_mov_reg_v(MO_32, reg, cpu_T0);
> +            gen_op_mov_v_reg(MO_32, s->T0, reg);
> +            tcg_gen_ext32u_tl(s->T0, s->T0);
> +            tcg_gen_bswap32_tl(s->T0, s->T0);
> +            gen_op_mov_reg_v(MO_32, reg, s->T0);
>          }
>          break;
>      case 0xd6: /* salc */
>          if (CODE64(s))
>              goto illegal_op;
> -        gen_compute_eflags_c(s, cpu_T0);
> -        tcg_gen_neg_tl(cpu_T0, cpu_T0);
> -        gen_op_mov_reg_v(MO_8, R_EAX, cpu_T0);
> +        gen_compute_eflags_c(s, s->T0);
> +        tcg_gen_neg_tl(s->T0, s->T0);
> +        gen_op_mov_reg_v(MO_8, R_EAX, s->T0);
>          break;
>      case 0xe0: /* loopnz */
>      case 0xe1: /* loopz */
> @@ -7229,7 +7243,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>              if (!s->pe || s->vm86)
>                  goto illegal_op;
>              gen_svm_check_intercept(s, pc_start, SVM_EXIT_LDTR_READ);
> -            tcg_gen_ld32u_tl(cpu_T0, cpu_env,
> +            tcg_gen_ld32u_tl(s->T0, cpu_env,
>                               offsetof(CPUX86State, ldt.selector));
>              ot =3D mod =3D=3D 3 ? dflag : MO_16;
>              gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 1);
> @@ -7242,7 +7256,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>              } else {
>                  gen_svm_check_intercept(s, pc_start, SVM_EXIT_LDTR_WRITE=
);
>                  gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
> -                tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_T0);
> +                tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
>                  gen_helper_lldt(cpu_env, cpu_tmp2_i32);
>              }
>              break;
> @@ -7250,7 +7264,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>              if (!s->pe || s->vm86)
>                  goto illegal_op;
>              gen_svm_check_intercept(s, pc_start, SVM_EXIT_TR_READ);
> -            tcg_gen_ld32u_tl(cpu_T0, cpu_env,
> +            tcg_gen_ld32u_tl(s->T0, cpu_env,
>                               offsetof(CPUX86State, tr.selector));
>              ot =3D mod =3D=3D 3 ? dflag : MO_16;
>              gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 1);
> @@ -7263,7 +7277,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>              } else {
>                  gen_svm_check_intercept(s, pc_start, SVM_EXIT_TR_WRITE);
>                  gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
> -                tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_T0);
> +                tcg_gen_trunc_tl_i32(cpu_tmp2_i32, s->T0);
>                  gen_helper_ltr(cpu_env, cpu_tmp2_i32);
>              }
>              break;
> @@ -7274,9 +7288,9 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>              gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
>              gen_update_cc_op(s);
>              if (op =3D=3D 4) {
> -                gen_helper_verr(cpu_env, cpu_T0);
> +                gen_helper_verr(cpu_env, s->T0);
>              } else {
> -                gen_helper_verw(cpu_env, cpu_T0);
> +                gen_helper_verw(cpu_env, s->T0);
>              }
>              set_cc_op(s, CC_OP_EFLAGS);
>              break;
> @@ -7291,15 +7305,15 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>          CASE_MODRM_MEM_OP(0): /* sgdt */
>              gen_svm_check_intercept(s, pc_start, SVM_EXIT_GDTR_READ);
>              gen_lea_modrm(env, s, modrm);
> -            tcg_gen_ld32u_tl(cpu_T0,
> +            tcg_gen_ld32u_tl(s->T0,
>                               cpu_env, offsetof(CPUX86State, gdt.limit));
> -            gen_op_st_v(s, MO_16, cpu_T0, s->A0);
> +            gen_op_st_v(s, MO_16, s->T0, s->A0);
>              gen_add_A0_im(s, 2);
> -            tcg_gen_ld_tl(cpu_T0, cpu_env, offsetof(CPUX86State, gdt.bas=
e));
> +            tcg_gen_ld_tl(s->T0, cpu_env, offsetof(CPUX86State, gdt.base=
));
>              if (dflag =3D=3D MO_16) {
> -                tcg_gen_andi_tl(cpu_T0, cpu_T0, 0xffffff);
> +                tcg_gen_andi_tl(s->T0, s->T0, 0xffffff);
>              }
> -            gen_op_st_v(s, CODE64(s) + MO_32, cpu_T0, s->A0);
> +            gen_op_st_v(s, CODE64(s) + MO_32, s->T0, s->A0);
>              break;
>
>          case 0xc8: /* monitor */
> @@ -7347,14 +7361,14 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>          CASE_MODRM_MEM_OP(1): /* sidt */
>              gen_svm_check_intercept(s, pc_start, SVM_EXIT_IDTR_READ);
>              gen_lea_modrm(env, s, modrm);
> -            tcg_gen_ld32u_tl(cpu_T0, cpu_env, offsetof(CPUX86State, idt.=
limit));
> -            gen_op_st_v(s, MO_16, cpu_T0, s->A0);
> +            tcg_gen_ld32u_tl(s->T0, cpu_env, offsetof(CPUX86State, idt.l=
imit));
> +            gen_op_st_v(s, MO_16, s->T0, s->A0);
>              gen_add_A0_im(s, 2);
> -            tcg_gen_ld_tl(cpu_T0, cpu_env, offsetof(CPUX86State, idt.bas=
e));
> +            tcg_gen_ld_tl(s->T0, cpu_env, offsetof(CPUX86State, idt.base=
));
>              if (dflag =3D=3D MO_16) {
> -                tcg_gen_andi_tl(cpu_T0, cpu_T0, 0xffffff);
> +                tcg_gen_andi_tl(s->T0, s->T0, 0xffffff);
>              }
> -            gen_op_st_v(s, CODE64(s) + MO_32, cpu_T0, s->A0);
> +            gen_op_st_v(s, CODE64(s) + MO_32, s->T0, s->A0);
>              break;
>
>          case 0xd0: /* xgetbv */
> @@ -7500,11 +7514,11 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>              gen_lea_modrm(env, s, modrm);
>              gen_op_ld_v(s, MO_16, cpu_T1, s->A0);
>              gen_add_A0_im(s, 2);
> -            gen_op_ld_v(s, CODE64(s) + MO_32, cpu_T0, s->A0);
> +            gen_op_ld_v(s, CODE64(s) + MO_32, s->T0, s->A0);
>              if (dflag =3D=3D MO_16) {
> -                tcg_gen_andi_tl(cpu_T0, cpu_T0, 0xffffff);
> +                tcg_gen_andi_tl(s->T0, s->T0, 0xffffff);
>              }
> -            tcg_gen_st_tl(cpu_T0, cpu_env, offsetof(CPUX86State, gdt.bas=
e));
> +            tcg_gen_st_tl(s->T0, cpu_env, offsetof(CPUX86State, gdt.base=
));
>              tcg_gen_st32_tl(cpu_T1, cpu_env, offsetof(CPUX86State, gdt.l=
imit));
>              break;
>
> @@ -7517,17 +7531,17 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>              gen_lea_modrm(env, s, modrm);
>              gen_op_ld_v(s, MO_16, cpu_T1, s->A0);
>              gen_add_A0_im(s, 2);
> -            gen_op_ld_v(s, CODE64(s) + MO_32, cpu_T0, s->A0);
> +            gen_op_ld_v(s, CODE64(s) + MO_32, s->T0, s->A0);
>              if (dflag =3D=3D MO_16) {
> -                tcg_gen_andi_tl(cpu_T0, cpu_T0, 0xffffff);
> +                tcg_gen_andi_tl(s->T0, s->T0, 0xffffff);
>              }
> -            tcg_gen_st_tl(cpu_T0, cpu_env, offsetof(CPUX86State, idt.bas=
e));
> +            tcg_gen_st_tl(s->T0, cpu_env, offsetof(CPUX86State, idt.base=
));
>              tcg_gen_st32_tl(cpu_T1, cpu_env, offsetof(CPUX86State, idt.l=
imit));
>              break;
>
>          CASE_MODRM_OP(4): /* smsw */
>              gen_svm_check_intercept(s, pc_start, SVM_EXIT_READ_CR0);
> -            tcg_gen_ld_tl(cpu_T0, cpu_env, offsetof(CPUX86State, cr[0]));
> +            tcg_gen_ld_tl(s->T0, cpu_env, offsetof(CPUX86State, cr[0]));
>              if (CODE64(s)) {
>                  mod =3D (modrm >> 6) & 3;
>                  ot =3D (mod !=3D 3 ? MO_16 : s->dflag);
> @@ -7560,7 +7574,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>              }
>              gen_svm_check_intercept(s, pc_start, SVM_EXIT_WRITE_CR0);
>              gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
> -            gen_helper_lmsw(cpu_env, cpu_T0);
> +            gen_helper_lmsw(cpu_env, s->T0);
>              gen_jmp_im(s->pc - s->cs_base);
>              gen_eob(s);
>              break;
> @@ -7584,10 +7598,10 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>                  if (s->cpl !=3D 0) {
>                      gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
>                  } else {
> -                    tcg_gen_mov_tl(cpu_T0, cpu_seg_base[R_GS]);
> +                    tcg_gen_mov_tl(s->T0, cpu_seg_base[R_GS]);
>                      tcg_gen_ld_tl(cpu_seg_base[R_GS], cpu_env,
>                                    offsetof(CPUX86State, kernelgsbase));
> -                    tcg_gen_st_tl(cpu_T0, cpu_env,
> +                    tcg_gen_st_tl(s->T0, cpu_env,
>                                    offsetof(CPUX86State, kernelgsbase));
>                  }
>                  break;
> @@ -7638,16 +7652,16 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>              rm =3D (modrm & 7) | REX_B(s);
>
>              if (mod =3D=3D 3) {
> -                gen_op_mov_v_reg(MO_32, cpu_T0, rm);
> +                gen_op_mov_v_reg(MO_32, s->T0, rm);
>                  /* sign extend */
>                  if (d_ot =3D=3D MO_64) {
> -                    tcg_gen_ext32s_tl(cpu_T0, cpu_T0);
> +                    tcg_gen_ext32s_tl(s->T0, s->T0);
>                  }
> -                gen_op_mov_reg_v(d_ot, reg, cpu_T0);
> +                gen_op_mov_reg_v(d_ot, reg, s->T0);
>              } else {
>                  gen_lea_modrm(env, s, modrm);
> -                gen_op_ld_v(s, MO_32 | MO_SIGN, cpu_T0, s->A0);
> -                gen_op_mov_reg_v(d_ot, reg, cpu_T0);
> +                gen_op_ld_v(s, MO_32 | MO_SIGN, s->T0, s->A0);
> +                gen_op_mov_reg_v(d_ot, reg, s->T0);
>              }
>          } else
>  #endif
> @@ -7712,9 +7726,9 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>              t0 =3D tcg_temp_local_new();
>              gen_update_cc_op(s);
>              if (b =3D=3D 0x102) {
> -                gen_helper_lar(t0, cpu_env, cpu_T0);
> +                gen_helper_lar(t0, cpu_env, s->T0);
>              } else {
> -                gen_helper_lsl(t0, cpu_env, cpu_T0);
> +                gen_helper_lsl(t0, cpu_env, s->T0);
>              }
>              tcg_gen_andi_tl(cpu_tmp0, cpu_cc_src, CC_Z);
>              label1 =3D gen_new_label();
> @@ -7816,16 +7830,16 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>                  }
>                  gen_lea_v_seg(s, s->aflag, s->A0, a.def_seg, s->override=
);
>                  if (a.index >=3D 0) {
> -                    tcg_gen_mov_tl(cpu_T0, cpu_regs[a.index]);
> +                    tcg_gen_mov_tl(s->T0, cpu_regs[a.index]);
>                  } else {
> -                    tcg_gen_movi_tl(cpu_T0, 0);
> +                    tcg_gen_movi_tl(s->T0, 0);
>                  }
>                  if (CODE64(s)) {
> -                    gen_helper_bndldx64(cpu_bndl[reg], cpu_env, s->A0, c=
pu_T0);
> +                    gen_helper_bndldx64(cpu_bndl[reg], cpu_env, s->A0, s=
->T0);
>                      tcg_gen_ld_i64(cpu_bndu[reg], cpu_env,
>                                     offsetof(CPUX86State, mmx_t0.MMX_Q(0)=
));
>                  } else {
> -                    gen_helper_bndldx32(cpu_bndu[reg], cpu_env, s->A0, c=
pu_T0);
> +                    gen_helper_bndldx32(cpu_bndu[reg], cpu_env, s->A0, s=
->T0);
>                      tcg_gen_ext32u_i64(cpu_bndl[reg], cpu_bndu[reg]);
>                      tcg_gen_shri_i64(cpu_bndu[reg], cpu_bndu[reg], 32);
>                  }
> @@ -7921,15 +7935,15 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>                  }
>                  gen_lea_v_seg(s, s->aflag, s->A0, a.def_seg, s->override=
);
>                  if (a.index >=3D 0) {
> -                    tcg_gen_mov_tl(cpu_T0, cpu_regs[a.index]);
> +                    tcg_gen_mov_tl(s->T0, cpu_regs[a.index]);
>                  } else {
> -                    tcg_gen_movi_tl(cpu_T0, 0);
> +                    tcg_gen_movi_tl(s->T0, 0);
>                  }
>                  if (CODE64(s)) {
> -                    gen_helper_bndstx64(cpu_env, s->A0, cpu_T0,
> +                    gen_helper_bndstx64(cpu_env, s->A0, s->T0,
>                                          cpu_bndl[reg], cpu_bndu[reg]);
>                  } else {
> -                    gen_helper_bndstx32(cpu_env, s->A0, cpu_T0,
> +                    gen_helper_bndstx32(cpu_env, s->A0, s->T0,
>                                          cpu_bndl[reg], cpu_bndu[reg]);
>                  }
>              }
> @@ -7973,9 +7987,9 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>                      if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
>                          gen_io_start();
>                      }
> -                    gen_op_mov_v_reg(ot, cpu_T0, rm);
> +                    gen_op_mov_v_reg(ot, s->T0, rm);
>                      gen_helper_write_crN(cpu_env, tcg_const_i32(reg),
> -                                         cpu_T0);
> +                                         s->T0);
>                      if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
>                          gen_io_end();
>                      }
> @@ -7985,8 +7999,8 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>                      if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
>                          gen_io_start();
>                      }
> -                    gen_helper_read_crN(cpu_T0, cpu_env, tcg_const_i32(r=
eg));
> -                    gen_op_mov_reg_v(ot, rm, cpu_T0);
> +                    gen_helper_read_crN(s->T0, cpu_env, tcg_const_i32(re=
g));
> +                    gen_op_mov_reg_v(ot, rm, s->T0);
>                      if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
>                          gen_io_end();
>                      }
> @@ -8019,16 +8033,16 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>              }
>              if (b & 2) {
>                  gen_svm_check_intercept(s, pc_start, SVM_EXIT_WRITE_DR0 =
+ reg);
> -                gen_op_mov_v_reg(ot, cpu_T0, rm);
> +                gen_op_mov_v_reg(ot, s->T0, rm);
>                  tcg_gen_movi_i32(cpu_tmp2_i32, reg);
> -                gen_helper_set_dr(cpu_env, cpu_tmp2_i32, cpu_T0);
> +                gen_helper_set_dr(cpu_env, cpu_tmp2_i32, s->T0);
>                  gen_jmp_im(s->pc - s->cs_base);
>                  gen_eob(s);
>              } else {
>                  gen_svm_check_intercept(s, pc_start, SVM_EXIT_READ_DR0 +=
 reg);
>                  tcg_gen_movi_i32(cpu_tmp2_i32, reg);
> -                gen_helper_get_dr(cpu_T0, cpu_env, cpu_tmp2_i32);
> -                gen_op_mov_reg_v(ot, rm, cpu_T0);
> +                gen_helper_get_dr(s->T0, cpu_env, cpu_tmp2_i32);
> +                gen_op_mov_reg_v(ot, rm, s->T0);
>              }
>          }
>          break;
> @@ -8107,8 +8121,8 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>                  break;
>              }
>              gen_lea_modrm(env, s, modrm);
> -            tcg_gen_ld32u_tl(cpu_T0, cpu_env, offsetof(CPUX86State, mxcs=
r));
> -            gen_op_st_v(s, MO_32, cpu_T0, s->A0);
> +            tcg_gen_ld32u_tl(s->T0, cpu_env, offsetof(CPUX86State, mxcsr=
));
> +            gen_op_st_v(s, MO_32, s->T0, s->A0);
>              break;
>
>          CASE_MODRM_MEM_OP(4): /* xsave */
> @@ -8287,10 +8301,10 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>          }
>
>          gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
> -        gen_extu(ot, cpu_T0);
> -        tcg_gen_mov_tl(cpu_cc_src, cpu_T0);
> -        tcg_gen_ctpop_tl(cpu_T0, cpu_T0);
> -        gen_op_mov_reg_v(ot, reg, cpu_T0);
> +        gen_extu(ot, s->T0);
> +        tcg_gen_mov_tl(cpu_cc_src, s->T0);
> +        tcg_gen_ctpop_tl(s->T0, s->T0);
> +        gen_op_mov_reg_v(ot, reg, s->T0);
>
>          set_cc_op(s, CC_OP_POPCNT);
>          break;
> @@ -8456,7 +8470,7 @@ static void i386_tr_init_disas_context(DisasContext=
Base *dcbase, CPUState *cpu)
>          printf("ERROR addseg\n");
>  #endif
>
> -    cpu_T0 =3D tcg_temp_new();
> +    dc->T0 =3D tcg_temp_new();
>      cpu_T1 =3D tcg_temp_new();
>      dc->A0 =3D tcg_temp_new();


--
Alex Benn=C3=A9e
