Received: from eggs.gnu.org ([2001:4830:134:3::10]:46824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgDez-0004Vf-Rw
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 14:28:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgDew-0000vq-ID
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 14:28:17 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:34612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fgDew-0000vN-9D
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 14:28:14 -0400
Received: by mail-pl0-x244.google.com with SMTP id f6-v6so4021957plo.1
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 11:28:14 -0700 (PDT)
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004912-13899-8-git-send-email-stefan.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <05290c1d-92ad-1dab-5d9d-32210bf08c53@linaro.org>
Date: Thu, 19 Jul 2018 11:28:10 -0700
MIME-Version: 1.0
In-Reply-To: <1532004912-13899-8-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 07/40] target/mips: Add emulation of
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
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 07/19/2018 05:54 AM, Stefan Markovic wrote:
> +/* Used for 16-bit store instructions.  */
> +static int decode_gpr_gpr3_src_store(int r)
> +{
> +    static const int map[] = { 0, 17, 18, 19, 4, 5, 6, 7 };
> +
> +    return map[r & 0x7];
> +}

Same comment re comment as before.

>      case NM_P16_LB:
> +        {
> +            uint32_t u = extract32(ctx->opcode, 0, 2);
> +            switch (((ctx->opcode) >> 2) & 0x03) {
> +            case NM_LB16:
> +                gen_ld(ctx, OPC_LB, rt, rs, u);
> +                break;
> +            case NM_SB16:
> +                {
> +                    int rt = decode_gpr_gpr3_src_store(
> +                                 NANOMIPS_EXTRACT_RD(ctx->opcode));

Shadowing outer rt variable.  And indeed, NANOMIPS_EXTRACT_RD has already been
extracted into it, so this becomes just

    rt = decode_gpr_gpr3_src_store(rt);

Similarly throughout the rest of this file.

Consider creating one "int imm" variable at the top of the function that you
can reuse for all of these immediate value extractions and not have to create
these local variable blocks.


r~
