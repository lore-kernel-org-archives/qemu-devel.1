Received: from eggs.gnu.org ([2001:4830:134:3::10]:56786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTRsV-0002E3-Q6
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 07:56:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTRsS-0002eg-LU
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 07:56:55 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:59474 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTRsS-0002eQ-4I
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 07:56:52 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Fri,  7 Jul 2017 13:56:36 +0200
Message-Id: <149942859571.8972.4761014660099212028.stgit@frigg.lan>
In-Reply-To: <149942760788.8972.474351671751194003.stgit@frigg.lan>
References: <149942760788.8972.474351671751194003.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v12 04/27] target: [tcg] Add generic
 translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 accel/tcg/Makefile.objs   |    1=20
 accel/tcg/translator.c    |  152 +++++++++++++++++++++++++++++++++++++++=
++++++
 include/exec/gen-icount.h |    2 -
 include/exec/translator.h |   99 +++++++++++++++++++++++++++++
 4 files changed, 253 insertions(+), 1 deletion(-)
 create mode 100644 accel/tcg/translator.c

diff --git a/accel/tcg/Makefile.objs b/accel/tcg/Makefile.objs
index f173cd5397..3a5da5357c 100644
--- a/accel/tcg/Makefile.objs
+++ b/accel/tcg/Makefile.objs
@@ -1,3 +1,4 @@
 obj-$(CONFIG_SOFTMMU) +=3D tcg-all.o
 obj-$(CONFIG_SOFTMMU) +=3D cputlb.o
 obj-y +=3D cpu-exec.o cpu-exec-common.o translate-all.o translate-common=
.o
+obj-y +=3D translator.o
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
new file mode 100644
index 0000000000..9e0343cbb1
--- /dev/null
+++ b/accel/tcg/translator.c
@@ -0,0 +1,152 @@
+/*
+ * Generic intermediate code generation.
+ *
+ * Copyright (C) 2016-2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qemu/error-report.h"
+#include "cpu.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-op.h"
+#include "exec/exec-all.h"
+#include "exec/gen-icount.h"
+#include "exec/log.h"
+#include "exec/translator.h"
+
+
+static inline void translate_block_tcg_check(const DisasContextBase *db)
+{
+    if (tcg_check_temp_count()) {
+        error_report("warning: TCG temporary leaks before "TARGET_FMT_lx=
,
+                     db->pc_next);
+    }
+}
+
+void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
+                     CPUState *cpu, TranslationBlock *tb)
+{
+    int max_insns;
+
+    /* Initialize DisasContext */
+    db->tb =3D tb;
+    db->pc_first =3D tb->pc;
+    db->pc_next =3D db->pc_first;
+    db->is_jmp =3D DISAS_NEXT;
+    db->num_insns =3D 0;
+    db->singlestep_enabled =3D cpu->singlestep_enabled;
+    ops->init_disas_context(db, cpu);
+
+    /* Initialize globals */
+    tcg_clear_temp_count();
+
+    /* Instruction counting */
+    max_insns =3D db->tb->cflags & CF_COUNT_MASK;
+    if (max_insns =3D=3D 0) {
+        max_insns =3D CF_COUNT_MASK;
+    }
+    if (max_insns > TCG_MAX_INSNS) {
+        max_insns =3D TCG_MAX_INSNS;
+    }
+    if (db->singlestep_enabled || singlestep) {
+        max_insns =3D 1;
+    }
+
+    /* Start translating */
+    gen_tb_start(db->tb);
+    ops->tb_start(db, cpu);
+
+    while (true) {
+        db->num_insns++;
+        ops->insn_start(db, cpu);
+
+        /* Early exit before breakpoint checks */
+        if (unlikely(db->is_jmp !=3D DISAS_NEXT)) {
+            break;
+        }
+
+        /* Pass breakpoint hits to target for further processing */
+        if (unlikely(!QTAILQ_EMPTY(&cpu->breakpoints))) {
+            CPUBreakpoint *bp;
+            QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
+                if (bp->pc =3D=3D db->pc_next) {
+                    BreakpointCheckType bp_check =3D
+                        ops->breakpoint_check(db, cpu, bp);
+                    switch (bp_check) {
+                    case BC_MISS:
+                        /* Target ignored this breakpoint, go to next */
+                        break;
+                    case BC_HIT_INSN:
+                        /* Hit, keep translating */
+                        /*
+                         * TODO: if we're never going to have more than =
one
+                         *       BP in a single address, we can simply u=
se a
+                         *       bool here.
+                         */
+                        goto done_breakpoints;
+                    case BC_HIT_TB:
+                        /* Hit, end TB */
+                        goto done_generating;
+                    default:
+                        g_assert_not_reached();
+                    }
+                }
+            }
+        }
+    done_breakpoints:
+
+        /* Accept I/O on last instruction */
+        if (db->num_insns =3D=3D max_insns && (db->tb->cflags & CF_LAST_=
IO)) {
+            gen_io_start();
+        }
+
+        /* Disassemble one instruction */
+        db->pc_next =3D ops->translate_insn(db, cpu);
+
+        /**************************************************/
+        /* Conditions to stop translation                 */
+        /**************************************************/
+
+        /* Target-specific conditions set by disassembly */
+        if (db->is_jmp !=3D DISAS_NEXT) {
+            break;
+        }
+
+        /* Too many instructions */
+        if (tcg_op_buf_full() || db->num_insns >=3D max_insns) {
+            db->is_jmp =3D DISAS_TOO_MANY;
+            break;
+        }
+
+        translate_block_tcg_check(db);
+    }
+
+    ops->tb_stop(db, cpu);
+
+    if (db->tb->cflags & CF_LAST_IO) {
+        gen_io_end();
+    }
+
+done_generating:
+    gen_tb_end(db->tb, db->num_insns);
+
+    translate_block_tcg_check(db);
+
+#ifdef DEBUG_DISAS
+    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
+        && qemu_log_in_addr_range(db->pc_first)) {
+        qemu_log_lock();
+        qemu_log("----------------\n");
+        ops->disas_log(db, cpu);
+        qemu_log("\n");
+        qemu_log_unlock();
+    }
+#endif
+
+    db->tb->size =3D db->pc_next - db->pc_first;
+    db->tb->icount =3D db->num_insns;
+}
diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
index 6c28ef59c3..9b3cb14dfa 100644
--- a/include/exec/gen-icount.h
+++ b/include/exec/gen-icount.h
@@ -44,7 +44,7 @@ static inline void gen_tb_start(TranslationBlock *tb)
     tcg_temp_free_i32(count);
 }
