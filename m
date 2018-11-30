Received: from eggs.gnu.org ([2001:4830:134:3::10]:35475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gSpgQ-00019a-Rh
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 15:46:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gSpgK-0002m1-UL
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 15:46:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
	id 1gSpgJ-0002Xz-HG
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 15:46:36 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wAUKgFPC079194
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 15:46:32 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2p3attvdae-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 15:46:32 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.ibm.com>;
	Fri, 30 Nov 2018 20:46:31 -0000
From: Fabiano Rosas <farosas@linux.ibm.com>
In-Reply-To: <20181126074100.GJ2251@umbus.fritz.box>
References: <20181121181347.24035-1-farosas@linux.ibm.com>
	<20181121181347.24035-4-farosas@linux.ibm.com>
	<20181126074100.GJ2251@umbus.fritz.box>
Date: Fri, 30 Nov 2018 18:46:21 -0200
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87h8fymgyq.fsf@linux.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 3/3] target/ppc: support single
 stepping with KVM HV
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, James Hogan <jhogan@kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

David Gibson <david@gibson.dropbear.id.au> writes:

>> --- a/target/ppc/kvm.c
>> +++ b/target/ppc/kvm.c
>> @@ -94,6 +94,7 @@ static int cap_ppc_safe_indirect_branch;
>>  static int cap_ppc_nested_kvm_hv;
>>  
>>  static uint32_t debug_inst_opcode;
>> +static target_ulong trace_handler_addr;
>>  
>>  /* XXX We have a race condition where we actually have a level triggered
>>   *     interrupt, but the infrastructure can't expose that yet, so the guest
>> @@ -509,6 +510,9 @@ int kvm_arch_init_vcpu(CPUState *cs)
>>      kvm_get_one_reg(cs, KVM_REG_PPC_DEBUG_INST, &debug_inst_opcode);
>>      kvmppc_hw_debug_points_init(cenv);
>>  
>> +    trace_handler_addr = (cenv->excp_vectors[POWERPC_EXCP_TRACE] |
>> +                          AIL_C000_0000_0000_4000_OFFSET);
>
> Effectively caching this as a global variable is pretty horrible.  A
> function to make the above calculation when you need it would be
> better.
>
> Also, won't the calculation above be wrong if the guest is using the
> low AIL value?

Yes. As you suggested, I'll change this to calculate the offset based on AIL.

>>  void kvm_arch_set_singlestep(CPUState *cs, int enabled)
>>  {
>> +    PowerPCCPU *cpu = POWERPC_CPU(cs);
>> +    CPUPPCState *env = &cpu->env;
>> +
>> +    if (kvmppc_is_pr(kvm_state)) {
>
> Explicitly testing for KVM PR is generally wrong (except as a
> fallback).  Instead you should add a capability flag to KVM which you
> use to test the feature's presence in qemu.  That capability can then
> be set in HV, but not PR.

My apologies, I did read the notice on the code about it. I was trying
to keep things simple for this RFC and forgot to mention that in the
cover letter.

>> +    if (arch_info->address == trace_handler_addr) {
>> +        cpu_synchronize_state(cs);
>> +        kvm_remove_breakpoint(cs, trace_handler_addr, 4, GDB_BREAKPOINT_SW);
>> +
>> +        cpu_memory_rw_debug(cs, env->spr[SPR_SRR0] - 4, (uint8_t *)&insn,
>> +                            sizeof(insn), 0);
>> +
>> +        /* If the last instruction was a mfmsr, make sure that the
>> +         * MSR_SE bit is not set to avoid the guest kernel knowing
>> +         * that it is being single-stepped */
>> +        if (extract32(insn, 26, 6) == 31 && extract32(insn, 1, 10) == 83) {
>> +            reg = extract32(insn, 21, 5);
>> +            env->gpr[reg] &= ~(1ULL << MSR_SE);
>> +        }
>
> Hm.  What happens if both qemu and the guest itself attempt to single
> step at the same time?  How do you distinguish between the cases?

There is currently no distinction being made. Since MSR_SE is only set
for the duration of the step (see my answer below) this mostly just
works and it is possible to single step inside/outside the guest while
the control changes from one debugger to the other as expected. However
there is a race as follows:

If the vcpu being stepped is preempted right after vm enter, with the
breakpoint at 0xd00 already in place *and* the other debugger starts
doing a step, it will cause a vm exit when it shouldn't:

    outside guest                  inside guest
set breakpoint at 0xd00     |
msr_se = 1                  |
vm enter                    |
                            |  msr_se = 1
                            |  exec next instruction
                            |  trace interrupt
                            |  jump to 0xd00
                            |  --- wrong from now on ---
                            |  emulation assist interrupt
                            |  vm exit

One way to avoid this race is by using GDB's `scheduler-locking step`
option which effectively negates the issue by running only the vcpu
being stepped.

Regardless of that workaround, I am exploring the idea of sending the
cpu back into the guest if we happen to break at the trace interrupt
handler while there is no cpu being stepped by QEMU
(cs->singlestep_enabled). That way, a step inside the guest would never
happen before the outside step has finished.

>
>> +
>> +        env->nip = env->spr[SPR_SRR0];
>> +        env->msr = msr &= ~(1ULL << MSR_SE);
>
> You clear SE after tracing one instruction; is that intentional?

Yes, both the kernel and KVM PR do the same:

from arch/powerpc/kernel/traps.c
void single_step_exception(struct pt_regs *regs)
{
        enum ctx_state prev_state = exception_enter();

->      clear_single_step(regs);
        ...
}

from arch/powerpc/kvm/book3s_pr.c
static int kvmppc_vcpu_run_pr(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
{
        ...
        ret = __kvmppc_vcpu_run(kvm_run, vcpu);

->      kvmppc_clear_debug(vcpu);
        ...
}

>
>> +        cpu_synchronize_state(cs);
>
> You're effectively aborting the entry to the single step exception
> vector; don't you need to set MSR to SRR1, not to the current MSR
> value which will have been modified for the singlestep exception entry?

I'm using the old MSR value (before synchronizing) so the effect is the same:

(gdb) p/x $msr
$2 = 0x8000000002803033
(gdb) si
1892            LOAD_REG_ADDR(r11, replay_interrupt_return)
(gdb) p/x $msr
$3 = 0x8000000002803033

Using SRR1 would also work but it would require clearing the bits set by
the interrupt (33:36, 44:47):

(gdb) p/x env->spr[0x01b]
$1 = 0x8000000042803433

I could do the latter, if you prefer.


Thank you for your attention.
Cheers.
