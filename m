Received: from eggs.gnu.org ([2001:4830:134:3::10]:59435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBza6-0001hT-6p
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:22:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBza5-00025t-7s
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:22:18 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 27 Apr 2018 19:21:05 +1000
Message-Id: <20180427092126.24812-29-david@gibson.dropbear.id.au>
In-Reply-To: <20180427092126.24812-1-david@gibson.dropbear.id.au>
References: <20180427092126.24812-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 28/49] spapr: drop useless sanity check in
 spapr_irq_alloc*()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

Both spapr_irq_alloc() and spapr_irq_alloc_block() have an errp
parameter, but they don't use it if XICS hasn't been initialized
yet.

This is doubly wrong:

- all callers do pass a non-null Error **, ie, they expect an error
  to be propagated in case of failure

- XICS obviously needs to be initialized before anything starts allocating
  IRQs

So this patch turns the check into an assert.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b92dad2273..5a1c1e25e1 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3719,9 +3719,8 @@ int spapr_irq_alloc(sPAPRMachineState *spapr, int irq_hint, bool lsi,
     ICSState *ics = spapr->ics;
     int irq;
 
-    if (!ics) {
-        return -1;
-    }
+    assert(ics);
+
     if (irq_hint) {
         if (!ICS_IRQ_FREE(ics, irq_hint - ics->offset)) {
             error_setg(errp, "can't allocate IRQ %d: already in use", irq_hint);
@@ -3753,9 +3752,7 @@ int spapr_irq_alloc_block(sPAPRMachineState *spapr, int num, bool lsi,
     ICSState *ics = spapr->ics;
     int i, first = -1;
 
-    if (!ics) {
-        return -1;
-    }
+    assert(ics);
 
     /*
      * MSIMesage::data is used for storing VIRQ so
-- 
2.14.3
