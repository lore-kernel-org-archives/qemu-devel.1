Received: from eggs.gnu.org ([2001:4830:134:3::10]:53428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1csYj3-00033n-Eq
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 13:46:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1csYj0-0000y8-Cn
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 13:46:41 -0400
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:49722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1csYj0-0000xQ-6e
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 13:46:38 -0400
Received: from player796.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 195BD769BD
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 19:46:37 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 27 Mar 2017 19:46:32 +0200
Message-ID: <149063679263.4447.610228515162504763.stgit@bahia.lan>
In-Reply-To: <149063674781.4447.14258971700726134711.stgit@bahia.lan>
References: <149063674781.4447.14258971700726134711.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 4/5] 9pfs: drop pdu_push_and_notify()
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
index 48babce836b6..09a8c79cf781 100644
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
@@ -667,7 +662,7 @@ static void coroutine_fn pdu_complete(V9fsPDU *pdu, ssize_t len)
     pdu->size = len;
     pdu->id = id;
 
-    pdu_push_and_notify(pdu);
+    pdu->s->transport->push_and_notify(pdu);
 
     /* Now wakeup anybody waiting in flush for this request */
     if (!qemu_co_queue_next(&pdu->complete)) {
