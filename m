Received: from eggs.gnu.org ([2001:4830:134:3::10]:38821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1chGZg-00040b-UR
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:10:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1chGZc-00066G-UP
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:10:20 -0500
Received: from mail-yb0-x244.google.com ([2607:f8b0:4002:c09::244]:35547)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1chGZc-00065u-Pk
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:10:16 -0500
Received: by mail-yb0-x244.google.com with SMTP id d88so821987ybi.2
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 06:10:16 -0800 (PST)
References: <1487914949-1294-1-git-send-email-bobby.prani@gmail.com>
	<87y3wvlwhx.fsf@linaro.org>
From: Pranith Kumar <bobby.prani@gmail.com>
In-reply-to: <87y3wvlwhx.fsf@linaro.org>
Date: Fri, 24 Feb 2017 09:10:14 -0500
Message-ID: <87zihbaddl.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] mttcg/i386: Patch instruction using
 async_safe_* framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>


Hi Alex,

Alex Bennée writes:

> Pranith Kumar <bobby.prani@gmail.com> writes:
>
>> In mttcg, calling pause_all_vcpus() during execution from the
>> generated TBs causes a deadlock if some vCPU is waiting for exclusive
>> execution in start_exclusive(). Fix this by using the aync_safe_*
>> framework instead of pausing vcpus for patching instructions.
>>

<...>

>> diff --git a/hw/i386/kvmvapic.c b/hw/i386/kvmvapic.c
>> index 82a4955..11b0d49 100644
>> --- a/hw/i386/kvmvapic.c
>>  
>> -    resume_all_vcpus();
>> +    g_free(info);
>> +}
>> +
>> +static void patch_instruction(VAPICROMState *s, X86CPU *cpu, target_ulong ip)
>> +{
>> +    CPUState *cs = CPU(cpu);
>> +    VAPICHandlers *handlers;
>> +    struct PatchInfo *info;
>> +
>> +    if (smp_cpus == 1) {
>> +        handlers = &s->rom_state.up;
>> +    } else {
>> +        handlers = &s->rom_state.mp;
>> +    }
>> +
>> +    info  = g_new(struct PatchInfo, 1);
>> +    info->handler = handlers;
>> +    info->ip = ip;
>>  
>>      if (!kvm_enabled()) {
>> -        /* Both tb_lock and iothread_mutex will be reset when
>> -         *  longjmps back into the cpu_exec loop. */
>> -        tb_lock();
>> -        tb_gen_code(cs, current_pc, current_cs_base, current_flags, 1);
>> -        cpu_loop_exit_noexc(cs);
>> +        const run_on_cpu_func fn = do_patch_instruction;
>> +
>> +        async_safe_run_on_cpu(cs, fn, RUN_ON_CPU_HOST_PTR(info));
>> +        cs->exception_index = EXCP_INTERRUPT;
>> +        cpu_loop_exit(cs);
>>      }
>> +
>> +    pause_all_vcpus();
>> +
>> +    do_patch_instruction(cs, RUN_ON_CPU_HOST_PTR(info));
>> +
>> +    resume_all_vcpus();
>> +    g_free(info);
>
> I don't know if there is any benefit scheduling this as async work for
> KVM but I'll leave that up to Paolo to decide. From a TCG point of view
> I think its good:
>

We are scheduling this as async work only for non-KVM cases. For KVM, we use
go to the pause/resume path above and patch it there itself.

Thanks,
-- 
Pranith
