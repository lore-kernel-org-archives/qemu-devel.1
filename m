Received: from eggs.gnu.org ([2001:4830:134:3::10]:58968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dXUd3-0008D7-8l
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:41:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dXUd2-0005rE-Ii
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:41:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dXUd2-0005qJ-D0
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:41:40 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 58332C058EA2
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 15:41:39 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 18 Jul 2017 17:41:14 +0200
Message-Id: <20170718154127.6459-4-quintela@redhat.com>
In-Reply-To: <20170718154127.6459-1-quintela@redhat.com>
References: <20170718154127.6459-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 03/16] migration/rdma: fix
 qemu_rdma_block_for_wrid error paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The two places that 'goto err_block_for_wrid' weren't setting ret
and so would end up returning 0 even though we've failed.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <20170717110936.23314-4-dgilbert@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/rdma.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 6111e10..59810ae 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1521,14 +1521,16 @@ static int qemu_rdma_block_for_wrid(RDMAContext *rdma, int wrid_requested,
             yield_until_fd_readable(rdma->comp_channel->fd);
         }
 
-        if (ibv_get_cq_event(rdma->comp_channel, &cq, &cq_ctx)) {
+        ret = ibv_get_cq_event(rdma->comp_channel, &cq, &cq_ctx);
+        if (ret) {
             perror("ibv_get_cq_event");
             goto err_block_for_wrid;
         }
 
         num_cq_events++;
 
-        if (ibv_req_notify_cq(cq, 0)) {
+        ret = -ibv_req_notify_cq(cq, 0);
+        if (ret) {
             goto err_block_for_wrid;
         }
 
@@ -1564,6 +1566,8 @@ err_block_for_wrid:
     if (num_cq_events) {
         ibv_ack_cq_events(cq, num_cq_events);
     }
+
+    rdma->error_state = ret;
     return ret;
 }
 
-- 
2.9.4
