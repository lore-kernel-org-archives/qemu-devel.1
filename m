Received: from eggs.gnu.org ([2001:4830:134:3::10]:57556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP3Oq-0005XW-R1
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 05:00:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP3Ol-0003cd-9w
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 05:00:08 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:53387 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP3Ok-0003c6-MJ
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 05:00:03 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Sun, 25 Jun 2017 11:59:54 +0300
Message-Id: <149838119390.6497.17430428991952287717.stgit@frigg.lan>
In-Reply-To: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
References: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v9 04/26] target: [tcg] Add generic translation
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
 Makefile.target                |    1=20
 include/exec/gen-icount.h      |    2=20
 include/exec/translate-block.h |  125 +++++++++++++++++++++++++++
 include/qom/cpu.h              |   22 +++++
 translate-block.c              |  185 ++++++++++++++++++++++++++++++++++=
++++++
 5 files changed, 334 insertions(+), 1 deletion(-)
 create mode 100644 include/exec/translate-block.h
 create mode 100644 translate-block.c

diff --git a/Makefile.target b/Makefile.target
index ce8dfe44a8..253c6e7999 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -90,6 +90,7 @@ all: $(PROGS) stap
 # cpu emulator library
 obj-y =3D exec.o translate-all.o cpu-exec.o
 obj-y +=3D translate-common.o
+obj-y +=3D translate-block.o
 obj-y +=3D cpu-exec-common.o
 obj-y +=3D tcg/tcg.o tcg/tcg-op.o tcg/optimize.o
 obj-$(CONFIG_TCG_INTERPRETER) +=3D tci.o
diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
index 9b26c7da5f..f4ad61014b 100644
--- a/include/exec/gen-icount.h
+++ b/include/exec/gen-icount.h
@@ -44,7 +44,7 @@ static inline void gen_tb_start(TranslationBlock *tb, T=
CGv_env cpu_env)
     tcg_temp_free_i32(count);
 }
