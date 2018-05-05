Received: from eggs.gnu.org ([2001:4830:134:3::10]:58445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fEyIJ-0008T9-JG
	for qemu-devel@nongnu.org; Sat, 05 May 2018 10:36:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fEyII-0008GM-Q0
	for qemu-devel@nongnu.org; Sat, 05 May 2018 10:36:15 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:44958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1fEyII-0008G5-Jd
	for qemu-devel@nongnu.org; Sat, 05 May 2018 10:36:14 -0400
Received: by mail-pg0-x244.google.com with SMTP id 82-v6so17312447pge.11
	for <qemu-devel@nongnu.org>; Sat, 05 May 2018 07:36:14 -0700 (PDT)
From: Lidong Chen <jemmy858585@gmail.com>
Date: Sat,  5 May 2018 22:35:36 +0800
Message-Id: <1525530936-21835-7-git-send-email-lidongchen@tencent.com>
In-Reply-To: <1525530936-21835-1-git-send-email-lidongchen@tencent.com>
References: <1525530936-21835-1-git-send-email-lidongchen@tencent.com>
Subject: [Qemu-devel] [PATCH v3 6/6] migration: Stop rdma yielding during
 incoming postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com, dgilbert@redhat.com, berrange@redhat.com
Cc: qemu-devel@nongnu.org, galsha@mellanox.com, aviadye@mellanox.com, adido@mellanox.com, Lidong Chen <lidongchen@tencent.com>

During incoming postcopy, the destination qemu will invoke
qemu_rdma_wait_comp_channel in a seprate thread. So does not use rdma
yield, and poll the completion channel fd instead.

Signed-off-by: Lidong Chen <lidongchen@tencent.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/rdma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 854f355..ed9cfb1 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1490,11 +1490,13 @@ static int qemu_rdma_wait_comp_channel(RDMAContext *rdma)
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
