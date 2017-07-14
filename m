Received: from eggs.gnu.org ([2001:4830:134:3::10]:43474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dVvv8-0005WL-LZ
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 04:25:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dVvv5-00040f-Dz
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 04:25:54 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:41870 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dVvv4-0003yc-To
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 04:25:51 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Fri, 14 Jul 2017 11:25:40 +0300
Message-Id: <150002073981.22386.9870422422367410100.stgit@frigg.lan>
In-Reply-To: <150002001195.22386.4679134058536830996.stgit@frigg.lan>
References: <150002001195.22386.4679134058536830996.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v13 03/26] target: [tcg] Add generic
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
 accel/tcg/translator.c    |  141 +++++++++++++++++++++++++++++++++++++++=
++++++
 include/exec/translator.h |   94 ++++++++++++++++++++++++++++++
 3 files changed, 236 insertions(+)
 create mode 100644 accel/tcg/translator.c

diff --git a/accel/tcg/Makefile.objs b/accel/tcg/Makefile.objs
index 70cd474c01..22642e6f75 100644
--- a/accel/tcg/Makefile.objs
+++ b/accel/tcg/Makefile.objs
@@ -1,3 +1,4 @@
 obj-$(CONFIG_SOFTMMU) +=3D tcg-all.o
 obj-$(CONFIG_SOFTMMU) +=3D cputlb.o
 obj-y +=3D cpu-exec.o cpu-exec-common.o translate-all.o
+obj-y +=3D translator.o
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
new file mode 100644
index 0000000000..630edfd353
--- /dev/null
+++ b/accel/tcg/translator.c
@@ -0,0 +1,141 @@
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
+    /* should never be set by this hook */
+    assert(db->is_jmp =3D=3D DISAS_NEXT);
+
+    /* Reset the temp count so that we can identify leaks */
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
+    ops->tb_start(db, cpu, &max_insns);
+    /* should never be set by this hook */
+    assert(db->is_jmp =3D=3D DISAS_NEXT);
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
+                    if (ops->breakpoint_check(db, cpu, bp)) {
+                        break;
+                    }
+                }
+            }
+
+            if (db->is_jmp =3D=3D DISAS_NORETURN) {
+                break;
+            }
+        }
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
+    if ((db->tb->cflags & CF_LAST_IO)) {
+        gen_io_end();
+    }
+
+    ops->tb_stop(db, cpu);
+
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
diff --git a/include/exec/translator.h b/include/exec/translator.h
index b51b8f8a4e..3806e01d8b 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -10,6 +10,19 @@
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
 /**
  * DisasJumpType:
  * @DISAS_NEXT: Next instruction in program order.
@@ -37,4 +50,85 @@ typedef enum DisasJumpType {
     DISAS_TARGET_11,
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
+ * @tb_start: Start translating a new TB. Can override the maximum numbe=
r of
+ *            instructions to translate, as calculated by the generic co=
de in
+ *            translator_loop().
+ * @insn_start: Start translating a new instruction.
+ * @breakpoint_check: Check if a breakpoint did hit, in which case no mo=
re
+ *                    breakpoints are checked. When called, the breakpoi=
nt has
+ *                    already been checked to match the PC, but targets =
can
+ *                    decide the breakpoint missed the address (e.g., du=
e to
+ *                    conditions encoded in their flags).
+ * @translate_insn: Disassemble one instruction and return the PC for th=
e next
+ *                  one. Can set db->is_jmp to DISAS_TARGET or above to =
stop
+ *                  translation.
+ * @tb_stop: Stop translating a TB.
+ * @disas_log: Print instruction disassembly to log.
+ *
+ * Target-specific operations for the generic translator loop.
+ *
+ * The following hooks can set DisasContextBase::is_jmp to stop the tran=
slation
+ * loop:
+ *
+ * - insn_start(), translate_insn()
+ *   -> is_jmp !=3D DISAS_NEXT
+ *
+ * - insn_start(), breakpoint_check(), translate_insn()
+ *   -> is_jmp =3D=3D DISAS_NORETURN
+ */
+typedef struct TranslatorOps {
+    void (*init_disas_context)(DisasContextBase *db, CPUState *cpu);
+    void (*tb_start)(DisasContextBase *db, CPUState *cpu, int *max_insns=
);
+    void (*insn_start)(DisasContextBase *db, CPUState *cpu);
+    bool (*breakpoint_check)(DisasContextBase *db, CPUState *cpu,
+                             const CPUBreakpoint *bp);
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
