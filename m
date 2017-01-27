Received: from eggs.gnu.org ([2001:4830:134:3::10]:51082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1cX9nM-0003sF-9b
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 11:54:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1cX9nG-0007On-4O
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 11:54:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51157
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imbrenda@linux.vnet.ibm.com>)
	id 1cX9nF-0007OV-Vm
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 11:54:34 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0RGsPbW075078
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 11:54:32 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28896pj9vs-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 11:54:32 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <imbrenda@linux.vnet.ibm.com>;
	Fri, 27 Jan 2017 16:54:30 -0000
References: <1476445983-16661-1-git-send-email-imbrenda@linux.vnet.ibm.com>
	<1476445983-16661-2-git-send-email-imbrenda@linux.vnet.ibm.com>
	<87poj88nxu.fsf@linaro.org>
From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Date: Fri, 27 Jan 2017 17:54:28 +0100
MIME-Version: 1.0
In-Reply-To: <87poj88nxu.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Message-Id: <ed673cc1-4513-766c-83f6-ff560c9ed1d5@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] move vm_start to cpus.c
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

On 27/01/17 17:31, Alex Benn=C3=A9e wrote:
>=20
> Claudio Imbrenda <imbrenda@linux.vnet.ibm.com> writes:
>=20
>> This patch:
>>
>> * moves vm_start to cpus.c .
>> * exports qemu_vmstop_requested, since it's needed by vm_start .
>> * extracts vm_prepare_start from vm_start; it does what vm_start did,
>>   except restarting the cpus. vm_start now calls vm_prepare_start.
>> * moves the call to qemu_clock_enable away from resume_all_vcpus, and
>>   add an explicit call to it before each instance of resume_all_vcpus
>>   in the code.
>=20
> Can you be a bit more explicit about this? Shouldn't CPU time still
> accrue even if you are only starting some of them?

This is what's happening in the newest version of this patch, which I
sent around yesterday, although I forgot to update the patch
description; I'll send a fixed version ASAP.

> I'd prefer making resume_all_vcpus() a private function called from

resume_all_vcpus is already being used in other files too, doesn't make
sense to make it private now.

