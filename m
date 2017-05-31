Received: from eggs.gnu.org ([2001:4830:134:3::10]:41800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dG0AR-0002dK-1u
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:43:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dG0AO-0001sJ-Kh
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:43:51 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 31 May 2017 11:43:29 +0200
Message-Id: <20170531094330.1808-11-pbonzini@redhat.com>
In-Reply-To: <20170531094330.1808-1-pbonzini@redhat.com>
References: <20170531094330.1808-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 10/11] sheepdog: add queue_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/sheepdog.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index 5ebf5d9fbb..551db7cd17 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -391,6 +391,7 @@ struct BDRVSheepdogState {
     QLIST_HEAD(inflight_aio_head, AIOReq) inflight_aio_head;
     QLIST_HEAD(failed_aio_head, AIOReq) failed_aio_head;
 
+    CoMutex queue_lock;
     CoQueue overlapping_queue;
     QLIST_HEAD(inflight_aiocb_head, SheepdogAIOCB) inflight_aiocb_head;
 };
@@ -489,7 +490,7 @@ static void wait_for_overlapping_aiocb(BDRVSheepdogState *s, SheepdogAIOCB *acb)
 retry:
     QLIST_FOREACH(cb, &s->inflight_aiocb_head, aiocb_siblings) {
         if (AIOCBOverlapping(acb, cb)) {
-            qemu_co_queue_wait(&s->overlapping_queue, NULL);
+            qemu_co_queue_wait(&s->overlapping_queue, &s->queue_lock);
             goto retry;
         }
     }
@@ -526,8 +527,10 @@ static void sd_aio_setup(SheepdogAIOCB *acb, BDRVSheepdogState *s,
         return;
     }
 
+    qemu_co_mutex_lock(&s->queue_lock);
     wait_for_overlapping_aiocb(s, acb);
     QLIST_INSERT_HEAD(&s->inflight_aiocb_head, acb, aiocb_siblings);
+    qemu_co_mutex_unlock(&s->queue_lock);
 }
 
 static SocketAddress *sd_socket_address(const char *path,
@@ -786,6 +789,7 @@ static coroutine_fn void reconnect_to_sdog(void *opaque)
      * have to move all the inflight requests to the failed queue before
      * resend_aioreq() is called.
      */
+    qemu_co_mutex_lock(&s->queue_lock);
     QLIST_FOREACH_SAFE(aio_req, &s->inflight_aio_head, aio_siblings, next) {
         QLIST_REMOVE(aio_req, aio_siblings);
         QLIST_INSERT_HEAD(&s->failed_aio_head, aio_req, aio_siblings);
@@ -795,8 +799,11 @@ static coroutine_fn void reconnect_to_sdog(void *opaque)
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
@@ -888,7 +895,10 @@ static void coroutine_fn aio_read_response(void *opaque)
     */
     s->co_recv = NULL;
 
+    qemu_co_mutex_lock(&s->queue_lock);
     QLIST_REMOVE(aio_req, aio_siblings);
+    qemu_co_mutex_unlock(&s->queue_lock);
+
     switch (rsp.result) {
     case SD_RES_SUCCESS:
         break;
@@ -1308,7 +1318,9 @@ static void coroutine_fn add_aio_request(BDRVSheepdogState *s, AIOReq *aio_req,
     uint64_t old_oid = aio_req->base_oid;
     bool create = aio_req->create;
 
+    qemu_co_mutex_lock(&s->queue_lock);
     QLIST_INSERT_HEAD(&s->inflight_aio_head, aio_req, aio_siblings);
+    qemu_co_mutex_unlock(&s->queue_lock);
 
     if (!nr_copies) {
         error_report("bug");
@@ -1679,6 +1691,7 @@ static int sd_open(BlockDriverState *bs, QDict *options, int flags,
     bs->total_sectors = s->inode.vdi_size / BDRV_SECTOR_SIZE;
     pstrcpy(s->name, sizeof(s->name), vdi);
     qemu_co_mutex_init(&s->lock);
+    qemu_co_mutex_init(&s->queue_lock);
     qemu_co_queue_init(&s->overlapping_queue);
     qemu_opts_del(opts);
     g_free(buf);
@@ -2432,12 +2445,16 @@ static void coroutine_fn sd_co_rw_vector(SheepdogAIOCB *acb)
 
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
2.13.0
