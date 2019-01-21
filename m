Received: from eggs.gnu.org ([209.51.188.92]:45194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1glZRY-0006ff-3w
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 08:16:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1glZRT-0004J4-0z
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 08:16:48 -0500
Received: from mail02.asahi-net.or.jp ([202.224.55.14]:54416)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1glZRQ-000439-P3
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 08:16:42 -0500
From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Mon, 21 Jan 2019 22:15:53 +0900
Message-Id: <20190121131602.55003-3-ysato@users.sourceforge.jp>
In-Reply-To: <20190121131602.55003-1-ysato@users.sourceforge.jp>
References: <20190121131602.55003-1-ysato@users.sourceforge.jp>
Subject: [Qemu-devel] [PATCH RFC 02/11] RX CPU definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 target/rx/cpu-qom.h |  54 +++++++++++++
 target/rx/cpu.c     | 226 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 target/rx/cpu.h     | 212 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 492 insertions(+)
 create mode 100644 target/rx/cpu-qom.h
 create mode 100644 target/rx/cpu.c
 create mode 100644 target/rx/cpu.h

diff --git a/target/rx/cpu-qom.h b/target/rx/cpu-qom.h
new file mode 100644
index 0000000000..7215e17ce8
--- /dev/null
+++ b/target/rx/cpu-qom.h
@@ -0,0 +1,54 @@
+/*
+ * QEMU RX CPU
+ *
+ * Copyright (c) 2019 Yoshinori Sato
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
+#ifndef QEMU_RX_CPU_QOM_H
+#define QEMU_RX_CPU_QOM_H
+
+#include "qom/cpu.h"
+
+#define TYPE_RXCPU "rxcpu"
+
+#define RXCPU_CLASS(klass)                                     \
+    OBJECT_CLASS_CHECK(RXCPUClass, (klass), TYPE_RXCPU)
+#define RXCPU(obj) \
+    OBJECT_CHECK(RXCPU, (obj), TYPE_RXCPU)
+#define RXCPU_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(RXCPUClass, (obj), TYPE_RXCPU)
+
+/*
+ * RXCPUClass:
+ * @parent_realize: The parent class' realize handler.
+ * @parent_reset: The parent class' reset handler.
+ *
+ * A RX CPU model.
+ */
+typedef struct RXCPUClass {
+    /*< private >*/
+    CPUClass parent_class;
+    /*< public >*/
+
+    DeviceRealize parent_realize;
+    void (*parent_reset)(CPUState *cpu);
+
+} RXCPUClass;
+
+typedef struct RXCPU RXCPU;
+
+#endif
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
new file mode 100644
index 0000000000..990620e353
--- /dev/null
+++ b/target/rx/cpu.c
@@ -0,0 +1,226 @@
+/*
+ * QEMU RX CPU
+ *
+ * Copyright (c) 2018 Yoshinori Sato
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
+#include "qapi/error.h"
+#include "cpu.h"
+#include "qemu-common.h"
+#include "migration/vmstate.h"
+#include "exec/exec-all.h"
+#include "hw/loader.h"
+
+static void rx_cpu_set_pc(CPUState *cs, vaddr value)
+{
+    RXCPU *cpu = RXCPU(cs);
+
+    cpu->env.pc = value;
+}
+
+static void rx_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock *tb)
+{
+    RXCPU *cpu = RXCPU(cs);
+
+    cpu->env.pc = tb->pc;
+}
+
+static bool rx_cpu_has_work(CPUState *cs)
+{
+    return cs->interrupt_request & CPU_INTERRUPT_HARD;
+}
+
+static void rx_cpu_reset(CPUState *s)
+{
+    RXCPU *cpu = RXCPU(s);
+    RXCPUClass *rcc = RXCPU_GET_CLASS(cpu);
+    CPURXState *env = &cpu->env;
+    uint32_t *resetvec;
+
+    rcc->parent_reset(s);
+
+    memset(env, 0, offsetof(CPURXState, end_reset_fields));
+
+    resetvec = rom_ptr(0xfffffffc, 4);
+    if (resetvec) {
+        /* In the case of kernel, it is ignored because it is not set. */
+        env->pc = ldl_p(resetvec);
+    }
+    env->psw = 0x00000000;
+}
+
+typedef struct RXCPUListState {
+    fprintf_function cpu_fprintf;
+    FILE *file;
+} RXCPUListState;
+
+static void rx_cpu_list_entry(gpointer data, gpointer user_data)
+{
+    RXCPUListState *s = user_data;
+    const char *typename = object_class_get_name(OBJECT_CLASS(data));
+    int len = strlen(typename) - strlen(RX_CPU_TYPE_SUFFIX);
+
+    (*s->cpu_fprintf)(s->file, "%.*s\n", len, typename);
+}
+
+void rx_cpu_list(FILE *f, fprintf_function cpu_fprintf)
+{
+    RXCPUListState s = {
+        .cpu_fprintf = cpu_fprintf,
+        .file = f,
+    };
+    GSList *list;
+
+    list = object_class_get_list_sorted(TYPE_RXCPU, false);
+    g_slist_foreach(list, rx_cpu_list_entry, &s);
+    g_slist_free(list);
+}
+
+static ObjectClass *rx_cpu_class_by_name(const char *cpu_model)
+{
+    ObjectClass *oc;
+    char *typename = NULL;
+
+    typename = g_strdup_printf(RX_CPU_TYPE_NAME(""));
+    oc = object_class_by_name(typename);
+    if (oc != NULL && object_class_is_abstract(oc)) {
+        oc = NULL;
+    }
+
+    g_free(typename);
+    return oc;
+}
+
+static void rx_cpu_realize(DeviceState *dev, Error **errp)
+{
+    CPUState *cs = CPU(dev);
+    RXCPUClass *rcc = RXCPU_GET_CLASS(dev);
+    Error *local_err = NULL;
+
+    cpu_exec_realizefn(cs, &local_err);
+    if (local_err != NULL) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    cpu_reset(cs);
+    qemu_init_vcpu(cs);
+
+    rcc->parent_realize(dev, errp);
+}
+
+static void rxcpu_set_irq(void *opaque, int no, int request)
+{
+    RXCPU *cpu = opaque;
+    CPUState *cs = CPU(cpu);
+    int irq = request & 0xff;
+
+    static const int mask[] = {
+        [RX_CPU_IRQ] = CPU_INTERRUPT_HARD,
+        [RX_CPU_FIR] = CPU_INTERRUPT_FIR,
+    };
+    if (request & 0x1000) {
+        cpu->env.irq = irq;
+        cpu->env.intlevel = (request >> 8) & 0x0f;
+        cpu_interrupt(cs, mask[no]);
+    } else
+        cpu_reset_interrupt(cs, mask[no]);
+}
+
+static void rx_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
+{
+    info->mach = bfd_mach_rx;
+    info->print_insn = print_insn_rx;
+}
+
+static void rx_cpu_init(Object *obj)
+{
+    CPUState *cs = CPU(obj);
+    RXCPU *cpu = RXCPU(obj);
+    CPURXState *env = &cpu->env;
+
+    cs->env_ptr = env;
+    qdev_init_gpio_in(DEVICE(cpu), rxcpu_set_irq, 2);
+}
+
+static void rxcpu_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    CPUClass *cc = CPU_CLASS(klass);
+    RXCPUClass *rcc = RXCPU_CLASS(klass);
+
+    device_class_set_parent_realize(dc, rx_cpu_realize,
+                                    &rcc->parent_realize);
+
+    rcc->parent_reset = cc->reset;
+    cc->reset = rx_cpu_reset;
+
+    cc->class_by_name = rx_cpu_class_by_name;
+    cc->has_work = rx_cpu_has_work;
+    cc->do_interrupt = rx_cpu_do_interrupt;
+    cc->cpu_exec_interrupt = rx_cpu_exec_interrupt;
+    cc->dump_state = rx_cpu_dump_state;
+    cc->set_pc = rx_cpu_set_pc;
+    cc->synchronize_from_tb = rx_cpu_synchronize_from_tb;
+    cc->gdb_read_register = rx_cpu_gdb_read_register;
+    cc->gdb_write_register = rx_cpu_gdb_write_register;
+    cc->get_phys_page_debug = rx_cpu_get_phys_page_debug;
+    cc->disas_set_info = rx_cpu_disas_set_info;
+    cc->tcg_initialize = rx_translate_init;
+
+    cc->gdb_num_core_regs = 26;
+}
+
+static const TypeInfo rxcpu_info = {
+    .name = TYPE_RXCPU,
+    .parent = TYPE_CPU,
+    .instance_size = sizeof(RXCPU),
+    .instance_init = rx_cpu_init,
+    .abstract = false,
+    .class_size = sizeof(RXCPUClass),
+    .class_init = rxcpu_class_init,
+};
+
+static void rxcpu_register_types(void)
+{
+    type_register_static(&rxcpu_info);
+}
+
+type_init(rxcpu_register_types)
+
+static uint32_t extable[32];
+
+void rx_load_image(RXCPU *cpu, const char *filename,
+                   uint32_t start, uint32_t size)
+{
+    long kernel_size;
+    int i;
+
+    kernel_size = load_image_targphys(filename, start, size);
+    if (kernel_size < 0) {
+        fprintf(stderr, "qemu: could not load kernel '%s'\n", filename);
+        exit(1);
+    }
+    cpu->env.pc = start;
+
+    /* setup exception trap trampoline */
+    for (i = 0; i < 32; i++) {
+        extable[i] = 0x10 + i * 4;
+    }
+    rom_add_blob_fixed("extable", extable, sizeof(extable), 0xffffff80);
+}
diff --git a/target/rx/cpu.h b/target/rx/cpu.h
new file mode 100644
index 0000000000..70c0cbe928
--- /dev/null
+++ b/target/rx/cpu.h
@@ -0,0 +1,212 @@
+/*
+ *  RX emulation
+ *
+ *  Copyright (c) 2019 Yoshinori Sato
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef RX_CPU_H
+#define RX_CPU_H
+
+#include "qemu-common.h"
+#include "cpu-qom.h"
+
+#define TARGET_LONG_BITS 32
+#define TARGET_PAGE_BITS 12
+
+#define CPUArchState struct CPURXState
+
+#include "exec/cpu-defs.h"
+
+#define TARGET_PHYS_ADDR_SPACE_BITS 32
+
+#define PSW_I3 27
+#define PSW_I2 26
+#define PSW_I1 25
+#define PSW_I0 24
+#define PSW_IPL PSW_I0
+#define PSW_PM 20
+#define PSW_U  17
+#define PSW_I  16
+#define PSW_O  3
+#define PSW_S  2
+#define PSW_Z  1
+#define PSW_C  0
+
+#define FPSW_MASK 0xfc007cff
+#define FPSW_RM_MASK 0x00000003
+#define FPSW_DN (1 << 8)
+#define FPSW_CAUSE_MASK 0x000000fc
+#define FPSW_CAUSE_SHIFT 2
+#define FPSW_CAUSE_V (1 << 2)
+#define FPSW_CAUSE_O (1 << 3)
+#define FPSW_CAUSE_Z (1 << 4)
+#define FPSW_CAUSE_U (1 << 5)
+#define FPSW_CAUSE_X (1 << 6)
+#define FPSW_CAUSE_E (1 << 7)
+#define FPSW_ENABLE_MASK 0x00007c00
+#define FPSW_ENABLE_SHIFT 10
+#define FPSW_ENABLE_V (1 << 10)
+#define FPSW_ENABLE_O (1 << 11)
+#define FPSW_ENABLE_Z (1 << 12)
+#define FPSW_ENABLE_U (1 << 13)
+#define FPSW_ENABLE_X (1 << 14)
+#define FPSW_FLAG_SHIFT 26
+#define FPSW_FLAG_V 26
+#define FPSW_FLAG_O 27
+#define FPSW_FLAG_Z 28
+#define FPSW_FLAG_U 29
+#define FPSW_FLAG_X 30
+#define FPSW_FLAG_S 31
+
+#define NB_MMU_MODES 1
+#define MMU_MODE0_SUFFIX _all
+
+#define RX_PSW_OP_NONE 0
+#define RX_PSW_OP_SUB 1
+#define RX_PSW_OP_ADD 2
+#define RX_PSW_OP_ABS 3
+#define RX_PSW_OP_DIV 4
+#define RX_PSW_OP_STRING 5
+#define RX_PSW_OP_BTST 6
+#define RX_PSW_OP_LOGIC 7
+#define RX_PSW_OP_ROT 8
+#define RX_PSW_OP_SHLL 9
+#define RX_PSW_OP_SHAR 10
+#define RX_PSW_OP_SHLR 11
+#define RX_PSW_OP_FLOAT 12
+#define RX_PSW_OP_FCMP 13
+
+typedef struct memory_content {
+    uint32_t address;
+    struct memory_content *next;
+} memory_content;
+
+struct CCop;
+
+typedef struct CPURXState {
+    /* CPU registers */
+    uint32_t regs[16];          /* general registers */
+    uint32_t psw;               /* processor status */
+    uint32_t psw_o;             /* O bit of status register */
+    uint32_t psw_s;             /* S bit of status register */
+    uint32_t psw_z;             /* Z bit of status register */
+    uint32_t psw_c;             /* C bit of status register */
+    uint32_t psw_u;
+    uint32_t psw_i;
+    uint32_t psw_pm;
+    uint32_t psw_ipl;
+    uint32_t bpsw;              /* backup status */
+    uint32_t bpc;               /* backup pc */
+    uint32_t isp;               /* global base register */
+    uint32_t usp;               /* vector base register */
+    uint32_t pc;                /* program counter */
+    uint32_t intb;              /* interrupt vector */
+    uint32_t fintv;
+    uint32_t fpsw;
+    uint32_t acc_m;
+    uint32_t acc_l;
+
+    /* Internal use */
+    uint32_t in_sleep;
+    uint32_t intlevel;          /* Requested interrupt level */
+    uint32_t irq;               /* Requested interrupt no (hard) */
+    uint32_t sirq;              /* Requested interrupt no (soft) */
+    float_status fp_status;
+
+    /* Flag operation */
+    uint32_t op_a1[12];
+    uint32_t op_a2[12];
+    uint32_t op_r[12];
+    uint32_t op_mode;
+    /* Fields up to this point are cleared by a CPU reset */
+    struct {} end_reset_fields;
+
+    CPU_COMMON
+
+    void *ack;
+} CPURXState;
+
+/*
+ * RXCPU:
+ * @env: #CPURXState
+ *
+ * A RX CPU
+ */
+struct RXCPU {
+    /*< private >*/
+    CPUState parent_obj;
+    /*< public >*/
+
+    CPURXState env;
+};
+
+static inline RXCPU *rx_env_get_cpu(CPURXState *env)
+{
+    return container_of(env, RXCPU, env);
+}
+
+#define ENV_GET_CPU(e) CPU(rx_env_get_cpu(e))
+
+#define ENV_OFFSET offsetof(RXCPU, env)
+
+#define RX_CPU_TYPE_SUFFIX "-" TYPE_RXCPU
+#define RX_CPU_TYPE_NAME(model) model RX_CPU_TYPE_SUFFIX
+#define CPU_RESOLVING_TYPE TYPE_RXCPU
+
+void rx_cpu_do_interrupt(CPUState *cpu);
+bool rx_cpu_exec_interrupt(CPUState *cpu, int int_req);
+void rx_cpu_dump_state(CPUState *cpu, FILE *f,
+                           fprintf_function cpu_fprintf, int flags);
+int rx_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
+int rx_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
+hwaddr rx_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+
+void rx_translate_init(void);
+int cpu_rx_signal_handler(int host_signum, void *pinfo,
+                           void *puc);
+
+void rx_cpu_list(FILE *f, fprintf_function cpu_fprintf);
+void rx_load_image(RXCPU *cpu, const char *filename,
+                   uint32_t start, uint32_t size);
+void rx_cpu_pack_psw(CPURXState *env);
+void rx_cpu_unpack_psw(CPURXState *env, int all);
+uint32_t rx_get_psw_low(CPURXState *env);
+
+#define cpu_signal_handler cpu_rx_signal_handler
+#define cpu_list rx_cpu_list
+
+#include "exec/cpu-all.h"
+
+#define CPU_INTERRUPT_SOFT CPU_INTERRUPT_TGT_INT_0
+#define CPU_INTERRUPT_FIR  CPU_INTERRUPT_TGT_INT_1
+
+#define RX_CPU_IRQ 0
+#define RX_CPU_FIR 1
+
+static inline void cpu_get_tb_cpu_state(CPURXState *env, target_ulong *pc,
+                                        target_ulong *cs_base, uint32_t *flags)
+{
+    *pc = env->pc;
+    *cs_base = 0;
+    *flags = 0;
+}
+
+static inline int cpu_mmu_index(CPURXState *env, bool ifetch)
+{
+    return 0;
+}
+
+#endif /* RX_CPU_H */
-- 
2.11.0
