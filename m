Received: from eggs.gnu.org ([2001:4830:134:3::10]:52868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgEBB-0008Uz-GX
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 15:01:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgEB7-0008UI-Bp
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 15:01:33 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:43280)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fgEB6-0008Tj-2B
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 15:01:29 -0400
Received: by mail-pg1-x534.google.com with SMTP id v13-v6so4574283pgr.10
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 12:01:27 -0700 (PDT)
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004912-13899-12-git-send-email-stefan.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f60a0308-26a8-2a95-8104-6d65f0d9ff43@linaro.org>
Date: Thu, 19 Jul 2018 12:01:23 -0700
MIME-Version: 1.0
In-Reply-To: <1532004912-13899-12-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 11/40] target/mips: Add emulation of
 nanoMIPS 48-bit instructions
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
>      case NM_P48I:
> +        insn = cpu_lduw_code(env, ctx->base.pc_next + 4);
> +        switch ((ctx->opcode >> 16) & 0x1f) {
> +        case NM_LI48:
> +            if (rt != 0) {
> +                tcg_gen_movi_tl(cpu_gpr[rt],
> +                                extract32(ctx->opcode, 0, 16) | insn << 16);

It's probably worthwhile to hoist the offset computation above the switch; it
is used identically in every case.

> +        case NM_ADDIUGP48:
> +            if (rt != 0) {
> +                tcg_gen_addi_tl(cpu_gpr[rt], cpu_gpr[28],
> +                                extract32(ctx->opcode, 0, 16) | insn << 16);
> +                tcg_gen_ext32s_tl(cpu_gpr[rt], cpu_gpr[rt]);

This should use gen_op_addr_add (behaves_like('DADDIU[GP48]')).

> +        case NM_ADDIUPC48:
> +            if (rt != 0) {
> +                int32_t offset = extract32(ctx->opcode, 0, 16) | insn << 16;
> +                target_long addr = addr_add(ctx, ctx->base.pc_next + 6, offset);
> +
> +                tcg_gen_movi_tl(cpu_gpr[rt], addr);
> +                tcg_gen_ext32s_tl(cpu_gpr[rt], cpu_gpr[rt]);

No sign-extend needed; already done in addr_add.


r~
