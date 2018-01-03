Received: from eggs.gnu.org ([2001:4830:134:3::10]:59144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWqhZ-00030m-8C
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:35:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWqhV-0000Ty-W7
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:35:57 -0500
Received: from mail-pl0-x230.google.com ([2607:f8b0:400e:c01::230]:39993)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eWqhV-0000Sv-LA
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:35:53 -0500
Received: by mail-pl0-x230.google.com with SMTP id 62so2003633pld.7
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 13:35:53 -0800 (PST)
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<1514940265-18093-9-git-send-email-mjc@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9e14e29c-101f-cc9d-94d0-13226c66a724@linaro.org>
Date: Wed, 3 Jan 2018 13:35:49 -0800
MIME-Version: 1.0
In-Reply-To: <1514940265-18093-9-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 08/21] RISC-V TCG Code Generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On 01/02/2018 04:44 PM, Michael Clark wrote:
> +typedef struct DisasContext {
> +    struct TranslationBlock *tb;
> +    target_ulong pc;
> +    target_ulong next_pc;
> +    uint32_t opcode;
> +    int singlestep_enabled;
> +    int mem_idx;
> +    int bstate;
> +} DisasContext;
> +
> +static inline void kill_unknown(DisasContext *ctx, int excp);
> +
> +enum {
> +    BS_NONE     = 0, /* When seen outside of translation while loop, indicates
> +                     need to exit tb due to end of page. */
> +    BS_STOP     = 1, /* Need to exit tb for syscall, sret, etc. */
> +    BS_BRANCH   = 2, /* Need to exit tb for branch, jal, etc. */
> +};

I would prefer this to be updated to use exec/translator.h, TranslatorOps.
However, please use DisasJumpType and DisasContextBase right away.


> +static inline void generate_exception(DisasContext *ctx, int excp)
> +{
> +    tcg_gen_movi_tl(cpu_pc, ctx->pc);
> +    TCGv_i32 helper_tmp = tcg_const_i32(excp);
> +    gen_helper_raise_exception(cpu_env, helper_tmp);
> +    tcg_temp_free_i32(helper_tmp);
> +}

Drop inline unless required.  Let the compiler choose.

