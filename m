Received: from eggs.gnu.org ([2001:4830:134:3::10]:42158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eyk5V-00029r-Se
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:11:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eyk5S-00010C-5P
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:11:57 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:53645)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1eyk5R-0000zo-VB
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:11:54 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 21 Mar 2018 16:11:48 -0400
Message-Id: <1521663109-32262-14-git-send-email-cota@braap.org>
In-Reply-To: <1521663109-32262-1-git-send-email-cota@braap.org>
References: <1521663109-32262-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v1 13/14] hostfloat: support float32/64
 comparison
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

Performance results included in the following commit's log.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/fpu/hostfloat.h |  4 ++++
 include/fpu/softfloat.h |  6 ++----
 fpu/hostfloat.c         | 36 ++++++++++++++++++++++++++++++++++++
 fpu/softfloat.c         | 34 ++++++++++++++++++++--------------
 4 files changed, 62 insertions(+), 18 deletions(-)

diff --git a/include/fpu/hostfloat.h b/include/fpu/hostfloat.h
index b1e0689..aa555f6 100644
--- a/include/fpu/hostfloat.h
+++ b/include/fpu/hostfloat.h
@@ -17,6 +17,8 @@ float32 float32_mul(float32 a, float32 b, float_status *status);
 float32 float32_div(float32 a, float32 b, float_status *status);
 float32 float32_muladd(float32 a, float32 b, float32 c, int f, float_status *s);
 float32 float32_sqrt(float32 a, float_status *status);
+int float32_compare(float32 a, float32 b, float_status *s);
+int float32_compare_quiet(float32 a, float32 b, float_status *s);
 
 float64 float64_add(float64 a, float64 b, float_status *status);
 float64 float64_sub(float64 a, float64 b, float_status *status);
@@ -24,5 +26,7 @@ float64 float64_mul(float64 a, float64 b, float_status *status);
 float64 float64_div(float64 a, float64 b, float_status *status);
 float64 float64_muladd(float64 a, float64 b, float64 c, int f, float_status *s);
 float64 float64_sqrt(float64 a, float_status *status);
+int float64_compare(float64 a, float64 b, float_status *s);
+int float64_compare_quiet(float64 a, float64 b, float_status *s);
 
 #endif /* HOSTFLOAT_H */
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 8d5a50a..cb57942 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -359,8 +359,7 @@ int float32_eq_quiet(float32, float32, float_status *status);
 int float32_le_quiet(float32, float32, float_status *status);
 int float32_lt_quiet(float32, float32, float_status *status);
 int float32_unordered_quiet(float32, float32, float_status *status);
-int float32_compare(float32, float32, float_status *status);
-int float32_compare_quiet(float32, float32, float_status *status);
+int soft_float32_compare(float32, float32, bool is_quiet, float_status *status);
 float32 float32_min(float32, float32, float_status *status);
 float32 float32_max(float32, float32, float_status *status);
 float32 float32_minnum(float32, float32, float_status *status);
@@ -498,8 +497,7 @@ int float64_eq_quiet(float64, float64, float_status *status);
 int float64_le_quiet(float64, float64, float_status *status);
 int float64_lt_quiet(float64, float64, float_status *status);
 int float64_unordered_quiet(float64, float64, float_status *status);
-int float64_compare(float64, float64, float_status *status);
-int float64_compare_quiet(float64, float64, float_status *status);
+int soft_float64_compare(float64, float64, bool is_quiet, float_status *status);
 float64 float64_min(float64, float64, float_status *status);
 float64 float64_max(float64, float64, float_status *status);
 float64 float64_minnum(float64, float64, float_status *status);
