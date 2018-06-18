Received: from eggs.gnu.org ([2001:4830:134:3::10]:57321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fUz5O-0003Oz-1D
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:41:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fUz5N-0004fl-04
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:41:06 -0400
Received: from mail-pl0-x231.google.com ([2607:f8b0:400e:c01::231]:46992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fUz5M-0004ez-Pw
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:41:04 -0400
Received: by mail-pl0-x231.google.com with SMTP id 30-v6so9485198pld.13
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 11:41:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Jun 2018 08:40:31 -1000
Message-Id: <20180618184046.6270-8-richard.henderson@linaro.org>
In-Reply-To: <20180618184046.6270-1-richard.henderson@linaro.org>
References: <20180618184046.6270-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 07/22] target/openrisc: Form the spr index
 from tcg
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

Rather than pass base+offset to the helper, pass the full index.
In most cases the base is r0 and optimization yields a constant.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
index b284064381..a8d287d6ef 100644
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
@@ -201,13 +199,12 @@ void HELPER(mtspr)(CPUOpenRISCState *env,
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
index 6a7eb4a3e8..f19f0d257b 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -926,9 +926,10 @@ static bool trans_l_mfspr(DisasContext *dc, arg_l_mfspr *a, uint32_t insn)
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
@@ -940,7 +941,7 @@ static bool trans_l_mtspr(DisasContext *dc, arg_l_mtspr *a, uint32_t insn)
     if (is_user(dc)) {
         gen_illegal_exception(dc);
     } else {
-        TCGv_i32 ti;
+        TCGv spr;
 
         /* For SR, we will need to exit the TB to recognize the new
          * exception state.  For NPC, in theory this counts as a branch
@@ -953,9 +954,10 @@ static bool trans_l_mtspr(DisasContext *dc, arg_l_mtspr *a, uint32_t insn)
         tcg_gen_movi_tl(cpu_ppc, dc->base.pc_next);
         tcg_gen_movi_tl(cpu_pc, dc->base.pc_next + 4);
 
-        ti = tcg_const_i32(a->k);
-        gen_helper_mtspr(cpu_env, cpu_R[a->a], cpu_R[a->b], ti);
-        tcg_temp_free_i32(ti);
+        spr = tcg_temp_new();
+        tcg_gen_ori_tl(spr, cpu_R[a->a], a->k);
+        gen_helper_mtspr(cpu_env, spr, cpu_R[a->b]);
+        tcg_temp_free(spr);
 
         /* For PPC, we want the value that was just written and not
            the generic update that we'd get from DISAS_EXIT.  */
-- 
2.17.1