> +static inline void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
> +{
> +    if (use_goto_tb(ctx, dest)) {
> +        /* chaining is only allowed when the jump is to the same page */
> +        tcg_gen_goto_tb(n);
> +        tcg_gen_movi_tl(cpu_pc, dest);
> +        tcg_gen_exit_tb((uintptr_t)ctx->tb + n);
> +    } else {
> +        tcg_gen_movi_tl(cpu_pc, dest);
> +        if (ctx->singlestep_enabled) {
> +            gen_helper_raise_exception_debug(cpu_env);
> +        }

else

> +        tcg_gen_exit_tb(0);

tcg_gen_lookup_and_goto_ptr

and set ctx->base.is_jmp = DISAS_NORETURN.

> +static void gen_fsgnj(DisasContext *ctx, uint32_t rd, uint32_t rs1,
> +    uint32_t rs2, int rm, uint64_t min)
> +{
> +    TCGv t0 = tcg_temp_new();
> +#if !defined(CONFIG_USER_ONLY)
> +    TCGLabel *fp_ok = gen_new_label();
> +    TCGLabel *done = gen_new_label();
> +
> +    /* check MSTATUS.FS */
> +    tcg_gen_ld_tl(t0, cpu_env, offsetof(CPURISCVState, mstatus));
> +    tcg_gen_andi_tl(t0, t0, MSTATUS_FS);
> +    tcg_gen_brcondi_tl(TCG_COND_NE, t0, 0x0, fp_ok);
> +    /* MSTATUS_FS field was zero */
> +    kill_unknown(ctx, RISCV_EXCP_ILLEGAL_INST);
> +    tcg_gen_br(done);

As I suggested for the FP helper patch, this could become

  if (!(ctx->base.tb->flags & TB_FLAG_MSTATUS_FS)) {
    kill_unknown(...);
    return;
  }

> +#if defined(TARGET_RISCV64)
> +    case OPC_RISC_SRAW:
> +        /* first, trick to get it to act like working on 32 bits (get rid of
> +        upper 32, sign extend to fill space) */
> +        tcg_gen_ext32s_tl(source1, source1);
> +        tcg_gen_andi_tl(source2, source2, 0x1F);
> +        tcg_gen_sar_tl(source1, source1, source2);
> +        break;
> +        /* fall through to SRA */

fallthru after break?

> +        /* Handle by altering args to tcg_gen_div to produce req'd results:
> +         * For overflow: want source1 in source1 and 1 in source2
> +         * For div by zero: want -1 in source1 and 1 in source2 -> -1 result */
> +        cond1 = tcg_temp_new();
> +        cond2 = tcg_temp_new();
> +        zeroreg = tcg_const_tl(0);
> +        resultopt1 = tcg_temp_new();
> +
> +        tcg_gen_movi_tl(resultopt1, (target_ulong)-1);

Pointless cast.

> +        tcg_gen_setcondi_tl(TCG_COND_EQ, cond2, source2, (target_ulong)(~0L));

Pointless cast and pointless L.

> +        tcg_gen_movi_tl(resultopt1, (target_ulong)1);
> +        tcg_gen_movcond_tl(TCG_COND_EQ, source2, cond1, zeroreg, source2,
> +                resultopt1);

You can use cond1 instead of resultopt1 here, since cond1 is either 0 or 1.

> +        tcg_gen_setcondi_tl(TCG_COND_EQ, cond1, source2, 0);
> +        tcg_gen_movi_tl(resultopt1, (target_ulong)-1);
> +        tcg_gen_movcond_tl(TCG_COND_EQ, source1, cond1, zeroreg, source1,
> +                resultopt1);
> +        tcg_gen_movi_tl(resultopt1, (target_ulong)1);
> +        tcg_gen_movcond_tl(TCG_COND_EQ, source2, cond1, zeroreg, source2,
> +                resultopt1);

The setcond is useless.  Let the movconds use source2 directly.

Similarly in REM and REMU.

> +    case OPC_RISC_ADDI:
> +#if defined(TARGET_RISCV64)
> +    case OPC_RISC_ADDIW:
> +#endif

CASE_OP_32_64?

> +    gen_goto_tb(ctx, 0, ctx->pc + imm); /* must use this for safety */

What do you mean by this?

> +    /* no chaining with JALR */

We can now chain indirect branches.

> +    TCGLabel *misaligned = gen_new_label();
> +    TCGv t0;
> +    t0 = tcg_temp_new();

These may not be needed...

> +
> +    switch (opc) {
> +    case OPC_RISC_JALR:
> +        gen_get_gpr(cpu_pc, rs1);
> +        tcg_gen_addi_tl(cpu_pc, cpu_pc, imm);
> +        tcg_gen_andi_tl(cpu_pc, cpu_pc, (target_ulong)-2);
> +
> +        if (!riscv_feature(env, RISCV_FEATURE_RVC)) {

... unless this condition is true.  In particular you can avoid emitting the
label unless it is used.

> +            tcg_gen_andi_tl(t0, cpu_pc, 0x2);
> +            tcg_gen_brcondi_tl(TCG_COND_NE, t0, 0x0, misaligned);
> +        }
> +
> +        if (rd != 0) {
> +            tcg_gen_movi_tl(cpu_gpr[rd], ctx->next_pc);
> +        }
> +        tcg_gen_exit_tb(0);

tcg_gen_lookup_and_goto_ptr

> +
> +        gen_set_label(misaligned);
> +        generate_exception_mbadaddr(ctx, RISCV_EXCP_INST_ADDR_MIS);
> +        tcg_gen_exit_tb(0);

exit_tb is unreached, since the exception exits the loop.

> +    switch (opc) {
> +    case OPC_RISC_BEQ:
> +        tcg_gen_brcond_tl(TCG_COND_EQ, source1, source2, l);
> +        break;
> +    case OPC_RISC_BNE:
> +        tcg_gen_brcond_tl(TCG_COND_NE, source1, source2, l);
> +        break;
> +    case OPC_RISC_BLT:
> +        tcg_gen_brcond_tl(TCG_COND_LT, source1, source2, l);
> +        break;
> +    case OPC_RISC_BGE:
> +        tcg_gen_brcond_tl(TCG_COND_GE, source1, source2, l);
> +        break;
> +    case OPC_RISC_BLTU:
> +        tcg_gen_brcond_tl(TCG_COND_LTU, source1, source2, l);
> +        break;
> +    case OPC_RISC_BGEU:
> +        tcg_gen_brcond_tl(TCG_COND_GEU, source1, source2, l);
> +        break;

You could just set the condition in the switch, or load it from a table.

> +    gen_goto_tb(ctx, 1, ctx->next_pc);
> +    gen_set_label(l); /* branch taken */
> +    if (!riscv_feature(env, RISCV_FEATURE_RVC) && ((ctx->pc + bimm) & 0x3)) {
> +        /* misaligned */
> +        generate_exception_mbadaddr(ctx, RISCV_EXCP_INST_ADDR_MIS);
> +        tcg_gen_exit_tb(0);

Unreached.

> +static void gen_atomic(DisasContext *ctx, uint32_t opc,
> +                      int rd, int rs1, int rs2)
> +{
> +#if !defined(CONFIG_USER_ONLY)
> +    /* TODO: handle aq, rl bits? - for now just get rid of them: */
> +    opc = MASK_OP_ATOMIC_NO_AQ_RL(opc);
> +    TCGv source1, source2, dat;
> +    TCGLabel *j = gen_new_label();
> +    TCGLabel *done = gen_new_label();
> +    source1 = tcg_temp_local_new();
> +    source2 = tcg_temp_local_new();
> +    dat = tcg_temp_local_new();
> +    gen_get_gpr(source1, rs1);
> +    gen_get_gpr(source2, rs2);
> +
> +    switch (opc) {
> +        /* all currently implemented as non-atomics */
> +    case OPC_RISC_LR_W:
> +        /* put addr in load_res */
> +        tcg_gen_mov_tl(load_res, source1);
> +        tcg_gen_qemu_ld_tl(dat, source1, ctx->mem_idx, MO_TESL | MO_ALIGN);
> +        break;
> +    case OPC_RISC_SC_W:
> +        tcg_gen_brcond_tl(TCG_COND_NE, load_res, source1, j);
> +        tcg_gen_qemu_st_tl(source2, source1, ctx->mem_idx, MO_TEUL | MO_ALIGN);
> +        tcg_gen_movi_tl(dat, 0); /*success */
> +        tcg_gen_br(done);
> +        gen_set_label(j);
> +        tcg_gen_movi_tl(dat, 1); /*fail */
> +        gen_set_label(done);
> +        break;

We have atomic primitives now.  You'll want to use them.

> +#else
> +    tcg_gen_movi_i32(cpu_amoinsn, ctx->opcode);
> +    generate_exception(ctx, QEMU_USER_EXCP_ATOMIC);
> +#endif

Including for CONFIG_USER_ONLY.  No need for cpu_amoinsn or the exception.

> +#ifndef CONFIG_USER_ONLY
> +        case 0x002: /* URET */
> +            printf("URET unimplemented\n");
> +            exit(1);

No exit, ever.  qemu_log_mask w/ LOG_UNIMP and kill_unknown.

> +#ifndef CONFIG_USER_ONLY
> +        /* standard fence is nop, fence_i flushes TB (like an icache): */

Standard fence should be tcg_gen_mb with some combination of TCGBar bits.

QEMU will automatically detect self-modifying code.  FENCE_I should either be a
nop or another tcg_gen_mb.

> +    ctx.mem_idx = cpu_mmu_index(env, false);

tb->flags must contain enough to cover the bits you're testing here.  Otherwise
hashing may select a TB with different permissions.

Depending on how complicated the test is, another way to accomplish this is to
actually store cpu_mmu_index into tb->flags.  At which point you would retrieve
ctx.mem_idx directly from tb->flags.

> +void riscv_translate_init(void)
> +{
> +    int i;
> +
> +    /* WARNING: cpu_gpr[0] is not allocated ON PURPOSE. Do not use it. */
> +    /* Use the gen_set_gpr and gen_get_gpr helper functions when accessing */
> +    /* registers, unless you specifically block reads/writes to reg 0 */
> +    TCGV_UNUSED(cpu_gpr[0]);

A patch to remove TCGV_UNUSED is in queue.
This would simply be cpu_gpr[0] = NULL now.


r~
