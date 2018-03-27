Received: from eggs.gnu.org ([2001:4830:134:3::10]:35796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f0hFI-0007PD-8X
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 01:34:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f0hFE-0005ON-NA
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 01:34:08 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:48435)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f0hFE-0005Nd-J6
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 01:34:04 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 27 Mar 2018 01:33:59 -0400
Message-Id: <1522128840-498-14-git-send-email-cota@braap.org>
In-Reply-To: <1522128840-498-1-git-send-email-cota@braap.org>
References: <1522128840-498-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 13/14] hardfloat: support float32/64
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

Performance results for fp-bench run under aarch64-linux-user
on an Intel(R) Core(TM) i7-4790K CPU @ 4.00GHz host:

- before:
cmp-single: 34.23 MFlops
cmp-double: 32.53 MFlops

- after:
cmp-single: 43.51 MFlops
cmp-double: 41.23 MFlops

Using float32/64_is_any_nan vs. isnan yields only up to a 2% perf
difference, so I'm keeping for now a single implementation.

This low sensitivity is most likely due to the soft-fp
int64_to_float32/64 functions -- they take ~50% of execution time.
They should be converted to hardfloat once there are test cases
in fp-test for them.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 fpu/softfloat.c | 69 +++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 55 insertions(+), 14 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index ba7289b..2b86d73 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -2300,28 +2300,69 @@ static int compare_floats(FloatParts a, FloatParts b, bool is_quiet,
     }
 }
 
-#define COMPARE(sz)                                                     \
-int float ## sz ## _compare(float ## sz a, float ## sz b,               \
-                            float_status *s)                            \
-{                                                                       \
-    FloatParts pa = float ## sz ## _unpack_canonical(a, s);             \
-    FloatParts pb = float ## sz ## _unpack_canonical(b, s);             \
-    return compare_floats(pa, pb, false, s);                            \
-}                                                                       \
-int float ## sz ## _compare_quiet(float ## sz a, float ## sz b,         \
-                                  float_status *s)                      \
+#define COMPARE(attr, sz)                                               \
+static int attr                                                         \
+soft_float ## sz ## _compare(float ## sz a, float ## sz b,              \
+                             bool is_quiet, float_status *s)            \
 {                                                                       \
     FloatParts pa = float ## sz ## _unpack_canonical(a, s);             \
     FloatParts pb = float ## sz ## _unpack_canonical(b, s);             \
-    return compare_floats(pa, pb, true, s);                             \
+    return compare_floats(pa, pb, is_quiet, s);                         \
 }
 
-COMPARE(16)
-COMPARE(32)
-COMPARE(64)
+COMPARE(, 16)
+COMPARE(__attribute__((noinline)), 32)
+COMPARE(__attribute__((noinline)), 64)
 
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
+#define GEN_FPU_COMPARE(name, soft_t, host_t)                           \
+    static inline __attribute__((always_inline)) int                    \
+    fpu_ ## name(soft_t a, soft_t b, bool is_quiet, float_status *s)    \
+    {                                                                   \
+        host_t ha, hb;                                                  \
+                                                                        \
+        soft_t ## _input_flush2(&a, &b, s);                             \
+        ha = soft_t ## _to_ ## host_t(a);                               \
+        hb = soft_t ## _to_ ## host_t(b);                               \
+        if (unlikely(isnan(ha) || isnan(hb))) {                         \
+            return soft_ ## name(a, b, is_quiet, s);                    \
+        }                                                               \
+        if (isgreater(ha, hb)) {                                        \
+            return float_relation_greater;                              \
+        }                                                               \
+        if (isless(ha, hb)) {                                           \
+            return float_relation_less;                                 \
+        }                                                               \
+        return float_relation_equal;                                    \
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
+
 /* Multiply A by 2 raised to the power N.  */
 static FloatParts scalbn_decomposed(FloatParts a, int n, float_status *s)
 {
-- 
2.7.4
