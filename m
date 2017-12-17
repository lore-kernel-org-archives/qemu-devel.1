Received: from eggs.gnu.org ([2001:4830:134:3::10]:43261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eQRpo-0001Ze-D0
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 00:50:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eQRpl-0005Wj-Am
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 00:50:00 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 17 Dec 2017 06:49:53 +0100
Message-Id: <20171217054953.28500-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] target-ppc: optimize cmp translation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgibson@redhat.com, qemu-ppc@nongnu.org

We know that only one bit (in addition to SO) is going to be set in
the condition register, so do two movconds instead of three setconds,
three shifts and two ORs.

For ppc64-linux-user, the code size reduction is around 5% and the
performance improvement slightly less than 10%.  For softmmu, the
improvement is around 5%.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/ppc/translate.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 998fbed848..0e9e6823a3 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -605,27 +605,22 @@ static opc_handler_t invalid_handler = {
 static inline void gen_op_cmp(TCGv arg0, TCGv arg1, int s, int crf)
 {
     TCGv t0 = tcg_temp_new();
-    TCGv_i32 t1 = tcg_temp_new_i32();
-
-    tcg_gen_trunc_tl_i32(cpu_crf[crf], cpu_so);
-
-    tcg_gen_setcond_tl((s ? TCG_COND_LT: TCG_COND_LTU), t0, arg0, arg1);
-    tcg_gen_trunc_tl_i32(t1, t0);
-    tcg_gen_shli_i32(t1, t1, CRF_LT_BIT);
-    tcg_gen_or_i32(cpu_crf[crf], cpu_crf[crf], t1);
+    TCGv t1 = tcg_temp_new();
+    TCGv_i32 t = tcg_temp_new_i32();
 
-    tcg_gen_setcond_tl((s ? TCG_COND_GT: TCG_COND_GTU), t0, arg0, arg1);
-    tcg_gen_trunc_tl_i32(t1, t0);
-    tcg_gen_shli_i32(t1, t1, CRF_GT_BIT);
-    tcg_gen_or_i32(cpu_crf[crf], cpu_crf[crf], t1);
+    tcg_gen_movi_tl(t0, CRF_EQ);
+    tcg_gen_movi_tl(t1, CRF_LT);
+    tcg_gen_movcond_tl((s ? TCG_COND_LT : TCG_COND_LTU), t0, arg0, arg1, t1, t0);
+    tcg_gen_movi_tl(t1, CRF_GT);
+    tcg_gen_movcond_tl((s ? TCG_COND_GT : TCG_COND_GTU), t0, arg0, arg1, t1, t0);
 
-    tcg_gen_setcond_tl(TCG_COND_EQ, t0, arg0, arg1);
-    tcg_gen_trunc_tl_i32(t1, t0);
-    tcg_gen_shli_i32(t1, t1, CRF_EQ_BIT);
-    tcg_gen_or_i32(cpu_crf[crf], cpu_crf[crf], t1);
+    tcg_gen_trunc_tl_i32(t, t0);
+    tcg_gen_trunc_tl_i32(cpu_crf[crf], cpu_so);
+    tcg_gen_or_i32(cpu_crf[crf], cpu_crf[crf], t);
 
     tcg_temp_free(t0);
-    tcg_temp_free_i32(t1);
+    tcg_temp_free(t1);
+    tcg_temp_free_i32(t);
 }
 
 static inline void gen_op_cmpi(TCGv arg0, target_ulong arg1, int s, int crf)
-- 
2.14.3
