Received: from eggs.gnu.org ([2001:4830:134:3::10]:47508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1f4jBZ-0004xb-LJ
	for qemu-devel@nongnu.org; Sat, 07 Apr 2018 04:26:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1f4jBY-00028o-My
	for qemu-devel@nongnu.org; Sat, 07 Apr 2018 04:26:57 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:42930)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1f4jBY-00028T-H6
	for qemu-devel@nongnu.org; Sat, 07 Apr 2018 04:26:56 -0400
Received: by mail-pf0-x241.google.com with SMTP id o16so2368204pfk.9
	for <qemu-devel@nongnu.org>; Sat, 07 Apr 2018 01:26:56 -0700 (PDT)
From: Lidong Chen <jemmy858585@gmail.com>
Date: Sat,  7 Apr 2018 16:26:33 +0800
Message-Id: <1523089594-1422-5-git-send-email-lidongchen@tencent.com>
In-Reply-To: <1523089594-1422-1-git-send-email-lidongchen@tencent.com>
References: <1523089594-1422-1-git-send-email-lidongchen@tencent.com>
Subject: [Qemu-devel] [PATCH 4/5] migration: fix qemu carsh when RDMA live
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com, dgilbert@redhat.com
Cc: qemu-devel@nongnu.org, adido@mellanox.com, licq@mellanox.com, Lidong Chen <lidongchen@tencent.com>

After postcopy, the destination qemu work in the dedicated
thread, so only invoke yield_until_fd_readable before postcopy
migration.

Signed-off-by: Lidong Chen <lidongchen@tencent.com>
---
 migration/rdma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 53773c7..81be482 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1489,11 +1489,13 @@ static int qemu_rdma_wait_comp_channel(RDMAContext *rdma)
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
