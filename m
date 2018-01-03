Received: from eggs.gnu.org ([2001:4830:134:3::10]:49178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eWrYo-0000Ak-KJ
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 17:31:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eWrYm-0002u0-F0
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 17:30:58 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:45031)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eWrYm-0002tB-6P
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 17:30:56 -0500
Received: by mail-oi0-x244.google.com with SMTP id g6so1922817oib.11
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 14:30:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <0a498d8a-e59e-616f-9489-1e874a956341@linaro.org>
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<1514940265-18093-4-git-send-email-mjc@sifive.com>
	<0a498d8a-e59e-616f-9489-1e874a956341@linaro.org>
From: Michael Clark <mjc@sifive.com>
Date: Thu, 4 Jan 2018 11:30:55 +1300
Message-ID: <CAHNT7NtvroDROTOx1VrfO4U3p4udxFknvALVmASdyWe+vk2htg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 03/21] RISC-V CPU Core Definition
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

On Wed, Jan 3, 2018 at 6:21 PM, Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 01/02/2018 04:44 PM, Michael Clark wrote:
> > +#ifdef CONFIG_USER_ONLY
> > +static bool riscv_cpu_has_work(CPUState *cs)
> > +{
> > +    return 0;
> > +}
> > +#else
> > +static bool riscv_cpu_has_work(CPUState *cs)
> > +{
> > +    return cs->interrupt_request & CPU_INTERRUPT_HARD;
> > +}
> > +#endif
>
> There's no need to conditionalize this.


Got it. Will be in the next spin.


> > +static void riscv_cpu_reset(CPUState *cs)
> > +{
> > +    RISCVCPU *cpu = RISCV_CPU(cs);
> > +    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
> > +    CPURISCVState *env = &cpu->env;
> > +
> > +    mcc->parent_reset(cs);
> > +#ifndef CONFIG_USER_ONLY
> > +    tlb_flush(cs);
>
> Flush is now generic.  Remove it from here.


OK.

> +static void riscv_cpu_realize(DeviceState *dev, Error **errp)
> > +{
> > +    CPUState *cs = CPU(dev);
> > +    RISCVCPU *cpu = RISCV_CPU(dev);
> > +    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
> > +    CPURISCVState *env = &cpu->env;
> > +    Error *local_err = NULL;
> > +
> > +    cpu_exec_realizefn(cs, &local_err);
> > +    if (local_err != NULL) {
> > +        error_propagate(errp, local_err);
> > +        return;
> > +    }
> > +
> > +    if (env->misa & RVM) {
> > +        set_feature(env, RISCV_FEATURE_RVM);
> > +    }
>
> What's the point of replicating this information?
>

This is inherited code. I noticed this too. In this version they are
actually in sync with each other, which they weren't several weeks ago :-D

It may well be that the features flags pre-date the addition of the 'misa'
register in the privilege spec.

This will take a bit of re-work as a reasonable amount of code uses the
FEATURE flags vs misa.

Are you happy for this to be a pending work item? I don't like it either
and eventually want to fix, and already did some work to sync it with
'misa', but it's not a critical issue.

> +static void cpu_register(const RISCVCPUInfo *info)
> > +{
> > +    TypeInfo type_info = {
> > +        .name = g_strdup(info->name),
> > +        .parent = TYPE_RISCV_CPU,
> > +        .instance_size = sizeof(RISCVCPU),
> > +        .instance_init = info->initfn,
> > +    };
> > +
> > +    type_register(&type_info);
> > +    g_free((void *)type_info.name);
> > +}
>
> I think type_register does its own strdup; you don't need to do your own.


Got it.


> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > new file mode 100644
> > index 0000000..0480127
> > --- /dev/null
> > +++ b/target/riscv/cpu.h
> > @@ -0,0 +1,363 @@
> > +#ifndef RISCV_CPU_H
>
> Header comment and license?
>
> > +#define TARGET_HAS_ICE 1
>
> What's this for?


It's redundant. Inherited code. Looks like it came from nios2. Will remove.


> > +#define RV(x) (1L << (x - 'A'))
>
> L is useless since the type of long is variable.  Either U or ULL.
>
> > +typedef struct CPURISCVState CPURISCVState;
> > +
> > +#include "pmp.h"
> > +
> > +typedef struct CPURISCVState {
>
> Duplicate typedef.
>

Got it.


> > +    target_ulong gpr[32];
> > +    uint64_t fpr[32]; /* assume both F and D extensions */
> > +    target_ulong pc;
> > +    target_ulong load_res;
> > +
> > +    target_ulong frm;
> > +    target_ulong fstatus;
> > +    target_ulong fflags;
> > +
> > +    target_ulong badaddr;
> > +
> > +    uint32_t mucounteren;
> > +
> > +    target_ulong user_ver;
> > +    target_ulong priv_ver;
> > +    target_ulong misa_mask;
> > +    target_ulong misa;
> > +
> > +#ifdef CONFIG_USER_ONLY
> > +    uint32_t amoinsn;
> > +    target_long amoaddr;
> > +    target_long amotest;
> > +#else
> > +    target_ulong priv;
> > +
> > +    target_ulong mhartid;
> > +    target_ulong mstatus;
> > +    target_ulong mip;
> > +    target_ulong mie;
> > +    target_ulong mideleg;
> > +
> > +    target_ulong sptbr;  /* until: priv-1.9.1 */
> > +    target_ulong satp;   /* since: priv-1.10.0 */
> > +    target_ulong sbadaddr;
> > +    target_ulong mbadaddr;
> > +    target_ulong medeleg;
> > +
> > +    target_ulong stvec;
> > +    target_ulong sepc;
> > +    target_ulong scause;
> > +
> > +    target_ulong mtvec;
> > +    target_ulong mepc;
> > +    target_ulong mcause;
> > +    target_ulong mtval;  /* since: priv-1.10.0 */
> > +
> > +    uint32_t mscounteren;
> > +    target_ulong scounteren; /* since: priv-1.10.0 */
> > +    target_ulong mcounteren; /* since: priv-1.10.0 */
> > +
> > +    target_ulong sscratch;
> > +    target_ulong mscratch;
> > +
> > +    /* temporary htif regs */
> > +    uint64_t mfromhost;
> > +    uint64_t mtohost;
> > +    uint64_t timecmp;
> > +
> > +    /* physical memory protection */
> > +    pmp_table_t pmp_state;
> > +#endif
> > +
> > +    float_status fp_status;
> > +
> > +    /* Internal CPU feature flags. */
> > +    uint64_t features;
> > +
> > +    /* QEMU */
> > +    CPU_COMMON
> > +
> > +    /* Fields from here on are preserved across CPU reset. */
> > +    void *irq[8];
> > +    QEMUTimer *timer; /* Internal timer */
>
> FWIW, other targets have moved this timer to RISCVCPU struct.


I'll look into this. It seems like it should be a simple change and easy to
include in the next spin.

> +static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong
> *pc,
> > +                                        target_ulong *cs_base, uint32_t
> *flags)
> > +{
> > +    *pc = env->pc;
> > +    *cs_base = 0;
> > +    *flags = 0; /* necessary to avoid compiler warning */
>
> Remove the comment -- the assignment is necessary full stop.
>
> > +#define MSTATUS64_UXL       0x0000000300000000
> > +#define MSTATUS64_SXL       0x0000000C00000000
>
> 64-bit constants must use ULL.  Otherwise builds from a 32-bit host will
> fail.
> There are lots more instances within this file.


Got it. Will fix these in the next spin.

Thanks!
