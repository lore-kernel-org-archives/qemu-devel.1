Received: from eggs.gnu.org ([2001:4830:134:3::10]:41860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fIyjc-0004Ka-SM
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:53:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fIyjb-00052l-CU
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:53:00 -0400
Received: from mail-pl0-x22e.google.com ([2607:f8b0:400e:c01::22e]:44324)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fIyjb-00052X-40
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:52:59 -0400
Received: by mail-pl0-x22e.google.com with SMTP id e6-v6so658999plt.11
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 08:52:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 16 May 2018 08:52:23 -0700
Message-Id: <20180516155243.16937-9-richard.henderson@linaro.org>
In-Reply-To: <20180516155243.16937-1-richard.henderson@linaro.org>
References: <20180516155243.16937-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/28] fpu/softfloat: Replace float_class_msnan
 with parts_silence_nan
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

With a canonical representation of NaNs, we can silence an SNaN
immediately rather than delay until the final format is known.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-specialize.h | 23 ++++++++++++++++++++++
 fpu/softfloat.c            | 40 ++++++++++----------------------------
 2 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
index 0d3d81a52b..571d1df378 100644
--- a/fpu/softfloat-specialize.h
+++ b/fpu/softfloat-specialize.h
@@ -138,6 +138,29 @@ static FloatParts parts_default_nan(float_status *status)
     };
 }
 
+/*----------------------------------------------------------------------------
+| Returns a quiet NaN from a signalling NaN for the deconstructed
+| floating-point parts.
+*----------------------------------------------------------------------------*/
+
+static FloatParts parts_silence_nan(FloatParts a, float_status *status)
+{
+#ifdef NO_SIGNALING_NANS
+    g_assert_not_reached();
+#elif defined(TARGET_HPPA)
+    a.frac &= ~(1ULL << (DECOMPOSED_BINARY_POINT - 1));
+    a.frac |= 1ULL << (DECOMPOSED_BINARY_POINT - 2);
+#else
+    if (status->snan_bit_is_one) {
+        return parts_default_nan(status);
+    } else {
+        a.frac |= 1ULL << (DECOMPOSED_BINARY_POINT - 1);
+    }
+#endif
+    a.cls = float_class_qnan;
+    return a;
+}
+
 /*----------------------------------------------------------------------------
 | The pattern for a default generated half-precision NaN.
 *----------------------------------------------------------------------------*/
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 51780b718f..41253c6749 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -188,7 +188,6 @@ typedef enum __attribute__ ((__packed__)) {
     float_class_inf,
     float_class_qnan,  /* all NaNs from here */
     float_class_snan,
-    float_class_msnan, /* maybe silenced */
 } FloatClass;
 
 /*
@@ -492,14 +491,7 @@ static FloatParts float16_unpack_canonical(float16 f, float_status *s)
 
 static float16 float16_round_pack_canonical(FloatParts p, float_status *s)
 {
-    switch (p.cls) {
-    case float_class_msnan:
-        p.frac >>= float16_params.frac_shift;
-        return float16_maybe_silence_nan(float16_pack_raw(p), s);
-    default:
-        p = round_canonical(p, s, &float16_params);
-        return float16_pack_raw(p);
-    }
+    return float16_pack_raw(round_canonical(p, s, &float16_params));
 }
 
 static FloatParts float32_unpack_canonical(float32 f, float_status *s)
@@ -509,14 +501,7 @@ static FloatParts float32_unpack_canonical(float32 f, float_status *s)
 
 static float32 float32_round_pack_canonical(FloatParts p, float_status *s)
 {
-    switch (p.cls) {
-    case float_class_msnan:
-        p.frac >>= float32_params.frac_shift;
-        return float32_maybe_silence_nan(float32_pack_raw(p), s);
-    default:
-        p = round_canonical(p, s, &float32_params);
-        return float32_pack_raw(p);
-    }
+    return float32_pack_raw(round_canonical(p, s, &float32_params));
 }
 
 static FloatParts float64_unpack_canonical(float64 f, float_status *s)
@@ -526,14 +511,7 @@ static FloatParts float64_unpack_canonical(float64 f, float_status *s)
 
 static float64 float64_round_pack_canonical(FloatParts p, float_status *s)
 {
-    switch (p.cls) {
-    case float_class_msnan:
-        p.frac >>= float64_params.frac_shift;
-        return float64_maybe_silence_nan(float64_pack_raw(p), s);
-    default:
-        p = round_canonical(p, s, &float64_params);
-        return float64_pack_raw(p);
-    }
+    return float64_pack_raw(round_canonical(p, s, &float64_params));
 }
 
 /* Simple helpers for checking if what NaN we have */
@@ -555,7 +533,7 @@ static FloatParts return_nan(FloatParts a, float_status *s)
     switch (a.cls) {
     case float_class_snan:
         s->float_exception_flags |= float_flag_invalid;
-        a.cls = float_class_msnan;
+        a = parts_silence_nan(a, s);
         /* fall through */
     case float_class_qnan:
         if (s->default_nan_mode) {
@@ -584,7 +562,9 @@ static FloatParts pick_nan(FloatParts a, FloatParts b, float_status *s)
                     (a.frac == b.frac && a.sign < b.sign))) {
             a = b;
         }
-        a.cls = float_class_msnan;
+        if (is_snan(a.cls)) {
+            return parts_silence_nan(a, s);
+        }
     }
     return a;
 }
@@ -624,8 +604,10 @@ static FloatParts pick_nan_muladd(FloatParts a, FloatParts b, FloatParts c,
     default:
         g_assert_not_reached();
     }
-    a.cls = float_class_msnan;
 
+    if (is_snan(a.cls)) {
+        return parts_silence_nan(a, s);
+    }
     return a;
 }
 
@@ -1334,7 +1316,6 @@ static int64_t round_to_int_and_pack(FloatParts in, int rmode,
     switch (p.cls) {
     case float_class_snan:
     case float_class_qnan:
-    case float_class_msnan:
         s->float_exception_flags = orig_flags | float_flag_invalid;
         return max;
     case float_class_inf:
@@ -1425,7 +1406,6 @@ static uint64_t round_to_uint_and_pack(FloatParts in, int rmode, uint64_t max,
     switch (p.cls) {
     case float_class_snan:
     case float_class_qnan:
-    case float_class_msnan:
         s->float_exception_flags = orig_flags | float_flag_invalid;
         return max;
     case float_class_inf:
-- 
2.17.0
