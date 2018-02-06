Received: from eggs.gnu.org ([2001:4830:134:3::10]:35770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ej6Wb-0007BG-Dz
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 11:55:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ej6WZ-0001ah-3I
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 11:55:17 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:41108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ej6WY-0001Yl-EL
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 11:55:15 -0500
Received: by mail-wr0-x244.google.com with SMTP id v15so2673786wrb.8
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 08:55:14 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  6 Feb 2018 16:48:14 +0000
Message-Id: <20180206164815.10084-22-alex.bennee@linaro.org>
In-Reply-To: <20180206164815.10084-1-alex.bennee@linaro.org>
References: <20180206164815.10084-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 21/22] fpu/softfloat: re-factor compare
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

The compare function was already expanded from a macro. I keep the
macro expansion but move most of the logic into a compare_decomposed.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v2
  - minor re-factor for better inf handling
v3
  - fix renaming of structs/functions
v4
  - use is_nan
---
 fpu/softfloat.c         | 134 +++++++++++++++++++++++++++++-------------------
 include/fpu/softfloat.h |   2 +
 2 files changed, 82 insertions(+), 54 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index cb889a7a84..8fc1c2a8d9 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1784,6 +1784,86 @@ MINMAX(64, maxnummag, false, true, true)
 
 #undef MINMAX
 
+/* Floating point compare */
+static int compare_floats(FloatParts a, FloatParts b, bool is_quiet,
+                          float_status *s)
+{
+    if (is_nan(a.cls) || is_nan(b.cls)) {
+        if (!is_quiet ||
+            a.cls == float_class_snan ||
+            b.cls == float_class_snan) {
+            s->float_exception_flags |= float_flag_invalid;
+        }
+        return float_relation_unordered;
+    }
+
+    if (a.cls == float_class_zero) {
+        if (b.cls == float_class_zero) {
+            return float_relation_equal;
+        }
+        return b.sign ? float_relation_greater : float_relation_less;
+    } else if (b.cls == float_class_zero) {
+        return a.sign ? float_relation_less : float_relation_greater;
+    }
+
+    /* The only really important thing about infinity is its sign. If
+     * both are infinities the sign marks the smallest of the two.
+     */
+    if (a.cls == float_class_inf) {
+        if ((b.cls == float_class_inf) && (a.sign == b.sign)) {
+            return float_relation_equal;
+        }
+        return a.sign ? float_relation_less : float_relation_greater;
+    } else if (b.cls == float_class_inf) {
+        return b.sign ? float_relation_greater : float_relation_less;
+    }
+
+    if (a.sign != b.sign) {
+        return a.sign ? float_relation_less : float_relation_greater;
+    }
+
+    if (a.exp == b.exp) {
+        if (a.frac == b.frac) {
+            return float_relation_equal;
+        }
+        if (a.sign) {
+            return a.frac > b.frac ?
+                float_relation_less : float_relation_greater;
+        } else {
+            return a.frac > b.frac ?
+                float_relation_greater : float_relation_less;
+        }
+    } else {
+        if (a.sign) {
+            return a.exp > b.exp ? float_relation_less : float_relation_greater;
+        } else {
+            return a.exp > b.exp ? float_relation_greater : float_relation_less;
+        }
+    }
+}
+
+#define COMPARE(sz)                                                     \
+int float ## sz ## _compare(float ## sz a, float ## sz b,               \
+                            float_status *s)                            \
+{                                                                       \
+    FloatParts pa = float ## sz ## _unpack_canonical(a, s);             \
+    FloatParts pb = float ## sz ## _unpack_canonical(b, s);             \
+    return compare_floats(pa, pb, false, s);                            \
+}                                                                       \
+int float ## sz ## _compare_quiet(float ## sz a, float ## sz b,         \
+                                  float_status *s)                      \
+{                                                                       \
+    FloatParts pa = float ## sz ## _unpack_canonical(a, s);             \
+    FloatParts pb = float ## sz ## _unpack_canonical(b, s);             \
+    return compare_floats(pa, pb, true, s);                             \
+}
+
+COMPARE(16)
+COMPARE(32)
+COMPARE(64)
+
+#undef COMPARE
+
 /* Multiply A by 2 raised to the power N.  */
 static FloatParts scalbn_decomposed(FloatParts a, int n, float_status *s)
 {
@@ -6885,60 +6965,6 @@ int float128_unordered_quiet(float128 a, float128 b, float_status *status)
     return 0;
 }
 
-#define COMPARE(s, nan_exp)                                                  \
-static inline int float ## s ## _compare_internal(float ## s a, float ## s b,\
-                                      int is_quiet, float_status *status)    \
-{                                                                            \
-    flag aSign, bSign;                                                       \
-    uint ## s ## _t av, bv;                                                  \
-    a = float ## s ## _squash_input_denormal(a, status);                     \
-    b = float ## s ## _squash_input_denormal(b, status);                     \
-                                                                             \
-    if (( ( extractFloat ## s ## Exp( a ) == nan_exp ) &&                    \
-         extractFloat ## s ## Frac( a ) ) ||                                 \
-        ( ( extractFloat ## s ## Exp( b ) == nan_exp ) &&                    \
-          extractFloat ## s ## Frac( b ) )) {                                \
-        if (!is_quiet ||                                                     \
-            float ## s ## _is_signaling_nan(a, status) ||                  \
-            float ## s ## _is_signaling_nan(b, status)) {                 \
-            float_raise(float_flag_invalid, status);                         \
-        }                                                                    \
-        return float_relation_unordered;                                     \
-    }                                                                        \
-    aSign = extractFloat ## s ## Sign( a );                                  \
-    bSign = extractFloat ## s ## Sign( b );                                  \
-    av = float ## s ## _val(a);                                              \
-    bv = float ## s ## _val(b);                                              \
-    if ( aSign != bSign ) {                                                  \
-        if ( (uint ## s ## _t) ( ( av | bv )<<1 ) == 0 ) {                   \
-            /* zero case */                                                  \
-            return float_relation_equal;                                     \
-        } else {                                                             \
-            return 1 - (2 * aSign);                                          \
-        }                                                                    \
-    } else {                                                                 \
-        if (av == bv) {                                                      \
-            return float_relation_equal;                                     \
-        } else {                                                             \
-            return 1 - 2 * (aSign ^ ( av < bv ));                            \
-        }                                                                    \
-    }                                                                        \
-}                                                                            \
-                                                                             \
-int float ## s ## _compare(float ## s a, float ## s b, float_status *status) \
-{                                                                            \
-    return float ## s ## _compare_internal(a, b, 0, status);                 \
-}                                                                            \
-                                                                             \
-int float ## s ## _compare_quiet(float ## s a, float ## s b,                 \
-                                 float_status *status)                       \
-{                                                                            \
-    return float ## s ## _compare_internal(a, b, 1, status);                 \
-}
-
-COMPARE(32, 0xff)
-COMPARE(64, 0x7ff)
-
 static inline int floatx80_compare_internal(floatx80 a, floatx80 b,
                                             int is_quiet, float_status *status)
 {
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 35df225a55..cebe37b716 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -251,6 +251,8 @@ float16 float16_minnum(float16, float16, float_status *status);
 float16 float16_maxnum(float16, float16, float_status *status);
 float16 float16_minnummag(float16, float16, float_status *status);
 float16 float16_maxnummag(float16, float16, float_status *status);
+int float16_compare(float16, float16, float_status *status);
+int float16_compare_quiet(float16, float16, float_status *status);
 
 int float16_is_quiet_nan(float16, float_status *status);
 int float16_is_signaling_nan(float16, float_status *status);
-- 
2.15.1
