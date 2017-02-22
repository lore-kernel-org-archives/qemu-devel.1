Received: from eggs.gnu.org ([2001:4830:134:3::10]:37893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQV8-000353-Lw
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQV5-00083a-Ry
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:10 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 22 Feb 2017 17:33:27 +1100
Message-Id: <20170222063348.32176-23-david@gibson.dropbear.id.au>
In-Reply-To: <20170222063348.32176-1-david@gibson.dropbear.id.au>
References: <20170222063348.32176-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 22/43] softfloat: Add round-to-odd rounding mode
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

Power ISA 3.0 introduces a few quadruple precision floating point
instructions that support round-to-odd rounding mode. The
round-to-odd mode is explained as under:

Let Z be the intermediate arithmetic result or the operand of a convert
operation. If Z can be represented exactly in the target format, the
result is Z. Otherwise the result is either Z1 or Z2 whichever is odd.
Here Z1 and Z2 are the next larger and smaller numbers representable
in the target format respectively.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 fpu/softfloat.c         | 21 ++++++++++++++++++++-
 include/fpu/softfloat.h |  2 ++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index c295f31..5ccba76 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -623,6 +623,9 @@ static float64 roundAndPackFloat64(flag zSign, int zExp, uint64_t zSig,
     case float_round_down:
         roundIncrement = zSign ? 0x3ff : 0;
         break;
+    case float_round_to_odd:
+        roundIncrement = (zSig & 0x400) ? 0 : 0x3ff;
+        break;
     default:
         abort();
     }
@@ -632,8 +635,10 @@ static float64 roundAndPackFloat64(flag zSign, int zExp, uint64_t zSig,
              || (    ( zExp == 0x7FD )
                   && ( (int64_t) ( zSig + roundIncrement ) < 0 ) )
            ) {
+            bool overflow_to_inf = roundingMode != float_round_to_odd &&
+                                   roundIncrement != 0;
             float_raise(float_flag_overflow | float_flag_inexact, status);
-            return packFloat64( zSign, 0x7FF, - ( roundIncrement == 0 ));
+            return packFloat64(zSign, 0x7FF, -(!overflow_to_inf));
         }
         if ( zExp < 0 ) {
             if (status->flush_to_zero) {
@@ -651,6 +656,13 @@ static float64 roundAndPackFloat64(flag zSign, int zExp, uint64_t zSig,
             if (isTiny && roundBits) {
                 float_raise(float_flag_underflow, status);
             }
+            if (roundingMode == float_round_to_odd) {
+                /*
+                 * For round-to-odd case, the roundIncrement depends on
+                 * zSig which just changed.
+                 */
+                roundIncrement = (zSig & 0x400) ? 0 : 0x3ff;
+            }
         }
     }
     if (roundBits) {
@@ -1149,6 +1161,9 @@ static float128 roundAndPackFloat128(flag zSign, int32_t zExp,
     case float_round_down:
         increment = zSign && zSig2;
         break;
+    case float_round_to_odd:
+        increment = !(zSig1 & 0x1) && zSig2;
+        break;
     default:
         abort();
     }
@@ -1168,6 +1183,7 @@ static float128 roundAndPackFloat128(flag zSign, int32_t zExp,
             if (    ( roundingMode == float_round_to_zero )
                  || ( zSign && ( roundingMode == float_round_up ) )
                  || ( ! zSign && ( roundingMode == float_round_down ) )
+                 || (roundingMode == float_round_to_odd)
                ) {
                 return
                     packFloat128(
@@ -1215,6 +1231,9 @@ static float128 roundAndPackFloat128(flag zSign, int32_t zExp,
             case float_round_down:
                 increment = zSign && zSig2;
                 break;
+            case float_round_to_odd:
+                increment = !(zSig1 & 0x1) && zSig2;
+                break;
             default:
                 abort();
             }
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 842ec6b..8a39028 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -180,6 +180,8 @@ enum {
     float_round_up           = 2,
     float_round_to_zero      = 3,
     float_round_ties_away    = 4,
+    /* Not an IEEE rounding mode: round to the closest odd mantissa value */
+    float_round_to_odd       = 5,
 };
 
 /*----------------------------------------------------------------------------
-- 
2.9.3
