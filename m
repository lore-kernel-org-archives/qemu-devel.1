Received: from eggs.gnu.org ([209.51.188.92]:49756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gjdFK-0005cN-Dl
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 23:56:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gjdFH-0006e0-BW
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 23:56:09 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:40741)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1gjdFD-0006Wh-T5
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 23:56:05 -0500
Received: by mail-pl1-x644.google.com with SMTP id u18so2385674plq.7
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 20:56:01 -0800 (PST)
References: <20181119213739.773-1-farosas@linux.ibm.com>
	<20181119213739.773-2-farosas@linux.ibm.com>
	<aa441205-a985-5cdc-ee7e-c843777f8f53@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <b6f679bc-37cb-8b4f-d530-9dd2639f84c1@ozlabs.ru>
Date: Wed, 16 Jan 2019 15:55:55 +1100
MIME-Version: 1.0
In-Reply-To: <aa441205-a985-5cdc-ee7e-c843777f8f53@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] target/ppc: support single
 stepping with KVM HV
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fabiano Rosas <farosas@linux.ibm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, david@gibson.dropbear.id.au, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>

Fabiano,

Are you planning on reposting this any time soon? I am interested in the
feature. Thanks.


On 20/11/2018 23:40, Philippe Mathieu-Daudé wrote:
> Hi Fabiano,
> 
> You should Cc the relevant maintainers to get more attention.
> You can check this wiki page:
> https://wiki.qemu.org/Contribute/SubmitAPatch#CC_the_relevant_maintainer
> 
> $ ./scripts/get_maintainer.pl -f accel/kvm/kvm-all.c
> include/sysemu/kvm.h target/*/kvm.c
> Paolo Bonzini <pbonzini@redhat.com> (supporter:Overall)
> Peter Maydell <peter.maydell@linaro.org> (maintainer:ARM)
> Marcelo Tosatti <mtosatti@redhat.com> (supporter:X86)
> Richard Henderson <rth@twiddle.net> (maintainer:X86)
> Eduardo Habkost <ehabkost@redhat.com> (maintainer:X86)
> James Hogan <jhogan@kernel.org> (maintainer:MIPS)
> Stefan Markovic <smarkovic@wavecomp.com> (reviewer:MIPS)
> Aurelien Jarno <aurelien@aurel32.net> (maintainer:MIPS)
> Aleksandar Markovic <amarkovic@wavecomp.com> (maintainer:MIPS)
> David Gibson <david@gibson.dropbear.id.au> (maintainer:PPC)
> Christian Borntraeger <borntraeger@de.ibm.com> (maintainer:S390)
> Cornelia Huck <cohuck@redhat.com> (maintainer:S390)
> David Hildenbrand <david@redhat.com> (maintainer:S390)
> kvm@vger.kernel.org (open list:Overall)
> qemu-devel@nongnu.org (open list:All patches CC here)
> qemu-arm@nongnu.org (open list:ARM)
> qemu-ppc@nongnu.org (open list:PowerPC)
> qemu-s390x@nongnu.org (open list:S390)
> 
> On 19/11/18 22:37, Fabiano Rosas wrote:
>> The hardware singlestep mechanism in POWER works via a Trace Interrupt
>> (0xd00) that happens after any instruction executes, whenever MSR_SE =
>> 1 (PowerISA Section 6.5.15 - Trace Interrupt).
>>
>> However, with kvm_hv, the Trace Interrupt happens inside the guest and
>> KVM has no visibility of it. Therefore, when the gdbstub uses the
>> KVM_SET_GUEST_DEBUG ioctl to enable singlestep, KVM simply ignores it.
>>
>> This patch takes advantage of the Trace Interrupt to perform the step
>> inside the guest, but uses a breakpoint at the Trace Interrupt handler
>> to return control to KVM. The exit is treated by KVM as a regular
>> breakpoint and it returns to the host (and QEMU eventually).
>>
>> Before signalling GDB, QEMU sets the Next Instruction Pointer to the
>> instruction following the one being stepped, effectively skipping the
>> interrupt handler execution and hiding the trace interrupt breakpoint
>> from GDB.
>>
>> This approach works with both of GDB's 'scheduler-locking' options
>> (off, step).
>>
>> Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
>> ---
>>   accel/kvm/kvm-all.c  | 10 +++++++
>>   exec.c               |  1 +
>>   include/sysemu/kvm.h |  4 +++
>>   target/arm/kvm.c     |  4 +++
>>   target/i386/kvm.c    |  4 +++
>>   target/ppc/kvm.c     | 65 +++++++++++++++++++++++++++++++++++++++++++-
>>   target/s390x/kvm.c   |  4 +++
>>   7 files changed, 91 insertions(+), 1 deletion(-)
>>
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index 4880a05399..4fb7199a15 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -2313,6 +2313,11 @@ int kvm_update_guest_debug(CPUState *cpu,
>> unsigned long reinject_trap)
>>       return data.err;
>>   }
>>   +void kvm_set_singlestep(CPUState *cs, int enabled)
>> +{
>> +    kvm_arch_set_singlestep(cs, enabled);
> 
> This won't link on MIPS, you miss the stub there.
> 
>> +}
>> +
>>   int kvm_insert_breakpoint(CPUState *cpu, target_ulong addr,
>>                             target_ulong len, int type)
>>   {
>> @@ -2439,6 +2444,11 @@ int kvm_remove_breakpoint(CPUState *cpu,
>> target_ulong addr,
>>   void kvm_remove_all_breakpoints(CPUState *cpu)
>>   {
>>   }
>> +
>> +void kvm_set_singlestep(CPUState *cs, int enabled)
>> +{
>> +}
>> +
>>   #endif /* !KVM_CAP_SET_GUEST_DEBUG */
>>     static int kvm_set_signal_mask(CPUState *cpu, const sigset_t *sigset)
>> diff --git a/exec.c b/exec.c
>> index bb6170dbff..55614822c3 100644
>> --- a/exec.c
>> +++ b/exec.c
>> @@ -1233,6 +1233,7 @@ void cpu_single_step(CPUState *cpu, int enabled)
>>       if (cpu->singlestep_enabled != enabled) {
>>           cpu->singlestep_enabled = enabled;
>>           if (kvm_enabled()) {
>> +            kvm_set_singlestep(cpu, enabled);
>>               kvm_update_guest_debug(cpu, 0);
>>           } else {
>>               /* must flush all the translated code to avoid
>> inconsistencies */
>> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
>> index 97d8d9d0d5..a01a8d58dd 100644
>> --- a/include/sysemu/kvm.h
>> +++ b/include/sysemu/kvm.h
>> @@ -259,6 +259,8 @@ int kvm_remove_breakpoint(CPUState *cpu,
>> target_ulong addr,
>>   void kvm_remove_all_breakpoints(CPUState *cpu);
>>   int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap);
>>   +void kvm_set_singlestep(CPUState *cpu, int enabled);
>> +
>>   int kvm_on_sigbus_vcpu(CPUState *cpu, int code, void *addr);
>>   int kvm_on_sigbus(int code, void *addr);
>>   @@ -431,6 +433,8 @@ void kvm_arch_remove_all_hw_breakpoints(void);
>>     void kvm_arch_update_guest_debug(CPUState *cpu, struct
>> kvm_guest_debug *dbg);
>>   +void kvm_arch_set_singlestep(CPUState *cpu, int enabled);
>> +
>>   bool kvm_arch_stop_on_emulation_error(CPUState *cpu);
>>     int kvm_check_extension(KVMState *s, unsigned int extension);
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index 44dd0ce6ce..dd8e43ab7e 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
>> @@ -670,6 +670,10 @@ int kvm_arch_process_async_events(CPUState *cs)
>>       return 0;
>>   }
>>   +void kvm_arch_set_singlestep(CPUState *cs, int enabled)
>> +{
>> +}
>> +
>>   /* The #ifdef protections are until 32bit headers are imported and can
>>    * be removed once both 32 and 64 bit reach feature parity.
>>    */
>> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
>> index f524e7d929..ba56f2ee1f 100644
>> --- a/target/i386/kvm.c
>> +++ b/target/i386/kvm.c
>> @@ -3521,6 +3521,10 @@ static int kvm_handle_debug(X86CPU *cpu,
>>       return ret;
>>   }
>>   +void kvm_arch_set_singlestep(CPUState *cs, int enabled)
>> +{
>> +}
>> +
>>   void kvm_arch_update_guest_debug(CPUState *cpu, struct
>> kvm_guest_debug *dbg)
>>   {
>>       const uint8_t type_code[] = {
>> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
>> index f81327d6cd..3af5e91997 100644
>> --- a/target/ppc/kvm.c
>> +++ b/target/ppc/kvm.c
>> @@ -94,6 +94,7 @@ static int cap_ppc_safe_indirect_branch;
>>   static int cap_ppc_nested_kvm_hv;
>>     static uint32_t debug_inst_opcode;
>> +static target_ulong trace_handler_addr;
>>     /* XXX We have a race condition where we actually have a level
>> triggered
>>    *     interrupt, but the infrastructure can't expose that yet, so
>> the guest
>> @@ -509,6 +510,9 @@ int kvm_arch_init_vcpu(CPUState *cs)
>>       kvm_get_one_reg(cs, KVM_REG_PPC_DEBUG_INST, &debug_inst_opcode);
>>       kvmppc_hw_debug_points_init(cenv);
>>   +    trace_handler_addr = (cenv->excp_vectors[POWERPC_EXCP_TRACE] |
>> +                          0xc000000000004000ull);
> 
> Can you add a definition for this magic value?
> 
>> +
>>       return ret;
>>   }
>>   @@ -1551,6 +1555,28 @@ void kvm_arch_remove_all_hw_breakpoints(void)
>>       nb_hw_breakpoint = nb_hw_watchpoint = 0;
>>   }
>>   +void kvm_arch_set_singlestep(CPUState *cs, int enabled)
>> +{
>> +    PowerPCCPU *cpu = POWERPC_CPU(cs);
>> +    CPUPPCState *env = &cpu->env;
>> +
>> +    if (kvmppc_is_pr(kvm_state)) {
>> +            return;
>> +    }
>> +
>> +    if (enabled) {
>> +        /* MSR_SE = 1 will cause a Trace Interrupt in the guest after
>> +         * the next instruction executes. */
>> +        env->msr |= (1ULL << MSR_SE);
>> +
>> +        /* We set a breakpoint at the interrupt handler address so
>> +         * that the singlestep will be seen by KVM (this is treated by
>> +         * KVM like an ordinary breakpoint) and control is returned to
>> +         * QEMU. */
>> +        kvm_insert_breakpoint(cs, trace_handler_addr, 4,
>> GDB_BREAKPOINT_SW);
>> +    }
>> +}
>> +
>>   void kvm_arch_update_guest_debug(CPUState *cs, struct
>> kvm_guest_debug *dbg)
>>   {
>>       int n;
>> @@ -1590,6 +1616,43 @@ void kvm_arch_update_guest_debug(CPUState *cs,
>> struct kvm_guest_debug *dbg)
>>       }
>>   }
>>   +static int kvm_handle_singlestep(CPUState *cs,
>> +                                 struct kvm_debug_exit_arch *arch_info)
>> +{
>> +    PowerPCCPU *cpu = POWERPC_CPU(cs);
>> +    CPUPPCState *env = &cpu->env;
>> +    target_ulong msr = env->msr;
>> +    uint32_t insn;
>> +    int ret = 1;
>> +    int reg;
>> +
>> +    if (kvmppc_is_pr(kvm_state)) {
>> +        return ret;
>> +    }
>> +
>> +    if (arch_info->address == trace_handler_addr) {
>> +        cpu_synchronize_state(cs);
>> +        kvm_remove_breakpoint(cs, trace_handler_addr, 4,
>> GDB_BREAKPOINT_SW);
>> +
>> +        cpu_memory_rw_debug(cs, env->spr[SPR_SRR0] - 4, (uint8_t
>> *)&insn,
>> +                            sizeof(insn), 0);
>> +
>> +        /* If the last instruction was a mfmsr, make sure that the
>> +         * MSR_SE bit is not set to avoid the guest kernel knowing
>> +         * that it is being single-stepped */
>> +        if (((insn >> 26) & 0x3f) == 31 && ((insn >> 1) & 0x3ff) ==
>> 83) {
> 
> You can use the extract32() function to extract bits, it is easier to
> review:
> 
>     if (extract32(insn, 26, 6) == 31 && extract32(insn, 1, 10) == 83) {
> 
>> +            reg = (insn >> 21) & 0x1f;
> 
> Ditto.
> 
> Regards,
> 
> Phil.
> 
>> +            env->gpr[reg] &= ~(1ULL << MSR_SE);
>> +        }
>> +
>> +        env->nip = env->spr[SPR_SRR0];
>> +        env->msr = msr &= ~(1ULL << MSR_SE);
>> +        cpu_synchronize_state(cs);
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>>   static int kvm_handle_debug(PowerPCCPU *cpu, struct kvm_run *run)
>>   {
>>       CPUState *cs = CPU(cpu);
>> @@ -1600,7 +1663,7 @@ static int kvm_handle_debug(PowerPCCPU *cpu,
>> struct kvm_run *run)
>>       int flag = 0;
>>         if (cs->singlestep_enabled) {
>> -        handle = 1;
>> +        handle = kvm_handle_singlestep(cs, arch_info);
>>       } else if (arch_info->status) {
>>           if (nb_hw_breakpoint + nb_hw_watchpoint > 0) {
>>               if (arch_info->status & KVMPPC_DEBUG_BREAKPOINT) {
>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>> index 2ebf26adfe..4bde183458 100644
>> --- a/target/s390x/kvm.c
>> +++ b/target/s390x/kvm.c
>> @@ -975,6 +975,10 @@ void kvm_arch_remove_all_hw_breakpoints(void)
>>       hw_breakpoints = NULL;
>>   }
>>   +void kvm_arch_set_singlestep(CPUState *cs, int enabled)
>> +{
>> +}
>> +
>>   void kvm_arch_update_guest_debug(CPUState *cpu, struct
>> kvm_guest_debug *dbg)
>>   {
>>       int i;
>>
> 

-- 
Alexey
