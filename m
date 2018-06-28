Received: from eggs.gnu.org ([2001:4830:134:3::10]:39942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYNDo-00050Y-S6
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:03:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYNDk-0007l6-TF
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:03:48 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:45138)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fYNDk-0007jM-Mf
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:03:44 -0400
Received: by mail-pf0-x242.google.com with SMTP id a22-v6so1883172pfo.12
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 20:03:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 27 Jun 2018 20:03:15 -0700
Message-Id: <20180628030330.15615-9-richard.henderson@linaro.org>
In-Reply-To: <20180628030330.15615-1-richard.henderson@linaro.org>
References: <20180628030330.15615-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 08/23] target/openrisc: Split out is_user
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
index a618d39242..db149986af 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -50,6 +50,15 @@ typedef struct DisasContext {
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
 
@@ -853,33 +862,25 @@ static bool trans_l_mfspr(DisasContext *dc, arg_l_mfspr *a, uint32_t insn)
 {
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
 
 static bool trans_l_mtspr(DisasContext *dc, arg_l_mtspr *a, uint32_t insn)
 {
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
 
@@ -1104,16 +1105,12 @@ static bool trans_l_csync(DisasContext *dc, arg_l_csync *a, uint32_t insn)
 
 static bool trans_l_rfe(DisasContext *dc, arg_l_rfe *a, uint32_t insn)
 {
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
