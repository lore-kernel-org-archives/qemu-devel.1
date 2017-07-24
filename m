Received: from eggs.gnu.org ([2001:4830:134:3::10]:47797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZjxX-0002zE-FB
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:28:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZjxW-0000pC-1X
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:28:07 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:38316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dZjxV-0000oh-Sj
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:28:05 -0400
Received: by mail-qk0-x243.google.com with SMTP id t2so10964748qkc.5
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 13:28:05 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 24 Jul 2017 13:26:59 -0700
Message-Id: <20170724202728.25960-4-rth@twiddle.net>
In-Reply-To: <20170724202728.25960-1-rth@twiddle.net>
References: <20170724202728.25960-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v15 03/32] target/arm: Use DISAS_NORETURN
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

Fold DISAS_EXC and DISAS_TB_JUMP into DISAS_NORETURN.

In both cases all following code is dead.  In the first
case because we have exited the TB via exception; in the
second case because we have exited the TB via goto_tb
and its associated machinery.

Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/translate.h     |  8 ++------
 target/arm/translate-a64.c | 37 ++++++++++++++++++++-----------------
 target/arm/translate.c     | 14 ++++++++------
 3 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index 2fe144baa9..90f64d9716 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -124,12 +124,8 @@ static void disas_set_insn_syndrome(DisasContext *s, uint32_t syn)
  * defer them until after the conditional execution state has been updated.
  * WFI also needs special handling when single-stepping.
  */
-#define DISAS_WFI 4
-#define DISAS_SWI 5
-/* For instructions which unconditionally cause an exception we can skip
- * emitting unreachable code at the end of the TB in the A64 decoder
- */
-#define DISAS_EXC 6
+#define DISAS_WFI 5
+#define DISAS_SWI 6
 /* WFE */
 #define DISAS_WFE 7
 #define DISAS_HVC 8
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 883e9df0c2..789c66e634 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -304,7 +304,7 @@ static void gen_exception_internal_insn(DisasContext *s, int offset, int excp)
 {
     gen_a64_set_pc_im(s->pc - offset);
     gen_exception_internal(excp);
-    s->is_jmp = DISAS_EXC;
+    s->is_jmp = DISAS_NORETURN;
 }
 
 static void gen_exception_insn(DisasContext *s, int offset, int excp,
@@ -312,7 +312,7 @@ static void gen_exception_insn(DisasContext *s, int offset, int excp,
 {
     gen_a64_set_pc_im(s->pc - offset);
     gen_exception(excp, syndrome, target_el);
-    s->is_jmp = DISAS_EXC;
+    s->is_jmp = DISAS_NORETURN;
 }
 
 static void gen_ss_advance(DisasContext *s)
@@ -340,7 +340,7 @@ static void gen_step_complete_exception(DisasContext *s)
     gen_ss_advance(s);
     gen_exception(EXCP_UDEF, syn_swstep(s->ss_same_el, 1, s->is_ldex),
                   default_exception_el(s));
-    s->is_jmp = DISAS_EXC;
+    s->is_jmp = DISAS_NORETURN;
 }
 
 static inline bool use_goto_tb(DisasContext *s, int n, uint64_t dest)
@@ -371,7 +371,7 @@ static inline void gen_goto_tb(DisasContext *s, int n, uint64_t dest)
         tcg_gen_goto_tb(n);
         gen_a64_set_pc_im(dest);
         tcg_gen_exit_tb((intptr_t)tb + n);
-        s->is_jmp = DISAS_TB_JUMP;
+        s->is_jmp = DISAS_NORETURN;
     } else {
         gen_a64_set_pc_im(dest);
         if (s->ss_active) {
@@ -380,7 +380,7 @@ static inline void gen_goto_tb(DisasContext *s, int n, uint64_t dest)
             gen_exception_internal(EXCP_DEBUG);
         } else {
             tcg_gen_lookup_and_goto_ptr(cpu_pc);
-            s->is_jmp = DISAS_TB_JUMP;
+            s->is_jmp = DISAS_NORETURN;
         }
     }
 }
@@ -11305,7 +11305,7 @@ void gen_intermediate_code_a64(CPUState *cs, TranslationBlock *tb)
             assert(num_insns == 1);
             gen_exception(EXCP_UDEF, syn_swstep(dc->ss_same_el, 0, 0),
                           default_exception_el(dc));
