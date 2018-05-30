Received: from eggs.gnu.org ([2001:4830:134:3::10]:44317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@gmail.com>) id 1fO0nD-0001cv-GI
	for qemu-devel@nongnu.org; Wed, 30 May 2018 09:05:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@gmail.com>) id 1fO0n8-00021a-7g
	for qemu-devel@nongnu.org; Wed, 30 May 2018 09:05:31 -0400
Received: from mail.ispras.ru ([83.149.199.45]:51848)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@gmail.com>) id 1fO0n7-0001uL-K0
	for qemu-devel@nongnu.org; Wed, 30 May 2018 09:05:26 -0400
Received: from [127.0.1.1] (unknown [85.142.117.226])
	by mail.ispras.ru (Postfix) with ESMTPSA id E3B75540184
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 16:05:24 +0300 (MSK)
From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
Date: Wed, 30 May 2018 16:05:24 +0300
Message-ID: <152768552472.13955.11576907392919187527.stgit@pasha-ThinkPad-T60>
In-Reply-To: <152768551387.13955.7085403440722380428.stgit@pasha-ThinkPad-T60>
References: <152768551387.13955.7085403440722380428.stgit@pasha-ThinkPad-T60>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH v1 2/2] tcg: add instrumenting module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This is a samples of the instrumenting interface and implementation
of some instruction tracing tasks.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 accel/tcg/Makefile.objs            |    1 
 accel/tcg/instrument/Makefile.objs |    1 
 accel/tcg/instrument/helper.h      |    1 
 accel/tcg/instrument/instrument.c  |   82 ++++++++++++++++++++++++++++++++++++
 accel/tcg/instrument/instrument.h  |   11 +++++
 accel/tcg/translate-all.c          |    2 +
 accel/tcg/translator.c             |    5 ++
 7 files changed, 103 insertions(+)
 create mode 100644 accel/tcg/instrument/Makefile.objs
 create mode 100644 accel/tcg/instrument/helper.h
 create mode 100644 accel/tcg/instrument/instrument.c
 create mode 100644 accel/tcg/instrument/instrument.h

diff --git a/accel/tcg/Makefile.objs b/accel/tcg/Makefile.objs
index d381a02..fed2b6c 100644
--- a/accel/tcg/Makefile.objs
+++ b/accel/tcg/Makefile.objs
@@ -3,6 +3,7 @@ obj-$(CONFIG_SOFTMMU) += cputlb.o
 obj-y += tcg-runtime.o tcg-runtime-gvec.o
 obj-y += cpu-exec.o cpu-exec-common.o translate-all.o
 obj-y += translator.o
+obj-y += instrument/
 
 obj-$(CONFIG_USER_ONLY) += user-exec.o
 obj-$(call lnot,$(CONFIG_SOFTMMU)) += user-exec-stub.o
