Received: from eggs.gnu.org ([2001:4830:134:3::10]:46973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fi2yS-0001zQ-VX
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 15:27:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fi2yR-0003TD-0n
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 15:27:56 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:32852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fi2yQ-0003SE-MB
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 15:27:54 -0400
Received: by mail-pg1-x544.google.com with SMTP id r5-v6so3575977pgv.0
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 12:27:54 -0700 (PDT)
References: <1532453527-22911-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532453527-22911-7-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2071c45a-feb7-494e-5c6f-a3a239fff978@linaro.org>
Date: Tue, 24 Jul 2018 12:27:50 -0700
MIME-Version: 1.0
In-Reply-To: <1532453527-22911-7-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 06/55] target/mips: Add emulation of
 misc nanoMIPS 16-bit instructions
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

On 07/24/2018 10:31 AM, Aleksandar Markovic wrote:
> +    /* make sure instructions are on a halfword boundary */
> +    if (ctx->base.pc_next & 0x1) {
> +        TCGv tmp = tcg_const_tl(ctx->base.pc_next);
> +        tcg_gen_st_tl(tmp, cpu_env, offsetof(CPUMIPSState, CP0_BadVAddr));
> +        tcg_temp_free(tmp);
> +        return 2;
> +    }

You've lost the actual raising of the exception since v3.

> +    case NM_P16_MV:
> +        {
> +            int rt1 = NANOMIPS_EXTRACT_RD5(ctx->opcode);
> +            if (rt1 != 0) {
> +                /* MOVE */
> +                int rs1 = NANOMIPS_EXTRACT_RS5(ctx->opcode);
> +                gen_arith(ctx, OPC_ADDU, rt1, rs1, 0);

Why are you creating rt1 and rs1 variables?
I see you took my shadowed variables comment to heart, and renamed them, but
why not just overwrite the contents of the existing outer variable?

> +        case NM_P_ADDIURS5:
> +            {
> +                int rt1 = extract32(ctx->opcode, 5, 5);

Likewise.

> +    case NM_P16_4X4:
> +        {
> +            int rt1 = (extract32(ctx->opcode, 9, 1) << 3) |
> +                      extract32(ctx->opcode, 5, 3);
> +            int rs1 = (extract32(ctx->opcode, 4, 1) << 3) |
> +                      extract32(ctx->opcode, 0, 3);

Likewise.


r~
