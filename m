Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F4FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 13:43:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7B8020873
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 13:43:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7B8020873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdwLP-0000zv-3P
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 09:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jdwKo-0000Pf-Vm
 for qemu-devel@nongnu.org; Wed, 27 May 2020 09:43:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:60158)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jdwKm-0008PQ-Dt
 for qemu-devel@nongnu.org; Wed, 27 May 2020 09:43:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 543F0AAC7;
 Wed, 27 May 2020 13:43:03 +0000 (UTC)
Subject: Re: [RFC v3 4/4] cpus: extract out accel-specific code to each accel
To: Roman Bolshakov <r.bolshakov@yadro.com>
References: <20200525145440.29728-1-cfontana@suse.de>
 <20200525145440.29728-5-cfontana@suse.de>
 <20200526191600.GA4851@SPB-NB-133.local>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <69337969-63d0-b870-3129-6cf886d541dc@suse.de>
Date: Wed, 27 May 2020 15:42:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200526191600.GA4851@SPB-NB-133.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 00:24:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Cameron Esfahani <dirty@apple.com>, haxm-team@intel.com,
 Colin Xu <colin.xu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Wenchao Wang <wenchao.wang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ciao Roman,

thanks for looking at this and trying it out,

On 5/26/20 9:16 PM, Roman Bolshakov wrote:
> On Mon, May 25, 2020 at 04:54:40PM +0200, Claudio Fontana wrote:
>> each accelerator registers a new "CpusAccelInterface"
>> on initialization, providing functions for starting a vcpu,
>> kicking a vcpu, and sychronizing state.
>>
>> This way the code in cpus.cc is now all general softmmu code,
>> nothing (or almost nothing) accelerator-specific anymore.
>>
>> Signed-off-by: Claudio Fontana <cfontana@suse.de>
>> ---
>>  MAINTAINERS                          |   1 +
>>  accel/kvm/Makefile.objs              |   2 +
>>  accel/kvm/kvm-all.c                  |  15 +-
>>  accel/kvm/kvm-cpus-interface.c       |  94 ++++
>>  accel/kvm/kvm-cpus-interface.h       |   8 +
>>  accel/qtest.c                        |  82 ++++
>>  accel/stubs/kvm-stub.c               |   3 +-
>>  accel/tcg/Makefile.objs              |   1 +
>>  accel/tcg/tcg-all.c                  |  12 +-
>>  accel/tcg/tcg-cpus-interface.c       | 523 ++++++++++++++++++++
>>  accel/tcg/tcg-cpus-interface.h       |   8 +
>>  hw/core/cpu.c                        |   1 +
>>  include/sysemu/cpus.h                |  32 ++
>>  include/sysemu/hvf.h                 |   1 -
>>  include/sysemu/hw_accel.h            |  57 +--
>>  include/sysemu/kvm.h                 |   2 +-
>>  softmmu/cpus.c                       | 911 +++--------------------------------
>>  stubs/Makefile.objs                  |   1 +
>>  stubs/cpu-synchronize-state.c        |  15 +
>>  target/i386/Makefile.objs            |   7 +-
>>  target/i386/hax-all.c                |   6 +-
>>  target/i386/hax-cpus-interface.c     |  85 ++++
>>  target/i386/hax-cpus-interface.h     |   8 +
>>  target/i386/hax-i386.h               |   2 +
>>  target/i386/hax-posix.c              |  12 +
>>  target/i386/hax-windows.c            |  20 +
>>  target/i386/hvf/Makefile.objs        |   2 +-
>>  target/i386/hvf/hvf-cpus-interface.c |  92 ++++
>>  target/i386/hvf/hvf-cpus-interface.h |   8 +
>>  target/i386/hvf/hvf.c                |   5 +-
>>  target/i386/whpx-all.c               |   3 +
>>  target/i386/whpx-cpus-interface.c    |  96 ++++
>>  target/i386/whpx-cpus-interface.h    |   8 +
>>  33 files changed, 1220 insertions(+), 903 deletions(-)
>>  create mode 100644 accel/kvm/kvm-cpus-interface.c
>>  create mode 100644 accel/kvm/kvm-cpus-interface.h
>>  create mode 100644 accel/tcg/tcg-cpus-interface.c
>>  create mode 100644 accel/tcg/tcg-cpus-interface.h
>>  create mode 100644 stubs/cpu-synchronize-state.c
>>  create mode 100644 target/i386/hax-cpus-interface.c
>>  create mode 100644 target/i386/hax-cpus-interface.h
>>  create mode 100644 target/i386/hvf/hvf-cpus-interface.c
>>  create mode 100644 target/i386/hvf/hvf-cpus-interface.h
>>  create mode 100644 target/i386/whpx-cpus-interface.c
>>  create mode 100644 target/i386/whpx-cpus-interface.h
> 
> Hi Claudio,
> 
> Overall it looks good.
> 
> I wonder if the new structure should get singular form, i.e.
> softmmu/cpu.c instead of softmmu/cpus.c

