Received: from eggs.gnu.org ([2001:4830:134:3::10]:38981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsRpF-0006l0-0b
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsRpB-0008T7-Jg
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:01:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43066 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fsRpB-0008SH-CD
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:01:21 -0400
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 22 Aug 2018 14:00:41 +0200
Message-Id: <20180822120050.12694-12-quintela@redhat.com>
In-Reply-To: <20180822120050.12694-1-quintela@redhat.com>
References: <20180822120050.12694-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 11/20] migration: poll the cm event while wait
 RDMA work request completion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, Lidong Chen <jemmy858585@gmail.com>, Lidong Chen <lidongchen@tencent.com>, Gal Shachaf <galsha@mellanox.com>, Aviad Yehezkel <aviadye@mellanox.com>

From: Lidong Chen <jemmy858585@gmail.com>

If the peer qemu is crashed, the qemu_rdma_wait_comp_channel function
maybe loop forever. so we should also poll the cm event fd, and when
receive RDMA_CM_EVENT_DISCONNECTED and RDMA_CM_EVENT_DEVICE_REMOVAL,
we consider some error happened.

Signed-off-by: Lidong Chen <lidongchen@tencent.com>
Signed-off-by: Gal Shachaf <galsha@mellanox.com>
Signed-off-by: Aviad Yehezkel <aviadye@mellanox.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/rdma.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index d6bbf28fdc..673f126a05 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1489,6 +1489,9 @@ static uint64_t qemu_rdma_poll(RDMAContext *rdma, uint64_t *wr_id_out,
  */
 static int qemu_rdma_wait_comp_channel(RDMAContext *rdma)
 {
+    struct rdma_cm_event *cm_event;
+    int ret = -1;
+
     /*
      * Coroutine doesn't start until migration_fd_process_incoming()
      * so don't yield unless we know we're running inside of a coroutine.
@@ -1505,13 +1508,37 @@ static int qemu_rdma_wait_comp_channel(RDMAContext *rdma)
          * without hanging forever.
          */
         while (!rdma->error_state  && !rdma->received_error) {
-            GPollFD pfds[1];
+            GPollFD pfds[2];
             pfds[0].fd = rdma->comp_channel->fd;
             pfds[0].events = G_IO_IN | G_IO_HUP | G_IO_ERR;
+            pfds[0].revents = 0;
+
+            pfds[1].fd = rdma->channel->fd;
+            pfds[1].events = G_IO_IN | G_IO_HUP | G_IO_ERR;
+            pfds[1].revents = 0;
+
             /* 0.1s timeout, should be fine for a 'cancel' */
-            switch (qemu_poll_ns(pfds, 1, 100 * 1000 * 1000)) {
+            switch (qemu_poll_ns(pfds, 2, 100 * 1000 * 1000)) {
+            case 2:
             case 1: /* fd active */
-                return 0;
+                if (pfds[0].revents) {
+                    return 0;
+                }
+
+                if (pfds[1].revents) {
+                    ret = rdma_get_cm_event(rdma->channel, &cm_event);
+                    if (!ret) {
+                        rdma_ack_cm_event(cm_event);
+                    }
+
+                    error_report("receive cm event while wait comp channel,"
+                                 "cm event is %d", cm_event->event);
+                    if (cm_event->event == RDMA_CM_EVENT_DISCONNECTED ||
+                        cm_event->event == RDMA_CM_EVENT_DEVICE_REMOVAL) {
+                        return -EPIPE;
+                    }
+                }
+                break;
 
             case 0: /* Timeout, go around again */
                 break;
-- 
2.17.1
