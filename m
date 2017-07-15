Received: from eggs.gnu.org ([2001:4830:134:3::10]:38107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWJbR-0003h9-Vl
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWJbQ-0003GD-DL
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:10 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:35606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dWJbQ-0003FO-4d
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:08 -0400
Received: by mail-pf0-x243.google.com with SMTP id q85so13697829pfq.2
	for <qemu-devel@nongnu.org>; Sat, 15 Jul 2017 02:43:07 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 14 Jul 2017 23:42:17 -1000
Message-Id: <20170715094243.28371-9-rth@twiddle.net>
In-Reply-To: <20170715094243.28371-1-rth@twiddle.net>
References: <20170715094243.28371-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v14 08/34] tcg: Add generic translation
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
Cc: vilanova@ac.upc.edu, cota@braap.org, alex.bennee@linaro.org, crosthwaite.peter@gmail.com, pbonzini@redhat.com

From: Lluís Vilanova <vilanova@ac.upc.edu>

Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
Message-Id: <150002073981.22386.9870422422367410100.stgit@frigg.lan>
[rth: Moved max_insns adjustment from tb_start to init_disas_context.
Removed pc_next return from translate_insn.
Removed tcg_check_temp_count from generic loop.
Moved gen_io_end to exactly match gen_io_start.
Use qemu_log instead of error_report for temporary leaks.
Moved TB size/icount assignments before disas_log.]
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 include/exec/translator.h | 101 +++++++++++++++++++++++++++++++++++
 accel/tcg/translator.c    | 133 ++++++++++++++++++++++++++++++++++++++++++++++
 accel/tcg/Makefile.objs   |   1 +
 3 files changed, 235 insertions(+)
 create mode 100644 accel/tcg/translator.c

