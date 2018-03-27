Received: from eggs.gnu.org ([2001:4830:134:3::10]:35788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f0hFI-0007P6-7b
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 01:34:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f0hFE-0005OA-H7
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 01:34:08 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:34275)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f0hFE-0005NC-DC
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 01:34:04 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 27 Mar 2018 01:33:58 -0400
Message-Id: <1522128840-498-13-git-send-email-cota@braap.org>
In-Reply-To: <1522128840-498-1-git-send-email-cota@braap.org>
References: <1522128840-498-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 12/14] hardfloat: support float32/64 square
 root
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Performance results for fp-bench run under aarch64-linux-user
on an Intel(R) Core(TM) i7-4790K CPU @ 4.00GHz host:

- before:
sqrt-single: 26.61 MFlops
sqrt-double: 17.14 MFlops

- after:
sqrt-single: 95.06 MFlops
sqrt-double: 89.05 MFlops

Note that here we have a single implementation for both f32/f64.
I tried the same trick we used before, but the results aren't
as good:

- w/ each using float32/64_is_normal or fpclassify etc.:
sqrt-single: 95.50 MFlops
sqrt-double: 84.55 MFlops

- w/ both using fpclassify etc.:
sqrt-single: 91.04 MFlops
sqrt-double: 85.55 MFlops

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 fpu/softfloat.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 2dedb13..ba7289b 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -2436,20 +2436,42 @@ float16 __attribute__((flatten)) float16_sqrt(float16 a, float_status *status)
     return float16_round_pack_canonical(pr, status);
 }
 
-float32 __attribute__((flatten)) float32_sqrt(float32 a, float_status *status)
+static float32 __attribute__((flatten, noinline))
+soft_float32_sqrt(float32 a, float_status *status)
 {
     FloatParts pa = float32_unpack_canonical(a, status);
     FloatParts pr = sqrt_float(pa, status, &float32_params);
     return float32_round_pack_canonical(pr, status);
 }
 
-float64 __attribute__((flatten)) float64_sqrt(float64 a, float_status *status)
+static float64 __attribute__((flatten, noinline))
+soft_float64_sqrt(float64 a, float_status *status)
 {
     FloatParts pa = float64_unpack_canonical(a, status);
     FloatParts pr = sqrt_float(pa, status, &float64_params);
     return float64_round_pack_canonical(pr, status);
 }
 
+#define GEN_FPU_SQRT(name, soft_t, host_t, host_sqrt_func)              \
+    soft_t name(soft_t a, float_status *s)                              \
+    {                                                                   \
+        soft_t ## _input_flush1(&a, s);                                 \
+        if (likely((soft_t ## _is_normal(a) || soft_t ## _is_zero(a)) && \
+                   !soft_t ## _is_neg(a) &&                             \
+                   s->float_exception_flags & float_flag_inexact &&     \
+                   s->float_rounding_mode == float_round_nearest_even)) { \
+            host_t ha = soft_t ## _to_ ## host_t(a);                    \
+            host_t hr = host_sqrt_func(ha);                             \
+                                                                        \
+            return host_t ## _to_ ## soft_t(hr);                        \
+        }                                                               \
+        return soft_ ## soft_t ## _sqrt(a, s);                          \
+    }
+
+GEN_FPU_SQRT(float32_sqrt, float32, float, sqrtf)
+GEN_FPU_SQRT(float64_sqrt, float64, double, sqrt)
+#undef GEN_FPU_SQRT
+
 
 /*----------------------------------------------------------------------------
 | Takes a 64-bit fixed-point value `absZ' with binary point between bits 6
-- 
2.7.4
