Received: from eggs.gnu.org ([2001:4830:134:3::10]:50071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d3fzs-0004eC-GI
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:46:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d3fzo-00010B-Ja
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:46:00 -0400
Received: from 9.mo5.mail-out.ovh.net ([178.32.96.204]:45885)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1d3fzo-0000yO-8n
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:45:56 -0400
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id D3D52E8CC0
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 11:45:54 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 27 Apr 2017 11:45:51 +0200
Message-ID: <149328635105.30266.13681288439634920908.stgit@bahia>
In-Reply-To: <149328633283.30266.4224847428546759127.stgit@bahia>
References: <149328633283.30266.4224847428546759127.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 2/4] 9pfs: drop pdu_push_and_notify()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, Greg Kurz <groug@kaod.org>, "Michael S. Tsirkin" <mst@redhat.com>

Only pdu_complete() needs to notify the client that a request has completed.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index c80ba67389ce..01deffa0c3b5 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -65,11 +65,6 @@ ssize_t pdu_unmarshal(V9fsPDU *pdu, size_t offset, const char *fmt, ...)
     return ret;
 }
 
-static void pdu_push_and_notify(V9fsPDU *pdu)
-{
-    pdu->s->transport->push_and_notify(pdu);
-}
-
 static int omode_to_uflags(int8_t mode)
 {
     int ret = 0;
@@ -668,7 +663,7 @@ static void coroutine_fn pdu_complete(V9fsPDU *pdu, ssize_t len)
     pdu->size = len;
     pdu->id = id;
 
-    pdu_push_and_notify(pdu);
+    pdu->s->transport->push_and_notify(pdu);
 
     /* Now wakeup anybody waiting in flush for this request */
     if (!qemu_co_queue_next(&pdu->complete)) {
