Received: from eggs.gnu.org ([2001:4830:134:3::10]:42175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eyk5V-0002A2-W5
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:12:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eyk5R-0000zw-Sq
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:11:57 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:56221)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1eyk5R-0000zX-L8
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:11:53 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 21 Mar 2018 16:11:47 -0400
Message-Id: <1521663109-32262-13-git-send-email-cota@braap.org>
In-Reply-To: <1521663109-32262-1-git-send-email-cota@braap.org>
References: <1521663109-32262-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v1 12/14] hostfloat: support float32/64 square
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
sqrt-single: 13.23 MFlops
sqrt-double: 13.24 MFlops

- after:
sqrt-single: 15.02 MFlops
sqrt-double: 15.07 MFlops

Note that sqrt in soft-ft is relatively fast, which means
that fp-bench is not very sensitive to changes to sqrt's
emulation speed.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/fpu/hostfloat.h |  2 ++
 include/fpu/softfloat.h |  4 ++--
 fpu/hostfloat.c         | 20 ++++++++++++++++++++
 fpu/softfloat.c         |  6 ++++--
 4 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/include/fpu/hostfloat.h b/include/fpu/hostfloat.h
index c006576..b1e0689 100644
--- a/include/fpu/hostfloat.h
+++ b/include/fpu/hostfloat.h
@@ -16,11 +16,13 @@ float32 float32_sub(float32 a, float32 b, float_status *status);
 float32 float32_mul(float32 a, float32 b, float_status *status);
 float32 float32_div(float32 a, float32 b, float_status *status);
 float32 float32_muladd(float32 a, float32 b, float32 c, int f, float_status *s);
+float32 float32_sqrt(float32 a, float_status *status);
 
 float64 float64_add(float64 a, float64 b, float_status *status);
 float64 float64_sub(float64 a, float64 b, float_status *status);
 float64 float64_mul(float64 a, float64 b, float_status *status);
 float64 float64_div(float64 a, float64 b, float_status *status);
 float64 float64_muladd(float64 a, float64 b, float64 c, int f, float_status *s);
+float64 float64_sqrt(float64 a, float_status *status);
 
 #endif /* HOSTFLOAT_H */
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 866bd3b..8d5a50a 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -348,7 +348,7 @@ float32 soft_float32_mul(float32, float32, float_status *status);
 float32 soft_float32_div(float32, float32, float_status *status);
 float32 float32_rem(float32, float32, float_status *status);
 float32 soft_float32_muladd(float32, float32, float32, int, float_status *s);
-float32 float32_sqrt(float32, float_status *status);
+float32 soft_float32_sqrt(float32, float_status *status);
 float32 float32_exp2(float32, float_status *status);
 float32 float32_log2(float32, float_status *status);
 int float32_eq(float32, float32, float_status *status);
@@ -488,7 +488,7 @@ float64 soft_float64_mul(float64, float64, float_status *status);
 float64 soft_float64_div(float64, float64, float_status *status);
 float64 float64_rem(float64, float64, float_status *status);
 float64 soft_float64_muladd(float64, float64, float64, int, float_status *s);
-float64 float64_sqrt(float64, float_status *status);
+float64 soft_float64_sqrt(float64, float_status *status);
 float64 float64_log2(float64, float_status *status);
 int float64_eq(float64, float64, float_status *status);
 int float64_le(float64, float64, float_status *status);
diff --git a/fpu/hostfloat.c b/fpu/hostfloat.c
index a56b70a..974bd57 100644
--- a/fpu/hostfloat.c
+++ b/fpu/hostfloat.c
@@ -270,3 +270,23 @@ GEN_FPU_DIV(float64_div, float64, double, fabs, DBL_MIN)
 GEN_FPU_FMA(float32_muladd, float32, float, fmaf, fabsf, FLT_MIN)
 GEN_FPU_FMA(float64_muladd, float64, double, fma, fabs, DBL_MIN)
 #undef GEN_FPU_FMA
+
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
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index da81ec9..096b658 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1980,14 +1980,16 @@ float16 __attribute__((flatten)) float16_sqrt(float16 a, float_status *status)
     return float16_round_pack_canonical(pr, status);
 }
 
-float32 __attribute__((flatten)) float32_sqrt(float32 a, float_status *status)
+float32 __attribute__((flatten))
+soft_float32_sqrt(float32 a, float_status *status)
 {
     FloatParts pa = float32_unpack_canonical(a, status);
     FloatParts pr = sqrt_float(pa, status, &float32_params);
     return float32_round_pack_canonical(pr, status);
 }
 
-float64 __attribute__((flatten)) float64_sqrt(float64 a, float_status *status)
+float64 __attribute__((flatten))
+soft_float64_sqrt(float64 a, float_status *status)
 {
     FloatParts pa = float64_unpack_canonical(a, status);
     FloatParts pr = sqrt_float(pa, status, &float64_params);
-- 
2.7.4
