Received: from eggs.gnu.org ([2001:4830:134:3::10]:56072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cU53o-0007P0-Jq
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 00:14:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cU53l-0002hx-70
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 00:14:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1cU53k-0002gy-UT
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 00:14:53 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0J5Dm6G004351
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 00:14:50 -0500
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
	by mx0a-001b2d01.pphosted.com with ESMTP id 282pchhj6h-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 00:14:50 -0500
Received: from localhost
	by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Thu, 19 Jan 2017 10:44:47 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Thu, 19 Jan 2017 10:44:38 +0530
Message-Id: <1484802878-22681-1-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v0] softfloat: Add round-to-odd rounding
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
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, nikunj@linux.vnet.ibm.com, Bharata B Rao <bharata@linux.vnet.ibm.com>

Power ISA 3.0 introduces a few quadruple precision floating point
instructions that support round-to-add rounding mode. The
round-to-odd mode is explained as under:

Let Z be the intermediate arithmetic result or the operand of a convert
operation. If Z can be represented exactly in the target format, the
result is Z. Otherwise the result is either Z1 or Z2 whichever is odd.
Here Z1 and Z2 are the next larger and smaller numbers representable
in the target format respectively.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
---
- I am not fully sure if this the correct implementation for the above
  described round-to-odd rounding method. Any help is appreciated.
- Didn't bother to add round-to-odd to other floating point precision
  variants as round-to-odd option is currently supported only for some
  instructions that work on quad precision.

 fpu/softfloat.c         | 6 ++++++
 include/fpu/softfloat.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index c295f31..05932a9 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1149,6 +1149,9 @@ static float128 roundAndPackFloat128(flag zSign, int32_t zExp,
     case float_round_down:
         increment = zSign && zSig2;
         break;
+    case float_round_to_odd:
+        increment = !(zSig1 & 0x1) && zSig2;
+        break;
     default:
         abort();
     }
@@ -1215,6 +1218,9 @@ static float128 roundAndPackFloat128(flag zSign, int32_t zExp,
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
index 842ec6b..1463062 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -180,6 +180,7 @@ enum {
     float_round_up           = 2,
     float_round_to_zero      = 3,
     float_round_ties_away    = 4,
+    float_round_to_odd       = 5,
 };
 
 /*----------------------------------------------------------------------------
-- 
2.7.4
