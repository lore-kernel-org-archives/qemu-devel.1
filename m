Received: from eggs.gnu.org ([2001:4830:134:3::10]:38488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWJc9-0004iY-EW
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWJc7-0003as-Ty
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:53 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:34662)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dWJc7-0003ae-LH
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:51 -0400
Received: by mail-pf0-x244.google.com with SMTP id c24so13736604pfe.1
	for <qemu-devel@nongnu.org>; Sat, 15 Jul 2017 02:43:51 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 14 Jul 2017 23:42:39 -1000
Message-Id: <20170715094243.28371-31-rth@twiddle.net>
In-Reply-To: <20170715094243.28371-1-rth@twiddle.net>
References: <20170715094243.28371-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v14 30/34] target/arm: [tcg] Port to generic
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
Cc: vilanova@ac.upc.edu, cota@braap.org, alex.bennee@linaro.org, crosthwaite.peter@gmail.com, pbonzini@redhat.com

From: Lluís Vilanova <vilanova@ac.upc.edu>

Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
Message-Id: <150002631325.22386.10348327185029496649.stgit@frigg.lan>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/translate.h     |   8 +---
 target/arm/translate-a64.c | 107 ++++++++-----------------------------------
 target/arm/translate.c     | 110 ++++++++++-----------------------------------
 3 files changed, 42 insertions(+), 183 deletions(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index 65e0c74..73a42ae 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -147,21 +147,15 @@ static void disas_set_insn_syndrome(DisasContext *s, uint32_t syn)
 
 #ifdef TARGET_AARCH64
 void a64_translate_init(void);
-void gen_intermediate_code_a64(DisasContextBase *db, CPUState *cpu,
-                               TranslationBlock *tb);
 void gen_a64_set_pc_im(uint64_t val);
 void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
                             fprintf_function cpu_fprintf, int flags);
+extern const TranslatorOps aarch64_translator_ops;
 #else
 static inline void a64_translate_init(void)
 {
 }
 
-static inline void gen_intermediate_code_a64(DisasContextBase *db, CPUState *cpu,
-                                             TranslationBlock *tb)
-{
-}
-
 static inline void gen_a64_set_pc_im(uint64_t val)
 {
 }
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 6259ed0..1aa4c14 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11252,6 +11252,11 @@ static int aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     return max_insns;
 }
 
+static void aarch64_tr_tb_start(DisasContextBase *db, CPUState *cpu)
+{
+    tcg_clear_temp_count();
+}
+
 static void aarch64_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
@@ -11315,6 +11320,7 @@ static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     }
 
     dc->base.pc_next = dc->pc;
+    translator_loop_temp_check(&dc->base);
 }
 
 static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
@@ -11381,6 +11387,9 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
             break;
         }
     }
+
+    /* Functions above can change dc->pc, so re-align db->pc_next */
+    dc->base.pc_next = dc->pc;
 }
 
 static void aarch64_tr_disas_log(const DisasContextBase *dcbase,
@@ -11393,92 +11402,12 @@ static void aarch64_tr_disas_log(const DisasContextBase *dcbase,
                      4 | (bswap_code(dc->sctlr_b) ? 2 : 0));
 }
 
