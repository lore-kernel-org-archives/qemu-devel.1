Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CADC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 23:46:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C962420663
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 23:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C962420663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVkmo-0002eN-OP
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 19:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jVkey-0002oU-8r
 for qemu-devel@nongnu.org; Mon, 04 May 2020 19:38:04 -0400
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:10519)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jVkew-00024f-PW
 for qemu-devel@nongnu.org; Mon, 04 May 2020 19:38:03 -0400
IronPort-SDR: nAh6sP4TPIm9nS5MKcwbMOafW913chdfPbrGtzBhznTnOzliNd0fQGJglExnHmNF7rjbOqmDB5
 SGWJAJoeJlKlO3DQ3i1ffcO0eU+ZJbo6wozgPcny4HUkPSBolhTC4KUU2c6cyNrqqdKn+WkM/g
 i9ydgmLEIn3b1rBuvslBSf+V3YqCjAevq+Ys9tbmSgRJj5i8vMqvJAaq/K8cJl4UCtLpQCL9Nl
 jfJzhU9xTj+ZOy9R/2VTJII8LVWtKZ/1G/g7L0TyC4P+01DiNQfCobwVacxBevxf1gnb2U1SUv
 IW4=
X-IronPort-AV: E=Sophos;i="5.73,353,1583222400"; d="scan'208";a="48579956"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa4.mentor.iphmx.com with ESMTP; 04 May 2020 15:38:01 -0800
IronPort-SDR: 7pEs3fV6ef80FDW+xwh4O5yI1+IQvk+TKlpMZQBxFZL5lqQILaX7QouL3JnDgCI1v/WpziYkYC
 5yvaJ2WuvS/E+zR+eD+3o8ek/6lHNnwSJFqBDsLjFMZiBIkL2I2NurN1immjwVb4HdjmQpDlqH
 LSya+4fgadhOr/7ajwusavMzXXvp0eySdw5GpsjYIlR4a9fZB96FDsWBFeprz4vcktuwYf9A6u
 +sHPNUbjiAv61/S4K+KNx5DDiIrFakK07dlCML90zHVbj3CB682cCGxr6dFtv+Knutw1EZPiNY
 KPQ=
Date: Mon, 4 May 2020 23:37:54 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: <qemu-devel@nongnu.org>, <aurelien@aurel32.net>,
 <peter.maydell@linaro.org>, <alex.bennee@linaro.org>, <pbonzini@redhat.com>,
 <rth@twiddle.net>, <ehabkost@redhat.com>
Subject: [PATCH v2 1/4] softfloat: silence sNaN for conversions to/from
 floatx80
