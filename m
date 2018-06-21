Received: from eggs.gnu.org ([2001:4830:134:3::10]:34023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fWCnW-0005bT-CE
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 23:31:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fWCnV-0000PO-5e
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 23:31:42 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:40116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fWCnU-0000P0-Uj
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 23:31:41 -0400
Received: by mail-pg0-x244.google.com with SMTP id w8-v6so2327682pgp.7
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 20:31:40 -0700 (PDT)
References: <20180620120620.12806-1-yongbok.kim@mips.com>
	<20180620120620.12806-5-yongbok.kim@mips.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3ee6f061-c57f-d829-d5cc-9aa034fbcf3e@linaro.org>
Date: Thu, 21 Jun 2018 16:39:00 -0700
MIME-Version: 1.0
In-Reply-To: <20180620120620.12806-5-yongbok.kim@mips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/35] target/mips: Add
 decode_nanomips_opc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@mips.com>, qemu-devel@nongnu.org
Cc: Aleksandar.Markovic@mips.com, Paul.Burton@mips.com, Stefan.Markovic@mips.com, Matthew.Fortune@mips.com, James.Hogan@mips.com, aurelien@aurel32.net

On 06/20/2018 05:05 AM, Yongbok Kim wrote:
> +static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
> +{
> +    uint32_t op;
> +    int rt = mmreg_nanomips(uMIPS_RD(ctx->opcode));
> +    int rs = mmreg_nanomips(uMIPS_RS(ctx->opcode));
> +    int rd = mmreg_nanomips(uMIPS_RS1(ctx->opcode));

Do you really want to be reusing micro-mips macros for nano-mips?
Even if they are the same?

> +
> +    /* make sure instructions are on a halfword boundary */
> +    if (ctx->base.pc_next & 0x1) {
> +        env->CP0_BadVAddr = ctx->base.pc_next;
> +        generate_exception_end(ctx, EXCP_AdEL);
> +        return 2;
> +    }
> +
> +    op = (ctx->opcode >> 10) & 0x3f;
> +    switch (op) {
> +    case NM_P16_MV:
> +    {
> +        int rt = uMIPS_RD5(ctx->opcode);

The formatting here is off.  It should be

    switch (op) {
    case NM_P16_MV:
        {
            int rt ...

but it might be even better to split each case off into a separate function.
For the most part that could become

    return table[op](ctx, insn);

where the table is fully populated with function pointers.  It would have the
same indirect branch predictability of the switch statement while producing
smaller functions that are easier to reason with.

> +        if (rt != 0) {
> +            /* MOVE */
> +            int rs = uMIPS_RS5(ctx->opcode);
> +            gen_arith(ctx, OPC_ADDU, rt, rs, 0);
> +        } else {
> +            /* P16.RI */
> +            switch ((ctx->opcode >> 3) & 0x3) {

You have an eclectic mix of shift-and-mask and extract32 throughout.
I would prefer if you standardized on extract32.

> +    case NM_MOVEP:
> +    case NM_MOVEPREV:
> +    {
> +        static const int gpr2reg1[] = {4, 5, 6, 7};
> +        static const int gpr2reg2[] = {5, 6, 7, 8};
> +        int re;
> +        int rd2 = extract32(ctx->opcode, 3, 1) << 1 |
> +                  extract32(ctx->opcode, 8, 1);
> +        int r1 = gpr2reg1[rd2];
> +        int r2 = gpr2reg2[rd2];
> +        int r3 = extract32(ctx->opcode, 4, 1) << 3 |
> +                 extract32(ctx->opcode, 0, 3);
> +        int r4 = extract32(ctx->opcode, 9, 1) << 3 |
> +                 extract32(ctx->opcode, 5, 3);
> +        TCGv t0 = tcg_temp_new();
> +        TCGv t1 = tcg_temp_new();
> +        if (op == NM_MOVEP) {
> +            rd = r1;
> +            re = r2;
> +            rs = mmreg4z_nanomips(r3);
> +            rt = mmreg4z_nanomips(r4);
> +        } else {
> +            rd = mmreg4_nanomips(r3);
> +            re = mmreg4_nanomips(r4);
> +            rs = r1;
> +            rt = r2;
> +        }
> +        gen_load_gpr(t0, rs);
> +        gen_load_gpr(t1, rt);
> +        tcg_gen_mov_tl(cpu_gpr[rd], t0);
> +        tcg_gen_mov_tl(cpu_gpr[re], t1);
> +        tcg_temp_free(t0);
> +        tcg_temp_free(t1);
> +    }

I would encourage you to qemu_log_mask(LOG_GUEST_ERROR, ...) whenever the
result of the instruction is UNKNOWN or UNPREDICTABLE, as here when
destinations overlap sources.

>      } else if (ctx->insn_flags & ASE_MICROMIPS) {
>          ctx->opcode = cpu_lduw_code(env, ctx->base.pc_next);
> -        insn_bytes = decode_micromips_opc(env, ctx);
> +        if (env->insn_flags & ISA_NANOMIPS32) {
> +            insn_bytes = decode_nanomips_opc(env, ctx);
> +        } else {
> +            insn_bytes = decode_micromips_opc(env, ctx);
> +        }

Clearer without useless sharing of one line:

    } else if (env->insn_flags & ISA_NANOMIPS32) {
        ctx->opcode = cpu_lduw_code(env, ctx->base.pc_next);
        insn_bytes = decode_nanomips_opc(env, ctx);
    } else if (ctx->insn_flags & ASE_MICROMIPS) {
        ctx->opcode = cpu_lduw_code(env, ctx->base.pc_next);
        insn_bytes = decode_micromips_opc(env, ctx);
    }


r~
