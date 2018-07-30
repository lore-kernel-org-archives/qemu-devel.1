Received: from eggs.gnu.org ([2001:4830:134:3::10]:33661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkEze-0005Rh-3Q
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 16:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkEza-0006m8-6n
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 16:42:14 -0400
Received: from mail-vk0-x244.google.com ([2607:f8b0:400c:c05::244]:43352)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fkEza-0006lU-09
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 16:42:10 -0400
Received: by mail-vk0-x244.google.com with SMTP id s17-v6so6409256vke.10
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 13:42:09 -0700 (PDT)
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-20-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3cc80633-3b9f-07a4-1600-ca367dc6f5ba@linaro.org>
Date: Mon, 30 Jul 2018 16:42:04 -0400
MIME-Version: 1.0
In-Reply-To: <1532967169-22265-20-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 19/76] target/mips: Add emulation of
 nanoMIPS 16-bit arithmetic instructions
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
> +    case NM_P16_A2:
> +        switch (extract32(ctx->opcode, 3, 1)) {
> +        case NM_ADDIUR2:
> +            rd = extract32(ctx->opcode, 0, 3) << 2;
> +            gen_arith_imm(ctx, OPC_ADDIU, rt, rs, rd);
> +            break;
> +        case NM_P_ADDIURS5:
> +            rt = extract32(ctx->opcode, 5, 5);
> +            if (rt != 0) {
> +                rs = (sextract32(ctx->opcode, 4, 1) << 3) |
> +                      extract32(ctx->opcode, 0, 3);
> +                /* s = sign_extend( s[3] . s[2:0] , from_nbits = 4)*/
> +                gen_arith_imm(ctx, OPC_ADDIU, rt, rt, rs);
> +            }
> +            break;
> +        }

Now, these re-uses of RD and RS variables are misleading.
These are immediates that you are extracting, not register numbers.

I suggest a "target_long imm;" at the top of the function to handle all such
that will be required when this function is filled out.


r~