One problem we have in the codebase I think is just an overabundance of cpu.c, cpu.h,
and functions called cpu_some_thing(), so it is hard to understand what is what.

"cpus" is at least different, and (if you know of course) it points you to a specific module.

We could look for another module name to match more what is inside, however I did keep it on purpose,
considering that cpus.h, cpus.c offers functionality to run on _all_ cpus, fe:

list_cpus,
cpu_synchronize_all_states,
cpu_synchronize_all_post_reset,
cpu_synchronize_all_post_init,
cpu_synchronize_all_pre_loadvm,
pause_all_vcpus,
resume_all_vcpus,
vm_prepare_start,
vm_start,
vm_shutdown


I agree with the sentiment that the current situation of modules, names, functions they contain and headers is confusing,
however here I would stay with the (imperfect) cpus.c module name, but maybe there are other opinions we can collect on a possible alternative.


> 
> Perhaps cpus.c had plural form because it was related to implementation
> of multiple CPUs/accels. After the split, each accel got it's own
> implementation of accel interface.

Perhaps, I don't really know.

> 
> "<accel>-cpus-interface.c" contains implementation rather than interface
> it's a bit confusing. Perhaps it should be called: "<accel>-cpu.c" or
> even "<accel>-accel.c".

What I would like to convey here clearly is that the file contains the
implementation for kvm of the cpus accel interface.

I guess kvm-cpus-interface-impl.c would be more "correct"?

Maybe just kvm-cpus.c or kvm-[whatever name we replace the name "cpus.c" with]?

> 
> By the way, If we use registration for each accel, does it mean that
> include/sysemu/<accel>.h and accel stubs are no longer needed in shared
> location?

Does it? It seems to me AccelClass and AccelState is used a bit all over the place.


> 
> There's an AccelClass in accel/accel.c, I wonder if it should be re-used
> for accel CPU registration? I don't know but may be generic the leftover

I had a comment in the RFCv2 thread about this, since it's the first thing I tried:

"
NB: here I _really_ wanted to make AccelClass more useful and add methods to it.

In practice though, accessing the methods becomes clunky and expensive with lots of indirections from cpus.c

(current_accel() call, -> accelerator, ACCEL_GET_CLASS(), -> AccelCpusInterface -> method);

In my first attempt I ended up with a cache of the interface in cpus.c ,
and at that point the usefulness of having the methods at all in AccelClass becomes nil, so that resulted in the cpus accel interface being disjointed from AccelClass.
"

However I guess the question is, are we ok to increase substantially the cost of each vcpu kick and sync state for all archs?

I would prefer to err on the side of caution and reduce the overhead increase, although making more use of AccelClass would be "nicer",
maybe there are more opinions to collect here as well, or some experience on the hotness of the kick and sync_state code paths for all archs?


> of cpus.c also belongs to accel/ rather than softmmu/?


cpus.c does not seem to belong to accel/


> 
>>  
>> diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
>> index 149de000a0..cae22afe4d 100644
>> --- a/include/sysemu/cpus.h
>> +++ b/include/sysemu/cpus.h
>> @@ -4,7 +4,39 @@
>>  #include "qemu/timer.h"
>>  
>>  /* cpus.c */
>> +
>> +/* CPU execution threads */
>> +
>> +typedef struct CpusAccelInterface {
>> +    void (*create_vcpu_thread)(CPUState *cpu);
>> +    void (*kick_vcpu_thread)(CPUState *cpu);
>> +
>> +    void (*cpu_synchronize_post_reset)(CPUState *cpu);
>> +    void (*cpu_synchronize_post_init)(CPUState *cpu);
>> +    void (*cpu_synchronize_state)(CPUState *cpu);
>> +    void (*cpu_synchronize_pre_loadvm)(CPUState *cpu);
>> +} CpusAccelInterface;
> 
> 
> I think plural name may be replaced to singular. Interface suffix
> doesn't seem to be used in QEMU.
> 
> cpu_ and _vcpu are sort meaning the same and may be replaced to generic
> cpu_ prefix. There's a CPUState, CPU<Arch>State, and IMO shorter
> CPUAccel seems to match the naming. I also don't know if cpu_ prefix
> should be kept.
> 
> So here's how I see the interface:
> 
> typedef struct CPUAccel {
>     void (*create_thread)(CPUState *cpu);
>     void (*kick_thread)(CPUState *cpu);
> 
>     void (*synchronize_post_reset)(CPUState *cpu);
>     void (*synchronize_post_init)(CPUState *cpu);
>     void (*synchronize_state)(CPUState *cpu);
>     void (*synchronize_pre_loadvm)(CPUState *cpu);
> } CPUAccel;
> 
> 

