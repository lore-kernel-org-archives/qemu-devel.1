Received: from eggs.gnu.org ([2001:4830:134:3::10]:46712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgwDw-00056d-Al
	for qemu-devel@nongnu.org; Sat, 21 Jul 2018 14:03:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgwDt-0003oA-7u
	for qemu-devel@nongnu.org; Sat, 21 Jul 2018 14:03:20 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fgwDs-0003np-O7
	for qemu-devel@nongnu.org; Sat, 21 Jul 2018 14:03:17 -0400
Received: by mail-pg1-x541.google.com with SMTP id y5-v6so9353503pgv.1
	for <qemu-devel@nongnu.org>; Sat, 21 Jul 2018 11:03:16 -0700 (PDT)
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004912-13899-23-git-send-email-stefan.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <06bc0bdf-12da-cde4-34f6-60f526c6225e@linaro.org>
Date: Sat, 21 Jul 2018 11:03:12 -0700
MIME-Version: 1.0
In-Reply-To: <1532004912-13899-23-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 22/40] target/mips: Add handling of
 branch delay slots for nanoMIPS
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
> @@ -10991,7 +10992,8 @@ static void gen_branch(DisasContext *ctx, int insn_bytes)
>              break;
>          case MIPS_HFLAG_BR:
>              /* unconditional branch to register */
> -            if (ctx->insn_flags & (ASE_MIPS16 | ASE_MICROMIPS)) {
> +            if (ctx->has_isa_mode &&
> +                    (ctx->insn_flags & (ASE_MIPS16 | ASE_MICROMIPS))) {

Is this second condition really ever true for ISA_NANOMIPS?

> @@ -24747,6 +24749,7 @@ static void mips_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>      ctx->mrp = (env->CP0_Config5 >> CP0C5_MRP) & 1;
>      ctx->nan2008 = (env->active_fpu.fcr31 >> FCR31_NAN2008) & 1;
>      ctx->abs2008 = (env->active_fpu.fcr31 >> FCR31_ABS2008) & 1;
> +    ctx->has_isa_mode = ((env->CP0_Config3 >> CP0C3_MMAR) & 0x7) != 3;

< 3?

Or perhaps merge the combined test here,

  ctx->has_isa_mode = (ctx->insn_flags & (ASE_MIPS16 | ASE_MICROMIPS))
                   && ((env->CP0_Config3 >> CP0C3_MMAR) & 0x7) < 3);

and only use ctx->has_isa_mode in the other locations.



r~
