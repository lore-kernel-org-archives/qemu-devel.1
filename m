Received: from eggs.gnu.org ([2001:4830:134:3::10]:33256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cvLzA-0003bl-0O
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 06:46:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cvLz6-0000YL-8B
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 06:46:52 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:33016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cvLz5-0000Xo-W9
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 06:46:48 -0400
Received: by mail-wr0-x233.google.com with SMTP id w43so208144301wrb.0
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 03:46:47 -0700 (PDT)
References: <20170403124524.10824-1-alex.bennee@linaro.org>
	<20170403124524.10824-8-alex.bennee@linaro.org>
	<000201d2ad05$e28626d0$a7927470$@ru> <8760ikblf7.fsf@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <8760ikblf7.fsf@linaro.org>
Date: Tue, 04 Apr 2017 11:46:45 +0100
Message-ID: <874ly4bgbu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH v1 7/9] cpus: move icount preparation
 out of tcg_exec_cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: rth@twiddle.net, pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, 'Peter Crosthwaite' <crosthwaite.peter@gmail.com>


Alex Bennée <alex.bennee@linaro.org> writes:

> Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:
>
>> I guess you are trying to fix the sympthoms of the case
>> when iothread is trying to access instruction count.
>
> In theory the main-loop should be sequenced before or after vCPU events
> because of the BQL. I'm not sure why this is not currently the case.

It seems cpu_handle_exception doesn't take the BQL until
replay_exception() has done its thing. This is fixable but the function
is a mess so I'm trying to neaten that up first.

>
>> Maybe the solution is providing access to current_cpu for the iothread
>> coupled with your patch 8?
>
> Providing cross-thread access to CPU structures brings its own
> challenges.
>
> But it does occur to me we should probably ensure
> timer_state.qemu_icount has appropriate barriers. This should be ensured
> by the BQL but if it is ever accessed by 2 threads without a BQL
> transition in-between then it is potentially racey.
>
>>
>> Pavel Dovgalyuk
>>
>>
>>> -----Original Message-----
>>> From: Alex Bennée [mailto:alex.bennee@linaro.org]
>>> Sent: Monday, April 03, 2017 3:45 PM
>>> To: dovgaluk@ispras.ru; rth@twiddle.net; pbonzini@redhat.com
>>> Cc: peter.maydell@linaro.org; qemu-devel@nongnu.org; mttcg@listserver.greensocs.com;
>>> fred.konrad@greensocs.com; a.rigo@virtualopensystems.com; cota@braap.org;
>>> bobby.prani@gmail.com; nikunj@linux.vnet.ibm.com; Alex Bennée; Peter Crosthwaite
>>> Subject: [RFC PATCH v1 7/9] cpus: move icount preparation out of tcg_exec_cpu
>>>
>>> As icount is only supported for single-threaded execution due to the
>>> requirement for determinism let's remove it from the common
>>> tcg_exec_cpu path.
>>>
>>> Also remove the additional fiddling which shouldn't be required as the
>>> icount counters should all be rectified as you enter the loop.
>>>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> ---
>>>  cpus.c | 67 +++++++++++++++++++++++++++++++++++++++++++++---------------------
>>>  1 file changed, 46 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/cpus.c b/cpus.c
>>> index 18b1746770..87638a75d2 100644
>>> --- a/cpus.c
>>> +++ b/cpus.c
>>> @@ -1179,47 +1179,66 @@ static void handle_icount_deadline(void)
>>>      }
>>>  }
>>>
>>> -static int tcg_cpu_exec(CPUState *cpu)
>>> +static void prepare_icount_for_run(CPUState *cpu)
>>>  {
>>> -    int ret;
>>> -#ifdef CONFIG_PROFILER
>>> -    int64_t ti;
>>> -#endif
>>> -
>>> -#ifdef CONFIG_PROFILER
>>> -    ti = profile_getclock();
>>> -#endif
>>>      if (use_icount) {
>>>          int64_t count;
>>>          int decr;
>>> -        timers_state.qemu_icount -= (cpu->icount_decr.u16.low
>>> -                                    + cpu->icount_extra);
>>> -        cpu->icount_decr.u16.low = 0;
>>> -        cpu->icount_extra = 0;
>>> +
>>> +        /* These should always be cleared by process_icount_data after
>>> +         * each vCPU execution. However u16.high can be raised
>>> +         * asynchronously by cpu_exit/cpu_interrupt/tcg_handle_interrupt
>>> +         */
>>> +        g_assert(cpu->icount_decr.u16.low == 0);
>>> +        g_assert(cpu->icount_extra == 0);
>>> +
>>> +
>>>          count = tcg_get_icount_limit();
>>> +
>>>          timers_state.qemu_icount += count;
>>>          decr = (count > 0xffff) ? 0xffff : count;
>>>          count -= decr;
>>>          cpu->icount_decr.u16.low = decr;
>>>          cpu->icount_extra = count;
>>>      }
>>> -    qemu_mutex_unlock_iothread();
>>> -    cpu_exec_start(cpu);
>>> -    ret = cpu_exec(cpu);
>>> -    cpu_exec_end(cpu);
>>> -    qemu_mutex_lock_iothread();
>>> -#ifdef CONFIG_PROFILER
>>> -    tcg_time += profile_getclock() - ti;
>>> -#endif
>>> +}
>>> +
>>> +static void process_icount_data(CPUState *cpu)
>>> +{
>>>      if (use_icount) {
>>>          /* Fold pending instructions back into the
>>>             instruction counter, and clear the interrupt flag.  */
>>>          timers_state.qemu_icount -= (cpu->icount_decr.u16.low
>>>                          + cpu->icount_extra);
>>> +
>>> +        /* We must be under BQL here as cpu_exit can tweak
>>> +           icount_decr.u32 */
>>> +        g_assert(qemu_mutex_iothread_locked());
>>>          cpu->icount_decr.u32 = 0;
>>>          cpu->icount_extra = 0;
>>>          replay_account_executed_instructions();
>>>      }
>>> +}
>>> +
>>> +
>>> +static int tcg_cpu_exec(CPUState *cpu)
>>> +{
>>> +    int ret;
>>> +#ifdef CONFIG_PROFILER
>>> +    int64_t ti;
>>> +#endif
>>> +
>>> +#ifdef CONFIG_PROFILER
>>> +    ti = profile_getclock();
>>> +#endif
>>> +    qemu_mutex_unlock_iothread();
>>> +    cpu_exec_start(cpu);
>>> +    ret = cpu_exec(cpu);
>>> +    cpu_exec_end(cpu);
>>> +    qemu_mutex_lock_iothread();
>>> +#ifdef CONFIG_PROFILER
>>> +    tcg_time += profile_getclock() - ti;
>>> +#endif
>>>      return ret;
>>>  }
>>>
>>> @@ -1306,7 +1325,13 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
>>>
>>>              if (cpu_can_run(cpu)) {
>>>                  int r;
>>> +
>>> +                prepare_icount_for_run(cpu);
>>> +
>>>                  r = tcg_cpu_exec(cpu);
>>> +
>>> +                process_icount_data(cpu);
>>> +
>>>                  if (r == EXCP_DEBUG) {
>>>                      cpu_handle_guest_debug(cpu);
>>>                      break;
>>> --
>>> 2.11.0


--
Alex Bennée
