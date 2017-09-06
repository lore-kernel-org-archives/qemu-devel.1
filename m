Received: from eggs.gnu.org ([2001:4830:134:3::10]:42025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpcqx-0000aP-Q8
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:07:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpcqw-0003A3-JE
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:59 -0400
Received: from mail-pg0-x22c.google.com ([2607:f8b0:400e:c05::22c]:37876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dpcqw-00038p-Dg
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:58 -0400
Received: by mail-pg0-x22c.google.com with SMTP id d8so15976971pgt.4
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 09:06:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  6 Sep 2017 09:06:12 -0700
Message-Id: <20170906160612.22769-33-richard.henderson@linaro.org>
In-Reply-To: <20170906160612.22769-1-richard.henderson@linaro.org>
References: <20170906160612.22769-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 32/32] target/arm: Perform per-insn cross-page
 check only for Thumb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

ARM is a fixed-length ISA and we can compute the page crossing
condition exactly once during init_disas_context.

Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/translate.c | 58 ++++++++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 25 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 9e7bfbcf0c..6946e56a3a 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11888,6 +11888,13 @@ static int arm_tr_init_disas_context(DisasContextBase *dcbase,
         max_insns = 1;
     }
 
+    /* ARM is a fixed-length ISA.  Bound the number of insns to execute
+       to those left on the page.  */
+    if (!dc->thumb) {
+        int bound = (dc->next_page_start - dc->base.pc_first) / 4;
+        max_insns = MIN(max_insns, bound);
+    }
+
     cpu_F0s = tcg_temp_new_i32();
     cpu_F1s = tcg_temp_new_i32();
     cpu_F0d = tcg_temp_new_i64();
@@ -12015,34 +12022,12 @@ static bool arm_pre_translate_insn(DisasContext *dc)
     return false;
 }
 
-static void arm_post_translate_insn(CPUARMState *env, DisasContext *dc)
+static void arm_post_translate_insn(DisasContext *dc)
 {
     if (dc->condjmp && !dc->base.is_jmp) {
         gen_set_label(dc->condlabel);
         dc->condjmp = 0;
     }
-
-    /* Translation stops when a conditional branch is encountered.
-     * Otherwise the subsequent code could get translated several times.
-     * Also stop translation when a page boundary is reached.  This
-     * ensures prefetch aborts occur at the right place.
-     *
-     * We want to stop the TB if the next insn starts in a new page,
-     * or if it spans between this page and the next. This means that
-     * if we're looking at the last halfword in the page we need to
-     * see if it's a 16-bit Thumb insn (which will fit in this TB)
-     * or a 32-bit Thumb insn (which won't).
-     * This is to avoid generating a silly TB with a single 16-bit insn
-     * in it at the end of this page (which would execute correctly
-     * but isn't very efficient).
-     */
-    if (dc->base.is_jmp == DISAS_NEXT
-        && (dc->pc >= dc->next_page_start
-            || (dc->pc >= dc->next_page_start - 3
-                && insn_crosses_page(env, dc)))) {
-        dc->base.is_jmp = DISAS_TOO_MANY;
-    }
-
     dc->base.pc_next = dc->pc;
     translator_loop_temp_check(&dc->base);
 }
@@ -12061,7 +12046,10 @@ static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     dc->pc += 4;
     disas_arm_insn(dc, insn);
 
-    arm_post_translate_insn(env, dc);
+    arm_post_translate_insn(dc);
+
+    /* ARM is a fixed-length ISA.  We performed the cross-page check
+       in init_disas_context by adjusting max_insns.  */
 }
 
 static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
@@ -12085,7 +12073,27 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
         }
     }
 
-    arm_post_translate_insn(env, dc);
+    arm_post_translate_insn(dc);
+
+    /* Thumb is a variable-length ISA.  Stop translation when the next insn
+     * will touch a new page.  This ensures that prefetch aborts occur at
+     * the right place.
+     *
+     * We want to stop the TB if the next insn starts in a new page,
+     * or if it spans between this page and the next. This means that
+     * if we're looking at the last halfword in the page we need to
+     * see if it's a 16-bit Thumb insn (which will fit in this TB)
+     * or a 32-bit Thumb insn (which won't).
+     * This is to avoid generating a silly TB with a single 16-bit insn
+     * in it at the end of this page (which would execute correctly
+     * but isn't very efficient).
+     */
+    if (dc->base.is_jmp == DISAS_NEXT
+        && (dc->pc >= dc->next_page_start
+            || (dc->pc >= dc->next_page_start - 3
+                && insn_crosses_page(env, dc)))) {
+        dc->base.is_jmp = DISAS_TOO_MANY;
+    }
 }
 
 static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
-- 
2.13.5
