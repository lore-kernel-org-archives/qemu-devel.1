Received: from eggs.gnu.org ([2001:4830:134:3::10]:57862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dKQjV-0008As-1v
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 10:54:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dKQjT-0000Qc-4g
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 10:54:21 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:60889 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dKQjS-0000QI-K4
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 10:54:19 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Mon, 12 Jun 2017 17:54:09 +0300
Message-Id: <149727924970.28532.9346819516051209538.stgit@frigg.lan>
In-Reply-To: <149727922719.28532.11985025310576184920.stgit@frigg.lan>
References: <149727922719.28532.11985025310576184920.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 3/6] target: [tcg] Add generic translation
 framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 include/exec/gen-icount.h             |    2=20
 include/exec/translate-all_template.h |   73 ++++++++++++
 include/qom/cpu.h                     |   22 ++++
 translate-all_template.h              |  204 +++++++++++++++++++++++++++=
++++++
 4 files changed, 300 insertions(+), 1 deletion(-)
 create mode 100644 include/exec/translate-all_template.h
 create mode 100644 translate-all_template.h

diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
index 62d462e494..547c979629 100644
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
diff --git a/include/exec/translate-all_template.h b/include/exec/transla=
te-all_template.h
new file mode 100644
index 0000000000..51c8a43b80
--- /dev/null
+++ b/include/exec/translate-all_template.h
@@ -0,0 +1,73 @@
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
+#ifndef EXEC__TRANSLATE_ALL_TEMPLATE_H
+#define EXEC__TRANSLATE_ALL_TEMPLATE_H
+
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
+
+
+/**
+ * BreakpointHitType:
+ * @BH_MISS: No hit
+ * @BH_HIT_INSN: Hit, but continue translating instruction
+ * @BH_HIT_TB: Hit, stop translating TB
+ *
+ * How to react to a breakpoint hit.
+ */
+typedef enum BreakpointHitType {
+    BH_MISS,
+    BH_HIT_INSN,
+    BH_HIT_TB,
+} BreakpointHitType;
+
+/**
+ * DisasJumpType:
+ * @DJ_NEXT: Next instruction in program order
+ * @DJ_TOO_MANY: Too many instructions executed
+ * @DJ_TARGET: Start of target-specific conditions
+ *
+ * What instruction to disassemble next.
+ */
+typedef enum DisasJumpType {
+    DJ_NEXT,
+    DJ_TOO_MANY,
+    DJ_TARGET,
+} DisasJumpType;
+
+/**
+ * DisasContextBase:
+ * @tb: Translation block for this disassembly.
+ * @pc_first: Address of first guest instruction in this TB.
+ * @pc_next: Address of next guest instruction in this TB (current durin=
g
+ *           disassembly).
+ * @num_insns: Number of translated instructions (including current).
+ * @singlestep_enabled: "Hardware" single stepping enabled.
+ *
+ * Architecture-agnostic disassembly context.
+ */
+typedef struct DisasContextBase {
+    TranslationBlock *tb;
+    target_ulong pc_first;
+    target_ulong pc_next;
+    DisasJumpType jmp_type;
+    unsigned int num_insns;
+    bool singlestep_enabled;
+} DisasContextBase;
+
+#endif  /* EXEC__TRANSLATE_ALL_TEMPLATE_H */
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 89ddb686fb..d46e8df756 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -982,6 +982,28 @@ static inline bool cpu_breakpoint_test(CPUState *cpu=
, vaddr pc, int mask)
     return false;
 }
=20
+/* Get first breakpoint matching a PC */
+static inline CPUBreakpoint *cpu_breakpoint_get(CPUState *cpu, vaddr pc,
+                                                CPUBreakpoint *bp)
+{
+    if (likely(bp =3D=3D NULL)) {
+        if (unlikely(!QTAILQ_EMPTY(&cpu->breakpoints))) {
+            QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
+                if (bp->pc =3D=3D pc) {
+                    return bp;
+                }
+            }
+        }
+    } else {
+        QTAILQ_FOREACH_CONTINUE(bp, entry) {
+            if (bp->pc =3D=3D pc) {
+                return bp;
+            }
+        }
+    }
+    return NULL;
+}
+
 int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
                           int flags, CPUWatchpoint **watchpoint);
 int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
