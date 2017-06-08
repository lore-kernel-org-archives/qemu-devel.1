Received: from eggs.gnu.org ([2001:4830:134:3::10]:47236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1dJ2VN-0005cV-M1
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 14:50:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1dJ2VJ-0001Fx-Ep
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 14:50:01 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33608)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1dJ2VJ-0001FU-0y
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 14:49:57 -0400
Received: by mail-wm0-x241.google.com with SMTP id x3so8673985wme.0
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 11:49:56 -0700 (PDT)
From: Michael Rolnik <mrolnik@gmail.com>
Date: Thu,  8 Jun 2017 21:49:36 +0300
Message-Id: <20170608184944.19406-2-mrolnik@gmail.com>
In-Reply-To: <20170608184944.19406-1-mrolnik@gmail.com>
References: <20170608184944.19406-1-mrolnik@gmail.com>
Subject: [Qemu-devel] [PATCH RFC v19 01/13] target-avr: AVR cores support is
 added.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: anichang@protonmail.ch, Michael Rolnik <mrolnik@gmail.com>, Richard Henderson <rth@twiddle.net>

    1. basic CPU structure
    2. registers
    3. no instructions
    4. saving sreg, rampD, rampX, rampY, rampD, eind in HW representation

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Message-Id: <1471522070-77598-2-git-send-email-mrolnik@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 MAINTAINERS                     |   5 +
 arch_init.c                     |   2 +
 configure                       |   5 +
 default-configs/avr-softmmu.mak |  21 +++
 include/disas/bfd.h             |   6 +
 include/sysemu/arch_init.h      |   1 +
 target/avr/Makefile.objs        |  23 ++++
 target/avr/cpu-qom.h            |  84 ++++++++++++
 target/avr/cpu.c                | 288 ++++++++++++++++++++++++++++++++++++++++
 target/avr/cpu.h                | 179 +++++++++++++++++++++++++
 target/avr/gdbstub.c            |  85 ++++++++++++
 target/avr/helper.c             |  88 ++++++++++++
 target/avr/helper.h             |  21 +++
 target/avr/machine.c            | 120 +++++++++++++++++
 target/avr/translate.c          | 256 +++++++++++++++++++++++++++++++++++
 target/avr/translate.h          | 114 ++++++++++++++++
 16 files changed, 1298 insertions(+)
 create mode 100644 default-configs/avr-softmmu.mak
 create mode 100644 target/avr/Makefile.objs
 create mode 100644 target/avr/cpu-qom.h
 create mode 100644 target/avr/cpu.c
 create mode 100644 target/avr/cpu.h
 create mode 100644 target/avr/gdbstub.c
 create mode 100644 target/avr/helper.c
 create mode 100644 target/avr/helper.h
 create mode 100644 target/avr/machine.c
 create mode 100644 target/avr/translate.c
 create mode 100644 target/avr/translate.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 120788d8fb..dc37be323e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -125,6 +125,11 @@ F: disas/arm.c
 F: disas/arm-a64.cc
 F: disas/libvixl/
 
+AVR
+M: Michael Rolnik <mrolnik@gmail.com>
+S: Maintained
+F: target-avr/
+
 CRIS
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 S: Maintained
diff --git a/arch_init.c b/arch_init.c
index a0b8ed6167..4a9e74d62e 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -81,6 +81,8 @@ int graphic_depth = 32;
 #define QEMU_ARCH QEMU_ARCH_UNICORE32
 #elif defined(TARGET_TRICORE)
 #define QEMU_ARCH QEMU_ARCH_TRICORE
+#elif defined(TARGET_AVR)
+#define QEMU_ARCH QEMU_ARCH_AVR
 #endif
 
 const uint32_t arch_type = QEMU_ARCH;
diff --git a/configure b/configure
index 13e040d28c..d808340ece 100755
--- a/configure
+++ b/configure
@@ -6048,6 +6048,8 @@ case "$target_name" in
     mttcg="yes"
     gdb_xml_files="aarch64-core.xml aarch64-fpu.xml arm-core.xml arm-vfp.xml arm-vfp3.xml arm-neon.xml"
   ;;
+  avr)
+  ;;
   cris)
   ;;
   hppa)
@@ -6264,6 +6266,9 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
       disas_config "ARM_A64"
     fi
   ;;
+  avr)
+    disas_config "AVR"
+  ;;
   cris)
     disas_config "CRIS"
   ;;
diff --git a/default-configs/avr-softmmu.mak b/default-configs/avr-softmmu.mak
new file mode 100644
index 0000000000..003465dd1c
--- /dev/null
+++ b/default-configs/avr-softmmu.mak
@@ -0,0 +1,21 @@
+#
+#  QEMU AVR CPU
+#
+#  Copyright (c) 2016 Michael Rolnik
+#
+#  This library is free software; you can redistribute it and/or
+#  modify it under the terms of the GNU Lesser General Public
+#  License as published by the Free Software Foundation; either
+#  version 2.1 of the License, or (at your option) any later version.
+#
+#  This library is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY; without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+#  Lesser General Public License for more details.
+#
+#  You should have received a copy of the GNU Lesser General Public
+#  License along with this library; if not, see
+#  <http://www.gnu.org/licenses/lgpl-2.1.html>
+#
+
+# Default configuration for avr-softmmu
diff --git a/include/disas/bfd.h b/include/disas/bfd.h
index b01e002b4c..2b5841c696 100644
--- a/include/disas/bfd.h
+++ b/include/disas/bfd.h
@@ -213,6 +213,12 @@ enum bfd_architecture
 #define bfd_mach_m32r          0  /* backwards compatibility */
   bfd_arch_mn10200,    /* Matsushita MN10200 */
   bfd_arch_mn10300,    /* Matsushita MN10300 */
