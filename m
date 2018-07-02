Received: from eggs.gnu.org ([2001:4830:134:3::10]:47329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fZzLj-0002PO-FI
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:58:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fZzLi-00087s-JE
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:58:39 -0400
Received: from mail-pg0-x235.google.com ([2607:f8b0:400e:c05::235]:34258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fZzLi-00087U-Ci
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:58:38 -0400
Received: by mail-pg0-x235.google.com with SMTP id y5-v6so917339pgv.1
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 06:58:38 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Mon,  2 Jul 2018 22:57:51 +0900
Message-Id: <20180702135806.7087-11-shorne@gmail.com>
In-Reply-To: <20180702135806.7087-1-shorne@gmail.com>
References: <20180702135806.7087-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/25] target/openrisc: Form the spr index from
 tcg
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

Rather than pass base+offset to the helper, pass the full index.
In most cases the base is r0 and optimization yields a constant.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 target/openrisc/helper.h     |  4 ++--
 target/openrisc/sys_helper.c |  9 +++------
 target/openrisc/translate.c  | 16 +++++++++-------
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/target/openrisc/helper.h b/target/openrisc/helper.h
index e37dabc77a..9db9bf3963 100644
--- a/target/openrisc/helper.h
+++ b/target/openrisc/helper.h
@@ -56,5 +56,5 @@ FOP_CMP(le)
 DEF_HELPER_FLAGS_1(rfe, 0, void, env)
 
 /* sys */
-DEF_HELPER_FLAGS_4(mtspr, 0, void, env, tl, tl, tl)
-DEF_HELPER_FLAGS_4(mfspr, TCG_CALL_NO_WG, tl, env, tl, tl, tl)
+DEF_HELPER_FLAGS_3(mtspr, 0, void, env, tl, tl)
+DEF_HELPER_FLAGS_3(mfspr, TCG_CALL_NO_WG, tl, env, tl, tl)
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index 2f337363ec..2c959f63f4 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -27,13 +27,11 @@
 
 #define TO_SPR(group, number) (((group) << 11) + (number))
 
-void HELPER(mtspr)(CPUOpenRISCState *env,
-                   target_ulong ra, target_ulong rb, target_ulong offset)
+void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
 {
 #ifndef CONFIG_USER_ONLY
     OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
     CPUState *cs = CPU(cpu);
-    int spr = (ra | offset);
     int idx;
 
     switch (spr) {
@@ -202,13 +200,12 @@ void HELPER(mtspr)(CPUOpenRISCState *env,
 #endif
 }
 
-target_ulong HELPER(mfspr)(CPUOpenRISCState *env,
-                           target_ulong rd, target_ulong ra, uint32_t offset)
+target_ulong HELPER(mfspr)(CPUOpenRISCState *env, target_ulong rd,
+                           target_ulong spr)
 {
 #ifndef CONFIG_USER_ONLY
     OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
     CPUState *cs = CPU(cpu);
-    int spr = (ra | offset);
     int idx;
 
     switch (spr) {
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 59605aacca..64b5e84630 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -865,9 +865,10 @@ static bool trans_l_mfspr(DisasContext *dc, arg_l_mfspr *a, uint32_t insn)
     if (is_user(dc)) {
         gen_illegal_exception(dc);
     } else {
-        TCGv_i32 ti = tcg_const_i32(a->k);
-        gen_helper_mfspr(cpu_R[a->d], cpu_env, cpu_R[a->d], cpu_R[a->a], ti);
-        tcg_temp_free_i32(ti);
+        TCGv spr = tcg_temp_new();
+        tcg_gen_ori_tl(spr, cpu_R[a->a], a->k);
+        gen_helper_mfspr(cpu_R[a->d], cpu_env, cpu_R[a->d], spr);
+        tcg_temp_free(spr);
     }
     return true;
 }
@@ -877,7 +878,7 @@ static bool trans_l_mtspr(DisasContext *dc, arg_l_mtspr *a, uint32_t insn)
     if (is_user(dc)) {
         gen_illegal_exception(dc);
     } else {
-        TCGv_i32 ti;
+        TCGv spr;
 
         /* For SR, we will need to exit the TB to recognize the new
          * exception state.  For NPC, in theory this counts as a branch
@@ -892,9 +893,10 @@ static bool trans_l_mtspr(DisasContext *dc, arg_l_mtspr *a, uint32_t insn)
         }
         dc->base.is_jmp = DISAS_EXIT;
 
-        ti = tcg_const_i32(a->k);
-        gen_helper_mtspr(cpu_env, cpu_R[a->a], cpu_R[a->b], ti);
-        tcg_temp_free_i32(ti);
+        spr = tcg_temp_new();
+        tcg_gen_ori_tl(spr, cpu_R[a->a], a->k);
+        gen_helper_mtspr(cpu_env, spr, cpu_R[a->b]);
+        tcg_temp_free(spr);
     }
     return true;
 }
-- 
2.17.0
