Received: from eggs.gnu.org ([2001:4830:134:3::10]:48436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g0SeC-0003qI-GY
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 10:31:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g0Se8-0005Fx-Tj
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 10:31:08 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g0Se8-0005FU-DZ
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 10:31:04 -0400
Received: by mail-wr1-x442.google.com with SMTP id k5-v6so5931221wre.10
	for <qemu-devel@nongnu.org>; Thu, 13 Sep 2018 07:31:04 -0700 (PDT)
References: <20180911202823.21657-1-cota@braap.org>
	<20180911202823.21657-13-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180911202823.21657-13-cota@braap.org>
Date: Thu, 13 Sep 2018 15:31:01 +0100
Message-ID: <878t45bhay.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 12/13] target/i386: move x86_64_hregs to
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

> And convert it to a bool to use an existing hole
> in the struct.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/i386/translate.c | 307 ++++++++++++++++++++--------------------
>  1 file changed, 154 insertions(+), 153 deletions(-)
>
> diff --git a/target/i386/translate.c b/target/i386/translate.c
> index 61a98ef872..b8222dc4ba 100644
> --- a/target/i386/translate.c
> +++ b/target/i386/translate.c
> @@ -81,10 +81,6 @@ static TCGv_i64 cpu_bndu[4];
>
>  #include "exec/gen-icount.h"
>
> -#ifdef TARGET_X86_64
> -static int x86_64_hregs;
> -#endif
> -
>  typedef struct DisasContext {
>      DisasContextBase base;
>
> @@ -109,6 +105,9 @@ typedef struct DisasContext {
>      int ss32;   /* 32 bit stack segment */
>      CCOp cc_op;  /* current CC operation */
>      bool cc_op_dirty;
> +#ifdef TARGET_X86_64
> +    bool x86_64_hregs;
> +#endif
>      int addseg; /* non zero if either DS/ES/SS have a non zero base */
>      int f_st;   /* currently unused */
>      int vm86;   /* vm86 mode */
> @@ -307,13 +306,13 @@ static void gen_update_cc_op(DisasContext *s)
>   * [AH, CH, DH, BH], ie "bits 15..8 of register N-4". Return
>   * true for this special case, false otherwise.
>   */
> -static inline bool byte_reg_is_xH(int reg)
> +static inline bool byte_reg_is_xH(DisasContext *s, int reg)
>  {
>      if (reg < 4) {
>          return false;
>      }
>  #ifdef TARGET_X86_64
> -    if (reg >=3D 8 || x86_64_hregs) {
> +    if (reg >=3D 8 || s->x86_64_hregs) {
>          return false;
>      }
>  #endif
> @@ -360,11 +359,11 @@ static inline TCGMemOp mo_b_d32(int b, TCGMemOp ot)
>      return b & 1 ? (ot =3D=3D MO_16 ? MO_16 : MO_32) : MO_8;
>  }
>
> -static void gen_op_mov_reg_v(TCGMemOp ot, int reg, TCGv t0)
> +static void gen_op_mov_reg_v(DisasContext *s, TCGMemOp ot, int reg, TCGv=
 t0)
>  {
>      switch(ot) {
>      case MO_8:
> -        if (!byte_reg_is_xH(reg)) {
> +        if (!byte_reg_is_xH(s, reg)) {
>              tcg_gen_deposit_tl(cpu_regs[reg], cpu_regs[reg], t0, 0, 8);
>          } else {
>              tcg_gen_deposit_tl(cpu_regs[reg - 4], cpu_regs[reg - 4], t0,=
 8, 8);
> @@ -388,9 +387,10 @@ static void gen_op_mov_reg_v(TCGMemOp ot, int reg, T=
CGv t0)
>      }
>  }
>
> -static inline void gen_op_mov_v_reg(TCGMemOp ot, TCGv t0, int reg)
> +static inline
> +void gen_op_mov_v_reg(DisasContext *s, TCGMemOp ot, TCGv t0, int reg)
>  {
> -    if (ot =3D=3D MO_8 && byte_reg_is_xH(reg)) {
> +    if (ot =3D=3D MO_8 && byte_reg_is_xH(s, reg)) {
>          tcg_gen_extract_tl(t0, cpu_regs[reg - 4], 8, 8);
>      } else {
>          tcg_gen_mov_tl(t0, cpu_regs[reg]);
> @@ -414,13 +414,13 @@ static inline
>  void gen_op_add_reg_im(DisasContext *s, TCGMemOp size, int reg, int32_t =
val)
>  {
>      tcg_gen_addi_tl(s->tmp0, cpu_regs[reg], val);
> -    gen_op_mov_reg_v(size, reg, s->tmp0);
> +    gen_op_mov_reg_v(s, size, reg, s->tmp0);
>  }
>
>  static inline void gen_op_add_reg_T0(DisasContext *s, TCGMemOp size, int=
 reg)
>  {
>      tcg_gen_add_tl(s->tmp0, cpu_regs[reg], s->T0);
> -    gen_op_mov_reg_v(size, reg, s->tmp0);
> +    gen_op_mov_reg_v(s, size, reg, s->tmp0);
>  }
>
>  static inline void gen_op_ld_v(DisasContext *s, int idx, TCGv t0, TCGv a=
0)
> @@ -438,7 +438,7 @@ static inline void gen_op_st_rm_T0_A0(DisasContext *s=
, int idx, int d)
>      if (d =3D=3D OR_TMP0) {
>          gen_op_st_v(s, idx, s->T0, s->A0);
>      } else {
> -        gen_op_mov_reg_v(idx, d, s->T0);
> +        gen_op_mov_reg_v(s, idx, d, s->T0);
>      }
>  }
>
> @@ -1077,7 +1077,7 @@ static TCGLabel *gen_jz_ecx_string(DisasContext *s,=
 target_ulong next_eip)
>
>  static inline void gen_stos(DisasContext *s, TCGMemOp ot)
>  {
> -    gen_op_mov_v_reg(MO_32, s->T0, R_EAX);
> +    gen_op_mov_v_reg(s, MO_32, s->T0, R_EAX);
>      gen_string_movl_A0_EDI(s);
>      gen_op_st_v(s, ot, s->T0, s->A0);
>      gen_op_movl_T0_Dshift(s, ot);
> @@ -1088,7 +1088,7 @@ static inline void gen_lods(DisasContext *s, TCGMem=
Op ot)
>  {
>      gen_string_movl_A0_ESI(s);
>      gen_op_ld_v(s, ot, s->T0, s->A0);
> -    gen_op_mov_reg_v(ot, R_EAX, s->T0);
> +    gen_op_mov_reg_v(s, ot, R_EAX, s->T0);
>      gen_op_movl_T0_Dshift(s, ot);
>      gen_op_add_reg_T0(s, s->aflag, R_ESI);
>  }
> @@ -1272,7 +1272,7 @@ static void gen_helper_fp_arith_STN_ST0(int op, int=
 opreg)
>  static void gen_op(DisasContext *s1, int op, TCGMemOp ot, int d)
>  {
>      if (d !=3D OR_TMP0) {
> -        gen_op_mov_v_reg(ot, s1->T0, d);
> +        gen_op_mov_v_reg(s1, ot, s1->T0, d);
>      } else if (!(s1->prefix & PREFIX_LOCK)) {
>          gen_op_ld_v(s1, ot, s1->T0, s1->A0);
>      }
> @@ -1383,7 +1383,7 @@ static void gen_inc(DisasContext *s1, TCGMemOp ot, =
int d, int c)
>                                      s1->mem_index, ot | MO_LE);
>      } else {
>          if (d !=3D OR_TMP0) {
> -            gen_op_mov_v_reg(ot, s1->T0, d);
> +            gen_op_mov_v_reg(s1, ot, s1->T0, d);
>          } else {
>              gen_op_ld_v(s1, ot, s1->T0, s1->A0);
>          }
> @@ -1450,7 +1450,7 @@ static void gen_shift_rm_T1(DisasContext *s, TCGMem=
Op ot, int op1,
>      if (op1 =3D=3D OR_TMP0) {
>          gen_op_ld_v(s, ot, s->T0, s->A0);
>      } else {
> -        gen_op_mov_v_reg(ot, s->T0, op1);
> +        gen_op_mov_v_reg(s, ot, s->T0, op1);
>      }
>
>      tcg_gen_andi_tl(s->T1, s->T1, mask);
> @@ -1486,7 +1486,7 @@ static void gen_shift_rm_im(DisasContext *s, TCGMem=
Op ot, int op1, int op2,
>      if (op1 =3D=3D OR_TMP0)
>          gen_op_ld_v(s, ot, s->T0, s->A0);
>      else
> -        gen_op_mov_v_reg(ot, s->T0, op1);
> +        gen_op_mov_v_reg(s, ot, s->T0, op1);
>
>      op2 &=3D mask;
>      if (op2 !=3D 0) {
> @@ -1526,7 +1526,7 @@ static void gen_rot_rm_T1(DisasContext *s, TCGMemOp=
 ot, int op1, int is_right)
>      if (op1 =3D=3D OR_TMP0) {
>          gen_op_ld_v(s, ot, s->T0, s->A0);
>      } else {
> -        gen_op_mov_v_reg(ot, s->T0, op1);
> +        gen_op_mov_v_reg(s, ot, s->T0, op1);
>      }
>
>      tcg_gen_andi_tl(s->T1, s->T1, mask);
> @@ -1612,7 +1612,7 @@ static void gen_rot_rm_im(DisasContext *s, TCGMemOp=
 ot, int op1, int op2,
>      if (op1 =3D=3D OR_TMP0) {
>          gen_op_ld_v(s, ot, s->T0, s->A0);
>      } else {
> -        gen_op_mov_v_reg(ot, s->T0, op1);
> +        gen_op_mov_v_reg(s, ot, s->T0, op1);
>      }
>
>      op2 &=3D mask;
> @@ -1690,7 +1690,7 @@ static void gen_rotc_rm_T1(DisasContext *s, TCGMemO=
p ot, int op1,
>      if (op1 =3D=3D OR_TMP0)
>          gen_op_ld_v(s, ot, s->T0, s->A0);
>      else
> -        gen_op_mov_v_reg(ot, s->T0, op1);
> +        gen_op_mov_v_reg(s, ot, s->T0, op1);
>
>      if (is_right) {
>          switch (ot) {
> @@ -1746,7 +1746,7 @@ static void gen_shiftd_rm_T1(DisasContext *s, TCGMe=
mOp ot, int op1,
>      if (op1 =3D=3D OR_TMP0) {
>          gen_op_ld_v(s, ot, s->T0, s->A0);
>      } else {
> -        gen_op_mov_v_reg(ot, s->T0, op1);
> +        gen_op_mov_v_reg(s, ot, s->T0, op1);
>      }
>
>      count =3D tcg_temp_new();
> @@ -1820,7 +1820,7 @@ static void gen_shiftd_rm_T1(DisasContext *s, TCGMe=
mOp ot, int op1,
>  static void gen_shift(DisasContext *s1, int op, TCGMemOp ot, int d, int =
s)
>  {
>      if (s !=3D OR_TMP1)
> -        gen_op_mov_v_reg(ot, s1->T1, s);
> +        gen_op_mov_v_reg(s1, ot, s1->T1, s);
>      switch(op) {
>      case OP_ROL:
>          gen_rot_rm_T1(s1, ot, d, 0);
> @@ -2133,23 +2133,23 @@ static void gen_ldst_modrm(CPUX86State *env, Disa=
sContext *s, int modrm,
>      if (mod =3D=3D 3) {
>          if (is_store) {
>              if (reg !=3D OR_TMP0)
> -                gen_op_mov_v_reg(ot, s->T0, reg);
> -            gen_op_mov_reg_v(ot, rm, s->T0);
> +                gen_op_mov_v_reg(s, ot, s->T0, reg);
> +            gen_op_mov_reg_v(s, ot, rm, s->T0);
>          } else {
> -            gen_op_mov_v_reg(ot, s->T0, rm);
> +            gen_op_mov_v_reg(s, ot, s->T0, rm);
>              if (reg !=3D OR_TMP0)
> -                gen_op_mov_reg_v(ot, reg, s->T0);
> +                gen_op_mov_reg_v(s, ot, reg, s->T0);
>          }
>      } else {
>          gen_lea_modrm(env, s, modrm);
>          if (is_store) {
>              if (reg !=3D OR_TMP0)
> -                gen_op_mov_v_reg(ot, s->T0, reg);
> +                gen_op_mov_v_reg(s, ot, s->T0, reg);
>              gen_op_st_v(s, ot, s->T0, s->A0);
>          } else {
>              gen_op_ld_v(s, ot, s->T0, s->A0);
>              if (reg !=3D OR_TMP0)
> -                gen_op_mov_reg_v(ot, reg, s->T0);
> +                gen_op_mov_reg_v(s, ot, reg, s->T0);
>          }
>      }
>  }
> @@ -2260,7 +2260,7 @@ static void gen_cmovcc1(CPUX86State *env, DisasCont=
ext *s, TCGMemOp ot, int b,
>
>      tcg_gen_movcond_tl(cc.cond, s->T0, cc.reg, cc.reg2,
>                         s->T0, cpu_regs[reg]);
> -    gen_op_mov_reg_v(ot, reg, s->T0);
> +    gen_op_mov_reg_v(s, ot, reg, s->T0);
>
>      if (cc.mask !=3D -1) {
>          tcg_temp_free(cc.reg);
> @@ -2354,7 +2354,7 @@ static void gen_push_v(DisasContext *s, TCGv val)
>      }
>
>      gen_op_st_v(s, d_ot, val, s->A0);
> -    gen_op_mov_reg_v(a_ot, R_ESP, new_esp);
> +    gen_op_mov_reg_v(s, a_ot, R_ESP, new_esp);
>  }
>
>  /* two step pop is necessary for precise exceptions */
> @@ -2409,7 +2409,7 @@ static void gen_popa(DisasContext *s)
>          tcg_gen_addi_tl(s->A0, cpu_regs[R_ESP], i * size);
>          gen_lea_v_seg(s, s_ot, s->A0, R_SS, -1);
>          gen_op_ld_v(s, d_ot, s->T0, s->A0);
> -        gen_op_mov_reg_v(d_ot, 7 - i, s->T0);
> +        gen_op_mov_reg_v(s, d_ot, 7 - i, s->T0);
>      }
>
>      gen_stack_update(s, 8 * size);
> @@ -2448,11 +2448,11 @@ static void gen_enter(DisasContext *s, int esp_ad=
dend, int level)
>      }
>
>      /* Copy the FrameTemp value to EBP.  */
> -    gen_op_mov_reg_v(a_ot, R_EBP, s->T1);
> +    gen_op_mov_reg_v(s, a_ot, R_EBP, s->T1);
>
>      /* Compute the final value of ESP.  */
>      tcg_gen_subi_tl(s->T1, s->T1, esp_addend + size * level);
> -    gen_op_mov_reg_v(a_ot, R_ESP, s->T1);
> +    gen_op_mov_reg_v(s, a_ot, R_ESP, s->T1);
>  }
>
>  static void gen_leave(DisasContext *s)
> @@ -2465,8 +2465,8 @@ static void gen_leave(DisasContext *s)
>
>      tcg_gen_addi_tl(s->T1, cpu_regs[R_EBP], 1 << d_ot);
>
> -    gen_op_mov_reg_v(d_ot, R_EBP, s->T0);
> -    gen_op_mov_reg_v(a_ot, R_ESP, s->T1);
> +    gen_op_mov_reg_v(s, d_ot, R_EBP, s->T0);
> +    gen_op_mov_reg_v(s, a_ot, R_ESP, s->T1);
>  }
>
>  static void gen_exception(DisasContext *s, int trapno, target_ulong cur_=
eip)
> @@ -3598,7 +3598,7 @@ static void gen_sse(CPUX86State *env, DisasContext =
*s, int b,
>                  goto illegal_op;
>  #endif
>              }
> -            gen_op_mov_reg_v(ot, reg, s->T0);
> +            gen_op_mov_reg_v(s, ot, reg, s->T0);
>              break;
>          case 0xc4: /* pinsrw */
>          case 0x1c4:
> @@ -3633,7 +3633,7 @@ static void gen_sse(CPUX86State *env, DisasContext =
*s, int b,
>                                  offsetof(CPUX86State,fpregs[rm].mmx.MMX_=
W(val)));
>              }
>              reg =3D ((modrm >> 3) & 7) | rex_r;
> -            gen_op_mov_reg_v(ot, reg, s->T0);
> +            gen_op_mov_reg_v(s, ot, reg, s->T0);
>              break;
>          case 0x1d6: /* movq ea, xmm */
>              if (mod !=3D 3) {
> @@ -3787,7 +3787,7 @@ static void gen_sse(CPUX86State *env, DisasContext =
*s, int b,
>                                   s->T0, tcg_const_i32(8 << ot));
>
>                  ot =3D mo_64_32(s->dflag);
> -                gen_op_mov_reg_v(ot, reg, s->T0);
> +                gen_op_mov_reg_v(s, ot, reg, s->T0);
>                  break;
>
>              case 0x1f0: /* crc32 or movbe */
> @@ -3814,7 +3814,7 @@ static void gen_sse(CPUX86State *env, DisasContext =
*s, int b,
>                  if ((b & 1) =3D=3D 0) {
>                      tcg_gen_qemu_ld_tl(s->T0, s->A0,
>                                         s->mem_index, ot | MO_BE);
> -                    gen_op_mov_reg_v(ot, reg, s->T0);
> +                    gen_op_mov_reg_v(s, ot, reg, s->T0);
>                  } else {
>                      tcg_gen_qemu_st_tl(cpu_regs[reg], s->A0,
>                                         s->mem_index, ot | MO_BE);
> @@ -3830,7 +3830,7 @@ static void gen_sse(CPUX86State *env, DisasContext =
*s, int b,
>                  ot =3D mo_64_32(s->dflag);
>                  gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
>                  tcg_gen_andc_tl(s->T0, s->T0, cpu_regs[s->vex_v]);
> -                gen_op_mov_reg_v(ot, reg, s->T0);
> +                gen_op_mov_reg_v(s, ot, reg, s->T0);
>                  gen_op_update1_cc(s);
>                  set_cc_op(s, CC_OP_LOGICB + ot);
>                  break;
> @@ -3868,7 +3868,7 @@ static void gen_sse(CPUX86State *env, DisasContext =
*s, int b,
>                      tcg_gen_subi_tl(s->T1, s->T1, 1);
>                      tcg_gen_and_tl(s->T0, s->T0, s->T1);
>
> -                    gen_op_mov_reg_v(ot, reg, s->T0);
> +                    gen_op_mov_reg_v(s, ot, reg, s->T0);
>                      gen_op_update1_cc(s);
>                      set_cc_op(s, CC_OP_LOGICB + ot);
>                  }
> @@ -3896,7 +3896,7 @@ static void gen_sse(CPUX86State *env, DisasContext =
*s, int b,
>                  tcg_gen_movi_tl(s->A0, -1);
>                  tcg_gen_shl_tl(s->A0, s->A0, s->T1);
>                  tcg_gen_andc_tl(s->T0, s->T0, s->A0);
> -                gen_op_mov_reg_v(ot, reg, s->T0);
> +                gen_op_mov_reg_v(s, ot, reg, s->T0);
>                  gen_op_update1_cc(s);
>                  set_cc_op(s, CC_OP_BMILGB + ot);
>                  break;
> @@ -4071,7 +4071,7 @@ static void gen_sse(CPUX86State *env, DisasContext =
*s, int b,
>                      }
>                      tcg_gen_shr_tl(s->T0, s->T0, s->T1);
>                  }
> -                gen_op_mov_reg_v(ot, reg, s->T0);
> +                gen_op_mov_reg_v(s, ot, reg, s->T0);
>                  break;
>
>              case 0x0f3:
> @@ -4104,7 +4104,7 @@ static void gen_sse(CPUX86State *env, DisasContext =
*s, int b,
>                      goto unknown_op;
>                  }
>                  tcg_gen_mov_tl(cpu_cc_dst, s->T0);
> -                gen_op_mov_reg_v(ot, s->vex_v, s->T0);
> +                gen_op_mov_reg_v(s, ot, s->vex_v, s->T0);
>                  set_cc_op(s, CC_OP_BMILGB + ot);
>                  break;
>
> @@ -4145,7 +4145,7 @@ static void gen_sse(CPUX86State *env, DisasContext =
*s, int b,
>                      tcg_gen_ld8u_tl(s->T0, cpu_env, offsetof(CPUX86State,
>                                              xmm_regs[reg].ZMM_B(val & 15=
)));
>                      if (mod =3D=3D 3) {
> -                        gen_op_mov_reg_v(ot, rm, s->T0);
> +                        gen_op_mov_reg_v(s, ot, rm, s->T0);
>                      } else {
>                          tcg_gen_qemu_st_tl(s->T0, s->A0,
>                                             s->mem_index, MO_UB);
> @@ -4155,7 +4155,7 @@ static void gen_sse(CPUX86State *env, DisasContext =
*s, int b,
>                      tcg_gen_ld16u_tl(s->T0, cpu_env, offsetof(CPUX86Stat=
e,
>                                              xmm_regs[reg].ZMM_W(val & 7)=
));
>                      if (mod =3D=3D 3) {
> -                        gen_op_mov_reg_v(ot, rm, s->T0);
> +                        gen_op_mov_reg_v(s, ot, rm, s->T0);
>                      } else {
>                          tcg_gen_qemu_st_tl(s->T0, s->A0,
>                                             s->mem_index, MO_LEUW);
> @@ -4192,7 +4192,7 @@ static void gen_sse(CPUX86State *env, DisasContext =
*s, int b,
>                      tcg_gen_ld32u_tl(s->T0, cpu_env, offsetof(CPUX86Stat=
e,
>                                              xmm_regs[reg].ZMM_L(val & 3)=
));
>                      if (mod =3D=3D 3) {
> -                        gen_op_mov_reg_v(ot, rm, s->T0);
> +                        gen_op_mov_reg_v(s, ot, rm, s->T0);
>                      } else {
>                          tcg_gen_qemu_st_tl(s->T0, s->A0,
>                                             s->mem_index, MO_LEUL);
> @@ -4200,7 +4200,7 @@ static void gen_sse(CPUX86State *env, DisasContext =
*s, int b,
>                      break;
>                  case 0x20: /* pinsrb */
>                      if (mod =3D=3D 3) {
> -                        gen_op_mov_v_reg(MO_32, s->T0, rm);
> +                        gen_op_mov_v_reg(s, MO_32, s->T0, rm);
>                      } else {
>                          tcg_gen_qemu_ld_tl(s->T0, s->A0,
>                                             s->mem_index, MO_UB);
> @@ -4251,7 +4251,7 @@ static void gen_sse(CPUX86State *env, DisasContext =
*s, int b,
>                      } else { /* pinsrq */
>  #ifdef TARGET_X86_64
>                          if (mod =3D=3D 3) {
> -                            gen_op_mov_v_reg(ot, s->tmp1_i64, rm);
> +                            gen_op_mov_v_reg(s, ot, s->tmp1_i64, rm);
>                          } else {
>                              tcg_gen_qemu_ld_i64(s->tmp1_i64, s->A0,
>                                                  s->mem_index, MO_LEQ);
> @@ -4326,7 +4326,7 @@ static void gen_sse(CPUX86State *env, DisasContext =
*s, int b,
>                      tcg_gen_rotri_i32(s->tmp2_i32, s->tmp2_i32, b & 31);
>                      tcg_gen_extu_i32_tl(s->T0, s->tmp2_i32);
>                  }
> -                gen_op_mov_reg_v(ot, reg, s->T0);
> +                gen_op_mov_reg_v(s, ot, reg, s->T0);
>                  break;
>
>              default:
> @@ -4489,7 +4489,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>  #ifdef TARGET_X86_64
>      s->rex_x =3D 0;
>      s->rex_b =3D 0;
> -    x86_64_hregs =3D 0;
> +    s->x86_64_hregs =3D false;
>  #endif
>      s->rip_offset =3D 0; /* for relative ip address */
>      s->vex_l =3D 0;
> @@ -4548,7 +4548,8 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>              rex_r =3D (b & 0x4) << 1;
>              s->rex_x =3D (b & 0x2) << 2;
>              REX_B(s) =3D (b & 0x1) << 3;
> -            x86_64_hregs =3D 1; /* select uniform byte register addressi=
ng */
> +            /* select uniform byte register addressing */
> +            s->x86_64_hregs =3D true;
>              goto next_byte;
>          }
>          break;
> @@ -4576,7 +4577,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>                  goto illegal_op;
>              }
>  #ifdef TARGET_X86_64
> -            if (x86_64_hregs) {
> +            if (s->x86_64_hregs) {
>                  goto illegal_op;
>              }
>  #endif
> @@ -4681,12 +4682,12 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>                      /* xor reg, reg optimisation */
>                      set_cc_op(s, CC_OP_CLR);
>                      tcg_gen_movi_tl(s->T0, 0);
> -                    gen_op_mov_reg_v(ot, reg, s->T0);
> +                    gen_op_mov_reg_v(s, ot, reg, s->T0);
>                      break;
>                  } else {
>                      opreg =3D rm;
>                  }
> -                gen_op_mov_v_reg(ot, s->T1, reg);
> +                gen_op_mov_v_reg(s, ot, s->T1, reg);
>                  gen_op(s, op, ot, opreg);
>                  break;
>              case 1: /* OP Gv, Ev */
> @@ -4700,7 +4701,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>                  } else if (op =3D=3D OP_XORL && rm =3D=3D reg) {
>                      goto xor_zero;
>                  } else {
> -                    gen_op_mov_v_reg(ot, s->T1, rm);
> +                    gen_op_mov_v_reg(s, ot, s->T1, rm);
>                  }
>                  gen_op(s, op, ot, reg);
>                  break;
> @@ -4786,7 +4787,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>                  gen_op_ld_v(s, ot, s->T0, s->A0);
>              }
>          } else {
> -            gen_op_mov_v_reg(ot, s->T0, rm);
> +            gen_op_mov_v_reg(s, ot, s->T0, rm);
>          }
>
>          switch(op) {
> @@ -4809,7 +4810,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>                  if (mod !=3D 3) {
>                      gen_op_st_v(s, ot, s->T0, s->A0);
>                  } else {
> -                    gen_op_mov_reg_v(ot, rm, s->T0);
> +                    gen_op_mov_reg_v(s, ot, rm, s->T0);
>                  }
>              }
>              break;
> @@ -4847,7 +4848,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>                  if (mod !=3D 3) {
>                      gen_op_st_v(s, ot, s->T0, s->A0);
>                  } else {
> -                    gen_op_mov_reg_v(ot, rm, s->T0);
> +                    gen_op_mov_reg_v(s, ot, rm, s->T0);
>                  }
>              }
>              gen_op_update_neg_cc(s);
> @@ -4856,26 +4857,26 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>          case 4: /* mul */
>              switch(ot) {
>              case MO_8:
> -                gen_op_mov_v_reg(MO_8, s->T1, R_EAX);
> +                gen_op_mov_v_reg(s, MO_8, s->T1, R_EAX);
>                  tcg_gen_ext8u_tl(s->T0, s->T0);
>                  tcg_gen_ext8u_tl(s->T1, s->T1);
>                  /* XXX: use 32 bit mul which could be faster */
>                  tcg_gen_mul_tl(s->T0, s->T0, s->T1);
> -                gen_op_mov_reg_v(MO_16, R_EAX, s->T0);
> +                gen_op_mov_reg_v(s, MO_16, R_EAX, s->T0);
>                  tcg_gen_mov_tl(cpu_cc_dst, s->T0);
>                  tcg_gen_andi_tl(cpu_cc_src, s->T0, 0xff00);
>                  set_cc_op(s, CC_OP_MULB);
>                  break;
>              case MO_16:
> -                gen_op_mov_v_reg(MO_16, s->T1, R_EAX);
> +                gen_op_mov_v_reg(s, MO_16, s->T1, R_EAX);
>                  tcg_gen_ext16u_tl(s->T0, s->T0);
>                  tcg_gen_ext16u_tl(s->T1, s->T1);
>                  /* XXX: use 32 bit mul which could be faster */
>                  tcg_gen_mul_tl(s->T0, s->T0, s->T1);
> -                gen_op_mov_reg_v(MO_16, R_EAX, s->T0);
> +                gen_op_mov_reg_v(s, MO_16, R_EAX, s->T0);
>                  tcg_gen_mov_tl(cpu_cc_dst, s->T0);
>                  tcg_gen_shri_tl(s->T0, s->T0, 16);
> -                gen_op_mov_reg_v(MO_16, R_EDX, s->T0);
> +                gen_op_mov_reg_v(s, MO_16, R_EDX, s->T0);
>                  tcg_gen_mov_tl(cpu_cc_src, s->T0);
>                  set_cc_op(s, CC_OP_MULW);
>                  break;
> @@ -4905,29 +4906,29 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>          case 5: /* imul */
>              switch(ot) {
>              case MO_8:
> -                gen_op_mov_v_reg(MO_8, s->T1, R_EAX);
> +                gen_op_mov_v_reg(s, MO_8, s->T1, R_EAX);
>                  tcg_gen_ext8s_tl(s->T0, s->T0);
>                  tcg_gen_ext8s_tl(s->T1, s->T1);
>                  /* XXX: use 32 bit mul which could be faster */
>                  tcg_gen_mul_tl(s->T0, s->T0, s->T1);
> -                gen_op_mov_reg_v(MO_16, R_EAX, s->T0);
> +                gen_op_mov_reg_v(s, MO_16, R_EAX, s->T0);
>                  tcg_gen_mov_tl(cpu_cc_dst, s->T0);
>                  tcg_gen_ext8s_tl(s->tmp0, s->T0);
>                  tcg_gen_sub_tl(cpu_cc_src, s->T0, s->tmp0);
>                  set_cc_op(s, CC_OP_MULB);
>                  break;
>              case MO_16:
> -                gen_op_mov_v_reg(MO_16, s->T1, R_EAX);
> +                gen_op_mov_v_reg(s, MO_16, s->T1, R_EAX);
>                  tcg_gen_ext16s_tl(s->T0, s->T0);
>                  tcg_gen_ext16s_tl(s->T1, s->T1);
>                  /* XXX: use 32 bit mul which could be faster */
>                  tcg_gen_mul_tl(s->T0, s->T0, s->T1);
> -                gen_op_mov_reg_v(MO_16, R_EAX, s->T0);
> +                gen_op_mov_reg_v(s, MO_16, R_EAX, s->T0);
>                  tcg_gen_mov_tl(cpu_cc_dst, s->T0);
>                  tcg_gen_ext16s_tl(s->tmp0, s->T0);
>                  tcg_gen_sub_tl(cpu_cc_src, s->T0, s->tmp0);
>                  tcg_gen_shri_tl(s->T0, s->T0, 16);
> -                gen_op_mov_reg_v(MO_16, R_EDX, s->T0);
> +                gen_op_mov_reg_v(s, MO_16, R_EDX, s->T0);
>                  set_cc_op(s, CC_OP_MULW);
>                  break;
>              default:
> @@ -5026,7 +5027,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>              if (op >=3D 2 && op !=3D 3 && op !=3D 5)
>                  gen_op_ld_v(s, ot, s->T0, s->A0);
>          } else {
> -            gen_op_mov_v_reg(ot, s->T0, rm);
> +            gen_op_mov_v_reg(s, ot, s->T0, rm);
>          }
>
>          switch(op) {
> @@ -5115,7 +5116,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>          reg =3D ((modrm >> 3) & 7) | rex_r;
>
>          gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
> -        gen_op_mov_v_reg(ot, s->T1, reg);
> +        gen_op_mov_v_reg(s, ot, s->T1, reg);
>          gen_op_testl_T0_T1_cc(s);
>          set_cc_op(s, CC_OP_LOGICB + ot);
>          break;
> @@ -5125,7 +5126,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>          ot =3D mo_b_d(b, dflag);
>          val =3D insn_get(env, s, ot);
>
> -        gen_op_mov_v_reg(ot, s->T0, OR_EAX);
> +        gen_op_mov_v_reg(s, ot, s->T0, OR_EAX);
>          tcg_gen_movi_tl(s->T1, val);
>          gen_op_testl_T0_T1_cc(s);
>          set_cc_op(s, CC_OP_LOGICB + ot);
> @@ -5135,20 +5136,20 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>          switch (dflag) {
>  #ifdef TARGET_X86_64
>          case MO_64:
> -            gen_op_mov_v_reg(MO_32, s->T0, R_EAX);
> +            gen_op_mov_v_reg(s, MO_32, s->T0, R_EAX);
>              tcg_gen_ext32s_tl(s->T0, s->T0);
> -            gen_op_mov_reg_v(MO_64, R_EAX, s->T0);
> +            gen_op_mov_reg_v(s, MO_64, R_EAX, s->T0);
>              break;
>  #endif
>          case MO_32:
> -            gen_op_mov_v_reg(MO_16, s->T0, R_EAX);
> +            gen_op_mov_v_reg(s, MO_16, s->T0, R_EAX);
>              tcg_gen_ext16s_tl(s->T0, s->T0);
> -            gen_op_mov_reg_v(MO_32, R_EAX, s->T0);
> +            gen_op_mov_reg_v(s, MO_32, R_EAX, s->T0);
>              break;
>          case MO_16:
> -            gen_op_mov_v_reg(MO_8, s->T0, R_EAX);
> +            gen_op_mov_v_reg(s, MO_8, s->T0, R_EAX);
>              tcg_gen_ext8s_tl(s->T0, s->T0);
> -            gen_op_mov_reg_v(MO_16, R_EAX, s->T0);
> +            gen_op_mov_reg_v(s, MO_16, R_EAX, s->T0);
>              break;
>          default:
>              tcg_abort();
> @@ -5158,22 +5159,22 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>          switch (dflag) {
>  #ifdef TARGET_X86_64
>          case MO_64:
> -            gen_op_mov_v_reg(MO_64, s->T0, R_EAX);
> +            gen_op_mov_v_reg(s, MO_64, s->T0, R_EAX);
>              tcg_gen_sari_tl(s->T0, s->T0, 63);
> -            gen_op_mov_reg_v(MO_64, R_EDX, s->T0);
> +            gen_op_mov_reg_v(s, MO_64, R_EDX, s->T0);
>              break;
>  #endif
>          case MO_32:
> -            gen_op_mov_v_reg(MO_32, s->T0, R_EAX);
> +            gen_op_mov_v_reg(s, MO_32, s->T0, R_EAX);
>              tcg_gen_ext32s_tl(s->T0, s->T0);
>              tcg_gen_sari_tl(s->T0, s->T0, 31);
> -            gen_op_mov_reg_v(MO_32, R_EDX, s->T0);
> +            gen_op_mov_reg_v(s, MO_32, R_EDX, s->T0);
>              break;
>          case MO_16:
> -            gen_op_mov_v_reg(MO_16, s->T0, R_EAX);
> +            gen_op_mov_v_reg(s, MO_16, s->T0, R_EAX);
>              tcg_gen_ext16s_tl(s->T0, s->T0);
>              tcg_gen_sari_tl(s->T0, s->T0, 15);
> -            gen_op_mov_reg_v(MO_16, R_EDX, s->T0);
> +            gen_op_mov_reg_v(s, MO_16, R_EDX, s->T0);
>              break;
>          default:
>              tcg_abort();
> @@ -5197,7 +5198,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>              val =3D (int8_t)insn_get(env, s, MO_8);
>              tcg_gen_movi_tl(s->T1, val);
>          } else {
> -            gen_op_mov_v_reg(ot, s->T1, reg);
> +            gen_op_mov_v_reg(s, ot, s->T1, reg);
>          }
>          switch (ot) {
>  #ifdef TARGET_X86_64
> @@ -5227,7 +5228,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>              tcg_gen_mov_tl(cpu_cc_dst, s->T0);
>              tcg_gen_ext16s_tl(s->tmp0, s->T0);
>              tcg_gen_sub_tl(cpu_cc_src, s->T0, s->tmp0);
> -            gen_op_mov_reg_v(ot, reg, s->T0);
> +            gen_op_mov_reg_v(s, ot, reg, s->T0);
>              break;
>          }
>          set_cc_op(s, CC_OP_MULB + ot);
> @@ -5238,13 +5239,13 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>          modrm =3D x86_ldub_code(env, s);
>          reg =3D ((modrm >> 3) & 7) | rex_r;
>          mod =3D (modrm >> 6) & 3;
> -        gen_op_mov_v_reg(ot, s->T0, reg);
> +        gen_op_mov_v_reg(s, ot, s->T0, reg);
>          if (mod =3D=3D 3) {
>              rm =3D (modrm & 7) | REX_B(s);
> -            gen_op_mov_v_reg(ot, s->T1, rm);
> +            gen_op_mov_v_reg(s, ot, s->T1, rm);
>              tcg_gen_add_tl(s->T0, s->T0, s->T1);
> -            gen_op_mov_reg_v(ot, reg, s->T1);
> -            gen_op_mov_reg_v(ot, rm, s->T0);
> +            gen_op_mov_reg_v(s, ot, reg, s->T1);
> +            gen_op_mov_reg_v(s, ot, rm, s->T0);
>          } else {
>              gen_lea_modrm(env, s, modrm);
>              if (s->prefix & PREFIX_LOCK) {
> @@ -5256,7 +5257,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>                  tcg_gen_add_tl(s->T0, s->T0, s->T1);
>                  gen_op_st_v(s, ot, s->T0, s->A0);
>              }
> -            gen_op_mov_reg_v(ot, reg, s->T1);
> +            gen_op_mov_reg_v(s, ot, reg, s->T1);
>          }
>          gen_op_update2_cc(s);
>          set_cc_op(s, CC_OP_ADDB + ot);
> @@ -5273,7 +5274,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>              oldv =3D tcg_temp_new();
>              newv =3D tcg_temp_new();
>              cmpv =3D tcg_temp_new();
> -            gen_op_mov_v_reg(ot, newv, reg);
> +            gen_op_mov_v_reg(s, ot, newv, reg);
>              tcg_gen_mov_tl(cmpv, cpu_regs[R_EAX]);
>
>              if (s->prefix & PREFIX_LOCK) {
> @@ -5283,11 +5284,11 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>                  gen_lea_modrm(env, s, modrm);
>                  tcg_gen_atomic_cmpxchg_tl(oldv, s->A0, cmpv, newv,
>                                            s->mem_index, ot | MO_LE);
> -                gen_op_mov_reg_v(ot, R_EAX, oldv);
> +                gen_op_mov_reg_v(s, ot, R_EAX, oldv);
>              } else {
>                  if (mod =3D=3D 3) {
>                      rm =3D (modrm & 7) | REX_B(s);
> -                    gen_op_mov_v_reg(ot, oldv, rm);
> +                    gen_op_mov_v_reg(s, ot, oldv, rm);
>                  } else {
>                      gen_lea_modrm(env, s, modrm);
>                      gen_op_ld_v(s, ot, oldv, s->A0);
> @@ -5298,15 +5299,15 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>                  /* store value =3D (old =3D=3D cmp ? new : old);  */
>                  tcg_gen_movcond_tl(TCG_COND_EQ, newv, oldv, cmpv, newv, =
oldv);
>                  if (mod =3D=3D 3) {
> -                    gen_op_mov_reg_v(ot, R_EAX, oldv);
> -                    gen_op_mov_reg_v(ot, rm, newv);
> +                    gen_op_mov_reg_v(s, ot, R_EAX, oldv);
> +                    gen_op_mov_reg_v(s, ot, rm, newv);
>                  } else {
>                      /* Perform an unconditional store cycle like physica=
l cpu;
>                         must be before changing accumulator to ensure
>                         idempotency if the store faults and the instructi=
on
>                         is restarted */
>                      gen_op_st_v(s, ot, newv, s->A0);
> -                    gen_op_mov_reg_v(ot, R_EAX, oldv);
> +                    gen_op_mov_reg_v(s, ot, R_EAX, oldv);
>                  }
>              }
>              tcg_gen_mov_tl(cpu_cc_src, oldv);
> @@ -5351,14 +5352,14 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>          /**************************/
>          /* push/pop */
>      case 0x50 ... 0x57: /* push */
> -        gen_op_mov_v_reg(MO_32, s->T0, (b & 7) | REX_B(s));
> +        gen_op_mov_v_reg(s, MO_32, s->T0, (b & 7) | REX_B(s));
>          gen_push_v(s, s->T0);
>          break;
>      case 0x58 ... 0x5f: /* pop */
>          ot =3D gen_pop_T0(s);
>          /* NOTE: order is important for pop %sp */
>          gen_pop_update(s, ot);
> -        gen_op_mov_reg_v(ot, (b & 7) | REX_B(s), s->T0);
> +        gen_op_mov_reg_v(s, ot, (b & 7) | REX_B(s), s->T0);
>          break;
>      case 0x60: /* pusha */
>          if (CODE64(s))
> @@ -5388,7 +5389,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>              /* NOTE: order is important for pop %sp */
>              gen_pop_update(s, ot);
>              rm =3D (modrm & 7) | REX_B(s);
> -            gen_op_mov_reg_v(ot, rm, s->T0);
> +            gen_op_mov_reg_v(s, ot, rm, s->T0);
>          } else {
>              /* NOTE: order is important too for MMU exceptions */
>              s->popl_esp_hack =3D 1 << ot;
> @@ -5478,7 +5479,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>          if (mod !=3D 3) {
>              gen_op_st_v(s, ot, s->T0, s->A0);
>          } else {
> -            gen_op_mov_reg_v(ot, (modrm & 7) | REX_B(s), s->T0);
> +            gen_op_mov_reg_v(s, ot, (modrm & 7) | REX_B(s), s->T0);
>          }
>          break;
>      case 0x8a:
> @@ -5488,7 +5489,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>          reg =3D ((modrm >> 3) & 7) | rex_r;
>
>          gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
> -        gen_op_mov_reg_v(ot, reg, s->T0);
> +        gen_op_mov_reg_v(s, ot, reg, s->T0);
>          break;
>      case 0x8e: /* mov seg, Gv */
>          modrm =3D x86_ldub_code(env, s);
> @@ -5540,10 +5541,10 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>              rm =3D (modrm & 7) | REX_B(s);
>
>              if (mod =3D=3D 3) {
> -                if (s_ot =3D=3D MO_SB && byte_reg_is_xH(rm)) {
> +                if (s_ot =3D=3D MO_SB && byte_reg_is_xH(s, rm)) {
>                      tcg_gen_sextract_tl(s->T0, cpu_regs[rm - 4], 8, 8);
>                  } else {
> -                    gen_op_mov_v_reg(ot, s->T0, rm);
> +                    gen_op_mov_v_reg(s, ot, s->T0, rm);
>                      switch (s_ot) {
>                      case MO_UB:
>                          tcg_gen_ext8u_tl(s->T0, s->T0);
> @@ -5560,11 +5561,11 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>                          break;
>                      }
>                  }
> -                gen_op_mov_reg_v(d_ot, reg, s->T0);
> +                gen_op_mov_reg_v(s, d_ot, reg, s->T0);
>              } else {
>                  gen_lea_modrm(env, s, modrm);
>                  gen_op_ld_v(s, s_ot, s->T0, s->A0);
> -                gen_op_mov_reg_v(d_ot, reg, s->T0);
> +                gen_op_mov_reg_v(s, d_ot, reg, s->T0);
>              }
>          }
>          break;
> @@ -5579,7 +5580,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>              AddressParts a =3D gen_lea_modrm_0(env, s, modrm);
>              TCGv ea =3D gen_lea_modrm_1(s, a);
>              gen_lea_v_seg(s, s->aflag, ea, -1, -1);
> -            gen_op_mov_reg_v(dflag, reg, s->A0);
> +            gen_op_mov_reg_v(s, dflag, reg, s->A0);
>          }
>          break;
>
> @@ -5605,9 +5606,9 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>              gen_add_A0_ds_seg(s);
>              if ((b & 2) =3D=3D 0) {
>                  gen_op_ld_v(s, ot, s->T0, s->A0);
> -                gen_op_mov_reg_v(ot, R_EAX, s->T0);
> +                gen_op_mov_reg_v(s, ot, R_EAX, s->T0);
>              } else {
> -                gen_op_mov_v_reg(ot, s->T0, R_EAX);
> +                gen_op_mov_v_reg(s, ot, s->T0, R_EAX);
>                  gen_op_st_v(s, ot, s->T0, s->A0);
>              }
>          }
> @@ -5619,12 +5620,12 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>          gen_extu(s->aflag, s->A0);
>          gen_add_A0_ds_seg(s);
>          gen_op_ld_v(s, MO_8, s->T0, s->A0);
> -        gen_op_mov_reg_v(MO_8, R_EAX, s->T0);
> +        gen_op_mov_reg_v(s, MO_8, R_EAX, s->T0);
>          break;
>      case 0xb0 ... 0xb7: /* mov R, Ib */
>          val =3D insn_get(env, s, MO_8);
>          tcg_gen_movi_tl(s->T0, val);
> -        gen_op_mov_reg_v(MO_8, (b & 7) | REX_B(s), s->T0);
> +        gen_op_mov_reg_v(s, MO_8, (b & 7) | REX_B(s), s->T0);
>          break;
>      case 0xb8 ... 0xbf: /* mov R, Iv */
>  #ifdef TARGET_X86_64
> @@ -5634,7 +5635,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>              tmp =3D x86_ldq_code(env, s);
>              reg =3D (b & 7) | REX_B(s);
>              tcg_gen_movi_tl(s->T0, tmp);
> -            gen_op_mov_reg_v(MO_64, reg, s->T0);
> +            gen_op_mov_reg_v(s, MO_64, reg, s->T0);
>          } else
>  #endif
>          {
> @@ -5642,7 +5643,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>              val =3D insn_get(env, s, ot);
>              reg =3D (b & 7) | REX_B(s);
>              tcg_gen_movi_tl(s->T0, val);
> -            gen_op_mov_reg_v(ot, reg, s->T0);
> +            gen_op_mov_reg_v(s, ot, reg, s->T0);
>          }
>          break;
>
> @@ -5661,17 +5662,17 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>          if (mod =3D=3D 3) {
>              rm =3D (modrm & 7) | REX_B(s);
>          do_xchg_reg:
> -            gen_op_mov_v_reg(ot, s->T0, reg);
> -            gen_op_mov_v_reg(ot, s->T1, rm);
> -            gen_op_mov_reg_v(ot, rm, s->T0);
> -            gen_op_mov_reg_v(ot, reg, s->T1);
> +            gen_op_mov_v_reg(s, ot, s->T0, reg);
> +            gen_op_mov_v_reg(s, ot, s->T1, rm);
> +            gen_op_mov_reg_v(s, ot, rm, s->T0);
> +            gen_op_mov_reg_v(s, ot, reg, s->T1);
>          } else {
>              gen_lea_modrm(env, s, modrm);
> -            gen_op_mov_v_reg(ot, s->T0, reg);
> +            gen_op_mov_v_reg(s, ot, s->T0, reg);
>              /* for xchg, lock is implicit */
>              tcg_gen_atomic_xchg_tl(s->T1, s->A0, s->T0,
>                                     s->mem_index, ot | MO_LE);
> -            gen_op_mov_reg_v(ot, reg, s->T1);
> +            gen_op_mov_reg_v(s, ot, reg, s->T1);
>          }
>          break;
>      case 0xc4: /* les Gv */
> @@ -5704,7 +5705,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>          gen_op_ld_v(s, MO_16, s->T0, s->A0);
>          gen_movl_seg_T0(s, op);
>          /* then put the data */
> -        gen_op_mov_reg_v(ot, reg, s->T1);
> +        gen_op_mov_reg_v(s, ot, reg, s->T1);
>          if (s->base.is_jmp) {
>              gen_jmp_im(s, s->pc - s->cs_base);
>              gen_eob(s);
> @@ -5783,7 +5784,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>          } else {
>              opreg =3D rm;
>          }
> -        gen_op_mov_v_reg(ot, s->T1, reg);
> +        gen_op_mov_v_reg(s, ot, s->T1, reg);
>
>          if (shift) {
>              TCGv imm =3D tcg_const_tl(x86_ldub_code(env, s));
> @@ -6244,7 +6245,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>                  case 0:
>                      gen_helper_fnstsw(s->tmp2_i32, cpu_env);
>                      tcg_gen_extu_i32_tl(s->T0, s->tmp2_i32);
> -                    gen_op_mov_reg_v(MO_16, R_EAX, s->T0);
> +                    gen_op_mov_reg_v(s, MO_16, R_EAX, s->T0);
>                      break;
>                  default:
>                      goto unknown_op;
> @@ -6397,7 +6398,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>  	}
>          tcg_gen_movi_i32(s->tmp2_i32, val);
>          gen_helper_in_func(ot, s->T1, s->tmp2_i32);
> -        gen_op_mov_reg_v(ot, R_EAX, s->T1);
> +        gen_op_mov_reg_v(s, ot, R_EAX, s->T1);
>          gen_bpt_io(s, s->tmp2_i32, ot);
>          if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
>              gen_io_end();
> @@ -6411,7 +6412,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>          tcg_gen_movi_tl(s->T0, val);
>          gen_check_io(s, ot, pc_start - s->cs_base,
>                       svm_is_rep(prefixes));
> -        gen_op_mov_v_reg(ot, s->T1, R_EAX);
> +        gen_op_mov_v_reg(s, ot, s->T1, R_EAX);
>
>          if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
>              gen_io_start();
> @@ -6436,7 +6437,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>  	}
>          tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
>          gen_helper_in_func(ot, s->T1, s->tmp2_i32);
> -        gen_op_mov_reg_v(ot, R_EAX, s->T1);
> +        gen_op_mov_reg_v(s, ot, R_EAX, s->T1);
>          gen_bpt_io(s, s->tmp2_i32, ot);
>          if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
>              gen_io_end();
> @@ -6449,7 +6450,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>          tcg_gen_ext16u_tl(s->T0, cpu_regs[R_EDX]);
>          gen_check_io(s, ot, pc_start - s->cs_base,
>                       svm_is_rep(prefixes));
> -        gen_op_mov_v_reg(ot, s->T1, R_EAX);
> +        gen_op_mov_v_reg(s, ot, s->T1, R_EAX);
>
>          if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
>              gen_io_start();
> @@ -6708,7 +6709,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>      case 0x9e: /* sahf */
>          if (CODE64(s) && !(s->cpuid_ext3_features & CPUID_EXT3_LAHF_LM))
>              goto illegal_op;
> -        gen_op_mov_v_reg(MO_8, s->T0, R_AH);
> +        gen_op_mov_v_reg(s, MO_8, s->T0, R_AH);
>          gen_compute_eflags(s);
>          tcg_gen_andi_tl(cpu_cc_src, cpu_cc_src, CC_O);
>          tcg_gen_andi_tl(s->T0, s->T0, CC_S | CC_Z | CC_A | CC_P | CC_C);
> @@ -6720,7 +6721,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>          gen_compute_eflags(s);
>          /* Note: gen_compute_eflags() only gives the condition codes */
>          tcg_gen_ori_tl(s->T0, cpu_cc_src, 0x02);
> -        gen_op_mov_reg_v(MO_8, R_AH, s->T0);
> +        gen_op_mov_reg_v(s, MO_8, R_AH, s->T0);
>          break;
>      case 0xf5: /* cmc */
>          gen_compute_eflags(s);
> @@ -6758,7 +6759,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>                  gen_op_ld_v(s, ot, s->T0, s->A0);
>              }
>          } else {
> -            gen_op_mov_v_reg(ot, s->T0, rm);
> +            gen_op_mov_v_reg(s, ot, s->T0, rm);
>          }
>          /* load shift */
>          val =3D x86_ldub_code(env, s);
> @@ -6784,7 +6785,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>          reg =3D ((modrm >> 3) & 7) | rex_r;
>          mod =3D (modrm >> 6) & 3;
>          rm =3D (modrm & 7) | REX_B(s);
> -        gen_op_mov_v_reg(MO_32, s->T1, reg);
> +        gen_op_mov_v_reg(s, MO_32, s->T1, reg);
>          if (mod !=3D 3) {
>              AddressParts a =3D gen_lea_modrm_0(env, s, modrm);
>              /* specific case: we need to add a displacement */
> @@ -6797,7 +6798,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>                  gen_op_ld_v(s, ot, s->T0, s->A0);
>              }
>          } else {
> -            gen_op_mov_v_reg(ot, s->T0, rm);
> +            gen_op_mov_v_reg(s, ot, s->T0, rm);
>          }
>      bt_op:
>          tcg_gen_andi_tl(s->T1, s->T1, (1 << (3 + ot)) - 1);
> @@ -6847,7 +6848,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>                  if (mod !=3D 3) {
>                      gen_op_st_v(s, ot, s->T0, s->A0);
>                  } else {
> -                    gen_op_mov_reg_v(ot, rm, s->T0);
> +                    gen_op_mov_reg_v(s, ot, rm, s->T0);
>                  }
>              }
>          }
> @@ -6930,7 +6931,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>                  tcg_gen_ctz_tl(s->T0, s->T0, cpu_regs[reg]);
>              }
>          }
> -        gen_op_mov_reg_v(ot, reg, s->T0);
> +        gen_op_mov_reg_v(s, ot, reg, s->T0);
>          break;
>          /************************/
>          /* bcd */
> @@ -7070,7 +7071,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>          mod =3D (modrm >> 6) & 3;
>          if (mod =3D=3D 3)
>              goto illegal_op;
> -        gen_op_mov_v_reg(ot, s->T0, reg);
> +        gen_op_mov_v_reg(s, ot, s->T0, reg);
>          gen_lea_modrm(env, s, modrm);
>          tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
>          if (ot =3D=3D MO_16) {
> @@ -7083,16 +7084,16 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>          reg =3D (b & 7) | REX_B(s);
>  #ifdef TARGET_X86_64
>          if (dflag =3D=3D MO_64) {
> -            gen_op_mov_v_reg(MO_64, s->T0, reg);
> +            gen_op_mov_v_reg(s, MO_64, s->T0, reg);
>              tcg_gen_bswap64_i64(s->T0, s->T0);
> -            gen_op_mov_reg_v(MO_64, reg, s->T0);
> +            gen_op_mov_reg_v(s, MO_64, reg, s->T0);
>          } else
>  #endif
>          {
> -            gen_op_mov_v_reg(MO_32, s->T0, reg);
> +            gen_op_mov_v_reg(s, MO_32, s->T0, reg);
>              tcg_gen_ext32u_tl(s->T0, s->T0);
>              tcg_gen_bswap32_tl(s->T0, s->T0);
> -            gen_op_mov_reg_v(MO_32, reg, s->T0);
> +            gen_op_mov_reg_v(s, MO_32, reg, s->T0);
>          }
>          break;
>      case 0xd6: /* salc */
> @@ -7100,7 +7101,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>              goto illegal_op;
>          gen_compute_eflags_c(s, s->T0);
>          tcg_gen_neg_tl(s->T0, s->T0);
> -        gen_op_mov_reg_v(MO_8, R_EAX, s->T0);
> +        gen_op_mov_reg_v(s, MO_8, R_EAX, s->T0);
>          break;
>      case 0xe0: /* loopnz */
>      case 0xe1: /* loopz */
> @@ -7661,16 +7662,16 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>              rm =3D (modrm & 7) | REX_B(s);
>
>              if (mod =3D=3D 3) {
> -                gen_op_mov_v_reg(MO_32, s->T0, rm);
> +                gen_op_mov_v_reg(s, MO_32, s->T0, rm);
>                  /* sign extend */
>                  if (d_ot =3D=3D MO_64) {
>                      tcg_gen_ext32s_tl(s->T0, s->T0);
>                  }
> -                gen_op_mov_reg_v(d_ot, reg, s->T0);
> +                gen_op_mov_reg_v(s, d_ot, reg, s->T0);
>              } else {
>                  gen_lea_modrm(env, s, modrm);
>                  gen_op_ld_v(s, MO_32 | MO_SIGN, s->T0, s->A0);
> -                gen_op_mov_reg_v(d_ot, reg, s->T0);
> +                gen_op_mov_reg_v(s, d_ot, reg, s->T0);
>              }
>          } else
>  #endif
> @@ -7694,10 +7695,10 @@ static target_ulong disas_insn(DisasContext *s, C=
PUState *cpu)
>                  a0 =3D tcg_temp_local_new();
>                  tcg_gen_mov_tl(a0, s->A0);
>              } else {
> -                gen_op_mov_v_reg(ot, t0, rm);
> +                gen_op_mov_v_reg(s, ot, t0, rm);
>                  a0 =3D NULL;
>              }
> -            gen_op_mov_v_reg(ot, t1, reg);
> +            gen_op_mov_v_reg(s, ot, t1, reg);
>              tcg_gen_andi_tl(s->tmp0, t0, 3);
>              tcg_gen_andi_tl(t1, t1, 3);
>              tcg_gen_movi_tl(t2, 0);
> @@ -7711,7 +7712,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>                  gen_op_st_v(s, ot, t0, a0);
>                  tcg_temp_free(a0);
>             } else {
> -                gen_op_mov_reg_v(ot, rm, t0);
> +                gen_op_mov_reg_v(s, ot, rm, t0);
>              }
>              gen_compute_eflags(s);
>              tcg_gen_andi_tl(cpu_cc_src, cpu_cc_src, ~CC_Z);
> @@ -7742,7 +7743,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>              tcg_gen_andi_tl(s->tmp0, cpu_cc_src, CC_Z);
>              label1 =3D gen_new_label();
>              tcg_gen_brcondi_tl(TCG_COND_EQ, s->tmp0, 0, label1);
> -            gen_op_mov_reg_v(ot, reg, t0);
> +            gen_op_mov_reg_v(s, ot, reg, t0);
>              gen_set_label(label1);
>              set_cc_op(s, CC_OP_EFLAGS);
>              tcg_temp_free(t0);
> @@ -7996,7 +7997,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>                      if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
>                          gen_io_start();
>                      }
> -                    gen_op_mov_v_reg(ot, s->T0, rm);
> +                    gen_op_mov_v_reg(s, ot, s->T0, rm);
>                      gen_helper_write_crN(cpu_env, tcg_const_i32(reg),
>                                           s->T0);
>                      if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
> @@ -8009,7 +8010,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>                          gen_io_start();
>                      }
>                      gen_helper_read_crN(s->T0, cpu_env, tcg_const_i32(re=
g));
> -                    gen_op_mov_reg_v(ot, rm, s->T0);
> +                    gen_op_mov_reg_v(s, ot, rm, s->T0);
>                      if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
>                          gen_io_end();
>                      }
> @@ -8042,7 +8043,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>              }
>              if (b & 2) {
>                  gen_svm_check_intercept(s, pc_start, SVM_EXIT_WRITE_DR0 =
+ reg);
> -                gen_op_mov_v_reg(ot, s->T0, rm);
> +                gen_op_mov_v_reg(s, ot, s->T0, rm);
>                  tcg_gen_movi_i32(s->tmp2_i32, reg);
>                  gen_helper_set_dr(cpu_env, s->tmp2_i32, s->T0);
>                  gen_jmp_im(s, s->pc - s->cs_base);
> @@ -8051,7 +8052,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>                  gen_svm_check_intercept(s, pc_start, SVM_EXIT_READ_DR0 +=
 reg);
>                  tcg_gen_movi_i32(s->tmp2_i32, reg);
>                  gen_helper_get_dr(s->T0, cpu_env, s->tmp2_i32);
> -                gen_op_mov_reg_v(ot, rm, s->T0);
> +                gen_op_mov_reg_v(s, ot, rm, s->T0);
>              }
>          }
>          break;
> @@ -8313,7 +8314,7 @@ static target_ulong disas_insn(DisasContext *s, CPU=
State *cpu)
>          gen_extu(ot, s->T0);
>          tcg_gen_mov_tl(cpu_cc_src, s->T0);
>          tcg_gen_ctpop_tl(s->T0, s->T0);
> -        gen_op_mov_reg_v(ot, reg, s->T0);
> +        gen_op_mov_reg_v(s, ot, reg, s->T0);
>
>          set_cc_op(s, CC_OP_POPCNT);
>          break;


--
Alex Benn=C3=A9e
