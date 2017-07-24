Received: from eggs.gnu.org ([2001:4830:134:3::10]:48177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZjyK-0003pz-VX
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:29:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZjyJ-0001zy-QK
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:28:56 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:37037)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dZjyJ-0001zY-LW
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:28:55 -0400
Received: by mail-qk0-x241.google.com with SMTP id q130so10952104qka.4
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 13:28:55 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 24 Jul 2017 13:27:28 -0700
Message-Id: <20170724202728.25960-33-rth@twiddle.net>
In-Reply-To: <20170724202728.25960-1-rth@twiddle.net>
References: <20170724202728.25960-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v15 32/32] target/arm: Perform per-insn
 cross-page check only for Thumb
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

ARM is a fixed-length ISA and we can compute the page crossing
condition exactly once during init_disas_context.

Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/translate.c | 58 ++++++++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 25 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 554b05816b..875c9985d1 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11858,6 +11858,13 @@ static int arm_tr_init_disas_context(DisasContextBase *dcbase,
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
@@ -11985,34 +11992,12 @@ static bool arm_pre_translate_insn(DisasContext *dc)
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
@@ -12031,7 +12016,10 @@ static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     dc->pc += 4;
     disas_arm_insn(dc, insn);
 
-    arm_post_translate_insn(env, dc);
+    arm_post_translate_insn(dc);
+
+    /* ARM is a fixed-length ISA.  We performed the cross-page check
+       in init_disas_context by adjusting max_insns.  */
 }
 
 static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
@@ -12055,7 +12043,27 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
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
2.13.3