=20
-static void gen_tb_end(TranslationBlock *tb, int num_insns)
+static inline void gen_tb_end(TranslationBlock *tb, int num_insns)
 {
     if (tb->cflags & CF_USE_ICOUNT) {
         /* Update the num_insn immediate parameter now that we know
diff --git a/include/exec/translator.h b/include/exec/translator.h
index 1f9697dd31..f96b66f2bf 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -10,6 +10,38 @@
 #ifndef EXEC__TRANSLATOR_H
 #define EXEC__TRANSLATOR_H
=20
+/*
+ * Include this header from a target-specific file, and add a
+ *
+ *     DisasContextBase base;
+ *
+ * member in your target-specific DisasContext.
+ */
+
+
+#include "exec/exec-all.h"
+#include "tcg/tcg.h"
+
+
+/**
+ * BreakpointCheckType:
+ * @BC_MISS: No hit
+ * @BC_HIT_INSN: Hit, but continue translating TB
+ * @BC_HIT_TB: Hit, stop translating TB
+ *
+ * How to react to a breakpoint. A hit means no more breakpoints will be=
 checked
+ * for the current instruction.
+ *
+ * Not all breakpoints associated to an address are necessarily raised b=
y
+ * targets (e.g., due to conditions encoded in their flags), so they can=
 decide
+ * that a breakpoint missed the address (@BP_MISS).
+ */
+typedef enum BreakpointCheckType {
+    BC_MISS,
+    BC_HIT_INSN,
+    BC_HIT_TB,
+} BreakpointCheckType;
+
 /**
  * DisasJumpType:
  * @DISAS_NEXT: Next instruction in program order.
@@ -36,4 +68,71 @@ typedef enum DisasJumpType {
     DISAS_TARGET_12,
 } DisasJumpType;
=20
+/**
+ * DisasContextBase:
+ * @tb: Translation block for this disassembly.
+ * @pc_first: Address of first guest instruction in this TB.
+ * @pc_next: Address of next guest instruction in this TB (current durin=
g
+ *           disassembly).
+ * @is_jmp: What instruction to disassemble next.
+ * @num_insns: Number of translated instructions (including current).
+ * @singlestep_enabled: "Hardware" single stepping enabled.
+ *
+ * Architecture-agnostic disassembly context.
+ */
+typedef struct DisasContextBase {
+    TranslationBlock *tb;
+    target_ulong pc_first;
+    target_ulong pc_next;
+    DisasJumpType is_jmp;
+    unsigned int num_insns;
+    bool singlestep_enabled;
+} DisasContextBase;
+
+/**
+ * TranslatorOps:
+ * @init_disas_context: Initialize a DisasContext struct (DisasContextBa=
se has
+ *                      already been initialized).
+ * @tb_start: Start translating a new TB.
+ * @insn_start: Start translating a new instruction.
+ * @breakpoint_check: Check if a breakpoint did hit. When called, the br=
eakpoint
+ *                    has already been checked to match the PC.
+ * @translate_insn: Disassemble one instruction and return the PC for th=
e next
+ *                  one. Can set db->is_jmp to DISAS_TARGET or above to =
stop
+ *                  translation.
+ * @tb_stop: Stop translating a TB.
+ * @disas_log: Print instruction disassembly to log.
+ *
+ * Target-specific operations for the generic translator loop.
+ */
+typedef struct TranslatorOps {
+    void (*init_disas_context)(DisasContextBase *db, CPUState *cpu);
+    void (*tb_start)(DisasContextBase *db, CPUState *cpu);
+    void (*insn_start)(DisasContextBase *db, CPUState *cpu);
+    BreakpointCheckType (*breakpoint_check)(DisasContextBase *db, CPUSta=
te *cpu,
+                                            const CPUBreakpoint *bp);
+    target_ulong (*translate_insn)(DisasContextBase *db, CPUState *cpu);
+    void (*tb_stop)(DisasContextBase *db, CPUState *cpu);
+    void (*disas_log)(const DisasContextBase *db, CPUState *cpu);
+} TranslatorOps;
+
+/**
+ * translator_loop:
+ * @ops: Target-specific operations.
+ * @db: Disassembly context.
+ * @cpu: Target vCPU.
+ * @tb: Translation block.
+ *
+ * Generic translator loop.
+ *
+ * Translation will stop in the following cases (in order):
+ * - When set by #TranslatorOps::insn_start.
+ * - When set by #TranslatorOps::translate_insn.
+ * - When the TCG operation buffer is full.
+ * - When single-stepping is enabled (system-wide or on the current vCPU=
).
+ * - When too many instructions have been translated.
+ */
+void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
+                     CPUState *cpu, TranslationBlock *tb);
+
 #endif  /* EXEC__TRANSLATOR_H */
