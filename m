Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693AFC35247
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 02:03:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D7A820715
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 02:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D7A820715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izszL-0003Ip-8G
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 21:03:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59617)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1izsvY-0005qF-W4
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 20:59:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1izsvW-000184-JK
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 20:59:28 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:49890 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1izsvW-0000H8-6a
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 20:59:26 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 7FC771A20F8;
 Fri,  7 Feb 2020 02:58:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 20AE71A1FEC;
 Fri,  7 Feb 2020 02:58:22 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH rc5 02/32] target/avr: Introduce basic CPU class object
Date: Fri,  7 Feb 2020 02:57:30 +0100
Message-Id: <1581040680-308-3-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581040680-308-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1581040680-308-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>, Michael Rolnik <mrolnik@gmail.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Rolnik <mrolnik@gmail.com>

This patch introduces AVR CPU class object and its basic elements
and functions.

[AM: Split a larger AVR introduction patch into logical units]
Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Co-developed-by: Michael Rolnik <mrolnik@gmail.com>
Co-developed-by: Sarah Harris <S.E.Harris@kent.ac.uk>
Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/avr/cpu-qom.h |  54 ++++++++++++++
 target/avr/cpu.h     | 139 ++++++++++++++++++++++++++++++++++
 target/avr/cpu.c     | 207 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
 MAINTAINERS          |   2 +
 4 files changed, 402 insertions(+)
 create mode 100644 target/avr/cpu-qom.h
 create mode 100644 target/avr/cpu.c

diff --git a/target/avr/cpu-qom.h b/target/avr/cpu-qom.h
new file mode 100644
index 0000000..e28b58c
--- /dev/null
+++ b/target/avr/cpu-qom.h
@@ -0,0 +1,54 @@
+/*
+ * QEMU AVR CPU
+ *
+ * Copyright (c) 2019 Michael Rolnik
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
+#ifndef QEMU_AVR_QOM_H
+#define QEMU_AVR_QOM_H
+
+#include "hw/core/cpu.h"
+
+#define TYPE_AVR_CPU "avr-cpu"
+
+#define AVR_CPU_CLASS(klass) \
+    OBJECT_CLASS_CHECK(AVRCPUClass, (klass), TYPE_AVR_CPU)
+#define AVR_CPU(obj) \
+    OBJECT_CHECK(AVRCPU, (obj), TYPE_AVR_CPU)
+#define AVR_CPU_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(AVRCPUClass, (obj), TYPE_AVR_CPU)
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
+    /*< private >*/
+    CPUClass parent_class;
+    /*< public >*/
+    DeviceRealize parent_realize;
+    void (*parent_reset)(CPUState *cpu);
+} AVRCPUClass;
+
+typedef struct AVRCPU AVRCPU;
+
+
+#endif /* !defined (QEMU_AVR_CPU_QOM_H) */
diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index ecdeafb..ac14e64 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -21,8 +21,17 @@
 #ifndef QEMU_AVR_CPU_H
 #define QEMU_AVR_CPU_H
=20
+#include "cpu-qom.h"
 #include "exec/cpu-defs.h"
=20
+#ifdef CONFIG_USER_ONLY
+#error "AVR 8-bit does not support user mode"
+#endif
+
+#define AVR_CPU_TYPE_SUFFIX "-" TYPE_AVR_CPU
+#define AVR_CPU_TYPE_NAME(name) (name AVR_CPU_TYPE_SUFFIX)
+#define CPU_RESOLVING_TYPE TYPE_AVR_CPU
+
 #define TCG_GUEST_DEFAULT_MO 0
=20
 /*
@@ -63,4 +72,134 @@
  */
 #define OFFSET_IO_REGISTERS (OFFSET_DATA + NUMBER_OF_CPU_REGISTERS)
