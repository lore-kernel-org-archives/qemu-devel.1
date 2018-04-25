Received: from eggs.gnu.org ([2001:4830:134:3::10]:46437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fBKla-0003ue-5N
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 09:47:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fBKlV-00079Z-2w
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 09:47:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59780 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fBKlU-00079L-Tp
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 09:47:21 -0400
References: <20180424214550.32549-1-lersek@redhat.com>
	<20180424214550.32549-7-lersek@redhat.com>
	<8736zjagg3.fsf@dusky.pond.sub.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <4509705a-43b2-db40-aa24-18eff649e750@redhat.com>
Date: Wed, 25 Apr 2018 15:47:10 +0200
MIME-Version: 1.0
In-Reply-To: <8736zjagg3.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/6] qapi: discriminate CpuInfo[Fast] on
 SysEmuTarget, not CpuInfoArch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 04/25/18 09:33, Markus Armbruster wrote:
> Laszlo Ersek <lersek@redhat.com> writes:

[snip]

>> +static CpuInfoArch sysemu_target_to_cpuinfo_arch(SysEmuTarget target)
>> +{
>> +    /*
>> +     * The @SysEmuTarget -> @CpuInfoArch mapping below is based on the
>> +     * TARGET_ARCH -> TARGET_BASE_ARCH mapping in the "configure" script.
>> +     */
>> +    switch (target) {
>> +    case SYS_EMU_TARGET_I386:
>> +    case SYS_EMU_TARGET_X86_64:
>> +        return CPU_INFO_ARCH_X86;
>> +
>> +    case SYS_EMU_TARGET_PPC:
>> +    case SYS_EMU_TARGET_PPCEMB:
>> +    case SYS_EMU_TARGET_PPC64:
>> +        return CPU_INFO_ARCH_PPC;
>> +
>> +    case SYS_EMU_TARGET_SPARC:
>> +    case SYS_EMU_TARGET_SPARC64:
>> +        return CPU_INFO_ARCH_SPARC;
>> +
>> +    case SYS_EMU_TARGET_MIPS:
>> +    case SYS_EMU_TARGET_MIPSEL:
>> +    case SYS_EMU_TARGET_MIPS64:
>> +    case SYS_EMU_TARGET_MIPS64EL:
>> +        return CPU_INFO_ARCH_MIPS;
>> +
>> +    case SYS_EMU_TARGET_TRICORE:
>> +        return CPU_INFO_ARCH_TRICORE;
>> +
>> +    case SYS_EMU_TARGET_S390X:
>> +        return CPU_INFO_ARCH_S390;
>> +
>> +    case SYS_EMU_TARGET_RISCV32:
>> +    case SYS_EMU_TARGET_RISCV64:
>> +        return CPU_INFO_ARCH_RISCV;
>> +
>> +    default:
>> +        return CPU_INFO_ARCH_OTHER;
>> +    }
>> +}
> 
> Hmm.  Can we avoid duplicating configure's mapping here?  More on that
> below.
> 
>> +
>> +static void cpustate_to_cpuinfo_x86(CpuInfoX86 *info, const CPUState *cpu)
>> +{
>> +#ifdef TARGET_I386
>> +    X86CPU *x86_cpu = X86_CPU(cpu);
>> +    CPUX86State *env = &x86_cpu->env;
>> +
>> +    info->pc = env->eip + env->segs[R_CS].base;
>> +#else
>> +    abort();
>> +#endif
>> +}
>> +
>> +static void cpustate_to_cpuinfo_ppc(CpuInfoPPC *info, const CPUState *cpu)
>> +{
>> +#ifdef TARGET_PPC
>> +    PowerPCCPU *ppc_cpu = POWERPC_CPU(cpu);
>> +    CPUPPCState *env = &ppc_cpu->env;
>> +
>> +    info->nip = env->nip;
>> +#else
>> +    abort();
>> +#endif
>> +}
>> +
>> +static void cpustate_to_cpuinfo_sparc(CpuInfoSPARC *info, const CPUState *cpu)
>> +{
>> +#ifdef TARGET_SPARC
>> +    SPARCCPU *sparc_cpu = SPARC_CPU(cpu);
>> +    CPUSPARCState *env = &sparc_cpu->env;
>> +
>> +    info->pc = env->pc;
>> +    info->npc = env->npc;
>> +#else
>> +    abort();
>> +#endif
>> +}
>> +
>> +static void cpustate_to_cpuinfo_mips(CpuInfoMIPS *info, const CPUState *cpu)
>> +{
>> +#ifdef TARGET_MIPS
>> +    MIPSCPU *mips_cpu = MIPS_CPU(cpu);
>> +    CPUMIPSState *env = &mips_cpu->env;
>> +
>> +    info->PC = env->active_tc.PC;
>> +#else
>> +    abort();
>> +#endif
>> +}
>> +
>> +static void cpustate_to_cpuinfo_tricore(CpuInfoTricore *info,
>> +                                        const CPUState *cpu)
>> +{
>> +#ifdef TARGET_TRICORE
>> +    TriCoreCPU *tricore_cpu = TRICORE_CPU(cpu);
>> +    CPUTriCoreState *env = &tricore_cpu->env;
>> +
>> +    info->PC = env->PC;
>> +#else
>> +    abort();
>> +#endif
>> +}
>> +
>> +static void cpustate_to_cpuinfo_s390(CpuInfoS390 *info, const CPUState *cpu)
>> +{
>> +#ifdef TARGET_S390X
>> +    S390CPU *s390_cpu = S390_CPU(cpu);
>> +    CPUS390XState *env = &s390_cpu->env;
>> +
>> +    info->cpu_state = env->cpu_state;
>> +#else
>> +    abort();
>> +#endif
>> +}
>> +
>> +static void cpustate_to_cpuinfo_riscv(CpuInfoRISCV *info, const CPUState *cpu)
>> +{
>> +#ifdef TARGET_RISCV
>> +    RISCVCPU *riscv_cpu = RISCV_CPU(cpu);
>> +    CPURISCVState *env = &riscv_cpu->env;
>> +
>> +    info->pc = env->pc;
>> +#else
>> +    abort();
>> +#endif
>> +}
>> +
> 
> To reduce #ifdeffery here, these helpers could be moved to suitable
> files in target/*/, plus stubs, but I doubt it's worth the bother.

Indeed. I did look for suitable recipient C files under target/*/, in
particular target/*/cpu.c, but my results weren't promising.

For example, "target/ppc/cpu.c" says "PowerPC CPU routines for qemu"
(and its actual contents agree), so quite inappropriate.

I wouldn't like to introduce new files for this, and if we're just
looking for a dumping ground for these functions, let's keep them here.

> 
>>  CpuInfoList *qmp_query_cpus(Error **errp)
>>  {
>>      MachineState *ms = MACHINE(qdev_get_machine());
>>      MachineClass *mc = MACHINE_GET_CLASS(ms);
>>      CpuInfoList *head = NULL, *cur_item = NULL;
>> +    SysEmuTarget target = qapi_enum_parse(&SysEmuTarget_lookup, TARGET_NAME,
>> +                                          -1, &error_abort);
> 
> Note how configure providing TARGET_NAME makes computing target easy.
> 
> Compare to how sysemu_target_to_cpuinfo_arch() computes arch.  Would it
> make sense to have configure provide TARGET_BASE_NAME, so we can compute
> arch the same way as target?

It would eliminate sysemu_target_to_cpuinfo_arch() entirely, yes.

However, the (quite more painful) mapping below would not be helped:

[snip]

>> +        /*
>> +         * The @SysEmuTarget -> @CpuInfo mapping below is based on the
>> +         * TARGET_ARCH -> TARGET_BASE_ARCH mapping in the "configure" script.
>> +         */
>> +        switch (target) {
>> +        case SYS_EMU_TARGET_I386:
>> +            cpustate_to_cpuinfo_x86(&info->value->u.i386, cpu);
>> +            break;
>> +        case SYS_EMU_TARGET_X86_64:
>> +            cpustate_to_cpuinfo_x86(&info->value->u.x86_64, cpu);
>> +            break;
>> +
>> +        case SYS_EMU_TARGET_PPC:
>> +            cpustate_to_cpuinfo_ppc(&info->value->u.ppc, cpu);
>> +            break;
>> +        case SYS_EMU_TARGET_PPCEMB:
>> +            cpustate_to_cpuinfo_ppc(&info->value->u.ppcemb, cpu);
>> +            break;
>> +        case SYS_EMU_TARGET_PPC64:
>> +            cpustate_to_cpuinfo_ppc(&info->value->u.ppc64, cpu);
>> +            break;
>> +
>> +        case SYS_EMU_TARGET_SPARC:
>> +            cpustate_to_cpuinfo_sparc(&info->value->u.q_sparc, cpu);
>> +            break;
>> +        case SYS_EMU_TARGET_SPARC64:
>> +            cpustate_to_cpuinfo_sparc(&info->value->u.sparc64, cpu);
>> +            break;
>> +
>> +        case SYS_EMU_TARGET_MIPS:
>> +            cpustate_to_cpuinfo_mips(&info->value->u.q_mips, cpu);
>> +            break;
>> +        case SYS_EMU_TARGET_MIPSEL:
>> +            cpustate_to_cpuinfo_mips(&info->value->u.mipsel, cpu);
>> +            break;
>> +        case SYS_EMU_TARGET_MIPS64:
>> +            cpustate_to_cpuinfo_mips(&info->value->u.mips64, cpu);
>> +            break;
>> +        case SYS_EMU_TARGET_MIPS64EL:
>> +            cpustate_to_cpuinfo_mips(&info->value->u.mips64el, cpu);
>> +            break;
>> +
>> +        case SYS_EMU_TARGET_TRICORE:
>> +            cpustate_to_cpuinfo_tricore(&info->value->u.tricore, cpu);
>> +            break;
>> +
>> +        case SYS_EMU_TARGET_S390X:
>> +            cpustate_to_cpuinfo_s390(&info->value->u.s390x, cpu);
>> +            break;
>> +
>> +        case SYS_EMU_TARGET_RISCV32:
>> +            cpustate_to_cpuinfo_riscv(&info->value->u.riscv32, cpu);
>> +            break;
>> +        case SYS_EMU_TARGET_RISCV64:
>> +            cpustate_to_cpuinfo_riscv(&info->value->u.riscv64, cpu);
>> +            break;
>> +
>> +        default:
>> +            /* do nothing for @CpuInfoOther */
>> +            break;
>> +        }
>> +

