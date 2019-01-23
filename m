Received: from eggs.gnu.org ([209.51.188.92]:53234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gm933-00027G-Kb
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 22:17:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gm932-0003Rj-G8
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 22:17:53 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43040)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gm932-0003QQ-3S
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 22:17:52 -0500
Received: by mail-pl1-x642.google.com with SMTP id gn14so384987plb.10
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 19:17:51 -0800 (PST)
References: <20190121131602.55003-1-ysato@users.sourceforge.jp>
	<20190121131602.55003-2-ysato@users.sourceforge.jp>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5d885fe9-1fe8-86cc-be2d-e1f182ef13bf@linaro.org>
Date: Tue, 22 Jan 2019 19:17:46 -0800
MIME-Version: 1.0
In-Reply-To: <20190121131602.55003-2-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 01/11] TCG translation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org

On 1/21/19 5:15 AM, Yoshinori Sato wrote:
> +/* PSW condition operation */
> +typedef struct {
> +    TCGv op_mode;
> +    TCGv op_a1[13];
> +    TCGv op_a2[13];
> +    TCGv op_r[13];
> +} CCOP;
> +CCOP ccop;

Why does this have different array sizes than cpu.h?

Indeed, why does this have array sizes at all?  I am confused by your method of
flags generation.  This would be improved with comments, at least.  I suspect
that this is overly complicated and should be simplified to a single set of
variables, like target/i386 or target/s390x.

But I wonder if it might be least complicated, at least to start, if you just
explicitly compute each flag, like target/arm.

Note that computation need not be expensive.  Indeed, the Z and S flags can
generally be "computed" with a single move, if we define the representations as
env->psw_z == 0 and env->psw_s < 0.

> +DEF_HELPER_1(raise_illegal_instruction, noreturn, env)
> +DEF_HELPER_1(raise_access_fault, noreturn, env)
> +DEF_HELPER_1(raise_privilege_violation, noreturn, env)
> +DEF_HELPER_1(wait, noreturn, env)
> +DEF_HELPER_1(debug, noreturn, env)
> +DEF_HELPER_2(rxint, noreturn, env, i32)
> +DEF_HELPER_1(rxbrk, noreturn, env)
> +DEF_HELPER_FLAGS_4(floatop, TCG_CALL_NO_WG, f32, env, i32, f32, f32)
> +DEF_HELPER_2(to_fpsw, void, env, i32)
> +DEF_HELPER_FLAGS_2(ftoi, TCG_CALL_NO_WG, i32, env, f32)
> +DEF_HELPER_FLAGS_2(round, TCG_CALL_NO_WG, i32, env, f32)
> +DEF_HELPER_FLAGS_2(itof, TCG_CALL_NO_WG, f32, env, i32)
> +DEF_HELPER_2(racw, void, env, i32)
> +DEF_HELPER_1(update_psw, void, env)
> +DEF_HELPER_1(psw_c, i32, env)
> +DEF_HELPER_1(psw_s, i32, env)
> +DEF_HELPER_1(psw_o, i32, env)
> +DEF_HELPER_3(mvtc, void, env, i32, i32)
> +DEF_HELPER_2(mvfc, i32, env, i32)
> +DEF_HELPER_2(cond, i32, env, i32)
> +DEF_HELPER_1(unpack_psw, void, env)

Should fill in the flags for all of the non-noreturn helpers.

