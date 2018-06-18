Received: from eggs.gnu.org ([2001:4830:134:3::10]:57297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fUz5K-0003OS-Cj
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:41:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fUz5J-0004aV-CL
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:41:02 -0400
Received: from mail-pf0-x234.google.com ([2607:f8b0:400e:c00::234]:39329)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fUz5J-0004Z2-5N
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:41:01 -0400
Received: by mail-pf0-x234.google.com with SMTP id r11-v6so8605136pfl.6
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 11:41:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Jun 2018 08:40:29 -1000
Message-Id: <20180618184046.6270-6-richard.henderson@linaro.org>
In-Reply-To: <20180618184046.6270-1-richard.henderson@linaro.org>
References: <20180618184046.6270-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 05/22] target/openrisc: Split out is_user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: shorne@gmail.com

This allows us to limit the amount of ifdefs and isolate
the test for usermode.

Reviewed-by: Stafford Horne <shorne@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/translate.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 422f22d7f8..16e69c75fa 100644
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
2.17.1
