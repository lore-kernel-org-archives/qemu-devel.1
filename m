Received: from eggs.gnu.org ([2001:4830:134:3::10]:41359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkV1d-0006b4-MU
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 09:49:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkV1Y-0000fK-PV
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 09:49:21 -0400
Received: from mail-ua0-x233.google.com ([2607:f8b0:400c:c08::233]:46346)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fkV1Y-0000fC-Ci
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 09:49:16 -0400
Received: by mail-ua0-x233.google.com with SMTP id u11-v6so5588889uan.13
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 06:49:16 -0700 (PDT)
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-27-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a853356c-6b1d-9395-5c5e-7e98c976e264@linaro.org>
Date: Tue, 31 Jul 2018 09:49:10 -0400
MIME-Version: 1.0
In-Reply-To: <1532967169-22265-27-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 26/76] target/mips: Add emulation of
 some common nanoMIPS 32-bit instructions
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

On 07/30/2018 12:11 PM, Aleksandar Markovic wrote:
> +    case NM_ADDIUPC:
> +        if (rt != 0) {
> +            int32_t offset = sextract32(ctx->opcode, 0, 1) << 21 |
> +                             extract32(ctx->opcode, 1, 20) << 1;
> +            target_long addr = addr_add(ctx, ctx->base.pc_next + 4, offset);
> +            tcg_gen_movi_tl(cpu_gpr[rt], (int32_t)addr);

addr_add has already done any required sign-extend.
Including an extra one is wrong for nanomips64.

> +        case NM_SEQI:
> +            {
> +                TCGv t0 = tcg_temp_new();
> +                TCGv t1 = tcg_temp_new();
> +                TCGv t2 = tcg_temp_local_new();
> +
> +                gen_load_gpr(t0, rs);
> +                tcg_gen_movi_tl(t1, extract32(ctx->opcode, 0, 12));
> +                tcg_gen_setcond_tl(TCG_COND_EQ, t2, t0, t1);
> +                gen_store_gpr(t2, rt);
> +
> +                tcg_temp_free(t0);
> +                tcg_temp_free(t1);
> +                tcg_temp_free(t2);
> +            }
> +            break;

You only need one temporary.

  TCGv t0 = tcg_temp_new();
  int imm = extract32(ctx->opcode, 0, 12);

  gen_load_gpr(t0, rs);
  tcg_gen_setcondi_tl(TCG_COND_EQ, t0, t0, imm);
  gen_store_gpr(t0, rt);

  tcg_temp_free(t0);

Do not use tcg_temp_local_new unless you really need it in order to cross a
basic block boundary (branch or label).

> +                    } else if (rt == 0 && shift == 6) {
> +                        /* SYNC */
> +                        check_insn(ctx, ISA_MIPS2);

Cut and paste error from elsewhere?
Why would you need this ISA check?


r~
