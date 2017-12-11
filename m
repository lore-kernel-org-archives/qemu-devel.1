Received: from eggs.gnu.org ([2001:4830:134:3::10]:51667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eONe9-0002UQ-F1
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 07:57:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eONe8-0007ol-6T
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 07:57:25 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:41737)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eONe7-0007o1-Tb
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 07:57:24 -0500
Received: by mail-wr0-x244.google.com with SMTP id z18so17479337wrb.8
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 04:57:23 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 11 Dec 2017 12:57:05 +0000
Message-Id: <20171211125705.16120-20-alex.bennee@linaro.org>
In-Reply-To: <20171211125705.16120-1-alex.bennee@linaro.org>
References: <20171211125705.16120-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 19/19] fpu/softfloat: re-factor compare
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com, aleksandar.markovic@imgtec.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 fpu/softfloat.c         | 135 +++++++++++++++++++++++++++++-------------------
 include/fpu/softfloat.h |   2 +
 2 files changed, 83 insertions(+), 54 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 5eba996932..31b437e000 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1793,6 +1793,87 @@ MINMAX(64, maxnummag, false, true, true)
 
 #undef MINMAX
 
+/* Floating point compare */
+static int compare_decomposed(decomposed_parts a, decomposed_parts b,
+                              bool is_quiet, float_status *s)
+{
+    if (a.cls >= float_class_qnan
+        ||
+        b.cls >= float_class_qnan) {
+        if (!is_quiet ||
+            a.cls == float_class_snan ||
+            b.cls == float_class_snan) {
+            s->float_exception_flags |= float_flag_invalid;
+        }
+        return float_relation_unordered;
+    }
+
+    if (a.cls == float_class_zero || b.cls == float_class_zero) {
+        if (a.cls == float_class_normal) {
+            return a.sign ? float_relation_less : float_relation_greater;
+        } else if (b.cls == float_class_normal) {
+            return b.sign ? float_relation_greater : float_relation_less;
+        } else if (a.cls == b.cls) {
+            return float_relation_equal;
+        }
+    }
+
+    /* The only infinity we need to explicitly worry about is
+     * comparing two together, otherwise the max_exp/sign details are
+     * enough to compare to normal numbers
+     */
+    if (a.cls == float_class_inf && b.cls == float_class_inf) {
+        if (a.sign != b.sign) {
+            return a.sign ? float_relation_less : float_relation_greater;
+        } else {
+            return float_relation_equal;
+        }
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
+int float ## sz ## _compare(float ## sz a, float ## sz b, float_status *s) \
+{                                                                       \
+    decomposed_parts pa = float ## sz ## _unpack_canonical(a, s);       \
+    decomposed_parts pb = float ## sz ## _unpack_canonical(b, s);       \
+    return compare_decomposed(pa, pb, false, s);                        \
+}                                                                       \
+int float ## sz ## _compare_quiet(float ## sz a, float ## sz b, float_status *s) \
+{                                                                       \
+    decomposed_parts pa = float ## sz ## _unpack_canonical(a, s);       \
+    decomposed_parts pb = float ## sz ## _unpack_canonical(b, s);       \
+    return compare_decomposed(pa, pb, true, s);                         \
+}
+
+COMPARE(16)
+COMPARE(32)
+COMPARE(64)
+
+#undef COMPARE
+
 /* Multiply A by 2 raised to the power N.  */
 static decomposed_parts scalbn_decomposed(decomposed_parts a, int n,
                                           float_status *s)
@@ -6894,60 +6975,6 @@ int float128_unordered_quiet(float128 a, float128 b, float_status *status)
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
index ba248ffa39..a5232bcc87 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -360,6 +360,8 @@ float16 float16_minnum(float16, float16, float_status *status);
 float16 float16_maxnum(float16, float16, float_status *status);
 float16 float16_minnummag(float16, float16, float_status *status);
 float16 float16_maxnummag(float16, float16, float_status *status);
+int float16_compare(float16, float16, float_status *status);
+int float16_compare_quiet(float16, float16, float_status *status);
 
 int float16_is_quiet_nan(float16, float_status *status);
 int float16_is_signaling_nan(float16, float_status *status);
-- 
2.15.1
