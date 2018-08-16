Received: from eggs.gnu.org ([2001:4830:134:3::10]:57914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fqLBx-0002lG-PQ
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:32:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fqLBs-00044c-FC
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:32:09 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:45042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fqLBl-00042v-5e
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:31:58 -0400
Received: by mail-pf1-x441.google.com with SMTP id k21-v6so2248710pff.11
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 09:31:56 -0700 (PDT)
References: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1534431497-1385-40-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0b4d8d60-98d2-8515-c08e-f767a886e331@linaro.org>
Date: Thu, 16 Aug 2018 09:31:52 -0700
MIME-Version: 1.0
In-Reply-To: <1534431497-1385-40-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 39/84] target/mips: Add emulation of
 nanoMIPS 32-bit branch instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 08/16/2018 07:57 AM, Aleksandar Markovic wrote:
> +    } else {
> +        /* Conditional compact branch */
> +        TCGLabel *fs = gen_new_label();
> +        save_cpu_state(ctx, 0);

I will note that save_cpu_state(ctx, 0) is concerned about updating the BMASK
bits for branch delay slots, which nanomips does not have.  The function could
probably usefully be renamed so that's clearer.


> +    /* unconditional branch to register */
> +    tcg_gen_mov_tl(cpu_PC, btarget);
> +    if (ctx->base.singlestep_enabled) {
> +        save_cpu_state(ctx, 0);

Likewise.

> +    } else {
> +        /* Conditional compact branch */
> +        TCGLabel *fs = gen_new_label();
> +        save_cpu_state(ctx, 0);

Likewise.
>      case NM_MOVE_BALC:
> +        {
> +            TCGv t0 = tcg_temp_new();
> +            int32_t s = sextract32(ctx->opcode, 0, 1) << 21 |
> +                        extract32(ctx->opcode, 1, 20) << 1;
> +            rd = (extract32(ctx->opcode, 24, 1)) == 0 ? 4 : 5;
> +            rt = decode_gpr_gpr4_zero(extract32(ctx->opcode, 25, 1) << 3 |
> +                            extract32(ctx->opcode, 21, 3));
> +            gen_load_gpr(t0, rt);
> +            tcg_gen_mov_tl(cpu_gpr[rd], t0);
> +            gen_compute_branch(ctx, OPC_BGEZAL, 4, 0, 0, s, 0);
> +            tcg_temp_free(t0);
> +        }
>          break;
>      case NM_P_BAL:
> +        {
> +            int32_t s = sextract32(ctx->opcode, 0, 1) << 25 |
> +                        extract32(ctx->opcode, 1, 24) << 1;
> +
> +            if ((extract32(ctx->opcode, 25, 1)) == 0) {
> +                /* BC */
> +                gen_compute_branch(ctx, OPC_BEQ, 4, 0, 0, s, 0);
> +            } else {
> +                /* BALC */
> +                gen_compute_branch(ctx, OPC_BGEZAL, 4, 0, 0, s, 0);
> +            }
> +        }
>          break;
>      case NM_P_J:
> +        switch (extract32(ctx->opcode, 12, 4)) {
> +        case NM_JALRC:
> +        case NM_JALRC_HB:
> +            gen_compute_branch(ctx, OPC_JALR, 4, rs, rt, 0, 0);
> +            break;

All of these branches need to be using the new functions that you just added.
There are even more incorrect uses to follow.


r~
