Received: from eggs.gnu.org ([2001:4830:134:3::10]:45548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cnUV8-0001OH-OL
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 14:15:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cnUV5-0007Eq-IB
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 14:15:22 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:33828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cnUV5-0007EV-7y
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 14:15:19 -0400
Received: by mail-wr0-x234.google.com with SMTP id l37so109285987wrc.1
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 11:15:19 -0700 (PDT)
References: <20170303131113.25898-1-pbonzini@redhat.com>
	<20170303131113.25898-6-pbonzini@redhat.com>
	<871su1qfsu.fsf@linaro.org>
	<834de521-e5cc-8857-afeb-8734037f95f3@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <834de521-e5cc-8857-afeb-8734037f95f3@redhat.com>
Date: Mon, 13 Mar 2017 18:15:32 +0000
Message-ID: <87y3w9oxff.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 5/5] icount: process QEMU_CLOCK_VIRTUAL
 timers in vCPU thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 13/03/2017 17:53, Alex Bennée wrote:
>>
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>
>>> icount has become much slower after tcg_cpu_exec has stopped
>>> using the BQL.  There is also a latent bug that is masked by
>>> the slowness.
>>>
>>> The slowness happens because every occurrence of a QEMU_CLOCK_VIRTUAL
>>> timer now has to wake up the I/O thread and wait for it.  The rendez-vous
>>> is mediated by the BQL QemuMutex:
>>>
>>> - handle_icount_deadline wakes up the I/O thread with BQL taken
>>> - the I/O thread wakes up and waits on the BQL
>>> - the VCPU thread releases the BQL a little later
>>> - the I/O thread raises an interrupt, which calls qemu_cpu_kick
>>> - the VCPU thread notices the interrupt, takes the BQL to
>>>   process it and waits on it
>>>
>>> All this back and forth is extremely expensive, causing a 6 to 8-fold
>>> slowdown when icount is turned on.
>>>
>>> One may think that the issue is that the VCPU thread is too dependent
>>> on the BQL, but then the latent bug comes in.  I first tried removing
>>> the BQL completely from the x86 cpu_exec, only to see everything break.
>>> The only way to fix it (and make everything slow again) was to add a dummy
>>> BQL lock/unlock pair.
>>>
>>> This is because in -icount mode you really have to process the events
>>> before the CPU restarts executing the next instruction.  Therefore, this
>>> series moves the processing of QEMU_CLOCK_VIRTUAL timers straight in
>>> the vCPU thread when running in icount mode.
>>>
>>> The required changes include:
>>>
>>> - make the timer notification callback wake up TCG's single vCPU thread
>>>   when run from another thread.  By using async_run_on_cpu, the callback
>>>   can override all_cpu_threads_idle() when the CPU is halted.
>>>
>>> - move handle_icount_deadline after qemu_tcg_wait_io_event, so that
>>>   the timer notification callback is invoked after the dummy work item
>>>   wakes up the vCPU thread
>>>
>>> - make handle_icount_deadline run the timers instead of just waking the
>>>   I/O thread.
>>>
>>> - stop processing the timers in the main loop
>>>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>>  cpus.c               | 26 +++++++++++++++++++++++---
>>>  include/qemu/timer.h | 24 ++++++++++++++++++++++++
>>>  util/qemu-timer.c    |  4 +++-
>>>  3 files changed, 50 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/cpus.c b/cpus.c
>>> index 747addd..209c196 100644
>>> --- a/cpus.c
>>> +++ b/cpus.c
>>> @@ -804,9 +804,23 @@ static void qemu_cpu_kick_rr_cpu(void)
>>>      } while (cpu != atomic_mb_read(&tcg_current_rr_cpu));
>>>  }
>>>
>>> +static void do_nothing(CPUState *cpu, run_on_cpu_data unused)
>>> +{
>>> +}
>>> +
>>>  void qemu_timer_notify_cb(void *opaque, QEMUClockType type)
>>>  {
>>> -    qemu_notify_event();
>>> +    if (!use_icount || type != QEMU_CLOCK_VIRTUAL) {
>>> +        qemu_notify_event();
>>> +        return;
>>> +    }
>>> +
>>> +    if (!qemu_in_vcpu_thread() && first_cpu) {
>>> +        /* run_on_cpu will also kick the CPU out of halt so that
>>> +         * handle_icount_deadline runs
>>> +         */
>>> +        async_run_on_cpu(first_cpu, do_nothing, RUN_ON_CPU_NULL);
>>> +    }
>>
>> This doesn't read quite right - otherwise you get the same effect by
>> calling qemu_cpu_kick(), or even modify and call qemu_cpu_kick_rr_cpu()?
>>
>> The only real effect of having something in the work queue is you run
>> the outside of the loop before returning into the tcg_cpu_exec.
>
> Yes, and "the outside of the loop" here means handle_icount_deadline.
>
> But qemu_cpu_kick_rr_cpu won't signal condition variables, and
> qemu_cpu_kick does but it won't make cpu_thread_is_idle return false.
> Therefore, qemu_tcg_wait_io_event keeps looping.

How about:

  Scheduling work with async_run_on_cpu ensures we exit
  qemu_tcg_wait_io_event if we have halted that
  handle_icount_deadline can run.

>
>>>  }
>>>
>>>  static void kick_tcg_thread(void *opaque)
>>> @@ -1220,12 +1234,15 @@ static int64_t tcg_get_icount_limit(void)
>>>
>>>  static void handle_icount_deadline(void)
>>>  {
>>> +    assert(qemu_in_vcpu_thread());
>>>      if (use_icount) {
>>>          int64_t deadline =
>>>              qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL);
>>>
>>>          if (deadline == 0) {
>>> +            /* Wake up other AioContexts.  */
>>>              qemu_clock_notify(QEMU_CLOCK_VIRTUAL);
>>> +            qemu_clock_run_timers(QEMU_CLOCK_VIRTUAL);
>>>          }
>>>      }
>>>  }
>>> @@ -1338,6 +1355,11 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
>>>          /* Account partial waits to QEMU_CLOCK_VIRTUAL.  */
>>>          qemu_account_warp_timer();
>>>
>>> +        /* Run the timers here.  This is much more efficient than
>>> +         * waking up the I/O thread and waiting for completion.
>>> +         */
>>> +        handle_icount_deadline();
>>> +
>>>          if (!cpu) {
>>>              cpu = first_cpu;
>>>          }
>>> @@ -1379,8 +1401,6 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
>>>              atomic_mb_set(&cpu->exit_request, 0);
>>>          }
>>>
>>> -        handle_icount_deadline();
>>> -
>>
>> I guess we could just as easily move the handling to after
>> qemu_tcg_wait_io_event(cpu ? cpu : QTAILQ_FIRST(&cpus))?
>>
>> I noticed we still call handle_icount_deadline in the multi-thread case
>> which is probably superfluous unless/until we figure out a way for it to
>> work with MTTCG.
>
> Should I remove the call?  Add an assert(!use_icount)?

