Received: from eggs.gnu.org ([209.51.188.92]:49893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hNJQG-0001mn-Dh
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:51:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hNJQF-0004MO-3q
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:51:28 -0400
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-3-mark.cave-ayland@ilande.co.uk>
	<55204805-9275-2bc4-2c38-51dc87aa836d@linaro.org>
	<7227a96f-ae59-3ed4-8b1f-9e92005b4a69@ilande.co.uk>
	<626519f6-28c2-9870-0c6d-12869fbf57f1@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <cf86b84d-bf12-7b50-267d-cb2897cfd20d@ilande.co.uk>
Date: Sun, 5 May 2019 16:49:11 +0100
MIME-Version: 1.0
In-Reply-To: <626519f6-28c2-9870-0c6d-12869fbf57f1@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/14] target/ppc: remove getVSR()/putVSR()
 from mem_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, gkurz@kaod.org

On 05/05/2019 15:34, Richard Henderson wrote:

> On 5/5/19 2:34 AM, Mark Cave-Ayland wrote:
>>>>      EA = tcg_temp_new();                                        \
>>>> -    xt = tcg_const_tl(xT(ctx->opcode));                         \
>>>>      gen_set_access_type(ctx, ACCESS_INT);                       \
>>>>      gen_addr_register(ctx, EA);                                 \
>>>> -    gen_helper_##name(cpu_env, EA, xt, cpu_gpr[rB(ctx->opcode)]); \
>>>> +    xt = tcg_const_tl(xT(ctx->opcode));                         \
>>>> +    rb = tcg_const_tl(rB(ctx->opcode));                         \
>>>> +    gen_helper_##name(cpu_env, EA, xt, rb);                     \
>>>>      tcg_temp_free(EA);                                          \
>>>>      tcg_temp_free(xt);                                          \
>>>> +    tcg_temp_free(rb);                                          \
>>>>  }
>>>
>>> Why are you adjusting the function to pass the rB register number rather than
>>> the contents of rB?  That seems the wrong way around...
>>
>> I think what I was trying to do here was eliminate the cpu_gpr since it
>> feels to me that with the vector patchsets and your negative offset patches
>> that this should be the way to go for accessing CPUState rather than using
>> TCG globals.
> 
> Not for the integer register set.
> 
>> Looking at this again I realise the solution is really the same as is
>> currently used
>> for gen_load_spr() so I can use something like this:>
>>     static inline void gen_load_gpr(TCGv t, int reg)
>>     {
>>         tcg_gen_ld_tl(t, cpu_env, offsetof(CPUPPCState, gpr[reg]));
>>     }
>>
>> Does this seem reasonable as a solution?
> 
> No, this will fail quickly.

Okay in that case I'll leave it as-is. So just to satisfy my curiosity here: is the
problem here the mixing and matching of offsets and TCG globals, rather than the use
of offsets as done for the VMX/VSX registers?


ATB,

Mark.
