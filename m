Received: from eggs.gnu.org ([209.51.188.92]:48000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ggu8m-0004HR-6W
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:22:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ggu8g-0000jY-Sm
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:22:05 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35990)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ggu8f-0000Uz-Dt
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:22:02 -0500
Received: by mail-wr1-x442.google.com with SMTP id u4so4673521wrp.3
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 08:21:59 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  8 Jan 2019 16:21:51 +0000
Message-Id: <20190108162154.22259-4-alex.bennee@linaro.org>
In-Reply-To: <20190108162154.22259-1-alex.bennee@linaro.org>
References: <20190108162154.22259-1-alex.bennee@linaro.org>
Subject: [Qemu-devel] [PATCH v1 3/6] softfloat: enforce softfloat if the
 host's FMA is broken
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: "Emilio G. Cota" <cota@braap.org>

The added branch to the FMA ops is marked as unlikely and therefore
its impact on performance (measured with fp-bench) is within noise range
when measured on an Intel(R) Xeon(R) Gold 6142 CPU @ 2.60GHz.

In addition, when the host doesn't have a hardware FMA instruction
we force the use of softfloat, since whatever the libc does (e.g. checking
the host's FP flags) is unlikely to be faster than our softfloat
implementation. For instance, on an i386 machine with no hardware
support for FMA, we get:

  $ for precision in single double; do
        ./fp-bench -o mulAdd -p $precision
    done

- before:
5.07 MFlops
1.85 MFlops

- after:
12.65 MFlops
10.05 MFlops

Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 fpu/softfloat.c      | 85 ++++++++++++++++++++++++++++++++++++++++++++
 include/qemu/cpuid.h |  6 ++++
 2 files changed, 91 insertions(+)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 59eac97d10..ccaed85b0f 100644
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
@@ -7974,3 +7986,76 @@ float128 float128_scalbn(float128 a, int n, float_status *status)
                                          , status);
 
 }
+
+#ifdef CONFIG_CPUID_H
+#include "qemu/cpuid.h"
+#endif
+
+static void check_host_hw_fma(void)
+{
+#ifdef CONFIG_CPUID_H
+    int max = __get_cpuid_max(0, NULL);
+    int a, b, c, d;
+    bool has_fma3 = false;
+    bool has_fma4 = false;
+    bool has_avx = false;
+
+    if (max >= 1) {
+        __cpuid(1, a, b, c, d);
+
+        /* check whether avx is usable */
+        if (c & bit_OSXSAVE) {
+            int bv;
+
+            __asm("xgetbv" : "=a"(bv), "=d"(d) : "c"(0));
+            if ((bv & 6) == 6) {
+                has_avx = c & bit_AVX;
+            }
+        }
+
+        if (has_avx) {
+            /* fma3 */
+            has_fma3 = c & bit_FMA3;
+
+            /* fma4 */
+            __cpuid(0x80000000, a, b, c, d);
+            if (a >= 0x80000001) {
+                __cpuid(0x80000001, a, b, c, d);
+
+                has_fma4 = c & bit_FMA4;
+            }
+        }
+    }
+    /*
+     * Without HW FMA, whatever the libc does is probably slower than our
+     * softfloat implementation.
+     */
+    if (!has_fma3 && !has_fma4) {
+        force_soft_fma = true;
+    }
+#endif
+}
+
+static void __attribute__((constructor)) softfloat_init(void)
+{
+    union_float64 ua, ub, uc, ur;
+
+    if (QEMU_NO_HARDFLOAT) {
+        return;
+    }
+
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
+
+    check_host_hw_fma();
+}
diff --git a/include/qemu/cpuid.h b/include/qemu/cpuid.h
index 69301700bd..320926ffe0 100644
--- a/include/qemu/cpuid.h
+++ b/include/qemu/cpuid.h
@@ -25,6 +25,9 @@
 #endif
 
 /* Leaf 1, %ecx */
+#ifndef bit_FMA3
+#define bit_FMA3        (1 << 12)
+#endif
 #ifndef bit_SSE4_1
 #define bit_SSE4_1      (1 << 19)
 #endif
@@ -53,5 +56,8 @@
 #ifndef bit_LZCNT
 #define bit_LZCNT       (1 << 5)
 #endif
+#ifndef bit_FMA4
+#define bit_FMA4        (1 << 16)
+#endif
 
 #endif /* QEMU_CPUID_H */
-- 
2.17.1
