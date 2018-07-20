Received: from eggs.gnu.org ([2001:4830:134:3::10]:36125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgNVo-0000ui-LR
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 00:59:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgNVl-0003ia-Fz
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 00:59:28 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:37511)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fgNVl-0003hx-7m
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 00:59:25 -0400
Received: by mail-pl0-x241.google.com with SMTP id 31-v6so4643395plc.4
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 21:59:25 -0700 (PDT)
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004912-13899-19-git-send-email-stefan.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <17945e3f-9caf-b153-4c45-56d005f27a72@linaro.org>
Date: Thu, 19 Jul 2018 21:59:21 -0700
MIME-Version: 1.0
In-Reply-To: <1532004912-13899-19-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 18/40] target/mips: Add emulation of
 nanoMIPS 32-bit load and store instructions
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
> +        case NM_ADDIUGP_B:
> +            gen_arith_imm(ctx, OPC_ADDIU, rt, 28, u);
> +            break;

Use gen_op_addr_add, since behaves_like('DADDIU[GP.B]').

>      case NM_P_LS_U12:
> +    {
> +        uint32_t u = extract32(ctx->opcode, 0, 12);
> +        switch ((ctx->opcode >> 12) & 0x0f) {
> +        case NM_P_PREFU12:
> +            if (rt == 31) {
> +                /* SYNCI */
> +                /* Break the TB to be able to sync copied instructions
> +                   immediately */
> +                ctx->base.is_jmp = DISAS_STOP;

I'll note for future cleanup that while this matches all of the other instances
of SYNCI in target/mips/, this is not actually required.

QEMU supports self-modifying code without any barriers or breaks whatsoever.
(Becuase, of course, i386 as a guest requires this.)


r~
