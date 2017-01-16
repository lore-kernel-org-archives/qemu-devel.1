Received: from eggs.gnu.org ([2001:4830:134:3::10]:39281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cTFez-0008Pj-TE
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 17:21:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cTFev-0007Bd-Vt
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 17:21:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:51703)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agraf@suse.de>) id 1cTFev-0007BJ-Ex
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 17:21:49 -0500
References: <20161231132226.9595-1-marex@denx.de>
	<20161231132226.9595-2-marex@denx.de>
From: Alexander Graf <agraf@suse.de>
Message-ID: <37102228-c1e5-e8e5-c4a5-5c9ae186202b@suse.de>
Date: Mon, 16 Jan 2017 23:21:45 +0100
MIME-Version: 1.0
In-Reply-To: <20161231132226.9595-2-marex@denx.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V8 2/7] nios2: Add architecture emulation
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marek Vasut <marex@denx.de>, qemu-devel@nongnu.org
Cc: Jeff Da Silva <jdasilva@altera.com>, Chris Wulff <crwulff@gmail.com>, Sandra Loosemore <sandra@codesourcery.com>, Yves Vandervennet <yvanderv@altera.com>, Ley Foon Tan <lftan@altera.com>



On 31/12/2016 14:22, Marek Vasut wrote:
> From: Chris Wulff <crwulff@gmail.com>
>
> Add support for emulating Altera NiosII R1 architecture into qemu.
> This patch is based on previous work by Chris Wulff from 2012 and
> updated to latest mainline QEMU.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Chris Wulff <crwulff@gmail.com>
> Cc: Jeff Da Silva <jdasilva@altera.com>
> Cc: Ley Foon Tan <lftan@altera.com>
> Cc: Sandra Loosemore <sandra@codesourcery.com>
> Cc: Yves Vandervennet <yvanderv@altera.com>
> ---
> V3: Thorough cleanup, deal with the review comments all over the place
> V4: - Use extract32()
>     - Fix gen_goto_tb() , suppress tcg_gen_goto_tb()
>     - Clean up gen_check_supervisor() helper
>     - Use TCGMemOp type for flags
>     - Drop jump labels from wrctl/rdctl
>     - More TCG cleanup
> V5: - Simplify load/store handling
>     - Handle loads into R_ZERO from protected page, add comment
> V6: - Fix division opcode handling
>     - Add missing disas handling
>     - V5 review comments cleanup
> V7: - Drop newline at the end of file
> V8: - Rebase on top of qemu/master
>     - Move the target-nios2 to target/nios2
> ---
>  target/nios2/Makefile.objs |   4 +
>  target/nios2/cpu.c         | 232 +++++++++++
>  target/nios2/cpu.h         | 269 +++++++++++++
>  target/nios2/helper.c      | 313 +++++++++++++++
>  target/nios2/helper.h      |  27 ++
>  target/nios2/mmu.c         | 292 ++++++++++++++
>  target/nios2/mmu.h         |  54 +++
>  target/nios2/monitor.c     |  35 ++
>  target/nios2/op_helper.c   |  47 +++
>  target/nios2/translate.c   | 953 +++++++++++++++++++++++++++++++++++++++++++++
>  10 files changed, 2226 insertions(+)
>  create mode 100644 target/nios2/Makefile.objs
>  create mode 100644 target/nios2/cpu.c
>  create mode 100644 target/nios2/cpu.h
>  create mode 100644 target/nios2/helper.c
>  create mode 100644 target/nios2/helper.h
>  create mode 100644 target/nios2/mmu.c
>  create mode 100644 target/nios2/mmu.h
>  create mode 100644 target/nios2/monitor.c
>  create mode 100644 target/nios2/op_helper.c
>  create mode 100644 target/nios2/translate.c
>
> diff --git a/target/nios2/Makefile.objs b/target/nios2/Makefile.objs
> new file mode 100644
> index 0000000..2a11c5c
> --- /dev/null
> +++ b/target/nios2/Makefile.objs
> @@ -0,0 +1,4 @@
> +obj-y += translate.o op_helper.o helper.o cpu.o mmu.o
> +obj-$(CONFIG_SOFTMMU) += monitor.o
> +
> +$(obj)/op_helper.o: QEMU_CFLAGS += $(HELPER_CFLAGS)
> diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
> new file mode 100644
> index 0000000..658d684
> --- /dev/null
> +++ b/target/nios2/cpu.c
> @@ -0,0 +1,232 @@
> +/*
> + * QEMU Nios II CPU
> + *
> + * Copyright (c) 2012 Chris Wulff <crwulff@gmail.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see
> + * <http://www.gnu.org/licenses/lgpl-2.1.html>
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "qapi/error.h"
> +#include "cpu.h"
> +#include "exec/log.h"
> +#include "exec/gdbstub.h"
> +#include "hw/qdev-properties.h"
> +
> +static void nios2_cpu_set_pc(CPUState *cs, vaddr value)
> +{
> +    Nios2CPU *cpu = NIOS2_CPU(cs);
> +    CPUNios2State *env = &cpu->env;
> +
> +    env->regs[R_PC] = value;
> +}
> +
> +static bool nios2_cpu_has_work(CPUState *cs)
> +{
> +    return cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
> +}
> +
> +/* CPUClass::reset() */
> +static void nios2_cpu_reset(CPUState *cs)
> +{
> +    Nios2CPU *cpu = NIOS2_CPU(cs);
> +    Nios2CPUClass *ncc = NIOS2_CPU_GET_CLASS(cpu);
> +    CPUNios2State *env = &cpu->env;
> +
> +    if (qemu_loglevel_mask(CPU_LOG_RESET)) {
> +        qemu_log("CPU Reset (CPU %d)\n", cs->cpu_index);
> +        log_cpu_state(cs, 0);
> +    }
> +
> +    ncc->parent_reset(cs);
> +
> +    tlb_flush(cs, 1);
> +
> +    memset(env->regs, 0, sizeof(uint32_t) * NUM_CORE_REGS);
> +    env->regs[R_PC] = cpu->reset_addr;
> +
> +#if defined(CONFIG_USER_ONLY)
> +    /* Start in user mode with interrupts enabled. */
> +    env->regs[CR_STATUS] = CR_STATUS_U | CR_STATUS_PIE;

So what is the value of CR_STATUS after reset in softmmu land then? 
Random value from before reset? Probably not what you want :).

