Received: from eggs.gnu.org ([2001:4830:134:3::10]:47774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVmvA-0004MM-Ah
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 17:17:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVmv3-0007nk-SI
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 17:17:04 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34593)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cVmv3-0007ne-IP
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 17:16:57 -0500
Received: by mail-qt0-x244.google.com with SMTP id a29so20495005qtb.1
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 14:16:57 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 23 Jan 2017 14:16:44 -0800
Message-Id: <20170123221650.9267-2-rth@twiddle.net>
In-Reply-To: <20170123221650.9267-1-rth@twiddle.net>
References: <20170123221650.9267-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 1/7] nios2: Add architecture emulation support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>, Jeff Da Silva <jdasilva@altera.com>, Ley Foon Tan <lftan@altera.com>, Sandra Loosemore <sandra@codesourcery.com>, Yves Vandervennet <yvanderv@altera.com>, Alexander Graf <agraf@suse.de>

From: Chris Wulff <crwulff@gmail.com>

Add support for emulating Altera NiosII R1 architecture into qemu.
This patch is based on previous work by Chris Wulff from 2012 and
updated to latest mainline QEMU.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Chris Wulff <crwulff@gmail.com>
Cc: Jeff Da Silva <jdasilva@altera.com>
Cc: Ley Foon Tan <lftan@altera.com>
Cc: Sandra Loosemore <sandra@codesourcery.com>
Cc: Yves Vandervennet <yvanderv@altera.com>
Cc: Alexander Graf <agraf@suse.de>
Message-Id: <20170118220146.489-3-marex@denx.de>
[rth: Remove tlb_flush from nios2_cpu_reset.]
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/nios2/Makefile.objs |   4 +
 target/nios2/cpu.c         | 237 +++++++++++
 target/nios2/cpu.h         | 272 +++++++++++++
 target/nios2/helper.c      | 313 +++++++++++++++
 target/nios2/helper.h      |  27 ++
 target/nios2/mmu.c         | 296 ++++++++++++++
 target/nios2/mmu.h         |  50 +++
 target/nios2/monitor.c     |  35 ++
 target/nios2/op_helper.c   |  47 +++
 target/nios2/translate.c   | 958 +++++++++++++++++++++++++++++++++++++++++++++
 10 files changed, 2239 insertions(+)
 create mode 100644 target/nios2/Makefile.objs
 create mode 100644 target/nios2/cpu.c
 create mode 100644 target/nios2/cpu.h
 create mode 100644 target/nios2/helper.c
 create mode 100644 target/nios2/helper.h
 create mode 100644 target/nios2/mmu.c
 create mode 100644 target/nios2/mmu.h
 create mode 100644 target/nios2/monitor.c
 create mode 100644 target/nios2/op_helper.c
 create mode 100644 target/nios2/translate.c

