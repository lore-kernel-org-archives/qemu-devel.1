Received: from eggs.gnu.org ([2001:4830:134:3::10]:37969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5Da-00085i-0k
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5DW-0007G5-2a
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cK5DV-0007FS-Oi
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:38 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 22 Dec 2016 16:22:59 +0100
Message-Id: <20161222152300.32395-25-pbonzini@redhat.com>
In-Reply-To: <20161222152300.32395-1-pbonzini@redhat.com>
References: <20161222152300.32395-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 24/25] target-i386: Fix eflags.TF/#DB handling
 of syscall/sysret insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Doug Evans <dje@google.com>

From: Doug Evans <dje@google.com>

The syscall and sysret instructions behave a bit differently:
TF is checked after the instruction completes.
This allows the o/s to disable #DB at a syscall by adding TF to FMASK.
And then when the sysret is executed the #DB is taken "as if" the
syscall insn just completed.

Signed-off-by: Doug Evans <dje@google.com>
Message-Id: <94eb2c0bfa1c6a9fec0543057483@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/bpt_helper.c |  7 +++++++
 target/i386/helper.h     |  1 +
 target/i386/translate.c  | 29 ++++++++++++++++++++++++-----
 3 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/target/i386/bpt_helper.c b/target/i386/bpt_helper.c
index 6fd7fe0..b3efdc7 100644
--- a/target/i386/bpt_helper.c
+++ b/target/i386/bpt_helper.c
@@ -244,6 +244,13 @@ void helper_single_step(CPUX86State *env)
     raise_exception(env, EXCP01_DB);
 }
 
+void helper_rechecking_single_step(CPUX86State *env)
+{
+    if ((env->eflags & TF_MASK) != 0) {
+        helper_single_step(env);
+    }
+}
+
 void helper_set_dr(CPUX86State *env, int reg, target_ulong t0)
 {
 #ifndef CONFIG_USER_ONLY
diff --git a/target/i386/helper.h b/target/i386/helper.h
index 4e859eb..bd9b2cf 100644
--- a/target/i386/helper.h
+++ b/target/i386/helper.h
@@ -79,6 +79,7 @@ DEF_HELPER_2(cmpxchg16b_unlocked, void, env, tl)
 DEF_HELPER_2(cmpxchg16b, void, env, tl)
 #endif
 DEF_HELPER_1(single_step, void, env)
+DEF_HELPER_1(rechecking_single_step, void, env)
 DEF_HELPER_1(cpuid, void, env)
 DEF_HELPER_1(rdtsc, void, env)
 DEF_HELPER_1(rdtscp, void, env)
diff --git a/target/i386/translate.c b/target/i386/translate.c
index 324103c..59e11fc 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -2500,8 +2500,10 @@ static void gen_bnd_jmp(DisasContext *s)
 }
 
 /* Generate an end of block. Trace exception is also generated if needed.
-   If IIM, set HF_INHIBIT_IRQ_MASK if it isn't already set.  */
-static void gen_eob_inhibit_irq(DisasContext *s, bool inhibit)
+   If INHIBIT, set HF_INHIBIT_IRQ_MASK if it isn't already set.
+   If RECHECK_TF, emit a rechecking helper for #DB, ignoring the state of
+   S->TF.  This is used by the syscall/sysret insns.  */
+static void gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf)
 {
     gen_update_cc_op(s);
 
@@ -2517,6 +2519,9 @@ static void gen_eob_inhibit_irq(DisasContext *s, bool inhibit)
     }
     if (s->singlestep_enabled) {
         gen_helper_debug(cpu_env);
+    } else if (recheck_tf) {
+        gen_helper_rechecking_single_step(cpu_env);
+        tcg_gen_exit_tb(0);
     } else if (s->tf) {
         gen_helper_single_step(cpu_env);
     } else {
@@ -2525,10 +2530,17 @@ static void gen_eob_inhibit_irq(DisasContext *s, bool inhibit)
     s->is_jmp = DISAS_TB_JUMP;
 }
 
+/* End of block.
+   If INHIBIT, set HF_INHIBIT_IRQ_MASK if it isn't already set.  */
+static void gen_eob_inhibit_irq(DisasContext *s, bool inhibit)
+{
+    gen_eob_worker(s, inhibit, false);
+}
+
 /* End of block, resetting the inhibit irq flag.  */
 static void gen_eob(DisasContext *s)
 {
-    gen_eob_inhibit_irq(s, false);
+    gen_eob_worker(s, false, false);
 }
 
 /* generate a jump to eip. No segment change must happen before as a
@@ -6423,7 +6435,10 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
                                       tcg_const_i32(s->pc - s->cs_base));
             set_cc_op(s, CC_OP_EFLAGS);
         }
-        gen_eob(s);
+        /* TF handling for the syscall insn is different. The TF bit is checked
+           after the syscall insn completes. This allows #DB to not be
+           generated after one has entered CPL0 if TF is set in FMASK.  */
+        gen_eob_worker(s, false, true);
         break;
     case 0xe8: /* call im */
         {
@@ -7115,7 +7130,11 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
             if (s->lma) {
                 set_cc_op(s, CC_OP_EFLAGS);
             }
-            gen_eob(s);
+            /* TF handling for the sysret insn is different. The TF bit is
+               checked after the sysret insn completes. This allows #DB to be
+               generated "as if" the syscall insn in userspace has just
+               completed.  */
+            gen_eob_worker(s, false, true);
         }
         break;
 #endif
-- 
2.9.3
