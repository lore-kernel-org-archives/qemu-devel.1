Received: from eggs.gnu.org ([209.51.188.92]:40680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gmtgd-0005IN-F3
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 00:05:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gmtTj-0006NK-C8
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 23:52:35 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:40283)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1gmtTc-0006Jq-24
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 23:52:28 -0500
Received: by mail-pf1-x444.google.com with SMTP id i12so4146273pfo.7
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 20:52:21 -0800 (PST)
References: <20190118140758.829-1-farosas@linux.ibm.com>
	<20190118140758.829-8-farosas@linux.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <1ffb003e-55a9-c845-be16-95f119ec41b3@ozlabs.ru>
Date: Fri, 25 Jan 2019 15:52:13 +1100
MIME-Version: 1.0
In-Reply-To: <20190118140758.829-8-farosas@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v3 7/7] target/ppc: support single
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
Cc: qemu-ppc@nongnu.org, philmd@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, david@gibson.dropbear.id.au, cohuck@redhat.com



On 19/01/2019 01:07, Fabiano Rosas wrote:
> The hardware singlestep mechanism in POWER works via a Trace Interrupt
> (0xd00) that happens after any instruction executes, whenever MSR_SE =
> 1 (PowerISA Section 6.5.15 - Trace Interrupt).
> 
> However, with kvm_hv, the Trace Interrupt happens inside the guest and
> KVM has no visibility of it. Therefore, when the gdbstub uses the
> KVM_SET_GUEST_DEBUG ioctl to enable singlestep, KVM simply ignores it.
> 
> This patch takes advantage of the Trace Interrupt to perform the step
> inside the guest, but uses a breakpoint at the Trace Interrupt handler
> to return control to KVM. The exit is treated by KVM as a regular
> breakpoint and it returns to the host (and QEMU eventually).
> 
> Before signalling GDB, QEMU sets the Next Instruction Pointer to the
> instruction following the one being stepped and restores the MSR,
> SRR0, SRR1 values from before the step, effectively skipping the
> interrupt handler execution and hiding the trace interrupt breakpoint
> from GDB.
> 
> This approach works with both of GDB's 'scheduler-locking' options
> (off, step).
> 
> Note:
> 
> - kvm_arch_set_singlestep happens after GDB asks for a single step,
>   while the vcpus are stopped.
> 
> - kvm_handle_singlestep executes after the step, during the handling
>   of the Emulation Assist Interrupt (breakpoint).


Good job! Few comments below.