-            dc->is_jmp = DISAS_EXC;
+            dc->is_jmp = DISAS_NORETURN;
             break;
         }
 
@@ -11332,21 +11332,25 @@ void gen_intermediate_code_a64(CPUState *cs, TranslationBlock *tb)
         gen_io_end();
     }
 
-    if (unlikely(cs->singlestep_enabled || dc->ss_active)
-        && dc->is_jmp != DISAS_EXC) {
+    if (unlikely(cs->singlestep_enabled || dc->ss_active)) {
         /* Note that this means single stepping WFI doesn't halt the CPU.
          * For conditional branch insns this is harmless unreachable code as
          * gen_goto_tb() has already handled emitting the debug exception
          * (and thus a tb-jump is not possible when singlestepping).
          */
-        assert(dc->is_jmp != DISAS_TB_JUMP);
-        if (dc->is_jmp != DISAS_JUMP) {
+        switch (dc->is_jmp) {
+        default:
             gen_a64_set_pc_im(dc->pc);
-        }
-        if (cs->singlestep_enabled) {
-            gen_exception_internal(EXCP_DEBUG);
-        } else {
-            gen_step_complete_exception(dc);
+            /* fall through */
+        case DISAS_JUMP:
+            if (cs->singlestep_enabled) {
+                gen_exception_internal(EXCP_DEBUG);
+            } else {
+                gen_step_complete_exception(dc);
+            }
+            break;
+        case DISAS_NORETURN:
+            break;
         }
     } else {
         switch (dc->is_jmp) {
@@ -11356,8 +11360,7 @@ void gen_intermediate_code_a64(CPUState *cs, TranslationBlock *tb)
         case DISAS_JUMP:
             tcg_gen_lookup_and_goto_ptr(cpu_pc);
             break;
-        case DISAS_TB_JUMP:
-        case DISAS_EXC:
+        case DISAS_NORETURN:
         case DISAS_SWI:
             break;
         case DISAS_WFE:
diff --git a/target/arm/translate.c b/target/arm/translate.c
index d1a5f56998..699e810157 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -297,7 +297,7 @@ static void gen_step_complete_exception(DisasContext *s)
     gen_ss_advance(s);
     gen_exception(EXCP_UDEF, syn_swstep(s->ss_same_el, 1, s->is_ldex),
                   default_exception_el(s));
-    s->is_jmp = DISAS_EXC;
+    s->is_jmp = DISAS_NORETURN;
 }
 
 static void gen_singlestep_exception(DisasContext *s)
@@ -1184,7 +1184,7 @@ static void gen_exception_internal_insn(DisasContext *s, int offset, int excp)
     gen_set_condexec(s);
     gen_set_pc_im(s, s->pc - offset);
     gen_exception_internal(excp);
-    s->is_jmp = DISAS_EXC;
+    s->is_jmp = DISAS_NORETURN;
 }
 
 static void gen_exception_insn(DisasContext *s, int offset, int excp,
@@ -1193,7 +1193,7 @@ static void gen_exception_insn(DisasContext *s, int offset, int excp,
     gen_set_condexec(s);
     gen_set_pc_im(s, s->pc - offset);
     gen_exception(excp, syn, target_el);
-    s->is_jmp = DISAS_EXC;
+    s->is_jmp = DISAS_NORETURN;
 }
 
 /* Force a TB lookup after an instruction that changes the CPU state.  */
@@ -11944,7 +11944,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
             /* We always get here via a jump, so know we are not in a
                conditional execution block.  */
             gen_exception_internal(EXCP_KERNEL_TRAP);
-            dc->is_jmp = DISAS_EXC;
+            dc->is_jmp = DISAS_NORETURN;
             break;
         }
 #endif
@@ -12089,6 +12089,9 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
         default:
             /* FIXME: Single stepping a WFI insn will not halt the CPU. */
             gen_singlestep_exception(dc);
+            break;
+        case DISAS_NORETURN:
+            break;
         }
     } else {
         /* While branches must always occur at the end of an IT block,
@@ -12113,8 +12116,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
             /* indicate that the hash table must be used to find the next TB */
             tcg_gen_exit_tb(0);
             break;
-        case DISAS_TB_JUMP:
-        case DISAS_EXC:
+        case DISAS_NORETURN:
             /* nothing more to generate */
             break;
         case DISAS_WFI:
-- 
2.13.3
