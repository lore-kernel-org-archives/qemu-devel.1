Received: from eggs.gnu.org ([2001:4830:134:3::10]:37232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cgD8e-0008FS-Df
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:18:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cgD8b-0007UG-55
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:18:04 -0500
Received: from mail-yb0-x241.google.com ([2607:f8b0:4002:c09::241]:33137)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1cgD8b-0007Tx-1G
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:18:01 -0500
Received: by mail-yb0-x241.google.com with SMTP id n76so2274105ybg.0
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 08:17:59 -0800 (PST)
References: <20170220145335.591-1-bobby.prani@gmail.com>
	<87fuj8x2gi.fsf@linaro.org> <87k28ko1qw.fsf@gmail.com>
	<878tozwpp5.fsf@linaro.org>
From: Pranith Kumar <bobby.prani@gmail.com>
In-reply-to: <878tozwpp5.fsf@linaro.org>
Date: Tue, 21 Feb 2017 11:17:57 -0500
Message-ID: <871surv7pm.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] mttcg: Set jmp_env to handle exit from
 tb_gen_code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, rth@twiddle.net


Alex Bennée writes:

> Pranith Kumar <bobby.prani@gmail.com> writes:
>
>> Alex Bennée writes:
>>
>>> Pranith Kumar <bobby.prani@gmail.com> writes:
>>>
>>>> tb_gen_code() can exit execution using cpu_exit_loop() when it cannot
>>>> allocate new tb's. To handle this, we need to properly set the jmp_env
>>>> pointer ahead of calling tb_gen_code().
>>>>
>>>> CC:Alex Bennée <alex.bennee@linaro.org>
>>>> CC: Richard Henderson <rth@twiddle.net>
>>>> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
>>>> ---
>>>>  cpu-exec.c | 23 +++++++++++------------
>>>>  1 file changed, 11 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/cpu-exec.c b/cpu-exec.c
>>>> index 97d79612d9..4b70988b24 100644
>>>> --- a/cpu-exec.c
>>>> +++ b/cpu-exec.c
>>>> @@ -236,23 +236,22 @@ static void cpu_exec_step(CPUState *cpu)
>>>>
>>>>      cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
>>>>      tb_lock();
>>>> -    tb = tb_gen_code(cpu, pc, cs_base, flags,
>>>> -                     1 | CF_NOCACHE | CF_IGNORE_ICOUNT);
>>>> -    tb->orig_tb = NULL;
>>>> -    tb_unlock();
>>>> -
>>>> -    cc->cpu_exec_enter(cpu);
>>>> -
>>>
>>> It occurs to me we are also diverging in our locking pattern from
>>> tb_find which takes mmap_lock first. This is a NOP for system emulation
>>> but needed for user-emulation (for which we can do cpu_exec_step but not
>>> cpu_exec_nocache).
>>
>> Right. So we have to take the mmap_lock() before calling
>> tb_gen_code(). However, this lock is released in the error path before calling
>> cpu_loop_exit() if allocation of a new tb fails. The following is what I have
>> after merging with the previous EXCP_ATOMIC handling patch.
>>
>> diff --git a/cpu-exec.c b/cpu-exec.c
>> index a8e04bffbf..2bb3ba3672 100644
>> --- a/cpu-exec.c
>> +++ b/cpu-exec.c
>> @@ -228,6 +228,7 @@ static void cpu_exec_nocache(CPUState *cpu, int max_cycles,
>>
>>  static void cpu_exec_step(CPUState *cpu)
>>  {
>> +    CPUClass *cc = CPU_GET_CLASS(cpu);
>>      CPUArchState *env = (CPUArchState *)cpu->env_ptr;
>>      TranslationBlock *tb;
>>      target_ulong cs_base, pc;
>> @@ -235,16 +236,24 @@ static void cpu_exec_step(CPUState *cpu)
>>
>>      cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
>>      tb_lock();
>> -    tb = tb_gen_code(cpu, pc, cs_base, flags,
>> -                     1 | CF_NOCACHE | CF_IGNORE_ICOUNT);
>> -    tb->orig_tb = NULL;
>> -    tb_unlock();
>> -    /* execute the generated code */
>> -    trace_exec_tb_nocache(tb, pc);
>> -    cpu_tb_exec(cpu, tb);
>> -    tb_lock();
>> -    tb_phys_invalidate(tb, -1);
>> -    tb_free(tb);
>> +    if (sigsetjmp(cpu->jmp_env, 0) == 0) {
>> +        mmap_lock();
>
> That gets the locking order the wrong way around - I'm wary of that.
>

But we are in exclusive execution now, and we are releasing all the lock taken
before coming out of it. I think that should be OK. If your concern is that
this is not the normal locking pattern, then I agree. Otherwise, it should be fine.

-- 
Pranith
