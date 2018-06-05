Received: from eggs.gnu.org ([2001:4830:134:3::10]:40098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fQDsw-0008DK-B7
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 11:28:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fQDst-0003t0-ET
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 11:28:34 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:45631)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1fQDst-0003s7-8G
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 11:28:31 -0400
Received: by mail-pl0-x243.google.com with SMTP id c23-v6so1719771plz.12
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 08:28:31 -0700 (PDT)
From: Lidong Chen <jemmy858585@gmail.com>
Date: Tue,  5 Jun 2018 23:28:04 +0800
Message-Id: <1528212489-19137-6-git-send-email-lidongchen@tencent.com>
In-Reply-To: <1528212489-19137-1-git-send-email-lidongchen@tencent.com>
References: <1528212489-19137-1-git-send-email-lidongchen@tencent.com>
Subject: [Qemu-devel] [PATCH v5 05/10] migration: Stop rdma yielding during
 incoming postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhang.zhanghailiang@huawei.com, quintela@redhat.com, dgilbert@redhat.com, berrange@redhat.com, aviadye@mellanox.com, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, adido@mellanox.com, galsha@mellanox.com, Lidong Chen <jemmy858585@gmail.com>, Lidong Chen <lidongchen@tencent.com>

From: Lidong Chen <jemmy858585@gmail.com>

During incoming postcopy, the destination qemu will invoke
qemu_rdma_wait_comp_channel in a seprate thread. So does not use rdma
yield, and poll the completion channel fd instead.

Signed-off-by: Lidong Chen <lidongchen@tencent.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/rdma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 769f443..92e4d30 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1493,11 +1493,13 @@ static int qemu_rdma_wait_comp_channel(RDMAContext *rdma)
      * Coroutine doesn't start until migration_fd_process_incoming()
      * so don't yield unless we know we're running inside of a coroutine.
      */
-    if (rdma->migration_started_on_destination) {
+    if (rdma->migration_started_on_destination &&
+        migration_incoming_get_current()->state == MIGRATION_STATUS_ACTIVE) {
         yield_until_fd_readable(rdma->comp_channel->fd);
     } else {
         /* This is the source side, we're in a separate thread
          * or destination prior to migration_fd_process_incoming()
+         * after postcopy, the destination also in a seprate thread.
          * we can't yield; so we have to poll the fd.
          * But we need to be able to handle 'cancel' or an error
          * without hanging forever.
-- 
1.8.3.1