In-Reply-To: <alpine.DEB.2.21.2005042332380.22972@digraph.polyomino.org.uk>
Message-ID: <alpine.DEB.2.21.2005042336170.22972@digraph.polyomino.org.uk>
References: <alpine.DEB.2.21.2005042332380.22972@digraph.polyomino.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-08.mgc.mentorg.com (139.181.222.8) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Received-SPF: pass client-ip=68.232.137.252;
 envelope-from=joseph_myers@mentor.com; helo=esa4.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 19:36:19
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Conversions between IEEE floating-point formats should convert
signaling NaNs to quiet NaNs.  Most of those in QEMU's softfloat code
do so, but those for floatx80 fail to.  Fix those conversions to
silence signaling NaNs as well.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
---
 fpu/softfloat.c                         | 24 +++++++---
 tests/tcg/i386/test-i386-snan-convert.c | 63 +++++++++++++++++++++++++
 2 files changed, 81 insertions(+), 6 deletions(-)
 create mode 100644 tests/tcg/i386/test-i386-snan-convert.c

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index ae6ba71854..ac116c70b8 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -4498,7 +4498,9 @@ floatx80 float32_to_floatx80(float32 a, float_status *status)
     aSign = extractFloat32Sign( a );
     if ( aExp == 0xFF ) {
         if (aSig) {
-            return commonNaNToFloatx80(float32ToCommonNaN(a, status), status);
+            floatx80 res = commonNaNToFloatx80(float32ToCommonNaN(a, status),
+                                               status);
+            return floatx80_silence_nan(res, status);
         }
         return packFloatx80(aSign,
                             floatx80_infinity_high,
@@ -5016,7 +5018,9 @@ floatx80 float64_to_floatx80(float64 a, float_status *status)
     aSign = extractFloat64Sign( a );
     if ( aExp == 0x7FF ) {
         if (aSig) {
-            return commonNaNToFloatx80(float64ToCommonNaN(a, status), status);
+            floatx80 res = commonNaNToFloatx80(float64ToCommonNaN(a, status),
+                                               status);
+            return floatx80_silence_nan(res, status);
         }
         return packFloatx80(aSign,
                             floatx80_infinity_high,
@@ -5618,7 +5622,9 @@ float32 floatx80_to_float32(floatx80 a, float_status *status)
     aSign = extractFloatx80Sign( a );
     if ( aExp == 0x7FFF ) {
         if ( (uint64_t) ( aSig<<1 ) ) {
-            return commonNaNToFloat32(floatx80ToCommonNaN(a, status), status);
+            float32 res = commonNaNToFloat32(floatx80ToCommonNaN(a, status),
+                                             status);
+            return float32_silence_nan(res, status);
         }
         return packFloat32( aSign, 0xFF, 0 );
     }
@@ -5650,7 +5656,9 @@ float64 floatx80_to_float64(floatx80 a, float_status *status)
     aSign = extractFloatx80Sign( a );
     if ( aExp == 0x7FFF ) {
         if ( (uint64_t) ( aSig<<1 ) ) {
-            return commonNaNToFloat64(floatx80ToCommonNaN(a, status), status);
+            float64 res = commonNaNToFloat64(floatx80ToCommonNaN(a, status),
+                                             status);
+            return float64_silence_nan(res, status);
         }
         return packFloat64( aSign, 0x7FF, 0 );
     }
@@ -5681,7 +5689,9 @@ float128 floatx80_to_float128(floatx80 a, float_status *status)
     aExp = extractFloatx80Exp( a );
     aSign = extractFloatx80Sign( a );
     if ( ( aExp == 0x7FFF ) && (uint64_t) ( aSig<<1 ) ) {
-        return commonNaNToFloat128(floatx80ToCommonNaN(a, status), status);
+        float128 res = commonNaNToFloat128(floatx80ToCommonNaN(a, status),
+                                           status);
+        return float128_silence_nan(res, status);
     }
     shift128Right( aSig<<1, 0, 16, &zSig0, &zSig1 );
     return packFloat128( aSign, aExp, zSig0, zSig1 );
@@ -6959,7 +6969,9 @@ floatx80 float128_to_floatx80(float128 a, float_status *status)
     aSign = extractFloat128Sign( a );
     if ( aExp == 0x7FFF ) {
         if ( aSig0 | aSig1 ) {
-            return commonNaNToFloatx80(float128ToCommonNaN(a, status), status);
+            floatx80 res = commonNaNToFloatx80(float128ToCommonNaN(a, status),
+                                               status);
+            return floatx80_silence_nan(res, status);
         }
         return packFloatx80(aSign, floatx80_infinity_high,
                                    floatx80_infinity_low);
diff --git a/tests/tcg/i386/test-i386-snan-convert.c b/tests/tcg/i386/test-i386-snan-convert.c
new file mode 100644
index 0000000000..ed6d535ce2
--- /dev/null
+++ b/tests/tcg/i386/test-i386-snan-convert.c
@@ -0,0 +1,63 @@
+/* Test conversions of signaling NaNs to and from long double.  */
+
+#include <stdint.h>
+#include <stdio.h>
+
+volatile float f_res;
+volatile double d_res;
+volatile long double ld_res;
+
+volatile float f_snan = __builtin_nansf("");
+volatile double d_snan = __builtin_nans("");
+volatile long double ld_snan = __builtin_nansl("");
+
+int issignaling_f(float x)
+{
+    union { float f; uint32_t u; } u = { .f = x };
+    return (u.u & 0x7fffffff) > 0x7f800000 && (u.u & 0x400000) == 0;
+}
+
+int issignaling_d(double x)
+{
+    union { double d; uint64_t u; } u = { .d = x };
+    return (((u.u & UINT64_C(0x7fffffffffffffff)) >
+            UINT64_C(0x7ff0000000000000)) &&
+            (u.u & UINT64_C(0x8000000000000)) == 0);
+}
+
+int issignaling_ld(long double x)
+{
+    union {
+        long double ld;
+        struct { uint64_t sig; uint16_t sign_exp; } s;
+    } u = { .ld = x };
+    return ((u.s.sign_exp & 0x7fff) == 0x7fff &&
+            (u.s.sig >> 63) != 0 &&
+            (u.s.sig & UINT64_C(0x4000000000000000)) == 0);
+}
+
+int main(void)
+{
+    int ret = 0;
+    ld_res = f_snan;
+    if (issignaling_ld(ld_res)) {
+        printf("FAIL: float -> long double\n");
+        ret = 1;
+    }
+    ld_res = d_snan;
+    if (issignaling_ld(ld_res)) {
+        printf("FAIL: double -> long double\n");
+        ret = 1;
+    }
+    f_res = ld_snan;
+    if (issignaling_d(f_res)) {
+        printf("FAIL: long double -> float\n");
+        ret = 1;
+    }
+    d_res = ld_snan;
+    if (issignaling_d(d_res)) {
+        printf("FAIL: long double -> double\n");
+        ret = 1;
+    }
+    return ret;
+}
-- 
2.17.1


-- 
Joseph S. Myers
joseph@codesourcery.com

