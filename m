Received: from eggs.gnu.org ([2001:4830:134:3::10]:51298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgE2s-0002sC-Pb
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 14:52:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgE2q-0004k1-5e
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 14:52:58 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:45371)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fgE2p-0004jn-RA
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 14:52:56 -0400
Received: by mail-pf1-x441.google.com with SMTP id i26-v6so3498pfo.12
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 11:52:55 -0700 (PDT)
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004912-13899-11-git-send-email-stefan.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9fe2943c-bbae-67a2-4ee9-31741e4d863f@linaro.org>
Date: Thu, 19 Jul 2018 11:52:51 -0700
MIME-Version: 1.0
In-Reply-To: <1532004912-13899-11-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 10/40] target/mips: Add emulation of
 some common nanoMIPS 32-bit instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Markovic <stefan.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 07/19/2018 05:54 AM, Stefan Markovic wrote:
> +    case NM_P_ADDIU:
> +        if (rt == 0) {
> +            /* P.RI */
> +            switch ((ctx->opcode >> 19) & 0x03) {
> +            case NM_SIGRIE:
> +            default:
> +                generate_exception_end(ctx, EXCP_RI);
> +                break;
> +            case NM_P_SYSCALL:
> +                if (((ctx->opcode >> 18) & 0x01) == NM_SYSCALL) {
> +                    generate_exception_end(ctx, EXCP_SYSCALL);
> +                } else {
> +                    generate_exception_end(ctx, EXCP_RI);
> +                }
> +                break;
> +            case NM_BREAK:
> +                generate_exception_end(ctx, EXCP_BREAK);
> +                break;
> +            case NM_SDBBP:
> +                if (is_uhi(extract32(ctx->opcode, 0, 19))) {
> +                    gen_helper_do_semihosting(cpu_env);
> +                } else {
> +                    if (ctx->hflags & MIPS_HFLAG_SBRI) {
> +                        generate_exception_end(ctx, EXCP_RI);
> +                    } else {
> +                        generate_exception_end(ctx, EXCP_DBp);
> +                    }
> +                }
> +                break;
> +            }
> +        } else {
> +            uint16_t imm;
> +            imm = (uint16_t) extract32(ctx->opcode, 0, 16);
> +            if (rs != 0) {
> +                tcg_gen_addi_tl(cpu_gpr[rt], cpu_gpr[rs], imm);
> +                tcg_gen_ext32s_tl(cpu_gpr[rt], cpu_gpr[rt]);
> +            } else {
> +                tcg_gen_movi_tl(cpu_gpr[rt], imm);

This misses the sign-extend that is required.
I suggest not special-casing 0 at all, since
tcg_gen_andi_tl will already elide the add for 0.


> +    case NM_ADDIUPC:
> +        if (rt != 0) {
> +            int32_t offset = sextract32(ctx->opcode, 0, 1) << 21
> +                            | extract32(ctx->opcode, 1, 20) << 1;
> +            target_long addr = addr_add(ctx, ctx->base.pc_next + 4, offset);
> +            tcg_gen_movi_tl(cpu_gpr[rt], addr);
> +            tcg_gen_ext32s_tl(cpu_gpr[rt], cpu_gpr[rt]);

Do not sign-extend in tcg ops; do it during translation via

    tcg_gen_movi_tl(cpu_gpr[rt], (int32_t)addr);

> +    case NM_P_GP_W:
> +        switch (ctx->opcode & 0x03) {
> +        case NM_ADDIUGP_W:
> +            if (rt != 0) {
> +                uint32_t offset = extract32(ctx->opcode, 0, 21);
> +                if (offset == 0) {
> +                    gen_load_gpr(cpu_gpr[rt], 28);
> +                } else {
> +                    TCGv t0;
> +                    t0 = tcg_temp_new();
> +                    tcg_gen_movi_tl(t0, offset);
> +                    gen_op_addr_add(ctx, cpu_gpr[rt], cpu_gpr[28], t0);
> +                    tcg_temp_free(t0);

This misses out on the sign extend for mips64 when pointers are 32 bits and
offset == 0.  Again, dropping the special case for 0 will do everything right.

> +        case NM_SLTI:
> +            gen_slt_imm(ctx, OPC_SLTI, rt, rs, extract32(ctx->opcode, 0, 12));
> +            break;
> +        case NM_SLTIU:
> +            gen_slt_imm(ctx, OPC_SLTIU, rt, rs, extract32(ctx->opcode, 0, 12));
> +            break;
> +        case NM_SEQI:
> +            {
> +                TCGv t0 = tcg_temp_new();
> +                TCGv t1 = tcg_temp_new();
> +                TCGv t2 = tcg_temp_local_new();
> +                TCGLabel *l1 = gen_new_label();
> +
> +                gen_load_gpr(t0, rs);
> +                tcg_gen_movi_tl(t1, extract32(ctx->opcode, 0, 12));
> +                tcg_gen_movi_tl(t2, 0);
> +                tcg_gen_brcond_tl(TCG_COND_NE, t0, t1, l1);
> +                tcg_gen_movi_tl(t2, 1);
> +                gen_set_label(l1);
> +                gen_store_gpr(t2, rt);

Use tcg_gen_setcondi_tl.

> +        case NM_P_SHIFT:
> +            {
> +                int shift = extract32(ctx->opcode, 0, 5);
> +                switch ((ctx->opcode >> 5) & 0x0f) {
> +                case NM_P_SLL:
> +                    if (rt == 0 && shift == 0) {
> +                        /* NOP */
> +                    } else if (rt == 0 && shift == 3) {
> +                        /* EHB treat as NOP */
> +                    } else if (rt == 0 && shift == 5) {
> +                        /* PAUSE */
> +                        if (ctx->hflags & MIPS_HFLAG_BMASK) {
> +                            generate_exception_end(ctx, EXCP_RI);
> +                        }
> +                    } else if (rt == 0 && shift == 6) {
> +                        /* SYNC */
> +                        check_insn(ctx, ISA_MIPS2);
> +                        /* Treat as NOP. */

Use gen_sync.


r~
