Received: from eggs.gnu.org ([2001:4830:134:3::10]:57883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gBTCf-0002TL-Lh
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 19:20:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gBTCc-0007wC-Bp
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 19:20:13 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36351)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gBTCc-0007vh-5H
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 19:20:10 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sat, 13 Oct 2018 19:19:23 -0400
Message-Id: <20181013231933.28789-4-cota@braap.org>
In-Reply-To: <20181013231933.28789-1-cota@braap.org>
References: <20181013231933.28789-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v5 03/13] target/tricore: use
 float32_is_denormal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/tricore/fpu_helper.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/target/tricore/fpu_helper.c b/target/tricore/fpu_helper.c
index df162902d6..31df462e4a 100644
--- a/target/tricore/fpu_helper.c
+++ b/target/tricore/fpu_helper.c
@@ -44,11 +44,6 @@ static inline uint8_t f_get_excp_flags(CPUTriCoreState *env)
               | float_flag_inexact);
 }
 
-static inline bool f_is_denormal(float32 arg)
-{
-    return float32_is_zero_or_denormal(arg) && !float32_is_zero(arg);
-}
-
 static inline float32 f_maddsub_nan_result(float32 arg1, float32 arg2,
                                            float32 arg3, float32 result,
                                            uint32_t muladd_negate_c)
@@ -260,8 +255,8 @@ uint32_t helper_fcmp(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     set_flush_inputs_to_zero(0, &env->fp_status);
 
     result = 1 << (float32_compare_quiet(arg1, arg2, &env->fp_status) + 1);
-    result |= f_is_denormal(arg1) << 4;
-    result |= f_is_denormal(arg2) << 5;
+    result |= float32_is_denormal(arg1) << 4;
+    result |= float32_is_denormal(arg2) << 5;
 
     flags = f_get_excp_flags(env);
     if (flags) {
-- 
2.17.1
