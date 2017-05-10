Received: from eggs.gnu.org ([2001:4830:134:3::10]:42536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8Lco-0002R1-PM
	for qemu-devel@nongnu.org; Wed, 10 May 2017 03:01:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8Lcm-0007nX-U3
	for qemu-devel@nongnu.org; Wed, 10 May 2017 03:01:30 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 10 May 2017 17:01:01 +1000
Message-Id: <20170510070115.13063-9-david@gibson.dropbear.id.au>
In-Reply-To: <20170510070115.13063-1-david@gibson.dropbear.id.au>
References: <20170510070115.13063-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 08/22] ppc/xics: Fix stale irq->status bits
 after get
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, agraf@suse.de, aik@ozlabs.ru, sjitindarsingh@gmail.com, mark.cave-ayland@ilande.co.uk, sam.bobroff@au1.ibm.com, nikunj@linux.vnet.ibm.com, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: Sam Bobroff <sam.bobroff@au1.ibm.com>

ics_get_kvm_state() "or"s set bits into irq->status but does not mask
out clear bits.

Correct this by initializing the IRQ status to zero before adding bits
to it.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics_kvm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 42e0e0e..03c1fc7 100644
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
2.9.3
