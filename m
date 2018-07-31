Received: from eggs.gnu.org ([2001:4830:134:3::10]:57047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkXv9-0004Bw-GQ
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 12:54:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkXv6-0003yT-Ak
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 12:54:51 -0400
Received: from mail-ua0-x243.google.com ([2607:f8b0:400c:c08::243]:43672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fkXv6-0003yJ-2b
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 12:54:48 -0400
Received: by mail-ua0-x243.google.com with SMTP id x24-v6so10728960ual.10
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 09:54:47 -0700 (PDT)
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-33-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2a146c97-8dc7-31d8-a0eb-4e92216b16d5@linaro.org>
Date: Tue, 31 Jul 2018 12:54:42 -0400
MIME-Version: 1.0
In-Reply-To: <1532967169-22265-33-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 32/76] target/mips: Add emulation of
 misc nanoMIPS instructions (p_lsx)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 07/30/2018 12:12 PM, Aleksandar Markovic wrote:
> +static void gen_p_lsx(DisasContext *ctx, int rd, int rs, int rt)
> +{
> +    TCGv t0, t1;
> +    t0 = tcg_temp_new();
> +    t1 = tcg_temp_new();
> +
> +    gen_load_gpr(t0, rs);
> +    gen_load_gpr(t1, rt);
> +
> +    if ((extract32(ctx->opcode, 6, 1)) == 1) {
> +        /* PP.LSXS instructions require shifting */
> +        switch (extract32(ctx->opcode, 7, 4)) {
> +        case NM_LHXS:
> +        case NM_SHXS:
> +        case NM_LHUXS:
> +            tcg_gen_shli_tl(t0, t0, 1);
> +            break;
> +        case NM_LWXS:
> +        case NM_SWXS:
> +        case NM_LWC1XS:
> +        case NM_SWC1XS:
> +            tcg_gen_shli_tl(t0, t0, 2);
> +            break;
> +        case NM_LDC1XS:
> +        case NM_SDC1XS:
> +            tcg_gen_shli_tl(t0, t0, 3);
> +            break;
> +        }
> +    }
> +    gen_op_addr_add(ctx, t0, t0, t1);
> +
> +    switch (extract32(ctx->opcode, 7, 4)) {
> +    case NM_LBX:
> +        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx,
> +                           MO_SB);
> +        gen_store_gpr(t0, rd);
> +        break;
> +    case NM_LHX:
> +    /*case NM_LHXS:*/
> +        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx,
> +                           MO_TESW);

Elsewhere in translate you use ctx->default_tcg_memop_mask.

You probably should tidy this up with a table or another switch that computes
the TCGMemOp for the size and sign of the operation.  Then you don't have to
modify quite so many places fixing this.  Something like

    unsigned opc = extract32(ctx->opcode, 7, 4);
    TCGMemOp mop;

    switch (opc) {
    case NM_LBX:
        mop = MO_SB;
        break;
    ...
    }
    mop |= ctx->default_tcg_memop_mask;

    if (extract32(ctx->opcode, 6, 1)) {
        tcg_gen_shli_tl(t0, t0, mop & MO_SIZE);
    }
    gen_op_addr_add(ctx, t0, t0, t1);

    switch (opc) {
    case NM_LBX: // and all other integer loads
       tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, mop);
       gen_store_gpr(t0, rd);
       break;
    case NM_SBX: // and all other integer stores
       gen_load_gpr(t1, td);
       tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mop);
       break;
    case NM_LWC1X: // and all other fp ops
       if (ctx->CP0_Config1...) {
          ...
       }
    }


r~
