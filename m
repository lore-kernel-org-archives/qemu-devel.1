Received: from eggs.gnu.org ([2001:4830:134:3::10]:54968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cb0ll-0000E5-Oe
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 03:05:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cb0lf-0004tV-ED
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 03:04:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1cb0lf-0004rv-67
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 03:04:51 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1783qoC059196
	for <qemu-devel@nongnu.org>; Tue, 7 Feb 2017 03:04:50 -0500
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28euphr33v-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 03:04:49 -0500
Received: from localhost
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Tue, 7 Feb 2017 13:34:42 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Tue,  7 Feb 2017 13:34:35 +0530
In-Reply-To: <1486454676-29112-1-git-send-email-bharata@linux.vnet.ibm.com>
References: <1486454676-29112-1-git-send-email-bharata@linux.vnet.ibm.com>
Message-Id: <1486454676-29112-2-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v1 1/2] softfloat: Add
 float128_to_uint64_round_to_zero()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, nikunj@linux.vnet.ibm.com, peter.maydell@linaro.org, Bharata B Rao <bharata@linux.vnet.ibm.com>

Implement float128_to_uint64() and use that to implement
float128_to_uint64_round_to_zero()

This is required by xscvqpudz instruction of PowerPC ISA 3.0.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
---
 fpu/softfloat.c         | 59 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/fpu/softfloat.h |  2 ++
 2 files changed, 61 insertions(+)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index c295f31..4a4b50b 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -6109,6 +6109,65 @@ int64_t float128_to_int64_round_to_zero(float128 a, float_status *status)
 }
 
 /*----------------------------------------------------------------------------
+| Returns the result of converting the quadruple-precision floating-point value
+| `a' to the 64-bit unsigned integer format.  The conversion is
+| performed according to the IEC/IEEE Standard for Binary Floating-Point
+| Arithmetic---which means in particular that the conversion is rounded
+| according to the current rounding mode.  If `a' is a NaN, the largest
+| positive integer is returned.  If the conversion overflows, the
+| largest unsigned integer is returned.  If 'a' is negative, the value is
+| rounded and zero is returned; negative values that do not round to zero
+| will raise the inexact exception.
+*----------------------------------------------------------------------------*/
+
+uint64_t float128_to_uint64(float128 a, float_status *status)
+{
+    flag aSign;
+    int aExp;
+    int shiftCount;
+    uint64_t aSig0, aSig1;
+
+    aSig0 = extractFloat128Frac0(a);
+    aSig1 = extractFloat128Frac1(a);
+    aExp = extractFloat128Exp(a);
+    aSign = extractFloat128Sign(a);
+    if (aSign && (aExp > 0x3FFE)) {
+        float_raise(float_flag_invalid, status);
+        if (float128_is_any_nan(a)) {
+            return LIT64(0xFFFFFFFFFFFFFFFF);
+        } else {
+            return 0;
+        }
+    }
+    if (aExp) {
+        aSig0 |= LIT64(0x0001000000000000);
+    }
+    shiftCount = 0x402F - aExp;
+    if (shiftCount <= 0) {
+        if (0x403E < aExp) {
+            float_raise(float_flag_invalid, status);
+            return LIT64(0xFFFFFFFFFFFFFFFF);
+        }
+        shortShift128Left(aSig0, aSig1, -shiftCount, &aSig0, &aSig1);
+    } else {
+        shift64ExtraRightJamming(aSig0, aSig1, shiftCount, &aSig0, &aSig1);
+    }
+    return roundAndPackUint64(aSign, aSig0, aSig1, status);
+}
+
+uint64_t float128_to_uint64_round_to_zero(float128 a, float_status *status)
+{
+    uint64_t v;
+    signed char current_rounding_mode = status->float_rounding_mode;
+
+    set_float_rounding_mode(float_round_to_zero, status);
+    v = float128_to_uint64(a, status);
+    set_float_rounding_mode(current_rounding_mode, status);
+
+    return v;
+}
+
+/*----------------------------------------------------------------------------
 | Returns the result of converting the quadruple-precision floating-point
 | value `a' to the single-precision floating-point format.  The conversion
 | is performed according to the IEC/IEEE Standard for Binary Floating-Point
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 842ec6b..4e99253 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -712,6 +712,8 @@ int32_t float128_to_int32(float128, float_status *status);
 int32_t float128_to_int32_round_to_zero(float128, float_status *status);
 int64_t float128_to_int64(float128, float_status *status);
 int64_t float128_to_int64_round_to_zero(float128, float_status *status);
+uint64_t float128_to_uint64(float128, float_status *status);
+uint64_t float128_to_uint64_round_to_zero(float128, float_status *status);
 float32 float128_to_float32(float128, float_status *status);
 float64 float128_to_float64(float128, float_status *status);
 floatx80 float128_to_floatx80(float128, float_status *status);
-- 
2.7.4
