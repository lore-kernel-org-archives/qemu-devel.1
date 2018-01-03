Received: from eggs.gnu.org ([2001:4830:134:3::10]:43396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eWs0P-0005LS-4T
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 17:59:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eWs0L-0000ht-NR
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 17:59:29 -0500
Received: from mail-oi0-x22c.google.com ([2607:f8b0:4003:c06::22c]:37009)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eWs0L-0000hG-Ex
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 17:59:25 -0500
Received: by mail-oi0-x22c.google.com with SMTP id y75so1971560oie.4
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 14:59:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <7b4c9965-d0c4-1b10-aa6d-553a3923d598@linaro.org>
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<1514940265-18093-6-git-send-email-mjc@sifive.com>
	<7b4c9965-d0c4-1b10-aa6d-553a3923d598@linaro.org>
From: Michael Clark <mjc@sifive.com>
Date: Thu, 4 Jan 2018 11:59:23 +1300
Message-ID: <CAHNT7NsOYOiK1gJ68GfRW+WDM5OF0JEk_YX+dMzYo25s3gno-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 05/21] RISC-V CPU Helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On Wed, Jan 3, 2018 at 8:12 PM, Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 01/02/2018 04:44 PM, Michael Clark wrote:
> > +    target_ulong mode = env->priv;
> > +    if (access_type != MMU_INST_FETCH) {
> > +        if (get_field(env->mstatus, MSTATUS_MPRV)) {
> > +            mode = get_field(env->mstatus, MSTATUS_MPP);
> > +        }
> > +    }
> > +    if (env->priv_ver >= PRIV_VERSION_1_10_0) {
> > +        if (get_field(env->satp, SATP_MODE) == VM_1_09_MBARE) {
> > +            mode = PRV_M;
> > +        }
> > +    } else {
> > +        if (get_field(env->mstatus, MSTATUS_VM) == VM_1_10_MBARE) {
> > +            mode = PRV_M;
> > +        }
> > +    }
>
> This is replicating cpu_mmu_index.
> Therefore you should be relying on mmu_idx.
>
> > +    /* check to make sure that mmu_idx and mode that we get matches */
> > +    if (unlikely(mode != mmu_idx)) {
> > +        fprintf(stderr, "MODE: mmu_idx mismatch\n");
> > +        exit(1);
> > +    }
>
> As in the opposite of this.


OK. cpu_mmu_index has already translated the mode into mmu_idx for us so we
can eliminate the redundant mode fetch, check and error message.

Essentially we should trust mmu_idx returned from cpu_mmu_index, so this
statement should never trigger.

Will include in the next spin.


