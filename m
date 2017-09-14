Received: from eggs.gnu.org ([2001:4830:134:3::10]:49580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsYz0-0000Ox-Iu
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 14:35:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsYyy-0000QL-Fj
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 14:35:26 -0400
Received: from mail-pf0-x22c.google.com ([2607:f8b0:400e:c00::22c]:49830)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dsYyy-0000PR-7u
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 14:35:24 -0400
Received: by mail-pf0-x22c.google.com with SMTP id l188so115156pfc.6
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 11:35:24 -0700 (PDT)
Received: from bigtime.twiddle.net (97-126-103-167.tukw.qwest.net.
	[97.126.103.167]) by smtp.gmail.com with ESMTPSA id
	l85sm32473848pfb.176.2017.09.14.11.35.21 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 14 Sep 2017 11:35:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 14 Sep 2017 11:35:09 -0700
Message-Id: <20170914183516.19537-4-richard.henderson@linaro.org>
In-Reply-To: <20170914183516.19537-1-richard.henderson@linaro.org>
References: <20170914183516.19537-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 03/10] disas: Remove unused flags arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Now that every target is using the disas_set_info hook,
the flags argument is unused.  Remove it.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/disas/disas.h         |  4 ++--
 include/exec/log.h            |  4 ++--
 disas.c                       | 15 ++++-----------
 monitor.c                     |  3 +--
 target/alpha/translate.c      |  2 +-
 target/arm/translate-a64.c    |  3 +--
 target/arm/translate.c        |  3 +--
 target/cris/translate.c       |  3 +--
 target/hppa/translate.c       |  2 +-
 target/i386/translate.c       |  2 +-
 target/lm32/translate.c       |  2 +-
 target/m68k/translate.c       |  2 +-
 target/microblaze/translate.c |  2 +-
 target/mips/translate.c       |  2 +-
 target/nios2/translate.c      |  2 +-
 target/openrisc/translate.c   |  2 +-
 target/ppc/translate.c        |  2 +-
 target/s390x/translate.c      |  2 +-
 target/sh4/translate.c        |  2 +-
 target/sparc/translate.c      |  2 +-
 target/tricore/translate.c    |  2 +-
 target/unicore32/translate.c  |  2 +-
 target/xtensa/translate.c     |  2 +-
 23 files changed, 28 insertions(+), 39 deletions(-)

diff --git a/include/disas/disas.h b/include/disas/disas.h
index e549ca24a1..4d48c13c65 100644
--- a/include/disas/disas.h
+++ b/include/disas/disas.h
@@ -9,10 +9,10 @@
 /* Disassemble this for me please... (debugging). */
 void disas(FILE *out, void *code, unsigned long size);
 void target_disas(FILE *out, CPUState *cpu, target_ulong code,
-                  target_ulong size, int flags);
+                  target_ulong size);
 
 void monitor_disas(Monitor *mon, CPUState *cpu,
-                   target_ulong pc, int nb_insn, int is_physical, int flags);
+                   target_ulong pc, int nb_insn, int is_physical);
 
 /* Look up symbol for debugging purpose.  Returns "" if unknown. */
 const char *lookup_symbol(target_ulong orig_addr);
diff --git a/include/exec/log.h b/include/exec/log.h
index ba1c9b5682..c249307911 100644
--- a/include/exec/log.h
+++ b/include/exec/log.h
@@ -38,9 +38,9 @@ static inline void log_cpu_state_mask(int mask, CPUState *cpu, int flags)
 #ifdef NEED_CPU_H
 /* disas() and target_disas() to qemu_logfile: */
 static inline void log_target_disas(CPUState *cpu, target_ulong start,
-                                    target_ulong len, int flags)
+                                    target_ulong len)
 {
-    target_disas(qemu_logfile, cpu, start, len, flags);
+    target_disas(qemu_logfile, cpu, start, len);
 }
 
 static inline void log_disas(void *code, unsigned long size)
