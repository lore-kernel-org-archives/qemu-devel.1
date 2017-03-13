Received: from eggs.gnu.org ([2001:4830:134:3::10]:55034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cnTaT-0004Tg-Bs
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 13:16:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cnTaP-0001f3-R4
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 13:16:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cnTaP-0001eF-H4
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 13:16:45 -0400
References: <20170303131113.25898-1-pbonzini@redhat.com>
	<20170303131113.25898-6-pbonzini@redhat.com>
	<871su1qfsu.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <834de521-e5cc-8857-afeb-8734037f95f3@redhat.com>
Date: Mon, 13 Mar 2017 18:16:43 +0100
MIME-Version: 1.0
In-Reply-To: <871su1qfsu.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org



On 13/03/2017 17:53, Alex Benn=C3=A9e wrote:
>=20
> Paolo Bonzini <pbonzini@redhat.com> writes:
>=20
>> icount has become much slower after tcg_cpu_exec has stopped
>> using the BQL.  There is also a latent bug that is masked by
>> the slowness.
>>
>> The slowness happens because every occurrence of a QEMU_CLOCK_VIRTUAL
>> timer now has to wake up the I/O thread and wait for it.  The rendez-v=
ous
>> is mediated by the BQL QemuMutex:
>>
>> - handle_icount_deadline wakes up the I/O thread with BQL taken
>> - the I/O thread wakes up and waits on the BQL
>> - the VCPU thread releases the BQL a little later
>> - the I/O thread raises an interrupt, which calls qemu_cpu_kick
>> - the VCPU thread notices the interrupt, takes the BQL to
>>   process it and waits on it
>>
>> All this back and forth is extremely expensive, causing a 6 to 8-fold
>> slowdown when icount is turned on.
>>
>> One may think that the issue is that the VCPU thread is too dependent
>> on the BQL, but then the latent bug comes in.  I first tried removing
>> the BQL completely from the x86 cpu_exec, only to see everything break=
.
>> The only way to fix it (and make everything slow again) was to add a d=
ummy
>> BQL lock/unlock pair.
>>
>> This is because in -icount mode you really have to process the events
>> before the CPU restarts executing the next instruction.  Therefore, th=
is
>> series moves the processing of QEMU_CLOCK_VIRTUAL timers straight in
>> the vCPU thread when running in icount mode.
>>
>> The required changes include:
>>
>> - make the timer notification callback wake up TCG's single vCPU threa=
d
>>   when run from another thread.  By using async_run_on_cpu, the callba=
ck
>>   can override all_cpu_threads_idle() when the CPU is halted.
>>
>> - move handle_icount_deadline after qemu_tcg_wait_io_event, so that
>>   the timer notification callback is invoked after the dummy work item
>>   wakes up the vCPU thread
>>
>> - make handle_icount_deadline run the timers instead of just waking th=
e
>>   I/O thread.
>>
>> - stop processing the timers in the main loop
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  cpus.c               | 26 +++++++++++++++++++++++---
>>  include/qemu/timer.h | 24 ++++++++++++++++++++++++
>>  util/qemu-timer.c    |  4 +++-
>>  3 files changed, 50 insertions(+), 4 deletions(-)
>>
>> diff --git a/cpus.c b/cpus.c
>> index 747addd..209c196 100644
>> --- a/cpus.c
>> +++ b/cpus.c
>> @@ -804,9 +804,23 @@ static void qemu_cpu_kick_rr_cpu(void)
>>      } while (cpu !=3D atomic_mb_read(&tcg_current_rr_cpu));
>>  }
>>
>> +static void do_nothing(CPUState *cpu, run_on_cpu_data unused)
>> +{
>> +}
>> +
>>  void qemu_timer_notify_cb(void *opaque, QEMUClockType type)
>>  {
>> -    qemu_notify_event();
>> +    if (!use_icount || type !=3D QEMU_CLOCK_VIRTUAL) {
>> +        qemu_notify_event();
>> +        return;
>> +    }
>> +
>> +    if (!qemu_in_vcpu_thread() && first_cpu) {
>> +        /* run_on_cpu will also kick the CPU out of halt so that
>> +         * handle_icount_deadline runs
>> +         */
>> +        async_run_on_cpu(first_cpu, do_nothing, RUN_ON_CPU_NULL);
>> +    }
>=20
> This doesn't read quite right - otherwise you get the same effect by
> calling qemu_cpu_kick(), or even modify and call qemu_cpu_kick_rr_cpu()=
?
>=20
> The only real effect of having something in the work queue is you run
> the outside of the loop before returning into the tcg_cpu_exec.

Yes, and "the outside of the loop" here means handle_icount_deadline.

But qemu_cpu_kick_rr_cpu won't signal condition variables, and
qemu_cpu_kick does but it won't make cpu_thread_is_idle return false.
Therefore, qemu_tcg_wait_io_event keeps looping.

>>  }
>>
>>  static void kick_tcg_thread(void *opaque)
>> @@ -1220,12 +1234,15 @@ static int64_t tcg_get_icount_limit(void)
>>
>>  static void handle_icount_deadline(void)
>>  {
>> +    assert(qemu_in_vcpu_thread());
>>      if (use_icount) {
>>          int64_t deadline =3D
>>              qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL);
>>
>>          if (deadline =3D=3D 0) {
>> +            /* Wake up other AioContexts.  */
>>              qemu_clock_notify(QEMU_CLOCK_VIRTUAL);
>> +            qemu_clock_run_timers(QEMU_CLOCK_VIRTUAL);
>>          }
>>      }
>>  }
>> @@ -1338,6 +1355,11 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *ar=
g)
>>          /* Account partial waits to QEMU_CLOCK_VIRTUAL.  */
>>          qemu_account_warp_timer();
>>
>> +        /* Run the timers here.  This is much more efficient than
>> +         * waking up the I/O thread and waiting for completion.
>> +         */
>> +        handle_icount_deadline();
>> +
>>          if (!cpu) {
>>              cpu =3D first_cpu;
>>          }
>> @@ -1379,8 +1401,6 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg=
)
>>              atomic_mb_set(&cpu->exit_request, 0);
>>          }
>>
>> -        handle_icount_deadline();
>> -
>=20
> I guess we could just as easily move the handling to after
> qemu_tcg_wait_io_event(cpu ? cpu : QTAILQ_FIRST(&cpus))?
>=20
> I noticed we still call handle_icount_deadline in the multi-thread case
> which is probably superfluous unless/until we figure out a way for it t=
o
> work with MTTCG.

