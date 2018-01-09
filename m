Received: from eggs.gnu.org ([2001:4830:134:3::10]:53762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eYt15-0002ah-Tt
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:28:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eYt13-0002CR-C9
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:28:31 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:41641)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eYt13-0002BE-1r
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:28:29 -0500
Received: by mail-wm0-x241.google.com with SMTP id g75so20215892wme.0
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 04:28:28 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  9 Jan 2018 12:22:51 +0000
Message-Id: <20180109122252.17670-20-alex.bennee@linaro.org>
In-Reply-To: <20180109122252.17670-1-alex.bennee@linaro.org>
References: <20180109122252.17670-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 19/20] fpu/softfloat: re-factor minmax
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

Let's do the same re-factor treatment for minmax functions. I still
use the MACRO trick to expand but now all the checking code is common.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - minor indentation fix
---
 fpu/softfloat.c         | 239 ++++++++++++++++++++++++++----------------------
 include/fpu/softfloat.h |   6 ++
 2 files changed, 134 insertions(+), 111 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 3647f6ca03..1dd9bd5972 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1663,6 +1663,134 @@ float64 uint16_to_float64(uint16_t a, float_status *status)
     return uint64_to_float64(a, status);
 }
 
+/* Float Min/Max */
+/* min() and max() functions. These can't be implemented as
+ * 'compare and pick one input' because that would mishandle
+ * NaNs and +0 vs -0.
+ *
+ * minnum() and maxnum() functions. These are similar to the min()
+ * and max() functions but if one of the arguments is a QNaN and
+ * the other is numerical then the numerical argument is returned.
+ * SNaNs will get quietened before being returned.
+ * minnum() and maxnum correspond to the IEEE 754-2008 minNum()
+ * and maxNum() operations. min() and max() are the typical min/max
+ * semantics provided by many CPUs which predate that specification.
+ *
+ * minnummag() and maxnummag() functions correspond to minNumMag()
+ * and minNumMag() from the IEEE-754 2008.
+ */
+static decomposed_parts minmax_decomposed(decomposed_parts a,
+                                          decomposed_parts b,
+                                          bool ismin, bool ieee, bool ismag,
+                                          float_status *s)
+{
+    if (a.cls >= float_class_qnan
+        ||
+        b.cls >= float_class_qnan)
+    {
+        if (ieee) {
+            /* Takes two floating-point values `a' and `b', one of
+             * which is a NaN, and returns the appropriate NaN
+             * result. If either `a' or `b' is a signaling NaN,
+             * the invalid exception is raised.
+             */
+            if (a.cls == float_class_snan || b.cls == float_class_snan) {
+                return pick_nan_parts(a, b, s);
+            } else if (a.cls >= float_class_qnan
+                       &&
+                       b.cls < float_class_qnan) {
+                return b;
+            } else if (b.cls >= float_class_qnan
+                       &&
+                       a.cls < float_class_qnan) {
+                return a;
+            }
+        }
+        return pick_nan_parts(a, b, s);
+    } else {
+        int a_exp, b_exp;
+        bool a_sign, b_sign;
+
+        switch (a.cls) {
+        case float_class_normal:
+            a_exp = a.exp;
+            break;
+        case float_class_inf:
+            a_exp = INT_MAX;
+            break;
+        case float_class_zero:
+            a_exp = INT_MIN;
+            break;
+        default:
+            g_assert_not_reached();
+            break;
+        }
+        switch (b.cls) {
+        case float_class_normal:
+            b_exp = b.exp;
+            break;
+        case float_class_inf:
+            b_exp = INT_MAX;
+            break;
+        case float_class_zero:
+            b_exp = INT_MIN;
+            break;
+        default:
+            g_assert_not_reached();
+            break;
+        }
+
+        a_sign = a.sign;
+        b_sign = b.sign;
+        if (ismag) {
+            a_sign = b_sign = 0;
+        }
+
+        if (a_sign == b_sign) {
+            bool a_less = a_exp < b_exp;
+            if (a_exp == b_exp) {
+                a_less = a.frac < b.frac;
+            }
+            return a_sign ^ a_less ^ ismin ? b : a;
+        } else {
+            return a_sign ^ ismin ? b : a;
+        }
+    }
+}
+
+#define MINMAX(sz, name, ismin, isiee, ismag)                           \
+float ## sz float ## sz ## _ ## name(float ## sz a, float ## sz b, float_status *s) \
+{                                                                       \
+    decomposed_parts pa = float ## sz ## _unpack_canonical(a, s);       \
+    decomposed_parts pb = float ## sz ## _unpack_canonical(b, s);       \
+    decomposed_parts pr = minmax_decomposed(pa, pb, ismin, isiee, ismag, s); \
+                                                                        \
+    return float ## sz ## _round_pack_canonical(pr, s);                \
+}
+
+MINMAX(16, min, true, false, false)
+MINMAX(16, minnum, true, true, false)
+MINMAX(16, minnummag, true, true, true)
+MINMAX(16, max, false, false, false)
+MINMAX(16, maxnum, false, true, false)
+MINMAX(16, maxnummag, false, true, true)
+
+MINMAX(32, min, true, false, false)
+MINMAX(32, minnum, true, true, false)
+MINMAX(32, minnummag, true, true, true)
+MINMAX(32, max, false, false, false)
+MINMAX(32, maxnum, false, true, false)
+MINMAX(32, maxnummag, false, true, true)
+
+MINMAX(64, min, true, false, false)
+MINMAX(64, minnum, true, true, false)
+MINMAX(64, minnummag, true, true, true)
+MINMAX(64, max, false, false, false)
+MINMAX(64, maxnum, false, true, false)
+MINMAX(64, maxnummag, false, true, true)
+
+#undef MINMAX
+
 /* Multiply A by 2 raised to the power N.  */
 static decomposed_parts scalbn_decomposed(decomposed_parts a, int n,
                                           float_status *s)
