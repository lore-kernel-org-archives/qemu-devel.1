Received: from eggs.gnu.org ([2001:4830:134:3::10]:33407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fBLXf-0000he-Fz
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:37:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fBLXe-0008BG-Ii
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:37:07 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:43569)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1fBLXe-0008Al-DT
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:37:06 -0400
Received: by mail-pf0-x241.google.com with SMTP id j11so15393712pff.10
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 07:37:06 -0700 (PDT)
From: Lidong Chen <jemmy858585@gmail.com>
Date: Wed, 25 Apr 2018 22:35:34 +0800
Message-Id: <1524666934-8064-6-git-send-email-lidongchen@tencent.com>
In-Reply-To: <1524666934-8064-1-git-send-email-lidongchen@tencent.com>
References: <1524666934-8064-1-git-send-email-lidongchen@tencent.com>
Subject: [Qemu-devel] [PATCH v2 5/5] migration: Stop rdma yielding during
 incoming postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com, dgilbert@redhat.com
Cc: qemu-devel@nongnu.org, galsha@mellanox.com, aviadye@mellanox.com, licq@mellanox.com, adido@mellanox.com, Lidong Chen <lidongchen@tencent.com>

During incoming postcopy, the destination qemu will invoke
qemu_rdma_wait_comp_channel in a seprate thread. So does not use rdma
yield, and poll the completion channel fd instead.

Signed-off-by: Lidong Chen <lidongchen@tencent.com>
---
 migration/rdma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 0652224..4ba9fe2 100644
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
