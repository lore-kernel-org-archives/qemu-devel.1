Received: from eggs.gnu.org ([2001:4830:134:3::10]:41616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpcqU-0008PF-2L
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpcqK-0001bI-5d
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:30 -0400
Received: from mail-pf0-x22a.google.com ([2607:f8b0:400e:c00::22a]:35362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dpcqJ-0001X0-T7
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:20 -0400
Received: by mail-pf0-x22a.google.com with SMTP id g13so13482162pfm.2
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 09:06:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  6 Sep 2017 09:05:43 -0700
Message-Id: <20170906160612.22769-4-richard.henderson@linaro.org>
In-Reply-To: <20170906160612.22769-1-richard.henderson@linaro.org>
References: <20170906160612.22769-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 03/32] target/arm: Use DISAS_NORETURN
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
index cb44632d16..881d3c0cbb 100644
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
@@ -11326,7 +11326,7 @@ void gen_intermediate_code_a64(CPUState *cs, TranslationBlock *tb)
             assert(num_insns == 1);
             gen_exception(EXCP_UDEF, syn_swstep(dc->ss_same_el, 0, 0),
                           default_exception_el(dc));
-            dc->is_jmp = DISAS_EXC;
+            dc->is_jmp = DISAS_NORETURN;
             break;
         }
 
@@ -11353,21 +11353,25 @@ void gen_intermediate_code_a64(CPUState *cs, TranslationBlock *tb)
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
@@ -11377,8 +11381,7 @@ void gen_intermediate_code_a64(CPUState *cs, TranslationBlock *tb)
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
index e52a6d7622..b14329dc27 100644
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
@@ -11974,7 +11974,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
             /* We always get here via a jump, so know we are not in a
                conditional execution block.  */
             gen_exception_internal(EXCP_KERNEL_TRAP);
-            dc->is_jmp = DISAS_EXC;
+            dc->is_jmp = DISAS_NORETURN;
             break;
         }
 #endif
@@ -12119,6 +12119,9 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
         default:
             /* FIXME: Single stepping a WFI insn will not halt the CPU. */
             gen_singlestep_exception(dc);
+            break;
+        case DISAS_NORETURN:
+            break;
         }
     } else {
         /* While branches must always occur at the end of an IT block,
@@ -12143,8 +12146,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
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
2.13.5