> +#endif
> +}
> +
> +static void nios2_cpu_initfn(Object *obj)
> +{
> +    CPUState *cs = CPU(obj);
> +    Nios2CPU *cpu = NIOS2_CPU(obj);
> +    CPUNios2State *env = &cpu->env;
> +    static bool tcg_initialized;
> +
> +    cpu->mmu_present = true;
> +    cs->env_ptr = env;
> +
> +#if !defined(CONFIG_USER_ONLY)
> +    mmu_init(&env->mmu);
> +#endif
> +
> +    if (tcg_enabled() && !tcg_initialized) {
> +        tcg_initialized = true;
> +        nios2_tcg_init();
> +    }
> +}
> +
> +Nios2CPU *cpu_nios2_init(const char *cpu_model)
> +{
> +    Nios2CPU *cpu = NIOS2_CPU(object_new(TYPE_NIOS2_CPU));
> +
> +    object_property_set_bool(OBJECT(cpu), true, "realized", NULL);
> +
> +    return cpu;
> +}
> +
> +static void nios2_cpu_realizefn(DeviceState *dev, Error **errp)
> +{
> +    CPUState *cs = CPU(dev);
> +    Nios2CPUClass *ncc = NIOS2_CPU_GET_CLASS(dev);
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
> +    ncc->parent_realize(dev, errp);
> +}
> +
> +static bool nios2_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
> +{
> +    Nios2CPU *cpu = NIOS2_CPU(cs);
> +    CPUNios2State *env = &cpu->env;
> +
> +    if ((interrupt_request & CPU_INTERRUPT_HARD) &&
> +        (env->regs[CR_STATUS] & CR_STATUS_PIE)) {
> +        cs->exception_index = EXCP_IRQ;
> +        nios2_cpu_do_interrupt(cs);
> +        return true;
> +    }
> +    return false;
> +}
> +
> +
> +static void nios2_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
> +{
> +    /* NOTE: NiosII R2 is not supported yet. */
> +    info->mach = bfd_arch_nios2;
> +#ifdef TARGET_WORDS_BIGENDIAN
> +    info->print_insn = print_insn_big_nios2;
> +#else
> +    info->print_insn = print_insn_little_nios2;
> +#endif

I take it there is no runtime switch for endianness? Most architectures 
eventually got one and moved to a single default endianness for softmmu 
with swizzling for the "other" one (LE for ARM, BE for ppc).

> +}
> +
> +static int nios2_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
> +{
> +    Nios2CPU *cpu = NIOS2_CPU(cs);
> +    CPUClass *cc = CPU_GET_CLASS(cs);
> +    CPUNios2State *env = &cpu->env;
> +
> +    if (n > cc->gdb_num_core_regs) {
> +        return 0;
> +    }
> +
> +    if (n < 32) {          /* GP regs */
> +        return gdb_get_reg32(mem_buf, env->regs[n]);
> +    } else if (n == 32) {    /* PC */
> +        return gdb_get_reg32(mem_buf, env->regs[R_PC]);
> +    } else if (n < 49) {     /* Status regs */
> +        return gdb_get_reg32(mem_buf, env->regs[n - 1]);
> +    }
> +
> +    /* Invalid regs */
> +    return 0;
> +}
> +
> +static int nios2_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
> +{
> +    Nios2CPU *cpu = NIOS2_CPU(cs);
> +    CPUClass *cc = CPU_GET_CLASS(cs);
> +    CPUNios2State *env = &cpu->env;
> +
> +    if (n > cc->gdb_num_core_regs) {
> +        return 0;
> +    }
> +
> +    if (n < 32) {            /* GP regs */
> +        env->regs[n] = ldl_p(mem_buf);
> +    } else if (n == 32) {    /* PC */
> +        env->regs[R_PC] = ldl_p(mem_buf);
> +    } else if (n < 49) {     /* Status regs */
> +        env->regs[n - 1] = ldl_p(mem_buf);
> +    }
> +
> +    return 4;
> +}
> +
> +static Property nios2_properties[] = {
> +    DEFINE_PROP_BOOL("mmu_present", Nios2CPU, mmu_present, true),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +
> +static void nios2_cpu_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +    CPUClass *cc = CPU_CLASS(oc);
> +    Nios2CPUClass *ncc = NIOS2_CPU_CLASS(oc);
> +
> +    ncc->parent_realize = dc->realize;
> +    dc->realize = nios2_cpu_realizefn;
> +    dc->props = nios2_properties;
> +    ncc->parent_reset = cc->reset;
> +    cc->reset = nios2_cpu_reset;
> +
> +    cc->has_work = nios2_cpu_has_work;
> +    cc->do_interrupt = nios2_cpu_do_interrupt;
> +    cc->cpu_exec_interrupt = nios2_cpu_exec_interrupt;
> +    cc->dump_state = nios2_cpu_dump_state;
> +    cc->set_pc = nios2_cpu_set_pc;
> +    cc->disas_set_info = nios2_cpu_disas_set_info;
> +#ifdef CONFIG_USER_ONLY
> +    cc->handle_mmu_fault = nios2_cpu_handle_mmu_fault;
> +#else
> +    cc->do_unaligned_access = nios2_cpu_do_unaligned_access;
> +    cc->get_phys_page_debug = nios2_cpu_get_phys_page_debug;
> +#endif
> +    cc->gdb_read_register = nios2_cpu_gdb_read_register;
> +    cc->gdb_write_register = nios2_cpu_gdb_write_register;
> +    cc->gdb_num_core_regs = 49;
> +}
> +
> +static const TypeInfo nios2_cpu_type_info = {
> +    .name = TYPE_NIOS2_CPU,
> +    .parent = TYPE_CPU,
> +    .instance_size = sizeof(Nios2CPU),
> +    .instance_init = nios2_cpu_initfn,
> +    .class_size = sizeof(Nios2CPUClass),
> +    .class_init = nios2_cpu_class_init,
> +};
> +
> +static void nios2_cpu_register_types(void)
> +{
> +    type_register_static(&nios2_cpu_type_info);
> +}
> +
> +type_init(nios2_cpu_register_types)
> diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
> new file mode 100644
> index 0000000..91e73af
> --- /dev/null
> +++ b/target/nios2/cpu.h
> @@ -0,0 +1,269 @@
> +/*
> + * Altera Nios II virtual CPU header
> + *
> + * Copyright (c) 2012 Chris Wulff <crwulff@gmail.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see
> + * <http://www.gnu.org/licenses/lgpl-2.1.html>
> + */
> +#ifndef CPU_NIOS2_H
> +#define CPU_NIOS2_H
> +
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +
> +#define TARGET_LONG_BITS 32
> +
> +#define CPUArchState struct CPUNios2State
> +
> +#include "exec/cpu-defs.h"
> +#include "fpu/softfloat.h"
> +#include "qom/cpu.h"
> +struct CPUNios2State;
> +typedef struct CPUNios2State CPUNios2State;
> +#if !defined(CONFIG_USER_ONLY)
> +#include "mmu.h"
> +#endif
> +
> +#define TYPE_NIOS2_CPU "nios2-cpu"
> +
> +#define NIOS2_CPU_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(Nios2CPUClass, (klass), TYPE_NIOS2_CPU)
> +#define NIOS2_CPU(obj) \
> +    OBJECT_CHECK(Nios2CPU, (obj), TYPE_NIOS2_CPU)
> +#define NIOS2_CPU_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(Nios2CPUClass, (obj), TYPE_NIOS2_CPU)
> +
> +/**
> + * Nios2CPUClass:
> + * @parent_reset: The parent class' reset handler.
> + *
> + * A Nios2 CPU model.
> + */
> +typedef struct Nios2CPUClass {
> +    /*< private >*/
> +    CPUClass parent_class;
> +    /*< public >*/
> +
> +    DeviceRealize parent_realize;
> +    void (*parent_reset)(CPUState *cpu);
> +} Nios2CPUClass;
> +
> +#define TARGET_HAS_ICE 1
> +
> +/* Configuration options for Nios II */
> +#define RESET_ADDRESS         0x00000000
> +#define EXCEPTION_ADDRESS     0x00000004
> +#define FAST_TLB_MISS_ADDRESS 0x00000008
> +
> +
> +/* GP regs + CR regs + PC */
> +#define NUM_CORE_REGS (32 + 32 + 1)
> +
> +/* General purpose register aliases */
> +#define R_ZERO   0
> +#define R_AT     1
> +#define R_RET0   2
> +#define R_RET1   3
> +#define R_ARG0   4
> +#define R_ARG1   5
> +#define R_ARG2   6
> +#define R_ARG3   7
> +#define R_ET     24
> +#define R_BT     25
> +#define R_GP     26
> +#define R_SP     27
> +#define R_FP     28
> +#define R_EA     29
> +#define R_BA     30
> +#define R_RA     31
> +
> +/* Control register aliases */
> +#define CR_BASE  32
> +#define CR_STATUS    (CR_BASE + 0)
> +#define   CR_STATUS_PIE  (1 << 0)
> +#define   CR_STATUS_U    (1 << 1)
> +#define   CR_STATUS_EH   (1 << 2)
> +#define   CR_STATUS_IH   (1 << 3)
> +#define   CR_STATUS_IL   (63 << 4)
> +#define   CR_STATUS_CRS  (63 << 10)
> +#define   CR_STATUS_PRS  (63 << 16)
> +#define   CR_STATUS_NMI  (1 << 22)
> +#define   CR_STATUS_RSIE (1 << 23)
> +#define CR_ESTATUS   (CR_BASE + 1)
> +#define CR_BSTATUS   (CR_BASE + 2)
> +#define CR_IENABLE   (CR_BASE + 3)
> +#define CR_IPENDING  (CR_BASE + 4)
> +#define CR_CPUID     (CR_BASE + 5)
> +#define CR_CTL6      (CR_BASE + 6)
> +#define CR_EXCEPTION (CR_BASE + 7)
> +#define CR_PTEADDR   (CR_BASE + 8)
> +#define   CR_PTEADDR_PTBASE_SHIFT 22
> +#define   CR_PTEADDR_PTBASE_MASK  (0x3FF << CR_PTEADDR_PTBASE_SHIFT)
> +#define   CR_PTEADDR_VPN_SHIFT    2
> +#define   CR_PTEADDR_VPN_MASK     (0xFFFFF << CR_PTEADDR_VPN_SHIFT)
> +#define CR_TLBACC    (CR_BASE + 9)
> +#define   CR_TLBACC_IGN_SHIFT 25
> +#define   CR_TLBACC_IGN_MASK  (0x7F << CR_TLBACC_IGN_SHIFT)
> +#define   CR_TLBACC_C         (1 << 24)
> +#define   CR_TLBACC_R         (1 << 23)
> +#define   CR_TLBACC_W         (1 << 22)
> +#define   CR_TLBACC_X         (1 << 21)
> +#define   CR_TLBACC_G         (1 << 20)
> +#define   CR_TLBACC_PFN_MASK  0x000FFFFF
> +#define CR_TLBMISC   (CR_BASE + 10)
> +#define   CR_TLBMISC_WAY_SHIFT 20
> +#define   CR_TLBMISC_WAY_MASK  (0xF << CR_TLBMISC_WAY_SHIFT)
> +#define   CR_TLBMISC_RD        (1 << 19)
> +#define   CR_TLBMISC_WR        (1 << 18)
> +#define   CR_TLBMISC_PID_SHIFT 4
> +#define   CR_TLBMISC_PID_MASK  (0x3FFF << CR_TLBMISC_PID_SHIFT)
> +#define   CR_TLBMISC_DBL       (1 << 3)
> +#define   CR_TLBMISC_BAD       (1 << 2)
> +#define   CR_TLBMISC_PERM      (1 << 1)
> +#define   CR_TLBMISC_D         (1 << 0)
> +#define CR_ENCINJ    (CR_BASE + 11)
> +#define CR_BADADDR   (CR_BASE + 12)
> +#define CR_CONFIG    (CR_BASE + 13)
> +#define CR_MPUBASE   (CR_BASE + 14)
> +#define CR_MPUACC    (CR_BASE + 15)
> +
> +/* Other registers */
> +#define R_PC         64
> +
> +/* Exceptions */
> +#define EXCP_BREAK    -1
> +#define EXCP_RESET    0
> +#define EXCP_PRESET   1
> +#define EXCP_IRQ      2
> +#define EXCP_TRAP     3
> +#define EXCP_UNIMPL   4
> +#define EXCP_ILLEGAL  5
> +#define EXCP_UNALIGN  6
> +#define EXCP_UNALIGND 7
> +#define EXCP_DIV      8
> +#define EXCP_SUPERA   9
> +#define EXCP_SUPERI   10
> +#define EXCP_SUPERD   11
> +#define EXCP_TLBD     12
> +#define EXCP_TLBX     13
> +#define EXCP_TLBR     14
> +#define EXCP_TLBW     15
> +#define EXCP_MPUI     16
> +#define EXCP_MPUD     17
> +
> +#define CPU_INTERRUPT_NMI       CPU_INTERRUPT_TGT_EXT_3
> +
> +#define NB_MMU_MODES 2
> +
> +struct CPUNios2State {
> +    uint32_t regs[NUM_CORE_REGS];
> +
> +#if !defined(CONFIG_USER_ONLY)
> +    Nios2MMU mmu;
> +
> +    uint32_t irq_pending;
> +#endif
> +
> +    CPU_COMMON
> +};
> +
> +/**
> + * Nios2CPU:
> + * @env: #CPUNios2State
> + *
> + * A Nios2 CPU.
> + */
> +typedef struct Nios2CPU {
> +    /*< private >*/
> +    CPUState parent_obj;
> +    /*< public >*/
> +
> +    CPUNios2State env;
> +    bool mmu_present;
> +
> +    /* Addresses that are hard-coded in the FPGA build settings */
> +    uint32_t reset_addr;
> +    uint32_t exception_addr;
> +    uint32_t fast_tlb_miss_addr;
> +} Nios2CPU;
> +
> +static inline Nios2CPU *nios2_env_get_cpu(CPUNios2State *env)
> +{
> +    return NIOS2_CPU(container_of(env, Nios2CPU, env));
> +}
> +
> +#define ENV_GET_CPU(e) CPU(nios2_env_get_cpu(e))
> +
> +#define ENV_OFFSET offsetof(Nios2CPU, env)
> +
> +void nios2_tcg_init(void);
> +Nios2CPU *cpu_nios2_init(const char *cpu_model);
> +void nios2_cpu_do_interrupt(CPUState *cs);
> +int cpu_nios2_signal_handler(int host_signum, void *pinfo, void *puc);
> +void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUNios2State *env);
> +void nios2_cpu_dump_state(CPUState *cpu, FILE *f, fprintf_function cpu_fprintf,
> +                          int flags);
> +hwaddr nios2_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
> +void nios2_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
> +                                   MMUAccessType access_type,
> +                                   int mmu_idx, uintptr_t retaddr);
> +
> +qemu_irq *nios2_cpu_pic_init(Nios2CPU *cpu);
> +void nios2_check_interrupts(CPUNios2State *env);
> +
> +#define TARGET_PHYS_ADDR_SPACE_BITS 32
> +#define TARGET_VIRT_ADDR_SPACE_BITS 32
> +
> +#define cpu_init(cpu_model) CPU(cpu_nios2_init(cpu_model))
> +
> +#define cpu_gen_code cpu_nios2_gen_code
> +#define cpu_signal_handler cpu_nios2_signal_handler
> +
> +#define CPU_SAVE_VERSION 1
> +
> +#define TARGET_PAGE_BITS 12
> +
> +/* MMU modes definitions */
> +#define MMU_MODE0_SUFFIX _kernel
> +#define MMU_MODE1_SUFFIX _user
> +#define MMU_SUPERVISOR_IDX  0
> +#define MMU_USER_IDX        1
> +
> +static inline int cpu_mmu_index(CPUNios2State *env, bool ifetch)
> +{
> +    return (env->regs[CR_STATUS] & CR_STATUS_U) ? MMU_USER_IDX :
> +                                                  MMU_SUPERVISOR_IDX;
> +}
> +
> +int nios2_cpu_handle_mmu_fault(CPUState *env, vaddr address,
> +                               int rw, int mmu_idx);
> +
> +static inline int cpu_interrupts_enabled(CPUNios2State *env)
> +{
> +    return env->regs[CR_STATUS] & CR_STATUS_PIE;
> +}
> +
> +#include "exec/cpu-all.h"
> +#include "exec/exec-all.h"
> +
> +static inline void cpu_get_tb_cpu_state(CPUNios2State *env, target_ulong *pc,
> +                                        target_ulong *cs_base, uint32_t *flags)
> +{
> +    *pc = env->regs[R_PC];
> +    *cs_base = 0;
> +    *flags = (env->regs[CR_STATUS] & (CR_STATUS_EH | CR_STATUS_U));
> +}
> +
> +#endif /* CPU_NIOS2_H */
> diff --git a/target/nios2/helper.c b/target/nios2/helper.c
> new file mode 100644
> index 0000000..cd4f353
> --- /dev/null
> +++ b/target/nios2/helper.c
> @@ -0,0 +1,313 @@
> +/*
> + * Altera Nios II helper routines.
> + *
> + * Copyright (c) 2012 Chris Wulff <crwulff@gmail.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see
> + * <http://www.gnu.org/licenses/lgpl-2.1.html>
> + */
> +
> +#include <stdio.h>
> +#include <string.h>
> +#include <assert.h>
> +
> +#include "cpu.h"
> +#include "qemu/osdep.h"
> +#include "qemu/host-utils.h"
> +#include "qapi/error.h"
> +#include "exec/exec-all.h"
> +#include "exec/log.h"
> +#include "exec/helper-proto.h"
> +
> +#if defined(CONFIG_USER_ONLY)
> +
> +void nios2_cpu_do_interrupt(CPUState *cs)
> +{
> +    Nios2CPU *cpu = NIOS2_CPU(cs);
> +    CPUNios2State *env = &cpu->env;
> +    cs->exception_index = -1;
> +    env->regs[R_EA] = env->regs[R_PC] + 4;
> +}
> +
> +int nios2_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int rw, int mmu_idx)
> +{
> +    cs->exception_index = 0xaa;
> +    /* Page 0x1000 is kuser helper */
> +    if (address < 0x1000 || address >= 0x2000) {
> +        cpu_dump_state(cs, stderr, fprintf, 0);
> +    }
> +    return 1;
> +}
> +
> +#else /* !CONFIG_USER_ONLY */
> +
> +void nios2_cpu_do_interrupt(CPUState *cs)
> +{
> +    Nios2CPU *cpu = NIOS2_CPU(cs);
> +    CPUNios2State *env = &cpu->env;
> +
> +    switch (cs->exception_index) {
> +    case EXCP_IRQ:
> +        assert(env->regs[CR_STATUS] & CR_STATUS_PIE);
> +
> +        qemu_log_mask(CPU_LOG_INT, "interrupt at pc=%x\n", env->regs[R_PC]);
> +
> +        env->regs[CR_ESTATUS] = env->regs[CR_STATUS];
> +        env->regs[CR_STATUS] |= CR_STATUS_IH;
> +        env->regs[CR_STATUS] &= ~(CR_STATUS_PIE | CR_STATUS_U);
> +
> +        env->regs[CR_EXCEPTION] &= ~(0x1F << 2);
> +        env->regs[CR_EXCEPTION] |= (cs->exception_index & 0x1F) << 2;
> +
> +        env->regs[R_EA] = env->regs[R_PC] + 4;
> +        env->regs[R_PC] = cpu->exception_addr;
> +        break;
> +
> +    case EXCP_TLBD:
> +        if ((env->regs[CR_STATUS] & CR_STATUS_EH) == 0) {
> +            qemu_log_mask(CPU_LOG_INT, "TLB MISS (fast) at pc=%x\n",
> +                          env->regs[R_PC]);
> +
> +            /* Fast TLB miss */
> +            /* Variation from the spec. Table 3-35 of the cpu reference shows
> +             * estatus not being changed for TLB miss but this appears to
> +             * be incorrect. */
> +            env->regs[CR_ESTATUS] = env->regs[CR_STATUS];
> +            env->regs[CR_STATUS] |= CR_STATUS_EH;
> +            env->regs[CR_STATUS] &= ~(CR_STATUS_PIE | CR_STATUS_U);
> +
> +            env->regs[CR_EXCEPTION] &= ~(0x1F << 2);
> +            env->regs[CR_EXCEPTION] |= (cs->exception_index & 0x1F) << 2;
> +
> +            env->regs[CR_TLBMISC] &= ~CR_TLBMISC_DBL;
> +            env->regs[CR_TLBMISC] |= CR_TLBMISC_WR;
> +
> +            env->regs[R_EA] = env->regs[R_PC] + 4;
> +            env->regs[R_PC] = cpu->fast_tlb_miss_addr;
> +        } else {
> +            qemu_log_mask(CPU_LOG_INT, "TLB MISS (double) at pc=%x\n",
> +                          env->regs[R_PC]);
> +
> +            /* Double TLB miss */
> +            env->regs[CR_STATUS] |= CR_STATUS_EH;
> +            env->regs[CR_STATUS] &= ~(CR_STATUS_PIE | CR_STATUS_U);
> +
> +            env->regs[CR_EXCEPTION] &= ~(0x1F << 2);
> +            env->regs[CR_EXCEPTION] |= (cs->exception_index & 0x1F) << 2;
> +
> +            env->regs[CR_TLBMISC] |= CR_TLBMISC_DBL;
> +
> +            env->regs[R_PC] = cpu->exception_addr;
> +        }
> +        break;
> +
> +    case EXCP_TLBR:
> +    case EXCP_TLBW:
> +    case EXCP_TLBX:
> +        qemu_log_mask(CPU_LOG_INT, "TLB PERM at pc=%x\n", env->regs[R_PC]);
> +
> +        env->regs[CR_ESTATUS] = env->regs[CR_STATUS];
> +        env->regs[CR_STATUS] |= CR_STATUS_EH;
> +        env->regs[CR_STATUS] &= ~(CR_STATUS_PIE | CR_STATUS_U);
> +
> +        env->regs[CR_EXCEPTION] &= ~(0x1F << 2);
> +        env->regs[CR_EXCEPTION] |= (cs->exception_index & 0x1F) << 2;
> +
> +        if ((env->regs[CR_STATUS] & CR_STATUS_EH) == 0) {
> +            env->regs[CR_TLBMISC] |= CR_TLBMISC_WR;
> +        }
> +
> +        env->regs[R_EA] = env->regs[R_PC] + 4;
> +        env->regs[R_PC] = cpu->exception_addr;
> +        break;
> +
> +    case EXCP_SUPERA:
> +    case EXCP_SUPERI:
> +    case EXCP_SUPERD:
> +        qemu_log_mask(CPU_LOG_INT, "SUPERVISOR exception at pc=%x\n",
> +                      env->regs[R_PC]);
> +
> +        if ((env->regs[CR_STATUS] & CR_STATUS_EH) == 0) {
> +            env->regs[CR_ESTATUS] = env->regs[CR_STATUS];
> +            env->regs[R_EA] = env->regs[R_PC] + 4;
> +        }
> +
> +        env->regs[CR_STATUS] |= CR_STATUS_EH;
> +        env->regs[CR_STATUS] &= ~(CR_STATUS_PIE | CR_STATUS_U);
> +
> +        env->regs[CR_EXCEPTION] &= ~(0x1F << 2);
> +        env->regs[CR_EXCEPTION] |= (cs->exception_index & 0x1F) << 2;
> +
> +        env->regs[R_PC] = cpu->exception_addr;
> +        break;
> +
> +    case EXCP_ILLEGAL:
> +    case EXCP_TRAP:
> +        qemu_log_mask(CPU_LOG_INT, "TRAP exception at pc=%x\n",
> +                      env->regs[R_PC]);
> +
> +        if ((env->regs[CR_STATUS] & CR_STATUS_EH) == 0) {
> +            env->regs[CR_ESTATUS] = env->regs[CR_STATUS];
> +            env->regs[R_EA] = env->regs[R_PC] + 4;
> +        }
> +
> +        env->regs[CR_STATUS] |= CR_STATUS_EH;
> +        env->regs[CR_STATUS] &= ~(CR_STATUS_PIE | CR_STATUS_U);
> +
> +        env->regs[CR_EXCEPTION] &= ~(0x1F << 2);
> +        env->regs[CR_EXCEPTION] |= (cs->exception_index & 0x1F) << 2;
> +
> +        env->regs[R_PC] = cpu->exception_addr;
> +        break;
> +
> +    case EXCP_BREAK:
> +        if ((env->regs[CR_STATUS] & CR_STATUS_EH) == 0) {
> +            env->regs[CR_BSTATUS] = env->regs[CR_STATUS];
> +            env->regs[R_BA] = env->regs[R_PC] + 4;
> +        }
> +
> +        env->regs[CR_STATUS] |= CR_STATUS_EH;
> +        env->regs[CR_STATUS] &= ~(CR_STATUS_PIE | CR_STATUS_U);
> +
> +        env->regs[CR_EXCEPTION] &= ~(0x1F << 2);
> +        env->regs[CR_EXCEPTION] |= (cs->exception_index & 0x1F) << 2;
> +
> +        env->regs[R_PC] = cpu->exception_addr;
> +        break;
> +
> +    default:
> +        cpu_abort(cs, "unhandled exception type=%d\n",
> +                  cs->exception_index);
> +        break;
> +    }
> +}
> +
> +static int cpu_nios2_handle_virtual_page(
> +    CPUState *cs, target_ulong address, int rw, int mmu_idx)
> +{
> +    Nios2CPU *cpu = NIOS2_CPU(cs);
> +    CPUNios2State *env = &cpu->env;
> +    target_ulong vaddr, paddr;
> +    Nios2MMULookup lu;
> +    unsigned int hit;
> +    hit = mmu_translate(env, &lu, address, rw, mmu_idx);
> +    if (hit) {
> +        vaddr = address & TARGET_PAGE_MASK;
> +        paddr = lu.paddr + vaddr - lu.vaddr;
> +
> +        if (((rw == 0) && (lu.prot & PAGE_READ)) ||
> +            ((rw == 1) && (lu.prot & PAGE_WRITE)) ||
> +            ((rw == 2) && (lu.prot & PAGE_EXEC))) {
> +
> +            tlb_set_page(cs, vaddr, paddr, lu.prot,
> +                         mmu_idx, TARGET_PAGE_SIZE);
> +            return 0;
> +        } else {
> +            /* Permission violation */
> +            cs->exception_index = (rw == 0) ? EXCP_TLBR :
> +                                               ((rw == 1) ? EXCP_TLBW :
> +                                                            EXCP_TLBX);
> +        }
> +    } else {
> +        cs->exception_index = EXCP_TLBD;
> +    }
> +
> +    if (rw == 2) {
> +        env->regs[CR_TLBMISC] &= ~CR_TLBMISC_D;
> +    } else {
> +        env->regs[CR_TLBMISC] |= CR_TLBMISC_D;
> +    }
> +    env->regs[CR_PTEADDR] &= CR_PTEADDR_PTBASE_MASK;
> +    env->regs[CR_PTEADDR] |= (address >> 10) & CR_PTEADDR_VPN_MASK;
> +    env->mmu.pteaddr_wr = env->regs[CR_PTEADDR];
> +    env->regs[CR_BADADDR] = address;
> +    return 1;
> +}
> +
> +int nios2_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int rw, int mmu_idx)
> +{
> +    Nios2CPU *cpu = NIOS2_CPU(cs);
> +    CPUNios2State *env = &cpu->env;
> +
> +    if (cpu->mmu_present) {
> +        if (MMU_SUPERVISOR_IDX == mmu_idx) {
> +            if (address >= 0xC0000000) {
> +                /* Kernel physical page - TLB bypassed */
> +                address &= TARGET_PAGE_MASK;
> +                tlb_set_page(cs, address, address, PAGE_BITS,
> +                             mmu_idx, TARGET_PAGE_SIZE);
> +            } else if (address >= 0x80000000) {
> +                /* Kernel virtual page */
> +                return cpu_nios2_handle_virtual_page(cs, address, rw, mmu_idx);
> +            } else {
> +                /* User virtual page */
> +                return cpu_nios2_handle_virtual_page(cs, address, rw, mmu_idx);
> +            }
> +        } else {
> +            if (address >= 0x80000000) {
> +                /* Illegal access from user mode */
> +                cs->exception_index = EXCP_SUPERA;
> +                env->regs[CR_BADADDR] = address;
> +                return 1;
> +            } else {
> +                /* User virtual page */
> +                return cpu_nios2_handle_virtual_page(cs, address, rw, mmu_idx);
> +            }
> +        }
> +    } else {
> +        /* No MMU */
> +        address &= TARGET_PAGE_MASK;
> +        tlb_set_page(cs, address, address, PAGE_BITS,
> +                     mmu_idx, TARGET_PAGE_SIZE);
> +    }
> +
> +    return 0;
> +}
> +
> +hwaddr nios2_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
> +{
> +    Nios2CPU *cpu = NIOS2_CPU(cs);
> +    CPUNios2State *env = &cpu->env;
> +    target_ulong vaddr, paddr = 0;
> +    Nios2MMULookup lu;
> +    unsigned int hit;
> +
> +    if (cpu->mmu_present && (addr < 0xC0000000)) {
> +        hit = mmu_translate(env, &lu, addr, 0, 0);
> +        if (hit) {
> +            vaddr = addr & TARGET_PAGE_MASK;
> +            paddr = lu.paddr + vaddr - lu.vaddr;
> +        } else {
> +            paddr = -1;
> +            qemu_log("cpu_get_phys_page debug MISS: %08lX\n", addr);
> +        }
> +    } else {
> +        paddr = addr & TARGET_PAGE_MASK;
> +    }
> +
> +    return paddr;
> +}
> +
> +void nios2_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
> +                                   MMUAccessType access_type,
> +                                   int mmu_idx, uintptr_t retaddr)
> +{
> +    Nios2CPU *cpu = NIOS2_CPU(cs);
> +    CPUNios2State *env = &cpu->env;
> +
> +    env->regs[CR_BADADDR] = addr;
> +    env->regs[CR_EXCEPTION] = EXCP_UNALIGN << 2;
> +    helper_raise_exception(env, EXCP_UNALIGN);
> +}
> +#endif /* !CONFIG_USER_ONLY */
> diff --git a/target/nios2/helper.h b/target/nios2/helper.h
> new file mode 100644
> index 0000000..b86a2f2
> --- /dev/null
> +++ b/target/nios2/helper.h
> @@ -0,0 +1,27 @@
> +/*
> + * Altera Nios II helper routines header.
> + *
> + * Copyright (c) 2012 Chris Wulff <crwulff@gmail.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see
> + * <http://www.gnu.org/licenses/lgpl-2.1.html>
> + */
> +
> +DEF_HELPER_2(raise_exception, void, env, i32)
> +
> +#if !defined(CONFIG_USER_ONLY)
> +DEF_HELPER_2(mmu_read, i32, env, i32)
> +DEF_HELPER_3(mmu_write, void, env, i32, i32)
> +DEF_HELPER_1(check_interrupts, void, env)
> +#endif
> diff --git a/target/nios2/mmu.c b/target/nios2/mmu.c
> new file mode 100644
> index 0000000..875fbb0
> --- /dev/null
> +++ b/target/nios2/mmu.c
> @@ -0,0 +1,292 @@
> +/*
> + * Altera Nios II MMU emulation for qemu.
> + *
> + * Copyright (C) 2012 Chris Wulff <crwulff@gmail.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see
> + * <http://www.gnu.org/licenses/lgpl-2.1.html>
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "cpu.h"
> +#include "exec/exec-all.h"
> +#include "mmu.h"
> +
> +#if !defined(CONFIG_USER_ONLY)
> +
> +/* Define this to enable MMU debug messages */
> +/* #define DEBUG_MMU */
> +
> +#ifdef DEBUG_MMU
> +#define MMU_LOG(x) x
> +#else
> +#define MMU_LOG(x)
> +#endif
> +
> +void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
> +              int mmu_idx, uintptr_t retaddr)
> +{
> +    int ret;
> +
> +    ret = nios2_cpu_handle_mmu_fault(cs, addr, access_type, mmu_idx);
> +    if (unlikely(ret)) {
> +        if (retaddr) {
> +            /* now we have a real cpu fault */
> +            cpu_restore_state(cs, retaddr);
> +        }
> +        cpu_loop_exit(cs);
> +    }
> +}
> +
> +uint32_t mmu_read(CPUNios2State *env, uint32_t rn)
> +{
> +    switch (rn) {
> +    case CR_TLBACC:
> +        MMU_LOG(qemu_log("TLBACC READ %08X\n", env->regs[rn]));
> +        break;
> +
> +    case CR_TLBMISC:
> +        MMU_LOG(qemu_log("TLBMISC READ %08X\n", env->regs[rn]));
> +        break;
> +
> +    case CR_PTEADDR:
> +        MMU_LOG(qemu_log("PTEADDR READ %08X\n", env->regs[rn]));
> +        break;
> +
> +    default:
> +        break;
> +    }
> +    return env->regs[rn];

This function should get split into a logging function (which is a 
helper and translated in conditionally depending on your debug define) 
and a TCG register for the actual read.

> +}
> +
> +/* rw - 0 = read, 1 = write, 2 = fetch.  */
> +unsigned int mmu_translate(CPUNios2State *env,
> +                           Nios2MMULookup *lu,
> +                           target_ulong vaddr, int rw, int mmu_idx)
> +{
> +    int pid = (env->mmu.tlbmisc_wr & CR_TLBMISC_PID_MASK) >> 4;
> +    int vpn = vaddr >> 12;
> +
> +    MMU_LOG(qemu_log("mmu_translate vaddr %08X, pid %08X, vpn %08X\n",
> +                     vaddr, pid, vpn));
> +
> +    int way;
> +    for (way = 0; way < env->mmu.tlb_num_ways; way++) {
> +
> +        Nios2TLBEntry *entry =
> +            &env->mmu.tlb[(way * env->mmu.tlb_num_ways) +
> +                          (vpn & env->mmu.tlb_entry_mask)];
> +
> +        MMU_LOG(qemu_log("TLB[%d] TAG %08X, VPN %08X\n",
> +                         (way * env->mmu.tlb_num_ways) +
> +                         (vpn & env->mmu.tlb_entry_mask),
> +                         entry->tag, (entry->tag >> 12)));
> +
> +        if (((entry->tag >> 12) != vpn) ||
> +            (((entry->tag & (1 << 11)) == 0) &&
> +            ((entry->tag & ((1 << env->mmu.pid_bits) - 1)) != pid))) {
> +            continue;
> +        }
> +        lu->vaddr = vaddr & TARGET_PAGE_MASK;
> +        lu->paddr = (entry->data & CR_TLBACC_PFN_MASK) << TARGET_PAGE_BITS;
> +        lu->prot = ((entry->data & CR_TLBACC_R) ? PAGE_READ : 0) |
> +                   ((entry->data & CR_TLBACC_W) ? PAGE_WRITE : 0) |
> +                   ((entry->data & CR_TLBACC_X) ? PAGE_EXEC : 0);
> +
> +        MMU_LOG(qemu_log("HIT TLB[%d] %08X %08X %08X\n",
> +                         (way * env->mmu.tlb_num_ways) +
> +                         (vpn & env->mmu.tlb_entry_mask),
> +                         lu->vaddr, lu->paddr, lu->prot));
> +        return 1;
> +    }
> +    return 0;
> +}
> +
> +static void mmu_flush_pid(CPUNios2State *env, uint32_t pid)
> +{
> +    CPUState *cs = ENV_GET_CPU(env);
> +    int idx;
> +    MMU_LOG(qemu_log("TLB Flush PID %d\n", pid));
> +
> +    for (idx = 0; idx < env->mmu.tlb_num_entries; idx++) {
> +        Nios2TLBEntry *entry = &env->mmu.tlb[idx];
> +
> +        MMU_LOG(qemu_log("TLB[%d] => %08X %08X\n",
> +                         idx, entry->tag, entry->data));
> +
> +        if ((entry->tag & (1 << 10)) && (!(entry->tag & (1 << 11))) &&
> +            ((entry->tag & ((1 << env->mmu.pid_bits) - 1)) == pid)) {
> +            uint32_t vaddr = entry->tag & TARGET_PAGE_MASK;
> +
> +            MMU_LOG(qemu_log("TLB Flush Page %08X\n", vaddr));
> +
> +            tlb_flush_page(cs, vaddr);
> +        }
> +    }
> +}
> +
> +void mmu_write(CPUNios2State *env, uint32_t rn, uint32_t v)
> +{
> +    CPUState *cs = ENV_GET_CPU(env);
> +
> +    MMU_LOG(qemu_log("mmu_write %08X = %08X\n", rn, v));
> +
> +    switch (rn) {
> +    case CR_TLBACC:
> +        MMU_LOG(qemu_log("TLBACC: IG %02X, FLAGS %c%c%c%c%c, PFN %05X\n",
> +                         v >> CR_TLBACC_IGN_SHIFT,
> +                         (v & CR_TLBACC_C) ? 'C' : '.',
> +                         (v & CR_TLBACC_R) ? 'R' : '.',
> +                         (v & CR_TLBACC_W) ? 'W' : '.',
> +                         (v & CR_TLBACC_X) ? 'X' : '.',
> +                         (v & CR_TLBACC_G) ? 'G' : '.',
> +                         v & CR_TLBACC_PFN_MASK));
> +
> +        /* if tlbmisc.WE == 1 then trigger a TLB write on writes to TLBACC */
> +        if (env->regs[CR_TLBMISC] & CR_TLBMISC_WR) {
> +            int way = (env->regs[CR_TLBMISC] >> CR_TLBMISC_WAY_SHIFT);
> +            int vpn = (env->mmu.pteaddr_wr & CR_PTEADDR_VPN_MASK) >> 2;
> +            int pid = (env->mmu.tlbmisc_wr & CR_TLBMISC_PID_MASK) >> 4;
> +            int g = (v & CR_TLBACC_G) ? 1 : 0;
> +            int valid = ((vpn & CR_TLBACC_PFN_MASK) < 0xC0000) ? 1 : 0;
> +            Nios2TLBEntry *entry =
> +                &env->mmu.tlb[(way * env->mmu.tlb_num_ways) +
> +                              (vpn & env->mmu.tlb_entry_mask)];
> +            uint32_t newTag = (vpn << 12) | (g << 11) | (valid << 10) | pid;
> +            uint32_t newData = v & (CR_TLBACC_C | CR_TLBACC_R | CR_TLBACC_W |
> +                                    CR_TLBACC_X | CR_TLBACC_PFN_MASK);
> +
> +            if ((entry->tag != newTag) || (entry->data != newData)) {
> +                if (entry->tag & (1 << 10)) {
> +                    /* Flush existing entry */
> +                    MMU_LOG(qemu_log("TLB Flush Page (OLD) %08X\n",
> +                                     entry->tag & TARGET_PAGE_MASK));
> +                    tlb_flush_page(cs, entry->tag & TARGET_PAGE_MASK);
> +                }
> +                entry->tag = newTag;
> +                entry->data = newData;
> +                MMU_LOG(qemu_log("TLB[%d] = %08X %08X\n",
> +                                 (way * env->mmu.tlb_num_ways) +
> +                                 (vpn & env->mmu.tlb_entry_mask),
> +                                 entry->tag, entry->data));
> +            }
> +            /* Auto-increment tlbmisc.WAY */
> +            env->regs[CR_TLBMISC] =
> +                (env->regs[CR_TLBMISC] & ~CR_TLBMISC_WAY_MASK) |
> +                (((way + 1) & (env->mmu.tlb_num_ways - 1)) <<
> +                 CR_TLBMISC_WAY_SHIFT);
> +        }
> +
> +        /* Writes to TLBACC don't change the read-back value */
> +        env->mmu.tlbacc_wr = v;
> +        break;
> +
> +    case CR_TLBMISC:
> +        MMU_LOG(qemu_log("TLBMISC: WAY %X, FLAGS %c%c%c%c%c%c, PID %04X\n",
> +                         v >> CR_TLBMISC_WAY_SHIFT,
> +                         (v & CR_TLBMISC_RD) ? 'R' : '.',
> +                         (v & CR_TLBMISC_WR) ? 'W' : '.',
> +                         (v & CR_TLBMISC_DBL) ? '2' : '.',
> +                         (v & CR_TLBMISC_BAD) ? 'B' : '.',
> +                         (v & CR_TLBMISC_PERM) ? 'P' : '.',
> +                         (v & CR_TLBMISC_D) ? 'D' : '.',
> +                         (v & CR_TLBMISC_PID_MASK) >> 4));
> +
> +        if ((v & CR_TLBMISC_PID_MASK) !=
> +            (env->mmu.tlbmisc_wr & CR_TLBMISC_PID_MASK)) {
> +            mmu_flush_pid(env, (env->mmu.tlbmisc_wr & CR_TLBMISC_PID_MASK) >>
> +                               CR_TLBMISC_PID_SHIFT);
> +        }
> +        /* if tlbmisc.RD == 1 then trigger a TLB read on writes to TLBMISC */
> +        if (v & CR_TLBMISC_RD) {
> +            int way = (v >> CR_TLBMISC_WAY_SHIFT);
> +            int vpn = (env->mmu.pteaddr_wr & CR_PTEADDR_VPN_MASK) >> 2;
> +            Nios2TLBEntry *entry =
> +                &env->mmu.tlb[(way * env->mmu.tlb_num_ways) +
> +                              (vpn & env->mmu.tlb_entry_mask)];
> +
> +            env->regs[CR_TLBACC] &= CR_TLBACC_IGN_MASK;
> +            env->regs[CR_TLBACC] |= entry->data;
> +            env->regs[CR_TLBACC] |= (entry->tag & (1 << 11)) ? CR_TLBACC_G : 0;
> +            env->regs[CR_TLBMISC] =
> +                (v & ~CR_TLBMISC_PID_MASK) |
> +                ((entry->tag & ((1 << env->mmu.pid_bits) - 1)) <<
> +                 CR_TLBMISC_PID_SHIFT);
> +            env->regs[CR_PTEADDR] &= ~CR_PTEADDR_VPN_MASK;
> +            env->regs[CR_PTEADDR] |= (entry->tag >> 12) << CR_PTEADDR_VPN_SHIFT;
> +            MMU_LOG(qemu_log("TLB READ way %d, vpn %05X, tag %08X, data %08X, "
> +                             "tlbacc %08X, tlbmisc %08X, pteaddr %08X\n",
> +                             way, vpn, entry->tag, entry->data,
> +                             env->regs[CR_TLBACC], env->regs[CR_TLBMISC],
> +                             env->regs[CR_PTEADDR]));
> +        } else {
> +            env->regs[CR_TLBMISC] = v;
> +        }
> +
> +        env->mmu.tlbmisc_wr = v;
> +        break;
> +
> +    case CR_PTEADDR:
> +        MMU_LOG(qemu_log("PTEADDR: PTBASE %03X, VPN %05X\n",
> +                         v >> CR_PTEADDR_PTBASE_SHIFT,
> +                         (v & CR_PTEADDR_VPN_MASK) >> CR_PTEADDR_VPN_SHIFT));
> +
> +        /* Writes to PTEADDR don't change the read-back VPN value */
> +        env->regs[CR_PTEADDR] = (v & ~CR_PTEADDR_VPN_MASK) |
> +                                (env->regs[CR_PTEADDR] & CR_PTEADDR_VPN_MASK);
> +        env->mmu.pteaddr_wr = v;
> +        break;
> +
> +    default:
> +        break;
> +    }
> +}
> +
> +void mmu_init(Nios2MMU *mmu)
> +{
> +    MMU_LOG(qemu_log("mmu_init\n"));
> +
> +    mmu->pid_bits = 8;          /* TODO: get this from ALTR,pid-num-bits */
> +    mmu->tlb_num_ways = 16;     /* TODO: get this from ALTR,tlb-num-ways */
> +    mmu->tlb_num_entries = 256; /* TODO: get this from ALTR,tlb-num-entries */

If they're going to get set from outside, you probably want to make 
these QOM properties on the CPU objects. That way your board file can 
modify them depending on dt properties (which is what you're referring 
to I suppose?)


Alex
