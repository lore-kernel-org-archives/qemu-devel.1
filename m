Received: from eggs.gnu.org ([2001:4830:134:3::10]:51859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f3g0g-0007C9-8u
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:51:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f3g0b-00079s-GQ
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:51:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33588 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f3g0b-00079k-Am
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:51:17 -0400
References: <20180111125444.6498-1-pbonzini@redhat.com>
	<87lge3cl9u.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d7c8f261-5683-a2ce-3f5e-d6d53c104267@redhat.com>
Date: Wed, 4 Apr 2018 12:51:04 +0200
MIME-Version: 1.0
In-Reply-To: <87lge3cl9u.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] cpus: unify qemu_*_wait_io_event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

On 04/04/2018 12:34, Alex Benn=C3=A9e wrote:
>=20
> Paolo Bonzini <pbonzini@redhat.com> writes:
>=20
>> Except for round-robin TCG, every other accelerator is using more or
>> less the same code around qemu_wait_io_event_common.  The exception
>> is HAX, which also has to eat the dummy APC that is queued by
>> qemu_cpu_kick_thread.
>>
>> We can add the SleepEx call to qemu_wait_io_event under "if
>> (!tcg_enabled())", since that is the condition that is used in
>> qemu_cpu_kick_thread, and unify the function for KVM, HAX, HVF and
>> multi-threaded TCG.  Single-threaded TCG code can also be simplified
>> since it is only used in the round-robin, sleep-if-all-CPUs-idle case.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>=20
> I had trouble applying this patch but the change seems sane to me
>=20
> Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Isn't this commit db08b687cdd5319286665aabd34f82665630416f?

Paolo

>> ---
>>  cpus.c | 49 +++++++++++++++++--------------------------------
>>  1 file changed, 17 insertions(+), 32 deletions(-)
>>
>> diff --git a/cpus.c b/cpus.c
>> index 440b9291f5..3b6c9879ec 100644
>> --- a/cpus.c
>> +++ b/cpus.c
>> @@ -911,7 +911,8 @@ static void kick_tcg_thread(void *opaque)
>>
>>  static void start_tcg_kick_timer(void)
>>  {
>> -    if (!mttcg_enabled && !tcg_kick_vcpu_timer && CPU_NEXT(first_cpu)=
) {
>> +    assert(!mttcg_enabled);
>> +    if (!tcg_kick_vcpu_timer && CPU_NEXT(first_cpu)) {
>>          tcg_kick_vcpu_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
>>                                             kick_tcg_thread, NULL);
>>          timer_mod(tcg_kick_vcpu_timer, qemu_tcg_next_kick());
>> @@ -920,6 +921,7 @@ static void start_tcg_kick_timer(void)
>>
>>  static void stop_tcg_kick_timer(void)
>>  {
>> +    assert(!mttcg_enabled);
>>      if (tcg_kick_vcpu_timer) {
>>          timer_del(tcg_kick_vcpu_timer);
>>          tcg_kick_vcpu_timer =3D NULL;
>> @@ -1154,18 +1156,9 @@ static void qemu_wait_io_event_common(CPUState =
*cpu)
>>      process_queued_cpu_work(cpu);
>>  }
>>
>> -static bool qemu_tcg_should_sleep(CPUState *cpu)
>> +static void qemu_tcg_rr_wait_io_event(CPUState *cpu)
>>  {
>> -    if (mttcg_enabled) {
>> -        return cpu_thread_is_idle(cpu);
>> -    } else {
>> -        return all_cpu_threads_idle();
>> -    }
>> -}
>> -
>> -static void qemu_tcg_wait_io_event(CPUState *cpu)
>> -{
>> -    while (qemu_tcg_should_sleep(cpu)) {
>> +    while (all_cpu_threads_idle()) {
>>          stop_tcg_kick_timer();
>>          qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
>>      }
>> @@ -1175,20 +1168,18 @@ static void qemu_tcg_wait_io_event(CPUState *c=
pu)
>>      qemu_wait_io_event_common(cpu);
>>  }
>>
>> -static void qemu_kvm_wait_io_event(CPUState *cpu)
>> +static void qemu_wait_io_event(CPUState *cpu)
>>  {
>>      while (cpu_thread_is_idle(cpu)) {
>>          qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
>>      }
>>
>> -    qemu_wait_io_event_common(cpu);
>> -}
>> -
>> -static void qemu_hvf_wait_io_event(CPUState *cpu)
>> -{
>> -    while (cpu_thread_is_idle(cpu)) {
>> -        qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
>> +#ifdef _WIN32
>> +    /* Eat dummy APC queued by qemu_cpu_kick_thread.  */
>> +    if (!tcg_enabled()) {
>> +        SleepEx(0, TRUE);
>>      }
>> +#endif
>>      qemu_wait_io_event_common(cpu);
>>  }
>>
>> @@ -1224,7 +1215,7 @@ static void *qemu_kvm_cpu_thread_fn(void *arg)
>>                  cpu_handle_guest_debug(cpu);
>>              }
>>          }
>> -        qemu_kvm_wait_io_event(cpu);
>> +        qemu_wait_io_event(cpu);
>>      } while (!cpu->unplug || cpu_can_run(cpu));
>>
>>      qemu_kvm_destroy_vcpu(cpu);
>> @@ -1270,7 +1261,7 @@ static void *qemu_dummy_cpu_thread_fn(void *arg)
>>              exit(1);
>>          }
>>          qemu_mutex_lock_iothread();
>> -        qemu_wait_io_event_common(cpu);
>> +        qemu_wait_io_event(cpu);
>>      }
>>
>>      return NULL;
>> @@ -1487,7 +1478,7 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg=
)
>>              atomic_mb_set(&cpu->exit_request, 0);
>>          }
>>
>> -        qemu_tcg_wait_io_event(cpu ? cpu : QTAILQ_FIRST(&cpus));
>> +        qemu_tcg_rr_wait_io_event(cpu ? cpu : QTAILQ_FIRST(&cpus));
>>          deal_with_unplugged_cpus();
>>      }
>>
>> @@ -1518,13 +1509,7 @@ static void *qemu_hax_cpu_thread_fn(void *arg)
>>              }
>>          }
>>
>> -        while (cpu_thread_is_idle(cpu)) {
>> -            qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
>> -        }
>> -#ifdef _WIN32
>> -        SleepEx(0, TRUE);
>> -#endif
>> -        qemu_wait_io_event_common(cpu);
>> +        qemu_wait_io_event(cpu);
>>      }
>>      return NULL;
>>  }
>> @@ -1561,7 +1546,7 @@ static void *qemu_hvf_cpu_thread_fn(void *arg)
>>                  cpu_handle_guest_debug(cpu);
>>              }
>>          }
>> -        qemu_hvf_wait_io_event(cpu);
>> +        qemu_wait_io_event(cpu);
>>      } while (!cpu->unplug || cpu_can_run(cpu));
>>
>>      hvf_vcpu_destroy(cpu);
>> @@ -1640,7 +1625,7 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
>>          }
>>
>>          atomic_mb_set(&cpu->exit_request, 0);
>> -        qemu_tcg_wait_io_event(cpu);
>> +        qemu_wait_io_event(cpu);
>>      }
>>
>>      return NULL;
>=20
>=20
> --
> Alex Benn=C3=A9e
>=20
