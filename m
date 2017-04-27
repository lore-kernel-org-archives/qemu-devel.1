Received: from eggs.gnu.org ([2001:4830:134:3::10]:39665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1d3cz7-0006lN-Kp
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 02:33:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1d3cz4-0003sL-HX
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 02:33:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50093)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam.bobroff@au1.ibm.com>)
	id 1d3cz4-0003rO-7i
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 02:32:58 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3R6T9rO122633
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 02:32:57 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a34vxmnw3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 02:32:56 -0400
Received: from localhost
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sam.bobroff@au1.ibm.com>;
	Thu, 27 Apr 2017 16:32:53 +1000
Date: Thu, 27 Apr 2017 16:31:53 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
References: <cover.1493274659.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1493274659.git.sam.bobroff@au1.ibm.com>
Message-Id: <20170427063153.GB11487@tungsten.ozlabs.ibm.com>
Subject: [Qemu-devel] [PATCH 1/2] ppc/xics: Fix stale irq->status bits after
 get
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au

ics_get_kvm_state() "or"s set bits into irq->status but does not mask
out clear bits.

Correct this by initializing the IRQ status to zero before adding bits
to it.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
 hw/intc/xics_kvm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 42e0e0ef84..03c1fc77cb 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -213,6 +213,7 @@ static void ics_get_kvm_state(ICSState *ics)
             irq->priority = irq->saved_priority;
         }
 
+        irq->status = 0;
         if (state & KVM_XICS_PENDING) {
             if (state & KVM_XICS_LEVEL_SENSITIVE) {
                 irq->status |= XICS_STATUS_ASSERTED;
-- 
2.12.1.382.gc0f9c7058
