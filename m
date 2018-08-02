Received: from eggs.gnu.org ([2001:4830:134:3::10]:59999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1flHZe-0003QD-MN
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 13:39:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1flHZb-0001vX-Jg
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 13:39:42 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:40072)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1flHZb-0001u7-7U
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 13:39:39 -0400
Received: by mail-pg1-x544.google.com with SMTP id x5-v6so1538386pgp.7
	for <qemu-devel@nongnu.org>; Thu, 02 Aug 2018 10:39:38 -0700 (PDT)
References: <1533219424-7627-1-git-send-email-stefan.markovic@rt-rk.com>
	<1533219424-7627-24-git-send-email-stefan.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1a3c354d-4cdf-935a-2d6b-aa4fbc2bf100@linaro.org>
Date: Thu, 2 Aug 2018 13:39:27 -0400
MIME-Version: 1.0
In-Reply-To: <1533219424-7627-24-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 23/77] target/mips: Add emulation of
 nanoMIPS 16-bit load and store instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Markovic <stefan.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com, arikalo@wavecomp.com

On 08/02/2018 10:16 AM, Stefan Markovic wrote:
>      case NM_P16_LB:
> +        switch (extract32(ctx->opcode, 2, 2)) {
> +        case NM_LB16:
> +            offset = extract32(ctx->opcode, 0, 2);
> +            gen_ld(ctx, OPC_LB, rt, rs, offset);
> +            break;
> +        case NM_SB16:
> +            offset = decode_gpr_gpr3_src_store(
> +                         NANOMIPS_EXTRACT_RD(ctx->opcode));
> +            gen_st(ctx, OPC_SB, rt, rs, offset);

That looks wrong.  I think you want

    rt = decode_gpr_gpr3_src_store(...);
    offset = extract32(ctx->opcode, 0, 2);

here.

>      case NM_P16_LH:
> +        switch ((extract32(ctx->opcode, 3, 1) << 1) | (ctx->opcode & 1)) {
> +        case NM_LH16:
> +            offset = extract32(ctx->opcode, 1, 2) << 1;
> +            gen_ld(ctx, OPC_LH, rt, rs, offset);
> +            break;
> +        case NM_SH16:
> +            offset = decode_gpr_gpr3_src_store(
> +                         NANOMIPS_EXTRACT_RD(ctx->opcode));
> +            gen_st(ctx, OPC_SH, rt, rs, offset);

Similarly.


r~
