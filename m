Received: from eggs.gnu.org ([2001:4830:134:3::10]:33076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkYG8-00032K-Co
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 13:16:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkYG4-0005tZ-8x
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 13:16:32 -0400
Received: from mail-vk0-x242.google.com ([2607:f8b0:400c:c05::242]:42112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fkYG4-0005tI-3H
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 13:16:28 -0400
Received: by mail-vk0-x242.google.com with SMTP id t4-v6so7891812vke.9
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 10:16:28 -0700 (PDT)
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-37-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <740e5769-e392-cb7b-f23a-582243453127@linaro.org>
Date: Tue, 31 Jul 2018 13:16:23 -0400
MIME-Version: 1.0
In-Reply-To: <1532967169-22265-37-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 36/76] target/mips: Add emulation of
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
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 07/30/2018 12:12 PM, Aleksandar Markovic wrote:
> +/* Immediate Value Compact Branches */
> +static void gen_compute_imm_branch(DisasContext *ctx, uint32_t opc,
> +                                   int rt, int32_t imm, int32_t offset)
> +{
> +    TCGCond cond;
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

What is this,

> +        ctx->hflags |= MIPS_HFLAG_FBNSLOT;

and this (and several other occurrences), given that forbidden slots have been
removed from the nanomips architecture?

I think perhaps all of your branching code, utilizing the existing expanders,
needs a re-think.


r~
