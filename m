Received: from eggs.gnu.org ([2001:4830:134:3::10]:47421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eiBf0-0004rr-Nm
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:12:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eiBey-00053d-QA
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:12:10 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:46162)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eiBey-00052K-Fq
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:12:08 -0500
Received: by mail-pg0-x243.google.com with SMTP id s9so15973632pgq.13
	for <qemu-devel@nongnu.org>; Sat, 03 Feb 2018 20:12:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  3 Feb 2018 20:11:31 -0800
Message-Id: <20180204041136.17525-20-richard.henderson@linaro.org>
In-Reply-To: <20180204041136.17525-1-richard.henderson@linaro.org>
References: <20180204041136.17525-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 19/24] fpu: Implement min/max with soft-fp.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, cota@braap.org, hsp.cat7@gmail.com

Add routines for float16 and float128.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat.h |  12 ++++++
 fpu/floatxx.inc.c       |  89 ++++++++++++++++++++++++++++++++++++++++
 fpu/softfloat.c         | 107 ------------------------------------------------
 3 files changed, 101 insertions(+), 107 deletions(-)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 80df716a55..95590d8420 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -260,6 +260,12 @@ int float16_lt_quiet(float16, float16, float_status *status);
 int float16_unordered_quiet(float16, float16, float_status *status);
 int float16_compare(float16, float16, float_status *status);
 int float16_compare_quiet(float16, float16, float_status *status);
+float16 float16_min(float16, float16, float_status *status);
+float16 float16_max(float16, float16, float_status *status);
+float16 float16_minnum(float16, float16, float_status *status);
+float16 float16_maxnum(float16, float16, float_status *status);
+float16 float16_minnummag(float16, float16, float_status *status);
+float16 float16_maxnummag(float16, float16, float_status *status);
 
 int float16_is_quiet_nan(float16, float_status *status);
 int float16_is_signaling_nan(float16, float_status *status);
@@ -682,6 +688,12 @@ int float128_lt_quiet(float128, float128, float_status *status);
 int float128_unordered_quiet(float128, float128, float_status *status);
 int float128_compare(float128, float128, float_status *status);
 int float128_compare_quiet(float128, float128, float_status *status);
+float128 float128_min(float128, float128, float_status *status);
+float128 float128_max(float128, float128, float_status *status);
+float128 float128_minnum(float128, float128, float_status *status);
+float128 float128_maxnum(float128, float128, float_status *status);
+float128 float128_minnummag(float128, float128, float_status *status);
+float128 float128_maxnummag(float128, float128, float_status *status);
 int float128_is_quiet_nan(float128, float_status *status);
 int float128_is_signaling_nan(float128, float_status *status);
 float128 float128_maybe_silence_nan(float128, float_status *status);
