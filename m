Received: from eggs.gnu.org ([2001:4830:134:3::10]:52604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fILi7-0008BF-Qe
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:12:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fILi6-0008D8-KQ
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:12:51 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:43161)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fILi6-0008BM-Eh
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:12:50 -0400
Received: by mail-pg0-x241.google.com with SMTP id p8-v6so2538834pgq.10
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 15:12:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 14 May 2018 15:12:11 -0700
Message-Id: <20180514221219.7091-21-richard.henderson@linaro.org>
In-Reply-To: <20180514221219.7091-1-richard.henderson@linaro.org>
References: <20180514221219.7091-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v5 20/28] fpu/softfloat: Use float*_silence_nan
 in propagateFloat*NaN
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

We have already checked the arguments for SNaN;
we don't need to do it again.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-specialize.h | 44 +++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
index 995a0132c6..4fa068a5dc 100644
--- a/fpu/softfloat-specialize.h
+++ b/fpu/softfloat-specialize.h
@@ -498,7 +498,7 @@ static float32 commonNaNToFloat32(commonNaNT a, float_status *status)
 | The routine is passed various bits of information about the
 | two NaNs and should return 0 to select NaN a and 1 for NaN b.
 | Note that signalling NaNs are always squashed to quiet NaNs
-| by the caller, by calling floatXX_maybe_silence_nan() before
+| by the caller, by calling floatXX_silence_nan() before
 | returning them.
 |
 | aIsLargerSignificand is only valid if both a and b are NaNs
@@ -536,7 +536,7 @@ static int pickNaN(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNaN,
 {
     /* According to MIPS specifications, if one of the two operands is
      * a sNaN, a new qNaN has to be generated. This is done in
-     * floatXX_maybe_silence_nan(). For qNaN inputs the specifications
+     * floatXX_silence_nan(). For qNaN inputs the specifications
      * says: "When possible, this QNaN result is one of the operand QNaN
      * values." In practice it seems that most implementations choose
      * the first operand if both operands are qNaN. In short this gives
@@ -788,9 +788,15 @@ static float32 propagateFloat32NaN(float32 a, float32 b, float_status *status)
 
     if (pickNaN(aIsQuietNaN, aIsSignalingNaN, bIsQuietNaN, bIsSignalingNaN,
                 aIsLargerSignificand)) {
-        return float32_maybe_silence_nan(b, status);
+        if (bIsSignalingNaN) {
+            return float32_silence_nan(b, status);
+        }
+        return b;
     } else {
-        return float32_maybe_silence_nan(a, status);
+        if (aIsSignalingNaN) {
+            return float32_silence_nan(a, status);
+        }
+        return a;
     }
 }
 
@@ -950,9 +956,15 @@ static float64 propagateFloat64NaN(float64 a, float64 b, float_status *status)
 
     if (pickNaN(aIsQuietNaN, aIsSignalingNaN, bIsQuietNaN, bIsSignalingNaN,
                 aIsLargerSignificand)) {
-        return float64_maybe_silence_nan(b, status);
+        if (bIsSignalingNaN) {
+            return float64_silence_nan(b, status);
+        }
+        return b;
     } else {
-        return float64_maybe_silence_nan(a, status);
+        if (aIsSignalingNaN) {
+            return float64_silence_nan(a, status);
+        }
+        return a;
     }
 }
 
@@ -1121,9 +1133,15 @@ floatx80 propagateFloatx80NaN(floatx80 a, floatx80 b, float_status *status)
 
     if (pickNaN(aIsQuietNaN, aIsSignalingNaN, bIsQuietNaN, bIsSignalingNaN,
                 aIsLargerSignificand)) {
-        return floatx80_maybe_silence_nan(b, status);
+        if (bIsSignalingNaN) {
+            return floatx80_silence_nan(b, status);
+        }
+        return b;
     } else {
-        return floatx80_maybe_silence_nan(a, status);
+        if (aIsSignalingNaN) {
+            return floatx80_silence_nan(a, status);
+        }
+        return a;
     }
 }
 
@@ -1270,8 +1288,14 @@ static float128 propagateFloat128NaN(float128 a, float128 b,
 
     if (pickNaN(aIsQuietNaN, aIsSignalingNaN, bIsQuietNaN, bIsSignalingNaN,
                 aIsLargerSignificand)) {
-        return float128_maybe_silence_nan(b, status);
+        if (bIsSignalingNaN) {
+            return float128_silence_nan(b, status);
+        }
+        return b;
     } else {
-        return float128_maybe_silence_nan(a, status);
+        if (aIsSignalingNaN) {
+            return float128_silence_nan(a, status);
+        }
+        return a;
     }
 }
-- 
2.17.0