Should I remove the call?  Add an assert(!use_icount)?

>>          qemu_tcg_wait_io_event(cpu ? cpu : QTAILQ_FIRST(&cpus));
>>          deal_with_unplugged_cpus();
>>      }
>> diff --git a/include/qemu/timer.h b/include/qemu/timer.h
>> index 1441b42..e1742f2 100644
>> --- a/include/qemu/timer.h
>> +++ b/include/qemu/timer.h
>> @@ -533,6 +533,12 @@ static inline QEMUTimer *timer_new_tl(QEMUTimerLi=
st *timer_list,
>>   * Create a new timer and associate it with the default
>>   * timer list for the clock type @type.
>>   *
>> + * The default timer list has one special feature: in icount mode,
>> + * %QEMU_CLOCK_VIRTUAL timers are run in the vCPU thread.  This is
>> + * not true of other timer lists, which are typically associated
>> + * with an AioContext---each of them runs its timer callbacks in its =
own
>> + * AioContext thread.
>> + *
>>   * Returns: a pointer to the timer
>>   */
>>  static inline QEMUTimer *timer_new(QEMUClockType type, int scale,
>> @@ -550,6 +556,12 @@ static inline QEMUTimer *timer_new(QEMUClockType =
type, int scale,
>>   * Create a new timer with nanosecond scale on the default timer list
>>   * associated with the clock.
>>   *
>> + * The default timer list has one special feature: in icount mode,
>> + * %QEMU_CLOCK_VIRTUAL timers are run in the vCPU thread.  This is
>> + * not true of other timer lists, which are typically associated
>> + * with an AioContext---each of them runs its timer callbacks in its =
own
>> + * AioContext thread.
>> + *
>>   * Returns: a pointer to the newly created timer
>>   */
>>  static inline QEMUTimer *timer_new_ns(QEMUClockType type, QEMUTimerCB=
 *cb,
>> @@ -564,6 +576,12 @@ static inline QEMUTimer *timer_new_ns(QEMUClockTy=
pe type, QEMUTimerCB *cb,
>>   * @cb: the callback to call when the timer expires
>>   * @opaque: the opaque pointer to pass to the callback
>>   *
>> + * The default timer list has one special feature: in icount mode,
>> + * %QEMU_CLOCK_VIRTUAL timers are run in the vCPU thread.  This is
>> + * not true of other timer lists, which are typically associated
>> + * with an AioContext---each of them runs its timer callbacks in its =
own
>> + * AioContext thread.
>> + *
>>   * Create a new timer with microsecond scale on the default timer lis=
t
>>   * associated with the clock.
>>   *
>> @@ -581,6 +599,12 @@ static inline QEMUTimer *timer_new_us(QEMUClockTy=
pe type, QEMUTimerCB *cb,
>>   * @cb: the callback to call when the timer expires
>>   * @opaque: the opaque pointer to pass to the callback
>>   *
>> + * The default timer list has one special feature: in icount mode,
>> + * %QEMU_CLOCK_VIRTUAL timers are run in the vCPU thread.  This is
>> + * not true of other timer lists, which are typically associated
>> + * with an AioContext---each of them runs its timer callbacks in its =
own
>> + * AioContext thread.
>> + *
>>   * Create a new timer with millisecond scale on the default timer lis=
t
>>   * associated with the clock.
>>   *
>> diff --git a/util/qemu-timer.c b/util/qemu-timer.c
>> index dc3181e..82d5650 100644
>> --- a/util/qemu-timer.c
>> +++ b/util/qemu-timer.c
>> @@ -658,7 +658,9 @@ bool qemu_clock_run_all_timers(void)
>>      QEMUClockType type;
>>
>>      for (type =3D 0; type < QEMU_CLOCK_MAX; type++) {
>> -        progress |=3D qemu_clock_run_timers(type);
>> +        if (qemu_clock_use_for_deadline(type)) {
>> +            progress |=3D qemu_clock_run_timers(type);
>> +        }
>=20
> minor nit: its not really qemu_clock_run_all_timers() now is it. We run
> all but the virtual timers (if icount is enabled).

Well yeah, it's all those that pass qemu_clock_use_for_deadline.

Paolo

>>      }
>>
>>      return progress;
>=20
>=20
> --
> Alex Benn=C3=A9e
>=20