=20
-static void gen_tb_end(TranslationBlock *tb, int num_insns)
+static inline void gen_tb_end(TranslationBlock *tb, int num_insns)
 {
     if (tb->cflags & CF_USE_ICOUNT) {
         /* Update the num_insn immediate parameter now that we know
diff --git a/include/exec/translate-block.h b/include/exec/translate-bloc=
k.h
new file mode 100644
index 0000000000..d14d23f2cb
--- /dev/null
+++ b/include/exec/translate-block.h
@@ -0,0 +1,125 @@
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
+#ifndef EXEC__TRANSLATE_BLOCK_H
+#define EXEC__TRANSLATE_BLOCK_H
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
+ * targets (e.g., due to conditions encoded in their flags), so tey can =
decide
+ * that a breakpoint missed the address (@BP_MISS).
+ */
+typedef enum BreakpointCheckType {
+    BC_MISS,
+    BC_HIT_INSN,
+    BC_HIT_TB,
+} BreakpointCheckType;
+
+/**
+ * DisasJumpType:
+ * @DJ_NEXT: Next instruction in program order.
+ * @DJ_TOO_MANY: Too many instructions translated.
+ * @DJ_TARGET: Start of target-specific conditions.
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
+ * @init_globals: Initialize global variables.
+ * @tb_start: Start translating a new TB.
+ * @insn_start: Start translating a new instruction.
+ * @breakpoint_check: Check if a breakpoint did hit. When called, the br=
eakpoint
+ *                    has already been checked to match the PC.
+ * @disas_insn: Disassemble one instruction an return the PC for the nex=
t
+ *              one. Can set db->is_jmp to DJ_TARGET or above to stop
+ *              translation.
+ * @tb_stop: Stop translating a TB.
+ * @disas_flags: Get flags argument for log_target_disas().
+ *
+ * Target-specific operations for the generic translator loop.
+ *
+ * All operations but disas_insn() are optional, and ignored when not se=
t.
+ * A missing breakpoint_check() will ignore breakpoints. A missing disas=
_flags()
+ * will pass no flags.
+ */
+typedef struct TranslatorOps {
+    void (*init_disas_context)(DisasContextBase *db, CPUState *cpu);
+    void (*init_globals)(DisasContextBase *db, CPUState *cpu);
+    void (*tb_start)(DisasContextBase *db, CPUState *cpu);
+    void (*insn_start)(DisasContextBase *db, CPUState *cpu);
+    BreakpointCheckType (*breakpoint_check)(DisasContextBase *db, CPUSta=
te *cpu,
+                                            const CPUBreakpoint *bp);
+    target_ulong (*disas_insn)(DisasContextBase *db, CPUState *cpu);
+    void (*tb_stop)(DisasContextBase *db, CPUState *cpu);
+    int (*disas_flags)(const DisasContextBase *db);
+} TranslatorOps;
+
+/**
+ * translate_block:
+ * @ops: Target-specific operations.
+ * @db:
+ * @cpu:
+ * @tb:
+ *
+ * Generic translator loop.
+ */
+void translate_block(const TranslatorOps *ops, DisasContextBase *db,
+                     CPUState *cpu, TCGv_env *tcg_cpu, TranslationBlock =
*tb);
+
+#endif  /* EXEC__TRANSLATE_BLOCK_H */
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
diff --git a/translate-block.c b/translate-block.c
new file mode 100644
index 0000000000..1aac80560e
--- /dev/null
+++ b/translate-block.c
@@ -0,0 +1,185 @@
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
+#include "exec/translate-block.h"
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
+void translate_block(const TranslatorOps *ops, DisasContextBase *db,
+                     CPUState *cpu, TCGv_env *tcg_cpu, TranslationBlock =
*tb)
+{
+    int max_insns;
+
+    /* Sanity-check ops */
+    if (ops->disas_insn =3D=3D NULL) {
+        error_report("Missing ops->disas_insn");
+        abort();
+    }
+
+    /* Initialize DisasContext */
+    db->tb =3D tb;
+    db->pc_first =3D tb->pc;
+    db->pc_next =3D db->pc_first;
+    db->is_jmp =3D DJ_NEXT;
+    db->num_insns =3D 0;
+    db->singlestep_enabled =3D cpu->singlestep_enabled;
+    if (ops->init_disas_context) {
+        ops->init_disas_context(db, cpu);
+    }
+
+    /* Initialize globals */
+    if (ops->init_globals) {
+        ops->init_globals(db, cpu);
+    }
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
+    gen_tb_start(db->tb, *tcg_cpu);
+    if (ops->tb_start) {
+        ops->tb_start(db, cpu);
+    }
+
+    while (true) {
+        CPUBreakpoint *bp;
+
+        db->num_insns++;
+        if (ops->insn_start) {
+            ops->insn_start(db, cpu);
+        }
+
+        /* Early exit before breakpoint checks */
+        if (unlikely(db->is_jmp !=3D DJ_NEXT)) {
+            break;
+        }
+
+        /* Pass breakpoint hits to target for further processing */
+        bp =3D NULL;
+        do {
+            bp =3D cpu_breakpoint_get(cpu, db->pc_next, bp);
+            if (unlikely(bp) && ops->breakpoint_check) {
+                BreakpointCheckType bp_check =3D ops->breakpoint_check(
+                    db, cpu, bp);
+                if (bp_check =3D=3D BC_HIT_INSN) {
+                    /* Hit, keep translating */
+                    /*
+                     * TODO: if we're never going to have more than one =
BP in a
+                     *       single address, we can simply use a bool he=
re.
+                     */
+                    break;
+                } else if (bp_check =3D=3D BC_HIT_TB) {
+                    goto done_generating;
+                } else {
+                    error_report("Unexpected BreakpointCheckType %d", bp=
_check);
+                    abort();
+                }
+            }
+        } while (bp !=3D NULL);
+
+        /* Accept I/O on last instruction */
+        if (db->num_insns =3D=3D max_insns && (db->tb->cflags & CF_LAST_=
IO)) {
+            gen_io_start(*tcg_cpu);
+        }
+
+        /* Disassemble one instruction */
+        db->pc_next =3D ops->disas_insn(db, cpu);
+
+        /**************************************************/
+        /* Conditions to stop translation                 */
+        /**************************************************/
+
+        /* Target-specific conditions set by disassembly */
+        if (db->is_jmp !=3D DJ_NEXT) {
+            break;
+        }
+
+        /* Too many instructions */
+        if (tcg_op_buf_full() || db->num_insns >=3D max_insns) {
+            db->is_jmp =3D DJ_TOO_MANY;
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
+        if ((db->pc_first & TARGET_PAGE_MASK)
+            !=3D (db->pc_next & TARGET_PAGE_MASK)) {
+            db->is_jmp =3D DJ_TOO_MANY;
+            break;
+        }
+
+        translate_block_tcg_check(db);
+    }
+
+    if (ops->tb_stop) {
+        ops->tb_stop(db, cpu);
+    }
+
+    if (db->tb->cflags & CF_LAST_IO) {
+        gen_io_end(*tcg_cpu);
+    }
+
+done_generating:
+    gen_tb_end(db->tb, db->num_insns);
+
+    translate_block_tcg_check(db);
+
+#ifdef DEBUG_DISAS
+    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM) &&
+        qemu_log_in_addr_range(db->pc_first)) {
+        int flags;
+        if (ops->disas_flags) {
+            flags =3D ops->disas_flags(db);
+        } else {
+            flags =3D 0;
+        }
+        qemu_log_lock();
+        qemu_log("----------------\n");
+        qemu_log("IN: %s\n", lookup_symbol(db->pc_first));
+        log_target_disas(cpu, db->pc_first, db->pc_next - db->pc_first, =
flags);
+        qemu_log("\n");
+        qemu_log_unlock();
+    }
+#endif
+
+    db->tb->size =3D db->pc_next - db->pc_first;
+    db->tb->icount =3D db->num_insns;
+}