> 
> Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
> ---
>  target/ppc/cpu.h |   5 ++
>  target/ppc/kvm.c | 180 +++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 178 insertions(+), 7 deletions(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 2185ef5e67..c7320c908e 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1157,6 +1157,11 @@ struct CPUPPCState {
>      uint32_t tm_vscr;
>      uint64_t tm_dscr;
>      uint64_t tm_tar;
> +
> +    /* Used for software single step */
> +    target_ulong sstep_msr;
> +    target_ulong sstep_srr0;
> +    target_ulong sstep_srr1;
>  };
>  
>  #define SET_FIT_PERIOD(a_, b_, c_, d_)          \
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index c27190d7fb..880597a4a6 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -1555,6 +1555,68 @@ void kvm_arch_remove_all_hw_breakpoints(void)
>      nb_hw_breakpoint = nb_hw_watchpoint = 0;
>  }
>  
> +void kvm_arch_set_singlestep(CPUState *cs, int enabled)
> +{
> +    PowerPCCPU *cpu = POWERPC_CPU(cs);
> +    CPUPPCState *env = &cpu->env;
> +    target_ulong trace_handler_addr;
> +    uint32_t insn;
> +
> +    if (enabled) {

if (!enabled) {
    return;
}

and reduce indent?


> +        cpu_synchronize_state(cs);
> +
> +        /*
> +         * Save the registers that will be affected by the single step
> +         * mechanism. These will be restored after the step at
> +         * kvm_handle_singlestep.
> +         */
> +        env->sstep_msr = env->msr;
> +        env->sstep_srr0 = env->spr[SPR_SRR0];
> +        env->sstep_srr1 = env->spr[SPR_SRR1];
> +
> +        cpu_memory_rw_debug(cs, env->nip, (uint8_t *)&insn, sizeof(insn), 0);
> +
> +        /*
> +         * rfid overwrites MSR with SRR1. Check if it has the SE bit
> +         * already set, meaning the guest is doing a single step
> +         * itself and set the SRR1_SE bit instead of MSR_SE to trigger
> +         * our own single step.
> +         */
> +        if (extract32(insn, 26, 6) == 19 && extract32(insn, 1, 10) == 18) {

We could define "rfid" like XL(19,18):

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/xmon/ppc-opc.c#n4388


> +            if ((env->spr[SPR_SRR1] >> MSR_SE) & 1) {
> +                env->sstep_msr |= (1ULL << MSR_SE);
> +            }
> +
> +            env->spr[SPR_SRR1] |= (1ULL << MSR_SE);
> +        } else {
> +            /*
> +             * MSR_SE = 1 will cause a Trace Interrupt in the guest
> +             * after the next instruction executes.
> +             */
> +            env->msr |= (1ULL << MSR_SE);
> +        }
> +
> +        /*
> +         * We set a breakpoint at the interrupt handler address so
> +         * that the singlestep will be seen by KVM (this is treated by
> +         * KVM like an ordinary breakpoint) and control is returned to
> +         * QEMU.
> +         */
> +        trace_handler_addr = ppc_get_trace_int_handler_addr(cs);
> +
> +        if (env->nip == trace_handler_addr) {
> +            /*
> +             * We are trying to step over the interrupt handler
> +             * address itself; move the breakpoint to the next
> +             * instruction.
> +             */
> +            trace_handler_addr += 4;
> +        }
> +
> +        kvm_insert_breakpoint(cs, trace_handler_addr, 4, GDB_BREAKPOINT_SW);
> +    }
> +}
> +
>  void kvm_arch_update_guest_debug(CPUState *cs, struct kvm_guest_debug *dbg)
>  {
>      int n;
> @@ -1594,6 +1656,93 @@ void kvm_arch_update_guest_debug(CPUState *cs, struct kvm_guest_debug *dbg)
>      }
>  }
>  
> +/* Revert any side-effects caused during single step */
> +static void restore_singlestep_env(CPUState *cs)
> +{
> +    PowerPCCPU *cpu = POWERPC_CPU(cs);
> +    CPUPPCState *env = &cpu->env;
> +    uint32_t insn;
> +    int reg;
> +    int spr;
> +    int opcode;
> +
> +    cpu_memory_rw_debug(cs, env->spr[SPR_SRR0] - 4, (uint8_t *)&insn,
> +                        sizeof(insn), 0);
> +
> +    env->spr[SPR_SRR0] = env->sstep_srr0;
> +    env->spr[SPR_SRR1] = env->sstep_srr1;
> +
> +    if (extract32(insn, 26, 6) == 31) {

if (extract32(insn, 26, 6) != 31) {
    return;
}

and minus one level of indent?

Also we could introduce get_op()/get_xop() and nice op definitions as in
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/kvm/book3s_emulate.c#n258


> +        opcode = extract32(insn, 1, 10);
> +        reg = extract32(insn, 21, 5);
> +
> +        switch (opcode) {
> +        case 467:
> +            /*
> +             * mtspr: the guest altered the SRR, so do not use the
> +             *        pre-step value.
> +             */
> +            spr = ((insn >> 16) & 0x1f) | ((insn >> 6) & 0x3e0);


spr = SPR(insn); ?


> +            if (spr == SPR_SRR0 || spr == SPR_SRR1) {
> +                env->spr[spr] = env->gpr[reg];
> +            }
> +            break;
> +        case 83:
> +            /*
> +             * msfmsr: clear MSR_SE bit to avoid the guest knowing

s/msfmsr/mfmsr/


> +             *         that it is being single-stepped.
> +             */
> +            env->gpr[reg] &= ~(1ULL << MSR_SE);
> +            break;
> +        }
> +    }
> +}
> +
> +static int kvm_handle_singlestep(CPUState *cs,
> +                                 struct kvm_debug_exit_arch *arch_info)


