Received: from eggs.gnu.org ([208.118.235.92]:58284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gbgkC-00011S-UE
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 02:03:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gbgk7-0008QT-VG
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 02:03:12 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52511)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gbgk7-0008QE-NT
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 02:03:07 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 25 Dec 2018 02:03:05 -0500
Message-Id: <20181225070305.18221-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2] softfloat: enforce softfloat if the host's
 FMA is broken
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, laurent.desnogues@gmail.com

The added branch to the FMA ops is marked as unlikely and therefore
its impact on performance (measured with fp-bench) is within noise range
when measured on an Intel(R) Xeon(R) Gold 6142 CPU @ 2.60GHz.

Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
v2: drop the cpuid bits, since that work (1) is only a performance
optimization, not a correctness fix and (2) requires additional
consolidation work that I do not have time to do right now.

 fpu/softfloat.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 59eac97d10..9132d7a0b0 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1542,6 +1542,8 @@ soft_f64_muladd(float64 a, float64 b, float64 c, int flags,
     return float64_round_pack_canonical(pr, status);
 }
 
+static bool force_soft_fma;
+
 float32 QEMU_FLATTEN
 float32_muladd(float32 xa, float32 xb, float32 xc, int flags, float_status *s)
 {
@@ -1562,6 +1564,11 @@ float32_muladd(float32 xa, float32 xb, float32 xc, int flags, float_status *s)
     if (unlikely(!f32_is_zon3(ua, ub, uc))) {
         goto soft;
     }
+
+    if (unlikely(force_soft_fma)) {
+        goto soft;
+    }
+
     /*
      * When (a || b) == 0, there's no need to check for under/over flow,
      * since we know the addend is (normal || 0) and the product is 0.
@@ -1623,6 +1630,11 @@ float64_muladd(float64 xa, float64 xb, float64 xc, int flags, float_status *s)
     if (unlikely(!f64_is_zon3(ua, ub, uc))) {
         goto soft;
     }
+
+    if (unlikely(force_soft_fma)) {
+        goto soft;
+    }
+
     /*
      * When (a || b) == 0, there's no need to check for under/over flow,
      * since we know the addend is (normal || 0) and the product is 0.
@@ -7974,3 +7986,24 @@ float128 float128_scalbn(float128 a, int n, float_status *status)
                                          , status);
 
 }
+
+static void __attribute__((constructor)) softfloat_init(void)
+{
+    union_float64 ua, ub, uc, ur;
+
+    if (QEMU_NO_HARDFLOAT) {
+        return;
+    }
+    /*
+     * Test that the host's FMA is not obviously broken. For example,
+     * glibc < 2.23 can perform an incorrect FMA on certain hosts; see
+     *   https://sourceware.org/bugzilla/show_bug.cgi?id=13304
+     */
+    ua.s = 0x0020000000000001ULL;
+    ub.s = 0x3ca0000000000000ULL;
+    uc.s = 0x0020000000000000ULL;
+    ur.h = fma(ua.h, ub.h, uc.h);
+    if (ur.s != 0x0020000000000001ULL) {
+        force_soft_fma = true;
+    }
+}
-- 
2.17.1
