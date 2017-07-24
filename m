Received: from eggs.gnu.org ([2001:4830:134:3::10]:48059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZjy9-0003gx-RS
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:28:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZjy8-0001lN-NQ
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:28:45 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:33061)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dZjy8-0001kh-Ig
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:28:44 -0400
Received: by mail-qt0-x242.google.com with SMTP id n42so3408325qtn.0
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 13:28:44 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 24 Jul 2017 13:27:21 -0700
Message-Id: <20170724202728.25960-26-rth@twiddle.net>
In-Reply-To: <20170724202728.25960-1-rth@twiddle.net>
References: <20170724202728.25960-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v15 25/32] target/arm: [tcg,
 a64] Port to tb_stop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, vilanova@ac.upc.edu

From: Lluís Vilanova <vilanova@ac.upc.edu>

Incrementally paves the way towards using the generic instruction translation
loop.

Reviewed-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
Message-Id: <150002558503.22386.1149037590886263349.stgit@frigg.lan>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/translate-a64.c | 127 ++++++++++++++++++++++++---------------------
 1 file changed, 67 insertions(+), 60 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index c1684b80c4..4056d38c02 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11306,6 +11306,72 @@ static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     dc->base.pc_next = dc->pc;
 }
 
+static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
+{
+    DisasContext *dc = container_of(dcbase, DisasContext, base);
+
+    if (unlikely(dc->base.singlestep_enabled || dc->ss_active)) {
+        /* Note that this means single stepping WFI doesn't halt the CPU.
+         * For conditional branch insns this is harmless unreachable code as
+         * gen_goto_tb() has already handled emitting the debug exception
+         * (and thus a tb-jump is not possible when singlestepping).
+         */
+        switch (dc->base.is_jmp) {
+        default:
+            gen_a64_set_pc_im(dc->pc);
+            /* fall through */
+        case DISAS_JUMP:
+            if (dc->base.singlestep_enabled) {
+                gen_exception_internal(EXCP_DEBUG);
+            } else {
+                gen_step_complete_exception(dc);
+            }
+            break;
+        case DISAS_NORETURN:
+            break;
+        }
+    } else {
+        switch (dc->base.is_jmp) {
+        case DISAS_NEXT:
+        case DISAS_TOO_MANY:
+            gen_goto_tb(dc, 1, dc->pc);
+            break;
+        default:
+        case DISAS_UPDATE:
+            gen_a64_set_pc_im(dc->pc);
+            /* fall through */
+        case DISAS_JUMP:
+            tcg_gen_lookup_and_goto_ptr(cpu_pc);
+            break;
+        case DISAS_EXIT:
+            tcg_gen_exit_tb(0);
+            break;
+        case DISAS_NORETURN:
+        case DISAS_SWI:
+            break;
+        case DISAS_WFE:
+            gen_a64_set_pc_im(dc->pc);
+            gen_helper_wfe(cpu_env);
+            break;
+        case DISAS_YIELD:
+            gen_a64_set_pc_im(dc->pc);
+            gen_helper_yield(cpu_env);
+            break;
+        case DISAS_WFI:
+            /* This is a special case because we don't want to just halt the CPU
+             * if trying to debug across a WFI.
+             */
+            gen_a64_set_pc_im(dc->pc);
+            gen_helper_wfi(cpu_env);
+            /* The helper doesn't necessarily throw an exception, but we
+             * must go back to the main loop to check for interrupts anyway.
+             */
+            tcg_gen_exit_tb(0);
+            break;
+        }
+    }
+}
+
 void gen_intermediate_code_a64(DisasContextBase *dcbase, CPUState *cs,
                                TranslationBlock *tb)
 {
@@ -11377,66 +11443,7 @@ void gen_intermediate_code_a64(DisasContextBase *dcbase, CPUState *cs,
         gen_io_end();
     }
 
-    if (unlikely(cs->singlestep_enabled || dc->ss_active)) {
-        /* Note that this means single stepping WFI doesn't halt the CPU.
-         * For conditional branch insns this is harmless unreachable code as
-         * gen_goto_tb() has already handled emitting the debug exception
-         * (and thus a tb-jump is not possible when singlestepping).
-         */
-        switch (dc->base.is_jmp) {
-        default:
-            gen_a64_set_pc_im(dc->pc);
-            /* fall through */
-        case DISAS_JUMP:
-            if (cs->singlestep_enabled) {
-                gen_exception_internal(EXCP_DEBUG);
-            } else {
-                gen_step_complete_exception(dc);
-            }
-            break;
-        case DISAS_NORETURN:
-            break;
-        }
-    } else {
-        switch (dc->base.is_jmp) {
-        case DISAS_NEXT:
-        case DISAS_TOO_MANY:
-            gen_goto_tb(dc, 1, dc->pc);
-            break;
-        case DISAS_JUMP:
-            tcg_gen_lookup_and_goto_ptr(cpu_pc);
-            break;
-        case DISAS_NORETURN:
-        case DISAS_SWI:
-            break;
-        case DISAS_WFE:
-            gen_a64_set_pc_im(dc->pc);
-            gen_helper_wfe(cpu_env);
-            break;
-        case DISAS_YIELD:
-            gen_a64_set_pc_im(dc->pc);
-            gen_helper_yield(cpu_env);
-            break;
-        case DISAS_WFI:
-            /* This is a special case because we don't want to just halt the CPU
-             * if trying to debug across a WFI.
-             */
-            gen_a64_set_pc_im(dc->pc);
-            gen_helper_wfi(cpu_env);
-            /* The helper doesn't necessarily throw an exception, but we
-             * must go back to the main loop to check for interrupts anyway.
-             */
-            tcg_gen_exit_tb(0);
-            break;
-        case DISAS_UPDATE:
-            gen_a64_set_pc_im(dc->pc);
-            /* fall through */
-        case DISAS_EXIT:
-        default:
-            tcg_gen_exit_tb(0);
-            break;
-        }
-    }
+    aarch64_tr_tb_stop(&dc->base, cs);
 
     gen_tb_end(tb, dc->base.num_insns);
 
-- 
2.13.3