+  bfd_arch_avr,       /* Atmel AVR microcontrollers.  */
+#define bfd_mach_avr1          1
+#define bfd_mach_avr2          2
+#define bfd_mach_avr3          3
+#define bfd_mach_avr4          4
+#define bfd_mach_avr5          5
   bfd_arch_cris,       /* Axis CRIS */
 #define bfd_mach_cris_v0_v10   255
 #define bfd_mach_cris_v32      32
diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index 8751c468ed..1bf565f146 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -24,6 +24,7 @@ enum {
     QEMU_ARCH_MOXIE = (1 << 15),
     QEMU_ARCH_TRICORE = (1 << 16),
     QEMU_ARCH_NIOS2 = (1 << 17),
+    QEMU_ARCH_AVR = (1 << 18),
 };
 
 extern const uint32_t arch_type;
diff --git a/target/avr/Makefile.objs b/target/avr/Makefile.objs
new file mode 100644
index 0000000000..48233ef544
--- /dev/null
+++ b/target/avr/Makefile.objs
@@ -0,0 +1,23 @@
+#
+#  QEMU AVR CPU
+#
+#  Copyright (c) 2016 Michael Rolnik
+#
+#  This library is free software; you can redistribute it and/or
+#  modify it under the terms of the GNU Lesser General Public
+#  License as published by the Free Software Foundation; either
+#  version 2.1 of the License, or (at your option) any later version.
+#
+#  This library is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY; without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+#  Lesser General Public License for more details.
+#
+#  You should have received a copy of the GNU Lesser General Public
+#  License along with this library; if not, see
+#  <http://www.gnu.org/licenses/lgpl-2.1.html>
+#
+
+obj-y += translate.o cpu.o helper.o
+obj-y += gdbstub.o
+obj-$(CONFIG_SOFTMMU) += machine.o
diff --git a/target/avr/cpu-qom.h b/target/avr/cpu-qom.h
new file mode 100644
index 0000000000..b5cd5a7d73
--- /dev/null
+++ b/target/avr/cpu-qom.h
@@ -0,0 +1,84 @@
+/*
+ * QEMU AVR CPU
+ *
+ * Copyright (c) 2016 Michael Rolnik
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
+#ifndef QEMU_AVR_CPU_QOM_H
+#define QEMU_AVR_CPU_QOM_H
+
+#include "qom/cpu.h"
+
+#define TYPE_AVR_CPU "avr"
+
+#define AVR_CPU_CLASS(klass) \
+                    OBJECT_CLASS_CHECK(AVRCPUClass, (klass), TYPE_AVR_CPU)
+#define AVR_CPU(obj) \
+                    OBJECT_CHECK(AVRCPU, (obj), TYPE_AVR_CPU)
+#define AVR_CPU_GET_CLASS(obj) \
+                    OBJECT_GET_CLASS(AVRCPUClass, (obj), TYPE_AVR_CPU)
+
+/**
+ *  AVRCPUClass:
+ *  @parent_realize: The parent class' realize handler.
+ *  @parent_reset: The parent class' reset handler.
+ *  @vr: Version Register value.
+ *
+ *  A AVR CPU model.
+ */
+typedef struct AVRCPUClass {
+    CPUClass parent_class;
+
+    DeviceRealize parent_realize;
+    void (*parent_reset)(CPUState *cpu);
+} AVRCPUClass;
+
+/**
+ *  AVRCPU:
+ *  @env: #CPUAVRState
+ *
+ *  A AVR CPU.
+ */
+typedef struct AVRCPU {
+    /*< private >*/
+    CPUState parent_obj;
+    /*< public >*/
+
+    CPUAVRState env;
+} AVRCPU;
+
+static inline AVRCPU *avr_env_get_cpu(CPUAVRState *env)
+{
+    return container_of(env, AVRCPU, env);
+}
+
+#define ENV_GET_CPU(e) CPU(avr_env_get_cpu(e))
+#define ENV_OFFSET offsetof(AVRCPU, env)
+
+#ifndef CONFIG_USER_ONLY
+extern const struct VMStateDescription vms_avr_cpu;
+#endif
+
+void avr_cpu_do_interrupt(CPUState *cpu);
+bool avr_cpu_exec_interrupt(CPUState *cpu, int int_req);
+void avr_cpu_dump_state(CPUState *cs, FILE *f,
+                            fprintf_function cpu_fprintf, int flags);
+hwaddr avr_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+int avr_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
+int avr_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
+
+#endif
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
new file mode 100644
index 0000000000..af307d3418
--- /dev/null
+++ b/target/avr/cpu.c
@@ -0,0 +1,288 @@
+/*
+ * QEMU AVR CPU
+ *
+ * Copyright (c) 2016 Michael Rolnik
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
+
+static void avr_cpu_set_pc(CPUState *cs, vaddr value)
+{
+    AVRCPU *cpu = AVR_CPU(cs);
+
+    cpu->env.pc_w = value / 2; /* internally PC points to words */
+}
+
+static bool avr_cpu_has_work(CPUState *cs)
+{
+    AVRCPU *cpu = AVR_CPU(cs);
+    CPUAVRState *env = &cpu->env;
+
+    return (cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_RESET))
+            && cpu_interrupts_enabled(env);
+}
+
+static void avr_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock *tb)
+{
+    AVRCPU *cpu = AVR_CPU(cs);
+    CPUAVRState *env = &cpu->env;
+
+    env->pc_w = tb->pc / 2; /* internally PC points to words */
+}
+
+static void avr_cpu_reset(CPUState *s)
+{
+    AVRCPU *cpu = AVR_CPU(s);
+    AVRCPUClass *mcc = AVR_CPU_GET_CLASS(cpu);
+    CPUAVRState *env = &cpu->env;
+
+    mcc->parent_reset(s);
+
+    env->pc_w = 0;
+    env->sregI = 1;
+    env->sregC = 0;
+    env->sregZ = 0;
+    env->sregN = 0;
+    env->sregV = 0;
+    env->sregS = 0;
+    env->sregH = 0;
+    env->sregT = 0;
+
+    env->rampD = 0;
+    env->rampX = 0;
+    env->rampY = 0;
+    env->rampZ = 0;
+    env->eind = 0;
+    env->sp = 0;
+
+    memset(env->r, 0, sizeof(env->r));
+
+    tlb_flush(s);
+}
+
+static void avr_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
+{
+    info->mach = bfd_arch_avr;
+    info->print_insn = NULL;
+}
+
+static void avr_cpu_realizefn(DeviceState *dev, Error **errp)
+{
+    CPUState *cs = CPU(dev);
+    AVRCPUClass *mcc = AVR_CPU_GET_CLASS(dev);
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
+static void avr_cpu_set_int(void *opaque, int irq, int level)
+{
+    AVRCPU *cpu = opaque;
+    CPUAVRState *env = &cpu->env;
+    CPUState *cs = CPU(cpu);
+
+    uint64_t mask = (1ull << irq);
+    if (level) {
+        env->intsrc |= mask;
+        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
+    } else {
+        env->intsrc &= ~mask;
+        if (env->intsrc == 0) {
+            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
+        }
+    }
+}
+
+static void avr_cpu_initfn(Object *obj)
+{
+    CPUState *cs = CPU(obj);
+    AVRCPU *cpu = AVR_CPU(obj);
+
+    cs->env_ptr = &cpu->env;
+
+#ifndef CONFIG_USER_ONLY
+    qdev_init_gpio_in(DEVICE(cpu), avr_cpu_set_int, 37);
+#endif
+
+    if (tcg_enabled()) {
+        avr_translate_init();
+    }
+}
+
+static ObjectClass *avr_cpu_class_by_name(const char *cpu_model)
+{
+    ObjectClass *oc;
+    char *typename;
+    char **cpuname;
+
+    if (!cpu_model) {
+        return NULL;
+    }
+
+    cpuname = g_strsplit(cpu_model, ",", 1);
+    typename = g_strdup_printf("%s-" TYPE_AVR_CPU, cpuname[0]);
+    oc = object_class_by_name(typename);
+
+    g_strfreev(cpuname);
+    g_free(typename);
+
+    if (!oc
+        || !object_class_dynamic_cast(oc, TYPE_AVR_CPU)
+        || object_class_is_abstract(oc)) {
+        return NULL;
+    }
+
+    return oc;
+}
+
+static void avr_cpu_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    CPUClass *cc = CPU_CLASS(oc);
+    AVRCPUClass *mcc = AVR_CPU_CLASS(oc);
+
+    mcc->parent_realize = dc->realize;
+    dc->realize = avr_cpu_realizefn;
+
+    mcc->parent_reset = cc->reset;
+    cc->reset = avr_cpu_reset;
+
+    cc->class_by_name = avr_cpu_class_by_name;
+
+    cc->has_work = avr_cpu_has_work;
+    cc->do_interrupt = avr_cpu_do_interrupt;
+    cc->cpu_exec_interrupt = avr_cpu_exec_interrupt;
+    cc->dump_state = avr_cpu_dump_state;
+    cc->set_pc = avr_cpu_set_pc;
+#if !defined(CONFIG_USER_ONLY)
+    cc->memory_rw_debug = avr_cpu_memory_rw_debug;
+#endif
+#ifdef CONFIG_USER_ONLY
+    cc->handle_mmu_fault = avr_cpu_handle_mmu_fault;
+#else
+    cc->get_phys_page_debug = avr_cpu_get_phys_page_debug;
+    cc->vmsd = &vms_avr_cpu;
+#endif
+    cc->disas_set_info = avr_cpu_disas_set_info;
+    cc->synchronize_from_tb = avr_cpu_synchronize_from_tb;
+    cc->gdb_read_register = avr_cpu_gdb_read_register;
+    cc->gdb_write_register = avr_cpu_gdb_write_register;
+    cc->gdb_num_core_regs = 35;
+}
+
+typedef struct AVRCPUInfo {
+    const char *name;
+    void (*initfn)(Object *obj);
+} AVRCPUInfo;
+
+static const AVRCPUInfo avr_cpus[] = {
+};
+
+static gint avr_cpu_list_compare(gconstpointer a, gconstpointer b)
+{
+    ObjectClass *class_a = (ObjectClass *)a;
+    ObjectClass *class_b = (ObjectClass *)b;
+    const char *name_a;
+    const char *name_b;
+
+    name_a = object_class_get_name(class_a);
+    name_b = object_class_get_name(class_b);
+
+    return strcmp(name_a, name_b);
+}
+
+static void avr_cpu_list_entry(gpointer data, gpointer user_data)
+{
+    ObjectClass *oc = data;
+    CPUListState *s = user_data;
+    const char *typename;
+    char *name;
+
+    typename = object_class_get_name(oc);
+    name = g_strndup(typename, strlen(typename) - strlen("-" TYPE_AVR_CPU));
+    (*s->cpu_fprintf)(s->file, "  %s\n", name);
+    g_free(name);
+}
+
+void avr_cpu_list(FILE *f, fprintf_function cpu_fprintf)
+{
+    CPUListState s = {
+        .file = f,
+        .cpu_fprintf = cpu_fprintf,
+    };
+    GSList *list;
+
+    list = object_class_get_list(TYPE_AVR_CPU, false);
+    list = g_slist_sort(list, avr_cpu_list_compare);
+    (*cpu_fprintf)(f, "Available CPUs:\n");
+    g_slist_foreach(list, avr_cpu_list_entry, &s);
+    g_slist_free(list);
+}
+
+AVRCPU *cpu_avr_init(const char *cpu_model)
+{
+    return AVR_CPU(cpu_generic_init(TYPE_AVR_CPU, cpu_model));
+}
+
+static void cpu_register(const AVRCPUInfo *info)
+{
+    TypeInfo type_info = {
+        .parent = TYPE_AVR_CPU,
+        .instance_size = sizeof(AVRCPU),
+        .instance_init = info->initfn,
+        .class_size = sizeof(AVRCPUClass),
+    };
+
+    type_info.name = g_strdup_printf("%s-" TYPE_AVR_CPU, info->name);
+    type_register(&type_info);
+    g_free((void *)type_info.name);
+}
+
+static const TypeInfo avr_cpu_type_info = {
+    .name = TYPE_AVR_CPU,
+    .parent = TYPE_CPU,
+    .instance_size = sizeof(AVRCPU),
+    .instance_init = avr_cpu_initfn,
+    .class_size = sizeof(AVRCPUClass),
+    .class_init = avr_cpu_class_init,
+    .abstract = false,
+};
+
+static void avr_cpu_register_types(void)
+{
+    int i;
+    type_register_static(&avr_cpu_type_info);
+
+    for (i = 0; i < ARRAY_SIZE(avr_cpus); i++) {
+        cpu_register(&avr_cpus[i]);
+    }
+}
+
+type_init(avr_cpu_register_types)
diff --git a/target/avr/cpu.h b/target/avr/cpu.h
new file mode 100644
index 0000000000..fb05216ff5
--- /dev/null
+++ b/target/avr/cpu.h
@@ -0,0 +1,179 @@
+/*
+ * QEMU AVR CPU
+ *
+ * Copyright (c) 2016 Michael Rolnik
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
+#if !defined(CPU_AVR_H)
+#define CPU_AVR_H
+
+#include "qemu-common.h"
+
+#define TARGET_LONG_BITS 32
+
+#define CPUArchState struct CPUAVRState
+
+#include "exec/cpu-defs.h"
+#include "fpu/softfloat.h"
+
+/*
+ *  TARGET_PAGE_BITS cannot be more than 8 bits because
+ *  1.  all IO registers occupy [0x0000 .. 0x00ff] address range, and they
+ *      should be implemented as a device and not memory
+ *  2.  SRAM starts at the address 0x0100
+ */
+#define TARGET_PAGE_BITS 8
+#define TARGET_PHYS_ADDR_SPACE_BITS 24
+#define TARGET_VIRT_ADDR_SPACE_BITS 24
+#define NB_MMU_MODES 2
+
+/*
+ *  AVR has two memory spaces, data & code.
+ *  e.g. both have 0 address
+ *  ST/LD instructions access data space
+ *  LPM/SPM and instruction fetching access code memory space
+ */
+#define MMU_CODE_IDX 0
+#define MMU_DATA_IDX 1
+
+#define EXCP_RESET 1
+#define EXCP_INT(n) (EXCP_RESET + (n) + 1)
+
+#define PHYS_ADDR_MASK 0xfff00000
+
+#define PHYS_BASE_CODE 0x00000000
+#define PHYS_BASE_DATA 0x00800000
+#define PHYS_BASE_REGS 0x10000000
+
+#define VIRT_BASE_CODE 0x00000000
+#define VIRT_BASE_DATA 0x00000000
+#define VIRT_BASE_REGS 0x00000000
+
+/*
+ *  there are two groups of registers
+ *  1. CPU regs     - accessible by LD/ST and CPU itself
+ *  2. CPU IO regs  - accessible by LD/ST and IN/OUT
+ */
+#define AVR_CPU_REGS 0x0020
+#define AVR_CPU_IO_REGS 0x0040
+#define AVR_REGS (AVR_CPU_IO_REGS + AVR_CPU_REGS)
+
+#define AVR_CPU_REGS_BASE 0x0000
+#define AVR_CPU_IO_REGS_BASE (AVR_CPU_REGS_BASE + AVR_CPU_REGS)
+
+#define AVR_CPU_REGS_LAST (AVR_CPU_REGS_BASE + AVR_CPU_REGS - 1)
+#define AVR_CPU_IO_REGS_LAST (AVR_CPU_IO_REGS_BASE + AVR_CPU_IO_REGS - 1)
+
+typedef struct CPUAVRState CPUAVRState;
+
+struct CPUAVRState {
+    uint32_t pc_w; /* 0x003fffff up to 22 bits */
+
+    uint32_t sregC; /* 0x00000001 1 bits */
+    uint32_t sregZ; /* 0x0000ffff 16 bits, negative logic */
+    uint32_t sregN; /* 0x00000001 1 bits */
+    uint32_t sregV; /* 0x00000001 1 bits */
+    uint32_t sregS; /* 0x00000001 1 bits */
+    uint32_t sregH; /* 0x00000001 1 bits */
+    uint32_t sregT; /* 0x00000001 1 bits */
+    uint32_t sregI; /* 0x00000001 1 bits */
+
+    uint32_t rampD; /* 0x00ff0000 8 bits */
+    uint32_t rampX; /* 0x00ff0000 8 bits */
+    uint32_t rampY; /* 0x00ff0000 8 bits */
+    uint32_t rampZ; /* 0x00ff0000 8 bits */
+    uint32_t eind; /* 0x00ff0000 8 bits */
+
+    uint32_t r[AVR_CPU_REGS];
+                     /* 8 bits each */
+    uint32_t sp; /* 16 bits */
+
+    uint64_t intsrc; /* interrupt sources */
+
+    /* Those resources are used only in QEMU core */
+    CPU_COMMON
+};
+
+#define cpu_list avr_cpu_list
+#define cpu_signal_handler cpu_avr_signal_handler
+
+#include "exec/cpu-all.h"
+#include "cpu-qom.h"
+
+static inline int cpu_mmu_index(CPUAVRState *env, bool ifetch)
+{
+    return ifetch ? MMU_CODE_IDX : MMU_DATA_IDX;
+}
+
+void avr_translate_init(void);
+
+AVRCPU *cpu_avr_init(const char *cpu_model);
+
+#define cpu_init(cpu_model) CPU(cpu_avr_init(cpu_model))
+
+void avr_cpu_list(FILE *f, fprintf_function cpu_fprintf);
+int cpu_avr_exec(CPUState *cpu);
+int cpu_avr_signal_handler(int host_signum, void *pinfo, void *puc);
+int avr_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int rw,
+                                int mmu_idx);
+int avr_cpu_memory_rw_debug(CPUState *cs, vaddr address, uint8_t *buf,
+                                int len, bool is_write);
+
+static inline void cpu_get_tb_cpu_state(CPUAVRState *env, target_ulong *pc,
+                                target_ulong *cs_base, uint32_t *pflags)
+{
+    uint32_t flags = 0;
+
+    *pc = env->pc_w * 2;
+    *cs_base = 0;
+    *pflags = flags;
+}
+
+static inline int cpu_interrupts_enabled(CPUAVRState *env)
+{
+    return env->sregI != 0;
+}
+
+static inline uint8_t cpu_get_sreg(CPUAVRState *env)
+{
+    uint8_t sreg;
+    sreg = (env->sregC & 0x01) << 0
+         | (env->sregZ == 0 ? 1 : 0) << 1
+         | (env->sregN) << 2
+         | (env->sregV) << 3
+         | (env->sregS) << 4
+         | (env->sregH) << 5
+         | (env->sregT) << 6
+         | (env->sregI) << 7;
+    return sreg;
+}
+
+static inline void cpu_set_sreg(CPUAVRState *env, uint8_t sreg)
+{
+    env->sregC = (sreg >> 0) & 0x01;
+    env->sregZ = (sreg >> 1) & 0x01 ? 0 : 1;
+    env->sregN = (sreg >> 2) & 0x01;
+    env->sregV = (sreg >> 3) & 0x01;
+    env->sregS = (sreg >> 4) & 0x01;
+    env->sregH = (sreg >> 5) & 0x01;
+    env->sregT = (sreg >> 6) & 0x01;
+    env->sregI = (sreg >> 7) & 0x01;
+}
+
+#include "exec/exec-all.h"
+
+#endif /* !defined (CPU_AVR_H) */
diff --git a/target/avr/gdbstub.c b/target/avr/gdbstub.c
new file mode 100644
index 0000000000..537dc7226e
--- /dev/null
+++ b/target/avr/gdbstub.c
@@ -0,0 +1,85 @@
+/*
+ * QEMU AVR CPU
+ *
+ * Copyright (c) 2016 Michael Rolnik
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
+#include "exec/gdbstub.h"
+
+int avr_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+{
+    AVRCPU *cpu = AVR_CPU(cs);
+    CPUAVRState *env = &cpu->env;
+
+    /*  R */
+    if (n < 32) {
+        return gdb_get_reg8(mem_buf, env->r[n]);
+    }
+
+    /*  SREG */
+    if (n == 32) {
+        uint8_t sreg = cpu_get_sreg(env);
+
+        return gdb_get_reg8(mem_buf, sreg);
+    }
+
+    /*  SP */
+    if (n == 33) {
+        return gdb_get_reg16(mem_buf, env->sp & 0x0000ffff);
+    }
+
+    /*  PC */
+    if (n == 34) {
+        return gdb_get_reg32(mem_buf, env->pc_w * 2);
+    }
+
+    return 0;
+}
+
+int avr_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
+{
+    AVRCPU *cpu = AVR_CPU(cs);
+    CPUAVRState *env = &cpu->env;
+
+    /*  R */
+    if (n < 32) {
+        env->r[n] = *mem_buf;
+        return 1;
+    }
+
+    /*  SREG */
+    if (n == 32) {
+        cpu_set_sreg(env, *mem_buf);
+        return 1;
+    }
+
+    /*  SP */
+    if (n == 33) {
+        env->sp = lduw_p(mem_buf);
+        return 2;
+    }
+
+    /*  PC */
+    if (n == 34) {
+        env->pc_w = ldl_p(mem_buf) / 2;
+        return 4;
+    }
+
+    return 0;
+}
diff --git a/target/avr/helper.c b/target/avr/helper.c
new file mode 100644
index 0000000000..c1871939b3
--- /dev/null
+++ b/target/avr/helper.c
@@ -0,0 +1,88 @@
+/*
+ * QEMU AVR CPU
+ *
+ * Copyright (c) 2016 Michael Rolnik
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
+
+#include "cpu.h"
+#include "hw/irq.h"
+#include "include/hw/sysbus.h"
+#include "include/sysemu/sysemu.h"
+#include "exec/exec-all.h"
+#include "exec/cpu_ldst.h"
+#include "qemu/host-utils.h"
+#include "exec/helper-proto.h"
+
+bool avr_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
+{
+    bool ret = false;
+    return ret;
+}
+
+void avr_cpu_do_interrupt(CPUState *cs)
+{
+}
+
+int avr_cpu_memory_rw_debug(CPUState *cs, vaddr addr, uint8_t *buf,
+                                int len, bool is_write)
+{
+    return cpu_memory_rw_debug(cs, addr, buf, len, is_write);
+}
+
+hwaddr avr_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
+{
+    return addr; /* I assume 1:1 address correspondance */
+}
+
+int avr_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int rw, int mmu_idx)
+{
+    /* currently it's assumed that this will never happen */
+    cs->exception_index = EXCP_DEBUG;
+    cpu_dump_state(cs, stderr, fprintf, 0);
+    return 1;
+}
+
+void tlb_fill(CPUState *cs, target_ulong vaddr, MMUAccessType access_type,
+                                int mmu_idx, uintptr_t retaddr)
+{
+    target_ulong page_size = TARGET_PAGE_SIZE;
+    int prot = 0;
+    MemTxAttrs attrs = {};
+    uint32_t paddr;
+
+    vaddr &= TARGET_PAGE_MASK;
+
+    if (mmu_idx == MMU_CODE_IDX) {
+        paddr = PHYS_BASE_CODE + vaddr - VIRT_BASE_CODE;
+        prot = PAGE_READ | PAGE_EXEC;
+    } else {
+        paddr = PHYS_BASE_DATA + vaddr - VIRT_BASE_DATA;
+        prot = PAGE_READ | PAGE_WRITE;
+    }
+
+    tlb_set_page_with_attrs(cs, vaddr, paddr, attrs, prot, mmu_idx, page_size);
+}
+
+void helper_debug(CPUAVRState *env)
+{
+    CPUState *cs = CPU(avr_env_get_cpu(env));
+
+    cs->exception_index = EXCP_DEBUG;
+    cpu_loop_exit(cs);
+}
diff --git a/target/avr/helper.h b/target/avr/helper.h
new file mode 100644
index 0000000000..b5ef3bfb93
--- /dev/null
+++ b/target/avr/helper.h
@@ -0,0 +1,21 @@
+/*
+ * QEMU AVR CPU
+ *
+ * Copyright (c) 2016 Michael Rolnik
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
+DEF_HELPER_1(debug, void, env)
diff --git a/target/avr/machine.c b/target/avr/machine.c
new file mode 100644
index 0000000000..2442174542
--- /dev/null
+++ b/target/avr/machine.c
@@ -0,0 +1,120 @@
+/*
+ * QEMU AVR CPU
+ *
+ * Copyright (c) 2016 Michael Rolnik
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
+#include "hw/hw.h"
+#include "cpu.h"
+#include "hw/boards.h"
+#include "migration/qemu-file.h"
+
+static int get_sreg(QEMUFile *f, void *opaque, size_t size,
+                                                        VMStateField *field)
+{
+    CPUAVRState *env = opaque;
+    uint8_t sreg;
+
+    sreg = qemu_get_ubyte(f);
+    cpu_set_sreg(env, sreg);
+    return 0;
+}
+
+static int put_sreg(QEMUFile *f, void *opaque, size_t size,
+                                        VMStateField *field, QJSON *vmdesc)
+{
+    CPUAVRState *env = opaque;
+    uint8_t sreg = cpu_get_sreg(env);
+
+    qemu_put_byte(f, sreg);
+    return 0;
+}
+
+static const VMStateInfo vms_sreg = {
+    .name = "sreg",
+    .get = get_sreg,
+    .put = put_sreg,
+};
+
+static int get_segment(QEMUFile *f, void *opaque, size_t size,
+                                                        VMStateField *field)
+{
+    uint32_t *ramp = opaque;
+    uint8_t temp;
+
+    temp = qemu_get_ubyte(f);
+    *ramp = ((uint32_t)temp) << 16;
+    return 0;
+}
+
+static int put_segment(QEMUFile *f, void *opaque, size_t size,
+                                        VMStateField *field, QJSON *vmdesc)
+{
+    uint32_t *ramp = opaque;
+    uint8_t temp = *ramp >> 16;
+
+    qemu_put_byte(f, temp);
+    return 0;
+}
+
+static const VMStateInfo vms_rampD = {
+    .name = "rampD",
+    .get = get_segment,
+    .put = put_segment,
+};
+static const VMStateInfo vms_rampX = {
+    .name = "rampX",
+    .get = get_segment,
+    .put = put_segment,
+};
+static const VMStateInfo vms_rampY = {
+    .name = "rampY",
+    .get = get_segment,
+    .put = put_segment,
+};
+static const VMStateInfo vms_rampZ = {
+    .name = "rampZ",
+    .get = get_segment,
+    .put = put_segment,
+};
+static const VMStateInfo vms_eind = {
+    .name = "eind",
+    .get = get_segment,
+    .put = put_segment,
+};
+
+const VMStateDescription vms_avr_cpu = {
+    .name = "cpu",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(env.pc_w, AVRCPU),
+        VMSTATE_UINT32(env.sp, AVRCPU),
+
+        VMSTATE_UINT32_ARRAY(env.r, AVRCPU, AVR_CPU_REGS),
+
+        VMSTATE_SINGLE(env, AVRCPU, 0, vms_sreg, CPUAVRState),
+        VMSTATE_SINGLE(env.rampD, AVRCPU, 0, vms_rampD, uint32_t),
+        VMSTATE_SINGLE(env.rampX, AVRCPU, 0, vms_rampX, uint32_t),
+        VMSTATE_SINGLE(env.rampY, AVRCPU, 0, vms_rampY, uint32_t),
+        VMSTATE_SINGLE(env.rampZ, AVRCPU, 0, vms_rampZ, uint32_t),
+        VMSTATE_SINGLE(env.eind, AVRCPU, 0, vms_eind, uint32_t),
+
+        VMSTATE_END_OF_LIST()
+    }
+};
diff --git a/target/avr/translate.c b/target/avr/translate.c
new file mode 100644
index 0000000000..7926b7162f
--- /dev/null
+++ b/target/avr/translate.c
@@ -0,0 +1,256 @@
+/*
+ * QEMU AVR CPU
+ *
+ * Copyright (c) 2016 Michael Rolnik
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
+#include "translate.h"
+
+TCGv_env cpu_env;
+
+TCGv cpu_pc;
+
+TCGv cpu_Cf;
+TCGv cpu_Zf;
+TCGv cpu_Nf;
+TCGv cpu_Vf;
+TCGv cpu_Sf;
+TCGv cpu_Hf;
+TCGv cpu_Tf;
+TCGv cpu_If;
+
+TCGv cpu_rampD;
+TCGv cpu_rampX;
+TCGv cpu_rampY;
+TCGv cpu_rampZ;
+
+TCGv cpu_r[32];
+TCGv cpu_eind;
+TCGv cpu_sp;
+
+#include "exec/gen-icount.h"
+#define REG(x) (cpu_r[x])
+
+void avr_translate_init(void)
+{
+    int i;
+    static int done_init;
+
+    if (done_init) {
+        return;
+    }
+#define AVR_REG_OFFS(x) offsetof(CPUAVRState, x)
+    cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
+    cpu_pc = tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(pc_w), "pc");
+    cpu_Cf = tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(sregC), "Cf");
+    cpu_Zf = tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(sregZ), "Zf");
+    cpu_Nf = tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(sregN), "Nf");
+    cpu_Vf = tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(sregV), "Vf");
+    cpu_Sf = tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(sregS), "Sf");
+    cpu_Hf = tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(sregH), "Hf");
+    cpu_Tf = tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(sregT), "Tf");
+    cpu_If = tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(sregI), "If");
+    cpu_rampD = tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(rampD), "rampD");
+    cpu_rampX = tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(rampX), "rampX");
+    cpu_rampY = tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(rampY), "rampY");
+    cpu_rampZ = tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(rampZ), "rampZ");
+    cpu_eind = tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(eind), "eind");
+    cpu_sp = tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(sp), "sp");
+
+    for (i = 0; i < 32; i++) {
+        char name[16];
+
+        sprintf(name, "r[%d]", i);
+
+        cpu_r[i] = tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(r[i]), name);
+    }
+
+    done_init = 1;
+}
+
+static void decode_opc(AVRCPU *cpu, DisasContext *ctx, InstInfo *inst)
+{
+    CPUAVRState *env = &cpu->env;
+
+    inst->opcode = cpu_ldl_code(env, inst->cpc * 2);/* pc points to words */
+    inst->length = 16;
+    inst->translate = NULL;
+
+    if (inst->length == 16) {
+        inst->npc = inst->cpc + 1;
+        /* get opcode as 16bit value */
+        inst->opcode = inst->opcode & 0x0000ffff;
+    }
+    if (inst->length == 32) {
+        inst->npc = inst->cpc + 2;
+        /* get opcode as 32bit value */
+        inst->opcode = (inst->opcode << 16)
+                     | (inst->opcode >> 16);
+    }
+}
+
+/* generate intermediate code for basic block 'tb'. */
+void gen_intermediate_code(CPUAVRState *env, struct TranslationBlock *tb)
+{
+    AVRCPU *cpu = avr_env_get_cpu(env);
+    CPUState *cs = CPU(cpu);
+    DisasContext ctx;
+    target_ulong pc_start;
+    int num_insns, max_insns;
+    target_ulong cpc;
+    target_ulong npc;
+
+    pc_start = tb->pc / 2;
+    ctx.tb = tb;
+    ctx.memidx = 0;
+    ctx.bstate = BS_NONE;
+    ctx.singlestep = cs->singlestep_enabled;
+    num_insns = 0;
+    max_insns = tb->cflags & CF_COUNT_MASK;
+
+    if (max_insns == 0) {
+        max_insns = CF_COUNT_MASK;
+    }
+    if (max_insns > TCG_MAX_INSNS) {
+        max_insns = TCG_MAX_INSNS;
+    }
+
+    gen_tb_start(tb);
+
+    /* decode first instruction */
+    ctx.inst[0].cpc = pc_start;
+    decode_opc(cpu, &ctx, &ctx.inst[0]);
+    do {
+        /* set curr/next PCs */
+        cpc = ctx.inst[0].cpc;
+        npc = ctx.inst[0].npc;
+
+        /* decode next instruction */
+        ctx.inst[1].cpc = ctx.inst[0].npc;
+        decode_opc(cpu, &ctx, &ctx.inst[1]);
+
+        /* translate current instruction */
+        tcg_gen_insn_start(cpc);
+        num_insns++;
+
+        /*
+         * this is due to some strange GDB behavior
+         * let's assume main is has 0x100 address
+         * b main   - sets a breakpoint to 0x00000100 address (code)
+         * b *0x100 - sets a breakpoint to 0x00800100 address (data)
+         */
+        if (unlikely(cpu_breakpoint_test(cs, PHYS_BASE_CODE + cpc * 2, BP_ANY))
+                 || cpu_breakpoint_test(cs, PHYS_BASE_DATA + cpc * 2, BP_ANY)) {
+            tcg_gen_movi_i32(cpu_pc, cpc);
+            gen_helper_debug(cpu_env);
+            ctx.bstate = BS_EXCP;
+            goto done_generating;
+        }
+
+        if (ctx.inst[0].translate) {
+            ctx.bstate = ctx.inst[0].translate(env, &ctx, ctx.inst[0].opcode);
+        }
+
+        if (num_insns >= max_insns) {
+            break; /* max translated instructions limit reached */
+        }
+        if (ctx.singlestep) {
+            break; /* single step */
+        }
+        if ((cpc & (TARGET_PAGE_SIZE - 1)) == 0) {
+            break; /* page boundary */
+        }
+
+        ctx.inst[0] = ctx.inst[1]; /* make next inst curr */
+    } while (ctx.bstate == BS_NONE && !tcg_op_buf_full());
+
+    if (tb->cflags & CF_LAST_IO) {
+        gen_io_end();
+    }
+
+    if (ctx.singlestep) {
+        if (ctx.bstate == BS_STOP || ctx.bstate == BS_NONE) {
+            tcg_gen_movi_tl(cpu_pc, npc);
+        }
+        gen_helper_debug(cpu_env);
+        tcg_gen_exit_tb(0);
+    } else {
+        switch (ctx.bstate) {
+        case BS_STOP:
+        case BS_NONE:
+            gen_goto_tb(env, &ctx, 0, npc);
+            break;
+        case BS_BRANCH:
+        case BS_EXCP:
+            tcg_gen_exit_tb(0);
+            break;
+        default:
+            break;
+        }
+    }
+
+done_generating:
+    gen_tb_end(tb, num_insns);
+
+    tb->size = (npc - pc_start) * 2;
+    tb->icount = num_insns;
+}
+
+void restore_state_to_opc(CPUAVRState *env, TranslationBlock *tb,
+                            target_ulong *data)
+{
+    env->pc_w = data[0];
+}
+
+void avr_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
+                            int flags)
+{
+    AVRCPU *cpu = AVR_CPU(cs);
+    CPUAVRState *env = &cpu->env;
+    int i;
+
+    cpu_fprintf(f, "\n");
+    cpu_fprintf(f, "PC:    %06x\n", env->pc_w);
+    cpu_fprintf(f, "SP:      %04x\n", env->sp);
+    cpu_fprintf(f, "rampD:     %02x\n", env->rampD >> 16);
+    cpu_fprintf(f, "rampX:     %02x\n", env->rampX >> 16);
+    cpu_fprintf(f, "rampY:     %02x\n", env->rampY >> 16);
+    cpu_fprintf(f, "rampZ:     %02x\n", env->rampZ >> 16);
+    cpu_fprintf(f, "EIND:      %02x\n", env->eind);
+    cpu_fprintf(f, "X:       %02x%02x\n", env->r[27], env->r[26]);
+    cpu_fprintf(f, "Y:       %02x%02x\n", env->r[29], env->r[28]);
+    cpu_fprintf(f, "Z:       %02x%02x\n", env->r[31], env->r[30]);
+    cpu_fprintf(f, "SREG:    [ %c %c %c %c %c %c %c %c ]\n",
+                        env->sregI ? 'I' : '-',
+                        env->sregT ? 'T' : '-',
+                        env->sregH ? 'H' : '-',
+                        env->sregS ? 'S' : '-',
+                        env->sregV ? 'V' : '-',
+                        env->sregN ? '-' : 'N', /* Zf has negative logic */
+                        env->sregZ ? 'Z' : '-',
+                        env->sregC ? 'I' : '-');
+
+    cpu_fprintf(f, "\n");
+    for (i = 0; i < ARRAY_SIZE(env->r); i++) {
+        cpu_fprintf(f, "R[%02d]:  %02x   ", i, env->r[i]);
+
+        if ((i % 8) == 7) {
+            cpu_fprintf(f, "\n");
+        }
+    }
+    cpu_fprintf(f, "\n");
+}
diff --git a/target/avr/translate.h b/target/avr/translate.h
new file mode 100644
index 0000000000..99045a3b5e
--- /dev/null
+++ b/target/avr/translate.h
@@ -0,0 +1,114 @@
+/*
+ * QEMU AVR CPU
+ *
+ * Copyright (c) 2016 Michael Rolnik
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
+#ifndef AVR_TRANSLATE_H_
+#define AVR_TRANSLATE_H_
+
+#include "qemu/osdep.h"
+
+#include "tcg/tcg.h"
+#include "cpu.h"
+#include "exec/exec-all.h"
+#include "disas/disas.h"
+#include "tcg-op.h"
+#include "exec/cpu_ldst.h"
+
+#include "exec/helper-proto.h"
+#include "exec/helper-gen.h"
+#include "exec/log.h"
+
+extern TCGv_env cpu_env;
+
+extern TCGv cpu_pc;
+
+extern TCGv cpu_Cf;
+extern TCGv cpu_Zf;
+extern TCGv cpu_Nf;
+extern TCGv cpu_Vf;
+extern TCGv cpu_Sf;
+extern TCGv cpu_Hf;
+extern TCGv cpu_Tf;
+extern TCGv cpu_If;
+
+extern TCGv cpu_rampD;
+extern TCGv cpu_rampX;
+extern TCGv cpu_rampY;
+extern TCGv cpu_rampZ;
+
+extern TCGv cpu_r[32];
+extern TCGv cpu_eind;
+extern TCGv cpu_sp;
+
+enum {
+    BS_NONE = 0, /* Nothing special (none of the below) */
+    BS_STOP = 1, /* We want to stop translation for any reason */
+    BS_BRANCH = 2, /* A branch condition is reached */
+    BS_EXCP = 3, /* An exception condition is reached */
+};
+
+uint32_t get_opcode(uint8_t const *code, unsigned bitBase, unsigned bitSize);
+
+typedef struct DisasContext DisasContext;
+typedef struct InstInfo InstInfo;
+
+typedef int (*translate_function_t)(CPUAVRState *env, DisasContext *ctx,
+                                        uint32_t opcode);
+struct InstInfo {
+    target_long cpc;
+    target_long npc;
+    uint32_t opcode;
+    translate_function_t translate;
+    unsigned length;
+};
+
+/* This is the state at translation time. */
+struct DisasContext {
+    struct TranslationBlock *tb;
+
+    InstInfo inst[2];/* two consecutive instructions */
+
+    /* Routine used to access memory */
+    int memidx;
+    int bstate;
+    int singlestep;
+};
+
+void avr_decode(uint32_t pc, uint32_t *length, uint32_t opcode,
+                        translate_function_t *translate);
+
+static inline void gen_goto_tb(CPUAVRState *env, DisasContext *ctx,
+                        int n, target_ulong dest)
+{
+    TranslationBlock *tb;
+
+    tb = ctx->tb;
+
+    if (ctx->singlestep == 0) {
+        tcg_gen_goto_tb(n);
+        tcg_gen_movi_i32(cpu_pc, dest);
+        tcg_gen_exit_tb((uintptr_t)tb + n);
+    } else {
+        tcg_gen_movi_i32(cpu_pc, dest);
+        gen_helper_debug(cpu_env);
+        tcg_gen_exit_tb(0);
+    }
+}
+
+#endif
-- 
2.11.0 (Apple Git-81)
