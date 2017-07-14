Received: from eggs.gnu.org ([2001:4830:134:3::10]:46480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dW4cA-00064X-7W
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 13:42:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dW4c9-0005cU-7x
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 13:42:54 -0400
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
References: <150002001195.22386.4679134058536830996.stgit@frigg.lan>
	<150002437386.22386.7745855254236101855.stgit@frigg.lan>
	<584dade6-5ce0-4950-c0e3-03128bae119e@twiddle.net>
Message-ID: <a831e072-2a10-d6c5-5d04-f00772b85b5b@twiddle.net>
Date: Fri, 14 Jul 2017 07:42:40 -1000
MIME-Version: 1.0
In-Reply-To: <584dade6-5ce0-4950-c0e3-03128bae119e@twiddle.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v13 18/26] target/arm: [tcg] Port to
 breakpoint_check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Emilio G. Cota" <cota@braap.org>, "open list:ARM" <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 07/14/2017 07:26 AM, Richard Henderson wrote:
> On 07/13/2017 11:26 PM, Lluís Vilanova wrote:
>> Incrementally paves the way towards using the generic instruction translation
>> loop.
>>
>> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
>> Reviewed-by: Richard Henderson <rth@twiddle.net>
>> ---
>>   target/arm/translate.c |   53 +++++++++++++++++++++++++++++++-----------------
>>   1 file changed, 34 insertions(+), 19 deletions(-)
>>
>> diff --git a/target/arm/translate.c b/target/arm/translate.c
>> index b9183fc511..55bef09739 100644
>> --- a/target/arm/translate.c
>> +++ b/target/arm/translate.c
>> @@ -11917,6 +11917,33 @@ static void arm_tr_insn_start(DisasContextBase 
>> *dcbase, CPUState *cpu)
>>   #endif
>>   }
>> +static bool arm_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
>> +                                    const CPUBreakpoint *bp)
>> +{
>> +    DisasContext *dc = container_of(dcbase, DisasContext, base);
>> +
>> +    if (bp->flags & BP_CPU) {
>> +        gen_set_condexec(dc);
>> +        gen_set_pc_im(dc, dc->pc);
>> +        gen_helper_check_breakpoints(cpu_env);
>> +        /* End the TB early; it's likely not going to be executed */
>> +        dc->base.is_jmp = DISAS_UPDATE;
>> +    } else {
>> +        gen_exception_internal_insn(dc, 0, EXCP_DEBUG);
>> +        /* The address covered by the breakpoint must be
>> +           included in [tb->pc, tb->pc + tb->size) in order
>> +           to for it to be properly cleared -- thus we
>> +           increment the PC here so that the logic setting
>> +           tb->size below does the right thing.  */
>> +        /* TODO: Advance PC by correct instruction length to
>> +         * avoid disassembler error messages */
>> +        dc->pc += 2;
>> +        dc->base.is_jmp = DISAS_NORETURN;
>> +    }
>> +
>> +    return true;
>> +}
>> +
>>   /* generate intermediate code for basic block 'tb'.  */
>>   void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
>>   {
>> @@ -11965,28 +11992,16 @@ void gen_intermediate_code(CPUState *cs, 
>> TranslationBlock *tb)
>>           if (unlikely(!QTAILQ_EMPTY(&cs->breakpoints))) {
>>               CPUBreakpoint *bp;
>>               QTAILQ_FOREACH(bp, &cs->breakpoints, entry) {
>> -                if (bp->pc == dc->pc) {
>> -                    if (bp->flags & BP_CPU) {
>> -                        gen_set_condexec(dc);
>> -                        gen_set_pc_im(dc, dc->pc);
>> -                        gen_helper_check_breakpoints(cpu_env);
>> -                        /* End the TB early; it's likely not going to be 
>> executed */
>> -                        dc->base.is_jmp = DISAS_UPDATE;
> 
> Oh I see what you're doing there in the main loop.
> And I see that you're copying existing behaviour.
> 
> That said, I do wonder if there's a better way.
> 
> Looking back at the original patch (5d98bf8f), there do not
> seem to have been any other side effects intended; simply
> "single step" any insn for which this bp condition is met.
> 
> Another way to handle this would be if we could adjust max_insns = num_insns.
> That would cause the loop to exit after the current insn, with DISAS_TOO_MANY 
> if nothing else.

Another possibility is is_jmp = DISAS_TOO_MANY, and exit the translation loop 
after the breakpoint check only for is_jmp > DISAS_TOO_MANY.  That allows all 
of the DISAS_TARGET_N values to exit as well.


r~
