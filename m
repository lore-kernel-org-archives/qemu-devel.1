Received: from eggs.gnu.org ([2001:4830:134:3::10]:49387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgBxm-0007go-Uq
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:39:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgBxi-00039O-3S
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:39:34 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:36961)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fgBxh-000398-TH
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:39:30 -0400
Received: by mail-pg1-x541.google.com with SMTP id n7-v6so4258244pgq.4
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 09:39:29 -0700 (PDT)
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004912-13899-5-git-send-email-stefan.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <469970e4-21cf-e7e6-bd3d-cedf265e5741@linaro.org>
Date: Thu, 19 Jul 2018 09:39:26 -0700
MIME-Version: 1.0
In-Reply-To: <1532004912-13899-5-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 04/40] target/mips: Add
 decode_nanomips_opc() function
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
>          decode_opc(env, ctx);
>      } else if (ctx->insn_flags & ASE_MICROMIPS) {
> -        ctx->opcode = cpu_lduw_code(env, ctx->base.pc_next);
> -        insn_bytes = decode_micromips_opc(env, ctx);
> +        if (env->insn_flags & ISA_NANOMIPS32) {

Be consistent and use ctx->insn_flags.

> +            ctx->opcode = cpu_lduw_code(env, ctx->base.pc_next);
> +            insn_bytes = decode_nanomips_opc(env, ctx);
> +        } else {
> +            ctx->opcode = cpu_lduw_code(env, ctx->base.pc_next);
> +            insn_bytes = decode_micromips_opc(env, ctx);
> +        }
>      } else if (ctx->insn_flags & ASE_MIPS16) {
>          ctx->opcode = cpu_lduw_code(env, ctx->base.pc_next);

Do you really want to nest nanoMIPS within microMIPS?

I would have thought a better structure was

  } else if (ctx->insn_flags & ISA_NANOMIPS32) {
      ...
  } else if (ctx->insn_flags & ASE_MICROMIPS) {
      ...
  } else if (ctx->insn_flags & ASE_MIPS16) {


r~
