Received: from eggs.gnu.org ([2001:4830:134:3::10]:52394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fILhm-0007oZ-0D
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:12:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fILhk-0007Ob-7q
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:12:29 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:39427)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fILhj-0007Ms-VV
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:12:28 -0400
Received: by mail-pg0-x242.google.com with SMTP id e1-v6so6066289pga.6
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 15:12:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 14 May 2018 15:11:54 -0700
Message-Id: <20180514221219.7091-4-richard.henderson@linaro.org>
In-Reply-To: <20180514221219.7091-1-richard.henderson@linaro.org>
References: <20180514221219.7091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 03/28] fpu/softfloat: Split
 floatXX_silence_nan from floatXX_maybe_silence_nan
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org

The new function assumes that the input is an SNaN and
does not double-check.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-specialize.h | 174 +++++++++++++++++++++++++------------
 include/fpu/softfloat.h    |   5 ++
 2 files changed, 123 insertions(+), 56 deletions(-)

diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
index 58b05718c8..4fc9ea4ac0 100644
--- a/fpu/softfloat-specialize.h
+++ b/fpu/softfloat-specialize.h
@@ -271,22 +271,35 @@ int float16_is_signaling_nan(float16 a_, float_status *status)
 #endif
 }
 
+/*----------------------------------------------------------------------------
+| Returns a quiet NaN from a signalling NaN for the half-precision
+| floating point value `a'.
+*----------------------------------------------------------------------------*/
+
+float16 float16_silence_nan(float16 a, float_status *status)
+{
+#ifdef NO_SIGNALING_NANS
+    g_assert_not_reached();
+#else
+    if (status->snan_bit_is_one) {
+        return float16_default_nan(status);
+    } else {
+        return a | (1 << 9);
+    }
+#endif
+}
+
 /*----------------------------------------------------------------------------
 | Returns a quiet NaN if the half-precision floating point value `a' is a
 | signaling NaN; otherwise returns `a'.
 *----------------------------------------------------------------------------*/
