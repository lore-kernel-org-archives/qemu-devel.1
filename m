Received: from eggs.gnu.org ([2001:4830:134:3::10]:37493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWQcP-0002mN-JB
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 13:49:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWQcM-0000pJ-8B
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 13:49:25 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45700)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gWQcL-0000nN-Bh
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 13:49:22 -0500
Received: by mail-ot1-x343.google.com with SMTP id 32so11402941ota.12
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 10:49:19 -0800 (PST)
References: <20181207085635.4291-1-mark.cave-ayland@ilande.co.uk>
	<20181207085635.4291-3-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e4de9517-e90f-076a-a358-eec1e1d2de64@linaro.org>
Date: Mon, 10 Dec 2018 12:49:15 -0600
MIME-Version: 1.0
In-Reply-To: <20181207085635.4291-3-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 2/6] target/ppc: introduce get_avr64()
 and set_avr64() helpers for VMX register access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 12/7/18 2:56 AM, Mark Cave-Ayland wrote:
> +    avr = tcg_temp_new_i64();                                                 \
>      EA = tcg_temp_new();                                                      \
>      gen_addr_reg_index(ctx, EA);                                              \
>      tcg_gen_andi_tl(EA, EA, ~0xf);                                            \
>      /* We only need to swap high and low halves. gen_qemu_ld64_i64 does       \
>         necessary 64-bit byteswap already. */                                  \
>      if (ctx->le_mode) {                                                       \
> -        gen_qemu_ld64_i64(ctx, cpu_avrl[rD(ctx->opcode)], EA);                \
> +        gen_qemu_ld64_i64(ctx, avr, EA);                                      \
> +        set_avr64(rD(ctx->opcode), avr, false);                               \
>          tcg_gen_addi_tl(EA, EA, 8);                                           \
> -        gen_qemu_ld64_i64(ctx, cpu_avrh[rD(ctx->opcode)], EA);                \
> +        gen_qemu_ld64_i64(ctx, avr, EA);                                      \
> +        set_avr64(rD(ctx->opcode), avr, true);  

An accurate conversion, but I'm going to call this an existing bug:

The writeback to both avr{l,h} should be delayed until all exceptions have been
raised.  Thus you should perform the two gen_qemu_ld64_i64 into two temporaries
and only then write them both back via set_avr64.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
