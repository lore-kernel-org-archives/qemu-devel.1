Received: from eggs.gnu.org ([2001:4830:134:3::10]:46542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cX1WU-0006HJ-TP
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 03:04:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cX1WR-0001Tz-Pq
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 03:04:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35875)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1cX1WR-0001TR-HK
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 03:04:39 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0R7x2KH057746
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 03:04:38 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	by mx0a-001b2d01.pphosted.com with ESMTP id 287va9b1b8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 03:04:38 -0500
Received: from localhost
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Fri, 27 Jan 2017 18:04:36 +1000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Fri, 27 Jan 2017 13:33:32 +0530
In-Reply-To: <1485504213-21632-1-git-send-email-bharata@linux.vnet.ibm.com>
References: <1485504213-21632-1-git-send-email-bharata@linux.vnet.ibm.com>
Message-Id: <1485504213-21632-2-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v2 1/2] softfloat: Handle float64 rounding
 properly for underflow case
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

When rounding a floating point result to float64 precision, the
existing code doesn't re-calculate the required round increment
for the underflow case. Fix this.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
---
 fpu/softfloat.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index c295f31..b04699c 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -651,6 +651,23 @@ static float64 roundAndPackFloat64(flag zSign, int zExp, uint64_t zSig,
             if (isTiny && roundBits) {
                 float_raise(float_flag_underflow, status);
             }
+            switch (roundingMode) {
+            case float_round_nearest_even:
+            case float_round_ties_away:
+                roundIncrement = 0x200;
+                break;
+            case float_round_to_zero:
+                roundIncrement = 0;
+                break;
+            case float_round_up:
+                roundIncrement = zSign ? 0 : 0x3ff;
+                break;
+            case float_round_down:
+                roundIncrement = zSign ? 0x3ff : 0;
+                break;
+            default:
+                abort();
+            }
         }
     }
     if (roundBits) {
-- 
2.7.4