diff --git a/translate-all_template.h b/translate-all_template.h
new file mode 100644
index 0000000000..3e3f0816f7
--- /dev/null
+++ b/translate-all_template.h
@@ -0,0 +1,204 @@
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
+#ifndef TRANSLATE_ALL_TEMPLATE_H
+#define TRANSLATE_ALL_TEMPLATE_H
+
+/*
+ * Include this header from a target-specific file, which must define th=
e
+ * target-specific functions declared below.
+ *
+ * These must be paired with instructions in "exec/translate-all_templat=
e.h".
+ */
+
+
+#include "cpu.h"
+#include "qemu/error-report.h"
+
+
+static void gen_intermediate_code_target_init_disas_context(
+    DisasContext *dc, CPUArchState *env);
+
+static void gen_intermediate_code_target_init_globals(
+    DisasContext *dc, CPUArchState *env);
+
+static void gen_intermediate_code_target_tb_start(
+    DisasContext *dc, CPUArchState *env);
+
+static void gen_intermediate_code_target_insn_start(
+    DisasContext *dc, CPUArchState *env);
+
+static BreakpointHitType gen_intermediate_code_target_breakpoint_hit(
+    DisasContext *dc, CPUArchState *env,
+    const CPUBreakpoint *bp);
+
+static target_ulong gen_intermediate_code_target_disas_insn(
+    DisasContext *dc, CPUArchState *env);
+
+static DisasJumpType gen_intermediate_code_target_stop_check(
+    DisasContext *dc, CPUArchState *env);
+
+static void gen_intermediate_code_target_stop(
+    DisasContext *dc, CPUArchState *env);
+
+static int gen_intermediate_code_target_get_disas_flags(
+    const DisasContext *dc);
+
+
+static inline void gen_intermediate_code_tcg_check(const DisasContext *d=
c)
+{
+    if (tcg_check_temp_count()) {
+        error_report("warning: TCG temporary leaks before "TARGET_FMT_lx=
,
+                     dc->base.pc_next);
+    }
+}
+
+void gen_intermediate_code(CPUState *cpu, struct TranslationBlock *tb)
+{
+    CPUArchState *env =3D cpu->env_ptr;
+    DisasContext dc1, *dc =3D &dc1;
+    int max_insns;
+
+    /* Initialize DisasContext */
+    dc->base.tb =3D tb;
+    dc->base.singlestep_enabled =3D cpu->singlestep_enabled;
+    dc->base.pc_first =3D tb->pc;
+    dc->base.pc_next =3D dc->base.pc_first;
+    dc->base.jmp_type =3D DJ_NEXT;
+    dc->base.num_insns =3D 0;
+    gen_intermediate_code_target_init_disas_context(dc, env);
+
+    /* Initialize globals */
+    gen_intermediate_code_target_init_globals(dc, env);
+    tcg_clear_temp_count();
+
+    /* Instruction counting */
+    max_insns =3D dc->base.tb->cflags & CF_COUNT_MASK;
+    if (max_insns =3D=3D 0) {
+        max_insns =3D CF_COUNT_MASK;
+    }
+    if (max_insns > TCG_MAX_INSNS) {
+        max_insns =3D TCG_MAX_INSNS;
+    }
+    if (dc->base.singlestep_enabled || singlestep) {
+        max_insns =3D 1;
+    }
+
+    /* Start translating */
+    gen_tb_start(dc->base.tb);
+    gen_intermediate_code_target_tb_start(dc, env);
+
+    while (true) {
+        CPUBreakpoint *bp;
+
+        dc->base.num_insns++;
+        gen_intermediate_code_target_insn_start(dc, env);
+
+        /* Early exit before breakpoint checks */
+        if (unlikely(dc->base.jmp_type !=3D DJ_NEXT)) {
+            break;
+        }
+
+        /* Pass breakpoint hits to target for further processing */
+        bp =3D NULL;
+        do {
+            bp =3D cpu_breakpoint_get(cpu, dc->base.pc_next, bp);
+            if (unlikely(bp)) {
+                BreakpointHitType bh =3D
+                    gen_intermediate_code_target_breakpoint_hit(dc, env,=
 bp);
+                if (bh =3D=3D BH_HIT_INSN) {
+                    /* Hit, keep translating */
+                    /*
+                     * TODO: if we're never going to have more than one =
BP in a
+                     *       single address, we can simply use a bool he=
re.
+                     */
+                    break;
+                } else if (bh =3D=3D BH_HIT_TB) {
+                    goto done_generating;
+                }
+            }
+        } while (bp !=3D NULL);
+
+        /* Accept I/O on last instruction */
+        if (dc->base.num_insns =3D=3D max_insns &&
+            (dc->base.tb->cflags & CF_LAST_IO)) {
+            gen_io_start();
+        }
+
+        /* Disassemble one instruction */
+        dc->base.pc_next =3D gen_intermediate_code_target_disas_insn(dc,=
 env);
+
+        /**************************************************/
+        /* Conditions to stop translation                 */
+        /**************************************************/
+
+        /* Disassembly already set a stop condition */
+        if (dc->base.jmp_type >=3D DJ_TARGET) {
+            break;
+        }
+
+        /* Target-specific conditions */
+        dc->base.jmp_type =3D gen_intermediate_code_target_stop_check(dc=
, env);
+        if (dc->base.jmp_type >=3D DJ_TARGET) {
+            break;
+        }
+
+        /* Too many instructions */
+        if (tcg_op_buf_full() || dc->base.num_insns >=3D max_insns) {
+            dc->base.jmp_type =3D DJ_TOO_MANY;
+            break;
+        }
+
+        /*
+         * Check if next instruction is on next page, which can cause an
+         * exception.
+         *
+         * NOTE: Target-specific code must check a single instruction do=
es not
+         *       cross page boundaries; the first in the TB is always al=
lowed to
+         *       cross pages (never goes through this check).
+         */
+        if ((dc->base.pc_first & TARGET_PAGE_MASK)
+            !=3D (dc->base.pc_next & TARGET_PAGE_MASK)) {
+            dc->base.jmp_type =3D DJ_TOO_MANY;
+            break;
+        }
+
+        gen_intermediate_code_tcg_check(dc);
+    }
+
+    gen_intermediate_code_target_stop(dc, env);
+
+    if (dc->base.tb->cflags & CF_LAST_IO) {
+        gen_io_end();
+    }
+
+done_generating:
+    gen_tb_end(dc->base.tb, dc->base.num_insns);
+
+    gen_intermediate_code_tcg_check(dc);
+
+#ifdef DEBUG_DISAS
+    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM) &&
+        qemu_log_in_addr_range(dc->base.pc_first)) {
+        qemu_log_lock();
+        qemu_log("----------------\n");
+        qemu_log("IN: %s\n", lookup_symbol(dc->base.pc_first));
+        log_target_disas(cpu, dc->base.pc_first,
+                         dc->base.pc_next - dc->base.pc_first,
+                         gen_intermediate_code_target_get_disas_flags(dc=
));
+        qemu_log("\n");
+        qemu_log_unlock();
+    }
+#endif
+
+    dc->base.tb->size =3D dc->base.pc_next - dc->base.pc_first;
+    dc->base.tb->icount =3D dc->base.num_insns;
+}
+
+#endif  /* TRANSLATE_ALL_TEMPLATE_H */
