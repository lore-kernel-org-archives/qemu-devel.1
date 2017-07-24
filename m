Received: from eggs.gnu.org ([2001:4830:134:3::10]:48032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZjy3-0003aL-Bb
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:28:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZjxz-0001Tc-1Z
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:28:39 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33050)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dZjxy-0001Si-QE
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:28:34 -0400
Received: by mail-qt0-x243.google.com with SMTP id n42so3407926qtn.0
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 13:28:34 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 24 Jul 2017 13:27:18 -0700
Message-Id: <20170724202728.25960-23-rth@twiddle.net>
In-Reply-To: <20170724202728.25960-1-rth@twiddle.net>
References: <20170724202728.25960-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v15 22/32] target/arm: [tcg] Port to
 translate_insn
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
Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
Message-Id: <150002485863.22386.13949856269576226529.stgit@frigg.lan>
[rth: Adjust for translate_insn interface change.]
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/translate.h |   1 +
 target/arm/translate.c | 165 +++++++++++++++++++++++++++----------------------
 2 files changed, 91 insertions(+), 75 deletions(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index a804ff65ac..e8dcec51ac 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -9,6 +9,7 @@ typedef struct DisasContext {
     DisasContextBase base;
 
     target_ulong pc;
+    target_ulong next_page_start;
     uint32_t insn;
     /* Nonzero if this instruction has been conditionally skipped.  */
     int condjmp;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 30db22fa79..0b4cb1e463 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11850,6 +11850,8 @@ static int arm_tr_init_disas_context(DisasContextBase *dcbase,
     dc->is_ldex = false;
     dc->ss_same_el = false; /* Can't be true since EL_d must be AArch64 */
 
+    dc->next_page_start =
+        (dc->base.pc_first & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
 
     cpu_F0s = tcg_temp_new_i32();
     cpu_F1s = tcg_temp_new_i32();
@@ -11943,14 +11945,93 @@ static bool arm_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
     return true;
 }
 
+static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
+{
+    DisasContext *dc = container_of(dcbase, DisasContext, base);
+    CPUARMState *env = cpu->env_ptr;
+
+#ifdef CONFIG_USER_ONLY
+    /* Intercept jump to the magic kernel page.  */
+    if (dc->pc >= 0xffff0000) {
+        /* We always get here via a jump, so know we are not in a
+           conditional execution block.  */
+        gen_exception_internal(EXCP_KERNEL_TRAP);
+        dc->base.is_jmp = DISAS_NORETURN;
+        return;
+    }
+#endif
+
+    if (dc->ss_active && !dc->pstate_ss) {
+        /* Singlestep state is Active-pending.
+         * If we're in this state at the start of a TB then either
+         *  a) we just took an exception to an EL which is being debugged
+         *     and this is the first insn in the exception handler
+         *  b) debug exceptions were masked and we just unmasked them
+         *     without changing EL (eg by clearing PSTATE.D)
+         * In either case we're going to take a swstep exception in the
+         * "did not step an insn" case, and so the syndrome ISV and EX
+         * bits should be zero.
+         */
+        assert(dc->base.num_insns == 1);
+        gen_exception(EXCP_UDEF, syn_swstep(dc->ss_same_el, 0, 0),
+                      default_exception_el(dc));
+        dc->base.is_jmp = DISAS_NORETURN;
+        return;
+    }
+
+    if (dc->thumb) {
+        disas_thumb_insn(env, dc);
+        if (dc->condexec_mask) {
+            dc->condexec_cond = (dc->condexec_cond & 0xe)
+                | ((dc->condexec_mask >> 4) & 1);
+            dc->condexec_mask = (dc->condexec_mask << 1) & 0x1f;
+            if (dc->condexec_mask == 0) {
+                dc->condexec_cond = 0;
+            }
+        }
+    } else {
+        unsigned int insn = arm_ldl_code(env, dc->pc, dc->sctlr_b);
+        dc->pc += 4;
+        disas_arm_insn(dc, insn);
+    }
+
+    if (dc->condjmp && !dc->base.is_jmp) {
+        gen_set_label(dc->condlabel);
+        dc->condjmp = 0;
+    }
+
+    if (dc->base.is_jmp == DISAS_NEXT) {
+        /* Translation stops when a conditional branch is encountered.
+         * Otherwise the subsequent code could get translated several times.
+         * Also stop translation when a page boundary is reached.  This
+         * ensures prefetch aborts occur at the right place.  */
+
+        if (is_singlestepping(dc)) {
+            dc->base.is_jmp = DISAS_TOO_MANY;
+        } else if ((dc->pc >= dc->next_page_start) ||
+                   ((dc->pc >= dc->next_page_start - 3) &&
+                    insn_crosses_page(env, dc))) {
+            /* We want to stop the TB if the next insn starts in a new page,
+             * or if it spans between this page and the next. This means that
+             * if we're looking at the last halfword in the page we need to
+             * see if it's a 16-bit Thumb insn (which will fit in this TB)
+             * or a 32-bit Thumb insn (which won't).
+             * This is to avoid generating a silly TB with a single 16-bit insn
+             * in it at the end of this page (which would execute correctly
+             * but isn't very efficient).
+             */
+            dc->base.is_jmp = DISAS_TOO_MANY;
+        }
+    }
+
+    dc->base.pc_next = dc->pc;
+}
+
 /* generate intermediate code for basic block 'tb'.  */
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
 {
-    CPUARMState *env = cs->env_ptr;
     DisasContext dc1, *dc = &dc1;
-    target_ulong next_page_start;
     int max_insns;
-    bool end_of_page;
 
     /* generate intermediate code */
 
@@ -11969,7 +12050,6 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
     dc->base.num_insns = 0;
     dc->base.singlestep_enabled = cs->singlestep_enabled;
 
-    next_page_start = (dc->base.pc_first & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
     max_insns = tb->cflags & CF_COUNT_MASK;
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
@@ -12006,83 +12086,18 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
             gen_io_start();
         }
 
-#ifdef CONFIG_USER_ONLY
-        /* Intercept jump to the magic kernel page.  */
-        if (dc->pc >= 0xffff0000) {
-            /* We always get here via a jump, so know we are not in a
-               conditional execution block.  */
-            gen_exception_internal(EXCP_KERNEL_TRAP);
-            dc->base.is_jmp = DISAS_NORETURN;
-            break;
-        }
-#endif
-
-        if (dc->ss_active && !dc->pstate_ss) {
-            /* Singlestep state is Active-pending.
-             * If we're in this state at the start of a TB then either
-             *  a) we just took an exception to an EL which is being debugged
-             *     and this is the first insn in the exception handler
-             *  b) debug exceptions were masked and we just unmasked them
-             *     without changing EL (eg by clearing PSTATE.D)
-             * In either case we're going to take a swstep exception in the
-             * "did not step an insn" case, and so the syndrome ISV and EX
-             * bits should be zero.
-             */
-            assert(dc->base.num_insns == 1);
-            gen_exception(EXCP_UDEF, syn_swstep(dc->ss_same_el, 0, 0),
-                          default_exception_el(dc));
-            dc->base.is_jmp = DISAS_NORETURN;
-            break;
-        }
-
-        if (dc->thumb) {
-            disas_thumb_insn(env, dc);
-            if (dc->condexec_mask) {
-                dc->condexec_cond = (dc->condexec_cond & 0xe)
-                                   | ((dc->condexec_mask >> 4) & 1);
-                dc->condexec_mask = (dc->condexec_mask << 1) & 0x1f;
-                if (dc->condexec_mask == 0) {
-                    dc->condexec_cond = 0;
-                }
-            }
-        } else {
-            unsigned int insn = arm_ldl_code(env, dc->pc, dc->sctlr_b);
-            dc->pc += 4;
-            disas_arm_insn(dc, insn);
-        }
-
-        if (dc->condjmp && !dc->base.is_jmp) {
-            gen_set_label(dc->condlabel);
-            dc->condjmp = 0;
-        }
+        arm_tr_translate_insn(&dc->base, cs);
 
         if (tcg_check_temp_count()) {
             fprintf(stderr, "TCG temporary leak before "TARGET_FMT_lx"\n",
                     dc->pc);
         }
 
-        /* Translation stops when a conditional branch is encountered.
-         * Otherwise the subsequent code could get translated several times.
-         * Also stop translation when a page boundary is reached.  This
-         * ensures prefetch aborts occur at the right place.  */
-
-        /* We want to stop the TB if the next insn starts in a new page,
-         * or if it spans between this page and the next. This means that
-         * if we're looking at the last halfword in the page we need to
-         * see if it's a 16-bit Thumb insn (which will fit in this TB)
-         * or a 32-bit Thumb insn (which won't).
-         * This is to avoid generating a silly TB with a single 16-bit insn
-         * in it at the end of this page (which would execute correctly
-         * but isn't very efficient).
-         */
-        end_of_page = (dc->pc >= next_page_start) ||
-            ((dc->pc >= next_page_start - 3) && insn_crosses_page(env, dc));
-
-    } while (!dc->base.is_jmp && !tcg_op_buf_full() &&
-             !is_singlestepping(dc) &&
-             !singlestep &&
-             !end_of_page &&
-             dc->base.num_insns < max_insns);
+        if (!dc->base.is_jmp && (tcg_op_buf_full() || singlestep ||
+                            dc->base.num_insns >= max_insns)) {
+            dc->base.is_jmp = DISAS_TOO_MANY;
+        }
+    } while (!dc->base.is_jmp);
 
     if (tb->cflags & CF_LAST_IO) {
         if (dc->condjmp) {
-- 
2.13.3
