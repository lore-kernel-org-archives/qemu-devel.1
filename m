Received: from eggs.gnu.org ([2001:4830:134:3::10]:40364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gWnVb-0000pv-5B
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 14:15:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gWnVa-0005rb-CX
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 14:15:55 -0500
References: <20181207085635.4291-1-mark.cave-ayland@ilande.co.uk>
	<20181207085635.4291-2-mark.cave-ayland@ilande.co.uk>
	<77de485e-14f8-8724-af97-ee76c0147f73@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <ec952bbc-2b42-1306-8463-8e391cda8ccc@ilande.co.uk>
Date: Tue, 11 Dec 2018 19:15:36 +0000
MIME-Version: 1.0
In-Reply-To: <77de485e-14f8-8724-af97-ee76c0147f73@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
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
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 10/12/2018 18:43, Richard Henderson wrote:

> On 12/7/18 2:56 AM, Mark Cave-Ayland wrote:
>> -    gen_helper_f##op(cpu_fpr[rD(ctx->opcode)], cpu_env,                       \
>> -                     cpu_fpr[rA(ctx->opcode)],                                \
>> -                     cpu_fpr[rC(ctx->opcode)], cpu_fpr[rB(ctx->opcode)]);     \
>> +    get_fpr(t0, rA(ctx->opcode));                                             \
>> +    get_fpr(t1, rC(ctx->opcode));                                             \
>> +    get_fpr(t2, rB(ctx->opcode));                                             \
>> +    gen_helper_f##op(t3, cpu_env, t0, t1, t2);                                \
>> +    set_fpr(rD(ctx->opcode), t3);                                             \
>>      if (isfloat) {                                                            \
>> -        gen_helper_frsp(cpu_fpr[rD(ctx->opcode)], cpu_env,                    \
>> -                        cpu_fpr[rD(ctx->opcode)]);                            \
>> +        get_fpr(t0, rD(ctx->opcode));                                         \
>> +        gen_helper_frsp(t3, cpu_env, t0);                                     \
>> +        set_fpr(rD(ctx->opcode), t3);                                         \
>>      }                                                                         \
> 
> This is an accurate conversion, but the writeback to the rD register need not
> happen until after helper_frsp.  Just move it below the isfloat block.

Okay - I'll fix this up in the next iteration.

> I do see that helper_frsp can raise an exception for invalid_op for SNaN.  If
> that code were actually reachable, this would have been an existing bug, in
> that we should not have written back to rD after the first operation.  However,
> any SNaN will already have been eliminated by the first operation (via
> squashing to QNaN or by exiting via exception).
> 
> Similarly in GEN_FLOAT_AB.

Noted.

>> +    get_fpr(t0, rB(ctx->opcode));
>> +    gen_helper_frsqrte(t1, cpu_env, t0);
>> +    set_fpr(rD(ctx->opcode), t1);
>> +    gen_helper_frsp(t1, cpu_env, t1);
>> +    gen_compute_fprf_float64(t1);
> 
> gen_frsqrtes has the set_fpr in the wrong place.  Likewise gen_fsqrts.

Ooops. I remember having a think a bit harder about these two functions, so I'll go
and take another look.


ATB,

Mark.
