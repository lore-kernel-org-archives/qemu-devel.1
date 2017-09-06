Received: from eggs.gnu.org ([2001:4830:134:3::10]:41973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpcqr-0000Uc-DQ
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpcqm-0002k9-4b
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:53 -0400
Received: from mail-pg0-x235.google.com ([2607:f8b0:400e:c05::235]:34481)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dpcql-0002jr-T8
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:48 -0400
Received: by mail-pg0-x235.google.com with SMTP id q68so158773pgq.1
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 09:06:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  6 Sep 2017 09:06:04 -0700
Message-Id: <20170906160612.22769-25-richard.henderson@linaro.org>
In-Reply-To: <20170906160612.22769-1-richard.henderson@linaro.org>
References: <20170906160612.22769-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 24/32] target/arm: [tcg] Port to tb_stop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Richard Henderson <rth@twiddle.net>

From: Lluís Vilanova <vilanova@ac.upc.edu>

Incrementally paves the way towards using the generic instruction translation
loop.

Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
Message-Id: <150002534291.22386.13499916738708680298.stgit@frigg.lan>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/translate.c | 161 ++++++++++++++++++++++++++-----------------------
 1 file changed, 84 insertions(+), 77 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 5737299943..10527b50c8 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -12057,85 +12057,13 @@ static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     dc->base.pc_next = dc->pc;
 }
 
-/* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
+static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
 {
-    DisasContext dc1, *dc = &dc1;
-    int max_insns;
-
-    /* generate intermediate code */
-
-    /* The A64 decoder has its own top level loop, because it doesn't need
-     * the A32/T32 complexity to do with conditional execution/IT blocks/etc.
-     */
-    if (ARM_TBFLAG_AARCH64_STATE(tb->flags)) {
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
+    DisasContext *dc = container_of(dcbase, DisasContext, base);
 
-    if (tb->cflags & CF_LAST_IO) {
-        if (dc->condjmp) {
-            /* FIXME:  This can theoretically happen with self-modifying
-               code.  */
-            cpu_abort(cs, "IO on conditional branch instruction");
-        }
-        gen_io_end();
+    if (dc->base.tb->cflags & CF_LAST_IO && dc->condjmp) {
+        /* FIXME: This can theoretically happen with self-modifying code. */
+        cpu_abort(cpu, "IO on conditional branch instruction");
     }
 
     /* At this stage dc->condjmp will only be set when the skipped
@@ -12241,6 +12169,85 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
             gen_goto_tb(dc, 1, dc->pc);
         }
     }
+}
+
+/* generate intermediate code for basic block 'tb'.  */
+void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
+{
+    DisasContext dc1, *dc = &dc1;
+    int max_insns;
+
+    /* generate intermediate code */
+
+    /* The A64 decoder has its own top level loop, because it doesn't need
+     * the A32/T32 complexity to do with conditional execution/IT blocks/etc.
+     */
+    if (ARM_TBFLAG_AARCH64_STATE(tb->flags)) {
+        gen_intermediate_code_a64(&dc->base, cs, tb);
+        return;
+    }
+
+    dc->base.tb = tb;
+    dc->base.pc_first = dc->base.tb->pc;
+    dc->base.pc_next = dc->base.pc_first;
+    dc->base.is_jmp = DISAS_NEXT;
+    dc->base.num_insns = 0;
+    dc->base.singlestep_enabled = cs->singlestep_enabled;
+
+    max_insns = tb->cflags & CF_COUNT_MASK;
+    if (max_insns == 0) {
+        max_insns = CF_COUNT_MASK;
+    }
+    if (max_insns > TCG_MAX_INSNS) {
+        max_insns = TCG_MAX_INSNS;
+    }
+    max_insns = arm_tr_init_disas_context(&dc->base, cs, max_insns);
+
+    gen_tb_start(tb);
+
+    tcg_clear_temp_count();
+    arm_tr_tb_start(&dc->base, cs);
+
+    do {
+        dc->base.num_insns++;
+        arm_tr_insn_start(&dc->base, cs);
+
+        if (unlikely(!QTAILQ_EMPTY(&cs->breakpoints))) {
+            CPUBreakpoint *bp;
+            QTAILQ_FOREACH(bp, &cs->breakpoints, entry) {
+                if (bp->pc == dc->base.pc_next) {
+                    if (arm_tr_breakpoint_check(&dc->base, cs, bp)) {
+                        break;
+                    }
+                }
+            }
+            if (dc->base.is_jmp > DISAS_TOO_MANY) {
+                break;
+            }
+        }
+
+        if (dc->base.num_insns == max_insns && (tb->cflags & CF_LAST_IO)) {
+            gen_io_start();
+        }
+
+        arm_tr_translate_insn(&dc->base, cs);
+
+        if (tcg_check_temp_count()) {
+            fprintf(stderr, "TCG temporary leak before "TARGET_FMT_lx"\n",
+                    dc->pc);
+        }
+
+        if (!dc->base.is_jmp && (tcg_op_buf_full() || singlestep ||
+                            dc->base.num_insns >= max_insns)) {
+            dc->base.is_jmp = DISAS_TOO_MANY;
+        }
+    } while (!dc->base.is_jmp);
+
+    if (dc->base.tb->cflags & CF_LAST_IO) {
+        gen_io_end();
+    }
+
+    arm_tr_tb_stop(&dc->base, cs);
 
     gen_tb_end(tb, dc->base.num_insns);
 
-- 
2.13.5
