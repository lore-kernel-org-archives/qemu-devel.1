Received: from eggs.gnu.org ([2001:4830:134:3::10]:37597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cHxxa-00025n-77
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 14:14:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cHxxW-0000TA-8j
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 14:14:26 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:33597)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cHxxW-0000SW-3z
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 14:14:22 -0500
Received: by mail-pg0-x241.google.com with SMTP id 3so10556528pgd.0
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 11:14:22 -0800 (PST)
Received: from bigtime.domain ([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	c22sm13735067pgn.12.2016.12.16.11.14.20 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 16 Dec 2016 11:14:20 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 16 Dec 2016 11:13:56 -0800
Message-Id: <20161216191405.9473-18-rth@twiddle.net>
In-Reply-To: <20161216191405.9473-1-rth@twiddle.net>
References: <20161216191405.9473-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 17/26] target-hppa: Add softfloat
 specializations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Like the original MIPS, HPPA has the MSB of an SNaN set.
However, it has different rules for silencing an SNaN:
(1) msb is cleared and (2) msb-1 must be set if the fraction
is now zero, and (implementation defined) may be set always.
I haven't checked real hardware but chose the set always
alternative because it's easy and within spec.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 fpu/softfloat-specialize.h | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
index f5aed72..f05c865 100644
--- a/fpu/softfloat-specialize.h
+++ b/fpu/softfloat-specialize.h
@@ -116,6 +116,8 @@ float32 float32_default_nan(float_status *status)
 #elif defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_ALPHA) || \
       defined(TARGET_XTENSA) || defined(TARGET_S390X) || defined(TARGET_TRICORE)
     return const_float32(0x7FC00000);
+#elif defined(TARGET_HPPA)
+    return const_float32(0x7FA00000);
 #else
     if (status->snan_bit_is_one) {
         return const_float32(0x7FBFFFFF);
@@ -139,6 +141,8 @@ float64 float64_default_nan(float_status *status)
 #elif defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_ALPHA) || \
       defined(TARGET_S390X)
     return const_float64(LIT64(0x7FF8000000000000));
+#elif defined(TARGET_HPPA)
+    return const_float64(LIT64(0x7FF4000000000000));
 #else
     if (status->snan_bit_is_one) {
         return const_float64(LIT64(0x7FF7FFFFFFFFFFFF));
@@ -361,7 +365,14 @@ float32 float32_maybe_silence_nan(float32 a_, float_status *status)
 {
     if (float32_is_signaling_nan(a_, status)) {
         if (status->snan_bit_is_one) {
+#ifdef TARGET_HPPA
+            uint32_t a = float32_val(a_);
+            a &= ~0x00400000;
+            a |=  0x00200000;
+            return make_float32(a);
+#else
             return float32_default_nan(status);
+#endif
         } else {
             uint32_t a = float32_val(a_);
             a |= (1 << 22);
@@ -449,7 +460,7 @@ static int pickNaN(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNaN,
         return 1;
     }
 }
-#elif defined(TARGET_MIPS)
+#elif defined(TARGET_MIPS) || defined(TARGET_HPPA)
 static int pickNaN(flag aIsQNaN, flag aIsSNaN, flag bIsQNaN, flag bIsSNaN,
                     flag aIsLargerSignificand)
 {
@@ -794,7 +805,14 @@ float64 float64_maybe_silence_nan(float64 a_, float_status *status)
 {
     if (float64_is_signaling_nan(a_, status)) {
         if (status->snan_bit_is_one) {
+#ifdef TARGET_HPPA
+            uint64_t a = float64_val(a_);
+            a &= ~0x0008000000000000ULL;
+            a |=  0x0004000000000000ULL;
+            return make_float64(a);
+#else
             return float64_default_nan(status);
+#endif
         } else {
             uint64_t a = float64_val(a_);
             a |= LIT64(0x0008000000000000);
-- 
2.9.3
