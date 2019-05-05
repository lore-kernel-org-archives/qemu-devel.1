Received: from eggs.gnu.org ([209.51.188.92]:40657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hNDon-0002bp-8p
	for qemu-devel@nongnu.org; Sun, 05 May 2019 05:52:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hNDom-0006iX-Bt
	for qemu-devel@nongnu.org; Sun, 05 May 2019 05:52:25 -0400
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-5-mark.cave-ayland@ilande.co.uk>
	<557b6776-45ab-0c00-7e1e-45fe33705d0b@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <ea616832-33ca-eeed-03f9-708394e72ecb@ilande.co.uk>
Date: Sun, 5 May 2019 10:52:13 +0100
MIME-Version: 1.0
In-Reply-To: <557b6776-45ab-0c00-7e1e-45fe33705d0b@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/14] target/ppc: introduce
 GEN_VSX_HELPER_X3 macro to fpu_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, gkurz@kaod.org

On 30/04/2019 17:36, Richard Henderson wrote:

> On 4/28/19 7:38 AM, Mark Cave-Ayland wrote:
>> +#define GEN_VSX_HELPER_X3(name, op1, op2, inval, type)                        \
>> +static void gen_##name(DisasContext *ctx)                                     \
>> +{                                                                             \
>> +    TCGv_i32 opc;                                                             \
>> +    TCGv_ptr xt, xa, xb;                                                      \
>> +    if (unlikely(!ctx->vsx_enabled)) {                                        \
>> +        gen_exception(ctx, POWERPC_EXCP_VSXU);                                \
>> +        return;                                                               \
>> +    }                                                                         \
>> +    opc = tcg_const_i32(ctx->opcode);                                         \
>> +    xt = gen_vsr_ptr(xT(ctx->opcode));                                        \
>> +    xa = gen_vsr_ptr(xA(ctx->opcode));                                        \
>> +    xb = gen_vsr_ptr(xB(ctx->opcode));                                        \
> 
> Do you still need to pass opc?
> 
> Anyway, I guess this is still progress...
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Right, it looks like VSX_CMP is the culprit here. Am I right in thinking that it's
best to remove the opc parameter from GEN_VSX_HELPER_X3 above, and then have a
separate gen and helper function for just the VSX_CMP instructions? Presumably this
reduces of the overhead at both translation and execution time for the instructions
that don't require it.


ATB,

Mark.
