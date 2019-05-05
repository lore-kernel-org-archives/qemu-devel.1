Received: from eggs.gnu.org ([209.51.188.92]:35988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNIED-0004ix-AX
	for qemu-devel@nongnu.org; Sun, 05 May 2019 10:34:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNIEC-0006yu-Di
	for qemu-devel@nongnu.org; Sun, 05 May 2019 10:34:57 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:37691)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNIEC-0006yM-5l
	for qemu-devel@nongnu.org; Sun, 05 May 2019 10:34:56 -0400
Received: by mail-pl1-x643.google.com with SMTP id z8so5049329pln.4
	for <qemu-devel@nongnu.org>; Sun, 05 May 2019 07:34:55 -0700 (PDT)
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-3-mark.cave-ayland@ilande.co.uk>
	<55204805-9275-2bc4-2c38-51dc87aa836d@linaro.org>
	<7227a96f-ae59-3ed4-8b1f-9e92005b4a69@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <626519f6-28c2-9870-0c6d-12869fbf57f1@linaro.org>
Date: Sun, 5 May 2019 07:34:52 -0700
MIME-Version: 1.0
In-Reply-To: <7227a96f-ae59-3ed4-8b1f-9e92005b4a69@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, gkurz@kaod.org

On 5/5/19 2:34 AM, Mark Cave-Ayland wrote:
>>>      EA = tcg_temp_new();                                        \
>>> -    xt = tcg_const_tl(xT(ctx->opcode));                         \
>>>      gen_set_access_type(ctx, ACCESS_INT);                       \
>>>      gen_addr_register(ctx, EA);                                 \
>>> -    gen_helper_##name(cpu_env, EA, xt, cpu_gpr[rB(ctx->opcode)]); \
>>> +    xt = tcg_const_tl(xT(ctx->opcode));                         \
>>> +    rb = tcg_const_tl(rB(ctx->opcode));                         \
>>> +    gen_helper_##name(cpu_env, EA, xt, rb);                     \
>>>      tcg_temp_free(EA);                                          \
>>>      tcg_temp_free(xt);                                          \
>>> +    tcg_temp_free(rb);                                          \
>>>  }
>>
>> Why are you adjusting the function to pass the rB register number rather than
>> the contents of rB?  That seems the wrong way around...
> 
> I think what I was trying to do here was eliminate the cpu_gpr since it
> feels to me that with the vector patchsets and your negative offset patches
> that this should be the way to go for accessing CPUState rather than using
> TCG globals.

Not for the integer register set.

> Looking at this again I realise the solution is really the same as is
> currently used
> for gen_load_spr() so I can use something like this:>
>     static inline void gen_load_gpr(TCGv t, int reg)
>     {
>         tcg_gen_ld_tl(t, cpu_env, offsetof(CPUPPCState, gpr[reg]));
>     }
> 
> Does this seem reasonable as a solution?

No, this will fail quickly.


r~
