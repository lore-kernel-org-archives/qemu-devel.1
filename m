Received: from eggs.gnu.org ([2001:4830:134:3::10]:48686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fa0Tl-00041Q-9I
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:11:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fa0Tj-0007rt-Uo
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:11:01 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:33271)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fa0Tj-0007ri-Oo
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:10:59 -0400
Received: by mail-pg0-x244.google.com with SMTP id e11-v6so7285956pgq.0
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 08:10:59 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Tue,  3 Jul 2018 00:10:06 +0900
Message-Id: <20180702151023.24532-9-shorne@gmail.com>
In-Reply-To: <20180702151023.24532-1-shorne@gmail.com>
References: <20180702151023.24532-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 08/25] target/openrisc: Split out is_user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Development <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, Stafford Horne <shorne@gmail.com>

From: Richard Henderson <richard.henderson@linaro.org>

This allows us to limit the amount of ifdefs and isolate
the test for usermode.

Reviewed-by: Stafford Horne <shorne@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
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
2.17.0
