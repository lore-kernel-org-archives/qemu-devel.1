Received: from eggs.gnu.org ([2001:4830:134:3::10]:53540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dRhnU-0007mE-FW
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 12:32:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dRhnT-0006kA-63
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 12:32:32 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:40224)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dRhnT-0006hp-0P
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 12:32:31 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Sun,  2 Jul 2017 18:32:19 +0200
Message-Id: <20170702163220.8039-2-aurelien@aurel32.net>
In-Reply-To: <20170702163220.8039-1-aurelien@aurel32.net>
References: <20170702163220.8039-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH 1/2] target/sh4: do not check for PR bit for
 fabs instruction
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

The SH4 manual is not fully clear about that, but real hardware do not
check for the PR bit, which allows to select between single or double
precision, for the fabs instruction. This is probably what is meant by
"Same operation is performed regardless of precision."

Remove the check, and at the same time use a TCG instruction instead of
a helper to clear one bit.

LP: https://bugs.launchpad.net/qemu/+bug/1701821
Reported-by: Bruno Haible <bruno@clisp.org>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/helper.h    |  2 --
 target/sh4/op_helper.c | 10 ----------
 target/sh4/translate.c | 15 +++------------
 3 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/target/sh4/helper.h b/target/sh4/helper.h
index dce859caea..f715224822 100644
--- a/target/sh4/helper.h
+++ b/target/sh4/helper.h
@@ -16,8 +16,6 @@ DEF_HELPER_3(macw, void, env, i32, i32)
 
 DEF_HELPER_2(ld_fpscr, void, env, i32)
 
-DEF_HELPER_FLAGS_1(fabs_FT, TCG_CALL_NO_RWG_SE, f32, f32)
-DEF_HELPER_FLAGS_1(fabs_DT, TCG_CALL_NO_RWG_SE, f64, f64)
 DEF_HELPER_FLAGS_3(fadd_FT, TCG_CALL_NO_WG, f32, env, f32, f32)
 DEF_HELPER_FLAGS_3(fadd_DT, TCG_CALL_NO_WG, f64, env, f64, f64)
 DEF_HELPER_FLAGS_2(fcnvsd_FT_DT, TCG_CALL_NO_WG, f64, env, f32)
diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index 528a40ac1d..5e3a3ba68c 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -252,16 +252,6 @@ static void update_fpscr(CPUSH4State *env, uintptr_t retaddr)
     }
 }
 
-float32 helper_fabs_FT(float32 t0)
-{
-    return float32_abs(t0);
-}
-
-float64 helper_fabs_DT(float64 t0)
-{
-    return float64_abs(t0);
-}
-
 float32 helper_fadd_FT(CPUSH4State *env, float32 t0, float32 t1)
 {
     set_float_exception_flags(0, &env->fp_status);
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 4f20537ef8..7c40945908 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1695,19 +1695,10 @@ static void _decode_opc(DisasContext * ctx)
 	    gen_helper_fneg_T(cpu_fregs[FREG(B11_8)], cpu_fregs[FREG(B11_8)]);
 	}
 	return;
-    case 0xf05d: /* fabs FRn/DRn */
+    case 0xf05d: /* fabs FRn/DRn - FPCSR: Nothing */
 	CHECK_FPU_ENABLED
-        if (ctx->tbflags & FPSCR_PR) {
-	    if (ctx->opcode & 0x0100)
-		break; /* illegal instruction */
-	    TCGv_i64 fp = tcg_temp_new_i64();
-	    gen_load_fpr64(fp, DREG(B11_8));
-	    gen_helper_fabs_DT(fp, fp);
-	    gen_store_fpr64(fp, DREG(B11_8));
-	    tcg_temp_free_i64(fp);
-	} else {
-	    gen_helper_fabs_FT(cpu_fregs[FREG(B11_8)], cpu_fregs[FREG(B11_8)]);
-	}
+        tcg_gen_andi_i32(cpu_fregs[FREG(B11_8)], cpu_fregs[FREG(B11_8)],
+                         0x7fffffff);
 	return;
     case 0xf06d: /* fsqrt FRn */
 	CHECK_FPU_ENABLED
-- 
2.11.0
