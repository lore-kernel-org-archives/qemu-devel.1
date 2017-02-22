Received: from eggs.gnu.org ([2001:4830:134:3::10]:37835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQV7-000334-H5
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQV4-00081b-SS
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:09 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 22 Feb 2017 17:33:29 +1100
Message-Id: <20170222063348.32176-25-david@gibson.dropbear.id.au>
In-Reply-To: <20170222063348.32176-1-david@gibson.dropbear.id.au>
References: <20170222063348.32176-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 24/43] softfloat: Add
 float128_to_uint32_round_to_zero()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, imammedo@redhat.com, Bharata B Rao <bharata@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Bharata B Rao <bharata@linux.vnet.ibm.com>

float128_to_uint32_round_to_zero() is needed by xscvqpuwz instruction
of PowerPC ISA 3.0.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
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
2.9.3