diff --git a/target/nios2/Makefile.objs b/target/nios2/Makefile.objs
new file mode 100644
index 0000000..2a11c5c
--- /dev/null
+++ b/target/nios2/Makefile.objs
@@ -0,0 +1,4 @@
+obj-y += translate.o op_helper.o helper.o cpu.o mmu.o
+obj-$(CONFIG_SOFTMMU) += monitor.o
+
+$(obj)/op_helper.o: QEMU_CFLAGS += $(HELPER_CFLAGS)
diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
new file mode 100644
index 0000000..d56bb72
--- /dev/null
+++ b/target/nios2/cpu.c
@@ -0,0 +1,237 @@
+/*
+ * QEMU Nios II CPU
+ *
+ * Copyright (c) 2012 Chris Wulff <crwulff@gmail.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see
+ * <http://www.gnu.org/licenses/lgpl-2.1.html>
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qapi/error.h"
+#include "cpu.h"
+#include "exec/log.h"
+#include "exec/gdbstub.h"
+#include "hw/qdev-properties.h"
+
+static void nios2_cpu_set_pc(CPUState *cs, vaddr value)
+{
+    Nios2CPU *cpu = NIOS2_CPU(cs);
+    CPUNios2State *env = &cpu->env;
+
+    env->regs[R_PC] = value;
+}
+
+static bool nios2_cpu_has_work(CPUState *cs)
+{
+    return cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
+}
+
+/* CPUClass::reset() */
+static void nios2_cpu_reset(CPUState *cs)
+{
+    Nios2CPU *cpu = NIOS2_CPU(cs);
+    Nios2CPUClass *ncc = NIOS2_CPU_GET_CLASS(cpu);
+    CPUNios2State *env = &cpu->env;
+
+    if (qemu_loglevel_mask(CPU_LOG_RESET)) {
+        qemu_log("CPU Reset (CPU %d)\n", cs->cpu_index);
+        log_cpu_state(cs, 0);
+    }
+
+    ncc->parent_reset(cs);
+
+    memset(env->regs, 0, sizeof(uint32_t) * NUM_CORE_REGS);
+    env->regs[R_PC] = cpu->reset_addr;
+
+#if defined(CONFIG_USER_ONLY)
+    /* Start in user mode with interrupts enabled. */
+    env->regs[CR_STATUS] = CR_STATUS_U | CR_STATUS_PIE;
+#else
+    env->regs[CR_STATUS] = 0;
+#endif
+}
+
+static void nios2_cpu_initfn(Object *obj)
+{
+    CPUState *cs = CPU(obj);
+    Nios2CPU *cpu = NIOS2_CPU(obj);
+    CPUNios2State *env = &cpu->env;
+    static bool tcg_initialized;
+
+    cs->env_ptr = env;
+
+#if !defined(CONFIG_USER_ONLY)
+    mmu_init(env);
+#endif
+
+    if (tcg_enabled() && !tcg_initialized) {
+        tcg_initialized = true;
+        nios2_tcg_init();
+    }
+}
+
+Nios2CPU *cpu_nios2_init(const char *cpu_model)
+{
+    Nios2CPU *cpu = NIOS2_CPU(object_new(TYPE_NIOS2_CPU));
+
+    object_property_set_bool(OBJECT(cpu), true, "realized", NULL);
+
+    return cpu;
+}
+
+static void nios2_cpu_realizefn(DeviceState *dev, Error **errp)
+{
+    CPUState *cs = CPU(dev);
+    Nios2CPUClass *ncc = NIOS2_CPU_GET_CLASS(dev);
+    Error *local_err = NULL;
+
+    cpu_exec_realizefn(cs, &local_err);
+    if (local_err != NULL) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    qemu_init_vcpu(cs);
+    cpu_reset(cs);
+
+    ncc->parent_realize(dev, errp);
+}
+
+static bool nios2_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
+{
+    Nios2CPU *cpu = NIOS2_CPU(cs);
+    CPUNios2State *env = &cpu->env;
+
+    if ((interrupt_request & CPU_INTERRUPT_HARD) &&
+        (env->regs[CR_STATUS] & CR_STATUS_PIE)) {
+        cs->exception_index = EXCP_IRQ;
+        nios2_cpu_do_interrupt(cs);
+        return true;
+    }
+    return false;
+}
+
+
+static void nios2_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
+{
+    /* NOTE: NiosII R2 is not supported yet. */
+    info->mach = bfd_arch_nios2;
+#ifdef TARGET_WORDS_BIGENDIAN
+    info->print_insn = print_insn_big_nios2;
+#else
+    info->print_insn = print_insn_little_nios2;
+#endif
+}
+
+static int nios2_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+{
+    Nios2CPU *cpu = NIOS2_CPU(cs);
+    CPUClass *cc = CPU_GET_CLASS(cs);
+    CPUNios2State *env = &cpu->env;
+
+    if (n > cc->gdb_num_core_regs) {
+        return 0;
+    }
+
+    if (n < 32) {          /* GP regs */
+        return gdb_get_reg32(mem_buf, env->regs[n]);
+    } else if (n == 32) {    /* PC */
+        return gdb_get_reg32(mem_buf, env->regs[R_PC]);
+    } else if (n < 49) {     /* Status regs */
+        return gdb_get_reg32(mem_buf, env->regs[n - 1]);
+    }
+
+    /* Invalid regs */
+    return 0;
+}
+
+static int nios2_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
+{
+    Nios2CPU *cpu = NIOS2_CPU(cs);
+    CPUClass *cc = CPU_GET_CLASS(cs);
+    CPUNios2State *env = &cpu->env;
+
+    if (n > cc->gdb_num_core_regs) {
+        return 0;
+    }
+
+    if (n < 32) {            /* GP regs */
+        env->regs[n] = ldl_p(mem_buf);
+    } else if (n == 32) {    /* PC */
+        env->regs[R_PC] = ldl_p(mem_buf);
+    } else if (n < 49) {     /* Status regs */
+        env->regs[n - 1] = ldl_p(mem_buf);
+    }
+
+    return 4;
+}
+
+static Property nios2_properties[] = {
+    DEFINE_PROP_BOOL("mmu_present", Nios2CPU, mmu_present, true),
+    /* ALTR,pid-num-bits */
+    DEFINE_PROP_UINT32("mmu_pid_num_bits", Nios2CPU, pid_num_bits, 8),
+    /* ALTR,tlb-num-ways */
+    DEFINE_PROP_UINT32("mmu_tlb_num_ways", Nios2CPU, tlb_num_ways, 16),
+    /* ALTR,tlb-num-entries */
+    DEFINE_PROP_UINT32("mmu_pid_num_entries", Nios2CPU, tlb_num_entries, 256),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+
+static void nios2_cpu_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    CPUClass *cc = CPU_CLASS(oc);
+    Nios2CPUClass *ncc = NIOS2_CPU_CLASS(oc);
+
+    ncc->parent_realize = dc->realize;
+    dc->realize = nios2_cpu_realizefn;
+    dc->props = nios2_properties;
+    ncc->parent_reset = cc->reset;
+    cc->reset = nios2_cpu_reset;
+
+    cc->has_work = nios2_cpu_has_work;
+    cc->do_interrupt = nios2_cpu_do_interrupt;
+    cc->cpu_exec_interrupt = nios2_cpu_exec_interrupt;
+    cc->dump_state = nios2_cpu_dump_state;
+    cc->set_pc = nios2_cpu_set_pc;
+    cc->disas_set_info = nios2_cpu_disas_set_info;
+#ifdef CONFIG_USER_ONLY
+    cc->handle_mmu_fault = nios2_cpu_handle_mmu_fault;
+#else
+    cc->do_unaligned_access = nios2_cpu_do_unaligned_access;
+    cc->get_phys_page_debug = nios2_cpu_get_phys_page_debug;
+#endif
+    cc->gdb_read_register = nios2_cpu_gdb_read_register;
+    cc->gdb_write_register = nios2_cpu_gdb_write_register;
+    cc->gdb_num_core_regs = 49;
+}
+
+static const TypeInfo nios2_cpu_type_info = {
+    .name = TYPE_NIOS2_CPU,
+    .parent = TYPE_CPU,
+    .instance_size = sizeof(Nios2CPU),
+    .instance_init = nios2_cpu_initfn,
+    .class_size = sizeof(Nios2CPUClass),
+    .class_init = nios2_cpu_class_init,
+};
+
+static void nios2_cpu_register_types(void)
+{
+    type_register_static(&nios2_cpu_type_info);
+}
+
+type_init(nios2_cpu_register_types)
diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
new file mode 100644
index 0000000..13931f3
--- /dev/null
+++ b/target/nios2/cpu.h
@@ -0,0 +1,272 @@
+/*
+ * Altera Nios II virtual CPU header
+ *
+ * Copyright (c) 2012 Chris Wulff <crwulff@gmail.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see
+ * <http://www.gnu.org/licenses/lgpl-2.1.html>
+ */
+#ifndef CPU_NIOS2_H
+#define CPU_NIOS2_H
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+
+#define TARGET_LONG_BITS 32
+
+#define CPUArchState struct CPUNios2State
+
+#include "exec/cpu-defs.h"
+#include "fpu/softfloat.h"
+#include "qom/cpu.h"
+struct CPUNios2State;
+typedef struct CPUNios2State CPUNios2State;
+#if !defined(CONFIG_USER_ONLY)
+#include "mmu.h"
+#endif
+
+#define TYPE_NIOS2_CPU "nios2-cpu"
+
+#define NIOS2_CPU_CLASS(klass) \
+    OBJECT_CLASS_CHECK(Nios2CPUClass, (klass), TYPE_NIOS2_CPU)
+#define NIOS2_CPU(obj) \
+    OBJECT_CHECK(Nios2CPU, (obj), TYPE_NIOS2_CPU)
+#define NIOS2_CPU_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(Nios2CPUClass, (obj), TYPE_NIOS2_CPU)
+
+/**
+ * Nios2CPUClass:
+ * @parent_reset: The parent class' reset handler.
+ *
+ * A Nios2 CPU model.
+ */
+typedef struct Nios2CPUClass {
+    /*< private >*/
+    CPUClass parent_class;
+    /*< public >*/
+
+    DeviceRealize parent_realize;
+    void (*parent_reset)(CPUState *cpu);
+} Nios2CPUClass;
+
+#define TARGET_HAS_ICE 1
+
+/* Configuration options for Nios II */
+#define RESET_ADDRESS         0x00000000
+#define EXCEPTION_ADDRESS     0x00000004
+#define FAST_TLB_MISS_ADDRESS 0x00000008
+
+
+/* GP regs + CR regs + PC */
+#define NUM_CORE_REGS (32 + 32 + 1)
+
+/* General purpose register aliases */
+#define R_ZERO   0
+#define R_AT     1
+#define R_RET0   2
+#define R_RET1   3
+#define R_ARG0   4
+#define R_ARG1   5
+#define R_ARG2   6
+#define R_ARG3   7
+#define R_ET     24
+#define R_BT     25
+#define R_GP     26
+#define R_SP     27
+#define R_FP     28
+#define R_EA     29
+#define R_BA     30
+#define R_RA     31
+
+/* Control register aliases */
+#define CR_BASE  32
+#define CR_STATUS    (CR_BASE + 0)
+#define   CR_STATUS_PIE  (1 << 0)
+#define   CR_STATUS_U    (1 << 1)
+#define   CR_STATUS_EH   (1 << 2)
+#define   CR_STATUS_IH   (1 << 3)
+#define   CR_STATUS_IL   (63 << 4)
+#define   CR_STATUS_CRS  (63 << 10)
+#define   CR_STATUS_PRS  (63 << 16)
+#define   CR_STATUS_NMI  (1 << 22)
+#define   CR_STATUS_RSIE (1 << 23)
+#define CR_ESTATUS   (CR_BASE + 1)
+#define CR_BSTATUS   (CR_BASE + 2)
+#define CR_IENABLE   (CR_BASE + 3)
+#define CR_IPENDING  (CR_BASE + 4)
+#define CR_CPUID     (CR_BASE + 5)
+#define CR_CTL6      (CR_BASE + 6)
+#define CR_EXCEPTION (CR_BASE + 7)
+#define CR_PTEADDR   (CR_BASE + 8)
+#define   CR_PTEADDR_PTBASE_SHIFT 22
+#define   CR_PTEADDR_PTBASE_MASK  (0x3FF << CR_PTEADDR_PTBASE_SHIFT)
+#define   CR_PTEADDR_VPN_SHIFT    2
+#define   CR_PTEADDR_VPN_MASK     (0xFFFFF << CR_PTEADDR_VPN_SHIFT)
+#define CR_TLBACC    (CR_BASE + 9)
+#define   CR_TLBACC_IGN_SHIFT 25
+#define   CR_TLBACC_IGN_MASK  (0x7F << CR_TLBACC_IGN_SHIFT)
+#define   CR_TLBACC_C         (1 << 24)
+#define   CR_TLBACC_R         (1 << 23)
+#define   CR_TLBACC_W         (1 << 22)
+#define   CR_TLBACC_X         (1 << 21)
+#define   CR_TLBACC_G         (1 << 20)
+#define   CR_TLBACC_PFN_MASK  0x000FFFFF
+#define CR_TLBMISC   (CR_BASE + 10)
+#define   CR_TLBMISC_WAY_SHIFT 20
+#define   CR_TLBMISC_WAY_MASK  (0xF << CR_TLBMISC_WAY_SHIFT)
+#define   CR_TLBMISC_RD        (1 << 19)
+#define   CR_TLBMISC_WR        (1 << 18)
+#define   CR_TLBMISC_PID_SHIFT 4
+#define   CR_TLBMISC_PID_MASK  (0x3FFF << CR_TLBMISC_PID_SHIFT)
+#define   CR_TLBMISC_DBL       (1 << 3)
+#define   CR_TLBMISC_BAD       (1 << 2)
+#define   CR_TLBMISC_PERM      (1 << 1)
+#define   CR_TLBMISC_D         (1 << 0)
+#define CR_ENCINJ    (CR_BASE + 11)
+#define CR_BADADDR   (CR_BASE + 12)
+#define CR_CONFIG    (CR_BASE + 13)
+#define CR_MPUBASE   (CR_BASE + 14)
+#define CR_MPUACC    (CR_BASE + 15)
+
+/* Other registers */
+#define R_PC         64
+
+/* Exceptions */
+#define EXCP_BREAK    -1
+#define EXCP_RESET    0
+#define EXCP_PRESET   1
+#define EXCP_IRQ      2
+#define EXCP_TRAP     3
+#define EXCP_UNIMPL   4
+#define EXCP_ILLEGAL  5
+#define EXCP_UNALIGN  6
+#define EXCP_UNALIGND 7
+#define EXCP_DIV      8
+#define EXCP_SUPERA   9
+#define EXCP_SUPERI   10
+#define EXCP_SUPERD   11
+#define EXCP_TLBD     12
+#define EXCP_TLBX     13
+#define EXCP_TLBR     14
+#define EXCP_TLBW     15
+#define EXCP_MPUI     16
+#define EXCP_MPUD     17
+
+#define CPU_INTERRUPT_NMI       CPU_INTERRUPT_TGT_EXT_3
+
+#define NB_MMU_MODES 2
+
+struct CPUNios2State {
+    uint32_t regs[NUM_CORE_REGS];
+
+#if !defined(CONFIG_USER_ONLY)
+    Nios2MMU mmu;
+
+    uint32_t irq_pending;
+#endif
+
+    CPU_COMMON
+};
+
+/**
+ * Nios2CPU:
+ * @env: #CPUNios2State
+ *
+ * A Nios2 CPU.
+ */
+typedef struct Nios2CPU {
+    /*< private >*/
+    CPUState parent_obj;
+    /*< public >*/
+
+    CPUNios2State env;
+    bool mmu_present;
+    uint32_t pid_num_bits;
+    uint32_t tlb_num_ways;
+    uint32_t tlb_num_entries;
+
+    /* Addresses that are hard-coded in the FPGA build settings */
+    uint32_t reset_addr;
+    uint32_t exception_addr;
+    uint32_t fast_tlb_miss_addr;
+} Nios2CPU;
+
+static inline Nios2CPU *nios2_env_get_cpu(CPUNios2State *env)
+{
+    return NIOS2_CPU(container_of(env, Nios2CPU, env));
+}
+
+#define ENV_GET_CPU(e) CPU(nios2_env_get_cpu(e))
+
+#define ENV_OFFSET offsetof(Nios2CPU, env)
+
+void nios2_tcg_init(void);
+Nios2CPU *cpu_nios2_init(const char *cpu_model);
+void nios2_cpu_do_interrupt(CPUState *cs);
+int cpu_nios2_signal_handler(int host_signum, void *pinfo, void *puc);
+void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUNios2State *env);
+void nios2_cpu_dump_state(CPUState *cpu, FILE *f, fprintf_function cpu_fprintf,
+                          int flags);
+hwaddr nios2_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+void nios2_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
+                                   MMUAccessType access_type,
+                                   int mmu_idx, uintptr_t retaddr);
+
+qemu_irq *nios2_cpu_pic_init(Nios2CPU *cpu);
+void nios2_check_interrupts(CPUNios2State *env);
+
+#define TARGET_PHYS_ADDR_SPACE_BITS 32
+#define TARGET_VIRT_ADDR_SPACE_BITS 32
+
+#define cpu_init(cpu_model) CPU(cpu_nios2_init(cpu_model))
+
+#define cpu_gen_code cpu_nios2_gen_code
+#define cpu_signal_handler cpu_nios2_signal_handler
+
+#define CPU_SAVE_VERSION 1
+
+#define TARGET_PAGE_BITS 12
+
+/* MMU modes definitions */
+#define MMU_MODE0_SUFFIX _kernel
+#define MMU_MODE1_SUFFIX _user
+#define MMU_SUPERVISOR_IDX  0
+#define MMU_USER_IDX        1
+
+static inline int cpu_mmu_index(CPUNios2State *env, bool ifetch)
+{
+    return (env->regs[CR_STATUS] & CR_STATUS_U) ? MMU_USER_IDX :
+                                                  MMU_SUPERVISOR_IDX;
+}
+
+int nios2_cpu_handle_mmu_fault(CPUState *env, vaddr address,
+                               int rw, int mmu_idx);
+
+static inline int cpu_interrupts_enabled(CPUNios2State *env)
+{
+    return env->regs[CR_STATUS] & CR_STATUS_PIE;
+}
+
+#include "exec/cpu-all.h"
+#include "exec/exec-all.h"
+
+static inline void cpu_get_tb_cpu_state(CPUNios2State *env, target_ulong *pc,
+                                        target_ulong *cs_base, uint32_t *flags)
+{
+    *pc = env->regs[R_PC];
+    *cs_base = 0;
+    *flags = (env->regs[CR_STATUS] & (CR_STATUS_EH | CR_STATUS_U));
+}
+
+#endif /* CPU_NIOS2_H */
diff --git a/target/nios2/helper.c b/target/nios2/helper.c
new file mode 100644
index 0000000..cd4f353
--- /dev/null
+++ b/target/nios2/helper.c
@@ -0,0 +1,313 @@
+/*
+ * Altera Nios II helper routines.
+ *
+ * Copyright (c) 2012 Chris Wulff <crwulff@gmail.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see
+ * <http://www.gnu.org/licenses/lgpl-2.1.html>
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <assert.h>
+
+#include "cpu.h"
+#include "qemu/osdep.h"
+#include "qemu/host-utils.h"
+#include "qapi/error.h"
+#include "exec/exec-all.h"
+#include "exec/log.h"
+#include "exec/helper-proto.h"
+
+#if defined(CONFIG_USER_ONLY)
+
+void nios2_cpu_do_interrupt(CPUState *cs)
+{
+    Nios2CPU *cpu = NIOS2_CPU(cs);
+    CPUNios2State *env = &cpu->env;
+    cs->exception_index = -1;
+    env->regs[R_EA] = env->regs[R_PC] + 4;
+}
+
+int nios2_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int rw, int mmu_idx)
+{
+    cs->exception_index = 0xaa;
+    /* Page 0x1000 is kuser helper */
+    if (address < 0x1000 || address >= 0x2000) {
+        cpu_dump_state(cs, stderr, fprintf, 0);
+    }
+    return 1;
+}
+
+#else /* !CONFIG_USER_ONLY */
+
+void nios2_cpu_do_interrupt(CPUState *cs)
+{
+    Nios2CPU *cpu = NIOS2_CPU(cs);
+    CPUNios2State *env = &cpu->env;
+
+    switch (cs->exception_index) {
+    case EXCP_IRQ:
+        assert(env->regs[CR_STATUS] & CR_STATUS_PIE);
+
+        qemu_log_mask(CPU_LOG_INT, "interrupt at pc=%x\n", env->regs[R_PC]);
+
+        env->regs[CR_ESTATUS] = env->regs[CR_STATUS];
+        env->regs[CR_STATUS] |= CR_STATUS_IH;
+        env->regs[CR_STATUS] &= ~(CR_STATUS_PIE | CR_STATUS_U);
+
+        env->regs[CR_EXCEPTION] &= ~(0x1F << 2);
+        env->regs[CR_EXCEPTION] |= (cs->exception_index & 0x1F) << 2;
+
+        env->regs[R_EA] = env->regs[R_PC] + 4;
+        env->regs[R_PC] = cpu->exception_addr;
+        break;
+
+    case EXCP_TLBD:
+        if ((env->regs[CR_STATUS] & CR_STATUS_EH) == 0) {
+            qemu_log_mask(CPU_LOG_INT, "TLB MISS (fast) at pc=%x\n",
+                          env->regs[R_PC]);
+
+            /* Fast TLB miss */
+            /* Variation from the spec. Table 3-35 of the cpu reference shows
+             * estatus not being changed for TLB miss but this appears to
+             * be incorrect. */
+            env->regs[CR_ESTATUS] = env->regs[CR_STATUS];
+            env->regs[CR_STATUS] |= CR_STATUS_EH;
+            env->regs[CR_STATUS] &= ~(CR_STATUS_PIE | CR_STATUS_U);
+
+            env->regs[CR_EXCEPTION] &= ~(0x1F << 2);
+            env->regs[CR_EXCEPTION] |= (cs->exception_index & 0x1F) << 2;
+
+            env->regs[CR_TLBMISC] &= ~CR_TLBMISC_DBL;
+            env->regs[CR_TLBMISC] |= CR_TLBMISC_WR;
+
+            env->regs[R_EA] = env->regs[R_PC] + 4;
+            env->regs[R_PC] = cpu->fast_tlb_miss_addr;
+        } else {
+            qemu_log_mask(CPU_LOG_INT, "TLB MISS (double) at pc=%x\n",
+                          env->regs[R_PC]);
+
+            /* Double TLB miss */
+            env->regs[CR_STATUS] |= CR_STATUS_EH;
+            env->regs[CR_STATUS] &= ~(CR_STATUS_PIE | CR_STATUS_U);
+
+            env->regs[CR_EXCEPTION] &= ~(0x1F << 2);
+            env->regs[CR_EXCEPTION] |= (cs->exception_index & 0x1F) << 2;
+
+            env->regs[CR_TLBMISC] |= CR_TLBMISC_DBL;
+
+            env->regs[R_PC] = cpu->exception_addr;
+        }
+        break;
+
+    case EXCP_TLBR:
+    case EXCP_TLBW:
+    case EXCP_TLBX:
+        qemu_log_mask(CPU_LOG_INT, "TLB PERM at pc=%x\n", env->regs[R_PC]);
+
+        env->regs[CR_ESTATUS] = env->regs[CR_STATUS];
+        env->regs[CR_STATUS] |= CR_STATUS_EH;
+        env->regs[CR_STATUS] &= ~(CR_STATUS_PIE | CR_STATUS_U);
+
+        env->regs[CR_EXCEPTION] &= ~(0x1F << 2);
+        env->regs[CR_EXCEPTION] |= (cs->exception_index & 0x1F) << 2;
+
+        if ((env->regs[CR_STATUS] & CR_STATUS_EH) == 0) {
+            env->regs[CR_TLBMISC] |= CR_TLBMISC_WR;
+        }
+
+        env->regs[R_EA] = env->regs[R_PC] + 4;
+        env->regs[R_PC] = cpu->exception_addr;
+        break;
+
+    case EXCP_SUPERA:
+    case EXCP_SUPERI:
+    case EXCP_SUPERD:
+        qemu_log_mask(CPU_LOG_INT, "SUPERVISOR exception at pc=%x\n",
+                      env->regs[R_PC]);
+
+        if ((env->regs[CR_STATUS] & CR_STATUS_EH) == 0) {
+            env->regs[CR_ESTATUS] = env->regs[CR_STATUS];
+            env->regs[R_EA] = env->regs[R_PC] + 4;
+        }
+
+        env->regs[CR_STATUS] |= CR_STATUS_EH;
+        env->regs[CR_STATUS] &= ~(CR_STATUS_PIE | CR_STATUS_U);
+
+        env->regs[CR_EXCEPTION] &= ~(0x1F << 2);
+        env->regs[CR_EXCEPTION] |= (cs->exception_index & 0x1F) << 2;
+
+        env->regs[R_PC] = cpu->exception_addr;
+        break;
+
+    case EXCP_ILLEGAL:
+    case EXCP_TRAP:
+        qemu_log_mask(CPU_LOG_INT, "TRAP exception at pc=%x\n",
+                      env->regs[R_PC]);
+
+        if ((env->regs[CR_STATUS] & CR_STATUS_EH) == 0) {
+            env->regs[CR_ESTATUS] = env->regs[CR_STATUS];
+            env->regs[R_EA] = env->regs[R_PC] + 4;
+        }
+
+        env->regs[CR_STATUS] |= CR_STATUS_EH;
+        env->regs[CR_STATUS] &= ~(CR_STATUS_PIE | CR_STATUS_U);
+
+        env->regs[CR_EXCEPTION] &= ~(0x1F << 2);
+        env->regs[CR_EXCEPTION] |= (cs->exception_index & 0x1F) << 2;
+
+        env->regs[R_PC] = cpu->exception_addr;
+        break;
+
+    case EXCP_BREAK:
+        if ((env->regs[CR_STATUS] & CR_STATUS_EH) == 0) {
+            env->regs[CR_BSTATUS] = env->regs[CR_STATUS];
+            env->regs[R_BA] = env->regs[R_PC] + 4;
+        }
+
+        env->regs[CR_STATUS] |= CR_STATUS_EH;
+        env->regs[CR_STATUS] &= ~(CR_STATUS_PIE | CR_STATUS_U);
+
+        env->regs[CR_EXCEPTION] &= ~(0x1F << 2);
+        env->regs[CR_EXCEPTION] |= (cs->exception_index & 0x1F) << 2;
+
+        env->regs[R_PC] = cpu->exception_addr;
+        break;
+
+    default:
+        cpu_abort(cs, "unhandled exception type=%d\n",
+                  cs->exception_index);
+        break;
+    }
+}
+
+static int cpu_nios2_handle_virtual_page(
+    CPUState *cs, target_ulong address, int rw, int mmu_idx)
+{
+    Nios2CPU *cpu = NIOS2_CPU(cs);
+    CPUNios2State *env = &cpu->env;
+    target_ulong vaddr, paddr;
+    Nios2MMULookup lu;
+    unsigned int hit;
+    hit = mmu_translate(env, &lu, address, rw, mmu_idx);
+    if (hit) {
+        vaddr = address & TARGET_PAGE_MASK;
+        paddr = lu.paddr + vaddr - lu.vaddr;
+
+        if (((rw == 0) && (lu.prot & PAGE_READ)) ||
+            ((rw == 1) && (lu.prot & PAGE_WRITE)) ||
+            ((rw == 2) && (lu.prot & PAGE_EXEC))) {
+
+            tlb_set_page(cs, vaddr, paddr, lu.prot,
+                         mmu_idx, TARGET_PAGE_SIZE);
+            return 0;
+        } else {
+            /* Permission violation */
+            cs->exception_index = (rw == 0) ? EXCP_TLBR :
+                                               ((rw == 1) ? EXCP_TLBW :
+                                                            EXCP_TLBX);
+        }
+    } else {
+        cs->exception_index = EXCP_TLBD;
+    }
+
+    if (rw == 2) {
+        env->regs[CR_TLBMISC] &= ~CR_TLBMISC_D;
+    } else {
+        env->regs[CR_TLBMISC] |= CR_TLBMISC_D;
+    }
+    env->regs[CR_PTEADDR] &= CR_PTEADDR_PTBASE_MASK;
+    env->regs[CR_PTEADDR] |= (address >> 10) & CR_PTEADDR_VPN_MASK;
+    env->mmu.pteaddr_wr = env->regs[CR_PTEADDR];
+    env->regs[CR_BADADDR] = address;
+    return 1;
+}
+
+int nios2_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int rw, int mmu_idx)
+{
+    Nios2CPU *cpu = NIOS2_CPU(cs);
+    CPUNios2State *env = &cpu->env;
+
+    if (cpu->mmu_present) {
+        if (MMU_SUPERVISOR_IDX == mmu_idx) {
+            if (address >= 0xC0000000) {
+                /* Kernel physical page - TLB bypassed */
+                address &= TARGET_PAGE_MASK;
+                tlb_set_page(cs, address, address, PAGE_BITS,
+                             mmu_idx, TARGET_PAGE_SIZE);
+            } else if (address >= 0x80000000) {
+                /* Kernel virtual page */
+                return cpu_nios2_handle_virtual_page(cs, address, rw, mmu_idx);
+            } else {
+                /* User virtual page */
+                return cpu_nios2_handle_virtual_page(cs, address, rw, mmu_idx);
+            }
+        } else {
+            if (address >= 0x80000000) {
+                /* Illegal access from user mode */
+                cs->exception_index = EXCP_SUPERA;
+                env->regs[CR_BADADDR] = address;
+                return 1;
+            } else {
+                /* User virtual page */
+                return cpu_nios2_handle_virtual_page(cs, address, rw, mmu_idx);
+            }
+        }
+    } else {
+        /* No MMU */
+        address &= TARGET_PAGE_MASK;
+        tlb_set_page(cs, address, address, PAGE_BITS,
+                     mmu_idx, TARGET_PAGE_SIZE);
+    }
+
+    return 0;
+}
+
+hwaddr nios2_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
+{
+    Nios2CPU *cpu = NIOS2_CPU(cs);
+    CPUNios2State *env = &cpu->env;
+    target_ulong vaddr, paddr = 0;
+    Nios2MMULookup lu;
+    unsigned int hit;
+
+    if (cpu->mmu_present && (addr < 0xC0000000)) {
+        hit = mmu_translate(env, &lu, addr, 0, 0);
+        if (hit) {
+            vaddr = addr & TARGET_PAGE_MASK;
+            paddr = lu.paddr + vaddr - lu.vaddr;
+        } else {
+            paddr = -1;
+            qemu_log("cpu_get_phys_page debug MISS: %08lX\n", addr);
+        }
+    } else {
+        paddr = addr & TARGET_PAGE_MASK;
+    }
+
+    return paddr;
+}
+
+void nios2_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
+                                   MMUAccessType access_type,
+                                   int mmu_idx, uintptr_t retaddr)
+{
+    Nios2CPU *cpu = NIOS2_CPU(cs);
+    CPUNios2State *env = &cpu->env;
+
+    env->regs[CR_BADADDR] = addr;
+    env->regs[CR_EXCEPTION] = EXCP_UNALIGN << 2;
+    helper_raise_exception(env, EXCP_UNALIGN);
+}
+#endif /* !CONFIG_USER_ONLY */
diff --git a/target/nios2/helper.h b/target/nios2/helper.h
new file mode 100644
index 0000000..b0cb914
--- /dev/null
+++ b/target/nios2/helper.h
@@ -0,0 +1,27 @@
+/*
+ * Altera Nios II helper routines header.
+ *
+ * Copyright (c) 2012 Chris Wulff <crwulff@gmail.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see
+ * <http://www.gnu.org/licenses/lgpl-2.1.html>
+ */
+
+DEF_HELPER_2(raise_exception, void, env, i32)
+
+#if !defined(CONFIG_USER_ONLY)
+DEF_HELPER_2(mmu_read_debug, void, env, i32)
+DEF_HELPER_3(mmu_write, void, env, i32, i32)
+DEF_HELPER_1(check_interrupts, void, env)
+#endif
diff --git a/target/nios2/mmu.c b/target/nios2/mmu.c
new file mode 100644
index 0000000..fe9298a
--- /dev/null
+++ b/target/nios2/mmu.c
@@ -0,0 +1,296 @@
+/*
+ * Altera Nios II MMU emulation for qemu.
+ *
+ * Copyright (C) 2012 Chris Wulff <crwulff@gmail.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see
+ * <http://www.gnu.org/licenses/lgpl-2.1.html>
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "cpu.h"
+#include "exec/exec-all.h"
+#include "mmu.h"
+
+#if !defined(CONFIG_USER_ONLY)
+
+/* Define this to enable MMU debug messages */
+/* #define DEBUG_MMU */
+
+#ifdef DEBUG_MMU
+#define MMU_LOG(x) x
+#else
+#define MMU_LOG(x)
+#endif
+
+void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
+              int mmu_idx, uintptr_t retaddr)
+{
+    int ret;
+
+    ret = nios2_cpu_handle_mmu_fault(cs, addr, access_type, mmu_idx);
+    if (unlikely(ret)) {
+        if (retaddr) {
+            /* now we have a real cpu fault */
+            cpu_restore_state(cs, retaddr);
+        }
+        cpu_loop_exit(cs);
+    }
+}
+
+void mmu_read_debug(CPUNios2State *env, uint32_t rn)
+{
+    switch (rn) {
+    case CR_TLBACC:
+        MMU_LOG(qemu_log("TLBACC READ %08X\n", env->regs[rn]));
+        break;
+
+    case CR_TLBMISC:
+        MMU_LOG(qemu_log("TLBMISC READ %08X\n", env->regs[rn]));
+        break;
+
+    case CR_PTEADDR:
+        MMU_LOG(qemu_log("PTEADDR READ %08X\n", env->regs[rn]));
+        break;
+
+    default:
+        break;
+    }
+}
+
+/* rw - 0 = read, 1 = write, 2 = fetch.  */
+unsigned int mmu_translate(CPUNios2State *env,
+                           Nios2MMULookup *lu,
+                           target_ulong vaddr, int rw, int mmu_idx)
+{
+    Nios2CPU *cpu = nios2_env_get_cpu(env);
+    int pid = (env->mmu.tlbmisc_wr & CR_TLBMISC_PID_MASK) >> 4;
+    int vpn = vaddr >> 12;
+
+    MMU_LOG(qemu_log("mmu_translate vaddr %08X, pid %08X, vpn %08X\n",
+                     vaddr, pid, vpn));
+
+    int way;
+    for (way = 0; way < cpu->tlb_num_ways; way++) {
+
+        Nios2TLBEntry *entry =
+            &env->mmu.tlb[(way * cpu->tlb_num_ways) +
+                          (vpn & env->mmu.tlb_entry_mask)];
+
+        MMU_LOG(qemu_log("TLB[%d] TAG %08X, VPN %08X\n",
+                         (way * cpu->tlb_num_ways) +
+                         (vpn & env->mmu.tlb_entry_mask),
+                         entry->tag, (entry->tag >> 12)));
+
+        if (((entry->tag >> 12) != vpn) ||
+            (((entry->tag & (1 << 11)) == 0) &&
+            ((entry->tag & ((1 << cpu->pid_num_bits) - 1)) != pid))) {
+            continue;
+        }
+        lu->vaddr = vaddr & TARGET_PAGE_MASK;
+        lu->paddr = (entry->data & CR_TLBACC_PFN_MASK) << TARGET_PAGE_BITS;
+        lu->prot = ((entry->data & CR_TLBACC_R) ? PAGE_READ : 0) |
+                   ((entry->data & CR_TLBACC_W) ? PAGE_WRITE : 0) |
+                   ((entry->data & CR_TLBACC_X) ? PAGE_EXEC : 0);
+
+        MMU_LOG(qemu_log("HIT TLB[%d] %08X %08X %08X\n",
+                         (way * cpu->tlb_num_ways) +
+                         (vpn & env->mmu.tlb_entry_mask),
+                         lu->vaddr, lu->paddr, lu->prot));
+        return 1;
+    }
+    return 0;
+}
+
+static void mmu_flush_pid(CPUNios2State *env, uint32_t pid)
+{
+    CPUState *cs = ENV_GET_CPU(env);
+    Nios2CPU *cpu = nios2_env_get_cpu(env);
+    int idx;
+    MMU_LOG(qemu_log("TLB Flush PID %d\n", pid));
+
+    for (idx = 0; idx < cpu->tlb_num_entries; idx++) {
+        Nios2TLBEntry *entry = &env->mmu.tlb[idx];
+
+        MMU_LOG(qemu_log("TLB[%d] => %08X %08X\n",
+                         idx, entry->tag, entry->data));
+
+        if ((entry->tag & (1 << 10)) && (!(entry->tag & (1 << 11))) &&
+            ((entry->tag & ((1 << cpu->pid_num_bits) - 1)) == pid)) {
+            uint32_t vaddr = entry->tag & TARGET_PAGE_MASK;
+
+            MMU_LOG(qemu_log("TLB Flush Page %08X\n", vaddr));
+
+            tlb_flush_page(cs, vaddr);
+        }
+    }
+}
+
+void mmu_write(CPUNios2State *env, uint32_t rn, uint32_t v)
+{
+    CPUState *cs = ENV_GET_CPU(env);
+    Nios2CPU *cpu = nios2_env_get_cpu(env);
+
+    MMU_LOG(qemu_log("mmu_write %08X = %08X\n", rn, v));
+
+    switch (rn) {
+    case CR_TLBACC:
+        MMU_LOG(qemu_log("TLBACC: IG %02X, FLAGS %c%c%c%c%c, PFN %05X\n",
+                         v >> CR_TLBACC_IGN_SHIFT,
+                         (v & CR_TLBACC_C) ? 'C' : '.',
+                         (v & CR_TLBACC_R) ? 'R' : '.',
+                         (v & CR_TLBACC_W) ? 'W' : '.',
+                         (v & CR_TLBACC_X) ? 'X' : '.',
+                         (v & CR_TLBACC_G) ? 'G' : '.',
+                         v & CR_TLBACC_PFN_MASK));
+
+        /* if tlbmisc.WE == 1 then trigger a TLB write on writes to TLBACC */
+        if (env->regs[CR_TLBMISC] & CR_TLBMISC_WR) {
+            int way = (env->regs[CR_TLBMISC] >> CR_TLBMISC_WAY_SHIFT);
+            int vpn = (env->mmu.pteaddr_wr & CR_PTEADDR_VPN_MASK) >> 2;
+            int pid = (env->mmu.tlbmisc_wr & CR_TLBMISC_PID_MASK) >> 4;
+            int g = (v & CR_TLBACC_G) ? 1 : 0;
+            int valid = ((vpn & CR_TLBACC_PFN_MASK) < 0xC0000) ? 1 : 0;
+            Nios2TLBEntry *entry =
+                &env->mmu.tlb[(way * cpu->tlb_num_ways) +
+                              (vpn & env->mmu.tlb_entry_mask)];
+            uint32_t newTag = (vpn << 12) | (g << 11) | (valid << 10) | pid;
+            uint32_t newData = v & (CR_TLBACC_C | CR_TLBACC_R | CR_TLBACC_W |
+                                    CR_TLBACC_X | CR_TLBACC_PFN_MASK);
+
+            if ((entry->tag != newTag) || (entry->data != newData)) {
+                if (entry->tag & (1 << 10)) {
+                    /* Flush existing entry */
+                    MMU_LOG(qemu_log("TLB Flush Page (OLD) %08X\n",
+                                     entry->tag & TARGET_PAGE_MASK));
+                    tlb_flush_page(cs, entry->tag & TARGET_PAGE_MASK);
+                }
+                entry->tag = newTag;
+                entry->data = newData;
+                MMU_LOG(qemu_log("TLB[%d] = %08X %08X\n",
+                                 (way * cpu->tlb_num_ways) +
+                                 (vpn & env->mmu.tlb_entry_mask),
+                                 entry->tag, entry->data));
+            }
+            /* Auto-increment tlbmisc.WAY */
+            env->regs[CR_TLBMISC] =
+                (env->regs[CR_TLBMISC] & ~CR_TLBMISC_WAY_MASK) |
+                (((way + 1) & (cpu->tlb_num_ways - 1)) <<
+                 CR_TLBMISC_WAY_SHIFT);
+        }
+
+        /* Writes to TLBACC don't change the read-back value */
+        env->mmu.tlbacc_wr = v;
+        break;
+
+    case CR_TLBMISC:
+        MMU_LOG(qemu_log("TLBMISC: WAY %X, FLAGS %c%c%c%c%c%c, PID %04X\n",
+                         v >> CR_TLBMISC_WAY_SHIFT,
+                         (v & CR_TLBMISC_RD) ? 'R' : '.',
+                         (v & CR_TLBMISC_WR) ? 'W' : '.',
+                         (v & CR_TLBMISC_DBL) ? '2' : '.',
+                         (v & CR_TLBMISC_BAD) ? 'B' : '.',
+                         (v & CR_TLBMISC_PERM) ? 'P' : '.',
+                         (v & CR_TLBMISC_D) ? 'D' : '.',
+                         (v & CR_TLBMISC_PID_MASK) >> 4));
+
+        if ((v & CR_TLBMISC_PID_MASK) !=
+            (env->mmu.tlbmisc_wr & CR_TLBMISC_PID_MASK)) {
+            mmu_flush_pid(env, (env->mmu.tlbmisc_wr & CR_TLBMISC_PID_MASK) >>
+                               CR_TLBMISC_PID_SHIFT);
+        }
+        /* if tlbmisc.RD == 1 then trigger a TLB read on writes to TLBMISC */
+        if (v & CR_TLBMISC_RD) {
+            int way = (v >> CR_TLBMISC_WAY_SHIFT);
+            int vpn = (env->mmu.pteaddr_wr & CR_PTEADDR_VPN_MASK) >> 2;
+            Nios2TLBEntry *entry =
+                &env->mmu.tlb[(way * cpu->tlb_num_ways) +
+                              (vpn & env->mmu.tlb_entry_mask)];
+
+            env->regs[CR_TLBACC] &= CR_TLBACC_IGN_MASK;
+            env->regs[CR_TLBACC] |= entry->data;
+            env->regs[CR_TLBACC] |= (entry->tag & (1 << 11)) ? CR_TLBACC_G : 0;
+            env->regs[CR_TLBMISC] =
+                (v & ~CR_TLBMISC_PID_MASK) |
+                ((entry->tag & ((1 << cpu->pid_num_bits) - 1)) <<
+                 CR_TLBMISC_PID_SHIFT);
+            env->regs[CR_PTEADDR] &= ~CR_PTEADDR_VPN_MASK;
+            env->regs[CR_PTEADDR] |= (entry->tag >> 12) << CR_PTEADDR_VPN_SHIFT;
+            MMU_LOG(qemu_log("TLB READ way %d, vpn %05X, tag %08X, data %08X, "
+                             "tlbacc %08X, tlbmisc %08X, pteaddr %08X\n",
+                             way, vpn, entry->tag, entry->data,
+                             env->regs[CR_TLBACC], env->regs[CR_TLBMISC],
+                             env->regs[CR_PTEADDR]));
+        } else {
+            env->regs[CR_TLBMISC] = v;
+        }
+
+        env->mmu.tlbmisc_wr = v;
+        break;
+
+    case CR_PTEADDR:
+        MMU_LOG(qemu_log("PTEADDR: PTBASE %03X, VPN %05X\n",
+                         v >> CR_PTEADDR_PTBASE_SHIFT,
+                         (v & CR_PTEADDR_VPN_MASK) >> CR_PTEADDR_VPN_SHIFT));
+
+        /* Writes to PTEADDR don't change the read-back VPN value */
+        env->regs[CR_PTEADDR] = (v & ~CR_PTEADDR_VPN_MASK) |
+                                (env->regs[CR_PTEADDR] & CR_PTEADDR_VPN_MASK);
+        env->mmu.pteaddr_wr = v;
+        break;
+
+    default:
+        break;
+    }
+}
+
+void mmu_init(CPUNios2State *env)
+{
+    Nios2CPU *cpu = nios2_env_get_cpu(env);
+    Nios2MMU *mmu = &env->mmu;
+
+    MMU_LOG(qemu_log("mmu_init\n"));
+
+    mmu->tlb_entry_mask = (cpu->tlb_num_entries / cpu->tlb_num_ways) - 1;
+    mmu->tlb = g_new0(Nios2TLBEntry, cpu->tlb_num_entries);
+}
+
+void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUNios2State *env)
+{
+    Nios2CPU *cpu = nios2_env_get_cpu(env);
+    int i;
+
+    cpu_fprintf(f, "MMU: ways %d, entries %d, pid bits %d\n",
+                cpu->tlb_num_ways, cpu->tlb_num_entries,
+                cpu->pid_num_bits);
+
+    for (i = 0; i < cpu->tlb_num_entries; i++) {
+        Nios2TLBEntry *entry = &env->mmu.tlb[i];
+        cpu_fprintf(f, "TLB[%d] = %08X %08X %c VPN %05X "
+                    "PID %02X %c PFN %05X %c%c%c%c\n",
+                    i, entry->tag, entry->data,
+                    (entry->tag & (1 << 10)) ? 'V' : '-',
+                    entry->tag >> 12,
+                    entry->tag & ((1 << cpu->pid_num_bits) - 1),
+                    (entry->tag & (1 << 11)) ? 'G' : '-',
+                    entry->data & CR_TLBACC_PFN_MASK,
+                    (entry->data & CR_TLBACC_C) ? 'C' : '-',
+                    (entry->data & CR_TLBACC_R) ? 'R' : '-',
+                    (entry->data & CR_TLBACC_W) ? 'W' : '-',
+                    (entry->data & CR_TLBACC_X) ? 'X' : '-');
+    }
+}
+
+#endif /* !CONFIG_USER_ONLY */
diff --git a/target/nios2/mmu.h b/target/nios2/mmu.h
new file mode 100644
index 0000000..51d3d1f
--- /dev/null
+++ b/target/nios2/mmu.h
@@ -0,0 +1,50 @@
+/*
+ * Altera Nios II MMU emulation for qemu.
+ *
+ * Copyright (C) 2012 Chris Wulff <crwulff@gmail.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see
+ * <http://www.gnu.org/licenses/lgpl-2.1.html>
+ */
+#ifndef MMU_NIOS2_H
+#define MMU_NIOS2_H
+
+typedef struct Nios2TLBEntry {
+    target_ulong tag;
+    target_ulong data;
+} Nios2TLBEntry;
+
+typedef struct Nios2MMU {
+    int tlb_entry_mask;
+    uint32_t pteaddr_wr;
+    uint32_t tlbacc_wr;
+    uint32_t tlbmisc_wr;
+    Nios2TLBEntry *tlb;
+} Nios2MMU;
+
+typedef struct Nios2MMULookup {
+    target_ulong vaddr;
+    target_ulong paddr;
+    int prot;
+} Nios2MMULookup;
+
+void mmu_flip_um(CPUNios2State *env, unsigned int um);
+unsigned int mmu_translate(CPUNios2State *env,
+                           Nios2MMULookup *lu,
+                           target_ulong vaddr, int rw, int mmu_idx);
+void mmu_read_debug(CPUNios2State *env, uint32_t rn);
+void mmu_write(CPUNios2State *env, uint32_t rn, uint32_t v);
+void mmu_init(CPUNios2State *env);
+
+#endif /* MMU_NIOS2_H */
diff --git a/target/nios2/monitor.c b/target/nios2/monitor.c
new file mode 100644
index 0000000..422c816
--- /dev/null
+++ b/target/nios2/monitor.c
@@ -0,0 +1,35 @@
+/*
+ * QEMU monitor
+ *
+ * Copyright (c) 2003-2004 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "monitor/monitor.h"
+#include "monitor/hmp-target.h"
+#include "hmp.h"
+
+void hmp_info_tlb(Monitor *mon, const QDict *qdict)
+{
+    CPUArchState *env1 = mon_get_cpu_env();
+
+    dump_mmu((FILE *)mon, (fprintf_function)monitor_printf, env1);
+}
diff --git a/target/nios2/op_helper.c b/target/nios2/op_helper.c
new file mode 100644
index 0000000..538853c
--- /dev/null
+++ b/target/nios2/op_helper.c
@@ -0,0 +1,47 @@
+/*
+ * Altera Nios II helper routines.
+ *
+ * Copyright (C) 2012 Chris Wulff <crwulff@gmail.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see
+ * <http://www.gnu.org/licenses/lgpl-2.1.html>
+ */
+
+#include "cpu.h"
+#include "exec/helper-proto.h"
+#include "exec/cpu_ldst.h"
+
+#if !defined(CONFIG_USER_ONLY)
+void helper_mmu_read_debug(CPUNios2State *env, uint32_t rn)
+{
+    mmu_read_debug(env, rn);
+}
+
+void helper_mmu_write(CPUNios2State *env, uint32_t rn, uint32_t v)
+{
+    mmu_write(env, rn, v);
+}
+
+void helper_check_interrupts(CPUNios2State *env)
+{
+    nios2_check_interrupts(env);
+}
+#endif /* !CONFIG_USER_ONLY */
+
+void helper_raise_exception(CPUNios2State *env, uint32_t index)
+{
+    CPUState *cs = ENV_GET_CPU(env);
+    cs->exception_index = index;
+    cpu_loop_exit(cs);
+}
diff --git a/target/nios2/translate.c b/target/nios2/translate.c
new file mode 100644
index 0000000..2d73839
--- /dev/null
+++ b/target/nios2/translate.c
@@ -0,0 +1,958 @@
+/*
+ * Altera Nios II emulation for qemu: main translation routines.
+ *
+ * Copyright (C) 2016 Marek Vasut <marex@denx.de>
+ * Copyright (C) 2012 Chris Wulff <crwulff@gmail.com>
+ * Copyright (C) 2010 Tobias Klauser <tklauser@distanz.ch>
+ *  (Portions of this file that were originally from nios2sim-ng.)
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see
+ * <http://www.gnu.org/licenses/lgpl-2.1.html>
+ */
+
+#include "cpu.h"
+#include "tcg-op.h"
+#include "exec/exec-all.h"
+#include "disas/disas.h"
+#include "exec/helper-proto.h"
+#include "exec/helper-gen.h"
+#include "exec/log.h"
+#include "exec/cpu_ldst.h"
+
+#define INSTRUCTION_FLG(func, flags) { (func), (flags) }
+#define INSTRUCTION(func)                  \
+        INSTRUCTION_FLG(func, 0)
+#define INSTRUCTION_NOP()                  \
+        INSTRUCTION_FLG(nop, 0)
+#define INSTRUCTION_UNIMPLEMENTED()        \
+        INSTRUCTION_FLG(gen_excp, EXCP_UNIMPL)
+#define INSTRUCTION_ILLEGAL()              \
+        INSTRUCTION_FLG(gen_excp, EXCP_ILLEGAL)
+
+/* Special R-Type instruction opcode */
+#define INSN_R_TYPE 0x3A
+
+/* I-Type instruction parsing */
+#define I_TYPE(instr, code)                \
+    struct {                               \
+        uint8_t op;                        \
+        union {                            \
+            uint16_t imm16;                \
+            int16_t imm16s;                \
+        };                                 \
+        uint8_t b;                         \
+        uint8_t a;                         \
+    } (instr) = {                          \
+        .op    = extract32((code), 0, 6),  \
+        .imm16 = extract32((code), 6, 16), \
+        .b     = extract32((code), 22, 5), \
+        .a     = extract32((code), 27, 5), \
+    }
+
+/* R-Type instruction parsing */
+#define R_TYPE(instr, code)                \
+    struct {                               \
+        uint8_t op;                        \
+        uint8_t imm5;                      \
+        uint8_t opx;                       \
+        uint8_t c;                         \
+        uint8_t b;                         \
+        uint8_t a;                         \
+    } (instr) = {                          \
+        .op    = extract32((code), 0, 6),  \
+        .imm5  = extract32((code), 6, 5),  \
+        .opx   = extract32((code), 11, 6), \
+        .c     = extract32((code), 17, 5), \
+        .b     = extract32((code), 22, 5), \
+        .a     = extract32((code), 27, 5), \
+    }
+
+/* J-Type instruction parsing */
+#define J_TYPE(instr, code)                \
+    struct {                               \
+        uint8_t op;                        \
+        uint32_t imm26;                    \
+    } (instr) = {                          \
+        .op    = extract32((code), 0, 6),  \
+        .imm26 = extract32((code), 6, 26), \
+    }
+
+typedef struct DisasContext {
+    TCGv_ptr          cpu_env;
+    TCGv             *cpu_R;
+    TCGv_i32          zero;
+    int               is_jmp;
+    target_ulong      pc;
+    TranslationBlock *tb;
+    int               mem_idx;
+    bool              singlestep_enabled;
+} DisasContext;
+
+typedef struct Nios2Instruction {
+    void     (*handler)(DisasContext *dc, uint32_t code, uint32_t flags);
+    uint32_t  flags;
+} Nios2Instruction;
+
+static uint8_t get_opcode(uint32_t code)
+{
+    I_TYPE(instr, code);
+    return instr.op;
+}
+
+static uint8_t get_opxcode(uint32_t code)
+{
+    R_TYPE(instr, code);
+    return instr.opx;
+}
+
+static TCGv load_zero(DisasContext *dc)
+{
+    if (TCGV_IS_UNUSED_I32(dc->zero)) {
+        dc->zero = tcg_const_i32(0);
+    }
+    return dc->zero;
+}
+
+static TCGv load_gpr(DisasContext *dc, uint8_t reg)
+{
+    if (likely(reg != R_ZERO)) {
+        return dc->cpu_R[reg];
+    } else {
+        return load_zero(dc);
+    }
+}
+
+static void t_gen_helper_raise_exception(DisasContext *dc,
+                                         uint32_t index)
+{
+    TCGv_i32 tmp = tcg_const_i32(index);
+
+    tcg_gen_movi_tl(dc->cpu_R[R_PC], dc->pc);
+    gen_helper_raise_exception(dc->cpu_env, tmp);
+    tcg_temp_free_i32(tmp);
+    dc->is_jmp = DISAS_UPDATE;
+}
+
+static bool use_goto_tb(DisasContext *dc, uint32_t dest)
+{
+    if (unlikely(dc->singlestep_enabled)) {
+        return false;
+    }
+
+#ifndef CONFIG_USER_ONLY
+    return (dc->tb->pc & TARGET_PAGE_MASK) == (dest & TARGET_PAGE_MASK);
+#else
+    return true;
+#endif
+}
+
+static void gen_goto_tb(DisasContext *dc, int n, uint32_t dest)
+{
+    TranslationBlock *tb = dc->tb;
+
+    if (use_goto_tb(dc, dest)) {
+        tcg_gen_goto_tb(n);
+        tcg_gen_movi_tl(dc->cpu_R[R_PC], dest);
+        tcg_gen_exit_tb((tcg_target_long)tb + n);
+    } else {
+        tcg_gen_movi_tl(dc->cpu_R[R_PC], dest);
+        tcg_gen_exit_tb(0);
+    }
+}
+
+static void gen_excp(DisasContext *dc, uint32_t code, uint32_t flags)
+{
+    t_gen_helper_raise_exception(dc, flags);
+}
+
+static void gen_check_supervisor(DisasContext *dc)
+{
+    if (dc->tb->flags & CR_STATUS_U) {
+        /* CPU in user mode, privileged instruction called, stop. */
+        t_gen_helper_raise_exception(dc, EXCP_SUPERI);
+    }
+}
+
+/*
+ * Used as a placeholder for all instructions which do not have
+ * an effect on the simulator (e.g. flush, sync)
+ */
+static void nop(DisasContext *dc, uint32_t code, uint32_t flags)
+{
+    /* Nothing to do here */
+}
+
+/*
+ * J-Type instructions
+ */
+static void jmpi(DisasContext *dc, uint32_t code, uint32_t flags)
+{
+    J_TYPE(instr, code);
+    gen_goto_tb(dc, 0, (dc->pc & 0xF0000000) | (instr.imm26 << 2));
+    dc->is_jmp = DISAS_TB_JUMP;
+}
+
+static void call(DisasContext *dc, uint32_t code, uint32_t flags)
+{
+    tcg_gen_movi_tl(dc->cpu_R[R_RA], dc->pc + 4);
+    jmpi(dc, code, flags);
+}
+
+/*
+ * I-Type instructions
+ */
+/* Load instructions */
+static void gen_ldx(DisasContext *dc, uint32_t code, uint32_t flags)
+{
+    I_TYPE(instr, code);
+
+    TCGv addr = tcg_temp_new();
+    TCGv data;
+
+    /*
+     * WARNING: Loads into R_ZERO are ignored, but we must generate the
+     *          memory access itself to emulate the CPU precisely. Load
+     *          from a protected page to R_ZERO will cause SIGSEGV on
+     *          the Nios2 CPU.
+     */
+    if (likely(instr.b != R_ZERO)) {
+        data = dc->cpu_R[instr.b];
+    } else {
+        data = tcg_temp_new();
+    }
+
+    tcg_gen_addi_tl(addr, load_gpr(dc, instr.a), instr.imm16s);
+    tcg_gen_qemu_ld_tl(data, addr, dc->mem_idx, flags);
+
+    if (unlikely(instr.b == R_ZERO)) {
+        tcg_temp_free(data);
+    }
+
+    tcg_temp_free(addr);
+}
+
+/* Store instructions */
+static void gen_stx(DisasContext *dc, uint32_t code, uint32_t flags)
+{
+    I_TYPE(instr, code);
+    TCGv val = load_gpr(dc, instr.b);
+
+    TCGv addr = tcg_temp_new();
+    tcg_gen_addi_tl(addr, load_gpr(dc, instr.a), instr.imm16s);
+    tcg_gen_qemu_st_tl(val, addr, dc->mem_idx, flags);
+    tcg_temp_free(addr);
+}
+
+/* Branch instructions */
+static void br(DisasContext *dc, uint32_t code, uint32_t flags)
+{
+    I_TYPE(instr, code);
+
+    gen_goto_tb(dc, 0, dc->pc + 4 + (instr.imm16s & -4));
+    dc->is_jmp = DISAS_TB_JUMP;
+}
+
+static void gen_bxx(DisasContext *dc, uint32_t code, uint32_t flags)
+{
+    I_TYPE(instr, code);
+
+    TCGLabel *l1 = gen_new_label();
+    tcg_gen_brcond_tl(flags, dc->cpu_R[instr.a], dc->cpu_R[instr.b], l1);
+    gen_goto_tb(dc, 0, dc->pc + 4);
+    gen_set_label(l1);
+    gen_goto_tb(dc, 1, dc->pc + 4 + (instr.imm16s & -4));
+    dc->is_jmp = DISAS_TB_JUMP;
+}
+
+/* Comparison instructions */
+#define gen_i_cmpxx(fname, op3)                                              \
+static void (fname)(DisasContext *dc, uint32_t code, uint32_t flags)         \
+{                                                                            \
+    I_TYPE(instr, (code));                                                   \
+    tcg_gen_setcondi_tl(flags, (dc)->cpu_R[instr.b], (dc)->cpu_R[instr.a],   \
+                        (op3));                                              \
+}
+
+gen_i_cmpxx(gen_cmpxxsi, instr.imm16s)
+gen_i_cmpxx(gen_cmpxxui, instr.imm16)
+
+/* Math/logic instructions */
+#define gen_i_math_logic(fname, insn, resimm, op3)                          \
+static void (fname)(DisasContext *dc, uint32_t code, uint32_t flags)        \
+{                                                                           \
+    I_TYPE(instr, (code));                                                  \
+    if (unlikely(instr.b == R_ZERO)) { /* Store to R_ZERO is ignored */     \
+        return;                                                             \
+    } else if (instr.a == R_ZERO) { /* MOVxI optimizations */               \
+        tcg_gen_movi_tl(dc->cpu_R[instr.b], (resimm) ? (op3) : 0);          \
+    } else {                                                                \
+        tcg_gen_##insn##_tl((dc)->cpu_R[instr.b], (dc)->cpu_R[instr.a],     \
+                            (op3));                                         \
+    }                                                                       \
+}
+
+gen_i_math_logic(addi,  addi, 1, instr.imm16s)
+gen_i_math_logic(muli,  muli, 0, instr.imm16s)
+
+gen_i_math_logic(andi,  andi, 0, instr.imm16)
+gen_i_math_logic(ori,   ori,  1, instr.imm16)
+gen_i_math_logic(xori,  xori, 1, instr.imm16)
+
+gen_i_math_logic(andhi, andi, 0, instr.imm16 << 16)
+gen_i_math_logic(orhi , ori,  1, instr.imm16 << 16)
+gen_i_math_logic(xorhi, xori, 1, instr.imm16 << 16)
+
+/* Prototype only, defined below */
+static void handle_r_type_instr(DisasContext *dc, uint32_t code,
+                                uint32_t flags);
+
+static const Nios2Instruction i_type_instructions[] = {
+    INSTRUCTION(call),                                /* call */
+    INSTRUCTION(jmpi),                                /* jmpi */
+    INSTRUCTION_ILLEGAL(),
+    INSTRUCTION_FLG(gen_ldx, MO_UB),                  /* ldbu */
+    INSTRUCTION(addi),                                /* addi */
+    INSTRUCTION_FLG(gen_stx, MO_UB),                  /* stb */
+    INSTRUCTION(br),                                  /* br */
+    INSTRUCTION_FLG(gen_ldx, MO_SB),                  /* ldb */
+    INSTRUCTION_FLG(gen_cmpxxsi, TCG_COND_GE),        /* cmpgei */
+    INSTRUCTION_ILLEGAL(),
+    INSTRUCTION_ILLEGAL(),
+    INSTRUCTION_FLG(gen_ldx, MO_UW),                  /* ldhu */
+    INSTRUCTION(andi),                                /* andi */
+    INSTRUCTION_FLG(gen_stx, MO_UW),                  /* sth */
+    INSTRUCTION_FLG(gen_bxx, TCG_COND_GE),            /* bge */
+    INSTRUCTION_FLG(gen_ldx, MO_SW),                  /* ldh */
+    INSTRUCTION_FLG(gen_cmpxxsi, TCG_COND_LT),        /* cmplti */
+    INSTRUCTION_ILLEGAL(),
+    INSTRUCTION_ILLEGAL(),
+    INSTRUCTION_NOP(),                                /* initda */
+    INSTRUCTION(ori),                                 /* ori */
+    INSTRUCTION_FLG(gen_stx, MO_UL),                  /* stw */
+    INSTRUCTION_FLG(gen_bxx, TCG_COND_LT),            /* blt */
+    INSTRUCTION_FLG(gen_ldx, MO_UL),                  /* ldw */
+    INSTRUCTION_FLG(gen_cmpxxsi, TCG_COND_NE),        /* cmpnei */
+    INSTRUCTION_ILLEGAL(),
+    INSTRUCTION_ILLEGAL(),
+    INSTRUCTION_NOP(),                                /* flushda */
+    INSTRUCTION(xori),                                /* xori */
+    INSTRUCTION_ILLEGAL(),
+    INSTRUCTION_FLG(gen_bxx, TCG_COND_NE),            /* bne */
+    INSTRUCTION_ILLEGAL(),
+    INSTRUCTION_FLG(gen_cmpxxsi, TCG_COND_EQ),        /* cmpeqi */
+    INSTRUCTION_ILLEGAL(),
+    INSTRUCTION_ILLEGAL(),
+    INSTRUCTION_FLG(gen_ldx, MO_UB),                  /* ldbuio */
+    INSTRUCTION(muli),                                /* muli */
+    INSTRUCTION_FLG(gen_stx, MO_UB),                  /* stbio */
+    INSTRUCTION_FLG(gen_bxx, TCG_COND_EQ),            /* beq */
+    INSTRUCTION_FLG(gen_ldx, MO_SB),                  /* ldbio */
+    INSTRUCTION_FLG(gen_cmpxxui, TCG_COND_GEU),       /* cmpgeui */
+    INSTRUCTION_ILLEGAL(),
+    INSTRUCTION_ILLEGAL(),
+    INSTRUCTION_FLG(gen_ldx, MO_UW),                  /* ldhuio */
+    INSTRUCTION(andhi),                               /* andhi */
+    INSTRUCTION_FLG(gen_stx, MO_UW),                  /* sthio */
+    INSTRUCTION_FLG(gen_bxx, TCG_COND_GEU),           /* bgeu */
+    INSTRUCTION_FLG(gen_ldx, MO_SW),                  /* ldhio */
+    INSTRUCTION_FLG(gen_cmpxxui, TCG_COND_LTU),       /* cmpltui */
+    INSTRUCTION_ILLEGAL(),
+    INSTRUCTION_UNIMPLEMENTED(),                      /* custom */
+    INSTRUCTION_NOP(),                                /* initd */
+    INSTRUCTION(orhi),                                /* orhi */
+    INSTRUCTION_FLG(gen_stx, MO_SL),                  /* stwio */
+    INSTRUCTION_FLG(gen_bxx, TCG_COND_LTU),           /* bltu */
+    INSTRUCTION_FLG(gen_ldx, MO_UL),                  /* ldwio */
+    INSTRUCTION_UNIMPLEMENTED(),                      /* rdprs */
+    INSTRUCTION_ILLEGAL(),
+    INSTRUCTION_FLG(handle_r_type_instr, 0),          /* R-Type */
+    INSTRUCTION_NOP(),                                /* flushd */
+    INSTRUCTION(xorhi),                               /* xorhi */
+    INSTRUCTION_ILLEGAL(),
+    INSTRUCTION_ILLEGAL(),
+    INSTRUCTION_ILLEGAL(),
+};
+
+/*
+ * R-Type instructions
+ */
+/*
+ * status <- estatus
+ * PC <- ea
+ */
+static void eret(DisasContext *dc, uint32_t code, uint32_t flags)
+{
+    tcg_gen_mov_tl(dc->cpu_R[CR_STATUS], dc->cpu_R[CR_ESTATUS]);
+    tcg_gen_mov_tl(dc->cpu_R[R_PC], dc->cpu_R[R_EA]);
+
+    dc->is_jmp = DISAS_JUMP;
+}
+
+/* PC <- ra */
+static void ret(DisasContext *dc, uint32_t code, uint32_t flags)
+{
+    tcg_gen_mov_tl(dc->cpu_R[R_PC], dc->cpu_R[R_RA]);
+
+    dc->is_jmp = DISAS_JUMP;
+}
+
+/* PC <- ba */
+static void bret(DisasContext *dc, uint32_t code, uint32_t flags)
+{
+    tcg_gen_mov_tl(dc->cpu_R[R_PC], dc->cpu_R[R_BA]);
+
+    dc->is_jmp = DISAS_JUMP;
+}
+
+/* PC <- rA */
+static void jmp(DisasContext *dc, uint32_t code, uint32_t flags)
+{
+    R_TYPE(instr, code);
+
+    tcg_gen_mov_tl(dc->cpu_R[R_PC], load_gpr(dc, instr.a));
+
+    dc->is_jmp = DISAS_JUMP;
+}
+
+/* rC <- PC + 4 */
+static void nextpc(DisasContext *dc, uint32_t code, uint32_t flags)
+{
+    R_TYPE(instr, code);
+
+    if (likely(instr.c != R_ZERO)) {
+        tcg_gen_movi_tl(dc->cpu_R[instr.c], dc->pc + 4);
+    }
+}
+
+/*
+ * ra <- PC + 4
+ * PC <- rA
+ */
+static void callr(DisasContext *dc, uint32_t code, uint32_t flags)
+{
+    R_TYPE(instr, code);
+
+    tcg_gen_mov_tl(dc->cpu_R[R_PC], load_gpr(dc, instr.a));
+    tcg_gen_movi_tl(dc->cpu_R[R_RA], dc->pc + 4);
+
+    dc->is_jmp = DISAS_JUMP;
+}
+
+/* rC <- ctlN */
+static void rdctl(DisasContext *dc, uint32_t code, uint32_t flags)
+{
+    R_TYPE(instr, code);
+
+    gen_check_supervisor(dc);
+
+    switch (instr.imm5 + CR_BASE) {
+    case CR_PTEADDR:
+    case CR_TLBACC:
+    case CR_TLBMISC:
+    {
+#if !defined(CONFIG_USER_ONLY)
+        if (likely(instr.c != R_ZERO)) {
+            tcg_gen_mov_tl(dc->cpu_R[instr.c], dc->cpu_R[instr.imm5 + CR_BASE]);
+#ifdef DEBUG_MMU
+            TCGv_i32 tmp = tcg_const_i32(instr.imm5 + CR_BASE);
+            gen_helper_mmu_read_debug(dc->cpu_R[instr.c], dc->cpu_env, tmp);
+            tcg_temp_free_i32(tmp);
+#endif
+        }
+#endif
+        break;
+    }
+
+    default:
+        if (likely(instr.c != R_ZERO)) {
+            tcg_gen_mov_tl(dc->cpu_R[instr.c], dc->cpu_R[instr.imm5 + CR_BASE]);
+        }
+        break;
+    }
+}
+
+/* ctlN <- rA */
+static void wrctl(DisasContext *dc, uint32_t code, uint32_t flags)
+{
+    R_TYPE(instr, code);
+
+    gen_check_supervisor(dc);
+
+    switch (instr.imm5 + CR_BASE) {
+    case CR_PTEADDR:
+    case CR_TLBACC:
+    case CR_TLBMISC:
+    {
+#if !defined(CONFIG_USER_ONLY)
+        TCGv_i32 tmp = tcg_const_i32(instr.imm5 + CR_BASE);
+        gen_helper_mmu_write(dc->cpu_env, tmp, load_gpr(dc, instr.a));
+        tcg_temp_free_i32(tmp);
+#endif
+        break;
+    }
+
+    default:
+        tcg_gen_mov_tl(dc->cpu_R[instr.imm5 + CR_BASE], load_gpr(dc, instr.a));
+        break;
+    }
+
+    /* If interrupts were enabled using WRCTL, trigger them. */
+#if !defined(CONFIG_USER_ONLY)
+    if ((instr.imm5 + CR_BASE) == CR_STATUS) {
+        gen_helper_check_interrupts(dc->cpu_env);
+    }
+#endif
+}
+
+/* Comparison instructions */
+static void gen_cmpxx(DisasContext *dc, uint32_t code, uint32_t flags)
+{
+    R_TYPE(instr, code);
+    if (likely(instr.c != R_ZERO)) {
+        tcg_gen_setcond_tl(flags, dc->cpu_R[instr.c], dc->cpu_R[instr.a],
+                           dc->cpu_R[instr.b]);
+    }
+}
+
+/* Math/logic instructions */
+#define gen_r_math_logic(fname, insn, op3)                                 \
+static void (fname)(DisasContext *dc, uint32_t code, uint32_t flags)       \
+{                                                                          \
+    R_TYPE(instr, (code));                                                 \
+    if (likely(instr.c != R_ZERO)) {                                       \
+        tcg_gen_##insn((dc)->cpu_R[instr.c], load_gpr((dc), instr.a),      \
+                       (op3));                                             \
+    }                                                                      \
+}
+
+gen_r_math_logic(add,  add_tl,   load_gpr(dc, instr.b))
+gen_r_math_logic(sub,  sub_tl,   load_gpr(dc, instr.b))
+gen_r_math_logic(mul,  mul_tl,   load_gpr(dc, instr.b))
+
+gen_r_math_logic(and,  and_tl,   load_gpr(dc, instr.b))
+gen_r_math_logic(or,   or_tl,    load_gpr(dc, instr.b))
+gen_r_math_logic(xor,  xor_tl,   load_gpr(dc, instr.b))
+gen_r_math_logic(nor,  nor_tl,   load_gpr(dc, instr.b))
+
+gen_r_math_logic(srai, sari_tl,  instr.imm5)
+gen_r_math_logic(srli, shri_tl,  instr.imm5)
+gen_r_math_logic(slli, shli_tl,  instr.imm5)
+gen_r_math_logic(roli, rotli_tl, instr.imm5)
+
+#define gen_r_mul(fname, insn)                                         \
+static void (fname)(DisasContext *dc, uint32_t code, uint32_t flags)   \
+{                                                                      \
+    R_TYPE(instr, (code));                                             \
+    if (likely(instr.c != R_ZERO)) {                                   \
+        TCGv t0 = tcg_temp_new();                                      \
+        tcg_gen_##insn(t0, dc->cpu_R[instr.c],                         \
+                       load_gpr(dc, instr.a), load_gpr(dc, instr.b)); \
+        tcg_temp_free(t0);                                             \
+    }                                                                  \
+}
+
+gen_r_mul(mulxss, muls2_tl)
+gen_r_mul(mulxuu, mulu2_tl)
+gen_r_mul(mulxsu, mulsu2_tl)
+
+#define gen_r_shift_s(fname, insn)                                         \
+static void (fname)(DisasContext *dc, uint32_t code, uint32_t flags)       \
+{                                                                          \
+    R_TYPE(instr, (code));                                                 \
+    if (likely(instr.c != R_ZERO)) {                                       \
+        TCGv t0 = tcg_temp_new();                                          \
+        tcg_gen_andi_tl(t0, load_gpr((dc), instr.b), 31);                  \
+        tcg_gen_##insn((dc)->cpu_R[instr.c], load_gpr((dc), instr.a), t0); \
+        tcg_temp_free(t0);                                                 \
+    }                                                                      \
+}
+
+gen_r_shift_s(sra, sar_tl)
+gen_r_shift_s(srl, shr_tl)
+gen_r_shift_s(sll, shl_tl)
+gen_r_shift_s(rol, rotl_tl)
+gen_r_shift_s(ror, rotr_tl)
+
+static void divs(DisasContext *dc, uint32_t code, uint32_t flags)
+{
+    R_TYPE(instr, (code));
+
+    /* Stores into R_ZERO are ignored */
+    if (unlikely(instr.c == R_ZERO)) {
+        return;
+    }
+
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+    TCGv t2 = tcg_temp_new();
+    TCGv t3 = tcg_temp_new();
+
+    tcg_gen_ext32s_tl(t0, load_gpr(dc, instr.a));
+    tcg_gen_ext32s_tl(t1, load_gpr(dc, instr.b));
+    tcg_gen_setcondi_tl(TCG_COND_EQ, t2, t0, INT_MIN);
+    tcg_gen_setcondi_tl(TCG_COND_EQ, t3, t1, -1);
+    tcg_gen_and_tl(t2, t2, t3);
+    tcg_gen_setcondi_tl(TCG_COND_EQ, t3, t1, 0);
+    tcg_gen_or_tl(t2, t2, t3);
+    tcg_gen_movi_tl(t3, 0);
+    tcg_gen_movcond_tl(TCG_COND_NE, t1, t2, t3, t2, t1);
+    tcg_gen_div_tl(dc->cpu_R[instr.c], t0, t1);
+    tcg_gen_ext32s_tl(dc->cpu_R[instr.c], dc->cpu_R[instr.c]);
+
+    tcg_temp_free(t3);
+    tcg_temp_free(t2);
+    tcg_temp_free(t1);
+    tcg_temp_free(t0);
+}
+
+static void divu(DisasContext *dc, uint32_t code, uint32_t flags)
+{
+    R_TYPE(instr, (code));
+
+    /* Stores into R_ZERO are ignored */
+    if (unlikely(instr.c == R_ZERO)) {
+        return;
+    }
+
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+    TCGv t2 = tcg_const_tl(0);
+    TCGv t3 = tcg_const_tl(1);
+
+    tcg_gen_ext32u_tl(t0, load_gpr(dc, instr.a));
+    tcg_gen_ext32u_tl(t1, load_gpr(dc, instr.b));
+    tcg_gen_movcond_tl(TCG_COND_EQ, t1, t1, t2, t3, t1);
+    tcg_gen_divu_tl(dc->cpu_R[instr.c], t0, t1);
+    tcg_gen_ext32s_tl(dc->cpu_R[instr.c], dc->cpu_R[instr.c]);
+
+    tcg_temp_free(t3);
+    tcg_temp_free(t2);
+    tcg_temp_free(t1);
+    tcg_temp_free(t0);
+}
+
+static const Nios2Instruction r_type_instructions[] = {
+    INSTRUCTION_ILLEGAL(),
+    INSTRUCTION(eret),                                /* eret */
+    INSTRUCTION(roli),                                /* roli */
+    INSTRUCTION(rol),                                 /* rol */
+    INSTRUCTION_NOP(),                                /* flushp */
+    INSTRUCTION(ret),                                 /* ret */
+    INSTRUCTION(nor),                                 /* nor */
+    INSTRUCTION(mulxuu),                              /* mulxuu */
+    INSTRUCTION_FLG(gen_cmpxx, TCG_COND_GE),          /* cmpge */
+    INSTRUCTION(bret),                                /* bret */
+    INSTRUCTION_ILLEGAL(),
+    INSTRUCTION(ror),                                 /* ror */
+    INSTRUCTION_NOP(),                                /* flushi */
+    INSTRUCTION(jmp),                                 /* jmp */
+    INSTRUCTION(and),                                 /* and */
+    INSTRUCTION_ILLEGAL(),
+    INSTRUCTION_FLG(gen_cmpxx, TCG_COND_LT),          /* cmplt */
+    INSTRUCTION_ILLEGAL(),
+    INSTRUCTION(slli),                                /* slli */
+    INSTRUCTION(sll),                                 /* sll */
+    INSTRUCTION_UNIMPLEMENTED(),                      /* wrprs */
+    INSTRUCTION_ILLEGAL(),
+    INSTRUCTION(or),                                  /* or */
+    INSTRUCTION(mulxsu),                              /* mulxsu */
+    INSTRUCTION_FLG(gen_cmpxx, TCG_COND_NE),          /* cmpne */
+    INSTRUCTION_ILLEGAL(),
+    INSTRUCTION(srli),                                /* srli */
+    INSTRUCTION(srl),                                 /* srl */
+    INSTRUCTION(nextpc),                              /* nextpc */
+    INSTRUCTION(callr),                               /* callr */
+    INSTRUCTION(xor),                                 /* xor */
+    INSTRUCTION(mulxss),                              /* mulxss */
+    INSTRUCTION_FLG(gen_cmpxx, TCG_COND_EQ),          /* cmpeq */
+    INSTRUCTION_ILLEGAL(),
+    INSTRUCTION_ILLEGAL(),
+    INSTRUCTION_ILLEGAL(),
+    INSTRUCTION(divu),                                /* divu */
+    INSTRUCTION(divs),                                /* div */
+    INSTRUCTION(rdctl),                               /* rdctl */
+    INSTRUCTION(mul),                                 /* mul */
+    INSTRUCTION_FLG(gen_cmpxx, TCG_COND_GEU),         /* cmpgeu */
+    INSTRUCTION_NOP(),                                /* initi */
+    INSTRUCTION_ILLEGAL(),
+    INSTRUCTION_ILLEGAL(),
+    INSTRUCTION_ILLEGAL(),
+    INSTRUCTION_FLG(gen_excp, EXCP_TRAP),             /* trap */
+    INSTRUCTION(wrctl),                               /* wrctl */
+    INSTRUCTION_ILLEGAL(),
+    INSTRUCTION_FLG(gen_cmpxx, TCG_COND_LTU),         /* cmpltu */
+    INSTRUCTION(add),                                 /* add */
+    INSTRUCTION_ILLEGAL(),
+    INSTRUCTION_ILLEGAL(),
+    INSTRUCTION_FLG(gen_excp, EXCP_BREAK),            /* break */
+    INSTRUCTION_ILLEGAL(),
+    INSTRUCTION(nop),                                 /* nop */
+    INSTRUCTION_ILLEGAL(),
+    INSTRUCTION_ILLEGAL(),
+    INSTRUCTION(sub),                                 /* sub */
+    INSTRUCTION(srai),                                /* srai */
+    INSTRUCTION(sra),                                 /* sra */
+    INSTRUCTION_ILLEGAL(),
+    INSTRUCTION_ILLEGAL(),
+    INSTRUCTION_ILLEGAL(),
+    INSTRUCTION_ILLEGAL(),
+};
+
+static void handle_r_type_instr(DisasContext *dc, uint32_t code, uint32_t flags)
+{
+    uint8_t opx;
+    const Nios2Instruction *instr;
+
+    opx = get_opxcode(code);
+    if (unlikely(opx >= ARRAY_SIZE(r_type_instructions))) {
+        goto illegal_op;
+    }
+
+    instr = &r_type_instructions[opx];
+    instr->handler(dc, code, instr->flags);
+
+    return;
+
+illegal_op:
+    t_gen_helper_raise_exception(dc, EXCP_ILLEGAL);
+}
+
+static void handle_instruction(DisasContext *dc, CPUNios2State *env)
+{
+    uint32_t code;
+    uint8_t op;
+    const Nios2Instruction *instr;
+#if defined(CONFIG_USER_ONLY)
+    /* FIXME: Is this needed ? */
+    if (dc->pc >= 0x1000 && dc->pc < 0x2000) {
+        env->regs[R_PC] = dc->pc;
+        t_gen_helper_raise_exception(dc, 0xaa);
+        return;
+    }
+#endif
+    code = cpu_ldl_code(env, dc->pc);
+    op = get_opcode(code);
+
+    if (unlikely(op >= ARRAY_SIZE(i_type_instructions))) {
+        goto illegal_op;
+    }
+
+    TCGV_UNUSED_I32(dc->zero);
+
+    instr = &i_type_instructions[op];
+    instr->handler(dc, code, instr->flags);
+
+    if (!TCGV_IS_UNUSED_I32(dc->zero)) {
+        tcg_temp_free(dc->zero);
+    }
+
+    return;
+
+illegal_op:
+    t_gen_helper_raise_exception(dc, EXCP_ILLEGAL);
+}
+
+static const char * const regnames[] = {
+    "zero",       "at",         "r2",         "r3",
+    "r4",         "r5",         "r6",         "r7",
+    "r8",         "r9",         "r10",        "r11",
+    "r12",        "r13",        "r14",        "r15",
+    "r16",        "r17",        "r18",        "r19",
+    "r20",        "r21",        "r22",        "r23",
+    "et",         "bt",         "gp",         "sp",
+    "fp",         "ea",         "ba",         "ra",
+    "status",     "estatus",    "bstatus",    "ienable",
+    "ipending",   "cpuid",      "reserved0",  "exception",
+    "pteaddr",    "tlbacc",     "tlbmisc",    "reserved1",
+    "badaddr",    "config",     "mpubase",    "mpuacc",
+    "reserved2",  "reserved3",  "reserved4",  "reserved5",
+    "reserved6",  "reserved7",  "reserved8",  "reserved9",
+    "reserved10", "reserved11", "reserved12", "reserved13",
+    "reserved14", "reserved15", "reserved16", "reserved17",
+    "rpc"
+};
+
+static TCGv_ptr cpu_env;
+static TCGv cpu_R[NUM_CORE_REGS];
+
+#include "exec/gen-icount.h"
+
+static void gen_exception(DisasContext *dc, uint32_t excp)
+{
+    TCGv_i32 tmp = tcg_const_i32(excp);
+
+    tcg_gen_movi_tl(cpu_R[R_PC], dc->pc);
+    gen_helper_raise_exception(cpu_env, tmp);
+    tcg_temp_free_i32(tmp);
+    dc->is_jmp = DISAS_UPDATE;
+}
+
+/* generate intermediate code for basic block 'tb'.  */
+void gen_intermediate_code(CPUNios2State *env, TranslationBlock *tb)
+{
+    Nios2CPU *cpu = nios2_env_get_cpu(env);
+    CPUState *cs = CPU(cpu);
+    DisasContext dc1, *dc = &dc1;
+    int num_insns;
+    int max_insns;
+
+    /* Initialize DC */
+    dc->cpu_env = cpu_env;
+    dc->cpu_R   = cpu_R;
+    dc->is_jmp  = DISAS_NEXT;
+    dc->pc      = tb->pc;
+    dc->tb      = tb;
+    dc->mem_idx = cpu_mmu_index(env, false);
+    dc->singlestep_enabled = cs->singlestep_enabled;
+
+    /* Set up instruction counts */
+    num_insns = 0;
+    if (cs->singlestep_enabled || singlestep) {
+        max_insns = 1;
+    } else {
+        int page_insns = (TARGET_PAGE_SIZE - (tb->pc & TARGET_PAGE_MASK)) / 4;
+        max_insns = tb->cflags & CF_COUNT_MASK;
+        if (max_insns == 0) {
+            max_insns = CF_COUNT_MASK;
+        }
+        if (max_insns > page_insns) {
+            max_insns = page_insns;
+        }
+        if (max_insns > TCG_MAX_INSNS) {
+            max_insns = TCG_MAX_INSNS;
+        }
+    }
+
+    gen_tb_start(tb);
+    do {
+        tcg_gen_insn_start(dc->pc);
+        num_insns++;
+
+        if (unlikely(cpu_breakpoint_test(cs, dc->pc, BP_ANY))) {
+            gen_exception(dc, EXCP_DEBUG);
+            /* The address covered by the breakpoint must be included in
+               [tb->pc, tb->pc + tb->size) in order to for it to be
+               properly cleared -- thus we increment the PC here so that
+               the logic setting tb->size below does the right thing.  */
+            dc->pc += 4;
+            break;
+        }
+
+        if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
+            gen_io_start();
+        }
+
+        /* Decode an instruction */
+        handle_instruction(dc, env);
+
+        dc->pc += 4;
+
+        /* Translation stops when a conditional branch is encountered.
+         * Otherwise the subsequent code could get translated several times.
+         * Also stop translation when a page boundary is reached.  This
+         * ensures prefetch aborts occur at the right place.  */
+    } while (!dc->is_jmp &&
+             !tcg_op_buf_full() &&
+             num_insns < max_insns);
+
+    if (tb->cflags & CF_LAST_IO) {
+        gen_io_end();
+    }
+
+    /* Indicate where the next block should start */
+    switch (dc->is_jmp) {
+    case DISAS_NEXT:
+        /* Save the current PC back into the CPU register */
+        tcg_gen_movi_tl(cpu_R[R_PC], dc->pc);
+        tcg_gen_exit_tb(0);
+        break;
+
+    default:
+    case DISAS_JUMP:
+    case DISAS_UPDATE:
+        /* The jump will already have updated the PC register */
+        tcg_gen_exit_tb(0);
+        break;
+
+    case DISAS_TB_JUMP:
+        /* nothing more to generate */
+        break;
+    }
+
+    /* End off the block */
+    gen_tb_end(tb, num_insns);
+
+    /* Mark instruction starts for the final generated instruction */
+    tb->size = dc->pc - tb->pc;
+    tb->icount = num_insns;
+
+#ifdef DEBUG_DISAS
+    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
+        && qemu_log_in_addr_range(tb->pc)) {
+        qemu_log_lock();
+        qemu_log("IN: %s\n", lookup_symbol(tb->pc));
+        log_target_disas(cs, tb->pc, dc->pc - tb->pc, 0);
+        qemu_log("\n");
+        qemu_log_unlock();
+    }
+#endif
+}
+
+void nios2_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
+                          int flags)
+{
+    Nios2CPU *cpu = NIOS2_CPU(cs);
+    CPUNios2State *env = &cpu->env;
+    int i;
+
+    if (!env || !f) {
+        return;
+    }
+
+    cpu_fprintf(f, "IN: PC=%x %s\n",
+                env->regs[R_PC], lookup_symbol(env->regs[R_PC]));
+
+    for (i = 0; i < NUM_CORE_REGS; i++) {
+        cpu_fprintf(f, "%9s=%8.8x ", regnames[i], env->regs[i]);
+        if ((i + 1) % 4 == 0) {
+            cpu_fprintf(f, "\n");
+        }
+    }
+#if !defined(CONFIG_USER_ONLY)
+    cpu_fprintf(f, " mmu write: VPN=%05X PID %02X TLBACC %08X\n",
+                env->mmu.pteaddr_wr & CR_PTEADDR_VPN_MASK,
+                (env->mmu.tlbmisc_wr & CR_TLBMISC_PID_MASK) >> 4,
+                env->mmu.tlbacc_wr);
+#endif
+    cpu_fprintf(f, "\n\n");
+}
+
+void nios2_tcg_init(void)
+{
+    int i;
+
+    cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
+
+    for (i = 0; i < NUM_CORE_REGS; i++) {
+        cpu_R[i] = tcg_global_mem_new(cpu_env,
+                                      offsetof(CPUNios2State, regs[i]),
+                                      regnames[i]);
+    }
+}
+
+void restore_state_to_opc(CPUNios2State *env, TranslationBlock *tb,
+                          target_ulong *data)
+{
+    env->regs[R_PC] = data[0];
+}
-- 
2.9.3
