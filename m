Received: from eggs.gnu.org ([2001:4830:134:3::10]:42549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dWx1j-0000uA-MD
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:48:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dWx1d-0004dx-Is
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:48:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dWx1d-0004dp-9P
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 23:48:49 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon, 17 Jul 2017 11:48:20 +0800
Message-Id: <20170717034825.1524-11-famz@redhat.com>
In-Reply-To: <20170717034825.1524-1-famz@redhat.com>
References: <20170717034825.1524-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 10/15] sheepdog: add queue_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20170629132749.997-11-pbonzini@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/sheepdog.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index b7b7e6b..abb2e79 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -390,6 +390,7 @@ struct BDRVSheepdogState {
     QLIST_HEAD(inflight_aio_head, AIOReq) inflight_aio_head;
     QLIST_HEAD(failed_aio_head, AIOReq) failed_aio_head;
 
+    CoMutex queue_lock;
     CoQueue overlapping_queue;
     QLIST_HEAD(inflight_aiocb_head, SheepdogAIOCB) inflight_aiocb_head;
 };
@@ -488,7 +489,7 @@ static void wait_for_overlapping_aiocb(BDRVSheepdogState *s, SheepdogAIOCB *acb)
 retry:
     QLIST_FOREACH(cb, &s->inflight_aiocb_head, aiocb_siblings) {
         if (AIOCBOverlapping(acb, cb)) {
-            qemu_co_queue_wait(&s->overlapping_queue, NULL);
+            qemu_co_queue_wait(&s->overlapping_queue, &s->queue_lock);
             goto retry;
         }
     }
@@ -525,8 +526,10 @@ static void sd_aio_setup(SheepdogAIOCB *acb, BDRVSheepdogState *s,
         return;
     }
 
+    qemu_co_mutex_lock(&s->queue_lock);
     wait_for_overlapping_aiocb(s, acb);
     QLIST_INSERT_HEAD(&s->inflight_aiocb_head, acb, aiocb_siblings);
+    qemu_co_mutex_unlock(&s->queue_lock);
 }
 
 static SocketAddress *sd_socket_address(const char *path,
@@ -785,6 +788,7 @@ static coroutine_fn void reconnect_to_sdog(void *opaque)
      * have to move all the inflight requests to the failed queue before
      * resend_aioreq() is called.
      */
+    qemu_co_mutex_lock(&s->queue_lock);
     QLIST_FOREACH_SAFE(aio_req, &s->inflight_aio_head, aio_siblings, next) {
         QLIST_REMOVE(aio_req, aio_siblings);
         QLIST_INSERT_HEAD(&s->failed_aio_head, aio_req, aio_siblings);
@@ -794,8 +798,11 @@ static coroutine_fn void reconnect_to_sdog(void *opaque)
     while (!QLIST_EMPTY(&s->failed_aio_head)) {
         aio_req = QLIST_FIRST(&s->failed_aio_head);
         QLIST_REMOVE(aio_req, aio_siblings);
+        qemu_co_mutex_unlock(&s->queue_lock);
         resend_aioreq(s, aio_req);
+        qemu_co_mutex_lock(&s->queue_lock);
     }
+    qemu_co_mutex_unlock(&s->queue_lock);
 }
 
 /*
@@ -887,7 +894,10 @@ static void coroutine_fn aio_read_response(void *opaque)
     */
     s->co_recv = NULL;
 
+    qemu_co_mutex_lock(&s->queue_lock);
     QLIST_REMOVE(aio_req, aio_siblings);
+    qemu_co_mutex_unlock(&s->queue_lock);
+
     switch (rsp.result) {
     case SD_RES_SUCCESS:
         break;
@@ -1307,7 +1317,9 @@ static void coroutine_fn add_aio_request(BDRVSheepdogState *s, AIOReq *aio_req,
     uint64_t old_oid = aio_req->base_oid;
     bool create = aio_req->create;
 
+    qemu_co_mutex_lock(&s->queue_lock);
     QLIST_INSERT_HEAD(&s->inflight_aio_head, aio_req, aio_siblings);
+    qemu_co_mutex_unlock(&s->queue_lock);
 
     if (!nr_copies) {
         error_report("bug");
@@ -1678,6 +1690,7 @@ static int sd_open(BlockDriverState *bs, QDict *options, int flags,
     bs->total_sectors = s->inode.vdi_size / BDRV_SECTOR_SIZE;
     pstrcpy(s->name, sizeof(s->name), vdi);
     qemu_co_mutex_init(&s->lock);
+    qemu_co_mutex_init(&s->queue_lock);
     qemu_co_queue_init(&s->overlapping_queue);
     qemu_opts_del(opts);
     g_free(buf);
@@ -2438,12 +2451,16 @@ static void coroutine_fn sd_co_rw_vector(SheepdogAIOCB *acb)
 
 static void sd_aio_complete(SheepdogAIOCB *acb)
 {
+    BDRVSheepdogState *s;
     if (acb->aiocb_type == AIOCB_FLUSH_CACHE) {
         return;
     }
 
+    s = acb->s;
+    qemu_co_mutex_lock(&s->queue_lock);
     QLIST_REMOVE(acb, aiocb_siblings);
-    qemu_co_queue_restart_all(&acb->s->overlapping_queue);
+    qemu_co_queue_restart_all(&s->overlapping_queue);
+    qemu_co_mutex_unlock(&s->queue_lock);
 }
 
 static coroutine_fn int sd_co_writev(BlockDriverState *bs, int64_t sector_num,
-- 
2.9.4
