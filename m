Received: from eggs.gnu.org ([2001:4830:134:3::10]:49149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fmfa5-0003Hc-Cc
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 09:29:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fmfa4-0008Fg-Ei
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 09:29:53 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:38300)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1fmfa4-0008FR-8V
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 09:29:52 -0400
Received: by mail-pg1-x542.google.com with SMTP id k3-v6so6239760pgq.5
	for <qemu-devel@nongnu.org>; Mon, 06 Aug 2018 06:29:52 -0700 (PDT)
From: Lidong Chen <jemmy858585@gmail.com>
Date: Mon,  6 Aug 2018 21:29:30 +0800
Message-Id: <1533562177-16447-5-git-send-email-lidongchen@tencent.com>
In-Reply-To: <1533562177-16447-1-git-send-email-lidongchen@tencent.com>
References: <1533562177-16447-1-git-send-email-lidongchen@tencent.com>
Subject: [Qemu-devel] [PATCH v6 04/11] migration: Stop rdma yielding during
 incoming postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhang.zhanghailiang@huawei.com, quintela@redhat.com, dgilbert@redhat.com
Cc: qemu-devel@nongnu.org, Lidong Chen <jemmy858585@gmail.com>, Lidong Chen <lidongchen@tencent.com>

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
index a5535fb..cfb0671 100644
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