You only need address from arch_info, pass just that.


> +{
> +    PowerPCCPU *cpu = POWERPC_CPU(cs);
> +    CPUPPCState *env = &cpu->env;
> +    target_ulong trace_handler_addr;
> +
> +    if (kvm_has_guestdbg_singlestep()) {
> +        return 1;
> +    }
> +
> +    cpu_synchronize_state(cs);
> +    trace_handler_addr = ppc_get_trace_int_handler_addr(cs);
> +
> +    if (arch_info->address == trace_handler_addr) {
> +        kvm_remove_breakpoint(cs, trace_handler_addr, 4, GDB_BREAKPOINT_SW);
> +
> +        if (env->sstep_msr & (1ULL << MSR_SE)) {
> +            /*
> +             * The guest expects the last instruction to have caused a
> +             * single step, go back into the interrupt handler.
> +             */
> +            return 1;
> +        }
> +
> +        env->nip = env->spr[SPR_SRR0];
> +        /* Bits 33-36, 43-47 are set by the interrupt */
> +        env->msr = env->spr[SPR_SRR1] & ~(1ULL << MSR_SE |
> +                                          PPC_BITMASK(33, 36) |
> +                                          PPC_BITMASK(43, 47));
> +        restore_singlestep_env(cs);
> +
> +    } else if (arch_info->address == trace_handler_addr + 4) {
> +        /*
> +         * A step at trace_handler_addr would interfere with the
> +         * singlestep mechanism itself, so we have previously
> +         * displaced the breakpoint to the next instruction.
> +         */
> +        kvm_remove_breakpoint(cs, trace_handler_addr + 4, 4, GDB_BREAKPOINT_SW);
> +        restore_singlestep_env(cs);
> +    }
> +
> +    return 1;
> +}
> +
>  static int kvm_handle_hw_breakpoint(CPUState *cs,
>                                      struct kvm_debug_exit_arch *arch_info)
>  {
> @@ -1621,13 +1770,30 @@ static int kvm_handle_hw_breakpoint(CPUState *cs,
>      return handle;
>  }
>  
> -static int kvm_handle_singlestep(void)
> +static int kvm_handle_sw_breakpoint(CPUState *cs,
> +                                    struct kvm_debug_exit_arch *arch_info)
>  {
> -    return 1;
> -}
> +    target_ulong trace_handler_addr;
>  
> -static int kvm_handle_sw_breakpoint(void)
> -{
> +    if (kvm_has_guestdbg_singlestep()) {
> +        return 1;
> +    }
> +
> +    cpu_synchronize_state(cs);
> +    trace_handler_addr = ppc_get_trace_int_handler_addr(cs);
> +
> +    if (arch_info->address == trace_handler_addr) {
> +        CPU_FOREACH(cs) {
> +            if (cs->singlestep_enabled) {
> +                /*
> +                 * We hit this breakpoint while another cpu is doing a
> +                 * software single step. Go back into the guest to
> +                 * give chance for the single step to finish.
> +                 */
> +                return 0;
> +            }
> +        }
> +    }
>      return 1;
>  }
>  
> @@ -1638,7 +1804,7 @@ static int kvm_handle_debug(PowerPCCPU *cpu, struct kvm_run *run)
>      struct kvm_debug_exit_arch *arch_info = &run->debug.arch;
>  
>      if (cs->singlestep_enabled) {
> -        return kvm_handle_singlestep();
> +        return kvm_handle_singlestep(cs, arch_info);
>      }
>  
>      if (arch_info->status) {
> @@ -1646,7 +1812,7 @@ static int kvm_handle_debug(PowerPCCPU *cpu, struct kvm_run *run)
>      }
>  
>      if (kvm_find_sw_breakpoint(cs, arch_info->address)) {
> -        return kvm_handle_sw_breakpoint();
> +        return kvm_handle_sw_breakpoint(cs, arch_info);
>      }
>  
>      /*
> 

-- 
Alexey