> > +
> > +    if (mode == PRV_M) {
> > +        target_ulong msb_mask = /*0x7FFFFFFFFFFFFFFF; */
> > +            (((target_ulong)2) << (TARGET_LONG_BITS - 1)) - 1;
> > +        *physical = address & msb_mask;
>
> Or perhaps extract64(address, 0, TARGET_LONG_BITS - 1)?
>
> > +    if (env->priv_ver >= PRIV_VERSION_1_10_0) {
> > +        base = get_field(env->satp, SATP_PPN) << PGSHIFT;
> > +        sum = get_field(env->mstatus, MSTATUS_SUM);
> > +        vm = get_field(env->satp, SATP_MODE);
> > +        switch (vm) {
> > +        case VM_1_10_SV32:
> > +          levels = 2; ptidxbits = 10; ptesize = 4; break;
> > +        case VM_1_10_SV39:
> > +          levels = 3; ptidxbits = 9; ptesize = 8; break;
> > +        case VM_1_10_SV48:
> > +          levels = 4; ptidxbits = 9; ptesize = 8; break;
> > +        case VM_1_10_SV57:
> > +          levels = 5; ptidxbits = 9; ptesize = 8; break;
> > +        default:
> > +          printf("unsupported SATP_MODE value\n");
> > +          exit(1);
>
> Just qemu_log_mask with LOG_UNIMP or LOG_GUEST_ERROR, and then return
> TRANSLATE_FAIL.  Printing to stdout and exiting isn't kosher.  Lots more
> occurrences within this file.


Understand.  I had aleady converted several printfs to error_report.

I wasn't sure which logging API to use. There are also quite a lot of uses
of grep -r error_report target.

I'll grep -r for printf and change to qemu_log_mask with appropriate level.

I see exit(1) called in quite a few of the other ports too. I was wondering
at the time if there is a canonical error_abort API?

Will try to improve things in the next spin.

> +static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
> > +                                MMUAccessType access_type)
> > +{
> > +    CPUState *cs = CPU(riscv_env_get_cpu(env));
> > +    int page_fault_exceptions =
> > +        (env->priv_ver >= PRIV_VERSION_1_10_0) &&
> > +        get_field(env->satp, SATP_MODE) != VM_1_10_MBARE;
> > +    int exception = 0;
> > +    if (access_type == MMU_INST_FETCH) { /* inst access */
> > +        exception = page_fault_exceptions ?
> > +            RISCV_EXCP_INST_PAGE_FAULT : RISCV_EXCP_INST_ACCESS_FAULT;
> > +        env->badaddr = address;
> > +    } else if (access_type == MMU_DATA_STORE) { /* store access */
> > +        exception = page_fault_exceptions ?
> > +            RISCV_EXCP_STORE_PAGE_FAULT : RISCV_EXCP_STORE_AMO_ACCESS_
> FAULT;
> > +        env->badaddr = address;
> > +    } else if (access_type == MMU_DATA_LOAD) { /* load access */
> > +        exception = page_fault_exceptions ?
> > +            RISCV_EXCP_LOAD_PAGE_FAULT : RISCV_EXCP_LOAD_ACCESS_FAULT;
> > +        env->badaddr = address;
> > +    } else {
> > +        fprintf(stderr, "FAIL: invalid access_type\n");
> > +        exit(1);
>
> Switch with a default: g_assert_not_reached(), since access_type is not
> controlled by the guest.
>
> > +void riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
> > +                                   MMUAccessType access_type, int
> mmu_idx,
> > +                                   uintptr_t retaddr)
> > +{
> > +    RISCVCPU *cpu = RISCV_CPU(cs);
> > +    CPURISCVState *env = &cpu->env;
> > +    if (access_type == MMU_INST_FETCH) {
> > +        fprintf(stderr, "unaligned inst fetch not handled here. should
> not "
> > +                "trigger\n");
> > +        exit(1);
>
> No exit.  Do something logical.


Got it. Assertion.


> > +    } else if (access_type == MMU_DATA_STORE) {
> > +        cs->exception_index = RISCV_EXCP_STORE_AMO_ADDR_MIS;
> > +        env->badaddr = addr;
>
> Why does STORE imply AMO?  Why can't a normal store trigger an unaligned
> trap?


It's STORE or AMO. Here are the exception causes from the RISC-V Privileged
ISA Specification:

# Machine Cause Register faults (mcause), interrupt bit clear
cause   misaligned_fetch     0       "Instruction address misaligned"
cause   fault_fetch          1       "Instruction access fault"
cause   illegal_instruction  2       "Illegal instruction"
cause   breakpoint           3       "Breakpoint"
cause   misaligned_load      4       "Load address misaligned"
cause   fault_load           5       "Load access fault"
cause   misaligned_store     6       "Store/AMO address misaligned"
cause   fault_store          7       "Store/AMO access fault"
cause   user_ecall           8       "Environment call from U-mode"
cause   supervisor_ecall     9       "Environment call from S-mode"
cause   hypervisor_ecall     10      "Environment call from H-mode"
cause   machine_ecall        11      "Environment call from M-mode"
cause   exec_page_fault      12      "Instruction page fault"
cause   load_page_fault      13      "Load page fault"
cause   store_page_fault     15      "Store/AMO page fault"



> > +        fprintf(stderr, "Invalid MMUAccessType\n");
> > +        exit(1);
>
> I'll stop pointing these out, but there need to be zero instances of exit
> within the backend.


I totally agree. Inherited. However it seems there are lots of calls to
exit(1) in many other targets. Not that that is an excuse.


> > +void riscv_cpu_do_interrupt(CPUState *cs)
> > +{
> > +#if !defined(CONFIG_USER_ONLY)
> > +
> > +    RISCVCPU *cpu = RISCV_CPU(cs);
> > +    CPURISCVState *env = &cpu->env;
> > +
> > +    #ifdef RISCV_DEBUG_INTERRUPT
> > +    if (cs->exception_index & 0x70000000) {
> > +        fprintf(stderr, "core   0: exception trap_%s, epc 0x"
> TARGET_FMT_lx "\n"
> > +                , riscv_interrupt_names[cs->exception_index &
> 0x0fffffff],
> > +                env->pc);
> > +    } else {
> > +        fprintf(stderr, "core   0: exception trap_%s, epc 0x"
> TARGET_FMT_lx "\n"
> > +                , riscv_excp_names[cs->exception_index], env->pc);
> > +    }
> > +    #endif
> > +
> > +    if (cs->exception_index == RISCV_EXCP_BREAKPOINT) {
> > +        fprintf(stderr, "debug mode not implemented\n");
> > +    }
> > +
> > +    /* skip dcsr cause check */
> > +
> > +    target_ulong fixed_cause = 0;
> > +    if (cs->exception_index & (0x70000000)) {
> > +        /* hacky for now. the MSB (bit 63) indicates interrupt but
> cs->exception
> > +           index is only 32 bits wide */
> > +        fixed_cause = cs->exception_index & 0x0FFFFFFF;
> > +        fixed_cause |= ((target_ulong)1) << (TARGET_LONG_BITS - 1);
> > +    } else {
> > +        /* fixup User ECALL -> correct priv ECALL */
> > +        if (cs->exception_index == RISCV_EXCP_U_ECALL) {
> > +            switch (env->priv) {
> > +            case PRV_U:
> > +                fixed_cause = RISCV_EXCP_U_ECALL;
> > +                break;
> > +            case PRV_S:
> > +                fixed_cause = RISCV_EXCP_S_ECALL;
> > +                break;
> > +            case PRV_H:
> > +                fixed_cause = RISCV_EXCP_H_ECALL;
> > +                break;
> > +            case PRV_M:
> > +                fixed_cause = RISCV_EXCP_M_ECALL;
> > +                break;
> > +            }
> > +        } else {
> > +            fixed_cause = cs->exception_index;
> > +        }
> > +    }
> > +
> > +    target_ulong backup_epc = env->pc;
> > +
> > +    target_ulong bit = fixed_cause;
> > +    target_ulong deleg = env->medeleg;
> > +
> > +    int hasbadaddr =
> > +        (fixed_cause == RISCV_EXCP_INST_ADDR_MIS) ||
> > +        (fixed_cause == RISCV_EXCP_INST_ACCESS_FAULT) ||
> > +        (fixed_cause == RISCV_EXCP_LOAD_ADDR_MIS) ||
> > +        (fixed_cause == RISCV_EXCP_STORE_AMO_ADDR_MIS) ||
> > +        (fixed_cause == RISCV_EXCP_LOAD_ACCESS_FAULT) ||
> > +        (fixed_cause == RISCV_EXCP_STORE_AMO_ACCESS_FAULT) ||
> > +        (fixed_cause == RISCV_EXCP_INST_PAGE_FAULT) ||
> > +        (fixed_cause == RISCV_EXCP_LOAD_PAGE_FAULT) ||
> > +        (fixed_cause == RISCV_EXCP_STORE_PAGE_FAULT);
> > +
> > +    if (bit & ((target_ulong)1 << (TARGET_LONG_BITS - 1))) {
> > +        deleg = env->mideleg;
> > +        bit &= ~((target_ulong)1 << (TARGET_LONG_BITS - 1));
> > +    }
> > +
> > +    if (env->priv <= PRV_S && bit < 64 && ((deleg >> bit) & 1)) {
> > +        /* handle the trap in S-mode */
> > +        /* No need to check STVEC for misaligned - lower 2 bits cannot
> be set */
> > +        env->pc = env->stvec;
> > +        env->scause = fixed_cause;
> > +        env->sepc = backup_epc;
> > +
> > +        if (hasbadaddr) {
> > +            #ifdef RISCV_DEBUG_INTERRUPT
> > +            fprintf(stderr, "core %d: badaddr 0x" TARGET_FMT_lx "\n",
> > +                    env->mhartid, env->badaddr);
> > +            #endif
> > +            env->sbadaddr = env->badaddr;
> > +        }
> > +
> > +        target_ulong s = env->mstatus;
> > +        s = set_field(s, MSTATUS_SPIE, get_field(s, MSTATUS_UIE <<
> env->priv));
> > +        s = set_field(s, MSTATUS_SPP, env->priv);
> > +        s = set_field(s, MSTATUS_SIE, 0);
> > +        csr_write_helper(env, s, CSR_MSTATUS);
> > +        set_privilege(env, PRV_S);
> > +    } else {
> > +        /* No need to check MTVEC for misaligned - lower 2 bits cannot
> be set */
> > +        env->pc = env->mtvec;
> > +        env->mepc = backup_epc;
> > +        env->mcause = fixed_cause;
> > +
> > +        if (hasbadaddr) {
> > +            #ifdef RISCV_DEBUG_INTERRUPT
> > +            fprintf(stderr, "core %d: badaddr 0x" TARGET_FMT_lx "\n",
> > +                    env->mhartid, env->badaddr);
> > +            #endif
> > +            env->mbadaddr = env->badaddr;
> > +        }
> > +
> > +        target_ulong s = env->mstatus;
> > +        s = set_field(s, MSTATUS_MPIE, get_field(s, MSTATUS_UIE <<
> env->priv));
> > +        s = set_field(s, MSTATUS_MPP, env->priv);
> > +        s = set_field(s, MSTATUS_MIE, 0);
> > +        csr_write_helper(env, s, CSR_MSTATUS);
> > +        set_privilege(env, PRV_M);
> > +    }
> > +    /* TODO yield load reservation  */
> > +#endif
> > +    cs->exception_index = EXCP_NONE; /* mark handled to qemu */
> > +}
>
> Marking handled is done generically.  Why do you need to do it here?


Nothing i guess. I'll remove and re-test...


> > +/* Floating Point - fused */
> > +DEF_HELPER_FLAGS_5(fmadd_s, TCG_CALL_NO_RWG, i64, env, i64, i64, i64,
> i64)
>
> Ideally these would go in with the patch that adds the helpers, so they're
> easier to validate.  However, I suppose it doesn't really matter.
>
> > +void helper_raise_exception_mbadaddr(CPURISCVState *env, uint32_t
> exception,
> > +        target_ulong bad_pc) {
>
> Brace on next line.
>
> > +    #ifdef RISCV_DEBUG_PRINT
> > +    fprintf(stderr, "Write CSR reg: 0x" TARGET_FMT_lx "\n", csrno);
> > +    fprintf(stderr, "Write CSR val: 0x" TARGET_FMT_lx "\n",
> val_to_write);
> > +    #endif
>
> Drop the debugging prints.  Perhaps use the tracing infrastructure?


Agree. That will take some time...


>
> > +    case CSR_MISA: {
> > +        if (!(val_to_write & (1L << ('F' - 'A')))) {
> > +            val_to_write &= ~(1L << ('D' - 'A'));
> > +        }
> > +
> > +        /* allow MAFDC bits in MISA to be modified */
> > +        target_ulong mask = 0;
> > +        mask |= 1L << ('M' - 'A');
> > +        mask |= 1L << ('A' - 'A');
> > +        mask |= 1L << ('F' - 'A');
> > +        mask |= 1L << ('D' - 'A');
> > +        mask |= 1L << ('C' - 'A');
> > +        mask &= env->misa_mask;
> > +
> > +        env->misa = (val_to_write & mask) | (env->misa & ~mask);
>
> Does this not affect the set of instructions that are allowable?  If so,
> you'd
> want something like
>
>     new_misa = (val_to_write & mask) | (env->misa & ~mask);
>     if (env->misa != new_misa) {
>         env->misa = new_misa;
>         tb_flush(CPU(riscv_env_get_cpu(env)));
>     }
>
> so that we start with all new translations, which would then check the new
> value of misa, and would then raise INST_ADDR_MIS (or not).
>
> > +inline target_ulong csr_read_helper(CPURISCVState *env, target_ulong
> csrno)
>
> Why mark such large functions inline?


Inherited. I'd outlined some occurences.

It seems we need to do quite a bit of work on the cpu core.

> +void set_privilege(CPURISCVState *env, target_ulong newpriv)
> > +{
> > +    if (!(newpriv <= PRV_M)) {
> > +        printf("INVALID PRIV SET\n");
> > +        exit(1);
> > +    }
> > +    if (newpriv == PRV_H) {
> > +        newpriv = PRV_U;
> > +    }
> > +    helper_tlb_flush(env);
>
> Why flush?  Doesn't this just switch to a different mmu_idx?


Sagar or Bastien might be able to answer that.


> > +void helper_fence_i(CPURISCVState *env)
> > +{
> > +    RISCVCPU *cpu = riscv_env_get_cpu(env);
> > +    CPUState *cs = CPU(cpu);
> > +    /* Flush QEMU's TLB */
> > +    tlb_flush(cs);
> > +    /* ARM port seems to not know if this is okay inside a TB
> > +       But we need to do it */
> > +    tb_flush(cs);
> > +}
>
> You should not require either flush.
> This insn can be implemented in qemu as a nop.
>

So self modifying code with no advice is fine? I guess that is required to
support x86. Will include in the next spin.

This may take some time... When is code freeze for 2.12?
