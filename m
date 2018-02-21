Received: from eggs.gnu.org ([2001:4830:134:3::10]:37357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eoSKA-0001Au-0v
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:12:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eoSK5-0002NG-W1
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:12:33 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:35200)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eoSK5-0002MX-NB
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:12:29 -0500
Received: by mail-wr0-x244.google.com with SMTP id l43so3348040wrc.2
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 03:12:29 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 21 Feb 2018 11:05:20 +0000
Message-Id: <20180221110523.859-21-alex.bennee@linaro.org>
In-Reply-To: <20180221110523.859-1-alex.bennee@linaro.org>
References: <20180221110523.859-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 20/22] fpu/softfloat: re-factor minmax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

Let's do the same re-factor treatment for minmax functions. I still
use the MACRO trick to expand but now all the checking code is common.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index a07b8556b0..7a53c36da4 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1663,6 +1663,126 @@ float64 uint16_to_float64(uint16_t a, float_status *status)
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
+static FloatParts minmax_floats(FloatParts a, FloatParts b, bool ismin,
+                                bool ieee, bool ismag, float_status *s)
+{
+    if (unlikely(is_nan(a.cls) || is_nan(b.cls))) {
+        if (ieee) {
+            /* Takes two floating-point values `a' and `b', one of
+             * which is a NaN, and returns the appropriate NaN
+             * result. If either `a' or `b' is a signaling NaN,
+             * the invalid exception is raised.
+             */
+            if (is_snan(a.cls) || is_snan(b.cls)) {
+                return pick_nan(a, b, s);
+            } else if (is_nan(a.cls) && !is_nan(b.cls)) {
+                return b;
+            } else if (is_nan(b.cls) && !is_nan(a.cls)) {
+                return a;
+            }
+        }
+        return pick_nan(a, b, s);
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
+float ## sz float ## sz ## _ ## name(float ## sz a, float ## sz b,      \
+                                     float_status *s)                   \
+{                                                                       \
+    FloatParts pa = float ## sz ## _unpack_canonical(a, s);             \
+    FloatParts pb = float ## sz ## _unpack_canonical(b, s);             \
+    FloatParts pr = minmax_floats(pa, pb, ismin, isiee, ismag, s);      \
+                                                                        \
+    return float ## sz ## _round_pack_canonical(pr, s);                 \
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
 static FloatParts scalbn_decomposed(FloatParts a, int n, float_status *s)
 {
@@ -6912,113 +7032,6 @@ int float128_compare_quiet(float128 a, float128 b, float_status *status)
     return float128_compare_internal(a, b, 1, status);
 }
 
-/* min() and max() functions. These can't be implemented as
- * 'compare and pick one input' because that would mishandle
- * NaNs and +0 vs -0.
- *
- * minnum() and maxnum() functions. These are similar to the min()
- * and max() functions but if one of the arguments is a QNaN and
- * the other is numerical then the numerical argument is returned.
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
-            if (float ## s ## _is_quiet_nan(a, status) &&               \
-                !float ## s ##_is_any_nan(b)) {                         \
-                return b;                                               \
-            } else if (float ## s ## _is_quiet_nan(b, status) &&        \
-                       !float ## s ## _is_any_nan(a)) {                \
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
index 52621e0b79..35df225a55 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -245,6 +245,12 @@ float16 float16_mul(float16, float16, float_status *status);
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