Yes pretty much that as an independent patch.

>
>>>          qemu_tcg_wait_io_event(cpu ? cpu : QTAILQ_FIRST(&cpus));
>>>          deal_with_unplugged_cpus();
>>>      }
>>> diff --git a/include/qemu/timer.h b/include/qemu/timer.h
>>> index 1441b42..e1742f2 100644
>>> --- a/include/qemu/timer.h
>>> +++ b/include/qemu/timer.h
>>> @@ -533,6 +533,12 @@ static inline QEMUTimer *timer_new_tl(QEMUTimerList *timer_list,
>>>   * Create a new timer and associate it with the default
>>>   * timer list for the clock type @type.
>>>   *
>>> + * The default timer list has one special feature: in icount mode,
>>> + * %QEMU_CLOCK_VIRTUAL timers are run in the vCPU thread.  This is
>>> + * not true of other timer lists, which are typically associated
>>> + * with an AioContext---each of them runs its timer callbacks in its own
>>> + * AioContext thread.
>>> + *
>>>   * Returns: a pointer to the timer
>>>   */
>>>  static inline QEMUTimer *timer_new(QEMUClockType type, int scale,
>>> @@ -550,6 +556,12 @@ static inline QEMUTimer *timer_new(QEMUClockType type, int scale,
>>>   * Create a new timer with nanosecond scale on the default timer list
>>>   * associated with the clock.
>>>   *
>>> + * The default timer list has one special feature: in icount mode,
>>> + * %QEMU_CLOCK_VIRTUAL timers are run in the vCPU thread.  This is
>>> + * not true of other timer lists, which are typically associated
>>> + * with an AioContext---each of them runs its timer callbacks in its own
>>> + * AioContext thread.
>>> + *
>>>   * Returns: a pointer to the newly created timer
>>>   */
>>>  static inline QEMUTimer *timer_new_ns(QEMUClockType type, QEMUTimerCB *cb,
>>> @@ -564,6 +576,12 @@ static inline QEMUTimer *timer_new_ns(QEMUClockType type, QEMUTimerCB *cb,
>>>   * @cb: the callback to call when the timer expires
>>>   * @opaque: the opaque pointer to pass to the callback
>>>   *
>>> + * The default timer list has one special feature: in icount mode,
>>> + * %QEMU_CLOCK_VIRTUAL timers are run in the vCPU thread.  This is
>>> + * not true of other timer lists, which are typically associated
>>> + * with an AioContext---each of them runs its timer callbacks in its own
>>> + * AioContext thread.
>>> + *
>>>   * Create a new timer with microsecond scale on the default timer list
>>>   * associated with the clock.
>>>   *
>>> @@ -581,6 +599,12 @@ static inline QEMUTimer *timer_new_us(QEMUClockType type, QEMUTimerCB *cb,
>>>   * @cb: the callback to call when the timer expires
>>>   * @opaque: the opaque pointer to pass to the callback
>>>   *
>>> + * The default timer list has one special feature: in icount mode,
>>> + * %QEMU_CLOCK_VIRTUAL timers are run in the vCPU thread.  This is
>>> + * not true of other timer lists, which are typically associated
>>> + * with an AioContext---each of them runs its timer callbacks in its own
>>> + * AioContext thread.
>>> + *
>>>   * Create a new timer with millisecond scale on the default timer list
>>>   * associated with the clock.
>>>   *
>>> diff --git a/util/qemu-timer.c b/util/qemu-timer.c
>>> index dc3181e..82d5650 100644
>>> --- a/util/qemu-timer.c
>>> +++ b/util/qemu-timer.c
>>> @@ -658,7 +658,9 @@ bool qemu_clock_run_all_timers(void)
>>>      QEMUClockType type;
>>>
>>>      for (type = 0; type < QEMU_CLOCK_MAX; type++) {
>>> -        progress |= qemu_clock_run_timers(type);
>>> +        if (qemu_clock_use_for_deadline(type)) {
>>> +            progress |= qemu_clock_run_timers(type);
>>> +        }
>>
>> minor nit: its not really qemu_clock_run_all_timers() now is it. We run
>> all but the virtual timers (if icount is enabled).
>
> Well yeah, it's all those that pass qemu_clock_use_for_deadline.
>
> Paolo

Have you done any testing with record/replay? So far I have one
reproducible run and one failure. However it is not entirely clear to me
how I am meant to cleanly halt and stop a machine so I don't corrupt the
replay log.

--
Alex Bennée