diff --git a/accel/tcg/instrument/Makefile.objs b/accel/tcg/instrument/Makefile.objs
new file mode 100644
index 0000000..f40c75a
--- /dev/null
+++ b/accel/tcg/instrument/Makefile.objs
@@ -0,0 +1 @@
+obj-$(CONFIG_TCG) += instrument.o
diff --git a/accel/tcg/instrument/helper.h b/accel/tcg/instrument/helper.h
new file mode 100644
index 0000000..007b395
--- /dev/null
+++ b/accel/tcg/instrument/helper.h
@@ -0,0 +1 @@
+DEF_HELPER_2(before_insn, void, tl, ptr)
diff --git a/accel/tcg/instrument/instrument.c b/accel/tcg/instrument/instrument.c
new file mode 100644
index 0000000..076810d
--- /dev/null
+++ b/accel/tcg/instrument/instrument.c
@@ -0,0 +1,82 @@
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qemu/error-report.h"
+#include "cpu.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-op.h"
+#include "exec/exec-all.h"
+#include "exec/log.h"
+#include "exec/translator.h"
+#include "exec/helper-proto.h"
+#include "exec/helper-gen.h"
+#include "qemu/log.h"
+
+#include "instrument.h"
+
+//#define QI_ALL
+#define QI_SYSCALL
+
+bool qi_needs_before_insn(DisasContextBase *db, CPUState *cpu)
+{
+#ifdef QI_ALL
+    /* instrument all the instructions */
+    return true;
+#endif
+#ifdef QI_SYSCALL
+    /* instrument only system calls */
+#ifdef TARGET_I386
+    uint8_t code = 0;
+    // int 80h is processed by exception handlers
+    if (!cpu_memory_rw_debug(cpu, db->pc_next, &code, 1, false)
+        && code == 0x0f) {
+        if (cpu_memory_rw_debug(cpu, db->pc_next + 1, &code, 1, false)) {
+            return false;
+        }
+        if (code == 0x34) {
+            /* sysenter */
+            return true;
+        }
+        if (code == 0x35) {
+            /* sysexit */
+            return true;
+        }
+    }
+#endif    
+    return false;
+#endif
+}
+
+void qi_instrument_before_insn(DisasContextBase *db, CPUState *cpu)
+{
+    TCGv t_pc = tcg_const_tl(db->pc_next);
+    TCGv_ptr t_cpu= tcg_const_ptr(cpu);
+    gen_helper_before_insn(t_pc, t_cpu);
+    tcg_temp_free(t_pc);
+    tcg_temp_free_ptr(t_cpu);
+}
+
+void helper_before_insn(target_ulong pc, void *cpu)
+{
+#ifdef QI_ALL
+    /* log all the executed instructions */
+    qemu_log("executing %"PRIx64"\n", (uint64_t)pc);
+#endif
+#ifdef QI_SYSCALL
+    uint8_t code = 0;
+    cpu_memory_rw_debug(cpu, pc + 1, &code, 1, false);
+#ifdef TARGET_I386
+    CPUArchState *env = ((CPUState*)cpu)->env_ptr;
+    /* log system calls */
+    if (code == 0x34) {
+        qemu_log("syscall %x\n", (uint32_t)env->regs[R_EAX]);
+    } else if (code == 0x35) {
+        qemu_log("sysexit %x\n", (uint32_t)env->regs[R_EAX]);
+    }
+#endif
+#endif
+}
+
+void qi_init(void)
+{
+#include "exec/helper-register.h"
+}
diff --git a/accel/tcg/instrument/instrument.h b/accel/tcg/instrument/instrument.h
new file mode 100644
index 0000000..758ea49
--- /dev/null
+++ b/accel/tcg/instrument/instrument.h
@@ -0,0 +1,11 @@
+#ifndef INSTRUMENT_H
+#define INSTRUMENT_H
+
+typedef struct DisasContextBase DisasContextBase;
+
+void qi_init(void);
+
+bool qi_needs_before_insn(DisasContextBase *db, CPUState *cpu);
+void qi_instrument_before_insn(DisasContextBase *db, CPUState *cpu);
+
+#endif // INSTRUMENT_H
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 732c919..517db13 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -58,6 +58,7 @@
 #include "qemu/main-loop.h"
 #include "exec/log.h"
 #include "sysemu/cpus.h"
+#include "instrument/instrument.h"
 
 /* #define DEBUG_TB_INVALIDATE */
 /* #define DEBUG_TB_FLUSH */
@@ -210,6 +211,7 @@ static TranslationBlock *tb_find_pc(uintptr_t tc_ptr);
 void cpu_gen_init(void)
 {
     tcg_context_init(&tcg_init_ctx);
+    qi_init();
 }
 
 /* Encode VAL as a signed leb128 sequence at P.
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 0f9dca9..ec4c933 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -17,6 +17,7 @@
 #include "exec/gen-icount.h"
 #include "exec/log.h"
 #include "exec/translator.h"
+#include "instrument/instrument.h"
 
 /* Pairs with tcg_clear_temp_count.
    To be called by #TranslatorOps.{translate_insn,tb_stop} if
@@ -89,6 +90,10 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
             }
         }
 
+        if (qi_needs_before_insn(db, cpu)) {
+            qi_instrument_before_insn(db, cpu);
+        }
+
         /* Disassemble one instruction.  The translate_insn hook should
            update db->pc_next and db->is_jmp to indicate what should be
            done next -- either exiting this loop or locate the start of
