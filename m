Received: from eggs.gnu.org ([2001:4830:134:3::10]:38804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ctVPo-0005OH-Ha
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 04:26:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ctVPk-0003oF-J9
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 04:26:44 -0400
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:58854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ctVPk-0003mc-DV
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 04:26:40 -0400
Received: from player731.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 3137178F6B
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 10:26:38 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 30 Mar 2017 10:26:24 +0200
Message-ID: <149086238428.3338.4129463785289801461.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] 9pfs: fix multiple flush for same request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Li Qiang <liqiang6-s@360.cn>, Greg Kurz <groug@kaod.org>

If a client tries to flush the same outstanding request several times, only
the first flush completes. Subsequent ones keep waiting for the request
completion in v9fs_flush() and, therefore, leak a PDU. This will cause QEMU
to hang when draining active PDUs the next time the device is reset.

Let have each flush request wake up the next one if any. The last waiter
frees the cancelled PDU.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 48babce836b6..ef47a0a5ad6f 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -2387,8 +2387,10 @@ static void coroutine_fn v9fs_flush(void *opaque)
          * Wait for pdu to complete.
          */
         qemu_co_queue_wait(&cancel_pdu->complete, NULL);
-        cancel_pdu->cancelled = 0;
-        pdu_free(cancel_pdu);
+        if (!qemu_co_queue_next(&cancel_pdu->complete)) {
+            cancel_pdu->cancelled = 0;
+            pdu_free(cancel_pdu);
+        }
     }
     pdu_complete(pdu, 7);
 }
