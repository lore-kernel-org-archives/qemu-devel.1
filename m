Received: from eggs.gnu.org ([2001:4830:134:3::10]:40794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fSYQm-00046I-Pf
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:49:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fSYQh-0003LN-Pw
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:49:08 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56157)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fSYQh-0003J9-JJ
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:49:03 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 11 Jun 2018 21:48:50 -0400
Message-Id: <1528768140-17894-5-git-send-email-cota@braap.org>
In-Reply-To: <1528768140-17894-1-git-send-email-cota@braap.org>
References: <1528768140-17894-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v4 04/14] target/tricore: use
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
Cc: Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/tricore/fpu_helper.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/target/tricore/fpu_helper.c b/target/tricore/fpu_helper.c
index df16290..31df462 100644
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
2.7.4
