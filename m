Received: from eggs.gnu.org ([2001:4830:134:3::10]:60151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cc5Z9-0007Es-M1
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 02:24:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cc5Z6-0000M0-HH
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 02:24:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43025)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1cc5Z6-0000LI-7p
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 02:24:20 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1A7Il1j028904
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 02:24:19 -0500
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28h4cn90pk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 02:24:18 -0500
Received: from localhost
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Fri, 10 Feb 2017 17:24:16 +1000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Fri, 10 Feb 2017 12:53:07 +0530
In-Reply-To: <1486711391-12247-1-git-send-email-bharata@linux.vnet.ibm.com>
References: <1486711391-12247-1-git-send-email-bharata@linux.vnet.ibm.com>
Message-Id: <1486711391-12247-4-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 3/7] softfloat: Add
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
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, nikunj@linux.vnet.ibm.com, Bharata B Rao <bharata@linux.vnet.ibm.com>

float128_to_uint32_round_to_zero() is needed by xscvqpuwz instruction
of PowerPC ISA 3.0.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
Earlier posted separately at:
https://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg01326.html

 fpu/softfloat.c         | 28 ++++++++++++++++++++++++++++
 include/fpu/softfloat.h |  1 +
 2 files changed, 29 insertions(+)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 47e4646..485a006 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -6188,6 +6188,34 @@ uint64_t float128_to_uint64_round_to_zero(float128 a, float_status *status)
 
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
+    uint64_t v;
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
index a09ad0e..f1288ef 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -716,6 +716,7 @@ int64_t float128_to_int64(float128, float_status *status);
 int64_t float128_to_int64_round_to_zero(float128, float_status *status);
 uint64_t float128_to_uint64(float128, float_status *status);
 uint64_t float128_to_uint64_round_to_zero(float128, float_status *status);
+uint32_t float128_to_uint32_round_to_zero(float128, float_status *status);
 float32 float128_to_float32(float128, float_status *status);
 float64 float128_to_float64(float128, float_status *status);
 floatx80 float128_to_floatx80(float128, float_status *status);
-- 
2.7.4