> +static uint32_t psw_z(CPURXState *env)
> +{
> +    int m = (env->op_mode >> 4) & 0x000f;
> +    if (m == RX_PSW_OP_NONE)
> +        return env->psw_z;

./scripts/checkpatch.pl should have given a diagnostic for the lack of braces here.

> +void helper_update_psw(CPURXState *env)
> +{
> +    struct {
> +        uint32_t *p;
> +        uint32_t (*fn)(CPURXState *);
> +    } const update_proc[] = {
> +        {&env->psw_c, psw_c},
> +        {&env->psw_z, psw_z},
> +        {&env->psw_s, psw_s},
> +        {&env->psw_o, psw_o},
> +    };
> +    int i;
> +
> +    for (i = 0; i < 4; i++) {
> +        *(update_proc[i].p) = update_proc[i].fn(env);
> +    }
> +    g_assert((env->op_mode & 0xffff) == 0);
> +}

All of the helpers already update the variables.  This should simplify to

void helper_update_psw(CPURXState *env)
{
  psw_c(env);
  psw_z(env);
  psw_s(env);
  psw_o(env);
  assert(env->op_mode == 0);
}

> +void rx_cpu_pack_psw(CPURXState *env)
> +{
> +    helper_update_psw(env);
> +    env->psw = (
> +        (env->psw_ipl << 24) | (env->psw_pm << 20) |
> +        (env->psw_u << 17) | (env->psw_i << 16) |
> +        (env->psw_o << 3) | (env->psw_s << 2) |
> +        (env->psw_z << 1) | (env->psw_c << 0));
> +}

I recommend this only return a value, and not modify state.  This is
particularly important for debugging, where you would like to examine state
without modifying anything.

> +typedef float32 (*floatfunc)(float32 f1, float32 f2, float_status *st);
> +float32 helper_floatop(CPURXState *env, uint32_t op,
> +                       float32 t0, float32 t1)
> +{
> +    static const floatfunc fop[] = {
> +        float32_sub,
> +        NULL,
> +        float32_add,
> +        float32_mul,
> +        float32_div,
> +    };
> +    int st, xcpt;
> +    if (op != 1) {
> +        t0 = fop[op](t0, t1, &env->fp_status);
> +        update_fpsw(env, GETPC());
> +    } else {

I recommend that you split this into 5 different functions, one for each
arithmetic operator and one for the comparison.

> +        switch (st) {
> +        case float_relation_unordered:
> +            return (float32)0;
> +        case float_relation_equal:
> +            return (float32)1;
> +        case float_relation_less:
> +            return (float32)2;
> +        }
> +    }
> +    return t0;
> +}

The comparison function should return uint32_t instead of values that are
obviously not normal float32 values.

> +void helper_racw(CPURXState *env, uint32_t shift)
> +{
> +    int64_t acc;
> +    acc = env->acc_m;
> +    acc = (acc << 32) | env->acc_l;

I think that acc should be stored as (u)int64_t within env.

> +    acc <<= shift;
> +    acc += 0x0000000080000000LL;
> +    if (acc > 0x00007FFF00000000LL) {
> +        acc = 0x00007FFF00000000LL;
> +    } else if (acc < 0xFFFF800000000000LL) {

If you want a signed type, use a signed value: -0x800000000000LL.

> +    psw = rx_get_psw_low(env);
> +    psw |= (env->psw_ipl << 24) | (env->psw_pm << 20) |
> +        (env->psw_u << 17) | (env->psw_i << 16);

I think you should use your regular "get everything" helper.

> +static void rx_gen_ldst(int size, int dir, TCGv reg, TCGv mem)
> +{
> +    static void (* const rw[])(TCGv ret, TCGv addr, int idx) = {
> +        tcg_gen_qemu_st8, tcg_gen_qemu_ld8s,
> +        tcg_gen_qemu_st16, tcg_gen_qemu_ld16s,
> +        tcg_gen_qemu_st32, tcg_gen_qemu_ld32s,
> +    };
> +    rw[size * 2 + dir](reg, mem, 0);
> +}

Use tcg_gen_qemu_ld_i32 and tcg_gen_qemu_st_i32 instead:

    if (dir) {
        tcg_gen_qemu_ld_i32(reg, mem, 0, size | MO_SIGN | MO_TE);
    } else {
        tcg_gen_qemu_st_i32(reg, mem, 0, size | MO_TE);
    }

> +DEFINE_INSN(mov1_2)
> +{
> +    TCGv mem;
> +    int r1, r2, dsp, dir, sz;
> +
> +    insn >>= 16;
> +    sz = (insn >> 12) & 3;
> +    dsp = ((insn >> 6) & 0x1e) | ((insn >> 3) & 1);
> +    dsp <<= sz;
> +    r2 = insn & 7;
> +    r1 = (insn >> 4) & 7;
> +    dir = (insn >> 11) & 1;
> +
> +    mem = tcg_temp_local_new();
> +    tcg_gen_addi_i32(mem, cpu_regs[r1], dsp);
> +    rx_gen_ldst(sz, dir, cpu_regs[r2], mem);
> +    tcg_temp_free(mem);
> +    dc->pc += 2;
> +}

Do not use tcg_temp_local_new() unless you need it to hold a value across a
branch or label.  Use tcg_temp_new() instead.

Likewise with tcg_const_local.

> +static void rx_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
> +{
> +    CPURXState *env = cs->env_ptr;
> +    DisasContext *dc = container_of(dcbase, DisasContext, base);
> +    uint32_t insn = 0;
> +    int i;
> +
> +    for (i = 0; i < 4; i++) {
> +        insn <<= 8;
> +        insn |= cpu_ldub_code(env, dc->base.pc_next + i);
> +    }

You're reading 4 bytes when the insn may be only 1-2 bytes long?
This could fail if a branch insn is placed near the end of memory.

I wish Renesas has published a consolidated opcode map, because it is very hard
to compare your decoding to the manual.  I am tempted to try to extend
./scripts/decodetree.py to handle variable width instruction sets to see if we
can make this process easier.


r~