diff --git a/fpu/floatxx.inc.c b/fpu/floatxx.inc.c
index db49423723..0b6b8b4fd3 100644
--- a/fpu/floatxx.inc.c
+++ b/fpu/floatxx.inc.c
@@ -26,6 +26,10 @@
     (X##_e == _FP_EXPMAX_##fs && !_FP_FRAC_ZEROP_##wc (X))
 #define FP_ISNAN(fs, wc, X) \
     _FP_ISNAN(fs, wc, X)
+#define FP_CHOOSENAN(fs, wc, R, A, B, OP) \
+    _FP_CHOOSENAN(fs, wc, R, A, B, OP)
+#define FP_SETQNAN(fs, wc, X) \
+    _FP_SETQNAN(fs, wc, X)
 #define FP_ADD_INTERNAL(fs, wc, R, A, B, OP) \
     _FP_ADD_INTERNAL(fs, wc, R, A, B, '-')
 
@@ -263,3 +267,88 @@ int glue(FLOATXX,_unordered_quiet)(FLOATXX a, FLOATXX b, float_status *status)
 {
     return compare_internal(a, b, status, true) == float_relation_unordered;
 }
+
+#define MINMAX_MAX  0
+#define MINMAX_MIN  1
+#define MINMAX_IEEE 2
+#define MINMAX_MAG  4
+
+static FLOATXX minmax_internal(FLOATXX a, FLOATXX b,
+                               float_status *status, int flags)
+{
+    FP_DECL_EX;
+    glue(FP_DECL_, FS)(A);
+    glue(FP_DECL_, FS)(B);
+    bool save_A_s;
+    int cmp;
+
+    FP_INIT_EXCEPTIONS;
+    glue(FP_UNPACK_RAW_, FS)(A, a);
+    glue(FP_UNPACK_RAW_, FS)(B, b);
+
+    /* When comparing magnitudes, squish the signs.  */
+    save_A_s = A_s;
+    if (flags & MINMAX_MAG) {
+        A_s = B_s = 0;
+    }
+
+    glue(FP_CMP_, FS)(cmp, A, B, float_relation_unordered, 1);
+    FP_HANDLE_EXCEPTIONS;
+
+    if (unlikely(cmp == float_relation_unordered)) {
+        glue(FP_DECL_, FS)(R);
+        FLOATXX r;
+
+        if (flags & MINMAX_IEEE) {
+            if (glue(FP_ISSIGNAN_, FS)(A) || glue(FP_ISSIGNAN_, FS)(B)) {
+                /* fall through to FP_CHOOSENAN */
+            } else if (!FP_ISNAN(FS, WC, A)) {
+                return a;
+            } else if (!FP_ISNAN(FS, WC, B)) {
+                return b;
+            }
+        }
+
+        FP_CHOOSENAN(FS, WC, R, A, B, 'm');
+        FP_SETQNAN(FS, WC, R);
+        glue(FP_PACK_RAW_, FS)(r, R);
+        return r;
+    }
+
+    /* Specially handle min(+0.0, -0.0) = -0.0, which compare as equal. */
+    cmp = (cmp == 0 ? save_A_s : cmp < 0);
+    cmp ^= flags & MINMAX_MIN;
+    return cmp ? b : a;
+}
+
+FLOATXX glue(FLOATXX,_max)(FLOATXX a, FLOATXX b, float_status *status)
+{
+    return minmax_internal(a, b, status, MINMAX_MAX);
+}
+
+FLOATXX glue(FLOATXX,_min)(FLOATXX a, FLOATXX b, float_status *status)
+{
+    return minmax_internal(a, b, status, MINMAX_MIN);
+}
+
+FLOATXX glue(FLOATXX,_maxnum)(FLOATXX a, FLOATXX b, float_status *status)
+{
+    return minmax_internal(a, b, status, MINMAX_MAX | MINMAX_IEEE);
+}
+
+FLOATXX glue(FLOATXX,_minnum)(FLOATXX a, FLOATXX b, float_status *status)
+{
+    return minmax_internal(a, b, status, MINMAX_MIN | MINMAX_IEEE);
+}
+
+FLOATXX glue(FLOATXX,_maxnummag)(FLOATXX a, FLOATXX b, float_status *status)
+{
+    return minmax_internal(a, b, status,
+                           MINMAX_MAX | MINMAX_IEEE | MINMAX_MAG);
+}
+
+FLOATXX glue(FLOATXX,_minnummag)(FLOATXX a, FLOATXX b, float_status *status)
+{
+    return minmax_internal(a, b, status,
+                           MINMAX_MIN | MINMAX_IEEE | MINMAX_MAG);
+}
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index f75cd0bac4..68dfb464d5 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -4299,113 +4299,6 @@ int floatx80_unordered_quiet(floatx80 a, floatx80 b, float_status *status)
            == float_relation_unordered;
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
 /* Multiply A by 2 raised to the power N.  */
 float32 float32_scalbn(float32 a, int n, float_status *status)
 {
-- 
2.14.3
