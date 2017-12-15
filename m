Received: from eggs.gnu.org ([2001:4830:134:3::10]:50114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ePt46-0007ot-U8
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:42:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ePt42-0005tx-V3
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:42:26 -0500
Received: from 12.mo1.mail-out.ovh.net ([87.98.162.229]:38885)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ePt42-0005ez-OQ
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:42:22 -0500
Received: from player730.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 02A54B0982
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 17:42:11 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 15 Dec 2017 17:42:02 +0100
Message-ID: <151335612254.14991.13093029894103210710.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] 9pfs: fix error path in pdu_submit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>

If we receive an unsupported request id, we first decide to
return -ENOTSUPP to the client, but since the request id
causes is_read_only_op() to return false, we change the
error to be -EROFS if the fsdev is read-only. This doesn't
make sense since we don't know what the client asked for.

This patch ensures that -EROFS can only be returned if the
request id is supported.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 76f90f2b7863..558efb41defd 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -3473,14 +3473,12 @@ void pdu_submit(V9fsPDU *pdu, P9MsgHeader *hdr)
     if (pdu->id >= ARRAY_SIZE(pdu_co_handlers) ||
         (pdu_co_handlers[pdu->id] == NULL)) {
         handler = v9fs_op_not_supp;
+    } else if (is_ro_export(&s->ctx) && !is_read_only_op(pdu)) {
+        handler = v9fs_fs_ro;
     } else {
         handler = pdu_co_handlers[pdu->id];
     }
 
-    if (is_ro_export(&s->ctx) && !is_read_only_op(pdu)) {
-        handler = v9fs_fs_ro;
-    }
-
     qemu_co_queue_init(&pdu->complete);
     co = qemu_coroutine_create(handler, pdu);
     qemu_coroutine_enter(co);