diff --git a/disas.c b/disas.c
index 3a375a3b6c..ad675dc361 100644
--- a/disas.c
+++ b/disas.c
@@ -171,15 +171,9 @@ static int print_insn_od_target(bfd_vma pc, disassemble_info *info)
     return print_insn_objdump(pc, info, "OBJD-T");
 }
 
-/* Disassemble this for me please... (debugging). 'flags' has the following
-   values:
-    i386 - 1 means 16 bit code, 2 means 64 bit code
-    ppc  - bits 0:15 specify (optionally) the machine instruction set;
-           bit 16 indicates little endian.
-    other targets - unused
- */
+/* Disassemble this for me please... (debugging).  */
 void target_disas(FILE *out, CPUState *cpu, target_ulong code,
-                  target_ulong size, int flags)
+                  target_ulong size)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
     target_ulong pc;
@@ -336,10 +330,9 @@ monitor_read_memory (bfd_vma memaddr, bfd_byte *myaddr, int length,
     return 0;
 }
 
-/* Disassembler for the monitor.
-   See target_disas for a description of flags. */
+/* Disassembler for the monitor.  */
 void monitor_disas(Monitor *mon, CPUState *cpu,
-                   target_ulong pc, int nb_insn, int is_physical, int flags)
+                   target_ulong pc, int nb_insn, int is_physical)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
     int count, i;
diff --git a/monitor.c b/monitor.c
index a0f43f27e7..2125b54101 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1309,8 +1309,7 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
     }
 
     if (format == 'i') {
-        int flags = 0;
-        monitor_disas(mon, cs, addr, count, is_physical, flags);
+        monitor_disas(mon, cs, addr, count, is_physical);
         return;
     }
 
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 5a92c4accb..e9a245f9c5 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -3048,7 +3048,7 @@ static void alpha_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
 static void alpha_tr_disas_log(const DisasContextBase *dcbase, CPUState *cpu)
 {
     qemu_log("IN: %s\n", lookup_symbol(dcbase->pc_first));
-    log_target_disas(cpu, dcbase->pc_first, dcbase->tb->size, 1);
+    log_target_disas(cpu, dcbase->pc_first, dcbase->tb->size);
 }
 
 static const TranslatorOps alpha_tr_ops = {
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 9017e30510..a3984c9a0d 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11409,8 +11409,7 @@ static void aarch64_tr_disas_log(const DisasContextBase *dcbase,
     DisasContext *dc = container_of(dcbase, DisasContext, base);
 
     qemu_log("IN: %s\n", lookup_symbol(dc->base.pc_first));
-    log_target_disas(cpu, dc->base.pc_first, dc->base.tb->size,
-                     4 | (bswap_code(dc->sctlr_b) ? 2 : 0));
+    log_target_disas(cpu, dc->base.pc_first, dc->base.tb->size);
 }
 
 const TranslatorOps aarch64_translator_ops = {
diff --git a/target/arm/translate.c b/target/arm/translate.c
index ab1a12a1b8..93e9dbe33d 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -12258,8 +12258,7 @@ static void arm_tr_disas_log(const DisasContextBase *dcbase, CPUState *cpu)
     DisasContext *dc = container_of(dcbase, DisasContext, base);
 
     qemu_log("IN: %s\n", lookup_symbol(dc->base.pc_first));
-    log_target_disas(cpu, dc->base.pc_first, dc->base.tb->size,
-                     dc->thumb | (dc->sctlr_b << 1));
+    log_target_disas(cpu, dc->base.pc_first, dc->base.tb->size);
 }
 
 static const TranslatorOps arm_translator_ops = {
diff --git a/target/cris/translate.c b/target/cris/translate.c
index 38a999e6f1..b1fda57c74 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -3297,8 +3297,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         qemu_log_lock();
         qemu_log("--------------\n");
         qemu_log("IN: %s\n", lookup_symbol(pc_start));
-        log_target_disas(cs, pc_start, dc->pc - pc_start,
-                         env->pregs[PR_VR]);
+        log_target_disas(cs, pc_start, dc->pc - pc_start);
         qemu_log("\nisize=%d osize=%d\n",
                  dc->pc - pc_start, tcg_op_buf_count());
         qemu_log_unlock();
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index b6e2652341..fc2a9f5896 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3904,7 +3904,7 @@ static void hppa_tr_disas_log(const DisasContextBase *dcbase, CPUState *cs)
         break;
     default:
         qemu_log("IN: %s\n", lookup_symbol(tb->pc));
-        log_target_disas(cs, tb->pc, tb->size, 1);
+        log_target_disas(cs, tb->pc, tb->size);
         break;
     }
 }
