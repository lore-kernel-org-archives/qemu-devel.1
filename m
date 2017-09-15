Received: from eggs.gnu.org ([2001:4830:134:3::10]:54251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dshfN-0006mR-RX
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:51:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dshfM-0003Qo-Hx
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:51:45 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 15 Sep 2017 13:51:29 +1000
Message-Id: <20170915035130.8354-18-david@gibson.dropbear.id.au>
In-Reply-To: <20170915035130.8354-1-david@gibson.dropbear.id.au>
References: <20170915035130.8354-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 17/18] spapr_events: use QTAILQ_FOREACH_SAFE()
 in spapr_clear_pending_events()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, gkurz@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@ozlabs.ru, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

QTAILQ_FOREACH_SAFE() must be used when removing the current element
inside the loop block.

This fixes a user-after-free error introduced by commit 56258174238eb
and reported by Coverity (CID 1381017).

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_events.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 66b8164f30..e377fc7dde 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -702,9 +702,9 @@ static void event_scan(PowerPCCPU *cpu, sPAPRMachineState *spapr,
 
 void spapr_clear_pending_events(sPAPRMachineState *spapr)
 {
-    sPAPREventLogEntry *entry = NULL;
+    sPAPREventLogEntry *entry = NULL, *next_entry;
 
-    QTAILQ_FOREACH(entry, &spapr->pending_events, next) {
+    QTAILQ_FOREACH_SAFE(entry, &spapr->pending_events, next, next_entry) {
         QTAILQ_REMOVE(&spapr->pending_events, entry, next);
         g_free(entry->extended_log);
         g_free(entry);
-- 
2.13.5
