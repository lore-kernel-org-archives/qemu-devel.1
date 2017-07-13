Received: from eggs.gnu.org ([2001:4830:134:3::10]:53800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dVcjq-0004j6-4v
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:56:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dVcjo-0000qh-AN
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:56:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dVcjo-0000pB-44
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:56:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0D0657AE93
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 11:56:55 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 13 Jul 2017 12:56:45 +0100
Message-Id: <20170713115649.11853-2-dgilbert@redhat.com>
In-Reply-To: <20170713115649.11853-1-dgilbert@redhat.com>
References: <20170713115649.11853-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/5] migration/rdma: Fix race on source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, lvivier@redhat.com, peterx@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Fix a race where the destination might try and send the source a
WRID_READY before the source has done a post-recv for it.

rdma_post_recv has to happen after the qp exists, and we're
OK since we've already called qemu_rdma_source_init that calls
qemu_alloc_qp.

This corresponds to:
https://bugzilla.redhat.com/show_bug.cgi?id=1285044

The race can be triggered by adding a few ms wait before this
post_recv_control (which was originally due to me turning on loads of
debug).

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/rdma.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index c6bc607a03..6111e10c70 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2365,6 +2365,12 @@ static int qemu_rdma_connect(RDMAContext *rdma, Error **errp)
 
     caps_to_network(&cap);
 
+    ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_READY);
+    if (ret) {
+        ERROR(errp, "posting second control recv");
+        goto err_rdma_source_connect;
+    }
+
     ret = rdma_connect(rdma->cm_id, &conn_param);
     if (ret) {
         perror("rdma_connect");
@@ -2405,12 +2411,6 @@ static int qemu_rdma_connect(RDMAContext *rdma, Error **errp)
 
     rdma_ack_cm_event(cm_event);
 
-    ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_READY);
-    if (ret) {
-        ERROR(errp, "posting second control recv!");
-        goto err_rdma_source_connect;
-    }
-
     rdma->control_ready_expected = 1;
     rdma->nb_sent = 0;
     return 0;
-- 
2.13.0
