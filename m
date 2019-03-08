Received: from eggs.gnu.org ([209.51.188.92]:50672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h24Fg-00084I-VL
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:24:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h24Fe-0007FH-QZ
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:24:44 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:45401)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h24FR-0006zY-Ra
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:24:35 -0500
Received: by mail-pg1-x544.google.com with SMTP id 125so12482147pgc.12
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 17:24:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
References: <20190122121413.31437-1-ysato@users.sourceforge.jp>
	<20190302062138.10713-1-ysato@users.sourceforge.jp>
Message-ID: <341d5ff2-5d1e-56ad-8fc2-dc0c7b7f8335@linaro.org>
Date: Thu, 7 Mar 2019 17:24:23 -0800
MIME-Version: 1.0
In-Reply-To: <20190302062138.10713-1-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v3 00/11] Add RX archtecture support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

On 3/1/19 10:21 PM, Yoshinori Sato wrote:
> My git repository is bellow.
> git://git.pf.osdn.net/gitroot/y/ys/ysato/qemu.git

Somehow patch 1 did not arrive, so I am reviewing based on
rebasing this branch against master, and then looking at the diff.

> +struct CCop;

Unused?

> +static inline void cpu_get_tb_cpu_state(CPURXState *env, target_ulong *pc,
> +                                        target_ulong *cs_base, uint32_t *flags)
> +{
> +    *pc = env->pc;
> +    *cs_base = 0;
> +    *flags = 0;
> +}

*flags should contain PSW[PM], I think, so that knowledge of the
privilege level is given to the translator.

Looking forward I see that you're currently testing cpu_psw_pm dynamically for
instructions that require privs, so what you have is not wrong, but this is
exactly the sort of thing that TB flags are for.

> +#define RX_PSW_OP_NEG 4

Unused?

> +#define RX_BYTE 0
> +#define RX_WORD 1
> +#define RX_LONG 2

Redundant with TCGMemOps: MO_8, MO_16, MO_32?

> +++ b/target/rx/insns.decode

Should have a copyright + license notice.

> +BCnd_b         0010 cd:4 dsp:8                         &bcnd
...
> +#BRA_b         0010 1110 dsp:8         # overlaps BCnd_b

FYI, using pattern groups this can be written

{
  BRA_b        0010 1110 dsp:8
  Bcnd_b       0010 cd:4 dsp:8
}

I expect to have pattern groups merged this week.

> +static void rx_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
> +{
> +    DisasContext *ctx = container_of(dcbase, DisasContext, base);
> +
> +    ctx->src = tcg_temp_new();
> +}

This allocation will not survive across a branch or label.
So, after any SHIFTR_REG, for instance.

I think you need to allocate this on demand each insn, and
free it as necessary after each insn.

(Although avoiding branches in tcg is always helpful.)

> +/* generic load / store wrapper */
> +static inline void rx_gen_ldst(unsigned int size, unsigned int dir,
> +                        TCGv reg, TCGv mem)
> +{
> +    if (dir) {
> +        tcg_gen_qemu_ld_i32(reg, mem, 0, size | MO_SIGN | MO_TE);
> +    } else {
> +        tcg_gen_qemu_st_i32(reg, mem, 0, size | MO_TE);
> +    }
> +}

It would probably be worthwhile to split this function, and drop the "dir"
parameter.  It is always a constant, so instead of

  rx_gen_ldst(mi, RX_MEMORY_LD, ctx->src, ctx->src);
  rx_gen_ldst(a->sz, RX_MEMORY_ST, cpu_regs[a->rs], ctx->src);

use the shorter

  rx_gen_ld(mi, ctx->src, ctx->src);
  rx_gen_st(a->sz, cpu_regs[a->rs], ctx->src);


> +/* mov.l #uimm4,rd */
> +/* mov.l #uimm8,rd */
> +static bool trans_MOV_ri(DisasContext *ctx, arg_MOV_ri *a)
> +{
> +    tcg_gen_movi_i32(cpu_regs[a->rd], a->imm & 0xff);
> +    return true;
> +}

a->imm will already have been masked by the decode.
You can drop the & 0xff here.

> +/* mov.l #imm,rd */
> +static bool trans_MOV_rli(DisasContext *ctx, arg_MOV_rli *a)
> +{
> +    tcg_gen_movi_i32(cpu_regs[a->rd], a->imm);
> +    return true;
> +}

As written, this function is redundant.  We should be using the same MOV_ri,
with the immediate loaded from %b2_li_2.

