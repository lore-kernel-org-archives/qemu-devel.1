Received: from eggs.gnu.org ([2001:4830:134:3::10]:40740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1duT9Z-0004RZ-NX
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 20:46:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1duT9T-0005hS-Pt
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 20:46:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34888
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1duT9T-0005f3-Kk
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 20:46:07 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8K0hcrN015507
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 20:46:04 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2d3akjtph2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 20:46:03 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 19 Sep 2017 20:46:03 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 19 Sep 2017 19:45:14 -0500
In-Reply-To: <20170920004521.9417-1-mdroth@linux.vnet.ibm.com>
References: <20170920004521.9417-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20170920004521.9417-6-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 05/12] arm_gicv3_kvm: Fix compile warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Pranith Kumar <bobby.prani@gmail.com>, Peter Maydell <peter.maydell@linaro.org>

From: Pranith Kumar <bobby.prani@gmail.com>

Fix the following warning:

/home/pranith/qemu/hw/intc/arm_gicv3_kvm.c:296:17: warning: logical not is only applied to the left hand side of this bitwise operator [-Wlogical-not-parentheses]
            if (!c->gicr_ctlr & GICR_CTLR_ENABLE_LPIS) {
                ^             ~
/home/pranith/qemu/hw/intc/arm_gicv3_kvm.c:296:17: note: add parentheses after the '!' to evaluate the bitwise operator first
            if (!c->gicr_ctlr & GICR_CTLR_ENABLE_LPIS) {
                ^
/home/pranith/qemu/hw/intc/arm_gicv3_kvm.c:296:17: note: add parentheses around left hand side expression to silence this warning
            if (!c->gicr_ctlr & GICR_CTLR_ENABLE_LPIS) {
                ^

This logic error meant we were not setting the PTZ
bit when we should -- luckily as the comment suggests
this wouldn't have had any effects beyond making GIC
initialization take a little longer.

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
Message-id: 20170829173226.7625-1-bobby.prani@gmail.com
Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 7229ec5825df6b933f150b54a8a2bedd2de1864c)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/intc/arm_gicv3_kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 6051c77705..481fe5405a 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -293,7 +293,7 @@ static void kvm_arm_gicv3_put(GICv3State *s)
             kvm_gicr_access(s, GICR_PROPBASER + 4, ncpu, &regh, true);
 
             reg64 = c->gicr_pendbaser;
-            if (!c->gicr_ctlr & GICR_CTLR_ENABLE_LPIS) {
+            if (!(c->gicr_ctlr & GICR_CTLR_ENABLE_LPIS)) {
                 /* Setting PTZ is advised if LPIs are disabled, to reduce
                  * GIC initialization time.
                  */
-- 
2.11.0
