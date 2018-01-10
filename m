Received: from eggs.gnu.org ([2001:4830:134:3::10]:44752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eZQ7B-0006EH-N1
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 18:49:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eZQ76-0000Lw-My
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 18:49:01 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:38428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eZQ75-0000Kf-PM
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 18:48:56 -0500
Received: by mail-pg0-x244.google.com with SMTP id t67so1115485pgc.5
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 15:48:55 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Wed, 10 Jan 2018 15:46:22 -0800
Message-Id: <1515628000-93285-4-git-send-email-mjc@sifive.com>
In-Reply-To: <1515628000-93285-1-git-send-email-mjc@sifive.com>
References: <1515628000-93285-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v2 03/21] RISC-V CPU Core Definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, RISC-V Patches <patches+subscribe@groups.riscv.org>

Add CPU state header, CPU definitions and initialization routines

Signed-off-by: Michael Clark <mjc@sifive.com>
---
 target/riscv/cpu.c      | 391 +++++++++++++++++++++++++++++++++++++++++++++
 target/riscv/cpu.h      | 271 +++++++++++++++++++++++++++++++
 target/riscv/cpu_bits.h | 417 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1079 insertions(+)
 create mode 100644 target/riscv/cpu.c
 create mode 100644 target/riscv/cpu.h
 create mode 100644 target/riscv/cpu_bits.h

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
new file mode 100644
index 0000000..035dd39
--- /dev/null
+++ b/target/riscv/cpu.c
@@ -0,0 +1,391 @@
+/*
+ * QEMU RISC-V CPU
+ *
+ * Author: Sagar Karandikar, sagark@eecs.berkeley.edu
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
+#include "qemu/log.h"
+#include "cpu.h"
+#include "exec/exec-all.h"
+#include "qapi/error.h"
+#include "migration/vmstate.h"
+
+/* RISC-V CPU definitions */
+
+const char * const riscv_int_regnames[] = {
+  "zero", "ra  ", "sp  ", "gp  ", "tp  ", "t0  ", "t1  ", "t2  ",
+  "s0  ", "s1  ", "a0  ", "a1  ", "a2  ", "a3  ", "a4  ", "a5  ",
+  "a6  ", "a7  ", "s2  ", "s3  ", "s4  ", "s5  ", "s6  ", "s7  ",
+  "s8  ", "s9  ", "s10 ", "s11 ", "t3  ", "t4  ", "t5  ", "t6  "
+};
+
+const char * const riscv_fpr_regnames[] = {
+  "ft0 ", "ft1 ", "ft2 ", "ft3 ", "ft4 ", "ft5 ", "ft6 ",  "ft7 ",
+  "fs0 ", "fs1 ", "fa0 ", "fa1 ", "fa2 ", "fa3 ", "fa4 ",  "fa5 ",
+  "fa6 ", "fa7 ", "fs2 ", "fs3 ", "fs4 ", "fs5 ", "fs6 ",  "fs7 ",
+  "fs8 ", "fs9 ", "fs10", "fs11", "ft8 ", "ft9 ", "ft10",  "ft11"
+};
+
+const char * const riscv_excp_names[] = {
+    "misaligned_fetch",
+    "fault_fetch",
+    "illegal_instruction",
+    "breakpoint",
+    "misaligned_load",
+    "fault_load",
+    "misaligned_store",
+    "fault_store",
+    "user_ecall",
+    "supervisor_ecall",
+    "hypervisor_ecall",
+    "machine_ecall",
+    "exec_page_fault",
+    "load_page_fault",
+    "reserved",
+    "store_page_fault"
+};
+
+const char * const riscv_intr_names[] = {
+    "u_software",
+    "s_software",
+    "h_software",
+    "m_software",
+    "u_timer",
+    "s_timer",
+    "h_timer",
+    "m_timer",
+    "u_external",
+    "s_external",
+    "h_external",
+    "m_external",
+    "coprocessor",
+    "host"
+};
+
+typedef struct RISCVCPUInfo {
+    const char *name;
+    void (*initfn)(Object *obj);
+} RISCVCPUInfo;
+
+#ifdef CONFIG_USER_ONLY
+static void riscv_any_cpu_init(Object *obj)
+{
+    CPURISCVState *env = &RISCV_CPU(obj)->env;
+    env->misa = RVXLEN | RVI | RVM | RVA | RVF | RVD | RVC | RVU;
+    env->misa_mask = env->misa;
+    env->user_ver = USER_VERSION_2_02_0;
+    env->priv_ver = PRIV_VERSION_1_10_0;
+}
+#else
+static void riscv_imafdcsu_priv1_9_cpu_init(Object *obj)
+{
+    CPURISCVState *env = &RISCV_CPU(obj)->env;
+    env->misa = RVXLEN | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU;
+    env->misa_mask = env->misa;
+    env->user_ver = USER_VERSION_2_02_0;
+    env->priv_ver = PRIV_VERSION_1_09_1;
+}
+
+static void riscv_imafdcsu_priv1_10_cpu_init(Object *obj)
+{
+    CPURISCVState *env = &RISCV_CPU(obj)->env;
+    env->misa = RVXLEN | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU;
+    env->misa_mask = env->misa;
+    env->user_ver = USER_VERSION_2_02_0;
+    env->priv_ver = PRIV_VERSION_1_10_0;
+}
+
+static void riscv_imacu_priv1_10_cpu_init(Object *obj)
+{
+    CPURISCVState *env = &RISCV_CPU(obj)->env;
+    env->misa = RVXLEN | RVI | RVM | RVA | RVC | RVU;
+    env->misa_mask = env->misa;
+    env->user_ver = USER_VERSION_2_02_0;
+    env->priv_ver = PRIV_VERSION_1_10_0;
+}
+
+static void riscv_imac_priv1_10_cpu_init(Object *obj)
+{
+    CPURISCVState *env = &RISCV_CPU(obj)->env;
+    env->misa = RVXLEN | RVI | RVM | RVA | RVC;
+    env->misa_mask = env->misa;
+    env->user_ver = USER_VERSION_2_02_0;
+    env->priv_ver = PRIV_VERSION_1_10_0;
+}
+#endif
+
+static const RISCVCPUInfo riscv_cpus[] = {
+#ifdef CONFIG_USER_ONLY
+    { TYPE_RISCV_CPU_ANY,                riscv_any_cpu_init },
+#else
+    { TYPE_RISCV_CPU_IMAFDCSU_PRIV_1_09, riscv_imafdcsu_priv1_9_cpu_init },
+    { TYPE_RISCV_CPU_IMAFDCSU_PRIV_1_10, riscv_imafdcsu_priv1_10_cpu_init },
+    { TYPE_RISCV_CPU_IMACU_PRIV_1_10,    riscv_imacu_priv1_10_cpu_init },
+    { TYPE_RISCV_CPU_IMAC_PRIV_1_10,     riscv_imac_priv1_10_cpu_init },
+#endif
+    { NULL, NULL }
+};
+
+static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
+{
+    ObjectClass *oc;
+    char *typename;
+    char **cpuname;
+
+    cpuname = g_strsplit(cpu_model, ",", 1);
+    typename = g_strdup_printf(RISCV_CPU_TYPE_NAME("%s"), cpuname[0]);
+    oc = object_class_by_name(typename);
+    g_strfreev(cpuname);
+    g_free(typename);
+    if (!oc || !object_class_dynamic_cast(oc, TYPE_RISCV_CPU) ||
+        object_class_is_abstract(oc)) {
+        return NULL;
+    }
+    return oc;
+}
+
+static void riscv_cpu_dump_state(CPUState *cs, FILE *f,
+    fprintf_function cpu_fprintf, int flags)
+{
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    CPURISCVState *env = &cpu->env;
+    int i;
+
+    cpu_fprintf(f, "pc=0x" TARGET_FMT_lx "\n", env->pc);
+    for (i = 0; i < 32; i++) {
+        cpu_fprintf(f, " %s " TARGET_FMT_lx,
+            riscv_int_regnames[i], env->gpr[i]);
+        if ((i & 3) == 3) {
+            cpu_fprintf(f, "\n");
+        }
+    }
+
+#ifndef CONFIG_USER_ONLY
+    cpu_fprintf(f, " %s " TARGET_FMT_lx "\n", "MSTATUS ",
+                env->mstatus);
+    cpu_fprintf(f, " %s " TARGET_FMT_lx "\n", "MIP     ", env->mip);
+    cpu_fprintf(f, " %s " TARGET_FMT_lx "\n", "MIE     ", env->mie);
+#endif
+
+    for (i = 0; i < 32; i++) {
+        if ((i & 3) == 0) {
+            cpu_fprintf(f, "FPR%02d:", i);
+        }
+        cpu_fprintf(f, " %s %016" PRIx64,
+            riscv_fpr_regnames[i], env->fpr[i]);
+        if ((i & 3) == 3) {
+            cpu_fprintf(f, "\n");
+        }
+    }
+}
+
+static void riscv_cpu_set_pc(CPUState *cs, vaddr value)
+{
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    CPURISCVState *env = &cpu->env;
+    env->pc = value;
+}
+
+static void riscv_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock *tb)
+{
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    CPURISCVState *env = &cpu->env;
+    env->pc = tb->pc;
+}
+
+static bool riscv_cpu_has_work(CPUState *cs)
+{
+    return cs->interrupt_request & CPU_INTERRUPT_HARD;
+}
+
+void restore_state_to_opc(CPURISCVState *env, TranslationBlock *tb,
+                          target_ulong *data)
+{
+    env->pc = data[0];
+}
+
+static void riscv_cpu_reset(CPUState *cs)
+{
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
+    CPURISCVState *env = &cpu->env;
+
+    mcc->parent_reset(cs);
+#ifndef CONFIG_USER_ONLY
+    env->priv = PRV_M;
+    env->mtvec = DEFAULT_MTVEC;
+#endif
+    env->pc = DEFAULT_RSTVEC;
+    cs->exception_index = EXCP_NONE;
+    set_default_nan_mode(1, &env->fp_status);
+}
+
+static void riscv_cpu_disas_set_info(CPUState *s, disassemble_info *info)
+{
+#if defined(TARGET_RISCV32)
+    info->print_insn = print_insn_riscv32;
+#elif defined(TARGET_RISCV64)
+    info->print_insn = print_insn_riscv64;
+#endif
+}
+
+static void riscv_cpu_realize(DeviceState *dev, Error **errp)
+{
+    CPUState *cs = CPU(dev);
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
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
+    mcc->parent_realize(dev, errp);
+}
+
+static void riscv_cpu_init(Object *obj)
+{
+    CPUState *cs = CPU(obj);
+    RISCVCPU *cpu = RISCV_CPU(obj);
+
+    cs->env_ptr = &cpu->env;
+}
+
+static const VMStateDescription vmstate_riscv_cpu = {
+    .name = "cpu",
+    .unmigratable = 1,
+};
+
+static void riscv_cpu_class_init(ObjectClass *c, void *data)
+{
+    RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
+    CPUClass *cc = CPU_CLASS(c);
+    DeviceClass *dc = DEVICE_CLASS(c);
+
+    mcc->parent_realize = dc->realize;
+    dc->realize = riscv_cpu_realize;
+
+    mcc->parent_reset = cc->reset;
+    cc->reset = riscv_cpu_reset;
+
+    cc->class_by_name = riscv_cpu_class_by_name;
+    cc->has_work = riscv_cpu_has_work;
+    cc->do_interrupt = riscv_cpu_do_interrupt;
+    cc->cpu_exec_interrupt = riscv_cpu_exec_interrupt;
+    cc->dump_state = riscv_cpu_dump_state;
+    cc->set_pc = riscv_cpu_set_pc;
+    cc->synchronize_from_tb = riscv_cpu_synchronize_from_tb;
+    cc->gdb_read_register = riscv_cpu_gdb_read_register;
+    cc->gdb_write_register = riscv_cpu_gdb_write_register;
+    cc->gdb_num_core_regs = 65;
+    cc->gdb_stop_before_watchpoint = true;
+    cc->disas_set_info = riscv_cpu_disas_set_info;
+#ifdef CONFIG_USER_ONLY
+    cc->handle_mmu_fault = riscv_cpu_handle_mmu_fault;
+#else
+    cc->do_unassigned_access = riscv_cpu_unassigned_access;
+    cc->do_unaligned_access = riscv_cpu_do_unaligned_access;
+    cc->get_phys_page_debug = riscv_cpu_get_phys_page_debug;
+#endif
+#ifdef CONFIG_TCG
+    cc->tcg_initialize = riscv_translate_init;
+#endif
+    /* For now, mark unmigratable: */
+    cc->vmsd = &vmstate_riscv_cpu;
+}
+
+static void cpu_register(const RISCVCPUInfo *info)
+{
+    TypeInfo type_info = {
+        .name = info->name,
+        .parent = TYPE_RISCV_CPU,
+        .instance_size = sizeof(RISCVCPU),
+        .instance_init = info->initfn,
+    };
+
+    type_register(&type_info);
+}
+
+static const TypeInfo riscv_cpu_type_info = {
+    .name = TYPE_RISCV_CPU,
+    .parent = TYPE_CPU,
+    .instance_size = sizeof(RISCVCPU),
+    .instance_init = riscv_cpu_init,
+    .abstract = false,
+    .class_size = sizeof(RISCVCPUClass),
+    .class_init = riscv_cpu_class_init,
+};
+
+char *riscv_isa_string(RISCVCPU *cpu)
+{
+    size_t len = 5 + ctz32(cpu->env.misa);
+    char *isa_string = g_new(char, len);
+    isa_string[0] = '\0';
+#if defined(TARGET_RISCV32)
+    strncat(isa_string, "rv32", len);
+#elif defined(TARGET_RISCV64)
+    strncat(isa_string, "rv64", len);
+#endif
+    if (cpu->env.misa & RVI) {
+        strncat(isa_string, "i", len);
+    }
+    if (cpu->env.misa & RVM) {
+        strncat(isa_string, "m", len);
+    }
+    if (cpu->env.misa & RVA) {
+        strncat(isa_string, "a", len);
+    }
+    if (cpu->env.misa & RVF) {
+        strncat(isa_string, "f", len);
+    }
+    if (cpu->env.misa & RVD) {
+        strncat(isa_string, "d", len);
+    }
+    if (cpu->env.misa & RVC) {
+        strncat(isa_string, "c", len);
+    }
+    return isa_string;
+}
+
+void riscv_cpu_list(FILE *f, fprintf_function cpu_fprintf)
+{
+    const RISCVCPUInfo *info = riscv_cpus;
+
+    while (info->name) {
+        (*cpu_fprintf)(f, "%s\n", info->name);
+        info++;
+    }
+}
+
+static void riscv_cpu_register_types(void)
+{
+    const RISCVCPUInfo *info = riscv_cpus;
+
+    type_register_static(&riscv_cpu_type_info);
+
+    while (info->name) {
+        cpu_register(info);
+        info++;
+    }
+}
+
+type_init(riscv_cpu_register_types)
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
new file mode 100644
index 0000000..9dd131b
--- /dev/null
+++ b/target/riscv/cpu.h
@@ -0,0 +1,271 @@
+#ifndef RISCV_CPU_H
+#define RISCV_CPU_H
+
+/* QEMU addressing/paging config */
+#define TARGET_PAGE_BITS 12 /* 4 KiB Pages */
+#if defined(TARGET_RISCV64)
+#define TARGET_LONG_BITS 64
+#define TARGET_PHYS_ADDR_SPACE_BITS 50
+#define TARGET_VIRT_ADDR_SPACE_BITS 39
+#elif defined(TARGET_RISCV32)
+#define TARGET_LONG_BITS 32
+#define TARGET_PHYS_ADDR_SPACE_BITS 34
+#define TARGET_VIRT_ADDR_SPACE_BITS 32
+#endif
+
+#define ELF_MACHINE EM_RISCV
+#define CPUArchState struct CPURISCVState
+
+#include "qemu-common.h"
+#include "qom/cpu.h"
+#include "exec/cpu-defs.h"
+#include "fpu/softfloat.h"
+
+/* #define DEBUG_OP */
+/* #define RISCV_DEBUG_PRINT */
+
+#define TYPE_RISCV_CPU                    "riscv"
+#define TYPE_RISCV_CPU_ANY                "riscv-any"
+#define TYPE_RISCV_CPU_IMAFDCSU_PRIV_1_09 "riscv-imafdcsu-priv1.9"
+#define TYPE_RISCV_CPU_IMAFDCSU_PRIV_1_10 "riscv-imafdcsu-priv1.10"
+#define TYPE_RISCV_CPU_IMACU_PRIV_1_10    "riscv-imacu-priv1.10"
+#define TYPE_RISCV_CPU_IMAC_PRIV_1_10     "riscv-imac-priv1.10"
+
+#define RISCV_CPU_TYPE_PREFIX TYPE_RISCV_CPU "-"
+#define RISCV_CPU_TYPE_NAME(name) (RISCV_CPU_TYPE_PREFIX name)
+
+#if defined(TARGET_RISCV32)
+#define RVXLEN  ((target_ulong)1 << (TARGET_LONG_BITS - 2))
+#elif defined(TARGET_RISCV64)
+#define RVXLEN  ((target_ulong)2 << (TARGET_LONG_BITS - 2))
+#endif
+#define RV(x) ((target_ulong)1 << (x - 'A'))
+
+#define RVI RV('I')
+#define RVM RV('M')
+#define RVA RV('A')
+#define RVF RV('F')
+#define RVD RV('D')
+#define RVC RV('C')
+#define RVS RV('S')
+#define RVU RV('U')
+
+#define USER_VERSION_2_02_0 0x00020200
+#define PRIV_VERSION_1_09_1 0x00010901
+#define PRIV_VERSION_1_10_0 0x00011000
+
+#define TRANSLATE_FAIL 1
+#define TRANSLATE_SUCCESS 0
+#define NB_MMU_MODES 4
+#define MMU_USER_IDX 3
+
+#define SSIP_IRQ (env->irq[0])
+#define STIP_IRQ (env->irq[1])
+#define MSIP_IRQ (env->irq[2])
+#define MTIP_IRQ (env->irq[3])
+#define HTIF_IRQ (env->irq[4])
+#define SEIP_IRQ (env->irq[5])
+#define MEIP_IRQ (env->irq[6])
+
+#define MAX_RISCV_IRQ (8)
+#define MAX_RISCV_PMPS (16)
+
+typedef struct CPURISCVState CPURISCVState;
+
+#include "pmp.h"
+
+struct CPURISCVState {
+    target_ulong gpr[32];
+    uint64_t fpr[32]; /* assume both F and D extensions */
+    target_ulong pc;
+    target_ulong load_res;
+
+    target_ulong frm;
+    target_ulong fstatus;
+    target_ulong fflags;
+
+    target_ulong badaddr;
+
+    uint32_t mucounteren;
+
+    target_ulong user_ver;
+    target_ulong priv_ver;
+    target_ulong misa_mask;
+    target_ulong misa;
+
+#ifdef CONFIG_USER_ONLY
+    uint32_t amoinsn;
+    target_long amoaddr;
+    target_long amotest;
+#else
+    target_ulong priv;
+
+    target_ulong mhartid;
+    target_ulong mstatus;
+    target_ulong mip;
+    target_ulong mie;
+    target_ulong mideleg;
+
+    target_ulong sptbr;  /* until: priv-1.9.1 */
+    target_ulong satp;   /* since: priv-1.10.0 */
+    target_ulong sbadaddr;
+    target_ulong mbadaddr;
+    target_ulong medeleg;
+
+    target_ulong stvec;
+    target_ulong sepc;
+    target_ulong scause;
+
+    target_ulong mtvec;
+    target_ulong mepc;
+    target_ulong mcause;
+    target_ulong mtval;  /* since: priv-1.10.0 */
+
+    uint32_t mscounteren;
+    target_ulong scounteren; /* since: priv-1.10.0 */
+    target_ulong mcounteren; /* since: priv-1.10.0 */
+
+    target_ulong sscratch;
+    target_ulong mscratch;
+
+    /* temporary htif regs */
+    uint64_t mfromhost;
+    uint64_t mtohost;
+    uint64_t timecmp;
+
+    /* physical memory protection */
+    pmp_table_t pmp_state;
+#endif
+
+    float_status fp_status;
+
+    /* QEMU */
+    CPU_COMMON
+
+    /* Fields from here on are preserved across CPU reset. */
+    qemu_irq irq[8];
+    QEMUTimer *timer; /* Internal timer */
+};
+
+#define RISCV_CPU_CLASS(klass) \
+    OBJECT_CLASS_CHECK(RISCVCPUClass, (klass), TYPE_RISCV_CPU)
+#define RISCV_CPU(obj) \
+    OBJECT_CHECK(RISCVCPU, (obj), TYPE_RISCV_CPU)
+#define RISCV_CPU_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(RISCVCPUClass, (obj), TYPE_RISCV_CPU)
+
+/**
+ * RISCVCPUClass:
+ * @parent_realize: The parent class' realize handler.
+ * @parent_reset: The parent class' reset handler.
+ *
+ * A RISCV CPU model.
+ */
+typedef struct RISCVCPUClass {
+    /*< private >*/
+    CPUClass parent_class;
+    /*< public >*/
+    DeviceRealize parent_realize;
+    void (*parent_reset)(CPUState *cpu);
+} RISCVCPUClass;
+
+/**
+ * RISCVCPU:
+ * @env: #CPURISCVState
+ *
+ * A RISCV CPU.
+ */
+typedef struct RISCVCPU {
+    /*< private >*/
+    CPUState parent_obj;
+    /*< public >*/
+    CPURISCVState env;
+} RISCVCPU;
+
+static inline RISCVCPU *riscv_env_get_cpu(CPURISCVState *env)
+{
+    return container_of(env, RISCVCPU, env);
+}
+
+static inline int riscv_has_ext(CPURISCVState *env, target_ulong ext)
+{
+    return (env->misa & ext) != 0;
+}
+
+#include "cpu_user.h"
+#include "cpu_bits.h"
+
+extern const char * const riscv_int_regnames[];
+extern const char * const riscv_fpr_regnames[];
+extern const char * const riscv_excp_names[];
+extern const char * const riscv_intr_names[];
+
+#define ENV_GET_CPU(e) CPU(riscv_env_get_cpu(e))
+#define ENV_OFFSET offsetof(RISCVCPU, env)
+
+void riscv_cpu_do_interrupt(CPUState *cpu);
+hwaddr riscv_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+int riscv_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
+int riscv_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
+bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
+void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
+                                    MMUAccessType access_type, int mmu_idx,
+                                    uintptr_t retaddr);
+#if !defined(CONFIG_USER_ONLY)
+void riscv_cpu_unassigned_access(CPUState *cpu, hwaddr addr, bool is_write,
+        bool is_exec, int unused, unsigned size);
+#endif
+
+char *riscv_isa_string(RISCVCPU *cpu);
+void riscv_cpu_list(FILE *f, fprintf_function cpu_fprintf);
+int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch);
+
+#define cpu_init(cpu_model) cpu_generic_init(TYPE_RISCV_CPU, cpu_model)
+#define cpu_signal_handler cpu_riscv_signal_handler
+#define cpu_list riscv_cpu_list
+#define cpu_mmu_index riscv_cpu_mmu_index
+
+void riscv_set_mode(CPURISCVState *env, target_ulong newpriv);
+unsigned int softfloat_flags_to_riscv(unsigned int flag);
+uint_fast16_t float32_classify(uint32_t a, float_status *status);
+uint_fast16_t float64_classify(uint64_t a, float_status *status);
+
+void riscv_translate_init(void);
+RISCVCPU *cpu_riscv_init(const char *cpu_model);
+int cpu_riscv_signal_handler(int host_signum, void *pinfo, void *puc);
+void QEMU_NORETURN do_raise_exception_err(CPURISCVState *env,
+                                          uint32_t exception, uintptr_t pc);
+
+/* hw/riscv/sifive_clint.c  - supplies instret by approximating */
+uint64_t cpu_riscv_read_instret(CPURISCVState *env);
+uint64_t cpu_riscv_read_rtc(void);
+
+int riscv_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int rw,
+                              int mmu_idx);
+
+static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
+                                        target_ulong *cs_base, uint32_t *flags)
+{
+    *pc = env->pc;
+    *cs_base = 0;
+    *flags = 0; /* necessary to avoid compiler warning */
+}
+
+static inline int riscv_mstatus_fs(CPURISCVState *env)
+{
+#ifndef CONFIG_USER_ONLY
+    return env->mstatus & MSTATUS_FS;
+#else
+    return TRUE;
+#endif
+}
+
+void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
+        target_ulong csrno);
+target_ulong csr_read_helper(CPURISCVState *env, target_ulong csrno);
+
+void validate_csr(CPURISCVState *env, uint64_t which, uint64_t write);
+
+#include "exec/cpu-all.h"
+
+#endif /* RISCV_CPU_H */
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
new file mode 100644
index 0000000..81d2a9d
--- /dev/null
+++ b/target/riscv/cpu_bits.h
@@ -0,0 +1,417 @@
+/* RISC-V ISA constants */
+
+#define get_field(reg, mask) (((reg) & \
+                 (target_ulong)(mask)) / ((mask) & ~((mask) << 1)))
+#define set_field(reg, mask, val) (((reg) & ~(target_ulong)(mask)) | \
+                 (((target_ulong)(val) * ((mask) & ~((mask) << 1))) & \
+                 (target_ulong)(mask)))
+
+#define PGSHIFT 12
+
+#define FSR_RD_SHIFT 5
+#define FSR_RD   (0x7 << FSR_RD_SHIFT)
+
+#define FPEXC_NX 0x01
+#define FPEXC_UF 0x02
+#define FPEXC_OF 0x04
+#define FPEXC_DZ 0x08
+#define FPEXC_NV 0x10
+
+#define FSR_AEXC_SHIFT 0
+#define FSR_NVA  (FPEXC_NV << FSR_AEXC_SHIFT)
+#define FSR_OFA  (FPEXC_OF << FSR_AEXC_SHIFT)
+#define FSR_UFA  (FPEXC_UF << FSR_AEXC_SHIFT)
+#define FSR_DZA  (FPEXC_DZ << FSR_AEXC_SHIFT)
+#define FSR_NXA  (FPEXC_NX << FSR_AEXC_SHIFT)
+#define FSR_AEXC (FSR_NVA | FSR_OFA | FSR_UFA | FSR_DZA | FSR_NXA)
+
+/* CSR numbers */
+#define CSR_FFLAGS 0x1
+#define CSR_FRM 0x2
+#define CSR_FCSR 0x3
+#define CSR_CYCLE 0xc00
+#define CSR_TIME 0xc01
+#define CSR_INSTRET 0xc02
+#define CSR_HPMCOUNTER3 0xc03
+#define CSR_HPMCOUNTER4 0xc04
+#define CSR_HPMCOUNTER5 0xc05
+#define CSR_HPMCOUNTER6 0xc06
+#define CSR_HPMCOUNTER7 0xc07
+#define CSR_HPMCOUNTER8 0xc08
+#define CSR_HPMCOUNTER9 0xc09
+#define CSR_HPMCOUNTER10 0xc0a
+#define CSR_HPMCOUNTER11 0xc0b
+#define CSR_HPMCOUNTER12 0xc0c
+#define CSR_HPMCOUNTER13 0xc0d
+#define CSR_HPMCOUNTER14 0xc0e
+#define CSR_HPMCOUNTER15 0xc0f
+#define CSR_HPMCOUNTER16 0xc10
+#define CSR_HPMCOUNTER17 0xc11
+#define CSR_HPMCOUNTER18 0xc12
+#define CSR_HPMCOUNTER19 0xc13
+#define CSR_HPMCOUNTER20 0xc14
+#define CSR_HPMCOUNTER21 0xc15
+#define CSR_HPMCOUNTER22 0xc16
+#define CSR_HPMCOUNTER23 0xc17
+#define CSR_HPMCOUNTER24 0xc18
+#define CSR_HPMCOUNTER25 0xc19
+#define CSR_HPMCOUNTER26 0xc1a
+#define CSR_HPMCOUNTER27 0xc1b
+#define CSR_HPMCOUNTER28 0xc1c
+#define CSR_HPMCOUNTER29 0xc1d
+#define CSR_HPMCOUNTER30 0xc1e
+#define CSR_HPMCOUNTER31 0xc1f
+#define CSR_SSTATUS 0x100
+#define CSR_SIE 0x104
+#define CSR_STVEC 0x105
+#define CSR_SCOUNTEREN 0x106
+#define CSR_SSCRATCH 0x140
+#define CSR_SEPC 0x141
+#define CSR_SCAUSE 0x142
+#define CSR_SBADADDR 0x143
+#define CSR_SIP 0x144
+#define CSR_SPTBR 0x180
+#define CSR_SATP 0x180
+#define CSR_MSTATUS 0x300
+#define CSR_MISA 0x301
+#define CSR_MEDELEG 0x302
+#define CSR_MIDELEG 0x303
+#define CSR_MIE 0x304
+#define CSR_MTVEC 0x305
+#define CSR_MCOUNTEREN 0x306
+#define CSR_MSCRATCH 0x340
+#define CSR_MEPC 0x341
+#define CSR_MCAUSE 0x342
+#define CSR_MBADADDR 0x343
+#define CSR_MIP 0x344
+#define CSR_PMPCFG0 0x3a0
+#define CSR_PMPCFG1 0x3a1
+#define CSR_PMPCFG2 0x3a2
+#define CSR_PMPCFG3 0x3a3
+#define CSR_PMPADDR0 0x3b0
+#define CSR_PMPADDR1 0x3b1
+#define CSR_PMPADDR2 0x3b2
+#define CSR_PMPADDR3 0x3b3
+#define CSR_PMPADDR4 0x3b4
+#define CSR_PMPADDR5 0x3b5
+#define CSR_PMPADDR6 0x3b6
+#define CSR_PMPADDR7 0x3b7
+#define CSR_PMPADDR8 0x3b8
+#define CSR_PMPADDR9 0x3b9
+#define CSR_PMPADDR10 0x3ba
+#define CSR_PMPADDR11 0x3bb
+#define CSR_PMPADDR12 0x3bc
+#define CSR_PMPADDR13 0x3bd
+#define CSR_PMPADDR14 0x3be
+#define CSR_PMPADDR15 0x3bf
+#define CSR_TSELECT 0x7a0
+#define CSR_TDATA1 0x7a1
+#define CSR_TDATA2 0x7a2
+#define CSR_TDATA3 0x7a3
+#define CSR_DCSR 0x7b0
+#define CSR_DPC 0x7b1
+#define CSR_DSCRATCH 0x7b2
+#define CSR_MCYCLE 0xb00
+#define CSR_MINSTRET 0xb02
+#define CSR_MHPMCOUNTER3 0xb03
+#define CSR_MHPMCOUNTER4 0xb04
+#define CSR_MHPMCOUNTER5 0xb05
+#define CSR_MHPMCOUNTER6 0xb06
+#define CSR_MHPMCOUNTER7 0xb07
+#define CSR_MHPMCOUNTER8 0xb08
+#define CSR_MHPMCOUNTER9 0xb09
+#define CSR_MHPMCOUNTER10 0xb0a
+#define CSR_MHPMCOUNTER11 0xb0b
+#define CSR_MHPMCOUNTER12 0xb0c
+#define CSR_MHPMCOUNTER13 0xb0d
+#define CSR_MHPMCOUNTER14 0xb0e
+#define CSR_MHPMCOUNTER15 0xb0f
+#define CSR_MHPMCOUNTER16 0xb10
+#define CSR_MHPMCOUNTER17 0xb11
+#define CSR_MHPMCOUNTER18 0xb12
+#define CSR_MHPMCOUNTER19 0xb13
+#define CSR_MHPMCOUNTER20 0xb14
+#define CSR_MHPMCOUNTER21 0xb15
+#define CSR_MHPMCOUNTER22 0xb16
+#define CSR_MHPMCOUNTER23 0xb17
+#define CSR_MHPMCOUNTER24 0xb18
+#define CSR_MHPMCOUNTER25 0xb19
+#define CSR_MHPMCOUNTER26 0xb1a
+#define CSR_MHPMCOUNTER27 0xb1b
+#define CSR_MHPMCOUNTER28 0xb1c
+#define CSR_MHPMCOUNTER29 0xb1d
+#define CSR_MHPMCOUNTER30 0xb1e
+#define CSR_MHPMCOUNTER31 0xb1f
+#define CSR_MUCOUNTEREN 0x320
+#define CSR_MSCOUNTEREN 0x321
+#define CSR_MHPMEVENT3 0x323
+#define CSR_MHPMEVENT4 0x324
+#define CSR_MHPMEVENT5 0x325
+#define CSR_MHPMEVENT6 0x326
+#define CSR_MHPMEVENT7 0x327
+#define CSR_MHPMEVENT8 0x328
+#define CSR_MHPMEVENT9 0x329
+#define CSR_MHPMEVENT10 0x32a
+#define CSR_MHPMEVENT11 0x32b
+#define CSR_MHPMEVENT12 0x32c
+#define CSR_MHPMEVENT13 0x32d
+#define CSR_MHPMEVENT14 0x32e
+#define CSR_MHPMEVENT15 0x32f
+#define CSR_MHPMEVENT16 0x330
+#define CSR_MHPMEVENT17 0x331
+#define CSR_MHPMEVENT18 0x332
+#define CSR_MHPMEVENT19 0x333
+#define CSR_MHPMEVENT20 0x334
+#define CSR_MHPMEVENT21 0x335
+#define CSR_MHPMEVENT22 0x336
+#define CSR_MHPMEVENT23 0x337
+#define CSR_MHPMEVENT24 0x338
+#define CSR_MHPMEVENT25 0x339
+#define CSR_MHPMEVENT26 0x33a
+#define CSR_MHPMEVENT27 0x33b
+#define CSR_MHPMEVENT28 0x33c
+#define CSR_MHPMEVENT29 0x33d
+#define CSR_MHPMEVENT30 0x33e
+#define CSR_MHPMEVENT31 0x33f
+#define CSR_MVENDORID 0xf11
+#define CSR_MARCHID 0xf12
+#define CSR_MIMPID 0xf13
+#define CSR_MHARTID 0xf14
+#define CSR_CYCLEH 0xc80
+#define CSR_TIMEH 0xc81
+#define CSR_INSTRETH 0xc82
+#define CSR_HPMCOUNTER3H 0xc83
+#define CSR_HPMCOUNTER4H 0xc84
+#define CSR_HPMCOUNTER5H 0xc85
+#define CSR_HPMCOUNTER6H 0xc86
+#define CSR_HPMCOUNTER7H 0xc87
+#define CSR_HPMCOUNTER8H 0xc88
+#define CSR_HPMCOUNTER9H 0xc89
+#define CSR_HPMCOUNTER10H 0xc8a
+#define CSR_HPMCOUNTER11H 0xc8b
+#define CSR_HPMCOUNTER12H 0xc8c
+#define CSR_HPMCOUNTER13H 0xc8d
+#define CSR_HPMCOUNTER14H 0xc8e
+#define CSR_HPMCOUNTER15H 0xc8f
+#define CSR_HPMCOUNTER16H 0xc90
+#define CSR_HPMCOUNTER17H 0xc91
+#define CSR_HPMCOUNTER18H 0xc92
+#define CSR_HPMCOUNTER19H 0xc93
+#define CSR_HPMCOUNTER20H 0xc94
+#define CSR_HPMCOUNTER21H 0xc95
+#define CSR_HPMCOUNTER22H 0xc96
+#define CSR_HPMCOUNTER23H 0xc97
+#define CSR_HPMCOUNTER24H 0xc98
+#define CSR_HPMCOUNTER25H 0xc99
+#define CSR_HPMCOUNTER26H 0xc9a
+#define CSR_HPMCOUNTER27H 0xc9b
+#define CSR_HPMCOUNTER28H 0xc9c
+#define CSR_HPMCOUNTER29H 0xc9d
+#define CSR_HPMCOUNTER30H 0xc9e
+#define CSR_HPMCOUNTER31H 0xc9f
+#define CSR_MCYCLEH 0xb80
+#define CSR_MINSTRETH 0xb82
+#define CSR_MHPMCOUNTER3H 0xb83
+#define CSR_MHPMCOUNTER4H 0xb84
+#define CSR_MHPMCOUNTER5H 0xb85
+#define CSR_MHPMCOUNTER6H 0xb86
+#define CSR_MHPMCOUNTER7H 0xb87
+#define CSR_MHPMCOUNTER8H 0xb88
+#define CSR_MHPMCOUNTER9H 0xb89
+#define CSR_MHPMCOUNTER10H 0xb8a
+#define CSR_MHPMCOUNTER11H 0xb8b
+#define CSR_MHPMCOUNTER12H 0xb8c
+#define CSR_MHPMCOUNTER13H 0xb8d
+#define CSR_MHPMCOUNTER14H 0xb8e
+#define CSR_MHPMCOUNTER15H 0xb8f
+#define CSR_MHPMCOUNTER16H 0xb90
+#define CSR_MHPMCOUNTER17H 0xb91
+#define CSR_MHPMCOUNTER18H 0xb92
+#define CSR_MHPMCOUNTER19H 0xb93
+#define CSR_MHPMCOUNTER20H 0xb94
+#define CSR_MHPMCOUNTER21H 0xb95
+#define CSR_MHPMCOUNTER22H 0xb96
+#define CSR_MHPMCOUNTER23H 0xb97
+#define CSR_MHPMCOUNTER24H 0xb98
+#define CSR_MHPMCOUNTER25H 0xb99
+#define CSR_MHPMCOUNTER26H 0xb9a
+#define CSR_MHPMCOUNTER27H 0xb9b
+#define CSR_MHPMCOUNTER28H 0xb9c
+#define CSR_MHPMCOUNTER29H 0xb9d
+#define CSR_MHPMCOUNTER30H 0xb9e
+#define CSR_MHPMCOUNTER31H 0xb9f
+
+/* mstatus bits */
+#define MSTATUS_UIE         0x00000001
+#define MSTATUS_SIE         0x00000002
+#define MSTATUS_HIE         0x00000004
+#define MSTATUS_MIE         0x00000008
+#define MSTATUS_UPIE        0x00000010
+#define MSTATUS_SPIE        0x00000020
+#define MSTATUS_HPIE        0x00000040
+#define MSTATUS_MPIE        0x00000080
+#define MSTATUS_SPP         0x00000100
+#define MSTATUS_HPP         0x00000600
+#define MSTATUS_MPP         0x00001800
+#define MSTATUS_FS          0x00006000
+#define MSTATUS_XS          0x00018000
+#define MSTATUS_MPRV        0x00020000
+#define MSTATUS_PUM         0x00040000 /* until: priv-1.9.1 */
+#define MSTATUS_SUM         0x00040000 /* since: priv-1.10 */
+#define MSTATUS_MXR         0x00080000
+#define MSTATUS_VM          0x1F000000 /* until: priv-1.9.1 */
+#define MSTATUS_TVM         0x00100000 /* since: priv-1.10 */
+#define MSTATUS_TW          0x20000000 /* since: priv-1.10 */
+#define MSTATUS_TSR         0x40000000 /* since: priv-1.10 */
+
+#define MSTATUS64_UXL       0x0000000300000000ULL
+#define MSTATUS64_SXL       0x0000000C00000000ULL
+
+#define MSTATUS32_SD        0x80000000
+#define MSTATUS64_SD        0x8000000000000000ULL
+
+#if defined(TARGET_RISCV32)
+#define MSTATUS_SD MSTATUS32_SD
+#elif defined(TARGET_RISCV64)
+#define MSTATUS_SD MSTATUS64_SD
+#endif
+
+/* sstatus bits */
+#define SSTATUS_UIE         0x00000001
+#define SSTATUS_SIE         0x00000002
+#define SSTATUS_UPIE        0x00000010
+#define SSTATUS_SPIE        0x00000020
+#define SSTATUS_SPP         0x00000100
+#define SSTATUS_FS          0x00006000
+#define SSTATUS_XS          0x00018000
+#define SSTATUS_PUM         0x00040000 /* until: priv-1.9.1 */
+#define SSTATUS_SUM         0x00040000 /* since: priv-1.10 */
+#define SSTATUS_MXR         0x00080000
+
+#define SSTATUS32_SD        0x80000000
+#define SSTATUS64_SD        0x8000000000000000ULL
+
+#if defined(TARGET_RISCV32)
+#define SSTATUS_SD SSTATUS32_SD
+#elif defined(TARGET_RISCV64)
+#define SSTATUS_SD SSTATUS64_SD
+#endif
+
+/* irqs */
+#define MIP_SSIP            (1 << IRQ_S_SOFT)
+#define MIP_HSIP            (1 << IRQ_H_SOFT)
+#define MIP_MSIP            (1 << IRQ_M_SOFT)
+#define MIP_STIP            (1 << IRQ_S_TIMER)
+#define MIP_HTIP            (1 << IRQ_H_TIMER)
+#define MIP_MTIP            (1 << IRQ_M_TIMER)
+#define MIP_SEIP            (1 << IRQ_S_EXT)
+#define MIP_HEIP            (1 << IRQ_H_EXT)
+#define MIP_MEIP            (1 << IRQ_M_EXT)
+
+#define SIP_SSIP            MIP_SSIP
+#define SIP_STIP            MIP_STIP
+#define SIP_SEIP            MIP_SEIP
+
+#define PRV_U 0
+#define PRV_S 1
+#define PRV_H 2
+#define PRV_M 3
+
+/* privileged ISA 1.9.1 VM modes (mstatus.vm) */
+#define VM_1_09_MBARE 0
+#define VM_1_09_MBB   1
+#define VM_1_09_MBBID 2
+#define VM_1_09_SV32  8
+#define VM_1_09_SV39  9
+#define VM_1_09_SV48  10
+
+/* privileged ISA 1.10.0 VM modes (satp.mode) */
+#define VM_1_10_MBARE 0
+#define VM_1_10_SV32  1
+#define VM_1_10_SV39  8
+#define VM_1_10_SV48  9
+#define VM_1_10_SV57  10
+#define VM_1_10_SV64  11
+
+/* privileged ISA interrupt causes */
+#define IRQ_U_SOFT      0  /* since: priv-1.10 */
+#define IRQ_S_SOFT      1
+#define IRQ_H_SOFT      2  /* until: priv-1.9.1 */
+#define IRQ_M_SOFT      3  /* until: priv-1.9.1 */
+#define IRQ_U_TIMER     4  /* since: priv-1.10 */
+#define IRQ_S_TIMER     5
+#define IRQ_H_TIMER     6  /* until: priv-1.9.1 */
+#define IRQ_M_TIMER     7  /* until: priv-1.9.1 */
+#define IRQ_U_EXT       8  /* since: priv-1.10 */
+#define IRQ_S_EXT       9
+#define IRQ_H_EXT       10 /* until: priv-1.9.1 */
+#define IRQ_M_EXT       11 /* until: priv-1.9.1 */
+#define IRQ_X_COP       12 /* non-standard */
+#define IRQ_X_HOST      13 /* non-standard */
+
+/* Default addresses */
+#define DEFAULT_RSTVEC     0x00001000
+#define DEFAULT_NMIVEC     0x00001004
+#define DEFAULT_MTVEC      0x00001010
+#define CONFIG_STRING_ADDR 0x0000100C
+#define EXT_IO_BASE        0x40000000
+#define DRAM_BASE          0x80000000
+
+/* RV32 satp field masks */
+#define SATP32_MODE 0x80000000
+#define SATP32_ASID 0x7fc00000
+#define SATP32_PPN  0x003fffff
+
+/* RV64 satp field masks */
+#define SATP64_MODE 0xF000000000000000ULL
+#define SATP64_ASID 0x0FFFF00000000000ULL
+#define SATP64_PPN  0x00000FFFFFFFFFFFULL
+
+#if defined(TARGET_RISCV32)
+#define SATP_MODE SATP32_MODE
+#define SATP_ASID SATP32_ASID
+#define SATP_PPN  SATP32_PPN
+#endif
+#if defined(TARGET_RISCV64)
+#define SATP_MODE SATP64_MODE
+#define SATP_ASID SATP64_ASID
+#define SATP_PPN  SATP64_PPN
+#endif
+
+/* RISCV Exception Codes */
+#define EXCP_NONE                       -1 /* not a real RISCV exception code */
+#define RISCV_EXCP_INST_ADDR_MIS           0x0
+#define RISCV_EXCP_INST_ACCESS_FAULT       0x1
+#define RISCV_EXCP_ILLEGAL_INST            0x2
+#define RISCV_EXCP_BREAKPOINT              0x3
+#define RISCV_EXCP_LOAD_ADDR_MIS           0x4
+#define RISCV_EXCP_LOAD_ACCESS_FAULT       0x5
+#define RISCV_EXCP_STORE_AMO_ADDR_MIS      0x6
+#define RISCV_EXCP_STORE_AMO_ACCESS_FAULT  0x7
+#define RISCV_EXCP_U_ECALL                 0x8 /* for convenience, report all
+                                                  ECALLs as this, handler
+                                                  fixes */
+#define RISCV_EXCP_S_ECALL                 0x9
+#define RISCV_EXCP_H_ECALL                 0xa
+#define RISCV_EXCP_M_ECALL                 0xb
+#define RISCV_EXCP_INST_PAGE_FAULT         0xc /* since: priv-1.10.0 */
+#define RISCV_EXCP_LOAD_PAGE_FAULT         0xd /* since: priv-1.10.0 */
+#define RISCV_EXCP_STORE_PAGE_FAULT        0xf /* since: priv-1.10.0 */
+
+#define RISCV_EXCP_INT_FLAG                0x80000000
+#define RISCV_EXCP_INT_MASK                0x7fffffff
+
+/* page table entry (PTE) fields */
+#define PTE_V     0x001 /* Valid */
+#define PTE_R     0x002 /* Read */
+#define PTE_W     0x004 /* Write */
+#define PTE_X     0x008 /* Execute */
+#define PTE_U     0x010 /* User */
+#define PTE_G     0x020 /* Global */
+#define PTE_A     0x040 /* Accessed */
+#define PTE_D     0x080 /* Dirty */
+#define PTE_SOFT  0x300 /* Reserved for Software */
+
+#define PTE_PPN_SHIFT 10
+
+#define PTE_TABLE(PTE) (((PTE) & (PTE_V | PTE_R | PTE_W | PTE_X)) == PTE_V)
-- 
2.7.0
