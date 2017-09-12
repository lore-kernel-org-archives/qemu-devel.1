Received: from eggs.gnu.org ([2001:4830:134:3::10]:58770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1drqER-0004MW-1n
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:48:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1drqEN-0005hE-UO
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:48:23 -0400
Received: from 3.mo2.mail-out.ovh.net ([46.105.58.226]:41048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1drqEN-0005gr-O6
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:48:19 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id D2245AB4D1
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 20:48:17 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 12 Sep 2017 20:48:05 +0200
Message-ID: <150524208504.32496.18214181791773634133.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] spapr_events: use QTAILQ_FOREACH_SAFE() in
 spapr_clear_pending_events()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>

QTAILQ_FOREACH_SAFE() must be used when removing the current element
inside the loop block.

This fixes a user-after-free error introduced by commit 56258174238eb
and reported by Coverity (CID 1381017).

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_events.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 66b8164f30be..e377fc7ddea2 100644
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