-float16 float16_maybe_silence_nan(float16 a_, float_status *status)
+
+float16 float16_maybe_silence_nan(float16 a, float_status *status)
 {
-    if (float16_is_signaling_nan(a_, status)) {
-        if (status->snan_bit_is_one) {
-            return float16_default_nan(status);
-        } else {
-            uint16_t a = float16_val(a_);
-            a |= (1 << 9);
-            return make_float16(a);
-        }
+    if (float16_is_signaling_nan(a, status)) {
+        return float16_silence_nan(a, status);
     }
-    return a_;
+    return a;
 }
 
 /*----------------------------------------------------------------------------
@@ -367,30 +380,40 @@ int float32_is_signaling_nan(float32 a_, float_status *status)
 #endif
 }
 
+/*----------------------------------------------------------------------------
+| Returns a quiet NaN from a signalling NaN for the single-precision
+| floating point value `a'.
+*----------------------------------------------------------------------------*/
+
+float32 float32_silence_nan(float32 a, float_status *status)
+{
+#ifdef NO_SIGNALING_NANS
+    g_assert_not_reached();
+#else
+    if (status->snan_bit_is_one) {
+# ifdef TARGET_HPPA
+        a &= ~0x00400000;
+        a |=  0x00200000;
+        return a;
+# else
+        return float32_default_nan(status);
+# endif
+    } else {
+        return a | (1 << 22);
+    }
+#endif
+}
 /*----------------------------------------------------------------------------
 | Returns a quiet NaN if the single-precision floating point value `a' is a
 | signaling NaN; otherwise returns `a'.
 *----------------------------------------------------------------------------*/
 
-float32 float32_maybe_silence_nan(float32 a_, float_status *status)
+float32 float32_maybe_silence_nan(float32 a, float_status *status)
 {
-    if (float32_is_signaling_nan(a_, status)) {
-        if (status->snan_bit_is_one) {
-#ifdef TARGET_HPPA
-            uint32_t a = float32_val(a_);
-            a &= ~0x00400000;
-            a |=  0x00200000;
-            return make_float32(a);
-#else
-            return float32_default_nan(status);
-#endif
-        } else {
-            uint32_t a = float32_val(a_);
-            a |= (1 << 22);
-            return make_float32(a);
-        }
+    if (float32_is_signaling_nan(a, status)) {
+        return float32_silence_nan(a, status);
     }
-    return a_;
+    return a;
 }
 
 /*----------------------------------------------------------------------------
@@ -776,30 +799,41 @@ int float64_is_signaling_nan(float64 a_, float_status *status)
 #endif
 }
 
+/*----------------------------------------------------------------------------
+| Returns a quiet NaN from a signalling NaN for the double-precision
+| floating point value `a'.
+*----------------------------------------------------------------------------*/
+
+float64 float64_silence_nan(float64 a, float_status *status)
+{
+#ifdef NO_SIGNALING_NANS
+    g_assert_not_reached();
+#else
+    if (status->snan_bit_is_one) {
+# ifdef TARGET_HPPA
+        a &= ~0x0008000000000000ULL;
+        a |=  0x0004000000000000ULL;
+        return a;
+# else
+        return float64_default_nan(status);
+# endif
+    } else {
+        return a | LIT64(0x0008000000000000);
+    }
+#endif
+}
+
 /*----------------------------------------------------------------------------
 | Returns a quiet NaN if the double-precision floating point value `a' is a
 | signaling NaN; otherwise returns `a'.
 *----------------------------------------------------------------------------*/
 
-float64 float64_maybe_silence_nan(float64 a_, float_status *status)
+float64 float64_maybe_silence_nan(float64 a, float_status *status)
 {
-    if (float64_is_signaling_nan(a_, status)) {
-        if (status->snan_bit_is_one) {
-#ifdef TARGET_HPPA
-            uint64_t a = float64_val(a_);
-            a &= ~0x0008000000000000ULL;
-            a |=  0x0004000000000000ULL;
-            return make_float64(a);
-#else
-            return float64_default_nan(status);
-#endif
-        } else {
-            uint64_t a = float64_val(a_);
-            a |= LIT64(0x0008000000000000);
-            return make_float64(a);
-        }
+    if (float64_is_signaling_nan(a, status)) {
+        return float64_silence_nan(a, status);
     }
-    return a_;
+    return a;
 }
 
 /*----------------------------------------------------------------------------
@@ -937,6 +971,25 @@ int floatx80_is_signaling_nan(floatx80 a, float_status *status)
 #endif
 }
 
+/*----------------------------------------------------------------------------
+| Returns a quiet NaN from a signalling NaN for the extended double-precision
+| floating point value `a'.
+*----------------------------------------------------------------------------*/
+
+floatx80 floatx80_silence_nan(floatx80 a, float_status *status)
+{
+#ifdef NO_SIGNALING_NANS
+    g_assert_not_reached();
+#else
+    if (status->snan_bit_is_one) {
+        return floatx80_default_nan(status);
+    } else {
+        a.low |= LIT64(0xC000000000000000);
+        return a;
+    }
+#endif
+}
+
 /*----------------------------------------------------------------------------
 | Returns a quiet NaN if the extended double-precision floating point value
 | `a' is a signaling NaN; otherwise returns `a'.
@@ -945,12 +998,7 @@ int floatx80_is_signaling_nan(floatx80 a, float_status *status)
 floatx80 floatx80_maybe_silence_nan(floatx80 a, float_status *status)
 {
     if (floatx80_is_signaling_nan(a, status)) {
-        if (status->snan_bit_is_one) {
-            a = floatx80_default_nan(status);
-        } else {
-            a.low |= LIT64(0xC000000000000000);
-            return a;
-        }
+        return floatx80_silence_nan(a, status);
     }
     return a;
 }
@@ -1084,6 +1132,25 @@ int float128_is_signaling_nan(float128 a, float_status *status)
 #endif
 }
 
+/*----------------------------------------------------------------------------
+| Returns a quiet NaN from a signalling NaN for the quadruple-precision
+| floating point value `a'.
+*----------------------------------------------------------------------------*/
+
+float128 float128_silence_nan(float128 a, float_status *status)
+{
+#ifdef NO_SIGNALING_NANS
+    g_assert_not_reached();
+#else
+    if (status->snan_bit_is_one) {
+        return float128_default_nan(status);
+    } else {
+        a.high |= LIT64(0x0000800000000000);
+        return a;
+    }
+#endif
+}
+
 /*----------------------------------------------------------------------------
 | Returns a quiet NaN if the quadruple-precision floating point value `a' is
 | a signaling NaN; otherwise returns `a'.
@@ -1092,12 +1159,7 @@ int float128_is_signaling_nan(float128 a, float_status *status)
 float128 float128_maybe_silence_nan(float128 a, float_status *status)
 {
     if (float128_is_signaling_nan(a, status)) {
-        if (status->snan_bit_is_one) {
-            a = float128_default_nan(status);
-        } else {
-            a.high |= LIT64(0x0000800000000000);
-            return a;
-        }
+        return float128_silence_nan(a, status);
     }
     return a;
 }
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 36626a501b..43962dc3f5 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -257,6 +257,7 @@ int float16_compare_quiet(float16, float16, float_status *status);
 
 int float16_is_quiet_nan(float16, float_status *status);
 int float16_is_signaling_nan(float16, float_status *status);
+float16 float16_silence_nan(float16, float_status *status);
 float16 float16_maybe_silence_nan(float16, float_status *status);
 
 static inline int float16_is_any_nan(float16 a)
@@ -368,6 +369,7 @@ float32 float32_minnummag(float32, float32, float_status *status);
 float32 float32_maxnummag(float32, float32, float_status *status);
 int float32_is_quiet_nan(float32, float_status *status);
 int float32_is_signaling_nan(float32, float_status *status);
+float32 float32_silence_nan(float32, float_status *status);
 float32 float32_maybe_silence_nan(float32, float_status *status);
 float32 float32_scalbn(float32, int, float_status *status);
 
@@ -497,6 +499,7 @@ float64 float64_minnummag(float64, float64, float_status *status);
 float64 float64_maxnummag(float64, float64, float_status *status);
 int float64_is_quiet_nan(float64 a, float_status *status);
 int float64_is_signaling_nan(float64, float_status *status);
+float64 float64_silence_nan(float64, float_status *status);
 float64 float64_maybe_silence_nan(float64, float_status *status);
 float64 float64_scalbn(float64, int, float_status *status);
 
@@ -600,6 +603,7 @@ int floatx80_compare(floatx80, floatx80, float_status *status);
 int floatx80_compare_quiet(floatx80, floatx80, float_status *status);
 int floatx80_is_quiet_nan(floatx80, float_status *status);
 int floatx80_is_signaling_nan(floatx80, float_status *status);
+floatx80 floatx80_silence_nan(floatx80, float_status *status);
 floatx80 floatx80_maybe_silence_nan(floatx80, float_status *status);
 floatx80 floatx80_scalbn(floatx80, int, float_status *status);
 
@@ -811,6 +815,7 @@ int float128_compare(float128, float128, float_status *status);
 int float128_compare_quiet(float128, float128, float_status *status);
 int float128_is_quiet_nan(float128, float_status *status);
 int float128_is_signaling_nan(float128, float_status *status);
+float128 float128_silence_nan(float128, float_status *status);
 float128 float128_maybe_silence_nan(float128, float_status *status);
 float128 float128_scalbn(float128, int, float_status *status);
 
-- 
2.17.0
