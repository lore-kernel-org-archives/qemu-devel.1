Received: from eggs.gnu.org ([2001:4830:134:3::10]:59470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dRlTi-0001ke-AR
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 16:28:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dRlTh-0001HF-Av
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 16:28:22 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:41554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dRlTh-0001GK-4B
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 16:28:21 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Sun,  2 Jul 2017 22:28:14 +0200
Message-Id: <20170702202814.27793-6-aurelien@aurel32.net>
In-Reply-To: <20170702202814.27793-1-aurelien@aurel32.net>
References: <20170702202814.27793-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH v2 5/5] target/sh4: return result of fcmp using
 TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Bruno Haible <bruno@clisp.org>, Aurelien Jarno <aurelien@aurel32.net>

Since that the T bit of the SR register is mapped using a TGC global,
it's better to return the value through TCG than writing it directly. It
allows to declare the helpers with the flag TCG_CALL_NO_WG.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/helper.h    |  8 ++++----
 target/sh4/op_helper.c | 16 ++++++++--------
 target/sh4/translate.c | 10 ++++++----
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/target/sh4/helper.h b/target/sh4/helper.h
index d2398922dd..767a6d5209 100644
--- a/target/sh4/helper.h
+++ b/target/sh4/helper.h
@@ -21,10 +21,10 @@ DEF_HELPER_FLAGS_3(fadd_DT, TCG_CALL_NO_WG, f64, env, f64, f64)
 DEF_HELPER_FLAGS_2(fcnvsd_FT_DT, TCG_CALL_NO_WG, f64, env, f32)
 DEF_HELPER_FLAGS_2(fcnvds_DT_FT, TCG_CALL_NO_WG, f32, env, f64)
 
-DEF_HELPER_3(fcmp_eq_FT, void, env, f32, f32)
-DEF_HELPER_3(fcmp_eq_DT, void, env, f64, f64)
-DEF_HELPER_3(fcmp_gt_FT, void, env, f32, f32)
-DEF_HELPER_3(fcmp_gt_DT, void, env, f64, f64)
+DEF_HELPER_FLAGS_3(fcmp_eq_FT, TCG_CALL_NO_WG, i32, env, f32, f32)
+DEF_HELPER_FLAGS_3(fcmp_eq_DT, TCG_CALL_NO_WG, i32, env, f64, f64)
+DEF_HELPER_FLAGS_3(fcmp_gt_FT, TCG_CALL_NO_WG, i32, env, f32, f32)
+DEF_HELPER_FLAGS_3(fcmp_gt_DT, TCG_CALL_NO_WG, i32, env, f64, f64)
 DEF_HELPER_FLAGS_3(fdiv_FT, TCG_CALL_NO_WG, f32, env, f32, f32)
 DEF_HELPER_FLAGS_3(fdiv_DT, TCG_CALL_NO_WG, f64, env, f64, f64)
 DEF_HELPER_FLAGS_2(float_FT, TCG_CALL_NO_WG, f32, env, i32)
diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index 64206cf803..c3d19b1f61 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -268,44 +268,44 @@ float64 helper_fadd_DT(CPUSH4State *env, float64 t0, float64 t1)
     return t0;
 }
 
-void helper_fcmp_eq_FT(CPUSH4State *env, float32 t0, float32 t1)
+uint32_t helper_fcmp_eq_FT(CPUSH4State *env, float32 t0, float32 t1)
 {
     int relation;
 
     set_float_exception_flags(0, &env->fp_status);
     relation = float32_compare(t0, t1, &env->fp_status);
     update_fpscr(env, GETPC());
-    env->sr_t = (relation == float_relation_equal);
+    return relation == float_relation_equal;
 }
 
-void helper_fcmp_eq_DT(CPUSH4State *env, float64 t0, float64 t1)
+uint32_t helper_fcmp_eq_DT(CPUSH4State *env, float64 t0, float64 t1)
 {
     int relation;
 
     set_float_exception_flags(0, &env->fp_status);
     relation = float64_compare(t0, t1, &env->fp_status);
     update_fpscr(env, GETPC());
-    env->sr_t = (relation == float_relation_equal);
+    return relation == float_relation_equal;
 }
 
-void helper_fcmp_gt_FT(CPUSH4State *env, float32 t0, float32 t1)
+uint32_t helper_fcmp_gt_FT(CPUSH4State *env, float32 t0, float32 t1)
 {
     int relation;
 
     set_float_exception_flags(0, &env->fp_status);
     relation = float32_compare(t0, t1, &env->fp_status);
     update_fpscr(env, GETPC());
-    env->sr_t = (relation == float_relation_greater);
+    return relation == float_relation_greater;
 }
 
-void helper_fcmp_gt_DT(CPUSH4State *env, float64 t0, float64 t1)
+uint32_t helper_fcmp_gt_DT(CPUSH4State *env, float64 t0, float64 t1)
 {
     int relation;
 
     set_float_exception_flags(0, &env->fp_status);
     relation = float64_compare(t0, t1, &env->fp_status);
     update_fpscr(env, GETPC());
-    env->sr_t = (relation == float_relation_greater);
+    return relation == float_relation_greater;
 }
 
 float64 helper_fcnvsd_FT_DT(CPUSH4State *env, float32 t0)
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 8098228c51..87b04f0d39 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1077,10 +1077,10 @@ static void _decode_opc(DisasContext * ctx)
                     gen_helper_fdiv_DT(fp0, cpu_env, fp0, fp1);
                     break;
                 case 0xf004:		/* fcmp/eq Rm,Rn */
-                    gen_helper_fcmp_eq_DT(cpu_env, fp0, fp1);
+                    gen_helper_fcmp_eq_DT(cpu_sr_t, cpu_env, fp0, fp1);
                     return;
                 case 0xf005:		/* fcmp/gt Rm,Rn */
-                    gen_helper_fcmp_gt_DT(cpu_env, fp0, fp1);
+                    gen_helper_fcmp_gt_DT(cpu_sr_t, cpu_env, fp0, fp1);
                     return;
                 }
 		gen_store_fpr64(fp0, DREG(B11_8));
@@ -1109,11 +1109,13 @@ static void _decode_opc(DisasContext * ctx)
                                        cpu_fregs[FREG(B7_4)]);
                     break;
                 case 0xf004:		/* fcmp/eq Rm,Rn */
-                    gen_helper_fcmp_eq_FT(cpu_env, cpu_fregs[FREG(B11_8)],
+                    gen_helper_fcmp_eq_FT(cpu_sr_t, cpu_env,
+                                          cpu_fregs[FREG(B11_8)],
                                           cpu_fregs[FREG(B7_4)]);
                     return;
                 case 0xf005:		/* fcmp/gt Rm,Rn */
-                    gen_helper_fcmp_gt_FT(cpu_env, cpu_fregs[FREG(B11_8)],
+                    gen_helper_fcmp_gt_FT(cpu_sr_t, cpu_env,
+                                          cpu_fregs[FREG(B11_8)],
                                           cpu_fregs[FREG(B7_4)]);
                     return;
                 }
-- 
2.11.0
