Received: from eggs.gnu.org ([209.51.188.92]:37369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hNDTi-0002hG-W7
	for qemu-devel@nongnu.org; Sun, 05 May 2019 05:30:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hNDTh-0002Mu-2L
	for qemu-devel@nongnu.org; Sun, 05 May 2019 05:30:38 -0400
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-2-mark.cave-ayland@ilande.co.uk>
	<fc4d6169-12d4-3fd8-f85a-262135a62b93@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <98ba8d01-dbab-ecde-ffbd-bb46efb29215@ilande.co.uk>
Date: Sun, 5 May 2019 10:27:02 +0100
MIME-Version: 1.0
In-Reply-To: <fc4d6169-12d4-3fd8-f85a-262135a62b93@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 01/14] target/ppc: remove getVSR()/putVSR()
 from fpu_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, gkurz@kaod.org

On 30/04/2019 17:25, Richard Henderson wrote:

> On 4/28/19 7:38 AM, Mark Cave-Ayland wrote:
>>  void helper_xsaddqp(CPUPPCState *env, uint32_t opcode)
>>  {
>> -    ppc_vsr_t xt, xa, xb;
>> +    ppc_vsr_t *xt = &env->vsr[rD(opcode) + 32];
>> +    ppc_vsr_t *xa = &env->vsr[rA(opcode) + 32];
>> +    ppc_vsr_t *xb = &env->vsr[rB(opcode) + 32];
>>      float_status tstat;
>>  
>> -    getVSR(rA(opcode) + 32, &xa, env);
>> -    getVSR(rB(opcode) + 32, &xb, env);
>> -    getVSR(rD(opcode) + 32, &xt, env);
>>      helper_reset_fpstatus(env);
>>  
>>      tstat = env->fp_status;
>> @@ -1860,18 +1857,17 @@ void helper_xsaddqp(CPUPPCState *env, uint32_t opcode)
>>      }
>>  
>>      set_float_exception_flags(0, &tstat);
>> -    xt.f128 = float128_add(xa.f128, xb.f128, &tstat);
>> +    xt->f128 = float128_add(xa->f128, xb->f128, &tstat);
>>      env->fp_status.float_exception_flags |= tstat.float_exception_flags;
>>  
>>      if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {
>>          float_invalid_op_addsub(env, 1, GETPC(),
>> -                                float128_classify(xa.f128) |
>> -                                float128_classify(xb.f128));
>> +                                float128_classify(xa->f128) |
>> +                                float128_classify(xb->f128));
> 
> These values are no longer valid, because you may have written over them with
> the store to xt->f128.  You need to keep the result in a local variable until
> the location of the putVSR in order to keep the current semantics.
> 
> (Although the current semantics probably need to be reviewed with respect to
> how the exception is signaled vs the result is stored to the register file.  I
> know there are current bugs in this area with respect to regular floating-point
> operations, never mind the vector floating-point ones.)
> 
>>  #define VSX_ADD_SUB(name, op, nels, tp, fld, sfprf, r2sp)                    \
>>  void helper_##name(CPUPPCState *env, uint32_t opcode)                        \
>>  {                                                                            \
>> -    ppc_vsr_t xt, xa, xb;                                                    \
>> +    ppc_vsr_t *xt = &env->vsr[xT(opcode)];                                   \
>> +    ppc_vsr_t *xa = &env->vsr[xA(opcode)];                                   \
>> +    ppc_vsr_t *xb = &env->vsr[xB(opcode)];                                   \
>>      int i;                                                                   \
>>                                                                               \
>> -    getVSR(xA(opcode), &xa, env);                                            \
>> -    getVSR(xB(opcode), &xb, env);                                            \
>> -    getVSR(xT(opcode), &xt, env);                                            \
>>      helper_reset_fpstatus(env);                                              \
>>                                                                               \
>>      for (i = 0; i < nels; i++) {                                             \
>>          float_status tstat = env->fp_status;                                 \
>>          set_float_exception_flags(0, &tstat);                                \
>> -        xt.fld = tp##_##op(xa.fld, xb.fld, &tstat);                          \
>> +        xt->fld = tp##_##op(xa->fld, xb->fld, &tstat);                       \
>>          env->fp_status.float_exception_flags |= tstat.float_exception_flags; \
>>                                                                               \
>>          if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {    \
>>              float_invalid_op_addsub(env, sfprf, GETPC(),                     \
>> -                                    tp##_classify(xa.fld) |                  \
>> -                                    tp##_classify(xb.fld));                  \
>> +                                    tp##_classify(xa->fld) |                 \
>> +                                    tp##_classify(xb->fld));                 \
>>          }                                                                    \
> 
> Similarly.  Only here it's more interesting in that element 0 is modified when
> element 3 raises an exception.  To keep current semantics you need to keep xt
> as a ppc_vsr_t local variable and write back at the end.
> 
> It looks like the same is true for every other function.

Meh, so I forgot about the case where src == dest and obviously it's not something
that gets tickled by my test images :(

I've spent a bit of time today going through the functions and it seems that all
functions which have an xt parameter, minus a couple of the TEST macros, require the
result to be calculated in a local variable first.

I think the best solution is still to remove getVSR()/putVSR() but replace them with
macros for copying and zeroing like this:

    #define VSRCPY(d, s) (memcpy(d, s, sizeof(ppc_vsr_t)))
    #define VSRZERO(d)   (memset(d, 0, sizeof(ppc_vsr_t)))

Even though we're still doing a copy of the result register I hope that not having to
copy the 2 source registers, plus replacing the copies with a straight memcpy() will
still be an advantage. Does that seem sensible to you?

FWIW I agree that the exception handling seems inconsistent around the functions: for
example it looks strange that the VSX_FMADD code blindly copies the result back even
when an exception occurred.


ATB,

Mark.