@@ -6912,117 +7040,6 @@ int float128_compare_quiet(float128 a, float128 b, float_status *status)
     return float128_compare_internal(a, b, 1, status);
 }
 
-/* min() and max() functions. These can't be implemented as
- * 'compare and pick one input' because that would mishandle
- * NaNs and +0 vs -0.
- *
- * minnum() and maxnum() functions. These are similar to the min()
- * and max() functions but if one of the arguments is a QNaN and
- * the other is numerical then the numerical argument is returned.
- * SNaNs will get quietened before being returned.
- * minnum() and maxnum correspond to the IEEE 754-2008 minNum()
- * and maxNum() operations. min() and max() are the typical min/max
- * semantics provided by many CPUs which predate that specification.
- *
- * minnummag() and maxnummag() functions correspond to minNumMag()
- * and minNumMag() from the IEEE-754 2008.
- */
-#define MINMAX(s)                                                       \
-static inline float ## s float ## s ## _minmax(float ## s a, float ## s b,     \
-                                               int ismin, int isieee,   \
-                                               int ismag,               \
-                                               float_status *status)    \
-{                                                                       \
-    flag aSign, bSign;                                                  \
-    uint ## s ## _t av, bv, aav, abv;                                   \
-    a = float ## s ## _squash_input_denormal(a, status);                \
-    b = float ## s ## _squash_input_denormal(b, status);                \
-    if (float ## s ## _is_any_nan(a) ||                                 \
-        float ## s ## _is_any_nan(b)) {                                 \
-        if (isieee) {                                                   \
-            if (float ## s ## _is_signaling_nan(a, status) ||           \
-                float ## s ## _is_signaling_nan(b, status)) {           \
-                return propagateFloat ## s ## NaN(a, b, status);        \
-            } else  if (float ## s ## _is_quiet_nan(a, status) &&       \
-                !float ## s ##_is_any_nan(b)) {                         \
-                return b;                                               \
-            } else if (float ## s ## _is_quiet_nan(b, status) &&        \
-                       !float ## s ## _is_any_nan(a)) {                 \
-                return a;                                               \
-            }                                                           \
-        }                                                               \
-        return propagateFloat ## s ## NaN(a, b, status);                \
-    }                                                                   \
-    aSign = extractFloat ## s ## Sign(a);                               \
-    bSign = extractFloat ## s ## Sign(b);                               \
-    av = float ## s ## _val(a);                                         \
-    bv = float ## s ## _val(b);                                         \
-    if (ismag) {                                                        \
-        aav = float ## s ## _abs(av);                                   \
-        abv = float ## s ## _abs(bv);                                   \
-        if (aav != abv) {                                               \
-            if (ismin) {                                                \
-                return (aav < abv) ? a : b;                             \
-            } else {                                                    \
-                return (aav < abv) ? b : a;                             \
-            }                                                           \
-        }                                                               \
-    }                                                                   \
-    if (aSign != bSign) {                                               \
-        if (ismin) {                                                    \
-            return aSign ? a : b;                                       \
-        } else {                                                        \
-            return aSign ? b : a;                                       \
-        }                                                               \
-    } else {                                                            \
-        if (ismin) {                                                    \
-            return (aSign ^ (av < bv)) ? a : b;                         \
-        } else {                                                        \
-            return (aSign ^ (av < bv)) ? b : a;                         \
-        }                                                               \
-    }                                                                   \
-}                                                                       \
-                                                                        \
-float ## s float ## s ## _min(float ## s a, float ## s b,               \
-                              float_status *status)                     \
-{                                                                       \
-    return float ## s ## _minmax(a, b, 1, 0, 0, status);                \
-}                                                                       \
-                                                                        \
-float ## s float ## s ## _max(float ## s a, float ## s b,               \
-                              float_status *status)                     \
-{                                                                       \
-    return float ## s ## _minmax(a, b, 0, 0, 0, status);                \
-}                                                                       \
-                                                                        \
-float ## s float ## s ## _minnum(float ## s a, float ## s b,            \
-                                 float_status *status)                  \
-{                                                                       \
-    return float ## s ## _minmax(a, b, 1, 1, 0, status);                \
-}                                                                       \
-                                                                        \
-float ## s float ## s ## _maxnum(float ## s a, float ## s b,            \
-                                 float_status *status)                  \
-{                                                                       \
-    return float ## s ## _minmax(a, b, 0, 1, 0, status);                \
-}                                                                       \
-                                                                        \
-float ## s float ## s ## _minnummag(float ## s a, float ## s b,         \
-                                    float_status *status)               \
-{                                                                       \
-    return float ## s ## _minmax(a, b, 1, 1, 1, status);                \
-}                                                                       \
-                                                                        \
-float ## s float ## s ## _maxnummag(float ## s a, float ## s b,         \
-                                    float_status *status)               \
-{                                                                       \
-    return float ## s ## _minmax(a, b, 0, 1, 1, status);                \
-}
-
-MINMAX(32)
-MINMAX(64)
-
-
 floatx80 floatx80_scalbn(floatx80 a, int n, float_status *status)
 {
     flag aSign;
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 41338184d5..c948727bbb 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -327,6 +327,12 @@ float16 float16_mul(float16, float16, float_status *status);
 float16 float16_muladd(float16, float16, float16, int, float_status *status);
 float16 float16_div(float16, float16, float_status *status);
 float16 float16_scalbn(float16, int, float_status *status);
+float16 float16_min(float16, float16, float_status *status);
+float16 float16_max(float16, float16, float_status *status);
+float16 float16_minnum(float16, float16, float_status *status);
+float16 float16_maxnum(float16, float16, float_status *status);
+float16 float16_minnummag(float16, float16, float_status *status);
+float16 float16_maxnummag(float16, float16, float_status *status);
 
 int float16_is_quiet_nan(float16, float_status *status);
 int float16_is_signaling_nan(float16, float_status *status);
-- 
2.15.1
