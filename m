Received: from eggs.gnu.org ([2001:4830:134:3::10]:37141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWQbo-0002JQ-IE
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 13:48:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWQWe-0004yY-IV
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 13:43:33 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:45784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gWQWe-0004xx-BT
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 13:43:28 -0500
Received: by mail-oi1-x242.google.com with SMTP id y1so8053982oie.12
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 10:43:28 -0800 (PST)
References: <20181207085635.4291-1-mark.cave-ayland@ilande.co.uk>
	<20181207085635.4291-2-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <77de485e-14f8-8724-af97-ee76c0147f73@linaro.org>
Date: Mon, 10 Dec 2018 12:43:24 -0600
MIME-Version: 1.0
In-Reply-To: <20181207085635.4291-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/6] target/ppc: introduce get_fpr()
 and set_fpr() helpers for FP register access
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
> -    gen_helper_f##op(cpu_fpr[rD(ctx->opcode)], cpu_env,                       \
> -                     cpu_fpr[rA(ctx->opcode)],                                \
> -                     cpu_fpr[rC(ctx->opcode)], cpu_fpr[rB(ctx->opcode)]);     \
> +    get_fpr(t0, rA(ctx->opcode));                                             \
> +    get_fpr(t1, rC(ctx->opcode));                                             \
> +    get_fpr(t2, rB(ctx->opcode));                                             \
> +    gen_helper_f##op(t3, cpu_env, t0, t1, t2);                                \
> +    set_fpr(rD(ctx->opcode), t3);                                             \
>      if (isfloat) {                                                            \
> -        gen_helper_frsp(cpu_fpr[rD(ctx->opcode)], cpu_env,                    \
> -                        cpu_fpr[rD(ctx->opcode)]);                            \
> +        get_fpr(t0, rD(ctx->opcode));                                         \
> +        gen_helper_frsp(t3, cpu_env, t0);                                     \
> +        set_fpr(rD(ctx->opcode), t3);                                         \
>      }                                                                         \

This is an accurate conversion, but the writeback to the rD register need not
happen until after helper_frsp.  Just move it below the isfloat block.

I do see that helper_frsp can raise an exception for invalid_op for SNaN.  If
that code were actually reachable, this would have been an existing bug, in
that we should not have written back to rD after the first operation.  However,
any SNaN will already have been eliminated by the first operation (via
squashing to QNaN or by exiting via exception).

Similarly in GEN_FLOAT_AB.

> +    get_fpr(t0, rB(ctx->opcode));
> +    gen_helper_frsqrte(t1, cpu_env, t0);
> +    set_fpr(rD(ctx->opcode), t1);
> +    gen_helper_frsp(t1, cpu_env, t1);
> +    gen_compute_fprf_float64(t1);

gen_frsqrtes has the set_fpr in the wrong place.  Likewise gen_fsqrts.


r~
