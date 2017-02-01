Received: from eggs.gnu.org ([2001:4830:134:3::10]:56308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cYnZC-00043h-02
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 00:34:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cYnZB-0006Vm-0Z
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 00:34:50 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Wed,  1 Feb 2017 00:34:39 -0500
Message-Id: <20170201053440.26002-5-jcody@redhat.com>
In-Reply-To: <20170201053440.26002-1-jcody@redhat.com>
References: <20170201053440.26002-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 4/5] sheepdog: simplify inflight_aio_head
 management
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com

From: Paolo Bonzini <pbonzini@redhat.com>

Add to the list in add_aio_request and, indirectly, resend_aioreq.  Inline
free_aio_req in the caller, it does not simply undo alloc_aio_req's job.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20161129113245.32724-5-pbonzini@redhat.com
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/sheepdog.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index 33ded57..3ef7601 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -479,16 +479,6 @@ static inline AIOReq *alloc_aio_req(BDRVSheepdogState *s, SheepdogAIOCB *acb,
     return aio_req;
 }
 
-static inline void free_aio_req(BDRVSheepdogState *s, AIOReq *aio_req)
-{
-    SheepdogAIOCB *acb = aio_req->aiocb;
-
-    QLIST_REMOVE(aio_req, aio_siblings);
-    g_free(aio_req);
-
-    acb->nr_pending--;
-}
-
 static void sd_aio_setup(SheepdogAIOCB *acb, BDRVSheepdogState *s,
                          QEMUIOVector *qiov, int64_t sector_num, int nb_sectors,
                          int type)
@@ -730,7 +720,6 @@ static coroutine_fn void reconnect_to_sdog(void *opaque)
     while (!QLIST_EMPTY(&s->failed_aio_head)) {
         aio_req = QLIST_FIRST(&s->failed_aio_head);
         QLIST_REMOVE(aio_req, aio_siblings);
-        QLIST_INSERT_HEAD(&s->inflight_aio_head, aio_req, aio_siblings);
         resend_aioreq(s, aio_req);
     }
 }
@@ -825,6 +814,7 @@ static void coroutine_fn aio_read_response(void *opaque)
     */
     s->co_recv = NULL;
 
+    QLIST_REMOVE(aio_req, aio_siblings);
     switch (rsp.result) {
     case SD_RES_SUCCESS:
         break;
@@ -849,8 +839,9 @@ static void coroutine_fn aio_read_response(void *opaque)
         break;
     }
 
-    free_aio_req(s, aio_req);
-    if (!acb->nr_pending) {
+    g_free(aio_req);
+
+    if (!--acb->nr_pending) {
         /*
          * We've finished all requests which belong to the AIOCB, so
          * we can switch back to sd_co_readv/writev now.
@@ -1110,6 +1101,8 @@ static void coroutine_fn add_aio_request(BDRVSheepdogState *s, AIOReq *aio_req,
     uint64_t old_oid = aio_req->base_oid;
     bool create = aio_req->create;
 
+    QLIST_INSERT_HEAD(&s->inflight_aio_head, aio_req, aio_siblings);
+
     if (!nr_copies) {
         error_report("bug");
     }
@@ -1983,7 +1976,6 @@ static void coroutine_fn sd_write_done(SheepdogAIOCB *acb)
         iov.iov_len = sizeof(s->inode);
         aio_req = alloc_aio_req(s, acb, vid_to_vdi_oid(s->inode.vdi_id),
                                 data_len, offset, 0, false, 0, offset);
-        QLIST_INSERT_HEAD(&s->inflight_aio_head, aio_req, aio_siblings);
         add_aio_request(s, aio_req, &iov, 1, AIOCB_WRITE_UDATA);
         if (--acb->nr_pending) {
             qemu_coroutine_yield();
@@ -2185,8 +2177,6 @@ static void coroutine_fn sd_co_rw_vector(SheepdogAIOCB *acb)
                                 old_oid,
                                 acb->aiocb_type == AIOCB_DISCARD_OBJ ?
                                 0 : done);
-        QLIST_INSERT_HEAD(&s->inflight_aio_head, aio_req, aio_siblings);
-
         add_aio_request(s, aio_req, acb->qiov->iov, acb->qiov->niov,
                         acb->aiocb_type);
     done:
@@ -2280,7 +2270,6 @@ static int coroutine_fn sd_co_flush_to_disk(BlockDriverState *bs)
     acb.nr_pending++;
     aio_req = alloc_aio_req(s, &acb, vid_to_vdi_oid(s->inode.vdi_id),
                             0, 0, 0, false, 0, 0);
-    QLIST_INSERT_HEAD(&s->inflight_aio_head, aio_req, aio_siblings);
     add_aio_request(s, aio_req, NULL, 0, acb.aiocb_type);
 
     if (--acb.nr_pending) {
-- 
2.9.3
