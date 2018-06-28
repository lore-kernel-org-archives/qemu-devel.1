Received: from eggs.gnu.org ([2001:4830:134:3::10]:39939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYNDo-00050W-RD
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:03:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYNDn-0007qW-Q3
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:03:48 -0400
Received: from mail-pg0-x234.google.com ([2607:f8b0:400e:c05::234]:43008)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fYNDn-0007oe-KA
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:03:47 -0400
Received: by mail-pg0-x234.google.com with SMTP id a14-v6so1794411pgw.10
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 20:03:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 27 Jun 2018 20:03:17 -0700
Message-Id: <20180628030330.15615-11-richard.henderson@linaro.org>
In-Reply-To: <20180628030330.15615-1-richard.henderson@linaro.org>
References: <20180628030330.15615-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 10/23] target/openrisc: Form the spr index
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
2.17.1
