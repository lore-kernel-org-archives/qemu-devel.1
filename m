Received: from eggs.gnu.org ([2001:4830:134:3::10]:53777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eYt16-0002bY-Rs
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:28:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eYt15-0002Dd-BM
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:28:32 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:39343)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eYt14-0002Ct-UQ
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:28:31 -0500
Received: by mail-wm0-x242.google.com with SMTP id i11so20264249wmf.4
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 04:28:30 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  9 Jan 2018 12:22:52 +0000
Message-Id: <20180109122252.17670-21-alex.bennee@linaro.org>
In-Reply-To: <20180109122252.17670-1-alex.bennee@linaro.org>
References: <20180109122252.17670-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 20/20] fpu/softfloat: re-factor compare
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

---
v2
  - minor re-factor for better inf handling
---
 fpu/softfloat.c         | 134 +++++++++++++++++++++++++++++-------------------
 include/fpu/softfloat.h |   2 +
 2 files changed, 82 insertions(+), 54 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 1dd9bd5972..8eda35acd5 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1791,6 +1791,86 @@ MINMAX(64, maxnummag, false, true, true)
 
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
@@ -6892,60 +6972,6 @@ int float128_unordered_quiet(float128 a, float128 b, float_status *status)
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
index c948727bbb..e5aa8d65f9 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -333,6 +333,8 @@ float16 float16_minnum(float16, float16, float_status *status);
 float16 float16_maxnum(float16, float16, float_status *status);
 float16 float16_minnummag(float16, float16, float_status *status);
 float16 float16_maxnummag(float16, float16, float_status *status);
+int float16_compare(float16, float16, float_status *status);
+int float16_compare_quiet(float16, float16, float_status *status);
 
 int float16_is_quiet_nan(float16, float_status *status);
 int float16_is_signaling_nan(float16, float_status *status);
-- 
2.15.1