I don't know how this could be simplified. Even if the build system
provided some more macros, and we used token pasting here, we'd still
have to list all the case labels and the function calls one by one.

... I've also thought of fusing this switch statement with the one in
sysemu_target_to_cpuinfo_arch(), somehow, into a more generic helper
function. The idea would be to map the enums unconditionally, and map
the sub-structure only conditionally (e.g. if the "cpu" parameter were
not NULL). However, this helper function would not be reusable from
qmp_query_cpus_fast(): the helper cannot take a pointer *to the union*
called "u", because (a) that union has no *named* type, (b) even if it
had a type, that type differs between @CpuInfo and @CpuInfoFast.

In other words, it is impossible to write a C function that takes a
pointer to "some" union, and then fills the "s390x" member for *both*
qmp_query_cpus() and qmp_query_cpus_fast(). Those unions are genuinely
different, so the discrimination -- the identification of the
appropriate union member -- must occur separately in each. Once that's
done, we can call cpustate_to_cpuinfo_s390() from both places:

[snip]

>> +        info->value->arch = sysemu_target_to_cpuinfo_arch(target);
>> +        info->value->target = target;
>> +        if (target == SYS_EMU_TARGET_S390X) {
>> +            cpustate_to_cpuinfo_s390(&info->value->u.s390x, cpu);
>> +        } else {
>> +            /* do nothing for @CpuInfoOther */
>> +        }
>> +

In brief, I think extending configure / the build system would only help
with the less painful part of this (the scalar mapping), and so it's not
worth doing.

Thanks!
Laszlo
