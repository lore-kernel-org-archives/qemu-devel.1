Received: from eggs.gnu.org ([209.51.188.92]:41150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB44q-0001bL-Aj
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB44p-0003c3-B6
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57336
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB44p-0003VV-3V
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:43 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L1pFY095672
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:02:32 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rkswegxj0-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:02:32 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:02:31 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:26 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-53-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 52/97] target/arm: Correct condition for v8M
 callee stack push
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

In v7m_exception_taken() we were incorrectly using a
"LR bit EXCRET.ES is 1" check when it should be 0
(compare the pseudocode ExceptionTaken() function).
This meant we didn't stack the callee-saved registers
when tailchaining from a NonSecure to a Secure exception.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181002145940.30931-1-peter.maydell@linaro.org
(cherry picked from commit 7b73a1ca05b33d42278ce29cea4652e22d408165)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7ee614c04f..cae2b2649d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6858,7 +6858,7 @@ static void v7m_exception_taken(ARMCPU *cpu, uint32_t lr, bool dotailchain,
                  * not already saved.
                  */
                 if (lr & R_V7M_EXCRET_DCRS_MASK &&
-                    !(dotailchain && (lr & R_V7M_EXCRET_ES_MASK))) {
+                    !(dotailchain && !(lr & R_V7M_EXCRET_ES_MASK))) {
                     push_failed = v7m_push_callee_stack(cpu, lr, dotailchain,
                                                         ignore_stackfaults);
                 }
-- 
2.17.1