-void gen_intermediate_code_a64(DisasContextBase *dcbase, CPUState *cs,
-                               TranslationBlock *tb)
-{
-    DisasContext *dc = container_of(dcbase, DisasContext, base);
-    int max_insns;
-
-    dc->base.tb = tb;
-    dc->base.pc_first = dc->base.tb->pc;
-    dc->base.pc_next = dc->base.pc_first;
-    dc->base.is_jmp = DISAS_NEXT;
-    dc->base.num_insns = 0;
-    dc->base.singlestep_enabled = cs->singlestep_enabled;
-
-    max_insns = dc->base.tb->cflags & CF_COUNT_MASK;
-    if (max_insns == 0) {
-        max_insns = CF_COUNT_MASK;
-    }
-    if (max_insns > TCG_MAX_INSNS) {
-        max_insns = TCG_MAX_INSNS;
-    }
-    max_insns = aarch64_tr_init_disas_context(&dc->base, cs, max_insns);
-
-    gen_tb_start(tb);
-
-    tcg_clear_temp_count();
-
-    do {
-        dc->base.num_insns++;
-        aarch64_tr_insn_start(&dc->base, cs);
-
-        if (unlikely(!QTAILQ_EMPTY(&cs->breakpoints))) {
-            CPUBreakpoint *bp;
-            QTAILQ_FOREACH(bp, &cs->breakpoints, entry) {
-                if (bp->pc == dc->base.pc_next) {
-                    if (aarch64_tr_breakpoint_check(&dc->base, cs, bp)) {
-                        break;
-                    }
-                }
-            }
-            if (dc->base.is_jmp > DISAS_TOO_MANY) {
-                break;
-            }
-        }
-
-        if (dc->base.num_insns == max_insns && (dc->base.tb->cflags & CF_LAST_IO)) {
-            gen_io_start();
-        }
-
-        aarch64_tr_translate_insn(&dc->base, cs);
-
-        if (tcg_check_temp_count()) {
-            fprintf(stderr, "TCG temporary leak before "TARGET_FMT_lx"\n",
-                    dc->pc);
-        }
-
-        if (!dc->base.is_jmp && (tcg_op_buf_full() || cs->singlestep_enabled ||
-                            singlestep || dc->base.num_insns >= max_insns)) {
-            dc->base.is_jmp = DISAS_TOO_MANY;
-        }
-
-        /* Translation stops when a conditional branch is encountered.
-         * Otherwise the subsequent code could get translated several times.
-         * Also stop translation when a page boundary is reached.  This
-         * ensures prefetch aborts occur at the right place.
-         */
-    } while (!dc->base.is_jmp);
-
-    if (dc->base.tb->cflags & CF_LAST_IO) {
-        gen_io_end();
-    }
-
-    aarch64_tr_tb_stop(&dc->base, cs);
-
-    gen_tb_end(tb, dc->base.num_insns);
-
-    dc->base.tb->size = dc->pc - dc->base.pc_first;
-    dc->base.tb->icount = dc->base.num_insns;
-
-#ifdef DEBUG_DISAS
-    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM) &&
-        qemu_log_in_addr_range(dc->base.pc_first)) {
-        qemu_log_lock();
-        qemu_log("----------------\n");
-        aarch64_tr_disas_log(&dc->base, cs);
-        qemu_log("\n");
-        qemu_log_unlock();
-    }
-#endif
-}
+const TranslatorOps aarch64_translator_ops = {
+    .init_disas_context = aarch64_tr_init_disas_context,
+    .tb_start           = aarch64_tr_tb_start,
+    .insn_start         = aarch64_tr_insn_start,
+    .breakpoint_check   = aarch64_tr_breakpoint_check,
+    .translate_insn     = aarch64_tr_translate_insn,
+    .tb_stop            = aarch64_tr_tb_stop,
+    .disas_log          = aarch64_tr_disas_log,
+};
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 4ea5f70..4b1230b 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11897,7 +11897,9 @@ static void arm_tr_tb_start(DisasContextBase *dcbase, CPUState *cpu)
         TCGv_i32 tmp = tcg_temp_new_i32();
         tcg_gen_movi_i32(tmp, 0);
         store_cpu_field(tmp, condexec_bits);
+        tcg_temp_free_i32(tmp);
     }
+    tcg_clear_temp_count();
 }
 
 static void arm_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
@@ -12017,6 +12019,7 @@ static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     }
 
     dc->base.pc_next = dc->pc;
+    translator_loop_temp_check(&dc->base);
 }
 
 static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
@@ -12131,6 +12134,9 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
             gen_goto_tb(dc, 1, dc->pc);
         }
     }
+
+    /* Functions above can change dc->pc, so re-align db->pc_next */
+    dc->base.pc_next = dc->pc;
 }
 
 static void arm_tr_disas_log(const DisasContextBase *dcbase, CPUState *cpu)
@@ -12142,99 +12148,29 @@ static void arm_tr_disas_log(const DisasContextBase *dcbase, CPUState *cpu)
                      dc->thumb | (dc->sctlr_b << 1));
 }
 