It is fine too, for the "CPUAccel" name, I think it would depend on a couple of other things pending resolution above
(but I think it is fine in principle).


>> +
>> +/* register accel-specific interface */
>> +void cpus_register_accel_interface(CpusAccelInterface *i);
>> +
>> +/* interface available for cpus accelerator threads */
>> +
>> +/* For temporary buffers for forming a name */
>> +#define VCPU_THREAD_NAME_SIZE 16
>> +
>> +void cpus_kick_thread(CPUState *cpu);
> 
> If it's addressing a single CPU should it be singular too, i.e.
> cpu_kick_thread?


here the problem is again that there are a lot of functions called kick_cpu_something, kick_vcpu_something or various permutations.

Having modulename_function would help in this case I think.

There is precedent in qemu, and would actually like to see more of it, as it makes things way easier to understand and disambiguate, but maybe it's just my thing?

I could push for even more consistency in this regard in cpus.c and elsewhere (I have balanced this desire with the need to also not change too much, too quickly).

> 
>> +bool cpu_thread_is_idle(CPUState *cpu);
>>  bool all_cpu_threads_idle(void);
>> +bool cpu_can_run(CPUState *cpu);
>> +void qemu_wait_io_event_common(CPUState *cpu);
>> +void qemu_wait_io_event(CPUState *cpu);
>> +void cpu_thread_signal_created(CPUState *cpu);
>> +void cpu_thread_signal_destroyed(CPUState *cpu);
>> +void cpu_handle_guest_debug(CPUState *cpu);
>> +
>> +/* end interface for cpus accelerator threads */
>> +
>>  bool qemu_in_vcpu_thread(void);
>>  void qemu_init_cpu_loop(void);
>>  void resume_all_vcpus(void);
>> diff --git a/target/i386/hvf/Makefile.objs b/target/i386/hvf/Makefile.objs
>> index 927b86bc67..bdbc2c0227 100644
>> --- a/target/i386/hvf/Makefile.objs
>> +++ b/target/i386/hvf/Makefile.objs
>> @@ -1,2 +1,2 @@
>> -obj-y += hvf.o
>> +obj-y += hvf.o hvf-cpus-interface.o
>>  obj-y += x86.o x86_cpuid.o x86_decode.o x86_descr.o x86_emu.o x86_flags.o x86_mmu.o x86hvf.o x86_task.o
>> diff --git a/target/i386/hvf/hvf-cpus-interface.c b/target/i386/hvf/hvf-cpus-interface.c
>> new file mode 100644
>> index 0000000000..54bfe307c1
>> --- /dev/null
>> +++ b/target/i386/hvf/hvf-cpus-interface.c
>> @@ -0,0 +1,92 @@
>> +#include "qemu/osdep.h"
>> +#include "qemu/error-report.h"
>> +#include "qemu/main-loop.h"
>> +#include "sysemu/hvf.h"
>> +#include "sysemu/runstate.h"
>> +#include "sysemu/cpus.h"
>> +#include "qemu/guest-random.h"
>> +
>> +#include "hvf-cpus-interface.h"
>> +
>> +/*
>> + * The HVF-specific vCPU thread function. This one should only run when the host
>> + * CPU supports the VMX "unrestricted guest" feature.
>> + */
>> +static void *hvf_cpu_thread_fn(void *arg)
>> +{
>> +    CPUState *cpu = arg;
>> +
>> +    int r;
>> +
>> +    assert(hvf_enabled());
>> +
>> +    rcu_register_thread();
>> +
>> +    qemu_mutex_lock_iothread();
>> +    qemu_thread_get_self(cpu->thread);
>> +
>> +    cpu->thread_id = qemu_get_thread_id();
>> +    cpu->can_do_io = 1;
>> +    current_cpu = cpu;
>> +
>> +    hvf_init_vcpu(cpu);
>> +
>> +    /* signal CPU creation */
>> +    cpu_thread_signal_created(cpu);
>> +    qemu_guest_random_seed_thread_part2(cpu->random_seed);
>> +
>> +    do {
>> +        if (cpu_can_run(cpu)) {
>> +            r = hvf_vcpu_exec(cpu);
>> +            if (r == EXCP_DEBUG) {
>> +                cpu_handle_guest_debug(cpu);
>> +            }
>> +        }
>> +        qemu_wait_io_event(cpu);
>> +    } while (!cpu->unplug || cpu_can_run(cpu));
>> +
>> +    hvf_vcpu_destroy(cpu);
>> +    cpu_thread_signal_destroyed(cpu);
>> +    qemu_mutex_unlock_iothread();
>> +    rcu_unregister_thread();
>> +    return NULL;
>> +}
>> +
>> +static void hvf_kick_vcpu_thread(CPUState *cpu)
>> +{
>> +    cpus_kick_thread(cpu);
> 
> 
> I think we should leave it empty since it's not really implemented for
> HVF. Here's a WIP implementation I'm yet to send:
> 
> https://github.com/roolebo/qemu/commit/4437a4b8af31b0adaa58375f09e0b8547507f64f#diff-5e6ad1baa140ca4a1743b5a2f1a664b5R970

Just let me know what the best course of action is, I thought I reproduced here the existing behavior?

(remember that the code that cpus_kick_thread now consists of _was_ executed before for hvf, in the form of qemu_cpu_kick_thread)

If we need some changes to the existing behavior, should we do it after this so we don't mix refactoring with functional change?

> 
>> +}
>> +
>> +static void hvf_cpu_synchronize_noop(CPUState *cpu)
>> +{
>> +}
>> +
>> +static void hvf_start_vcpu_thread(CPUState *cpu)
>> +{
>> +    char thread_name[VCPU_THREAD_NAME_SIZE];
>> +
>> +    /*
>> +     * HVF currently does not support TCG, and only runs in
>> +     * unrestricted-guest mode.
>> +     */
>> +    assert(hvf_enabled());
>> +
>> +    cpu->thread = g_malloc0(sizeof(QemuThread));
>> +    cpu->halt_cond = g_malloc0(sizeof(QemuCond));
>> +    qemu_cond_init(cpu->halt_cond);
>> +
>> +    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/HVF",
>> +             cpu->cpu_index);
>> +    qemu_thread_create(cpu->thread, thread_name, hvf_cpu_thread_fn,
>> +                       cpu, QEMU_THREAD_JOINABLE);
>> +}
>> +
>> +CpusAccelInterface hvf_cpus_interface = {
>> +    .create_vcpu_thread = hvf_start_vcpu_thread,
> 
> I think it was meant as hvf_create_vcpu_thread.


throughout the code it is "start" for all accelerators, that is probably why "start" was used here as well.
The only exception being TCG, which had "init".


> 
>> +    .kick_vcpu_thread = hvf_kick_vcpu_thread,
>> +
>> +    .cpu_synchronize_post_reset = hvf_cpu_synchronize_noop,
>> +    .cpu_synchronize_post_init = hvf_cpu_synchronize_noop,
>> +    .cpu_synchronize_state = hvf_cpu_synchronize_noop,
>> +    .cpu_synchronize_pre_loadvm = hvf_cpu_synchronize_noop,
> 
> I have tested the RFC with hvf accel and it seems to work although I
> expected it fail. 

So it works?

> The noop functions are the reason of the behaviour. In
> some sense it's not equivalent to what it was before but to be fair it's
> not possible to use existing hvf_cpu_synchronize_* functions in
> target/i386/hvf/hvf.c without breaking hvf.
> 
> Here's how it fails.

Sorry I don't follow, you mentioned before that it seems to work, but now that it fails?

> hvf_cpu_synchronize_state() sets dirty flag to mark
> that emulator registers in CPUX86State are going to be out of sync with
> accel registers. If we bind .cpu_synchronize_state to
> hvf_synchronize_state it'd be called from vapic_write() on I/O writes
> (from kvmvapic.bin option ROM) to KVM vAPIC page (I/O port 0x7e).
> 
> But HVF uses two emulator states CPUX86State and HVFX86EmulatorState
> and they may become out-of-sync. That's exactly what happens when an I/O
> write to KVM vAPIC is made. The I/O write triggers cpu state
> synchronization, so VMCS registers are fetched into CPUX86State and the
> vcpu_dirty flag is set. Emulation code then advances RIP in the
> macvm_set_rip() by modifying VMCS directly. On the next round of vcpu
> run loop it checks if the cpu is dirty (it is) and pushes CPUX86State
> into the VMCS, effectively overwriting what was set by macvm_set_rip().
> 
> If the RFC isn't expected to be merged for a couple of weeks I can
> prepare a series that drops HVFX86EmulatorState. I need the change for
> single-stepping support in HVF anyway.

Does this have anything to do with the TODO in the current code in cpus.c:

void cpu_synchronize_all_states(void)
{
    CPUState *cpu;

    CPU_FOREACH(cpu) {
        cpu_synchronize_state(cpu);
        /* TODO: move to cpu_synchronize_state() */
        if (hvf_enabled()) {
            hvf_cpu_synchronize_state(cpu);
        }
    }
}

?

Ciao and thanks for the comments, really appreciated!

Claudio

