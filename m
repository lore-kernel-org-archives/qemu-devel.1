Received: from eggs.gnu.org ([2001:4830:134:3::10]:46693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVUD8-0007to-4D
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVUD4-0004wF-Dl
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:22 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33821)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cVUD4-0004w9-6K
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:18 -0500
Received: by mail-qt0-x243.google.com with SMTP id a29so14087605qtb.1
	for <qemu-devel@nongnu.org>; Sun, 22 Jan 2017 18:18:18 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun, 22 Jan 2017 18:17:40 -0800
Message-Id: <20170123021748.13170-19-rth@twiddle.net>
In-Reply-To: <20170123021748.13170-1-rth@twiddle.net>
References: <20170123021748.13170-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 18/26] target-hppa: Add framework and enable
 compilation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

This is just about the minimum required to enable compilation
without actually executing any instructions.  This contains the
HPPACPU structure and the required callbacks, the gdbstub, the
basic translation loop, and a translate_one function that always
results in an illegal instruction.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 MAINTAINERS                         |   6 +
 configure                           |   6 +-
 default-configs/hppa-linux-user.mak |   1 +
 target/hppa/Makefile.objs           |   1 +
 target/hppa/cpu-qom.h               |  52 +++++
 target/hppa/cpu.c                   | 164 ++++++++++++++
 target/hppa/cpu.h                   | 144 ++++++++++++
 target/hppa/gdbstub.c               | 111 ++++++++++
 target/hppa/helper.c                | 137 ++++++++++++
 target/hppa/helper.h                |   3 +
 target/hppa/op_helper.c             |  65 ++++++
 target/hppa/translate.c             | 429 ++++++++++++++++++++++++++++++++++++
 12 files changed, 1116 insertions(+), 3 deletions(-)
 create mode 100644 default-configs/hppa-linux-user.mak
 create mode 100644 target/hppa/Makefile.objs
 create mode 100644 target/hppa/cpu-qom.h
 create mode 100644 target/hppa/cpu.c
 create mode 100644 target/hppa/cpu.h
 create mode 100644 target/hppa/gdbstub.c
 create mode 100644 target/hppa/helper.c
 create mode 100644 target/hppa/helper.h
 create mode 100644 target/hppa/op_helper.c
 create mode 100644 target/hppa/translate.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b5ebfab..44c42fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -132,6 +132,12 @@ F: include/hw/cris/
 F: tests/tcg/cris/
 F: disas/cris.c
 
+HPPA (PA-RISC)
+M: Richard Henderson <rth@twiddle.net>
+S: Maintained
+F: target/hppa/
+F: disas/hppa.c
+
 LM32
 M: Michael Walle <michael@walle.cc>
 S: Maintained
diff --git a/configure b/configure
index 494c9cc..90f01e8 100755
--- a/configure
+++ b/configure
@@ -510,8 +510,6 @@ elif check_define __arm__ ; then
   cpu="arm"
 elif check_define __aarch64__ ; then
   cpu="aarch64"
-elif check_define __hppa__ ; then
-  cpu="hppa"
 else
   cpu=$(uname -m)
 fi
@@ -5847,7 +5845,7 @@ target_name=$(echo $target | cut -d '-' -f 1)
 target_bigendian="no"
 
 case "$target_name" in
-  armeb|lm32|m68k|microblaze|mips|mipsn32|mips64|moxie|or32|ppc|ppcemb|ppc64|ppc64abi32|s390x|sh4eb|sparc|sparc64|sparc32plus|xtensaeb)
+  armeb|hppa|lm32|m68k|microblaze|mips|mipsn32|mips64|moxie|or32|ppc|ppcemb|ppc64|ppc64abi32|s390x|sh4eb|sparc|sparc64|sparc32plus|xtensaeb)
   target_bigendian=yes
   ;;
 esac
@@ -5910,6 +5908,8 @@ case "$target_name" in
   ;;
   cris)
   ;;
+  hppa)
+  ;;
   lm32)
   ;;
   m68k)
