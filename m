Received: from eggs.gnu.org ([2001:4830:134:3::10]:46568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cX1WX-0006Jg-Nw
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 03:04:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cX1WU-0001WE-HM
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 03:04:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39830)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1cX1WU-0001Vm-8h
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 03:04:42 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0R7xixA103541
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 03:04:41 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	by mx0a-001b2d01.pphosted.com with ESMTP id 287vabb45c-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 03:04:41 -0500
Received: from localhost
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Fri, 27 Jan 2017 18:04:38 +1000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Fri, 27 Jan 2017 13:33:33 +0530
In-Reply-To: <1485504213-21632-1-git-send-email-bharata@linux.vnet.ibm.com>
References: <1485504213-21632-1-git-send-email-bharata@linux.vnet.ibm.com>
Message-Id: <1485504213-21632-3-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v2 2/2] softfloat: Add round-to-odd
 rounding mode
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

Power ISA 3.0 introduces a few quadruple precision floating point
instructions that support round-to-odd rounding mode. The
round-to-odd mode is explained as under:

Let Z be the intermediate arithmetic result or the operand of a convert
operation. If Z can be represented exactly in the target format, the
result is Z. Otherwise the result is either Z1 or Z2 whichever is odd.
Here Z1 and Z2 are the next larger and smaller numbers representable
in the target format respectively.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
---
 fpu/softfloat.c         | 17 ++++++++++++++++-
 include/fpu/softfloat.h |  2 ++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index b04699c..1c322ad 100644
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
+            return packFloat64( zSign, 0x7FF, - ( !overflow_to_inf ));
         }
         if ( zExp < 0 ) {
             if (status->flush_to_zero) {
@@ -665,6 +670,9 @@ static float64 roundAndPackFloat64(flag zSign, int zExp, uint64_t zSig,
             case float_round_down:
                 roundIncrement = zSign ? 0x3ff : 0;
                 break;
+            case float_round_to_odd:
+                roundIncrement = (zSig & 0x400) ? 0 : 0x3ff;
+                break;
             default:
                 abort();
             }
@@ -1166,6 +1174,9 @@ static float128 roundAndPackFloat128(flag zSign, int32_t zExp,
     case float_round_down:
         increment = zSign && zSig2;
         break;
+    case float_round_to_odd:
+        increment = !(zSig1 & 0x1) && zSig2;
+        break;
     default:
         abort();
     }
@@ -1185,6 +1196,7 @@ static float128 roundAndPackFloat128(flag zSign, int32_t zExp,
             if (    ( roundingMode == float_round_to_zero )
                  || ( zSign && ( roundingMode == float_round_up ) )
                  || ( ! zSign && ( roundingMode == float_round_down ) )
+                 || ( roundingMode == float_round_to_odd )
                ) {
                 return
                     packFloat128(
@@ -1232,6 +1244,9 @@ static float128 roundAndPackFloat128(flag zSign, int32_t zExp,
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
2.7.4
