Received: from eggs.gnu.org ([2001:4830:134:3::10]:33993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d2vIq-0008Ra-9r
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 03:54:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d2vIo-0000pG-SB
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 03:54:28 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 25 Apr 2017 03:53:56 -0400
Message-Id: <1493106839-10438-11-git-send-email-cota@braap.org>
In-Reply-To: <1493106839-10438-1-git-send-email-cota@braap.org>
References: <1493106839-10438-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 10/13] target/i386: introduce gen_jr()
 helper to jump to register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, qemu-arm@nongnu.org, alex.bennee@linaro.org, Pranith Kumar <bobby.prani+qemu@gmail.com>

This helper will be used by subsequent commits.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/i386/translate.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 1d1372f..445082b 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -141,6 +141,7 @@ typedef struct DisasContext {
 } DisasContext;
 
 static void gen_eob(DisasContext *s);
+static void gen_jr(DisasContext *s, TCGv dest);
 static void gen_jmp(DisasContext *s, target_ulong eip);
 static void gen_jmp_tb(DisasContext *s, target_ulong eip, int tb_num);
 static void gen_op(DisasContext *s1, int op, TCGMemOp ot, int d);
@@ -2509,7 +2510,8 @@ static void gen_bnd_jmp(DisasContext *s)
    If INHIBIT, set HF_INHIBIT_IRQ_MASK if it isn't already set.
    If RECHECK_TF, emit a rechecking helper for #DB, ignoring the state of
    S->TF.  This is used by the syscall/sysret insns.  */
-static void gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf)
+static void
+gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf, TCGv jr)
 {
     gen_update_cc_op(s);
 
@@ -2530,6 +2532,16 @@ static void gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf)
         tcg_gen_exit_tb(0);
     } else if (s->tf) {
         gen_helper_single_step(cpu_env);
+    } else if (jr) {
+        TCGv vaddr = tcg_temp_new();
+        TCGv_ptr ptr = tcg_temp_new_ptr();
+
+        tcg_gen_ld_tl(vaddr, cpu_env, offsetof(CPUX86State, segs[R_CS].base));
+        tcg_gen_add_tl(vaddr, vaddr, jr);
+        gen_helper_lookup_tb_ptr(ptr, cpu_env, vaddr);
+        tcg_temp_free(vaddr);
+        tcg_gen_goto_ptr(ptr);
+        tcg_temp_free_ptr(ptr);
     } else {
         tcg_gen_exit_tb(0);
     }
@@ -2540,13 +2552,19 @@ static void gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf)
    If INHIBIT, set HF_INHIBIT_IRQ_MASK if it isn't already set.  */
 static void gen_eob_inhibit_irq(DisasContext *s, bool inhibit)
 {
-    gen_eob_worker(s, inhibit, false);
+    gen_eob_worker(s, inhibit, false, NULL);
 }
 
 /* End of block, resetting the inhibit irq flag.  */
 static void gen_eob(DisasContext *s)
 {
-    gen_eob_worker(s, false, false);
+    gen_eob_worker(s, false, false, NULL);
+}
+
+/* Jump to register */
+static void gen_jr(DisasContext *s, TCGv dest)
+{
+    gen_eob_worker(s, false, false, dest);
 }
 
 /* generate a jump to eip. No segment change must happen before as a
@@ -7131,7 +7149,7 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
         /* TF handling for the syscall insn is different. The TF bit is  checked
            after the syscall insn completes. This allows #DB to not be
            generated after one has entered CPL0 if TF is set in FMASK.  */
-        gen_eob_worker(s, false, true);
+        gen_eob_worker(s, false, true, NULL);
         break;
     case 0x107: /* sysret */
         if (!s->pe) {
@@ -7146,7 +7164,7 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
                checked after the sysret insn completes. This allows #DB to be
                generated "as if" the syscall insn in userspace has just
                completed.  */
-            gen_eob_worker(s, false, true);
+            gen_eob_worker(s, false, true, NULL);
         }
         break;
 #endif
-- 
2.7.4
