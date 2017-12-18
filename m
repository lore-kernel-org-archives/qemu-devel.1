Received: from eggs.gnu.org ([2001:4830:134:3::10]:44330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzFL-0002da-61
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:30:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzFJ-0004h5-7n
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:30:35 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:36814)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQzFI-0004g3-Ds
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:30:32 -0500
Received: by mail-pf0-x241.google.com with SMTP id p84so9958320pfd.3
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:30:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:30:17 -0800
Message-Id: <20171218173022.18418-5-richard.henderson@linaro.org>
In-Reply-To: <20171218173022.18418-1-richard.henderson@linaro.org>
References: <20171218173022.18418-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 4/9] target/arm: Use pointers in neon tbl helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

Rather than passing a regno to the helper, pass pointers to the
vector register directly.  This eliminates the need to pass in
the environment pointer and reduces the number of places that
directly access env->vfp.regs[].

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h    |  2 +-
 target/arm/op_helper.c | 17 +++++++----------
 target/arm/translate.c |  8 ++++----
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index d39ca11cbd..206e39a207 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -201,7 +201,7 @@ DEF_HELPER_FLAGS_2(rsqrte_f32, TCG_CALL_NO_RWG, f32, f32, ptr)
 DEF_HELPER_FLAGS_2(rsqrte_f64, TCG_CALL_NO_RWG, f64, f64, ptr)
 DEF_HELPER_2(recpe_u32, i32, i32, ptr)
 DEF_HELPER_FLAGS_2(rsqrte_u32, TCG_CALL_NO_RWG, i32, i32, ptr)
-DEF_HELPER_5(neon_tbl, i32, env, i32, i32, i32, i32)
+DEF_HELPER_FLAGS_4(neon_tbl, TCG_CALL_NO_RWG, i32, i32, i32, ptr, i32)
 
 DEF_HELPER_3(shl_cc, i32, env, i32, i32)
 DEF_HELPER_3(shr_cc, i32, env, i32, i32)
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index c2bb4f3a43..df3aab170b 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -54,20 +54,17 @@ static int exception_target_el(CPUARMState *env)
     return target_el;
 }
 
-uint32_t HELPER(neon_tbl)(CPUARMState *env, uint32_t ireg, uint32_t def,
-                          uint32_t rn, uint32_t maxindex)
+uint32_t HELPER(neon_tbl)(uint32_t ireg, uint32_t def, void *vn,
+                          uint32_t maxindex)
 {
-    uint32_t val;
-    uint32_t tmp;
-    int index;
-    int shift;
-    uint64_t *table;
-    table = (uint64_t *)&env->vfp.regs[rn];
+    uint32_t val, shift;
+    uint64_t *table = vn;
+
     val = 0;
     for (shift = 0; shift < 32; shift += 8) {
-        index = (ireg >> shift) & 0xff;
+        uint32_t index = (ireg >> shift) & 0xff;
         if (index < maxindex) {
-            tmp = (table[index >> 3] >> ((index & 7) << 3)) & 0xff;
+            uint32_t tmp = (table[index >> 3] >> ((index & 7) << 3)) & 0xff;
             val |= tmp << shift;
         } else {
             val |= def & (0xff << shift);
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 68e928640f..55afd29b21 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7623,9 +7623,9 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     tcg_gen_movi_i32(tmp, 0);
                 }
                 tmp2 = neon_load_reg(rm, 0);
-                tmp4 = tcg_const_i32(rn);
+                ptr1 = vfp_reg_ptr(true, rn);
                 tmp5 = tcg_const_i32(n);
-                gen_helper_neon_tbl(tmp2, cpu_env, tmp2, tmp, tmp4, tmp5);
+                gen_helper_neon_tbl(tmp2, tmp2, tmp, ptr1, tmp5);
                 tcg_temp_free_i32(tmp);
                 if (insn & (1 << 6)) {
                     tmp = neon_load_reg(rd, 1);
@@ -7634,9 +7634,9 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     tcg_gen_movi_i32(tmp, 0);
                 }
                 tmp3 = neon_load_reg(rm, 1);
-                gen_helper_neon_tbl(tmp3, cpu_env, tmp3, tmp, tmp4, tmp5);
+                gen_helper_neon_tbl(tmp3, tmp3, tmp, ptr1, tmp5);
                 tcg_temp_free_i32(tmp5);
-                tcg_temp_free_i32(tmp4);
+                tcg_temp_free_ptr(ptr1);
                 neon_store_reg(rd, 0, tmp2);
                 neon_store_reg(rd, 1, tmp3);
                 tcg_temp_free_i32(tmp);
-- 
2.14.3
