Received: from eggs.gnu.org ([2001:4830:134:3::10]:37438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d3a7b-0007wt-JI
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 23:29:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d3a7a-0001x5-Bm
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 23:29:35 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 26 Apr 2017 23:29:21 -0400
Message-Id: <1493263764-18657-9-git-send-email-cota@braap.org>
In-Reply-To: <1493263764-18657-1-git-send-email-cota@braap.org>
References: <1493263764-18657-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v4 08/11] target/i386: introduce gen_jr helper
 to generate lookup_and_goto_ptr
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

This helper will be used by subsequent changes.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/i386/translate.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 1d1372f..f0e48dc 100644
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
+do_gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf, TCGv jr)
 {
     gen_update_cc_op(s);
 
@@ -2530,12 +2532,27 @@ static void gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf)
         tcg_gen_exit_tb(0);
     } else if (s->tf) {
         gen_helper_single_step(cpu_env);
+    } else if (!TCGV_IS_UNUSED(jr)) {
+        TCGv vaddr = tcg_temp_new();
+
+        tcg_gen_add_tl(vaddr, jr, cpu_seg_base[R_CS]);
+        tcg_gen_lookup_and_goto_ptr(vaddr);
+        tcg_temp_free(vaddr);
     } else {
         tcg_gen_exit_tb(0);
     }
     s->is_jmp = DISAS_TB_JUMP;
 }
 
+static inline void
+gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf)
+{
+    TCGv unused;
+
+    TCGV_UNUSED(unused);
+    do_gen_eob_worker(s, inhibit, recheck_tf, unused);
+}
+
 /* End of block.
    If INHIBIT, set HF_INHIBIT_IRQ_MASK if it isn't already set.  */
 static void gen_eob_inhibit_irq(DisasContext *s, bool inhibit)
@@ -2549,6 +2566,12 @@ static void gen_eob(DisasContext *s)
     gen_eob_worker(s, false, false);
 }
 
+/* Jump to register */
+static void gen_jr(DisasContext *s, TCGv dest)
+{
+    do_gen_eob_worker(s, false, false, dest);
+}
+
 /* generate a jump to eip. No segment change must happen before as a
    direct call to the next block may occur */
 static void gen_jmp_tb(DisasContext *s, target_ulong eip, int tb_num)
-- 
2.7.4
