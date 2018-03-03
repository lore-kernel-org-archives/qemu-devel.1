Received: from eggs.gnu.org ([2001:4830:134:3::10]:45179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1erwps-0001ki-RR
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 21:23:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1erwpk-0006Af-5H
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 21:23:44 -0500
Received: from mail-ot0-x22b.google.com ([2607:f8b0:4003:c0f::22b]:45201)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1erwpj-0006A9-Nn
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 21:23:36 -0500
Received: by mail-ot0-x22b.google.com with SMTP id f11so10437932otj.12
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 18:23:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1519998711-73430-4-git-send-email-mjc@sifive.com>
References: <1519998711-73430-1-git-send-email-mjc@sifive.com>
	<1519998711-73430-4-git-send-email-mjc@sifive.com>
From: Michael Clark <mjc@sifive.com>
Date: Sat, 3 Mar 2018 15:23:33 +1300
Message-ID: <CAHNT7NvaHm_nnzNWTn=J1QfNhOXy7XeyF2SQC2NQYT6=RvFj3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v8 03/23] RISC-V CPU Core Definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, Palmer Dabbelt <palmer@sifive.com>, Andrew Waterman <andrew@sifive.com>
Cc: Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, RISC-V Patches <patches@groups.riscv.org>

We were able to remove several ifdefs and figured out a problem with
masking out cores for qemu-system-riscv32 and qemu-system-riscv64.

This version of the core patch seems cleaner to me and we have fixed a few
spec compliance issues with regard to alignment of mtvec/stvec when the C
extension is enabled or disabled.

We haven't addressed runtime changes to 'misa' as it is legal for 'misa' to
be read-only. A later "feature" patch will add runtime support for misa
changes, likely just invalidating the translation cache due to the limited
number of bits in mmu_index. I can say for sure we not going to do anything
this risky so close to soft-freeze. The last minute changes were focused at
specification compliance for MMU vs NOMMU and respecting the 'S' and 'U'
misa bits with respect to allowable privilege modes. SiFive's E Series
cores do not support S mode but they do support U mode.

We also had an internal discussion about S-mode vs mmu, and it was decided
that it is a legal combination to have a nommu core that implements S mode.
In this use case, M mode could configure PMP (Physical Memory Protection),
and it would potentially possible to port FDPIC nommu linux to work on a
core with S mode and nommu. The other S mode registers besides 'satp'
(Supervisor Address Translation Pointer) are available in S-mode with nommu.

The v8 patch series just tightens up compliance with the specification, and
makes use of the mmu register (satp), selecting S-mode or calling SRET
cause illegal instruction traps.

Writes to mstatus.mpp of un unsupported modes (i.e. 'S' or 'U' misa bits
not present) are silently dropped, as that is the behaviour I am told
should be implemented. We may have to raise some issues against the RISC-V
Privileged ISA specification to make sure that this behaviour is specified,
as it currently does not specify explicitly the behaviour for a core that
supports S-mode with no-mmu.

Regards,
Michael.

On Sat, Mar 3, 2018 at 2:51 AM, Michael Clark <mjc@sifive.com> wrote:

