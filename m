Received: from eggs.gnu.org ([2001:4830:134:3::10]:57711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fMwQU-0008QE-8f
	for qemu-devel@nongnu.org; Sun, 27 May 2018 10:13:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fMwQT-0004Nr-AA
	for qemu-devel@nongnu.org; Sun, 27 May 2018 10:13:38 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:34533)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fMwQT-0004Nk-4I
	for qemu-devel@nongnu.org; Sun, 27 May 2018 10:13:37 -0400
Received: by mail-pl0-x243.google.com with SMTP id ay10-v6so5747298plb.1
	for <qemu-devel@nongnu.org>; Sun, 27 May 2018 07:13:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 27 May 2018 09:13:09 -0500
Message-Id: <20180527141324.11937-6-richard.henderson@linaro.org>
In-Reply-To: <20180527141324.11937-1-richard.henderson@linaro.org>
References: <20180527141324.11937-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 05/20] target/openrisc: Split out is_user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>

This allows us to limit the amount of ifdefs and isolate
the test for usermode.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/translate.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index a8afb9a562..61e6deef69 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -54,6 +54,15 @@ typedef struct DisasContext {
     target_ulong jmp_pc_imm;
 } DisasContext;
 
+static inline bool is_user(DisasContext *dc)
+{
+#ifdef CONFIG_USER_ONLY
+    return true;
+#else
+    return dc->mem_idx == MMU_USER_IDX;
+#endif
+}
+
 /* Include the auto-generated decoder.  */
 #include "decode.inc.c"
 
@@ -914,17 +923,13 @@ static bool trans_l_mfspr(DisasContext *dc, arg_l_mfspr *a, uint32_t insn)
     LOG_DIS("l.mfspr r%d, r%d, %d\n", a->d, a->a, a->k);
     check_r0_write(a->d);
 
-#ifdef CONFIG_USER_ONLY
-    gen_illegal_exception(dc);
-#else
-    if (dc->mem_idx == MMU_USER_IDX) {
+    if (is_user(dc)) {
         gen_illegal_exception(dc);
     } else {
         TCGv_i32 ti = tcg_const_i32(a->k);
         gen_helper_mfspr(cpu_R[a->d], cpu_env, cpu_R[a->d], cpu_R[a->a], ti);
         tcg_temp_free_i32(ti);
     }
-#endif
     return true;
 }
 
@@ -932,17 +937,13 @@ static bool trans_l_mtspr(DisasContext *dc, arg_l_mtspr *a, uint32_t insn)
 {
     LOG_DIS("l.mtspr r%d, r%d, %d\n", a->a, a->b, a->k);
 
-#ifdef CONFIG_USER_ONLY
-    gen_illegal_exception(dc);
-#else
-    if (dc->mem_idx == MMU_USER_IDX) {
+    if (is_user(dc)) {
         gen_illegal_exception(dc);
     } else {
         TCGv_i32 ti = tcg_const_i32(a->k);
         gen_helper_mtspr(cpu_env, cpu_R[a->a], cpu_R[a->b], ti);
         tcg_temp_free_i32(ti);
     }
-#endif
     return true;
 }
 
@@ -1204,16 +1205,12 @@ static bool trans_l_rfe(DisasContext *dc, arg_l_rfe *a, uint32_t insn)
 {
     LOG_DIS("l.rfe\n");
 
-#ifdef CONFIG_USER_ONLY
-    gen_illegal_exception(dc);
-#else
-    if (dc->mem_idx == MMU_USER_IDX) {
+    if (is_user(dc)) {
         gen_illegal_exception(dc);
     } else {
         gen_helper_rfe(cpu_env);
         dc->base.is_jmp = DISAS_EXIT;
     }
-#endif
     return true;
 }
 
-- 
2.17.0
