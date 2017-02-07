Received: from eggs.gnu.org ([2001:4830:134:3::10]:54946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cb0lk-0000DB-BR
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 03:04:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cb0lb-0004q8-3n
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 03:04:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1cb0la-0004pf-RU
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 03:04:47 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1783s4X059454
	for <qemu-devel@nongnu.org>; Tue, 7 Feb 2017 03:04:45 -0500
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28euphr33a-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 03:04:44 -0500
Received: from localhost
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Tue, 7 Feb 2017 13:34:41 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Tue,  7 Feb 2017 13:34:36 +0530
In-Reply-To: <1486454676-29112-1-git-send-email-bharata@linux.vnet.ibm.com>
References: <1486454676-29112-1-git-send-email-bharata@linux.vnet.ibm.com>
Message-Id: <1486454676-29112-3-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v1 2/2] softfloat: Add
 float128_to_uint32_round_to_zero()
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

float128_to_uint32_round_to_zero() is needed by xscvqpuwz instruction
of PowerPC ISA 3.0.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
---
 fpu/softfloat.c         | 28 ++++++++++++++++++++++++++++
 include/fpu/softfloat.h |  1 +
 2 files changed, 29 insertions(+)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 4a4b50b..ed76629 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -6169,6 +6169,34 @@ uint64_t float128_to_uint64_round_to_zero(float128 a, float_status *status)
 
 /*----------------------------------------------------------------------------
 | Returns the result of converting the quadruple-precision floating-point
+| value `a' to the 32-bit unsigned integer format.  The conversion
+| is performed according to the IEC/IEEE Standard for Binary Floating-Point
+| Arithmetic except that the conversion is always rounded toward zero.
+| If `a' is a NaN, the largest positive integer is returned.  Otherwise,
+| if the conversion overflows, the largest unsigned integer is returned.
+| If 'a' is negative, the value is rounded and zero is returned; negative
+| values that do not round to zero will raise the inexact exception.
+*----------------------------------------------------------------------------*/
+
+uint32_t float128_to_uint32_round_to_zero(float128 a, float_status *status)
+{
+    int64_t v;
+    uint32_t res;
+    int old_exc_flags = get_float_exception_flags(status);
+
+    v = float128_to_uint64_round_to_zero(a, status);
+    if (v > 0xffffffff) {
+        res = 0xffffffff;
+    } else {
+        return v;
+    }
+    set_float_exception_flags(old_exc_flags, status);
+    float_raise(float_flag_invalid, status);
+    return res;
+}
+
+/*----------------------------------------------------------------------------
+| Returns the result of converting the quadruple-precision floating-point
 | value `a' to the single-precision floating-point format.  The conversion
 | is performed according to the IEC/IEEE Standard for Binary Floating-Point
 | Arithmetic.
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 4e99253..9eb5a6b 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -714,6 +714,7 @@ int64_t float128_to_int64(float128, float_status *status);
 int64_t float128_to_int64_round_to_zero(float128, float_status *status);
 uint64_t float128_to_uint64(float128, float_status *status);
 uint64_t float128_to_uint64_round_to_zero(float128, float_status *status);
+uint32_t float128_to_uint32_round_to_zero(float128, float_status *status);
 float32 float128_to_float32(float128, float_status *status);
 float64 float128_to_float64(float128, float_status *status);
 floatx80 float128_to_floatx80(float128, float_status *status);
-- 
2.7.4
