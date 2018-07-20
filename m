Received: from eggs.gnu.org ([2001:4830:134:3::10]:39012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgNy0-0007Ds-Vm
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 01:28:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgNxx-0006l1-PG
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 01:28:36 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:43057)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fgNxx-0006ke-AL
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 01:28:33 -0400
Received: by mail-pl0-x243.google.com with SMTP id o7-v6so4663533plk.10
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 22:28:33 -0700 (PDT)
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004912-13899-20-git-send-email-stefan.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <77de7a45-4ffd-ef29-d679-946d7de03916@linaro.org>
Date: Thu, 19 Jul 2018 22:28:29 -0700
MIME-Version: 1.0
In-Reply-To: <1532004912-13899-20-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 19/40] target/mips: Add emulation of
 nanoMIPS branch instructions
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
> +/* Immediate Value Compact Branches */
> +static void gen_compute_imm_branch(DisasContext *ctx, uint32_t opc,
> +                                   int rt, int32_t imm, int32_t offset)
> +{
> +    int bcond_compute = 0;
> +    TCGv t0 = tcg_temp_new();
> +    TCGv t1 = tcg_temp_new();
> +
> +    if (ctx->hflags & MIPS_HFLAG_BMASK) {
> +#ifdef MIPS_DEBUG_DISAS
> +        LOG_DISAS("Branch in delay / forbidden slot at PC 0x" TARGET_FMT_lx
> +                  "\n", ctx->base.pc_next);
> +#endif
> +        generate_exception_end(ctx, EXCP_RI);
> +        goto out;
> +    }
> +
> +    gen_load_gpr(t0, rt);
> +    tcg_gen_movi_tl(t1, imm);
> +    ctx->btarget = addr_add(ctx, ctx->base.pc_next + 4, offset);
> +
> +    /* Load needed operands and calculate btarget */
> +    switch (opc) {
> +    case NM_BEQIC:
> +        if (rt == 0 && imm == 0) {
> +            /* Unconditional branch */
> +        } else if (rt == 0 && imm != 0) {
> +            /* Treat as NOP */
> +            goto out;

Surely this misses out on tracking the forbidden slot.
Given how infrequently these cases happen, is it really
worth special casing these at all?

Etc, througout this patch.

> +    if (bcond_compute == 0) {
> +        /* Uncoditional compact branch */
> +        ctx->hflags |= MIPS_HFLAG_B;
> +        /* Generating branch here as compact branches don't have delay slot */
> +        gen_branch(ctx, 4);
> +    } else {
> +        /* Conditional compact branch */
> +        TCGLabel *fs = gen_new_label();
> +        save_cpu_state(ctx, 0);
> +
> +        switch (opc) {
> +        case NM_BEQIC:
> +            tcg_gen_brcond_tl(tcg_invert_cond(TCG_COND_EQ), t0, t1, fs);
> +            break;
> +        case NM_BBEQZC:
> +            tcg_gen_brcond_tl(tcg_invert_cond(TCG_COND_EQ), t0, t1, fs);
> +            break;
> +        case NM_BNEIC:
> +            tcg_gen_brcond_tl(tcg_invert_cond(TCG_COND_NE), t0, t1, fs);
> +            break;
> +        case NM_BBNEZC:
> +            tcg_gen_brcond_tl(tcg_invert_cond(TCG_COND_NE), t0, t1, fs);
> +            break;
> +        case NM_BGEIC:
> +            tcg_gen_brcond_tl(tcg_invert_cond(TCG_COND_GE), t0, t1, fs);
> +            break;
> +        case NM_BLTIC:
> +            tcg_gen_brcond_tl(tcg_invert_cond(TCG_COND_LT), t0, t1, fs);
> +            break;
> +        case NM_BGEIUC:
> +            tcg_gen_brcond_tl(tcg_invert_cond(TCG_COND_GEU), t0, t1, fs);
> +            break;
> +        case NM_BLTIUC:
> +            tcg_gen_brcond_tl(tcg_invert_cond(TCG_COND_LTU), t0, t1, fs);
> +            break;
> +        }

I think you should, in the previous switch, store these conditions into a
variable.  Then squish this switch out and just have one brcond.


r~