diff --git a/default-configs/hppa-linux-user.mak b/default-configs/hppa-linux-user.mak
new file mode 100644
index 0000000..7963939
--- /dev/null
+++ b/default-configs/hppa-linux-user.mak
@@ -0,0 +1 @@
+# Default configuration for hppa-linux-user
diff --git a/target/hppa/Makefile.objs b/target/hppa/Makefile.objs
new file mode 100644
index 0000000..263446f
--- /dev/null
+++ b/target/hppa/Makefile.objs
@@ -0,0 +1 @@
+obj-y += translate.o helper.o cpu.o op_helper.o gdbstub.o
diff --git a/target/hppa/cpu-qom.h b/target/hppa/cpu-qom.h
new file mode 100644
index 0000000..9084e47
--- /dev/null
+++ b/target/hppa/cpu-qom.h
@@ -0,0 +1,52 @@
+/*
+ * QEMU HPPA CPU
+ *
+ * Copyright (c) 2016 Richard Henderson <rth@twiddle.net>
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
+#ifndef QEMU_HPPA_CPU_QOM_H
+#define QEMU_HPPA_CPU_QOM_H
+
+#include "qom/cpu.h"
+
+#define TYPE_HPPA_CPU "hppa-cpu"
+
+#define HPPA_CPU_CLASS(klass) \
+    OBJECT_CLASS_CHECK(HPPACPUClass, (klass), TYPE_HPPA_CPU)
+#define HPPA_CPU(obj) \
+    OBJECT_CHECK(HPPACPU, (obj), TYPE_HPPA_CPU)
+#define HPPA_CPU_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(HPPACPUClass, (obj), TYPE_HPPA_CPU)
+
+/**
+ * HPPACPUClass:
+ * @parent_realize: The parent class' realize handler.
+ * @parent_reset: The parent class' reset handler.
+ *
+ * An HPPA CPU model.
+ */
+typedef struct HPPACPUClass {
+    /*< private >*/
+    CPUClass parent_class;
+    /*< public >*/
+
+    DeviceRealize parent_realize;
+    void (*parent_reset)(CPUState *cpu);
+} HPPACPUClass;
+
+typedef struct HPPACPU HPPACPU;
+
+#endif
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
new file mode 100644
index 0000000..1d791d0
--- /dev/null
+++ b/target/hppa/cpu.c
@@ -0,0 +1,164 @@
+/*
+ * QEMU HPPA CPU
+ *
+ * Copyright (c) 2016 Richard Henderson <rth@twiddle.net>
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
+
+
+static void hppa_cpu_set_pc(CPUState *cs, vaddr value)
+{
+    HPPACPU *cpu = HPPA_CPU(cs);
+
+    cpu->env.iaoq_f = value;
+    cpu->env.iaoq_b = value + 4;
+}
+
+static void hppa_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock *tb)
+{
+    HPPACPU *cpu = HPPA_CPU(cs);
+
+    cpu->env.iaoq_f = tb->pc;
+    cpu->env.iaoq_b = tb->cs_base;
+    cpu->env.psw_n = tb->flags & 1;
+}
+
+static void hppa_cpu_disas_set_info(CPUState *cs, disassemble_info *info)
+{
+    info->mach = bfd_mach_hppa20;
+    info->print_insn = print_insn_hppa;
+}
+
+static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
+{
+    CPUState *cs = CPU(dev);
+    HPPACPUClass *acc = HPPA_CPU_GET_CLASS(dev);
+    Error *local_err = NULL;
+
+    cpu_exec_realizefn(cs, &local_err);
+    if (local_err != NULL) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    qemu_init_vcpu(cs);
+    acc->parent_realize(dev, errp);
+}
+
+/* Sort hppabetically by type name. */
+static gint hppa_cpu_list_compare(gconstpointer a, gconstpointer b)
+{
+    ObjectClass *class_a = (ObjectClass *)a;
+    ObjectClass *class_b = (ObjectClass *)b;
+    const char *name_a, *name_b;
+
+    name_a = object_class_get_name(class_a);
+    name_b = object_class_get_name(class_b);
+    return strcmp(name_a, name_b);
+}
+
+static void hppa_cpu_list_entry(gpointer data, gpointer user_data)
+{
+    ObjectClass *oc = data;
+    CPUListState *s = user_data;
+
+    (*s->cpu_fprintf)(s->file, "  %s\n", object_class_get_name(oc));
+}
+
+void hppa_cpu_list(FILE *f, fprintf_function cpu_fprintf)
+{
+    CPUListState s = {
+        .file = f,
+        .cpu_fprintf = cpu_fprintf,
+    };
+    GSList *list;
+
+    list = object_class_get_list(TYPE_HPPA_CPU, false);
+    list = g_slist_sort(list, hppa_cpu_list_compare);
+    (*cpu_fprintf)(f, "Available CPUs:\n");
+    g_slist_foreach(list, hppa_cpu_list_entry, &s);
+    g_slist_free(list);
+}
+
+static void hppa_cpu_initfn(Object *obj)
+{
+    CPUState *cs = CPU(obj);
+    HPPACPU *cpu = HPPA_CPU(obj);
+    CPUHPPAState *env = &cpu->env;
+
+    cs->env_ptr = env;
+    cpu_hppa_loaded_fr0(env);
+    set_snan_bit_is_one(true, &env->fp_status);
+
+    hppa_translate_init();
+}
+
+HPPACPU *cpu_hppa_init(const char *cpu_model)
+{
+    HPPACPU *cpu;
+
+    cpu = HPPA_CPU(object_new(TYPE_HPPA_CPU));
+
+    object_property_set_bool(OBJECT(cpu), true, "realized", NULL);
+
+    return cpu;
+}
+
+static void hppa_cpu_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    CPUClass *cc = CPU_CLASS(oc);
+    HPPACPUClass *acc = HPPA_CPU_CLASS(oc);
+
+    acc->parent_realize = dc->realize;
+    dc->realize = hppa_cpu_realizefn;
+
+    cc->do_interrupt = hppa_cpu_do_interrupt;
+    cc->cpu_exec_interrupt = hppa_cpu_exec_interrupt;
+    cc->dump_state = hppa_cpu_dump_state;
+    cc->set_pc = hppa_cpu_set_pc;
+    cc->synchronize_from_tb = hppa_cpu_synchronize_from_tb;
+    cc->gdb_read_register = hppa_cpu_gdb_read_register;
+    cc->gdb_write_register = hppa_cpu_gdb_write_register;
+    cc->handle_mmu_fault = hppa_cpu_handle_mmu_fault;
+    cc->disas_set_info = hppa_cpu_disas_set_info;
+
+    cc->gdb_num_core_regs = 128;
+}
+
+static const TypeInfo hppa_cpu_type_info = {
+    .name = TYPE_HPPA_CPU,
+    .parent = TYPE_CPU,
+    .instance_size = sizeof(HPPACPU),
+    .instance_init = hppa_cpu_initfn,
+    .abstract = false,
+    .class_size = sizeof(HPPACPUClass),
+    .class_init = hppa_cpu_class_init,
+};
+
+static void hppa_cpu_register_types(void)
+{
+    type_register_static(&hppa_cpu_type_info);
+}
+
+type_init(hppa_cpu_register_types)
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
new file mode 100644
index 0000000..4cf4ac6
--- /dev/null
+++ b/target/hppa/cpu.h
@@ -0,0 +1,144 @@
+/*
+ * PA-RISC emulation cpu definitions for qemu.
+ *
+ * Copyright (c) 2016 Richard Henderson <rth@twiddle.net>
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
+#ifndef HPPA_CPU_H
+#define HPPA_CPU_H
+
+#include "qemu-common.h"
+#include "cpu-qom.h"
+
+/* We only support hppa-linux-user at present, so 32-bit only.  */
+#define TARGET_LONG_BITS 32
+#define TARGET_PHYS_ADDR_SPACE_BITS  32
+#define TARGET_VIRT_ADDR_SPACE_BITS  32
+
+#define CPUArchState struct CPUHPPAState
+
+#include "exec/cpu-defs.h"
+#include "fpu/softfloat.h"
+
+#define TARGET_PAGE_BITS 12
+
+#define ALIGNED_ONLY
+#define NB_MMU_MODES     1
+#define MMU_USER_IDX     0
+#define TARGET_INSN_START_EXTRA_WORDS 1
+
+#define EXCP_SYSCALL     1
+#define EXCP_SYSCALL_LWS 2
+#define EXCP_SIGSEGV     3
+#define EXCP_SIGILL      4
+#define EXCP_SIGFPE      5
+
+typedef struct CPUHPPAState CPUHPPAState;
+
+struct CPUHPPAState {
+    target_ulong gr[32];
+    uint64_t fr[32];
+
+    target_ulong sar;
+    target_ulong cr26;
+    target_ulong cr27;
+
+    target_ulong psw_n;      /* boolean */
+    target_long  psw_v;      /* in most significant bit */
+
+    /* Splitting the carry-borrow field into the MSB and "the rest", allows
+     * for "the rest" to be deleted when it is unused, but the MSB is in use.
+     * In addition, it's easier to compute carry-in for bit B+1 than it is to
+     * compute carry-out for bit B (3 vs 4 insns for addition, assuming the
+     * host has the appropriate add-with-carry insn to compute the msb).
+     * Therefore the carry bits are stored as: cb_msb : cb & 0x11111110.
+     */
+    target_ulong psw_cb;     /* in least significant bit of next nibble */
+    target_ulong psw_cb_msb; /* boolean */
+
+    target_ulong iaoq_f;     /* front */
+    target_ulong iaoq_b;     /* back, aka next instruction */
+
+    target_ulong ior;        /* interrupt offset register */
+
+    uint32_t fr0_shadow;     /* flags, c, ca/cq, rm, d, enables */
+    float_status fp_status;
+
+    /* Those resources are used only in QEMU core */
+    CPU_COMMON
+};
+
+/**
+ * HPPACPU:
+ * @env: #CPUHPPAState
+ *
+ * An HPPA CPU.
+ */
+struct HPPACPU {
+    /*< private >*/
+    CPUState parent_obj;
+    /*< public >*/
+
+    CPUHPPAState env;
+};
+
+static inline HPPACPU *hppa_env_get_cpu(CPUHPPAState *env)
+{
+    return container_of(env, HPPACPU, env);
+}
+
+#define ENV_GET_CPU(e)  CPU(hppa_env_get_cpu(e))
+#define ENV_OFFSET      offsetof(HPPACPU, env)
+
+#include "exec/cpu-all.h"
+
+static inline int cpu_mmu_index(CPUHPPAState *env, bool ifetch)
+{
+    return 0;
+}
+
+void hppa_translate_init(void);
+
+HPPACPU *cpu_hppa_init(const char *cpu_model);
+
+#define cpu_init(cpu_model) CPU(cpu_hppa_init(cpu_model))
+
+void hppa_cpu_list(FILE *f, fprintf_function cpu_fprintf);
+
+static inline void cpu_get_tb_cpu_state(CPUHPPAState *env, target_ulong *pc,
+                                        target_ulong *cs_base,
+                                        uint32_t *pflags)
+{
+    *pc = env->iaoq_f;
+    *cs_base = env->iaoq_b;
+    *pflags = env->psw_n;
+}
+
+target_ulong cpu_hppa_get_psw(CPUHPPAState *env);
+void cpu_hppa_put_psw(CPUHPPAState *env, target_ulong);
+void cpu_hppa_loaded_fr0(CPUHPPAState *env);
+
+#define cpu_signal_handler cpu_hppa_signal_handler
+
+int cpu_hppa_signal_handler(int host_signum, void *pinfo, void *puc);
+int hppa_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int rw, int midx);
+int hppa_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
+int hppa_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
+void hppa_cpu_do_interrupt(CPUState *cpu);
+bool hppa_cpu_exec_interrupt(CPUState *cpu, int int_req);
+void hppa_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function, int);
+
+#endif /* HPPA_CPU_H */
diff --git a/target/hppa/gdbstub.c b/target/hppa/gdbstub.c
new file mode 100644
index 0000000..413a5e1
--- /dev/null
+++ b/target/hppa/gdbstub.c
@@ -0,0 +1,111 @@
+/*
+ * HPPA gdb server stub
+ *
+ * Copyright (c) 2016 Richard Henderson <rth@twiddle.net>
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
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "cpu.h"
+#include "exec/gdbstub.h"
+
+int hppa_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+{
+    HPPACPU *cpu = HPPA_CPU(cs);
+    CPUHPPAState *env = &cpu->env;
+    target_ulong val;
+
+    switch (n) {
+    case 0:
+        val = cpu_hppa_get_psw(env);
+        break;
+    case 1 ... 31:
+        val = env->gr[n];
+        break;
+    case 32:
+        val = env->sar;
+        break;
+    case 33:
+        val = env->iaoq_f;
+        break;
+    case 35:
+        val = env->iaoq_b;
+        break;
+    case 59:
+        val = env->cr26;
+        break;
+    case 60:
+        val = env->cr27;
+        break;
+    case 64 ... 127:
+        val = extract64(env->fr[(n - 64) / 2], (n & 1 ? 0 : 32), 32);
+        break;
+    default:
+        if (n < 128) {
+            val = 0;
+        } else {
+            return 0;
+        }
+        break;
+    }
+    return gdb_get_regl(mem_buf, val);
+}
+
+int hppa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
+{
+    HPPACPU *cpu = HPPA_CPU(cs);
+    CPUHPPAState *env = &cpu->env;
+    target_ulong val = ldtul_p(mem_buf);
+
+    switch (n) {
+    case 0:
+        cpu_hppa_put_psw(env, val);
+        break;
+    case 1 ... 31:
+        env->gr[n] = val;
+        break;
+    case 32:
+        env->sar = val;
+        break;
+    case 33:
+        env->iaoq_f = val;
+        break;
+    case 35:
+        env->iaoq_b = val;
+    case 59:
+        env->cr26 = val;
+        break;
+    case 60:
+        env->cr27 = val;
+        break;
+    case 64:
+        env->fr[0] = deposit64(env->fr[0], 32, 32, val);
+        cpu_hppa_loaded_fr0(env);
+        break;
+    case 65 ... 127:
+        {
+            uint64_t *fr = &env->fr[(n - 64) / 2];
+            *fr = deposit64(*fr, val, (n & 1 ? 0 : 32), 32);
+        }
+        break;
+    default:
+        if (n >= 128) {
+            return 0;
+        }
+        break;
+    }
+    return sizeof(target_ulong);
+}
diff --git a/target/hppa/helper.c b/target/hppa/helper.c
new file mode 100644
index 0000000..ba04a9a
--- /dev/null
+++ b/target/hppa/helper.c
@@ -0,0 +1,137 @@
+/*
+ *  HPPA emulation cpu helpers for qemu.
+ *
+ * Copyright (c) 2016 Richard Henderson <rth@twiddle.net>
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
+#include "qemu/osdep.h"
+
+#include "cpu.h"
+#include "exec/exec-all.h"
+#include "fpu/softfloat.h"
+#include "exec/helper-proto.h"
+
+target_ulong cpu_hppa_get_psw(CPUHPPAState *env)
+{
+    target_ulong psw;
+
+    /* Fold carry bits down to 8 consecutive bits.  */
+    /* ??? Needs tweaking for hppa64.  */
+    /* .......b...c...d...e...f...g...h */
+    psw = (env->psw_cb >> 4) & 0x01111111;
+    /* .......b..bc..cd..de..ef..fg..gh */
+    psw |= psw >> 3;
+    /* .............bcd............efgh */
+    psw |= (psw >> 6) & 0x000f000f;
+    /* .........................bcdefgh */
+    psw |= (psw >> 12) & 0xf;
+    psw |= env->psw_cb_msb << 7;
+    psw <<= 8;
+
+    psw |= env->psw_n << 21;
+    psw |= (env->psw_v < 0) << 17;
+
+    return psw;
+}
+
+void cpu_hppa_put_psw(CPUHPPAState *env, target_ulong psw)
+{
+    target_ulong cb = 0;
+
+    env->psw_n = (psw >> 21) & 1;
+    env->psw_v = -((psw >> 17) & 1);
+    env->psw_cb_msb = (psw >> 15) & 1;
+
+    cb |= ((psw >> 14) & 1) << 28;
+    cb |= ((psw >> 13) & 1) << 24;
+    cb |= ((psw >> 12) & 1) << 20;
+    cb |= ((psw >> 11) & 1) << 16;
+    cb |= ((psw >> 10) & 1) << 12;
+    cb |= ((psw >>  9) & 1) <<  8;
+    cb |= ((psw >>  8) & 1) <<  4;
+    env->psw_cb = cb;
+}
+
+int hppa_cpu_handle_mmu_fault(CPUState *cs, vaddr address,
+                              int rw, int mmu_idx)
+{
+    HPPACPU *cpu = HPPA_CPU(cs);
+
+    cs->exception_index = EXCP_SIGSEGV;
+    cpu->env.ior = address;
+    return 1;
+}
+
+void hppa_cpu_do_interrupt(CPUState *cs)
+{
+    HPPACPU *cpu = HPPA_CPU(cs);
+    CPUHPPAState *env = &cpu->env;
+    int i = cs->exception_index;
+
+    if (qemu_loglevel_mask(CPU_LOG_INT)) {
+        static int count;
+        const char *name = "<unknown>";
+
+        switch (i) {
+        case EXCP_SYSCALL:
+            name = "syscall";
+            break;
+        case EXCP_SIGSEGV:
+            name = "sigsegv";
+            break;
+        case EXCP_SIGILL:
+            name = "sigill";
+            break;
+        case EXCP_SIGFPE:
+            name = "sigfpe";
+            break;
+        }
+        qemu_log("INT %6d: %s ia_f=" TARGET_FMT_lx "\n",
+                 ++count, name, env->iaoq_f);
+    }
+    cs->exception_index = -1;
+}
+
+bool hppa_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
+{
+    abort();
+    return false;
+}
+
+void hppa_cpu_dump_state(CPUState *cs, FILE *f,
+                         fprintf_function cpu_fprintf, int flags)
+{
+    HPPACPU *cpu = HPPA_CPU(cs);
+    CPUHPPAState *env = &cpu->env;
+    int i;
+
+    cpu_fprintf(f, "IA_F " TARGET_FMT_lx
+                   " IA_B " TARGET_FMT_lx
+                   " PSW  " TARGET_FMT_lx
+                   " [N:" TARGET_FMT_ld " V:%d"
+                   " CB:" TARGET_FMT_lx "]\n              ",
+                env->iaoq_f, env->iaoq_b, cpu_hppa_get_psw(env),
+                env->psw_n, env->psw_v < 0,
+                ((env->psw_cb >> 4) & 0x01111111) | (env->psw_cb_msb << 28));
+    for (i = 1; i < 32; i++) {
+        cpu_fprintf(f, "GR%02d " TARGET_FMT_lx " ", i, env->gr[i]);
+        if ((i % 4) == 3) {
+            cpu_fprintf(f, "\n");
+        }
+    }
+
+    /* ??? FR */
+}
diff --git a/target/hppa/helper.h b/target/hppa/helper.h
new file mode 100644
index 0000000..9c94dac
--- /dev/null
+++ b/target/hppa/helper.h
@@ -0,0 +1,3 @@
+DEF_HELPER_2(excp, noreturn, env, int)
+
+DEF_HELPER_FLAGS_1(loaded_fr0, TCG_CALL_NO_RWG, void, env)
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
new file mode 100644
index 0000000..4dd0119
--- /dev/null
+++ b/target/hppa/op_helper.c
@@ -0,0 +1,65 @@
+/*
+ * Helpers for HPPA instructions.
+ *
+ * Copyright (c) 2016 Richard Henderson <rth@twiddle.net>
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
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "exec/exec-all.h"
+#include "exec/helper-proto.h"
+
+void QEMU_NORETURN HELPER(excp)(CPUHPPAState *env, int excp)
+{
+    HPPACPU *cpu = hppa_env_get_cpu(env);
+    CPUState *cs = CPU(cpu);
+
+    cs->exception_index = excp;
+    cpu_loop_exit(cs);
+}
+
+void HELPER(loaded_fr0)(CPUHPPAState *env)
+{
+    uint32_t shadow = env->fr[0] >> 32;
+    int rm, d;
+
+    env->fr0_shadow = shadow;
+
+    switch (extract32(shadow, 9, 2)) {
+    default:
+        rm = float_round_nearest_even;
+        break;
+    case 1:
+        rm = float_round_to_zero;
+        break;
+    case 2:
+        rm = float_round_up;
+        break;
+    case 3:
+        rm = float_round_down;
+        break;
+    }
+    set_float_rounding_mode(rm, &env->fp_status);
+
+    d = extract32(shadow, 5, 1);
+    set_flush_to_zero(d, &env->fp_status);
+    set_flush_inputs_to_zero(d, &env->fp_status);
+}
+
+void cpu_hppa_loaded_fr0(CPUHPPAState *env)
+{
+    helper_loaded_fr0(env);
+}
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
new file mode 100644
index 0000000..8d61853
--- /dev/null
+++ b/target/hppa/translate.c
@@ -0,0 +1,429 @@
+/*
+ * HPPA emulation cpu translation for qemu.
+ *
+ * Copyright (c) 2016 Richard Henderson <rth@twiddle.net>
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
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "disas/disas.h"
+#include "qemu/host-utils.h"
+#include "exec/exec-all.h"
+#include "tcg-op.h"
+#include "exec/cpu_ldst.h"
+
+#include "exec/helper-proto.h"
+#include "exec/helper-gen.h"
+
+#include "trace-tcg.h"
+#include "exec/log.h"
+
+typedef struct DisasCond {
+    TCGCond c;
+    TCGv a0, a1;
+    bool a0_is_n;
+    bool a1_is_0;
+} DisasCond;
+
+typedef struct DisasContext {
+    struct TranslationBlock *tb;
+    CPUState *cs;
+
+    target_ulong iaoq_f;
+    target_ulong iaoq_b;
+    target_ulong iaoq_n;
+    TCGv iaoq_n_var;
+
+    int ntemps;
+    TCGv temps[8];
+
+    DisasCond null_cond;
+    TCGLabel *null_lab;
+
+    bool singlestep_enabled;
+    bool psw_n_nonzero;
+} DisasContext;
+
+/* Return values from translate_one, indicating the state of the TB.
+   Note that zero indicates that we are not exiting the TB.  */
+
+typedef enum {
+    NO_EXIT,
+
+    /* We have emitted one or more goto_tb.  No fixup required.  */
+    EXIT_GOTO_TB,
+
+    /* We are not using a goto_tb (for whatever reason), but have updated
+       the iaq (for whatever reason), so don't do it again on exit.  */
+    EXIT_IAQ_N_UPDATED,
+
+    /* We are exiting the TB, but have neither emitted a goto_tb, nor
+       updated the iaq for the next instruction to be executed.  */
+    EXIT_IAQ_N_STALE,
+
+    /* We are ending the TB with a noreturn function call, e.g. longjmp.
+       No following code will be executed.  */
+    EXIT_NORETURN,
+} ExitStatus;
+
+typedef struct DisasInsn {
+    uint32_t insn, mask;
+    ExitStatus (*trans)(DisasContext *ctx, uint32_t insn,
+                        const struct DisasInsn *f);
+} DisasInsn;
+
+/* global register indexes */
+static TCGv_env cpu_env;
+static TCGv cpu_gr[32];
+static TCGv cpu_iaoq_f;
+static TCGv cpu_iaoq_b;
+static TCGv cpu_sar;
+static TCGv cpu_psw_n;
+static TCGv cpu_psw_v;
+static TCGv cpu_psw_cb;
+static TCGv cpu_psw_cb_msb;
+static TCGv cpu_cr26;
+static TCGv cpu_cr27;
+
+#include "exec/gen-icount.h"
+
+void hppa_translate_init(void)
+{
+#define DEF_VAR(V)  { &cpu_##V, #V, offsetof(CPUHPPAState, V) }
+
+    typedef struct { TCGv *var; const char *name; int ofs; } GlobalVar;
+    static const GlobalVar vars[] = {
+        DEF_VAR(sar),
+        DEF_VAR(cr26),
+        DEF_VAR(cr27),
+        DEF_VAR(psw_n),
+        DEF_VAR(psw_v),
+        DEF_VAR(psw_cb),
+        DEF_VAR(psw_cb_msb),
+        DEF_VAR(iaoq_f),
+        DEF_VAR(iaoq_b),
+    };
+
+#undef DEF_VAR
+
+    /* Use the symbolic register names that match the disassembler.  */
+    static const char gr_names[32][4] = {
+        "r0",  "r1",  "r2",  "r3",  "r4",  "r5",  "r6",  "r7",
+        "r8",  "r9",  "r10", "r11", "r12", "r13", "r14", "r15",
+        "r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23",
+        "r24", "r25", "r26", "r27", "r28", "r29", "r30", "r31"
+    };
+
+    static bool done_init = 0;
+    int i;
+
+    if (done_init) {
+        return;
+    }
+    done_init = 1;
+
+    cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
+    tcg_ctx.tcg_env = cpu_env;
+
+    TCGV_UNUSED(cpu_gr[0]);
+    for (i = 1; i < 32; i++) {
+        cpu_gr[i] = tcg_global_mem_new(cpu_env,
+                                       offsetof(CPUHPPAState, gr[i]),
+                                       gr_names[i]);
+    }
+
+    for (i = 0; i < ARRAY_SIZE(vars); ++i) {
+        const GlobalVar *v = &vars[i];
+        *v->var = tcg_global_mem_new(cpu_env, v->ofs, v->name);
+    }
+}
+
+static TCGv get_temp(DisasContext *ctx)
+{
+    unsigned i = ctx->ntemps++;
+    g_assert(i < ARRAY_SIZE(ctx->temps));
+    return ctx->temps[i] = tcg_temp_new();
+}
+
+static TCGv load_const(DisasContext *ctx, target_long v)
+{
+    TCGv t = get_temp(ctx);
+    tcg_gen_movi_tl(t, v);
+    return t;
+}
+
+static TCGv load_gpr(DisasContext *ctx, unsigned reg)
+{
+    if (reg == 0) {
+        TCGv t = get_temp(ctx);
+        tcg_gen_movi_tl(t, 0);
+        return t;
+    } else {
+        return cpu_gr[reg];
+    }
+}
+
+static TCGv dest_gpr(DisasContext *ctx, unsigned reg)
+{
+    if (reg == 0) {
+        return get_temp(ctx);
+    } else {
+        return cpu_gr[reg];
+    }
+}
+
+static void copy_iaoq_entry(TCGv dest, target_ulong ival, TCGv vval)
+{
+    if (unlikely(ival == -1)) {
+        tcg_gen_mov_tl(dest, vval);
+    } else {
+        tcg_gen_movi_tl(dest, ival);
+    }
+}
+
+static inline target_ulong iaoq_dest(DisasContext *ctx, target_long disp)
+{
+    return ctx->iaoq_f + disp + 8;
+}
+
+static void gen_excp_1(int exception)
+{
+    TCGv_i32 t = tcg_const_i32(exception);
+    gen_helper_excp(cpu_env, t);
+    tcg_temp_free_i32(t);
+}
+
+static ExitStatus gen_excp(DisasContext *ctx, int exception)
+{
+    copy_iaoq_entry(cpu_iaoq_f, ctx->iaoq_f, cpu_iaoq_f);
+    copy_iaoq_entry(cpu_iaoq_b, ctx->iaoq_b, cpu_iaoq_b);
+    gen_excp_1(exception);
+    return EXIT_NORETURN;
+}
+
+static ExitStatus gen_illegal(DisasContext *ctx)
+{
+    return gen_excp(ctx, EXCP_SIGILL);
+}
+
+static bool use_goto_tb(DisasContext *ctx, target_ulong dest)
+{
+    /* Suppress goto_tb in the case of single-steping and IO.  */
+    if ((ctx->tb->cflags & CF_LAST_IO) || ctx->singlestep_enabled) {
+        return false;
+    }
+    return true;
+}
+
+static void gen_goto_tb(DisasContext *ctx, int which,
+                        target_ulong f, target_ulong b)
+{
+    if (f != -1 && b != -1 && use_goto_tb(ctx, f)) {
+        tcg_gen_goto_tb(which);
+        tcg_gen_movi_tl(cpu_iaoq_f, f);
+        tcg_gen_movi_tl(cpu_iaoq_b, b);
+        tcg_gen_exit_tb((uintptr_t)ctx->tb + which);
+    } else {
+        copy_iaoq_entry(cpu_iaoq_f, f, cpu_iaoq_b);
+        copy_iaoq_entry(cpu_iaoq_b, b, ctx->iaoq_n_var);
+        if (ctx->singlestep_enabled) {
+            gen_excp_1(EXCP_DEBUG);
+        } else {
+            tcg_gen_exit_tb(0);
+        }
+    }
+}
+
+static ExitStatus translate_table_int(DisasContext *ctx, uint32_t insn,
+                                      const DisasInsn table[], size_t n)
+{
+    size_t i;
+    for (i = 0; i < n; ++i) {
+        if ((insn & table[i].mask) == table[i].insn) {
+            return table[i].trans(ctx, insn, &table[i]);
+        }
+    }
+    return gen_illegal(ctx);
+}
+
+#define translate_table(ctx, insn, table) \
+    translate_table_int(ctx, insn, table, ARRAY_SIZE(table))
+
+static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
+{
+    uint32_t opc = extract32(insn, 26, 6);
+
+    switch (opc) {
+    default:
+        break;
+    }
+    return gen_illegal(ctx);
+}
+
+void gen_intermediate_code(CPUHPPAState *env, struct TranslationBlock *tb)
+{
+    HPPACPU *cpu = hppa_env_get_cpu(env);
+    CPUState *cs = CPU(cpu);
+    DisasContext ctx;
+    ExitStatus ret;
+    int num_insns, max_insns, i;
+
+    ctx.tb = tb;
+    ctx.cs = cs;
+    ctx.iaoq_f = tb->pc;
+    ctx.iaoq_b = tb->cs_base;
+    ctx.singlestep_enabled = cs->singlestep_enabled;
+
+    ctx.ntemps = 0;
+    for (i = 0; i < ARRAY_SIZE(ctx.temps); ++i) {
+        TCGV_UNUSED(ctx.temps[i]);
+    }
+
+    /* Compute the maximum number of insns to execute, as bounded by
+       (1) icount, (2) single-stepping, (3) branch delay slots, or
+       (4) the number of insns remaining on the current page.  */
+    max_insns = tb->cflags & CF_COUNT_MASK;
+    if (max_insns == 0) {
+        max_insns = CF_COUNT_MASK;
+    }
+    if (ctx.singlestep_enabled || singlestep) {
+        max_insns = 1;
+    } else if (max_insns > TCG_MAX_INSNS) {
+        max_insns = TCG_MAX_INSNS;
+    }
+
+    num_insns = 0;
+    gen_tb_start(tb);
+
+    do {
+        tcg_gen_insn_start(ctx.iaoq_f, ctx.iaoq_b);
+        num_insns++;
+
+        if (unlikely(cpu_breakpoint_test(cs, ctx.iaoq_f, BP_ANY))) {
+            ret = gen_excp(&ctx, EXCP_DEBUG);
+            break;
+        }
+        if (num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
+            gen_io_start();
+        }
+
+        {
+            /* Always fetch the insn, even if nullified, so that we check
+               the page permissions for execute.  */
+            uint32_t insn = cpu_ldl_code(env, ctx.iaoq_f);
+
+            /* Set up the IA queue for the next insn.
+               This will be overwritten by a branch.  */
+            if (ctx.iaoq_b == -1) {
+                ctx.iaoq_n = -1;
+                ctx.iaoq_n_var = get_temp(&ctx);
+                tcg_gen_addi_tl(ctx.iaoq_n_var, cpu_iaoq_b, 4);
+            } else {
+                ctx.iaoq_n = ctx.iaoq_b + 4;
+                TCGV_UNUSED(ctx.iaoq_n_var);
+            }
+
+            ret = translate_one(&ctx, insn);
+        }
+
+        for (i = 0; i < ctx.ntemps; ++i) {
+            tcg_temp_free(ctx.temps[i]);
+            TCGV_UNUSED(ctx.temps[i]);
+        }
+        ctx.ntemps = 0;
+
+        /* If we see non-linear instructions, exhaust instruction count,
+           or run out of buffer space, stop generation.  */
+        /* ??? The non-linear instruction restriction is purely due to
+           the debugging dump.  Otherwise we *could* follow unconditional
+           branches within the same page.  */
+        if (ret == NO_EXIT
+            && (ctx.iaoq_b != ctx.iaoq_f + 4
+                || num_insns >= max_insns
+                || tcg_op_buf_full())) {
+            ret = EXIT_IAQ_N_STALE;
+        }
+
+        ctx.iaoq_f = ctx.iaoq_b;
+        ctx.iaoq_b = ctx.iaoq_n;
+        if (ret == EXIT_NORETURN
+            || ret == EXIT_GOTO_TB
+            || ret == EXIT_IAQ_N_UPDATED) {
+            break;
+        }
+        if (ctx.iaoq_f == -1) {
+            tcg_gen_mov_tl(cpu_iaoq_f, cpu_iaoq_b);
+            copy_iaoq_entry(cpu_iaoq_b, ctx.iaoq_n, ctx.iaoq_n_var);
+            ret = EXIT_IAQ_N_UPDATED;
+            break;
+        }
+        if (ctx.iaoq_b == -1) {
+            tcg_gen_mov_tl(cpu_iaoq_b, ctx.iaoq_n_var);
+        }
+    } while (ret == NO_EXIT);
+
+    if (tb->cflags & CF_LAST_IO) {
+        gen_io_end();
+    }
+
+    switch (ret) {
+    case EXIT_GOTO_TB:
+    case EXIT_NORETURN:
+        break;
+    case EXIT_IAQ_N_STALE:
+        copy_iaoq_entry(cpu_iaoq_f, ctx.iaoq_f, cpu_iaoq_f);
+        copy_iaoq_entry(cpu_iaoq_b, ctx.iaoq_b, cpu_iaoq_b);
+        /* FALLTHRU */
+    case EXIT_IAQ_N_UPDATED:
+        if (ctx.singlestep_enabled) {
+            gen_excp_1(EXCP_DEBUG);
+        } else {
+            tcg_gen_exit_tb(0);
+        }
+        break;
+    default:
+        abort();
+    }
+
+    gen_tb_end(tb, num_insns);
+
+    tb->size = num_insns * 4;
+    tb->icount = num_insns;
+
+#ifdef DEBUG_DISAS
+    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
+        && qemu_log_in_addr_range(tb->pc)) {
+        qemu_log_lock();
+        qemu_log("IN: %s\n", lookup_symbol(tb->pc));
+        log_target_disas(cs, tb->pc, tb->size, 1);
+        qemu_log("\n");
+        qemu_log_unlock();
+    }
+#endif
+}
+
+void restore_state_to_opc(CPUHPPAState *env, TranslationBlock *tb,
+                          target_ulong *data)
+{
+    env->iaoq_f = data[0];
+    if (data[1] != -1) {
+        env->iaoq_b = data[1];
+    }
+    /* Since we were executing the instruction at IAOQ_F, and took some
+       sort of action that provoked the cpu_restore_state, we can infer
+       that the instruction was not nullified.  */
+    env->psw_n = 0;
+}
-- 
2.9.3
