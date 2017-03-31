Received: from eggs.gnu.org ([2001:4830:134:3::10]:38888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ctuiJ-0002do-TH
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 07:27:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ctuiF-00078j-1I
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 07:27:31 -0400
Received: from 3.mo179.mail-out.ovh.net ([178.33.251.175]:54129)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ctuiE-00077o-Qn
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 07:27:26 -0400
Received: from player755.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 8579E34148
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 13:27:25 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 31 Mar 2017 13:27:15 +0200
Message-ID: <149095963571.26233.9370507789591510204.stgit@bahia.lan>
In-Reply-To: <149095959109.26233.3201018420228514740.stgit@bahia>
References: <149095959109.26233.3201018420228514740.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [for-2.9 PATCH 2/3] 9pfs: cancel active PDUs in
 virtfs_reset()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Li Qiang <liqiang6-s@360.cn>, Greg Kurz <groug@kaod.org>

According to the 9P spec [1], the version operation should abort any
outstanding I/O and clunk all fids, so that a new session may be started
in a clean state.

The current code tries to clunk and free fids, but it doesn't wait for
active PDUs to complete. This can cause an I/O to actually complete after
the new session has begun, and confuse the client.

This patch modifies virtfs_reset() so that it explicitely cancels and waits
for inflight requests to terminate. All fids should thus be unreferenced
and ready to be freed. Let's make it clear with a an assertion.

[1] http://man.cat-v.org/plan_9/5/version

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c |   22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index cc109367b030..86ed9065c4e2 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -536,9 +536,29 @@ static void coroutine_fn virtfs_reset(V9fsPDU *pdu)
 {
     V9fsState *s = pdu->s;
     V9fsFidState *fidp;
+    bool done = false;
+
+    /* Drain any outstanding I/O */
+    while (!done) {
+        V9fsPDU *cancel_pdu;
+
+        done = true;
+        QLIST_FOREACH(cancel_pdu, &s->active_list, next) {
+            if (cancel_pdu != pdu) {
+                done = false;
+                cancel_pdu->cancelled = 1;
+                qemu_co_queue_wait(&cancel_pdu->complete, NULL);
+                cancel_pdu->cancelled = 0;
+                pdu_free(cancel_pdu);
+                break;
+            }
+        }
+    }
 
     /* Free all fids */
     while (s->fid_list) {
+        assert(!fidp->ref);
+
         /* Get fid */
         fidp = s->fid_list;
         fidp->ref++;
@@ -670,7 +690,7 @@ static void coroutine_fn pdu_complete(V9fsPDU *pdu, ssize_t len)
 
     pdu_push_and_notify(pdu);
 
-    /* Now wakeup anybody waiting in flush for this request */
+    /* Now wakeup anybody waiting in flush or reset for this request */
     if (!qemu_co_queue_next(&pdu->complete)) {
         pdu_free(pdu);
     }