Likewise for trans_MOV_mi vs trans_MOV_mli.  That said...

> +static bool trans_MOV_mli(DisasContext *ctx, arg_MOV_mli *a)
> +{
> +    TCGv imm = tcg_const_i32(a->imm);
> +    if (a->ld == 2) {
> +        a->dsp = bswap_16(a->dsp);
> +    }

This suggests that the decode is incorrect.  Or perhaps the construction of the
32-bit insn passed into decode.  In decode_load_bytes, we construct a
big-endian value, so it would seem this dsp field should be loaded as a
little-endian value.

This could be fixed by not attempting to load the LI constant in decodetree
(for this insn), which would in turn not require that you decode the LD operand
by hand in decodetree.  E.g.

static bool trans_MOV_mli(DisasContext *ctx, arg_MOV_mli *a)
{
    TCGv imm;

    /* dsp operand comes before immediate operand */
    rx_index_addr(a->ld, a->sz, a->rd, s);
    imm = tcg_const_i32(li(s, a->li));
    rx_gen_st(a->sz, imm, ctx->src);
    tcg_temp_free_i32(imm);
    return true;
}

This will be easiest if you ever support the big-endian version of RX.

> +/* push rs */
> +static bool trans_PUSH_r(DisasContext *ctx, arg_PUSH_r *a)
> +{
> +    if (a->rs != 0) {
> +        tcg_gen_subi_i32(cpu_regs[0], cpu_regs[0], 4);
> +        rx_gen_ldst(a->sz, RX_MEMORY_ST, cpu_regs[a->rs], cpu_regs[0]);
> +    } else {
> +        tcg_gen_mov_i32(ctx->src, cpu_regs[a->rs]);
> +        tcg_gen_subi_i32(cpu_regs[0], cpu_regs[0], 4);
> +        rx_gen_ldst(a->sz, RX_MEMORY_ST, ctx->src, cpu_regs[0]);
> +    }
> +    return true;

As far as I can see the THEN and ELSE cases have identical operation.

> +static bool trans_XCHG_rl(DisasContext *ctx, arg_XCHG_rl *a)
> +{
> +    int sz;
> +    TCGv tmp;
> +    tmp = tcg_temp_new();
> +    if (a->ld == 3) {
> +       /* xchg rs,rd */
> +        tcg_gen_mov_i32(tmp, cpu_regs[a->rs]);
> +        tcg_gen_mov_i32(cpu_regs[a->rs], cpu_regs[a->rd]);
> +        tcg_gen_mov_i32(cpu_regs[a->rd], tmp);
> +    } else {
> +        switch (a->mi) {
> +        case 0 ... 2:
> +            rx_index_addr(a->ld, a->mi, a->rs, ctx);
> +            rx_gen_ldst(a->mi, RX_MEMORY_LD, tmp, ctx->src);
> +            sz = a->mi;
> +            break;
> +        case 3:
> +            rx_index_addr(a->ld, RX_MEMORY_WORD, a->rs, ctx);
> +            rx_gen_ldu(RX_MEMORY_WORD, tmp, ctx->src);
> +            sz = RX_MEMORY_WORD;
> +            break;
> +        case 4:
> +            rx_index_addr(a->ld, RX_MEMORY_BYTE, a->rs, ctx);
> +            rx_gen_ldu(RX_MEMORY_BYTE, tmp, ctx->src);
> +            sz = RX_MEMORY_BYTE;
> +            break;
> +        }
> +        rx_gen_ldst(sz, RX_MEMORY_ST, cpu_regs[a->rd], ctx->src);
> +        tcg_gen_mov_i32(cpu_regs[a->rd], tmp);
> +    }

While I doubt that there is an SMP RX cpu, I think this should still implement
an atomic xchg operation.  This will allow rx-linux-user to run on SMP host
cpus.  Thus use

static inline TCGMemOp mi_to_mop(unsigned mi)
{
    static const TCGMemOp mop[5] = { MO_SB, MO_SW, MO_UL, MO_UH, MO_UB };
    tcg_debug_assert(mi < 5);
    return mop[mi];
}

  tcg_gen_atomic_xchg_i32(cpu_regs[a->rd], ctx->src, cpu_regs[a->rd],
                          0, mi_to_mop(a->mi));


> +#define STCOND(cond)                                                    \
> +    do {                                                                \
> +        tcg_gen_movi_i32(ctx->imm, a->imm);            \
> +        tcg_gen_movi_i32(ctx->one, 1);                                  \
> +        tcg_gen_movcond_i32(cond, cpu_regs[a->rd], cpu_psw_z,           \
> +                            ctx->one, ctx->imm, cpu_regs[a->rd]);       \
> +        return true;                                                    \
> +    } while(0)

Unused?  This seems close to what you wanted instead of...

> +#define STZFN(maskop)                                                   \
> +    do {                                                                \
> +        TCGv mask, imm;                                                 \
> +        mask = tcg_temp_new();                                          \
> +        imm = tcg_temp_new();                                           \
> +        maskop;                                                         \
> +        tcg_gen_andi_i32(imm, mask, a->imm);                            \
> +        tcg_gen_andc_i32(cpu_regs[a->rd], cpu_regs[a->rd], mask);       \
> +        tcg_gen_or_i32(cpu_regs[a->rd], cpu_regs[a->rd], imm);          \
> +        tcg_temp_free(mask);                                            \
> +        tcg_temp_free(imm);                                             \
> +        return true;                                                    \
> +    } while(0)

... this.

  TCGv zero = tcg_const_i32(0);
  TCGv imm = tcg_const_i32(a->imm);
  tcg_gen_movcond(COND, cpu_regs[a->rd], cpu_psw_z, zero,
                  imm, cpu_regs[a->rd]);

where trans_STZ passes TCG_COND_NE and STNZ passes TCG_COND_EQ.

In addition, there's no point in using a #define when a function would work
just as well.

> +#define GEN_LOGIC_OP(opr, ret, arg1, arg2) \
> +    do {                                                                \
> +        opr(ret, arg1, arg2);                                       \
> +        tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_psw_z, ret, 0);           \
> +        tcg_gen_setcondi_i32(TCG_COND_GEU, cpu_psw_s, ret, 0x80000000UL); \
> +    } while(0)

Note that the second is the same as

  tcg_gen_setcondi_i32(TCG_COND_LT, cpu_psw_s, ret, 0);
or
  tcg_gen_shri_i32(cpu_psw_s, ret, 31);

That said, this extra computation is exactly why ARM (and others) represent the
flag differently in the field.  The inline setting would be

  tcg_gen_mov_i32(cpu_psw_z, ret);
  tcg_gen_mov_i32(cpu_psw_s, ret);

And then whenever we *use* these flags, we only look at the sign bit of S, and
we see if the whole of Z is zero/non-zero.  Similarly, the overflow flag is
also stored in the sign bit of O, so that is computed more easily:

  O = (ret ^ in1) & ~(in1 & in2)

with no right-shift required at the end.

This also means that we've reduced the amount of inline computation to the
point that there is no point in *not* doing the computation every time it is
required, and so update_psw_o and cpu->psw_v[] goes away.

Again, no reason for a macro when a function will do.
They are easier to debug.

> +    rs = (a->rs2 < 16) ? a->rs2 : a->rd;

Is this due to

> @b2_rds_uimm4   .... .... imm:4 rd:4            &rri rs2=255 len=2

this?  A better decode is

@b2_rds_uimm4   .... .... imm:4 rd:4    &rri rs2=%b2_r_0 len=2

i.e. extract the rd field twice.  Once directly into rd and again from the same
bits into rs2.

> +/* revw rs, rd */
> +static bool trans_REVW(DisasContext *ctx, arg_REVW *a)
> +{
> +    TCGv hi, lo;
> +
> +    hi = tcg_temp_new();
> +    lo = tcg_temp_new();
> +    tcg_gen_shri_i32(hi, cpu_regs[a->rs], 16);
> +    tcg_gen_bswap16_i32(hi, hi);
> +    tcg_gen_shli_i32(hi, hi, 16);
> +    tcg_gen_bswap16_i32(lo, cpu_regs[a->rs]);
> +    tcg_gen_or_i32(cpu_regs[a->rd], hi, lo);
> +    tcg_temp_free(hi);
> +    tcg_temp_free(lo);
> +    return true;
> +}

The bswap16 primitive requires the input to be zero-extended.
Thus this second bswap16 may fail.  Perhaps better as

  T0 = 0x00ff00ff;
  T1 = RS & T0;
  T2 = RS >> 8;
  T1 = T1 << 8;
  T2 = T2 & T0;
  RD = T1 | T2;

> +/* conditional branch helper */
> +static void rx_bcnd_main(DisasContext *ctx, int cd, int dst, int len)
> +{
> +        TCGv t, f, cond;
> +        switch(cd) {
> +        case 0 ... 13:

Indentation is off?

> +static bool trans_BCnd_s(DisasContext *ctx, arg_BCnd_s *a)
> +{
> +    if (a->dsp < 3)
> +        a->dsp += 8;

This bit should probably be in the decode, via !function.

> +static int16_t rev16(uint16_t dsp)
> +{
> +    return ((dsp << 8) & 0xff00) | ((dsp >> 8) & 0x00ff);
> +}
> +
> +static int32_t rev24(uint32_t dsp)
> +{
> +    dsp = ((dsp << 16) & 0xff0000) |
> +        (dsp & 0x00ff00) |
> +        ((dsp >> 16) & 0x0000ff);
> +    dsp |= (dsp & 0x00800000) ? 0xff000000 : 0x00000000;
> +    return dsp;
> +}

These could also be in the decode, probably with %some_field.
But as with MOV above, maybe ought to be done via an explicit
call to li(), in order to get a (potential) big-endian RX to work.

Also, watch out for CODING_STYLE violations.
Please recheck everything with ./scripts/checkpatch.pl.

> +/* mvtachi rs */
> +static bool trans_MVTACHI(DisasContext *ctx, arg_MVTACHI *a)
> +{
> +    TCGv_i32 hi, lo;
> +    hi = tcg_temp_new_i32();
> +    lo = tcg_temp_new_i32();
> +    tcg_gen_extr_i64_i32(lo, hi, cpu_acc);
> +    tcg_gen_concat_i32_i64(cpu_acc, lo, cpu_regs[a->rs]);
> +    tcg_temp_free_i32(hi);
> +    tcg_temp_free_i32(lo);
> +    return true;
> +}

Hmm.  How about

   TCGv_i64 rs64 = tcg_temp_new_i64();
   tcg_gen_extu_i32_i64(rs64, cpu_regs[a->rs]);
   tcg_gen_deposit_i64(cpu_acc, cpu_acc, rs64, 32, 32);

> +static inline void clrsetpsw(int dst, int mode)
> +{
> +    TCGv psw[] = {
> +        cpu_psw_c, cpu_psw_z, cpu_psw_s, cpu_psw_o,
> +        NULL, NULL, NULL, NULL,
> +        cpu_psw_i, cpu_psw_u, NULL, NULL,
> +        NULL, NULL, NULL, NULL
> +    };
> +    TCGLabel *skip;
> +
> +    skip = gen_new_label();
> +    if (dst >= 8)
> +        tcg_gen_brcondi_i32(TCG_COND_NE, cpu_psw_pm, 0, skip);
> +    tcg_gen_movi_i32(psw[dst], mode);
> +    if (dst == 3)
> +        tcg_gen_movi_i32(cpu_pswop, RX_PSW_OP_NONE);
> +    gen_set_label(skip);
> +}

When clearing psw_i, you'll need to exit to the main loop so that any pending
interrupts are recognized.  Otherwise you risk going around in a loop and never
delivering the interrupt at all.

> +/* rtfi */
> +static bool trans_RTFI(DisasContext *ctx, arg_RTFI *a)
> +{
> +    check_previleged();
> +    tcg_gen_mov_i32(cpu_pc, cpu_bpc);
> +    tcg_gen_mov_i32(cpu_psw, cpu_bpsw);
> +    gen_helper_unpack_psw(cpu_env);
> +    ctx->base.is_jmp = DISAS_JUMP;
> +    return true;
> +}

Likewise, you need to exit to the main loop, because psw_i changed.

> +    cpu_pswop = tcg_global_mem_new_i32(cpu_env,
> +                                     offsetof(CPURXState, psw_op), "");
> +    for (i = 0; i < 3; i++) {
> +        cpu_pswop_v[i] = tcg_global_mem_new_i32(cpu_env,
> +                                                offsetof(CPURXState, psw_v[i]), "");

Using the empty string for the name of a temp is cruel.
That'll be very hard to debug.

> +uint32_t psw_cond(CPURXState *env, uint32_t cond)

In general this can be inlined fairly easily.
See, for instance, target/arm/translate.c, arm_test_cc.

> +uint32_t helper_div(CPURXState *env, uint32_t num, uint32_t den)
> +{
> +    uint32_t ret = num;
> +    if (den != 0) {
> +        ret = (int32_t)num / (int32_t)den;
> +    }
> +    env->psw_o = (ret == 0 || den == 0);

That is not the correct overflow condition.
ret == 0 is irrelevant, but INT_MIN / -1 is relevant.


Finally, this was way too big to review properly.  This patch set will need to
be broken up into smaller pieces.  Perhaps introducing just one, or a few
related instructions with each patch.


r~
