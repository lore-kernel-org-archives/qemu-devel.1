Received: from eggs.gnu.org ([2001:4830:134:3::10]:36501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXEl8-0001Ub-LM
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 19:49:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXEl5-0006BF-EE
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 19:49:30 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:35510)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fXEl5-0006B0-62
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 19:49:27 -0400
Received: by mail-pg0-x243.google.com with SMTP id i7-v6so5247910pgp.2
	for <qemu-devel@nongnu.org>; Sun, 24 Jun 2018 16:49:26 -0700 (PDT)
References: <20180620120620.12806-1-yongbok.kim@mips.com>
	<20180620120620.12806-10-yongbok.kim@mips.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8c60d42c-72a6-28d4-ae36-66b541e7a1a8@linaro.org>
Date: Sun, 24 Jun 2018 16:49:23 -0700
MIME-Version: 1.0
In-Reply-To: <20180620120620.12806-10-yongbok.kim@mips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/35] target/mips: Add nanoMIPS 48bit
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@mips.com>, qemu-devel@nongnu.org
Cc: Aleksandar.Markovic@mips.com, Paul.Burton@mips.com, Stefan.Markovic@mips.com, Matthew.Fortune@mips.com, James.Hogan@mips.com, aurelien@aurel32.net

On 06/20/2018 05:05 AM, Yongbok Kim wrote:
>      case NM_P48I:
> +        insn = cpu_lduw_code(env, ctx->base.pc_next + 4);

Surely split this case out to a new function.  And properly form the common,
signed 32-bit offset once before the switch.

> +        switch ((ctx->opcode >> 16) & 0x1f) {
> +        case NM_LI48:
> +            if (rt != 0) {
> +                tcg_gen_movi_tl(cpu_gpr[rt],
> +                                extract32(ctx->opcode, 0, 16) | insn << 16);

The 32-bit constant is to be sign-extended for nanomips 64.

> +            }
> +            break;
> +        case NM_ADDIU48:
> +            if (rt != 0) {
> +                tcg_gen_addi_tl(cpu_gpr[rt], cpu_gpr[rt],
> +                                extract32(ctx->opcode, 0, 16) | insn << 16);

Likewise.

> +                tcg_gen_ext32s_tl(cpu_gpr[rt], cpu_gpr[rt]);
> +            }
> +            break;
> +        case NM_ADDIUGP48:
> +            if (rt != 0) {
> +                tcg_gen_addi_tl(cpu_gpr[rt], cpu_gpr[28],
> +                                extract32(ctx->opcode, 0, 16) | insn << 16);

Likewise.

> +                tcg_gen_ext32s_tl(cpu_gpr[rt], cpu_gpr[rt]);

Behaves-like DADDIU[GP48].  Which would indicate using gen_op_addr_add[i].

I know you're only targeting nanomips32 now, but I think you need to be clearer
about all of these 64-bit edge cases now, lest they be very difficult to pick
out later.

> +            }
> +            break;
> +        case NM_ADDIUPC48:
> +            if (rt != 0) {
> +                int32_t offset = extract32(ctx->opcode, 0, 16) | insn << 16;
> +                target_long addr = addr_add(ctx, ctx->base.pc_next + 6, offset);
> +
> +                tcg_gen_movi_tl(cpu_gpr[rt], addr);
> +                tcg_gen_ext32s_tl(cpu_gpr[rt], cpu_gpr[rt]);

Likewise.  And the ext32s would be doubly redundant with that already done in
addr_add.


r~
