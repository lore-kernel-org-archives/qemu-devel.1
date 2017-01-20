Received: from eggs.gnu.org ([2001:4830:134:3::10]:34191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cUVKh-0006BC-IQ
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:18:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cUVKc-0004Z8-IJ
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:18:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35808
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1cUVKc-0004Y8-Cj
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:18:02 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0K9DhWa121205
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 04:18:00 -0500
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
	by mx0b-001b2d01.pphosted.com with ESMTP id 283fpgg8f7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 04:17:59 -0500
Received: from localhost
	by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Fri, 20 Jan 2017 14:47:56 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Fri, 20 Jan 2017 14:47:46 +0530
Message-Id: <1484903866-17940-1-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v1] softfloat: Add round-to-odd rounding
 mode
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
Changes in v1:
- Addressed rounding to infinity in roundAndPackFloat128().
- Added 64bit round to odd implementation(roundAndPackFloat64()) as
  it is needed by xscvqpdp instruction of Power ISA 3.0.

v0: http://patchwork.ozlabs.org/patch/716956/

 fpu/softfloat.c         | 10 ++++++++++
 include/fpu/softfloat.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index c295f31..b9b36ad 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -623,6 +623,9 @@ static float64 roundAndPackFloat64(flag zSign, int zExp, uint64_t zSig,
     case float_round_down:
         roundIncrement = zSign ? 0x3ff : 0;
         break;
+    case float_round_to_odd:
+        roundIncrement = (zSig & 0x200) ? 0 : 0x3ff;
+        break;
     default:
         abort();
     }
@@ -1149,6 +1152,9 @@ static float128 roundAndPackFloat128(flag zSign, int32_t zExp,
     case float_round_down:
         increment = zSign && zSig2;
         break;
+    case float_round_to_odd:
+        increment = !(zSig1 & 0x1) && zSig2;
+        break;
     default:
         abort();
     }
@@ -1168,6 +1174,7 @@ static float128 roundAndPackFloat128(flag zSign, int32_t zExp,
             if (    ( roundingMode == float_round_to_zero )
                  || ( zSign && ( roundingMode == float_round_up ) )
                  || ( ! zSign && ( roundingMode == float_round_down ) )
+                 || ( roundingMode == float_round_to_odd )
                ) {
                 return
                     packFloat128(
@@ -1215,6 +1222,9 @@ static float128 roundAndPackFloat128(flag zSign, int32_t zExp,
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
