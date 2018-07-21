Received: from eggs.gnu.org ([2001:4830:134:3::10]:57131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fguB3-0003ZV-Rh
	for qemu-devel@nongnu.org; Sat, 21 Jul 2018 11:52:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fguB0-0004LR-Op
	for qemu-devel@nongnu.org; Sat, 21 Jul 2018 11:52:13 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fguB0-0004LF-Gt
	for qemu-devel@nongnu.org; Sat, 21 Jul 2018 11:52:10 -0400
Received: by mail-pg1-x543.google.com with SMTP id p23-v6so9203820pgv.13
	for <qemu-devel@nongnu.org>; Sat, 21 Jul 2018 08:52:10 -0700 (PDT)
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004912-13899-22-git-send-email-stefan.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cbc3d873-9f27-de0f-8195-f4a71050bd71@linaro.org>
Date: Sat, 21 Jul 2018 08:52:05 -0700
MIME-Version: 1.0
In-Reply-To: <1532004912-13899-22-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 21/40] target/mips: Implement DSP ASE
 support for nanoMIPS
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
> +    case OPC_APPEND:
> +    {
> +        TCGv t0;
> +
> +        t0 = tcg_temp_new();
> +        gen_load_gpr(t0, rs);
> +
> +        if (rd != 0) {
> +            tcg_gen_deposit_tl(cpu_gpr[rt], t0, cpu_gpr[rt], rd, 32 - rd);
> +        }
> +        tcg_gen_ext32s_tl(cpu_gpr[rt], cpu_gpr[rt]);
> +    }
> +    break;
> +    case OPC_MODSUB:

Indentation.  Probably should hoist t0 to the top of the function anyway.

> +    case OPC_SHILO:
> +    {
> +        TCGv t0;
> +        TCGv t1;
> +        t0 = tcg_temp_new();
> +        t1 = tcg_temp_new();
> +
> +        int16_t imm = (ctx->opcode >> 16) & 0x3F;
> +
> +        tcg_gen_movi_tl(t0, rd >> 3);
> +        tcg_gen_movi_tl(t1, imm);
> +
> +        gen_helper_shilo(t0, t1, cpu_env);
> +    }
> +    break;
> +    case OPC_MULEQ_S_W_PHL:

Indentation.  Shadowing outer t1 (and t0 if you move the one above).
And for future cleanup, helper_shilo is much easier to implement inline.

> +    case OPC_SHLL_S_W:
> +    {
> +        TCGv t0;
> +        t0 = tcg_temp_new();
> +        tcg_gen_movi_tl(t0, rd);
> +
> +        check_dsp(ctx);
> +        gen_helper_shll_s_w(cpu_gpr[rt], t0, v1_t, cpu_env);
> +        break;
> +    }
> +    break;
> +    case OPC_REPL_PH:
> +    check_dsp(ctx);
> +    {

Indentation.  I won't mention any more, but please fix them all.

> -    NM_LWUX     = 0x07,
> -    NM_SWC1X    = 0x0b,
> -    NM_SDC1X    = 0x0f,
> +    NM_LWUX     = 0x07,
> +    NM_SWC1X    = 0x0b,
> +    NM_SDC1X    = 0x0f,

What has changed here?  Actually, looking further down in the patch, something
really odd -- and large -- has happened.  Did you rearrange functions or
something?  Whatever it is, it should be folded back into the patch that
introduced them.


r~