> resume_some_vcpus() which can then make the QEMU_CLOCK_VIRTUAL decision
> in one place - with a comment.
>=20
>> * adds resume_some_vcpus, to selectively restart only some CPUs.
>>
>> Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
>> ---
>>  cpus.c                     | 61 +++++++++++++++++++++++++++++++++++++=
++++++++-
>>  hw/i386/kvmvapic.c         |  2 ++
>>  include/sysemu/cpus.h      |  1 +
>>  include/sysemu/sysemu.h    |  2 ++
>>  target-s390x/misc_helper.c |  2 ++
>>  vl.c                       | 32 +++---------------------
>>  6 files changed, 70 insertions(+), 30 deletions(-)
>>
>> diff --git a/cpus.c b/cpus.c
>> index 31204bb..c102624 100644
>> --- a/cpus.c
>> +++ b/cpus.c
>> @@ -1260,12 +1260,28 @@ void resume_all_vcpus(void)
>>  {
>>      CPUState *cpu;
>>
>> -    qemu_clock_enable(QEMU_CLOCK_VIRTUAL, true);
>>      CPU_FOREACH(cpu) {
>>          cpu_resume(cpu);
>>      }
>>  }
>>
>> +/**
>> + * resume_some_vcpus - resumes some vCPUs, indicated in a NULL-termin=
ated
>> + * array of CPUState *; if the parameter is NULL, all CPUs are resume=
d.
>> + */
>> +void resume_some_vcpus(CPUState **cpus)
>> +{
>> +    int idx;
>> +
>> +    if (!cpus) {
>> +        resume_all_vcpus();
>> +        return;
>> +    }
>> +    for (idx =3D 0; cpus[idx]; idx++) {
>> +        cpu_resume(cpus[idx]);
>> +    }
>> +}
>> +
>>  void cpu_remove(CPUState *cpu)
>>  {
>>      cpu->stop =3D true;
>> @@ -1396,6 +1412,49 @@ int vm_stop(RunState state)
>>      return do_vm_stop(state);
>>  }
>>
>> +/**
>> + * Prepare for (re)starting the VM.
>> + * Returns -1 if the vCPUs are not to be restarted (e.g. if they are =
already
>> + * running or in case of an error condition), 0 otherwise.
>> + */
>> +int vm_prepare_start(void)
>> +{
>> +    RunState requested;
>> +    int res =3D 0;
>> +
>> +    qemu_vmstop_requested(&requested);
>> +    if (runstate_is_running() && requested =3D=3D RUN_STATE__MAX) {
>> +        return -1;
>> +    }
>> +
>> +    /* Ensure that a STOP/RESUME pair of events is emitted if a
>> +     * vmstop request was pending.  The BLOCK_IO_ERROR event, for
>> +     * example, according to documentation is always followed by
>> +     * the STOP event.
>> +     */
>> +    if (runstate_is_running()) {
>> +        qapi_event_send_stop(&error_abort);
>> +        res =3D -1;
>> +    } else {
>> +        replay_enable_events();
>> +        cpu_enable_ticks();
>> +        runstate_set(RUN_STATE_RUNNING);
>> +        vm_state_notify(1, RUN_STATE_RUNNING);
>> +    }
>> +
>> +    /* XXX: is it ok to send this even before actually resuming the C=
PUs? */
>> +    qapi_event_send_resume(&error_abort);
>> +    return res;
>> +}
>> +
>> +void vm_start(void)
>> +{
>> +    if (!vm_prepare_start()) {
>> +        qemu_clock_enable(QEMU_CLOCK_VIRTUAL, true);
>> +        resume_all_vcpus();
>> +    }
>> +}
>> +
>>  /* does a state transition even if the VM is already stopped,
>>     current state is forgotten forever */
>>  int vm_stop_force_state(RunState state)
>> diff --git a/hw/i386/kvmvapic.c b/hw/i386/kvmvapic.c
>> index 74a549b..3101860 100644
>> --- a/hw/i386/kvmvapic.c
>> +++ b/hw/i386/kvmvapic.c
>> @@ -446,6 +446,7 @@ static void patch_instruction(VAPICROMState *s, X8=
6CPU *cpu, target_ulong ip)
>>          abort();
>>      }
>>
>> +    qemu_clock_enable(QEMU_CLOCK_VIRTUAL, true);
>>      resume_all_vcpus();
>>
>>      if (!kvm_enabled()) {
>> @@ -686,6 +687,7 @@ static void vapic_write(void *opaque, hwaddr addr,=
 uint64_t data,
>>              pause_all_vcpus();
>>              patch_byte(cpu, env->eip - 2, 0x66);
>>              patch_byte(cpu, env->eip - 1, 0x90);
>> +            qemu_clock_enable(QEMU_CLOCK_VIRTUAL, true);
>>              resume_all_vcpus();
>>          }
>>
>> diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
>> index 3728a1e..5fa074b 100644
>> --- a/include/sysemu/cpus.h
>> +++ b/include/sysemu/cpus.h
>> @@ -5,6 +5,7 @@
>>  bool qemu_in_vcpu_thread(void);
>>  void qemu_init_cpu_loop(void);
>>  void resume_all_vcpus(void);
>> +void resume_some_vcpus(CPUState **cpus);
>>  void pause_all_vcpus(void);
>>  void cpu_stop_current(void);
>>  void cpu_ticks_init(void);
>> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
>> index ef2c50b..ac301d6 100644
>> --- a/include/sysemu/sysemu.h
>> +++ b/include/sysemu/sysemu.h
>> @@ -37,6 +37,7 @@ void vm_state_notify(int running, RunState state);
>>  #define VMRESET_REPORT   true
>>
>>  void vm_start(void);
>> +int vm_prepare_start(void);
>>  int vm_stop(RunState state);
>>  int vm_stop_force_state(RunState state);
>>
>> @@ -60,6 +61,7 @@ void qemu_register_powerdown_notifier(Notifier *noti=
fier);
>>  void qemu_system_debug_request(void);
>>  void qemu_system_vmstop_request(RunState reason);
>>  void qemu_system_vmstop_request_prepare(void);
>> +bool qemu_vmstop_requested(RunState *r);
>>  int qemu_shutdown_requested_get(void);
>>  int qemu_reset_requested_get(void);
>>  void qemu_system_killed(int signal, pid_t pid);
>> diff --git a/target-s390x/misc_helper.c b/target-s390x/misc_helper.c
>> index 4df2ec6..2b74710 100644
>> --- a/target-s390x/misc_helper.c
>> +++ b/target-s390x/misc_helper.c
>> @@ -133,6 +133,7 @@ static int modified_clear_reset(S390CPU *cpu)
>>      s390_crypto_reset();
>>      scc->load_normal(CPU(cpu));
>>      cpu_synchronize_all_post_reset();
>> +    qemu_clock_enable(QEMU_CLOCK_VIRTUAL, true);
>>      resume_all_vcpus();
>>      return 0;
>>  }
>> @@ -152,6 +153,7 @@ static int load_normal_reset(S390CPU *cpu)
>>      scc->initial_cpu_reset(CPU(cpu));
>>      scc->load_normal(CPU(cpu));
>>      cpu_synchronize_all_post_reset();
>> +    qemu_clock_enable(QEMU_CLOCK_VIRTUAL, true);
>>      resume_all_vcpus();
>>      return 0;
>>  }
>> diff --git a/vl.c b/vl.c
>> index f3abd99..42addbb 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -746,7 +746,7 @@ StatusInfo *qmp_query_status(Error **errp)
>>      return info;
>>  }
>>
>> -static bool qemu_vmstop_requested(RunState *r)
>> +bool qemu_vmstop_requested(RunState *r)
>>  {
>>      qemu_mutex_lock(&vmstop_lock);
>>      *r =3D vmstop_requested;
>> @@ -767,34 +767,6 @@ void qemu_system_vmstop_request(RunState state)
>>      qemu_notify_event();
>>  }
>>
>> -void vm_start(void)
>> -{
>> -    RunState requested;
>> -
>> -    qemu_vmstop_requested(&requested);
>> -    if (runstate_is_running() && requested =3D=3D RUN_STATE__MAX) {
>> -        return;
>> -    }
>> -
>> -    /* Ensure that a STOP/RESUME pair of events is emitted if a
>> -     * vmstop request was pending.  The BLOCK_IO_ERROR event, for
>> -     * example, according to documentation is always followed by
>> -     * the STOP event.
>> -     */
>> -    if (runstate_is_running()) {
>> -        qapi_event_send_stop(&error_abort);
>> -    } else {
>> -        replay_enable_events();
>> -        cpu_enable_ticks();
>> -        runstate_set(RUN_STATE_RUNNING);
>> -        vm_state_notify(1, RUN_STATE_RUNNING);
>> -        resume_all_vcpus();
>> -    }
>> -
>> -    qapi_event_send_resume(&error_abort);
>> -}
>> -
>> -
>>  /***********************************************************/
>>  /* real time host monotonic timer */
>>
>> @@ -1910,6 +1882,7 @@ static bool main_loop_should_exit(void)
>>      if (qemu_reset_requested()) {
>>          pause_all_vcpus();
>>          qemu_system_reset(VMRESET_REPORT);
>> +        qemu_clock_enable(QEMU_CLOCK_VIRTUAL, true);
>>          resume_all_vcpus();
>>          if (!runstate_check(RUN_STATE_RUNNING) &&
>>                  !runstate_check(RUN_STATE_INMIGRATE)) {
>> @@ -1921,6 +1894,7 @@ static bool main_loop_should_exit(void)
>>          qemu_system_reset(VMRESET_SILENT);
>>          notifier_list_notify(&wakeup_notifiers, &wakeup_reason);
>>          wakeup_reason =3D QEMU_WAKEUP_REASON_NONE;
>> +        qemu_clock_enable(QEMU_CLOCK_VIRTUAL, true);
>>          resume_all_vcpus();
>>          qapi_event_send_wakeup(&error_abort);
>>      }
>=20
>=20
> --
> Alex Benn=C3=A9e
>=20