diff --git a/target/i386/translate.c b/target/i386/translate.c
index 06c2cb9e64..23d9e05426 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -8528,7 +8528,7 @@ static void i386_tr_disas_log(const DisasContextBase *dcbase,
     DisasContext *dc = container_of(dcbase, DisasContext, base);
 
     qemu_log("IN: %s\n", lookup_symbol(dc->base.pc_first));
-    log_target_disas(cpu, dc->base.pc_first, dc->base.tb->size, 0);
+    log_target_disas(cpu, dc->base.pc_first, dc->base.tb->size);
 }
 
 static const TranslatorOps i386_tr_ops = {
diff --git a/target/lm32/translate.c b/target/lm32/translate.c
index 65bc9c0bf6..a83cbdf729 100644
--- a/target/lm32/translate.c
+++ b/target/lm32/translate.c
@@ -1156,7 +1156,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         && qemu_log_in_addr_range(pc_start)) {
         qemu_log_lock();
         qemu_log("\n");
-        log_target_disas(cs, pc_start, dc->pc - pc_start, 0);
+        log_target_disas(cs, pc_start, dc->pc - pc_start);
         qemu_log("\nisize=%d osize=%d\n",
                  dc->pc - pc_start, tcg_op_buf_count());
         qemu_log_unlock();
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index d738f32f9c..e1e31f622c 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -5620,7 +5620,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
         qemu_log_lock();
         qemu_log("----------------\n");
         qemu_log("IN: %s\n", lookup_symbol(pc_start));
-        log_target_disas(cs, pc_start, dc->pc - pc_start, 0);
+        log_target_disas(cs, pc_start, dc->pc - pc_start);
         qemu_log("\n");
         qemu_log_unlock();
     }
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 067b0878d6..fecc61a1ec 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1810,7 +1810,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         qemu_log_lock();
         qemu_log("--------------\n");
 #if DISAS_GNU
-        log_target_disas(cs, pc_start, dc->pc - pc_start, 0);
+        log_target_disas(cs, pc_start, dc->pc - pc_start);
 #endif
         qemu_log("\nisize=%d osize=%d\n",
                  dc->pc - pc_start, tcg_op_buf_count());
diff --git a/target/mips/translate.c b/target/mips/translate.c
index c78d27294c..3b9cf9a236 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -20369,7 +20369,7 @@ done_generating:
         && qemu_log_in_addr_range(pc_start)) {
         qemu_log_lock();
         qemu_log("IN: %s\n", lookup_symbol(pc_start));
-        log_target_disas(cs, pc_start, ctx.pc - pc_start, 0);
+        log_target_disas(cs, pc_start, ctx.pc - pc_start);
         qemu_log("\n");
         qemu_log_unlock();
     }
diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index 6b0961837d..7a0fa860da 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -907,7 +907,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
         && qemu_log_in_addr_range(tb->pc)) {
         qemu_log_lock();
         qemu_log("IN: %s\n", lookup_symbol(tb->pc));
-        log_target_disas(cs, tb->pc, dc->pc - tb->pc, 0);
+        log_target_disas(cs, tb->pc, dc->pc - tb->pc);
         qemu_log("\n");
         qemu_log_unlock();
     }
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 112db1ad0f..99f2b463ce 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -1653,7 +1653,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
 
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
         && qemu_log_in_addr_range(pc_start)) {
-        log_target_disas(cs, pc_start, tb->size, 0);
+        log_target_disas(cs, pc_start, tb->size);
         qemu_log("\n");
         qemu_log_unlock();
     }
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index bc155f1036..8e92e4579c 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7397,7 +7397,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         && qemu_log_in_addr_range(pc_start)) {
         qemu_log_lock();
         qemu_log("IN: %s\n", lookup_symbol(pc_start));
-        log_target_disas(cs, pc_start, ctx.nip - pc_start, 0);
+        log_target_disas(cs, pc_start, ctx.nip - pc_start);
         qemu_log("\n");
         qemu_log_unlock();
     }
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 909b12818d..28bd02ceb3 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -5910,7 +5910,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
             qemu_log("IN: EXECUTE %016" PRIx64 "\n", dc.ex_value);
         } else {
             qemu_log("IN: %s\n", lookup_symbol(pc_start));
-            log_target_disas(cs, pc_start, dc.pc - pc_start, 1);
+            log_target_disas(cs, pc_start, dc.pc - pc_start);
             qemu_log("\n");
         }
         qemu_log_unlock();
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 10191073b2..7532bf74c1 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -2347,7 +2347,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         && qemu_log_in_addr_range(pc_start)) {
         qemu_log_lock();
 	qemu_log("IN:\n");	/* , lookup_symbol(pc_start)); */
-        log_target_disas(cs, pc_start, ctx.pc - pc_start, 0);
+        log_target_disas(cs, pc_start, ctx.pc - pc_start);
 	qemu_log("\n");
         qemu_log_unlock();
     }
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 6290705b11..e89b6227f2 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5855,7 +5855,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock * tb)
         qemu_log_lock();
         qemu_log("--------------\n");
         qemu_log("IN: %s\n", lookup_symbol(pc_start));
-        log_target_disas(cs, pc_start, last_pc + 4 - pc_start, 0);
+        log_target_disas(cs, pc_start, last_pc + 4 - pc_start);
         qemu_log("\n");
         qemu_log_unlock();
     }
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 4e4198e887..e807500e26 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -8839,7 +8839,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         && qemu_log_in_addr_range(pc_start)) {
         qemu_log_lock();
         qemu_log("IN: %s\n", lookup_symbol(pc_start));
-        log_target_disas(cs, pc_start, ctx.pc - pc_start, 0);
+        log_target_disas(cs, pc_start, ctx.pc - pc_start);
         qemu_log("\n");
         qemu_log_unlock();
     }
diff --git a/target/unicore32/translate.c b/target/unicore32/translate.c
index 6c094d59d7..f9aa248a80 100644
--- a/target/unicore32/translate.c
+++ b/target/unicore32/translate.c
@@ -2031,7 +2031,7 @@ done_generating:
         qemu_log_lock();
         qemu_log("----------------\n");
         qemu_log("IN: %s\n", lookup_symbol(pc_start));
-        log_target_disas(cs, pc_start, dc->pc - pc_start, 0);
+        log_target_disas(cs, pc_start, dc->pc - pc_start);
         qemu_log("\n");
         qemu_log_unlock();
     }
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index d7bf07e8e6..03719ce12b 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -3250,7 +3250,7 @@ done:
         qemu_log_lock();
         qemu_log("----------------\n");
         qemu_log("IN: %s\n", lookup_symbol(pc_start));
-        log_target_disas(cs, pc_start, dc.pc - pc_start, 0);
+        log_target_disas(cs, pc_start, dc.pc - pc_start);
         qemu_log("\n");
         qemu_log_unlock();
     }
-- 
2.13.5
