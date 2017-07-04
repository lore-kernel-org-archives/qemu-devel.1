Received: from eggs.gnu.org ([2001:4830:134:3::10]:34526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dSSt5-0003ZR-9B
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 14:49:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dSSt4-0001Rl-8O
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 14:49:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dSSt3-0001Qb-VJ
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 14:49:26 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue,  4 Jul 2017 19:49:13 +0100
Message-Id: <20170704184915.31586-4-dgilbert@redhat.com>
In-Reply-To: <20170704184915.31586-1-dgilbert@redhat.com>
References: <20170704184915.31586-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 3/5] migration/rdma: Allow cancelling while
 waiting for wrid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, michael@hinespot.com, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, berrange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

When waiting for a WRID, if the other side dies we end up waiting
for ever with no way to cancel the migration.
Cure this by poll()ing the fd first with a timeout and checking
error flags and migration state.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/rdma.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 48 insertions(+), 6 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 6111e10c70..7273ae9929 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1466,6 +1466,52 @@ static uint64_t qemu_rdma_poll(RDMAContext *rdma, uint64_t *wr_id_out,
     return  0;
 }
 
+/* Wait for activity on the completion channel.
+ * Returns 0 on success, none-0 on error.
+ */
+static int qemu_rdma_wait_comp_channel(RDMAContext *rdma)
+{
+    /*
+     * Coroutine doesn't start until migration_fd_process_incoming()
+     * so don't yield unless we know we're running inside of a coroutine.
+     */
+    if (rdma->migration_started_on_destination) {
+        yield_until_fd_readable(rdma->comp_channel->fd);
+    } else {
+        /* This is the source side, we're in a separate thread
+         * or destination prior to migration_fd_process_incoming()
+         * we can't yield; so we have to poll the fd.
+         * But we need to be able to handle 'cancel' or an error
+         * without hanging forever.
+         */
+        while (!rdma->error_state && !rdma->error_reported &&
+               !rdma->received_error) {
+            GPollFD pfds[1];
+            pfds[0].fd = rdma->comp_channel->fd;
+            pfds[0].events = G_IO_IN | G_IO_HUP | G_IO_ERR;
+            /* 0.5s timeout, should be fine for a 'cancel' */
+            switch (qemu_poll_ns(pfds, 1, 500 * 1000 * 1000)) {
+            case 1: /* fd active */
+                return 0;
+
+            case 0: /* Timeout, go around again */
+                break;
+
+            default: /* Error of some type */
+                return -1;
+            }
+
+            if (migrate_get_current()->state == MIGRATION_STATUS_CANCELLING) {
+                /* Bail out and let the cancellation happen */
+                return -EPIPE;
+            }
+        }
+    }
+
+    return rdma->error_state || rdma->error_reported ||
+           rdma->received_error;
+}
+
 /*
  * Block until the next work request has completed.
  *
@@ -1513,12 +1559,8 @@ static int qemu_rdma_block_for_wrid(RDMAContext *rdma, int wrid_requested,
     }
 
     while (1) {
-        /*
-         * Coroutine doesn't start until migration_fd_process_incoming()
-         * so don't yield unless we know we're running inside of a coroutine.
-         */
-        if (rdma->migration_started_on_destination) {
-            yield_until_fd_readable(rdma->comp_channel->fd);
+        if (qemu_rdma_wait_comp_channel(rdma)) {
+            goto err_block_for_wrid;
         }
 
         if (ibv_get_cq_event(rdma->comp_channel, &cq, &cq_ctx)) {
-- 
2.13.0
