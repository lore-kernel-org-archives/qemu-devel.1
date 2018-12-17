Received: from eggs.gnu.org ([2001:4830:134:3::10]:37274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gYqbp-0002Y7-QF
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 05:58:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gYqa1-00007m-C2
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 05:56:58 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:39549)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gYqa1-00007O-5r
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 05:56:57 -0500
Received: by mail-wr1-x436.google.com with SMTP id t27so11779150wra.6
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 02:56:57 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 17 Dec 2018 10:56:40 +0000
Message-Id: <20181217105650.27361-6-alex.bennee@linaro.org>
In-Reply-To: <20181217105650.27361-1-alex.bennee@linaro.org>
References: <20181217105650.27361-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v3 05/15] target/tricore: use float32_is_denormal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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