diff --git a/include/exec/translator.h b/include/exec/translator.h
index b51b8f8..aa84376 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -10,6 +10,19 @@
 #ifndef EXEC__TRANSLATOR_H
 #define EXEC__TRANSLATOR_H
 
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
 /**
  * DisasJumpType:
  * @DISAS_NEXT: Next instruction in program order.
@@ -37,4 +50,92 @@ typedef enum DisasJumpType {
     DISAS_TARGET_11,
 } DisasJumpType;
 
+/**
+ * DisasContextBase:
+ * @tb: Translation block for this disassembly.
+ * @pc_first: Address of first guest instruction in this TB.
+ * @pc_next: Address of next guest instruction in this TB (current during
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
+ * @init_disas_context:
+ *      Initialize the target-specific portions of DisasContext struct.
+ *      The generic DisasContextBase has already been initialized.
+ *      Return max_insns, modified as necessary by db->tb->flags.
+ *
+ * @tb_start:
+ *      Emit any code required before the start of the main loop,
+ *      after the generic gen_tb_start().
+ *
+ * @insn_start:
+ *      Emit the tcg_gen_insn_start opcode.
+ *
+ * @breakpoint_check:
+ *      When called, the breakpoint has already been checked to match the PC,
+ *      but the target may decide the breakpoint missed the address
+ *      (e.g., due to conditions encoded in their flags).  Return true to
+ *      indicate that the breakpoint did hit, in which case no more breakpoints
+ *      are checked.  If the breakpoint did hit, emit any code required to
+ *      signal the exception, and set db->is_jmp as necessary to terminate
+ *      the main loop.
+ *
+ * @translate_insn:
+ *      Disassemble one instruction and set db->pc_next for the start
+ *      of the following instruction.  Set db->is_jmp as necessary to
+ *      terminate the main loop.
+ *
+ * @tb_stop:
+ *      Emit any opcodes required to exit the TB, based on db->is_jmp.
+ *
+ * @disas_log:
+ *      Print instruction disassembly to log.
+ */
+typedef struct TranslatorOps {
+    int (*init_disas_context)(DisasContextBase *db, CPUState *cpu,
+                              int max_insns);
+    void (*tb_start)(DisasContextBase *db, CPUState *cpu);
+    void (*insn_start)(DisasContextBase *db, CPUState *cpu);
+    bool (*breakpoint_check)(DisasContextBase *db, CPUState *cpu,
+                             const CPUBreakpoint *bp);
+    void (*translate_insn)(DisasContextBase *db, CPUState *cpu);
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
+ * - When single-stepping is enabled (system-wide or on the current vCPU).
+ * - When too many instructions have been translated.
+ */
+void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
+                     CPUState *cpu, TranslationBlock *tb);
+
+void translator_loop_temp_check(DisasContextBase *db);
+
 #endif  /* EXEC__TRANSLATOR_H */
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
new file mode 100644
index 0000000..cb7ba96
--- /dev/null
+++ b/accel/tcg/translator.c
@@ -0,0 +1,133 @@
+/*
+ * Generic intermediate code generation.
+ *
+ * Copyright (C) 2016-2017 Lluís Vilanova <vilanova@ac.upc.edu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
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
+void translator_loop_temp_check(DisasContextBase *db)
+{
+    if (tcg_check_temp_count()) {
+        qemu_log("warning: TCG temporary leaks before "
+                 TARGET_FMT_lx "\n", db->pc_next);
+    }
+}
+
+void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
+                     CPUState *cpu, TranslationBlock *tb)
+{
+    int max_insns;
+
+    /* Initialize DisasContext */
+    db->tb = tb;
+    db->pc_first = tb->pc;
+    db->pc_next = db->pc_first;
+    db->is_jmp = DISAS_NEXT;
+    db->num_insns = 0;
+    db->singlestep_enabled = cpu->singlestep_enabled;
+
+    /* Instruction counting */
+    max_insns = db->tb->cflags & CF_COUNT_MASK;
+    if (max_insns == 0) {
+        max_insns = CF_COUNT_MASK;
+    }
+    if (max_insns > TCG_MAX_INSNS) {
+        max_insns = TCG_MAX_INSNS;
+    }
+    if (db->singlestep_enabled || singlestep) {
+        max_insns = 1;
+    }
+
+    max_insns = ops->init_disas_context(db, cpu, max_insns);
+    tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
+
+    /* Reset the temp count so that we can identify leaks */
+    tcg_clear_temp_count();
+
+    /* Start translating.  */
+    gen_tb_start(db->tb);
+    ops->tb_start(db, cpu);
+    tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
+
+    while (true) {
+        db->num_insns++;
+        ops->insn_start(db, cpu);
+        tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
+
+        /* Pass breakpoint hits to target for further processing */
+        if (unlikely(!QTAILQ_EMPTY(&cpu->breakpoints))) {
+            CPUBreakpoint *bp;
+            QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
+                if (bp->pc == db->pc_next) {
+                    if (ops->breakpoint_check(db, cpu, bp)) {
+                        break;
+                    }
+                }
+            }
+            /* The breakpoint_check hook may use DISAS_TOO_MANY to indicate
+               that only one more instruction is to be executed.  Otherwise
+               it should use DISAS_NORETURN when generating an exception,
+               but may use a DISAS_TARGET_* value for Something Else.  */
+            if (db->is_jmp > DISAS_TOO_MANY) {
+                break;
+            }
+        }
+
+        /* Disassemble one instruction.  The translate_insn hook should
+           update db->pc_next and db->is_jmp to indicate what should be
+           done next -- either exiting this loop or locate the start of
+           the next instruction.  */
+        if (db->num_insns == max_insns && (db->tb->cflags & CF_LAST_IO)) {
+            /* Accept I/O on the last instruction.  */
+            gen_io_start();
+            ops->translate_insn(db, cpu);
+            gen_io_end();
+        } else {
+            ops->translate_insn(db, cpu);
+        }
+
+        /* Stop translation if translate_insn so indicated.  */
+        if (db->is_jmp != DISAS_NEXT) {
+            break;
+        }
+
+        /* Stop translation if the output buffer is full,
+           or we have executed all of the allowed instructions.  */
+        if (tcg_op_buf_full() || db->num_insns >= max_insns) {
+            db->is_jmp = DISAS_TOO_MANY;
+            break;
+        }
+    }
+
+    /* Emit code to exit the TB, as indicated by db->is_jmp.  */
+    ops->tb_stop(db, cpu);
+    gen_tb_end(db->tb, db->num_insns);
+
+    /* The disas_log hook may use these values rather than recompute.  */
+    db->tb->size = db->pc_next - db->pc_first;
+    db->tb->icount = db->num_insns;
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
+}
diff --git a/accel/tcg/Makefile.objs b/accel/tcg/Makefile.objs
index 70cd474..22642e6 100644
--- a/accel/tcg/Makefile.objs
+++ b/accel/tcg/Makefile.objs
@@ -1,3 +1,4 @@
 obj-$(CONFIG_SOFTMMU) += tcg-all.o
 obj-$(CONFIG_SOFTMMU) += cputlb.o
 obj-y += cpu-exec.o cpu-exec-common.o translate-all.o
+obj-y += translator.o
-- 
2.9.4