=20
+typedef struct CPUAVRState CPUAVRState;
+
+struct CPUAVRState {
+    uint32_t pc_w; /* 0x003fffff up to 22 bits */
+
+    uint32_t sregC; /* 0x00000001 1 bit */
+    uint32_t sregZ; /* 0x00000001 1 bit */
+    uint32_t sregN; /* 0x00000001 1 bit */
+    uint32_t sregV; /* 0x00000001 1 bit */
+    uint32_t sregS; /* 0x00000001 1 bit */
+    uint32_t sregH; /* 0x00000001 1 bit */
+    uint32_t sregT; /* 0x00000001 1 bit */
+    uint32_t sregI; /* 0x00000001 1 bit */
+
+    uint32_t rampD; /* 0x00ff0000 8 bits */
+    uint32_t rampX; /* 0x00ff0000 8 bits */
+    uint32_t rampY; /* 0x00ff0000 8 bits */
+    uint32_t rampZ; /* 0x00ff0000 8 bits */
+    uint32_t eind; /* 0x00ff0000 8 bits */
+
+    uint32_t r[NUMBER_OF_CPU_REGISTERS]; /* 8 bits each */
+    uint32_t sp; /* 16 bits */
+
+    uint32_t skip; /* if set skip instruction */
+
+    uint64_t intsrc; /* interrupt sources */
+    bool fullacc; /* CPU/MEM if true MEM only otherwise */
+
+    uint64_t features;
+};
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
+    CPUNegativeOffsetState neg;
+    CPUAVRState env;
+} AVRCPU;
+
+void avr_cpu_do_interrupt(CPUState *cpu);
+bool avr_cpu_exec_interrupt(CPUState *cpu, int int_req);
+hwaddr avr_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+
+#define cpu_list avr_cpu_list
+#define cpu_signal_handler cpu_avr_signal_handler
+#define cpu_mmu_index avr_cpu_mmu_index
+
+static inline int avr_cpu_mmu_index(CPUAVRState *env, bool ifetch)
+{
+    return ifetch ? MMU_CODE_IDX : MMU_DATA_IDX;
+}
+
+void avr_cpu_tcg_init(void);
+
+void avr_cpu_list(void);
+int cpu_avr_exec(CPUState *cpu);
+int cpu_avr_signal_handler(int host_signum, void *pinfo, void *puc);
+int avr_cpu_memory_rw_debug(CPUState *cs, vaddr address, uint8_t *buf,
+                                int len, bool is_write);
+
+enum {
+    TB_FLAGS_FULL_ACCESS =3D 1,
+    TB_FLAGS_SKIP =3D 2,
+};
+
+static inline void cpu_get_tb_cpu_state(CPUAVRState *env, target_ulong *=
pc,
+                                target_ulong *cs_base, uint32_t *pflags)
+{
+    uint32_t flags =3D 0;
+
+    *pc =3D env->pc_w * 2;
+    *cs_base =3D 0;
+
+    if (env->fullacc) {
+        flags |=3D TB_FLAGS_FULL_ACCESS;
+    }
+    if (env->skip) {
+        flags |=3D TB_FLAGS_SKIP;
+    }
+
+    *pflags =3D flags;
+}
+
+static inline int cpu_interrupts_enabled(CPUAVRState *env)
+{
+    return env->sregI !=3D 0;
+}
+
+static inline uint8_t cpu_get_sreg(CPUAVRState *env)
+{
+    uint8_t sreg;
+    sreg =3D (env->sregC) << 0
+         | (env->sregZ) << 1
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
+    env->sregC =3D (sreg >> 0) & 0x01;
+    env->sregZ =3D (sreg >> 1) & 0x01;
+    env->sregN =3D (sreg >> 2) & 0x01;
+    env->sregV =3D (sreg >> 3) & 0x01;
+    env->sregS =3D (sreg >> 4) & 0x01;
+    env->sregH =3D (sreg >> 5) & 0x01;
+    env->sregT =3D (sreg >> 6) & 0x01;
+    env->sregI =3D (sreg >> 7) & 0x01;
+}
+
+bool avr_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                        MMUAccessType access_type, int mmu_idx,
+                        bool probe, uintptr_t retaddr);
+
+typedef CPUAVRState CPUArchState;
+typedef AVRCPU ArchCPU;
+
+#include "exec/cpu-all.h"
+
 #endif /* !defined (QEMU_AVR_CPU_H) */
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
new file mode 100644
index 0000000..442391c
--- /dev/null
+++ b/target/avr/cpu.c
@@ -0,0 +1,207 @@
+/*
+ * QEMU AVR CPU
+ *
+ * Copyright (c) 2019 Michael Rolnik
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
+#include "qemu/qemu-print.h"
+#include "exec/exec-all.h"
+#include "cpu.h"
+#include "disas/dis-asm.h"
+
+static void avr_cpu_set_pc(CPUState *cs, vaddr value)
+{
+    AVRCPU *cpu =3D AVR_CPU(cs);
+
+    cpu->env.pc_w =3D value / 2; /* internally PC points to words */
+}
+
+static bool avr_cpu_has_work(CPUState *cs)
+{
+    AVRCPU *cpu =3D AVR_CPU(cs);
+    CPUAVRState *env =3D &cpu->env;
+
+    return (cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_=
RESET))
+            && cpu_interrupts_enabled(env);
+}
+
+static void avr_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock *=
tb)
+{
+    AVRCPU *cpu =3D AVR_CPU(cs);
+    CPUAVRState *env =3D &cpu->env;
+
+    env->pc_w =3D tb->pc / 2; /* internally PC points to words */
+}
+
+static void avr_cpu_reset(CPUState *cs)
+{
+    AVRCPU *cpu =3D AVR_CPU(cs);
+    AVRCPUClass *mcc =3D AVR_CPU_GET_CLASS(cpu);
+    CPUAVRState *env =3D &cpu->env;
+
+    mcc->parent_reset(cs);
+
+    env->pc_w =3D 0;
+    env->sregI =3D 1;
+    env->sregC =3D 0;
+    env->sregZ =3D 0;
+    env->sregN =3D 0;
+    env->sregV =3D 0;
+    env->sregS =3D 0;
+    env->sregH =3D 0;
+    env->sregT =3D 0;
+
+    env->rampD =3D 0;
+    env->rampX =3D 0;
+    env->rampY =3D 0;
+    env->rampZ =3D 0;
+    env->eind =3D 0;
+    env->sp =3D 0;
+
+    env->skip =3D 0;
+
+    memset(env->r, 0, sizeof(env->r));
+
+    tlb_flush(cs);
+}
+
+static void avr_cpu_disas_set_info(CPUState *cpu, disassemble_info *info=
)
+{
+    info->mach =3D bfd_arch_avr;
+    info->print_insn =3D NULL;
+}
+
+static void avr_cpu_realizefn(DeviceState *dev, Error **errp)
+{
+    CPUState *cs =3D CPU(dev);
+    AVRCPUClass *mcc =3D AVR_CPU_GET_CLASS(dev);
+    Error *local_err =3D NULL;
+
+    cpu_exec_realizefn(cs, &local_err);
+    if (local_err !=3D NULL) {
+        error_propagate(errp, local_err);
+        return;
+    }
+    qemu_init_vcpu(cs);
+    cpu_reset(cs);
+
+    mcc->parent_realize(dev, errp);
+}
+
+static void avr_cpu_set_int(void *opaque, int irq, int level)
+{
+    AVRCPU *cpu =3D opaque;
+    CPUAVRState *env =3D &cpu->env;
+    CPUState *cs =3D CPU(cpu);
+
+    uint64_t mask =3D (1ull << irq);
+    if (level) {
+        env->intsrc |=3D mask;
+        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
+    } else {
+        env->intsrc &=3D ~mask;
+        if (env->intsrc =3D=3D 0) {
+            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
+        }
+    }
+}
+
+static void avr_cpu_initfn(Object *obj)
+{
+    AVRCPU *cpu =3D AVR_CPU(obj);
+
+    cpu_set_cpustate_pointers(cpu);
+
+    /* Set the number of interrupts supported by the CPU. */
+    qdev_init_gpio_in(DEVICE(cpu), avr_cpu_set_int,
+            sizeof(cpu->env.intsrc) * 8);
+}
+
+static ObjectClass *avr_cpu_class_by_name(const char *cpu_model)
+{
+    ObjectClass *oc;
+
+    oc =3D object_class_by_name(cpu_model);
+    if (object_class_dynamic_cast(oc, TYPE_AVR_CPU) =3D=3D NULL ||
+        object_class_is_abstract(oc)) {
+        oc =3D NULL;
+    }
+    return oc;
+}
+
+static void avr_cpu_dump_state(CPUState *cs, FILE *f, int flags)
+{
+    AVRCPU *cpu =3D AVR_CPU(cs);
+    CPUAVRState *env =3D &cpu->env;
+    int i;
+
+    qemu_fprintf(f, "\n");
+    qemu_fprintf(f, "PC:    %06x\n", env->pc_w);
+    qemu_fprintf(f, "SP:      %04x\n", env->sp);
+    qemu_fprintf(f, "rampD:     %02x\n", env->rampD >> 16);
+    qemu_fprintf(f, "rampX:     %02x\n", env->rampX >> 16);
+    qemu_fprintf(f, "rampY:     %02x\n", env->rampY >> 16);
+    qemu_fprintf(f, "rampZ:     %02x\n", env->rampZ >> 16);
+    qemu_fprintf(f, "EIND:      %02x\n", env->eind >> 16);
+    qemu_fprintf(f, "X:       %02x%02x\n", env->r[27], env->r[26]);
+    qemu_fprintf(f, "Y:       %02x%02x\n", env->r[29], env->r[28]);
+    qemu_fprintf(f, "Z:       %02x%02x\n", env->r[31], env->r[30]);
+    qemu_fprintf(f, "SREG:    [ %c %c %c %c %c %c %c %c ]\n",
+                        env->sregI ? 'I' : '-',
+                        env->sregT ? 'T' : '-',
+                        env->sregH ? 'H' : '-',
+                        env->sregS ? 'S' : '-',
+                        env->sregV ? 'V' : '-',
+                        env->sregN ? '-' : 'N', /* Zf has negative logic=
 */
+                        env->sregZ ? 'Z' : '-',
+                        env->sregC ? 'I' : '-');
+    qemu_fprintf(f, "SKIP:    %02x\n", env->skip);
+
+    qemu_fprintf(f, "\n");
+    for (i =3D 0; i < ARRAY_SIZE(env->r); i++) {
+        qemu_fprintf(f, "R[%02d]:  %02x   ", i, env->r[i]);
+
+        if ((i % 8) =3D=3D 7) {
+            qemu_fprintf(f, "\n");
+        }
+    }
+    qemu_fprintf(f, "\n");
+}
+
+static void avr_cpu_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(oc);
+    CPUClass *cc =3D CPU_CLASS(oc);
+    AVRCPUClass *mcc =3D AVR_CPU_CLASS(oc);
+
+    mcc->parent_realize =3D dc->realize;
+    dc->realize =3D avr_cpu_realizefn;
+
+    mcc->parent_reset =3D cc->reset;
+    cc->reset =3D avr_cpu_reset;
+
+    cc->class_by_name =3D avr_cpu_class_by_name;
+
+    cc->has_work =3D avr_cpu_has_work;
+    cc->dump_state =3D avr_cpu_dump_state;
+    cc->set_pc =3D avr_cpu_set_pc;
+    cc->disas_set_info =3D avr_cpu_disas_set_info;
+    cc->tcg_initialize =3D avr_cpu_tcg_init;
+    cc->synchronize_from_tb =3D avr_cpu_synchronize_from_tb;
+}
diff --git a/MAINTAINERS b/MAINTAINERS
index 4e47309..79b709d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -168,7 +168,9 @@ M: Michael Rolnik <mrolnik@gmail.com>
 R: Sarah Harris <S.E.Harris@kent.ac.uk>
 S: Maintained
 F: target/avr/cpu-param.h
+F: target/avr/cpu-qom.h
 F: target/avr/cpu.h
+F: target/avr/cpu.c
=20
 CRIS TCG CPUs
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
--=20
2.7.4


