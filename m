Received: from eggs.gnu.org ([2001:4830:134:3::10]:38357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWJbz-0004Uo-EF
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWJby-0003WP-1F
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:43 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:34643)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dWJbx-0003Ui-Pc
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:41 -0400
Received: by mail-pf0-x242.google.com with SMTP id c24so13736182pfe.1
	for <qemu-devel@nongnu.org>; Sat, 15 Jul 2017 02:43:41 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 14 Jul 2017 23:42:34 -1000
Message-Id: <20170715094243.28371-26-rth@twiddle.net>
In-Reply-To: <20170715094243.28371-1-rth@twiddle.net>
References: <20170715094243.28371-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v14 25/34] target/arm: [tcg,
 a64] Port to translate_insn
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

Incrementally paves the way towards using the generic instruction translation
loop.

Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
Message-Id: <150002510079.22386.10164419868911710218.stgit@frigg.lan>
[rth: Adjust for translate_insn interface change.]
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/translate-a64.c | 71 ++++++++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 28 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 1541bf0..a92a3ec 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11244,6 +11244,9 @@ static int aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->is_ldex = false;
     dc->ss_same_el = (arm_debug_target_el(env) == dc->current_el);
 
+    dc->next_page_start =
+        (dc->base.pc_first & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
+
     init_tmp_a64_array(dc);
 
     return max_insns;
@@ -11281,12 +11284,43 @@ static bool aarch64_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
     return true;
 }
 
+static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
+{
+    DisasContext *dc = container_of(dcbase, DisasContext, base);
+    CPUARMState *env = cpu->env_ptr;
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
+    } else {
+        disas_a64_insn(env, dc);
+    }
+
+    if (dc->base.is_jmp == DISAS_NEXT) {
+        if (dc->ss_active || dc->pc >= dc->next_page_start) {
+            dc->base.is_jmp = DISAS_TOO_MANY;
+        }
+    }
+
+    dc->base.pc_next = dc->pc;
+}
+
 void gen_intermediate_code_a64(DisasContextBase *dcbase, CPUState *cs,
                                TranslationBlock *tb)
 {
-    CPUARMState *env = cs->env_ptr;
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-    target_ulong next_page_start;
     int max_insns;
 
     dc->base.tb = tb;
@@ -11296,7 +11330,6 @@ void gen_intermediate_code_a64(DisasContextBase *dcbase, CPUState *cs,
     dc->base.num_insns = 0;
     dc->base.singlestep_enabled = cs->singlestep_enabled;
 
-    next_page_start = (dc->base.pc_first & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
     max_insns = dc->base.tb->cflags & CF_COUNT_MASK;
     if (max_insns == 0) {
         max_insns = CF_COUNT_MASK;
@@ -11332,42 +11365,24 @@ void gen_intermediate_code_a64(DisasContextBase *dcbase, CPUState *cs,
             gen_io_start();
         }
 
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
-        disas_a64_insn(env, dc);
+        aarch64_tr_translate_insn(&dc->base, cs);
 
         if (tcg_check_temp_count()) {
             fprintf(stderr, "TCG temporary leak before "TARGET_FMT_lx"\n",
                     dc->pc);
         }
 
+        if (!dc->base.is_jmp && (tcg_op_buf_full() || cs->singlestep_enabled ||
+                            singlestep || dc->base.num_insns >= max_insns)) {
+            dc->base.is_jmp = DISAS_TOO_MANY;
+        }
+
         /* Translation stops when a conditional branch is encountered.
          * Otherwise the subsequent code could get translated several times.
          * Also stop translation when a page boundary is reached.  This
          * ensures prefetch aborts occur at the right place.
          */
-    } while (!dc->base.is_jmp && !tcg_op_buf_full() &&
-             !cs->singlestep_enabled &&
-             !singlestep &&
-             !dc->ss_active &&
-             dc->pc < next_page_start &&
-             dc->base.num_insns < max_insns);
+    } while (!dc->base.is_jmp);
 
     if (dc->base.tb->cflags & CF_LAST_IO) {
         gen_io_end();
-- 
2.9.4