+static const TranslatorOps arm_translator_ops = {
+    .init_disas_context = arm_tr_init_disas_context,
+    .tb_start           = arm_tr_tb_start,
+    .insn_start         = arm_tr_insn_start,
+    .breakpoint_check   = arm_tr_breakpoint_check,
+    .translate_insn     = arm_tr_translate_insn,
+    .tb_stop            = arm_tr_tb_stop,
+    .disas_log          = arm_tr_disas_log,
+};
+
 /* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
+void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
 {
-    DisasContext dc1, *dc = &dc1;
-    int max_insns;
+    DisasContext dc;
+    const TranslatorOps *ops = &arm_translator_ops;
 
-    /* generate intermediate code */
-
-    /* The A64 decoder has its own top level loop, because it doesn't need
-     * the A32/T32 complexity to do with conditional execution/IT blocks/etc.
-     */
+#ifdef TARGET_AARCH64
     if (ARM_TBFLAG_AARCH64_STATE(tb->flags)) {
-        gen_intermediate_code_a64(&dc->base, cs, tb);
-        return;
-    }
-
-    dc->base.tb = tb;
-    dc->base.pc_first = dc->base.tb->pc;
-    dc->base.pc_next = dc->base.pc_first;
-    dc->base.is_jmp = DISAS_NEXT;
-    dc->base.num_insns = 0;
-    dc->base.singlestep_enabled = cs->singlestep_enabled;
-
-    max_insns = tb->cflags & CF_COUNT_MASK;
-    if (max_insns == 0) {
-        max_insns = CF_COUNT_MASK;
-    }
-    if (max_insns > TCG_MAX_INSNS) {
-        max_insns = TCG_MAX_INSNS;
-    }
-    max_insns = arm_tr_init_disas_context(&dc->base, cs, max_insns);
-
-    gen_tb_start(tb);
-
-    tcg_clear_temp_count();
-    arm_tr_tb_start(&dc->base, cs);
-
-    do {
-        dc->base.num_insns++;
-        arm_tr_insn_start(&dc->base, cs);
-
-        if (unlikely(!QTAILQ_EMPTY(&cs->breakpoints))) {
-            CPUBreakpoint *bp;
-            QTAILQ_FOREACH(bp, &cs->breakpoints, entry) {
-                if (bp->pc == dc->base.pc_next) {
-                    if (arm_tr_breakpoint_check(&dc->base, cs, bp)) {
-                        break;
-                    }
-                }
-            }
-            if (dc->base.is_jmp > DISAS_TOO_MANY) {
-                break;
-            }
-        }
-
-        if (dc->base.num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
-            gen_io_start();
-        }
-
-        arm_tr_translate_insn(&dc->base, cs);
-
-        if (tcg_check_temp_count()) {
-            fprintf(stderr, "TCG temporary leak before "TARGET_FMT_lx"\n",
-                    dc->pc);
-        }
-
-        if (!dc->base.is_jmp && (tcg_op_buf_full() || singlestep ||
-                            dc->base.num_insns >= max_insns)) {
-            dc->base.is_jmp = DISAS_TOO_MANY;
-        }
-    } while (!dc->base.is_jmp);
-
-    if (dc->base.tb->cflags & CF_LAST_IO) {
-        gen_io_end();
-    }
-
-    arm_tr_tb_stop(&dc->base, cs);
-
-    gen_tb_end(tb, dc->base.num_insns);
-
-    tb->size = dc->pc - dc->base.pc_first;
-    tb->icount = dc->base.num_insns;
-
-#ifdef DEBUG_DISAS
-    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM) &&
-        qemu_log_in_addr_range(dc->base.pc_first)) {
-        qemu_log_lock();
-        qemu_log("----------------\n");
-        arm_tr_disas_log(&dc->base, cs);
-        qemu_log("\n");
-        qemu_log_unlock();
+        ops = &aarch64_translator_ops;
     }
 #endif
+
+    translator_loop(ops, &dc.base, cpu, tb);
 }
 
 static const char *cpu_mode_names[16] = {
-- 
2.9.4