> Add CPU state header, CPU definitions and initialization routines
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>  target/riscv/cpu.c      | 432 ++++++++++++++++++++++++++++++
> ++++++++++++++++++
>  target/riscv/cpu.h      | 296 +++++++++++++++++++++++++++++++++
>  target/riscv/cpu_bits.h | 411 ++++++++++++++++++++++++++++++
> +++++++++++++++
>  3 files changed, 1139 insertions(+)
>  create mode 100644 target/riscv/cpu.c
>  create mode 100644 target/riscv/cpu.h
>  create mode 100644 target/riscv/cpu_bits.h
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> new file mode 100644
> index 0000000..4851890
> --- /dev/null
> +++ b/target/riscv/cpu.c
> @@ -0,0 +1,432 @@
> +/*
> + * QEMU RISC-V CPU
> + *
> + * Copyright (c) 2016-2017 Sagar Karandikar, sagark@eecs.berkeley.edu
> + * Copyright (c) 2017-2018 SiFive, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License
> along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "cpu.h"
> +#include "exec/exec-all.h"
> +#include "qapi/error.h"
> +#include "migration/vmstate.h"
> +
> +/* RISC-V CPU definitions */
> +
> +static const char riscv_exts[26] = "IMAFDQECLBJTPVNSUHKORWXYZG";
> +
> +const char * const riscv_int_regnames[] = {
> +  "zero", "ra  ", "sp  ", "gp  ", "tp  ", "t0  ", "t1  ", "t2  ",
> +  "s0  ", "s1  ", "a0  ", "a1  ", "a2  ", "a3  ", "a4  ", "a5  ",
> +  "a6  ", "a7  ", "s2  ", "s3  ", "s4  ", "s5  ", "s6  ", "s7  ",
> +  "s8  ", "s9  ", "s10 ", "s11 ", "t3  ", "t4  ", "t5  ", "t6  "
> +};
> +
> +const char * const riscv_fpr_regnames[] = {
> +  "ft0 ", "ft1 ", "ft2 ", "ft3 ", "ft4 ", "ft5 ", "ft6 ",  "ft7 ",
> +  "fs0 ", "fs1 ", "fa0 ", "fa1 ", "fa2 ", "fa3 ", "fa4 ",  "fa5 ",
> +  "fa6 ", "fa7 ", "fs2 ", "fs3 ", "fs4 ", "fs5 ", "fs6 ",  "fs7 ",
> +  "fs8 ", "fs9 ", "fs10", "fs11", "ft8 ", "ft9 ", "ft10",  "ft11"
> +};
> +
> +const char * const riscv_excp_names[] = {
> +    "misaligned_fetch",
> +    "fault_fetch",
> +    "illegal_instruction",
> +    "breakpoint",
> +    "misaligned_load",
> +    "fault_load",
> +    "misaligned_store",
> +    "fault_store",
> +    "user_ecall",
> +    "supervisor_ecall",
> +    "hypervisor_ecall",
> +    "machine_ecall",
> +    "exec_page_fault",
> +    "load_page_fault",
> +    "reserved",
> +    "store_page_fault"
> +};
> +
> +const char * const riscv_intr_names[] = {
> +    "u_software",
> +    "s_software",
> +    "h_software",
> +    "m_software",
> +    "u_timer",
> +    "s_timer",
> +    "h_timer",
> +    "m_timer",
> +    "u_external",
> +    "s_external",
> +    "h_external",
> +    "m_external",
> +    "coprocessor",
> +    "host"
> +};
> +
> +typedef struct RISCVCPUInfo {
> +    const int bit_widths;
> +    const char *name;
> +    void (*initfn)(Object *obj);
> +} RISCVCPUInfo;
> +
> +static void set_misa(CPURISCVState *env, target_ulong misa)
> +{
> +    env->misa = misa;
> +}
> +
> +static void set_versions(CPURISCVState *env, int user_ver, int priv_ver)
> +{
> +    env->user_ver = user_ver;
> +    env->priv_ver = priv_ver;
> +}
> +
> +static void set_feature(CPURISCVState *env, int feature)
> +{
> +    env->features |= (1ULL << feature);
> +}
> +
> +static void set_resetvec(CPURISCVState *env, int resetvec)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    env->resetvec = resetvec;
> +#endif
> +}
> +
> +static void riscv_any_cpu_init(Object *obj)
> +{
> +    CPURISCVState *env = &RISCV_CPU(obj)->env;
> +    set_misa(env, RVXLEN | RVI | RVM | RVA | RVF | RVD | RVC | RVU);
> +    set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
> +    set_resetvec(env, DEFAULT_RSTVEC);
> +}
> +
> +static void rv32gcsu_priv1_09_1_cpu_init(Object *obj)
> +{
> +    CPURISCVState *env = &RISCV_CPU(obj)->env;
> +    set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
> +    set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_09_1);
> +    set_resetvec(env, DEFAULT_RSTVEC);
> +    set_feature(env, RISCV_FEATURE_MMU);
> +}
> +
> +static void rv32gcsu_priv1_10_0_cpu_init(Object *obj)
> +{
> +    CPURISCVState *env = &RISCV_CPU(obj)->env;
> +    set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
> +    set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
> +    set_resetvec(env, DEFAULT_RSTVEC);
> +    set_feature(env, RISCV_FEATURE_MMU);
> +}
> +
> +static void rv32imacu_nommu_cpu_init(Object *obj)
> +{
> +    CPURISCVState *env = &RISCV_CPU(obj)->env;
> +    set_misa(env, RV32 | RVI | RVM | RVA | RVC | RVU);
> +    set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
> +    set_resetvec(env, DEFAULT_RSTVEC);
> +}
> +
> +static void rv64gcsu_priv1_09_1_cpu_init(Object *obj)
> +{
> +    CPURISCVState *env = &RISCV_CPU(obj)->env;
> +    set_misa(env, RV64 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
> +    set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_09_1);
> +    set_resetvec(env, DEFAULT_RSTVEC);
> +    set_feature(env, RISCV_FEATURE_MMU);
> +}
> +
> +static void rv64gcsu_priv1_10_0_cpu_init(Object *obj)
> +{
> +    CPURISCVState *env = &RISCV_CPU(obj)->env;
> +    set_misa(env, RV64 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
> +    set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
> +    set_resetvec(env, DEFAULT_RSTVEC);
> +    set_feature(env, RISCV_FEATURE_MMU);
> +}
> +
> +static void rv64imacu_nommu_cpu_init(Object *obj)
> +{
> +    CPURISCVState *env = &RISCV_CPU(obj)->env;
> +    set_misa(env, RV64 | RVI | RVM | RVA | RVC | RVU);
> +    set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
> +    set_resetvec(env, DEFAULT_RSTVEC);
> +}
> +
> +static const RISCVCPUInfo riscv_cpus[] = {
> +    { 96, TYPE_RISCV_CPU_ANY,              riscv_any_cpu_init },
> +    { 32, TYPE_RISCV_CPU_RV32GCSU_V1_09_1, rv32gcsu_priv1_09_1_cpu_init
> },
> +    { 32, TYPE_RISCV_CPU_RV32GCSU_V1_10_0, rv32gcsu_priv1_10_0_cpu_init
> },
> +    { 32, TYPE_RISCV_CPU_RV32IMACU_NOMMU,  rv32imacu_nommu_cpu_init },
> +    { 32, TYPE_RISCV_CPU_SIFIVE_E31,       rv32imacu_nommu_cpu_init },
> +    { 32, TYPE_RISCV_CPU_SIFIVE_U34,       rv32gcsu_priv1_10_0_cpu_init },
> +    { 64, TYPE_RISCV_CPU_RV64GCSU_V1_09_1, rv64gcsu_priv1_09_1_cpu_init
> },
> +    { 64, TYPE_RISCV_CPU_RV64GCSU_V1_10_0, rv64gcsu_priv1_10_0_cpu_init
> },
> +    { 64, TYPE_RISCV_CPU_RV64IMACU_NOMMU,  rv64imacu_nommu_cpu_init },
> +    { 64, TYPE_RISCV_CPU_SIFIVE_E51,       rv64imacu_nommu_cpu_init },
> +    { 64, TYPE_RISCV_CPU_SIFIVE_U54,       rv64gcsu_priv1_10_0_cpu_init },
> +    { 0, NULL, NULL }
> +};
> +
> +static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
> +{
> +    ObjectClass *oc;
> +    char *typename;
> +    char **cpuname;
> +
> +    cpuname = g_strsplit(cpu_model, ",", 1);
> +    typename = g_strdup_printf(RISCV_CPU_TYPE_NAME("%s"), cpuname[0]);
> +    oc = object_class_by_name(typename);
> +    g_strfreev(cpuname);
> +    g_free(typename);
> +    if (!oc || !object_class_dynamic_cast(oc, TYPE_RISCV_CPU) ||
> +        object_class_is_abstract(oc)) {
> +        return NULL;
> +    }
> +    return oc;
> +}
> +
> +static void riscv_cpu_dump_state(CPUState *cs, FILE *f,
> +    fprintf_function cpu_fprintf, int flags)
> +{
> +    RISCVCPU *cpu = RISCV_CPU(cs);
> +    CPURISCVState *env = &cpu->env;
> +    int i;
> +
> +    cpu_fprintf(f, " %s " TARGET_FMT_lx "\n", "pc      ", env->pc);
> +#ifndef CONFIG_USER_ONLY
> +    cpu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mhartid ", env->mhartid);
> +    cpu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatus ", env->mstatus);
> +    cpu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mip     ",
> +        (target_ulong)atomic_read(&env->mip));
> +    cpu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mie     ", env->mie);
> +    cpu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mideleg ", env->mideleg);
> +    cpu_fprintf(f, " %s " TARGET_FMT_lx "\n", "medeleg ", env->medeleg);
> +    cpu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mtvec   ", env->mtvec);
> +    cpu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mepc    ", env->mepc);
> +    cpu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mcause  ", env->mcause);
> +#endif
> +
> +    for (i = 0; i < 32; i++) {
> +        cpu_fprintf(f, " %s " TARGET_FMT_lx,
> +            riscv_int_regnames[i], env->gpr[i]);
> +        if ((i & 3) == 3) {
> +            cpu_fprintf(f, "\n");
> +        }
> +    }
> +    for (i = 0; i < 32; i++) {
> +        cpu_fprintf(f, " %s %016" PRIx64,
> +            riscv_fpr_regnames[i], env->fpr[i]);
> +        if ((i & 3) == 3) {
> +            cpu_fprintf(f, "\n");
> +        }
> +    }
> +}
> +
> +static void riscv_cpu_set_pc(CPUState *cs, vaddr value)
> +{
> +    RISCVCPU *cpu = RISCV_CPU(cs);
> +    CPURISCVState *env = &cpu->env;
> +    env->pc = value;
> +}
> +
> +static void riscv_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock
> *tb)
> +{
> +    RISCVCPU *cpu = RISCV_CPU(cs);
> +    CPURISCVState *env = &cpu->env;
> +    env->pc = tb->pc;
> +}
> +
> +static bool riscv_cpu_has_work(CPUState *cs)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    RISCVCPU *cpu = RISCV_CPU(cs);
> +    CPURISCVState *env = &cpu->env;
> +    /*
> +     * Definition of the WFI instruction requires it to ignore the
> privilege
> +     * mode and delegation registers, but respect individual enables
> +     */
> +    return (atomic_read(&env->mip) & env->mie) != 0;
> +#else
> +    return true;
> +#endif
> +}
> +
> +void restore_state_to_opc(CPURISCVState *env, TranslationBlock *tb,
> +                          target_ulong *data)
> +{
> +    env->pc = data[0];
> +}
> +
> +static void riscv_cpu_reset(CPUState *cs)
> +{
> +    RISCVCPU *cpu = RISCV_CPU(cs);
> +    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
> +    CPURISCVState *env = &cpu->env;
> +
> +    mcc->parent_reset(cs);
> +#ifndef CONFIG_USER_ONLY
> +    env->priv = PRV_M;
> +    env->mstatus &= ~(MSTATUS_MIE | MSTATUS_MPRV);
> +    env->mcause = 0;
> +    env->pc = env->resetvec;
> +#endif
> +    cs->exception_index = EXCP_NONE;
> +    set_default_nan_mode(1, &env->fp_status);
> +}
> +
> +static void riscv_cpu_disas_set_info(CPUState *s, disassemble_info *info)
> +{
> +#if defined(TARGET_RISCV32)
> +    info->print_insn = print_insn_riscv32;
> +#elif defined(TARGET_RISCV64)
> +    info->print_insn = print_insn_riscv64;
> +#endif
> +}
> +
> +static void riscv_cpu_realize(DeviceState *dev, Error **errp)
> +{
> +    CPUState *cs = CPU(dev);
> +    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
> +    Error *local_err = NULL;
> +
> +    cpu_exec_realizefn(cs, &local_err);
> +    if (local_err != NULL) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    qemu_init_vcpu(cs);
> +    cpu_reset(cs);
> +
> +    mcc->parent_realize(dev, errp);
> +}
> +
> +static void riscv_cpu_init(Object *obj)
> +{
> +    CPUState *cs = CPU(obj);
> +    RISCVCPU *cpu = RISCV_CPU(obj);
> +
> +    cs->env_ptr = &cpu->env;
> +}
> +
> +static const VMStateDescription vmstate_riscv_cpu = {
> +    .name = "cpu",
> +    .unmigratable = 1,
> +};
> +
> +static void riscv_cpu_class_init(ObjectClass *c, void *data)
> +{
> +    RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
> +    CPUClass *cc = CPU_CLASS(c);
> +    DeviceClass *dc = DEVICE_CLASS(c);
> +
> +    mcc->parent_realize = dc->realize;
> +    dc->realize = riscv_cpu_realize;
> +
> +    mcc->parent_reset = cc->reset;
> +    cc->reset = riscv_cpu_reset;
> +
> +    cc->class_by_name = riscv_cpu_class_by_name;
> +    cc->has_work = riscv_cpu_has_work;
> +    cc->do_interrupt = riscv_cpu_do_interrupt;
> +    cc->cpu_exec_interrupt = riscv_cpu_exec_interrupt;
> +    cc->dump_state = riscv_cpu_dump_state;
> +    cc->set_pc = riscv_cpu_set_pc;
> +    cc->synchronize_from_tb = riscv_cpu_synchronize_from_tb;
> +    cc->gdb_read_register = riscv_cpu_gdb_read_register;
> +    cc->gdb_write_register = riscv_cpu_gdb_write_register;
> +    cc->gdb_num_core_regs = 65;
> +    cc->gdb_stop_before_watchpoint = true;
> +    cc->disas_set_info = riscv_cpu_disas_set_info;
> +#ifdef CONFIG_USER_ONLY
> +    cc->handle_mmu_fault = riscv_cpu_handle_mmu_fault;
> +#else
> +    cc->do_unaligned_access = riscv_cpu_do_unaligned_access;
> +    cc->get_phys_page_debug = riscv_cpu_get_phys_page_debug;
> +#endif
> +#ifdef CONFIG_TCG
> +    cc->tcg_initialize = riscv_translate_init;
> +#endif
> +    /* For now, mark unmigratable: */
> +    cc->vmsd = &vmstate_riscv_cpu;
> +}
> +
> +static void cpu_register(const RISCVCPUInfo *info)
> +{
> +    TypeInfo type_info = {
> +        .name = info->name,
> +        .parent = TYPE_RISCV_CPU,
> +        .instance_size = sizeof(RISCVCPU),
> +        .instance_init = info->initfn,
> +    };
> +
> +    type_register(&type_info);
> +}
> +
> +static const TypeInfo riscv_cpu_type_info = {
> +    .name = TYPE_RISCV_CPU,
> +    .parent = TYPE_CPU,
> +    .instance_size = sizeof(RISCVCPU),
> +    .instance_init = riscv_cpu_init,
> +    .abstract = false,
> +    .class_size = sizeof(RISCVCPUClass),
> +    .class_init = riscv_cpu_class_init,
> +};
> +
> +char *riscv_isa_string(RISCVCPU *cpu)
> +{
> +    int i;
> +    size_t maxlen = 5 + ctz32(cpu->env.misa);
> +    char *isa_string = g_new0(char, maxlen);
> +    snprintf(isa_string, maxlen, "rv%d", TARGET_LONG_BITS);
> +    for (i = 0; i < sizeof(riscv_exts); i++) {
> +        if (cpu->env.misa & RV(riscv_exts[i])) {
> +            isa_string[strlen(isa_string)] = riscv_exts[i] - 'A' + 'a';
> +
> +        }
> +    }
> +    return isa_string;
> +}
> +
> +void riscv_cpu_list(FILE *f, fprintf_function cpu_fprintf)
> +{
> +    const RISCVCPUInfo *info = riscv_cpus;
> +
> +    while (info->name) {
> +        if (info->bit_widths & TARGET_LONG_BITS) {
> +            (*cpu_fprintf)(f, "%s\n", info->name);
> +        }
> +        info++;
> +    }
> +}
> +
> +static void riscv_cpu_register_types(void)
> +{
> +    const RISCVCPUInfo *info = riscv_cpus;
> +
> +    type_register_static(&riscv_cpu_type_info);
> +
> +    while (info->name) {
> +        if (info->bit_widths & TARGET_LONG_BITS) {
> +            cpu_register(info);
> +        }
> +        info++;
> +    }
> +}
> +
> +type_init(riscv_cpu_register_types)
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> new file mode 100644
> index 0000000..cff02a2
> --- /dev/null
> +++ b/target/riscv/cpu.h
> @@ -0,0 +1,296 @@
> +/*
> + * QEMU RISC-V CPU
> + *
> + * Copyright (c) 2016-2017 Sagar Karandikar, sagark@eecs.berkeley.edu
> + * Copyright (c) 2017-2018 SiFive, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License
> along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef RISCV_CPU_H
> +#define RISCV_CPU_H
> +
> +/* QEMU addressing/paging config */
> +#define TARGET_PAGE_BITS 12 /* 4 KiB Pages */
> +#if defined(TARGET_RISCV64)
> +#define TARGET_LONG_BITS 64
> +#define TARGET_PHYS_ADDR_SPACE_BITS 50
> +#define TARGET_VIRT_ADDR_SPACE_BITS 39
> +#elif defined(TARGET_RISCV32)
> +#define TARGET_LONG_BITS 32
> +#define TARGET_PHYS_ADDR_SPACE_BITS 34
> +#define TARGET_VIRT_ADDR_SPACE_BITS 32
> +#endif
> +
> +#define TCG_GUEST_DEFAULT_MO 0
> +
> +#define ELF_MACHINE EM_RISCV
> +#define CPUArchState struct CPURISCVState
> +
> +#include "qemu-common.h"
> +#include "qom/cpu.h"
> +#include "exec/cpu-defs.h"
> +#include "fpu/softfloat.h"
> +
> +#define TYPE_RISCV_CPU "riscv-cpu"
> +
> +#define RISCV_CPU_TYPE_SUFFIX "-" TYPE_RISCV_CPU
> +#define RISCV_CPU_TYPE_NAME(name) (name RISCV_CPU_TYPE_SUFFIX)
> +
> +#define TYPE_RISCV_CPU_ANY              RISCV_CPU_TYPE_NAME("any")
> +#define TYPE_RISCV_CPU_RV32GCSU_V1_09_1 RISCV_CPU_TYPE_NAME("rv32gcsu-
> v1.9.1")
> +#define TYPE_RISCV_CPU_RV32GCSU_V1_10_0 RISCV_CPU_TYPE_NAME("rv32gcsu-
> v1.10.0")
> +#define TYPE_RISCV_CPU_RV32IMACU_NOMMU  RISCV_CPU_TYPE_NAME("
> rv32imacu-nommu")
> +#define TYPE_RISCV_CPU_RV64GCSU_V1_09_1 RISCV_CPU_TYPE_NAME("rv64gcsu-
> v1.9.1")
> +#define TYPE_RISCV_CPU_RV64GCSU_V1_10_0 RISCV_CPU_TYPE_NAME("rv64gcsu-
> v1.10.0")
> +#define TYPE_RISCV_CPU_RV64IMACU_NOMMU  RISCV_CPU_TYPE_NAME("
> rv64imacu-nommu")
> +#define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31")
> +#define TYPE_RISCV_CPU_SIFIVE_E51       RISCV_CPU_TYPE_NAME("sifive-e51")
> +#define TYPE_RISCV_CPU_SIFIVE_U34       RISCV_CPU_TYPE_NAME("sifive-u34")
> +#define TYPE_RISCV_CPU_SIFIVE_U54       RISCV_CPU_TYPE_NAME("sifive-u54")
> +
> +#define RV32 ((target_ulong)1 << (TARGET_LONG_BITS - 2))
> +#define RV64 ((target_ulong)2 << (TARGET_LONG_BITS - 2))
> +
> +#if defined(TARGET_RISCV32)
> +#define RVXLEN RV32
> +#elif defined(TARGET_RISCV64)
> +#define RVXLEN RV64
> +#endif
> +
> +#define RV(x) ((target_ulong)1 << (x - 'A'))
> +
> +#define RVI RV('I')
> +#define RVM RV('M')
> +#define RVA RV('A')
> +#define RVF RV('F')
> +#define RVD RV('D')
> +#define RVC RV('C')
> +#define RVS RV('S')
> +#define RVU RV('U')
> +
> +/* S extension denotes that Supervisor mode exists, however it is possible
> +   to have a core that support S mode but does not have an MMU and there
> +   is currently no bit in misa to indicate whether an MMU exists or not
> +   so a cpu features bitfield is required */
> +enum {
> +    RISCV_FEATURE_MMU
> +};
> +
> +#define USER_VERSION_2_02_0 0x00020200
> +#define PRIV_VERSION_1_09_1 0x00010901
> +#define PRIV_VERSION_1_10_0 0x00011000
> +
> +#define TRANSLATE_FAIL 1
> +#define TRANSLATE_SUCCESS 0
> +#define NB_MMU_MODES 4
> +#define MMU_USER_IDX 3
> +
> +#define MAX_RISCV_PMPS (16)
> +
> +typedef struct CPURISCVState CPURISCVState;
> +
> +#include "pmp.h"
> +
> +struct CPURISCVState {
> +    target_ulong gpr[32];
> +    uint64_t fpr[32]; /* assume both F and D extensions */
> +    target_ulong pc;
> +    target_ulong load_res;
> +    target_ulong load_val;
> +
> +    target_ulong frm;
> +
> +    target_ulong badaddr;
> +
> +    target_ulong user_ver;
> +    target_ulong priv_ver;
> +    target_ulong misa;
> +
> +    uint32_t features;
> +
> +#ifndef CONFIG_USER_ONLY
> +    target_ulong priv;
> +    target_ulong resetvec;
> +
> +    target_ulong mhartid;
> +    target_ulong mstatus;
> +    /*
> +     * CAUTION! Unlike the rest of this struct, mip is accessed
> asynchonously
> +     * by I/O threads and other vCPUs, so hold the iothread mutex before
> +     * operating on it.  CPU_INTERRUPT_HARD should be in effect iff this
> is
> +     * non-zero.  Use riscv_cpu_set_local_interrupt.
> +     */
> +    uint32_t mip;        /* allow atomic_read for >= 32-bit hosts */
> +    target_ulong mie;
> +    target_ulong mideleg;
> +
> +    target_ulong sptbr;  /* until: priv-1.9.1 */
> +    target_ulong satp;   /* since: priv-1.10.0 */
> +    target_ulong sbadaddr;
> +    target_ulong mbadaddr;
> +    target_ulong medeleg;
> +
> +    target_ulong stvec;
> +    target_ulong sepc;
> +    target_ulong scause;
> +
> +    target_ulong mtvec;
> +    target_ulong mepc;
> +    target_ulong mcause;
> +    target_ulong mtval;  /* since: priv-1.10.0 */
> +
> +    uint32_t mucounteren;
> +    uint32_t mscounteren;
> +    target_ulong scounteren; /* since: priv-1.10.0 */
> +    target_ulong mcounteren; /* since: priv-1.10.0 */
> +
> +    target_ulong sscratch;
> +    target_ulong mscratch;
> +
> +    /* temporary htif regs */
> +    uint64_t mfromhost;
> +    uint64_t mtohost;
> +    uint64_t timecmp;
> +
> +    /* physical memory protection */
> +    pmp_table_t pmp_state;
> +#endif
> +
> +    float_status fp_status;
> +
> +    /* QEMU */
> +    CPU_COMMON
> +
> +    /* Fields from here on are preserved across CPU reset. */
> +    QEMUTimer *timer; /* Internal timer */
> +};
> +
> +#define RISCV_CPU_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(RISCVCPUClass, (klass), TYPE_RISCV_CPU)
> +#define RISCV_CPU(obj) \
> +    OBJECT_CHECK(RISCVCPU, (obj), TYPE_RISCV_CPU)
> +#define RISCV_CPU_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(RISCVCPUClass, (obj), TYPE_RISCV_CPU)
> +
> +/**
> + * RISCVCPUClass:
> + * @parent_realize: The parent class' realize handler.
> + * @parent_reset: The parent class' reset handler.
> + *
> + * A RISCV CPU model.
> + */
> +typedef struct RISCVCPUClass {
> +    /*< private >*/
> +    CPUClass parent_class;
> +    /*< public >*/
> +    DeviceRealize parent_realize;
> +    void (*parent_reset)(CPUState *cpu);
> +} RISCVCPUClass;
> +
> +/**
> + * RISCVCPU:
> + * @env: #CPURISCVState
> + *
> + * A RISCV CPU.
> + */
> +typedef struct RISCVCPU {
> +    /*< private >*/
> +    CPUState parent_obj;
> +    /*< public >*/
> +    CPURISCVState env;
> +} RISCVCPU;
> +
> +static inline RISCVCPU *riscv_env_get_cpu(CPURISCVState *env)
> +{
> +    return container_of(env, RISCVCPU, env);
> +}
> +
> +static inline int riscv_has_ext(CPURISCVState *env, target_ulong ext)
> +{
> +    return (env->misa & ext) != 0;
> +}
> +
> +static inline bool riscv_feature(CPURISCVState *env, int feature)
> +{
> +    return env->features & (1ULL << feature);
> +}
> +
> +#include "cpu_user.h"
> +#include "cpu_bits.h"
> +
> +extern const char * const riscv_int_regnames[];
> +extern const char * const riscv_fpr_regnames[];
> +extern const char * const riscv_excp_names[];
> +extern const char * const riscv_intr_names[];
> +
> +#define ENV_GET_CPU(e) CPU(riscv_env_get_cpu(e))
> +#define ENV_OFFSET offsetof(RISCVCPU, env)
> +
> +void riscv_cpu_do_interrupt(CPUState *cpu);
> +int riscv_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
> +int riscv_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
> +bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
> +int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch);
> +hwaddr riscv_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
> +void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
> +                                    MMUAccessType access_type, int
> mmu_idx,
> +                                    uintptr_t retaddr);
> +int riscv_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size,
> +                              int rw, int mmu_idx);
> +
> +char *riscv_isa_string(RISCVCPU *cpu);
> +void riscv_cpu_list(FILE *f, fprintf_function cpu_fprintf);
> +
> +#define cpu_init(cpu_model) cpu_generic_init(TYPE_RISCV_CPU, cpu_model)
> +#define cpu_signal_handler cpu_riscv_signal_handler
> +#define cpu_list riscv_cpu_list
> +#define cpu_mmu_index riscv_cpu_mmu_index
> +
> +void riscv_set_mode(CPURISCVState *env, target_ulong newpriv);
> +
> +void riscv_translate_init(void);
> +RISCVCPU *cpu_riscv_init(const char *cpu_model);
> +int cpu_riscv_signal_handler(int host_signum, void *pinfo, void *puc);
> +void QEMU_NORETURN do_raise_exception_err(CPURISCVState *env,
> +                                          uint32_t exception, uintptr_t
> pc);
> +
> +target_ulong cpu_riscv_get_fflags(CPURISCVState *env);
> +void cpu_riscv_set_fflags(CPURISCVState *env, target_ulong);
> +
> +#define TB_FLAGS_MMU_MASK  3
> +#define TB_FLAGS_FP_ENABLE MSTATUS_FS
> +
> +static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong
> *pc,
> +                                        target_ulong *cs_base, uint32_t
> *flags)
> +{
> +    *pc = env->pc;
> +    *cs_base = 0;
> +#ifdef CONFIG_USER_ONLY
> +    *flags = TB_FLAGS_FP_ENABLE;
> +#else
> +    *flags = cpu_mmu_index(env, 0) | (env->mstatus & MSTATUS_FS);
> +#endif
> +}
> +
> +void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
> +        target_ulong csrno);
> +target_ulong csr_read_helper(CPURISCVState *env, target_ulong csrno);
> +
> +#ifndef CONFIG_USER_ONLY
> +void riscv_set_local_interrupt(RISCVCPU *cpu, target_ulong mask, int
> value);
> +#endif
> +
> +#include "exec/cpu-all.h"
> +
> +#endif /* RISCV_CPU_H */
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> new file mode 100644
> index 0000000..64aa097
> --- /dev/null
> +++ b/target/riscv/cpu_bits.h
> @@ -0,0 +1,411 @@
> +/* RISC-V ISA constants */
> +
> +#define get_field(reg, mask) (((reg) & \
> +                 (target_ulong)(mask)) / ((mask) & ~((mask) << 1)))
> +#define set_field(reg, mask, val) (((reg) & ~(target_ulong)(mask)) | \
> +                 (((target_ulong)(val) * ((mask) & ~((mask) << 1))) & \
> +                 (target_ulong)(mask)))
> +
> +#define PGSHIFT 12
> +
> +#define FSR_RD_SHIFT 5
> +#define FSR_RD   (0x7 << FSR_RD_SHIFT)
> +
> +#define FPEXC_NX 0x01
> +#define FPEXC_UF 0x02
> +#define FPEXC_OF 0x04
> +#define FPEXC_DZ 0x08
> +#define FPEXC_NV 0x10
> +
> +#define FSR_AEXC_SHIFT 0
> +#define FSR_NVA  (FPEXC_NV << FSR_AEXC_SHIFT)
> +#define FSR_OFA  (FPEXC_OF << FSR_AEXC_SHIFT)
> +#define FSR_UFA  (FPEXC_UF << FSR_AEXC_SHIFT)
> +#define FSR_DZA  (FPEXC_DZ << FSR_AEXC_SHIFT)
> +#define FSR_NXA  (FPEXC_NX << FSR_AEXC_SHIFT)
> +#define FSR_AEXC (FSR_NVA | FSR_OFA | FSR_UFA | FSR_DZA | FSR_NXA)
> +
> +/* CSR numbers */
> +#define CSR_FFLAGS 0x1
> +#define CSR_FRM 0x2
> +#define CSR_FCSR 0x3
> +#define CSR_CYCLE 0xc00
> +#define CSR_TIME 0xc01
> +#define CSR_INSTRET 0xc02
> +#define CSR_HPMCOUNTER3 0xc03
> +#define CSR_HPMCOUNTER4 0xc04
> +#define CSR_HPMCOUNTER5 0xc05
> +#define CSR_HPMCOUNTER6 0xc06
> +#define CSR_HPMCOUNTER7 0xc07
> +#define CSR_HPMCOUNTER8 0xc08
> +#define CSR_HPMCOUNTER9 0xc09
> +#define CSR_HPMCOUNTER10 0xc0a
> +#define CSR_HPMCOUNTER11 0xc0b
> +#define CSR_HPMCOUNTER12 0xc0c
> +#define CSR_HPMCOUNTER13 0xc0d
> +#define CSR_HPMCOUNTER14 0xc0e
> +#define CSR_HPMCOUNTER15 0xc0f
> +#define CSR_HPMCOUNTER16 0xc10
> +#define CSR_HPMCOUNTER17 0xc11
> +#define CSR_HPMCOUNTER18 0xc12
> +#define CSR_HPMCOUNTER19 0xc13
> +#define CSR_HPMCOUNTER20 0xc14
> +#define CSR_HPMCOUNTER21 0xc15
> +#define CSR_HPMCOUNTER22 0xc16
> +#define CSR_HPMCOUNTER23 0xc17
> +#define CSR_HPMCOUNTER24 0xc18
> +#define CSR_HPMCOUNTER25 0xc19
> +#define CSR_HPMCOUNTER26 0xc1a
> +#define CSR_HPMCOUNTER27 0xc1b
> +#define CSR_HPMCOUNTER28 0xc1c
> +#define CSR_HPMCOUNTER29 0xc1d
> +#define CSR_HPMCOUNTER30 0xc1e
> +#define CSR_HPMCOUNTER31 0xc1f
> +#define CSR_SSTATUS 0x100
> +#define CSR_SIE 0x104
> +#define CSR_STVEC 0x105
> +#define CSR_SCOUNTEREN 0x106
> +#define CSR_SSCRATCH 0x140
> +#define CSR_SEPC 0x141
> +#define CSR_SCAUSE 0x142
> +#define CSR_SBADADDR 0x143
> +#define CSR_SIP 0x144
> +#define CSR_SPTBR 0x180
> +#define CSR_SATP 0x180
> +#define CSR_MSTATUS 0x300
> +#define CSR_MISA 0x301
> +#define CSR_MEDELEG 0x302
> +#define CSR_MIDELEG 0x303
> +#define CSR_MIE 0x304
> +#define CSR_MTVEC 0x305
> +#define CSR_MCOUNTEREN 0x306
> +#define CSR_MSCRATCH 0x340
> +#define CSR_MEPC 0x341
> +#define CSR_MCAUSE 0x342
> +#define CSR_MBADADDR 0x343
> +#define CSR_MIP 0x344
> +#define CSR_PMPCFG0 0x3a0
> +#define CSR_PMPCFG1 0x3a1
> +#define CSR_PMPCFG2 0x3a2
> +#define CSR_PMPCFG3 0x3a3
> +#define CSR_PMPADDR0 0x3b0
> +#define CSR_PMPADDR1 0x3b1
> +#define CSR_PMPADDR2 0x3b2
> +#define CSR_PMPADDR3 0x3b3
> +#define CSR_PMPADDR4 0x3b4
> +#define CSR_PMPADDR5 0x3b5
> +#define CSR_PMPADDR6 0x3b6
> +#define CSR_PMPADDR7 0x3b7
> +#define CSR_PMPADDR8 0x3b8
> +#define CSR_PMPADDR9 0x3b9
> +#define CSR_PMPADDR10 0x3ba
> +#define CSR_PMPADDR11 0x3bb
> +#define CSR_PMPADDR12 0x3bc
> +#define CSR_PMPADDR13 0x3bd
> +#define CSR_PMPADDR14 0x3be
> +#define CSR_PMPADDR15 0x3bf
> +#define CSR_TSELECT 0x7a0
> +#define CSR_TDATA1 0x7a1
> +#define CSR_TDATA2 0x7a2
> +#define CSR_TDATA3 0x7a3
> +#define CSR_DCSR 0x7b0
> +#define CSR_DPC 0x7b1
> +#define CSR_DSCRATCH 0x7b2
> +#define CSR_MCYCLE 0xb00
> +#define CSR_MINSTRET 0xb02
> +#define CSR_MHPMCOUNTER3 0xb03
> +#define CSR_MHPMCOUNTER4 0xb04
> +#define CSR_MHPMCOUNTER5 0xb05
> +#define CSR_MHPMCOUNTER6 0xb06
> +#define CSR_MHPMCOUNTER7 0xb07
> +#define CSR_MHPMCOUNTER8 0xb08
> +#define CSR_MHPMCOUNTER9 0xb09
> +#define CSR_MHPMCOUNTER10 0xb0a
> +#define CSR_MHPMCOUNTER11 0xb0b
> +#define CSR_MHPMCOUNTER12 0xb0c
> +#define CSR_MHPMCOUNTER13 0xb0d
> +#define CSR_MHPMCOUNTER14 0xb0e
> +#define CSR_MHPMCOUNTER15 0xb0f
> +#define CSR_MHPMCOUNTER16 0xb10
> +#define CSR_MHPMCOUNTER17 0xb11
> +#define CSR_MHPMCOUNTER18 0xb12
> +#define CSR_MHPMCOUNTER19 0xb13
> +#define CSR_MHPMCOUNTER20 0xb14
> +#define CSR_MHPMCOUNTER21 0xb15
> +#define CSR_MHPMCOUNTER22 0xb16
> +#define CSR_MHPMCOUNTER23 0xb17
> +#define CSR_MHPMCOUNTER24 0xb18
> +#define CSR_MHPMCOUNTER25 0xb19
> +#define CSR_MHPMCOUNTER26 0xb1a
> +#define CSR_MHPMCOUNTER27 0xb1b
> +#define CSR_MHPMCOUNTER28 0xb1c
> +#define CSR_MHPMCOUNTER29 0xb1d
> +#define CSR_MHPMCOUNTER30 0xb1e
> +#define CSR_MHPMCOUNTER31 0xb1f
> +#define CSR_MUCOUNTEREN 0x320
> +#define CSR_MSCOUNTEREN 0x321
> +#define CSR_MHPMEVENT3 0x323
> +#define CSR_MHPMEVENT4 0x324
> +#define CSR_MHPMEVENT5 0x325
> +#define CSR_MHPMEVENT6 0x326
> +#define CSR_MHPMEVENT7 0x327
> +#define CSR_MHPMEVENT8 0x328
> +#define CSR_MHPMEVENT9 0x329
> +#define CSR_MHPMEVENT10 0x32a
> +#define CSR_MHPMEVENT11 0x32b
> +#define CSR_MHPMEVENT12 0x32c
> +#define CSR_MHPMEVENT13 0x32d
> +#define CSR_MHPMEVENT14 0x32e
> +#define CSR_MHPMEVENT15 0x32f
> +#define CSR_MHPMEVENT16 0x330
> +#define CSR_MHPMEVENT17 0x331
> +#define CSR_MHPMEVENT18 0x332
> +#define CSR_MHPMEVENT19 0x333
> +#define CSR_MHPMEVENT20 0x334
> +#define CSR_MHPMEVENT21 0x335
> +#define CSR_MHPMEVENT22 0x336
> +#define CSR_MHPMEVENT23 0x337
> +#define CSR_MHPMEVENT24 0x338
> +#define CSR_MHPMEVENT25 0x339
> +#define CSR_MHPMEVENT26 0x33a
> +#define CSR_MHPMEVENT27 0x33b
> +#define CSR_MHPMEVENT28 0x33c
> +#define CSR_MHPMEVENT29 0x33d
> +#define CSR_MHPMEVENT30 0x33e
> +#define CSR_MHPMEVENT31 0x33f
> +#define CSR_MVENDORID 0xf11
> +#define CSR_MARCHID 0xf12
> +#define CSR_MIMPID 0xf13
> +#define CSR_MHARTID 0xf14
> +#define CSR_CYCLEH 0xc80
> +#define CSR_TIMEH 0xc81
> +#define CSR_INSTRETH 0xc82
> +#define CSR_HPMCOUNTER3H 0xc83
> +#define CSR_HPMCOUNTER4H 0xc84
> +#define CSR_HPMCOUNTER5H 0xc85
> +#define CSR_HPMCOUNTER6H 0xc86
> +#define CSR_HPMCOUNTER7H 0xc87
> +#define CSR_HPMCOUNTER8H 0xc88
> +#define CSR_HPMCOUNTER9H 0xc89
> +#define CSR_HPMCOUNTER10H 0xc8a
> +#define CSR_HPMCOUNTER11H 0xc8b
> +#define CSR_HPMCOUNTER12H 0xc8c
> +#define CSR_HPMCOUNTER13H 0xc8d
> +#define CSR_HPMCOUNTER14H 0xc8e
> +#define CSR_HPMCOUNTER15H 0xc8f
> +#define CSR_HPMCOUNTER16H 0xc90
> +#define CSR_HPMCOUNTER17H 0xc91
> +#define CSR_HPMCOUNTER18H 0xc92
> +#define CSR_HPMCOUNTER19H 0xc93
> +#define CSR_HPMCOUNTER20H 0xc94
> +#define CSR_HPMCOUNTER21H 0xc95
> +#define CSR_HPMCOUNTER22H 0xc96
> +#define CSR_HPMCOUNTER23H 0xc97
> +#define CSR_HPMCOUNTER24H 0xc98
> +#define CSR_HPMCOUNTER25H 0xc99
> +#define CSR_HPMCOUNTER26H 0xc9a
> +#define CSR_HPMCOUNTER27H 0xc9b
> +#define CSR_HPMCOUNTER28H 0xc9c
> +#define CSR_HPMCOUNTER29H 0xc9d
> +#define CSR_HPMCOUNTER30H 0xc9e
> +#define CSR_HPMCOUNTER31H 0xc9f
> +#define CSR_MCYCLEH 0xb80
> +#define CSR_MINSTRETH 0xb82
> +#define CSR_MHPMCOUNTER3H 0xb83
> +#define CSR_MHPMCOUNTER4H 0xb84
> +#define CSR_MHPMCOUNTER5H 0xb85
> +#define CSR_MHPMCOUNTER6H 0xb86
> +#define CSR_MHPMCOUNTER7H 0xb87
> +#define CSR_MHPMCOUNTER8H 0xb88
> +#define CSR_MHPMCOUNTER9H 0xb89
> +#define CSR_MHPMCOUNTER10H 0xb8a
> +#define CSR_MHPMCOUNTER11H 0xb8b
> +#define CSR_MHPMCOUNTER12H 0xb8c
> +#define CSR_MHPMCOUNTER13H 0xb8d
> +#define CSR_MHPMCOUNTER14H 0xb8e
> +#define CSR_MHPMCOUNTER15H 0xb8f
> +#define CSR_MHPMCOUNTER16H 0xb90
> +#define CSR_MHPMCOUNTER17H 0xb91
> +#define CSR_MHPMCOUNTER18H 0xb92
> +#define CSR_MHPMCOUNTER19H 0xb93
> +#define CSR_MHPMCOUNTER20H 0xb94
> +#define CSR_MHPMCOUNTER21H 0xb95
> +#define CSR_MHPMCOUNTER22H 0xb96
> +#define CSR_MHPMCOUNTER23H 0xb97
> +#define CSR_MHPMCOUNTER24H 0xb98
> +#define CSR_MHPMCOUNTER25H 0xb99
> +#define CSR_MHPMCOUNTER26H 0xb9a
> +#define CSR_MHPMCOUNTER27H 0xb9b
> +#define CSR_MHPMCOUNTER28H 0xb9c
> +#define CSR_MHPMCOUNTER29H 0xb9d
> +#define CSR_MHPMCOUNTER30H 0xb9e
> +#define CSR_MHPMCOUNTER31H 0xb9f
> +
> +/* mstatus bits */
> +#define MSTATUS_UIE         0x00000001
> +#define MSTATUS_SIE         0x00000002
> +#define MSTATUS_HIE         0x00000004
> +#define MSTATUS_MIE         0x00000008
> +#define MSTATUS_UPIE        0x00000010
> +#define MSTATUS_SPIE        0x00000020
> +#define MSTATUS_HPIE        0x00000040
> +#define MSTATUS_MPIE        0x00000080
> +#define MSTATUS_SPP         0x00000100
> +#define MSTATUS_HPP         0x00000600
> +#define MSTATUS_MPP         0x00001800
> +#define MSTATUS_FS          0x00006000
> +#define MSTATUS_XS          0x00018000
> +#define MSTATUS_MPRV        0x00020000
> +#define MSTATUS_PUM         0x00040000 /* until: priv-1.9.1 */
> +#define MSTATUS_SUM         0x00040000 /* since: priv-1.10 */
> +#define MSTATUS_MXR         0x00080000
> +#define MSTATUS_VM          0x1F000000 /* until: priv-1.9.1 */
> +#define MSTATUS_TVM         0x00100000 /* since: priv-1.10 */
> +#define MSTATUS_TW          0x20000000 /* since: priv-1.10 */
> +#define MSTATUS_TSR         0x40000000 /* since: priv-1.10 */
> +
> +#define MSTATUS64_UXL       0x0000000300000000ULL
> +#define MSTATUS64_SXL       0x0000000C00000000ULL
> +
> +#define MSTATUS32_SD        0x80000000
> +#define MSTATUS64_SD        0x8000000000000000ULL
> +
> +#if defined(TARGET_RISCV32)
> +#define MSTATUS_SD MSTATUS32_SD
> +#elif defined(TARGET_RISCV64)
> +#define MSTATUS_SD MSTATUS64_SD
> +#endif
> +
> +/* sstatus bits */
> +#define SSTATUS_UIE         0x00000001
> +#define SSTATUS_SIE         0x00000002
> +#define SSTATUS_UPIE        0x00000010
> +#define SSTATUS_SPIE        0x00000020
> +#define SSTATUS_SPP         0x00000100
> +#define SSTATUS_FS          0x00006000
> +#define SSTATUS_XS          0x00018000
> +#define SSTATUS_PUM         0x00040000 /* until: priv-1.9.1 */
> +#define SSTATUS_SUM         0x00040000 /* since: priv-1.10 */
> +#define SSTATUS_MXR         0x00080000
> +
> +#define SSTATUS32_SD        0x80000000
> +#define SSTATUS64_SD        0x8000000000000000ULL
> +
> +#if defined(TARGET_RISCV32)
> +#define SSTATUS_SD SSTATUS32_SD
> +#elif defined(TARGET_RISCV64)
> +#define SSTATUS_SD SSTATUS64_SD
> +#endif
> +
> +/* irqs */
> +#define MIP_SSIP            (1 << IRQ_S_SOFT)
> +#define MIP_HSIP            (1 << IRQ_H_SOFT)
> +#define MIP_MSIP            (1 << IRQ_M_SOFT)
> +#define MIP_STIP            (1 << IRQ_S_TIMER)
> +#define MIP_HTIP            (1 << IRQ_H_TIMER)
> +#define MIP_MTIP            (1 << IRQ_M_TIMER)
> +#define MIP_SEIP            (1 << IRQ_S_EXT)
> +#define MIP_HEIP            (1 << IRQ_H_EXT)
> +#define MIP_MEIP            (1 << IRQ_M_EXT)
> +
> +#define SIP_SSIP            MIP_SSIP
> +#define SIP_STIP            MIP_STIP
> +#define SIP_SEIP            MIP_SEIP
> +
> +#define PRV_U 0
> +#define PRV_S 1
> +#define PRV_H 2
> +#define PRV_M 3
> +
> +/* privileged ISA 1.9.1 VM modes (mstatus.vm) */
> +#define VM_1_09_MBARE 0
> +#define VM_1_09_MBB   1
> +#define VM_1_09_MBBID 2
> +#define VM_1_09_SV32  8
> +#define VM_1_09_SV39  9
> +#define VM_1_09_SV48  10
> +
> +/* privileged ISA 1.10.0 VM modes (satp.mode) */
> +#define VM_1_10_MBARE 0
> +#define VM_1_10_SV32  1
> +#define VM_1_10_SV39  8
> +#define VM_1_10_SV48  9
> +#define VM_1_10_SV57  10
> +#define VM_1_10_SV64  11
> +
> +/* privileged ISA interrupt causes */
> +#define IRQ_U_SOFT      0  /* since: priv-1.10 */
> +#define IRQ_S_SOFT      1
> +#define IRQ_H_SOFT      2  /* until: priv-1.9.1 */
> +#define IRQ_M_SOFT      3  /* until: priv-1.9.1 */
> +#define IRQ_U_TIMER     4  /* since: priv-1.10 */
> +#define IRQ_S_TIMER     5
> +#define IRQ_H_TIMER     6  /* until: priv-1.9.1 */
> +#define IRQ_M_TIMER     7  /* until: priv-1.9.1 */
> +#define IRQ_U_EXT       8  /* since: priv-1.10 */
> +#define IRQ_S_EXT       9
> +#define IRQ_H_EXT       10 /* until: priv-1.9.1 */
> +#define IRQ_M_EXT       11 /* until: priv-1.9.1 */
> +#define IRQ_X_COP       12 /* non-standard */
> +
> +/* Default addresses */
> +#define DEFAULT_RSTVEC     0x00001000
> +
> +/* RV32 satp field masks */
> +#define SATP32_MODE 0x80000000
> +#define SATP32_ASID 0x7fc00000
> +#define SATP32_PPN  0x003fffff
> +
> +/* RV64 satp field masks */
> +#define SATP64_MODE 0xF000000000000000ULL
> +#define SATP64_ASID 0x0FFFF00000000000ULL
> +#define SATP64_PPN  0x00000FFFFFFFFFFFULL
> +
> +#if defined(TARGET_RISCV32)
> +#define SATP_MODE SATP32_MODE
> +#define SATP_ASID SATP32_ASID
> +#define SATP_PPN  SATP32_PPN
> +#endif
> +#if defined(TARGET_RISCV64)
> +#define SATP_MODE SATP64_MODE
> +#define SATP_ASID SATP64_ASID
> +#define SATP_PPN  SATP64_PPN
> +#endif
> +
> +/* RISCV Exception Codes */
> +#define EXCP_NONE                       -1 /* not a real RISCV exception
> code */
> +#define RISCV_EXCP_INST_ADDR_MIS           0x0
> +#define RISCV_EXCP_INST_ACCESS_FAULT       0x1
> +#define RISCV_EXCP_ILLEGAL_INST            0x2
> +#define RISCV_EXCP_BREAKPOINT              0x3
> +#define RISCV_EXCP_LOAD_ADDR_MIS           0x4
> +#define RISCV_EXCP_LOAD_ACCESS_FAULT       0x5
> +#define RISCV_EXCP_STORE_AMO_ADDR_MIS      0x6
> +#define RISCV_EXCP_STORE_AMO_ACCESS_FAULT  0x7
> +#define RISCV_EXCP_U_ECALL                 0x8 /* for convenience, report
> all
> +                                                  ECALLs as this, handler
> +                                                  fixes */
> +#define RISCV_EXCP_S_ECALL                 0x9
> +#define RISCV_EXCP_H_ECALL                 0xa
> +#define RISCV_EXCP_M_ECALL                 0xb
> +#define RISCV_EXCP_INST_PAGE_FAULT         0xc /* since: priv-1.10.0 */
> +#define RISCV_EXCP_LOAD_PAGE_FAULT         0xd /* since: priv-1.10.0 */
> +#define RISCV_EXCP_STORE_PAGE_FAULT        0xf /* since: priv-1.10.0 */
> +
> +#define RISCV_EXCP_INT_FLAG                0x80000000
> +#define RISCV_EXCP_INT_MASK                0x7fffffff
> +
> +/* page table entry (PTE) fields */
> +#define PTE_V     0x001 /* Valid */
> +#define PTE_R     0x002 /* Read */
> +#define PTE_W     0x004 /* Write */
> +#define PTE_X     0x008 /* Execute */
> +#define PTE_U     0x010 /* User */
> +#define PTE_G     0x020 /* Global */
> +#define PTE_A     0x040 /* Accessed */
> +#define PTE_D     0x080 /* Dirty */
> +#define PTE_SOFT  0x300 /* Reserved for Software */
> +
> +#define PTE_PPN_SHIFT 10
> +
> +#define PTE_TABLE(PTE) (((PTE) & (PTE_V | PTE_R | PTE_W | PTE_X)) ==
> PTE_V)
> --
> 2.7.0
>
>