diff --git a/fpu/hostfloat.c b/fpu/hostfloat.c
index 974bd57..139e419 100644
--- a/fpu/hostfloat.c
+++ b/fpu/hostfloat.c
@@ -290,3 +290,39 @@ GEN_FPU_FMA(float64_muladd, float64, double, fma, fabs, DBL_MIN)
 GEN_FPU_SQRT(float32_sqrt, float32, float, sqrtf)
 GEN_FPU_SQRT(float64_sqrt, float64, double, sqrt)
 #undef GEN_FPU_SQRT
+
+#define GEN_FPU_COMPARE(name, soft_t, host_t)                           \
+    static inline __attribute__((always_inline)) int                    \
+    fpu_ ## name(soft_t a, soft_t b, bool is_quiet, float_status *s)    \
+    {                                                                   \
+        soft_t ## _input_flush2(&a, &b, s);                             \
+        if (unlikely(soft_t ## _is_any_nan(a) ||                        \
+                     soft_t ## _is_any_nan(b))) {                       \
+            return soft_ ## name(a, b, is_quiet, s);                    \
+        } else {                                                        \
+            host_t ha = soft_t ## _to_ ## host_t(a);                    \
+            host_t hb = soft_t ## _to_ ## host_t(b);                    \
+                                                                        \
+            if (isgreater(ha, hb)) {                                    \
+                return float_relation_greater;                          \
+            }                                                           \
+            if (isless(ha, hb)) {                                       \
+                return float_relation_less;                             \
+            }                                                           \
+            return float_relation_equal;                                \
+        }                                                               \
+    }                                                                   \
+                                                                        \
+    int name(soft_t a, soft_t b, float_status *s)                       \
+    {                                                                   \
+        return fpu_ ## name(a, b, false, s);                            \
+    }                                                                   \
+                                                                        \
+    int name ## _quiet(soft_t a, soft_t b, float_status *s)             \
+    {                                                                   \
+        return fpu_ ## name(a, b, true, s);                             \
+    }
+
+GEN_FPU_COMPARE(float32_compare, float32, float)
+GEN_FPU_COMPARE(float64_compare, float64, double)
+#undef GEN_FPU_COMPARE
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 096b658..1a32216 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1844,28 +1844,34 @@ static int compare_floats(FloatParts a, FloatParts b, bool is_quiet,
     }
 }
 
-#define COMPARE(sz)                                                     \
-int float ## sz ## _compare(float ## sz a, float ## sz b,               \
-                            float_status *s)                            \
+#define COMPARE(storage_class, sz)                                      \
+storage_class int                                                       \
+soft_float ## sz ## _compare(float ## sz a, float ## sz b,              \
+                                     bool is_quiet, float_status *s)    \
 {                                                                       \
     FloatParts pa = float ## sz ## _unpack_canonical(a, s);             \
     FloatParts pb = float ## sz ## _unpack_canonical(b, s);             \
-    return compare_floats(pa, pb, false, s);                            \
-}                                                                       \
-int float ## sz ## _compare_quiet(float ## sz a, float ## sz b,         \
-                                  float_status *s)                      \
-{                                                                       \
-    FloatParts pa = float ## sz ## _unpack_canonical(a, s);             \
-    FloatParts pb = float ## sz ## _unpack_canonical(b, s);             \
-    return compare_floats(pa, pb, true, s);                             \
+    return compare_floats(pa, pb, is_quiet, s);                         \
 }
 
-COMPARE(16)
-COMPARE(32)
-COMPARE(64)
+COMPARE(static, 16)
+COMPARE(, 32)
+COMPARE(, 64)
 
 #undef COMPARE
 
+int __attribute__((flatten))
+float16_compare(float16 a, float16 b, float_status *s)
+{
+    return soft_float16_compare(a, b, false, s);
+}
+
+int __attribute__((flatten))
+float16_compare_quiet(float16 a, float16 b, float_status *s)
+{
+    return soft_float16_compare(a, b, true, s);
+}
+
 /* Multiply A by 2 raised to the power N.  */
 static FloatParts scalbn_decomposed(FloatParts a, int n, float_status *s)
 {
-- 
2.7.4
