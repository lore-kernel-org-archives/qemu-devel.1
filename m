Received: from eggs.gnu.org ([2001:4830:134:3::10]:52914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1flWA3-0001Vg-0Q
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:14:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1flWA1-0001dc-Ix
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:14:14 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:33091)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1flWA1-0001cM-Ab
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:14:13 -0400
Received: by mail-pg1-x541.google.com with SMTP id r5-v6so2582940pgv.0
	for <qemu-devel@nongnu.org>; Fri, 03 Aug 2018 02:14:13 -0700 (PDT)
From: Lidong Chen <jemmy858585@gmail.com>
Date: Fri,  3 Aug 2018 17:13:46 +0800
Message-Id: <1533287630-4221-9-git-send-email-lidongchen@tencent.com>
In-Reply-To: <1533287630-4221-1-git-send-email-lidongchen@tencent.com>
References: <1533287630-4221-1-git-send-email-lidongchen@tencent.com>
Subject: [Qemu-devel] [PATCH v6 08/12] migration: poll the cm event while
 wait RDMA work request completion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhang.zhanghailiang@huawei.com, quintela@redhat.com, dgilbert@redhat.com
Cc: qemu-devel@nongnu.org, Lidong Chen <jemmy858585@gmail.com>, Lidong Chen <lidongchen@tencent.com>, Gal Shachaf <galsha@mellanox.com>, Aviad Yehezkel <aviadye@mellanox.com>

From: Lidong Chen <jemmy858585@gmail.com>

If the peer qemu is crashed, the qemu_rdma_wait_comp_channel function
maybe loop forever. so we should also poll the cm event fd, and when
receive RDMA_CM_EVENT_DISCONNECTED and RDMA_CM_EVENT_DEVICE_REMOVAL,
we consider some error happened.

Signed-off-by: Lidong Chen <lidongchen@tencent.com>
Signed-off-by: Gal Shachaf <galsha@mellanox.com>
Signed-off-by: Aviad Yehezkel <aviadye@mellanox.com>
---
 migration/rdma.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index d6bbf28..673f126 100644
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
1.8.3.1
