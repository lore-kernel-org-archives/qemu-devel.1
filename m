Received: from eggs.gnu.org ([2001:4830:134:3::10]:42946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7Kq6-0007ZL-E8
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 08:31:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7Kpz-00081m-Nd
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 08:31:18 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:51744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7Kpz-00081X-DU
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 08:31:11 -0400
Received: by mail-wm0-x243.google.com with SMTP id b9so1635190wmh.0
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 05:31:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 25 Oct 2017 14:30:50 +0200
Message-Id: <20171025123056.3165-6-richard.henderson@linaro.org>
In-Reply-To: <20171025123056.3165-1-richard.henderson@linaro.org>
References: <20171025123056.3165-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/11] disas: Remove unused flags arguments
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

Now that every target is using the disas_set_info hook,
the flags argument is unused.  Remove it.

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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
index 88d16fbd57..2b26466b61 100644
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
@@ -335,10 +329,9 @@ monitor_read_memory (bfd_vma memaddr, bfd_byte *myaddr, int length,
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
index 2164dfcc3b..7a802a345e 100644
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
index f32c95b9a1..3de369b17e 100644
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
index a39b9d3633..fc5419df7f 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11403,8 +11403,7 @@ static void aarch64_tr_disas_log(const DisasContextBase *dcbase,
     DisasContext *dc = container_of(dcbase, DisasContext, base);
 
     qemu_log("IN: %s\n", lookup_symbol(dc->base.pc_first));
-    log_target_disas(cpu, dc->base.pc_first, dc->base.tb->size,
-                     4 | (bswap_code(dc->sctlr_b) ? 2 : 0));
+    log_target_disas(cpu, dc->base.pc_first, dc->base.tb->size);
 }
 
 const TranslatorOps aarch64_translator_ops = {
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 4da1a4cbc6..9d31769c8d 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -12371,8 +12371,7 @@ static void arm_tr_disas_log(const DisasContextBase *dcbase, CPUState *cpu)
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
index 26242f4b3c..ca6a6d3372 100644
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
index 69a87de83b..e81479a50c 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -8559,7 +8559,7 @@ static void i386_tr_disas_log(const DisasContextBase *dcbase,
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
index ac05f3aa09..7c96aff1a0 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -20370,7 +20370,7 @@ done_generating:
         && qemu_log_in_addr_range(pc_start)) {
         qemu_log_lock();
         qemu_log("IN: %s\n", lookup_symbol(pc_start));
-        log_target_disas(cs, pc_start, ctx.pc - pc_start, 0);
+        log_target_disas(cs, pc_start, ctx.pc - pc_start);
         qemu_log("\n");
         qemu_log_unlock();
     }
diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index 54fbe898df..0d2d03d2d0 100644
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
index cddbf92564..469ebeb446 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7409,7 +7409,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
         && qemu_log_in_addr_range(pc_start)) {
         qemu_log_lock();
         qemu_log("IN: %s\n", lookup_symbol(pc_start));
-        log_target_disas(cs, pc_start, ctx.nip - pc_start, 0);
+        log_target_disas(cs, pc_start, ctx.nip - pc_start);
         qemu_log("\n");
         qemu_log_unlock();
     }
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 6ecf764a98..1ccdb35df2 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -5972,7 +5972,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
             qemu_log("IN: EXECUTE %016" PRIx64 "\n", dc.ex_value);
         } else {
             qemu_log("IN: %s\n", lookup_symbol(pc_start));
-            log_target_disas(cs, pc_start, dc.pc - pc_start, 1);
+            log_target_disas(cs, pc_start, dc.pc - pc_start);
             qemu_log("\n");
         }
         qemu_log_unlock();
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 8db9fba26e..27067cbd30 100644
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
2.13.6
