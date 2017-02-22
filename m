Received: from eggs.gnu.org ([2001:4830:134:3::10]:37895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQV8-000357-Lt
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQV5-00083p-Vx
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:10 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 22 Feb 2017 17:33:28 +1100
Message-Id: <20170222063348.32176-24-david@gibson.dropbear.id.au>
In-Reply-To: <20170222063348.32176-1-david@gibson.dropbear.id.au>
References: <20170222063348.32176-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 23/43] softfloat: Add
 float128_to_uint64_round_to_zero()
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

Implement float128_to_uint64() and use that to implement
float128_to_uint64_round_to_zero()

This is required by xscvqpudz instruction of PowerPC ISA 3.0.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 fpu/softfloat.c         | 59 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/fpu/softfloat.h |  2 ++
 2 files changed, 61 insertions(+)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 5ccba76..47e4646 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -6128,6 +6128,65 @@ int64_t float128_to_int64_round_to_zero(float128 a, float_status *status)
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
index 8a39028..a09ad0e 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -714,6 +714,8 @@ int32_t float128_to_int32(float128, float_status *status);
 int32_t float128_to_int32_round_to_zero(float128, float_status *status);
 int64_t float128_to_int64(float128, float_status *status);
 int64_t float128_to_int64_round_to_zero(float128, float_status *status);
+uint64_t float128_to_uint64(float128, float_status *status);
+uint64_t float128_to_uint64_round_to_zero(float128, float_status *status);
 float32 float128_to_float32(float128, float_status *status);
 float64 float128_to_float64(float128, float_status *status);
 floatx80 float128_to_floatx80(float128, float_status *status);
-- 
2.9.3
