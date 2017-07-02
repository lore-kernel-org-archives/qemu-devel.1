Received: from eggs.gnu.org ([2001:4830:134:3::10]:59463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dRlTi-0001kb-4a
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 16:28:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dRlTh-0001H4-BR
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 16:28:22 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:41570)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dRlTh-0001GM-4F
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 16:28:21 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Sun,  2 Jul 2017 22:28:13 +0200
Message-Id: <20170702202814.27793-5-aurelien@aurel32.net>
In-Reply-To: <20170702202814.27793-1-aurelien@aurel32.net>
References: <20170702202814.27793-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH v2 4/5] target/sh4: do not use a helper to
 implement fneg
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

There is no need to use a helper to flip one bit, just use a TCG xor
instruction instead.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/helper.h    | 1 -
 target/sh4/op_helper.c | 5 -----
 target/sh4/translate.c | 5 ++---
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/target/sh4/helper.h b/target/sh4/helper.h
index f715224822..d2398922dd 100644
--- a/target/sh4/helper.h
+++ b/target/sh4/helper.h
@@ -32,7 +32,6 @@ DEF_HELPER_FLAGS_2(float_DT, TCG_CALL_NO_WG, f64, env, i32)
 DEF_HELPER_FLAGS_4(fmac_FT, TCG_CALL_NO_WG, f32, env, f32, f32, f32)
 DEF_HELPER_FLAGS_3(fmul_FT, TCG_CALL_NO_WG, f32, env, f32, f32)
 DEF_HELPER_FLAGS_3(fmul_DT, TCG_CALL_NO_WG, f64, env, f64, f64)
-DEF_HELPER_FLAGS_1(fneg_T, TCG_CALL_NO_RWG_SE, f32, f32)
 DEF_HELPER_FLAGS_3(fsub_FT, TCG_CALL_NO_WG, f32, env, f32, f32)
 DEF_HELPER_FLAGS_3(fsub_DT, TCG_CALL_NO_WG, f64, env, f64, f64)
 DEF_HELPER_FLAGS_2(fsqrt_FT, TCG_CALL_NO_WG, f32, env, f32)
diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index f2e39c5ca6..64206cf803 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -384,11 +384,6 @@ float64 helper_fmul_DT(CPUSH4State *env, float64 t0, float64 t1)
     return t0;
 }
 
-float32 helper_fneg_T(float32 t0)
-{
-    return float32_chs(t0);
-}
-
 float32 helper_fsqrt_FT(CPUSH4State *env, float32 t0)
 {
     set_float_exception_flags(0, &env->fp_status);
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 7c40945908..8098228c51 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1691,9 +1691,8 @@ static void _decode_opc(DisasContext * ctx)
 	return;
     case 0xf04d: /* fneg FRn/DRn - FPSCR: Nothing */
 	CHECK_FPU_ENABLED
-	{
-	    gen_helper_fneg_T(cpu_fregs[FREG(B11_8)], cpu_fregs[FREG(B11_8)]);
-	}
+        tcg_gen_xori_i32(cpu_fregs[FREG(B11_8)], cpu_fregs[FREG(B11_8)],
+                         0x80000000);
 	return;
     case 0xf05d: /* fabs FRn/DRn - FPCSR: Nothing */
 	CHECK_FPU_ENABLED
-- 
2.11.0
