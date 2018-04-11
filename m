Received: from eggs.gnu.org ([2001:4830:134:3::10]:52601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f6JpA-0005dq-2g
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 13:46:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f6Jp5-0005RH-Cy
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 13:46:24 -0400
Received: from 5.mo5.mail-out.ovh.net ([87.98.173.103]:35768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1f6Jp5-0005QS-80
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 13:46:19 -0400
Received: from player760.ha.ovh.net (unknown [10.109.122.33])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 295971A17FE
	for <qemu-devel@nongnu.org>; Wed, 11 Apr 2018 19:46:17 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Wed, 11 Apr 2018 19:46:06 +0200
Message-ID: <152346876630.89534.10956847520017803741.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] spapr: drop useless sanity check in
 spapr_irq_alloc*()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

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
---
 hw/ppc/spapr.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 4d27909fb152..799673319b06 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3707,9 +3707,8 @@ int spapr_irq_alloc(sPAPRMachineState *spapr, int irq_hint, bool lsi,
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
@@ -3741,9 +3740,7 @@ int spapr_irq_alloc_block(sPAPRMachineState *spapr, int num, bool lsi,
     ICSState *ics = spapr->ics;
     int i, first = -1;
 
-    if (!ics) {
-        return -1;
-    }
+    assert(ics);
 
     /*
      * MSIMesage::data is used for storing VIRQ so
