Received: from eggs.gnu.org ([2001:4830:134:3::10]:56335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cYnZD-00044m-5h
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 00:34:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cYnZB-0006WD-KR
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 00:34:51 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Wed,  1 Feb 2017 00:34:37 -0500
Message-Id: <20170201053440.26002-3-jcody@redhat.com>
In-Reply-To: <20170201053440.26002-1-jcody@redhat.com>
References: <20170201053440.26002-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 2/5] sheepdog: reorganize coroutine flow
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

Delimit co_recv's lifetime clearly in aio_read_response.

Do a simple qemu_coroutine_enter in aio_read_response, letting
sd_co_writev call sd_write_done.

Handle nr_pending in the same way in sd_co_rw_vector,
sd_write_done and sd_co_flush_to_disk.

Remove sd_co_rw_vector's return value; just leave with no
pending requests.

[Jeff: added missing 'return' back, spotted by Paolo after
       series was applied.]

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/sheepdog.c | 115 ++++++++++++++++++++-----------------------------------
 1 file changed, 42 insertions(+), 73 deletions(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index 5fde37a..e0985df 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -345,8 +345,6 @@ struct SheepdogAIOCB {
     enum AIOCBState aiocb_type;
 
     Coroutine *coroutine;
-    void (*aio_done_func)(SheepdogAIOCB *);
-
     int nr_pending;
 
     uint32_t min_affect_data_idx;
@@ -449,14 +447,13 @@ static const char * sd_strerror(int err)
  *
  * 1. In sd_co_rw_vector, we send the I/O requests to the server and
  *    link the requests to the inflight_list in the
- *    BDRVSheepdogState.  The function exits without waiting for
+ *    BDRVSheepdogState.  The function yields while waiting for
  *    receiving the response.
  *
  * 2. We receive the response in aio_read_response, the fd handler to
- *    the sheepdog connection.  If metadata update is needed, we send
- *    the write request to the vdi object in sd_write_done, the write
- *    completion function.  We switch back to sd_co_readv/writev after
- *    all the requests belonging to the AIOCB are finished.
+ *    the sheepdog connection.  We switch back to sd_co_readv/sd_writev
+ *    after all the requests belonging to the AIOCB are finished.  If
+ *    needed, sd_co_writev will send another requests for the vdi object.
  */
 
 static inline AIOReq *alloc_aio_req(BDRVSheepdogState *s, SheepdogAIOCB *acb,
@@ -491,12 +488,6 @@ static inline void free_aio_req(BDRVSheepdogState *s, AIOReq *aio_req)
     acb->nr_pending--;
 }
 
-static void coroutine_fn sd_finish_aiocb(SheepdogAIOCB *acb)
-{
-    qemu_coroutine_enter(acb->coroutine);
-    qemu_aio_unref(acb);
-}
-
 static const AIOCBInfo sd_aiocb_info = {
     .aiocb_size     = sizeof(SheepdogAIOCB),
 };
@@ -517,7 +508,6 @@ static SheepdogAIOCB *sd_aio_setup(BlockDriverState *bs, QEMUIOVector *qiov,
     acb->sector_num = sector_num;
     acb->nb_sectors = nb_sectors;
 
-    acb->aio_done_func = NULL;
     acb->coroutine = qemu_coroutine_self();
     acb->ret = 0;
     acb->nr_pending = 0;
@@ -788,9 +778,6 @@ static void coroutine_fn aio_read_response(void *opaque)
 
     switch (acb->aiocb_type) {
     case AIOCB_WRITE_UDATA:
-        /* this coroutine context is no longer suitable for co_recv
-         * because we may send data to update vdi objects */
-        s->co_recv = NULL;
         if (!is_data_obj(aio_req->oid)) {
             break;
         }
@@ -838,6 +825,11 @@ static void coroutine_fn aio_read_response(void *opaque)
         }
     }
 
+    /* No more data for this aio_req (reload_inode below uses its own file
+     * descriptor handler which doesn't use co_recv).
+    */
+    s->co_recv = NULL;
+
     switch (rsp.result) {
     case SD_RES_SUCCESS:
         break;
@@ -855,7 +847,7 @@ static void coroutine_fn aio_read_response(void *opaque)
             aio_req->oid = vid_to_vdi_oid(s->inode.vdi_id);
         }
         resend_aioreq(s, aio_req);
-        goto out;
+        return;
     default:
         acb->ret = -EIO;
         error_report("%s", sd_strerror(rsp.result));
@@ -868,13 +860,12 @@ static void coroutine_fn aio_read_response(void *opaque)
          * We've finished all requests which belong to the AIOCB, so
          * we can switch back to sd_co_readv/writev now.
          */
-        acb->aio_done_func(acb);
+        qemu_coroutine_enter(acb->coroutine);
     }
-out:
-    s->co_recv = NULL;
+
     return;
+
 err:
-    s->co_recv = NULL;
     reconnect_to_sdog(opaque);
 }
 
@@ -1973,7 +1964,6 @@ static int sd_truncate(BlockDriverState *bs, int64_t offset)
 /*
  * This function is called after writing data objects.  If we need to
  * update metadata, this sends a write request to the vdi object.
- * Otherwise, this switches back to sd_co_readv/writev.
  */
 static void coroutine_fn sd_write_done(SheepdogAIOCB *acb)
 {
@@ -1986,6 +1976,7 @@ static void coroutine_fn sd_write_done(SheepdogAIOCB *acb)
     mx = acb->max_dirty_data_idx;
     if (mn <= mx) {
         /* we need to update the vdi object. */
+        ++acb->nr_pending;
         offset = sizeof(s->inode) - sizeof(s->inode.data_vdi_id) +
             mn * sizeof(s->inode.data_vdi_id[0]);
         data_len = (mx - mn + 1) * sizeof(s->inode.data_vdi_id[0]);
@@ -1999,13 +1990,10 @@ static void coroutine_fn sd_write_done(SheepdogAIOCB *acb)
                                 data_len, offset, 0, false, 0, offset);
         QLIST_INSERT_HEAD(&s->inflight_aio_head, aio_req, aio_siblings);
         add_aio_request(s, aio_req, &iov, 1, AIOCB_WRITE_UDATA);
-
-        acb->aio_done_func = sd_finish_aiocb;
-        acb->aiocb_type = AIOCB_WRITE_UDATA;
-        return;
+        if (--acb->nr_pending) {
+            qemu_coroutine_yield();
+        }
     }
-
-    sd_finish_aiocb(acb);
 }
 
 /* Delete current working VDI on the snapshot chain */
@@ -2117,7 +2105,7 @@ out:
  * Returns 1 when we need to wait a response, 0 when there is no sent
  * request and -errno in error cases.
  */
-static int coroutine_fn sd_co_rw_vector(void *p)
+static void coroutine_fn sd_co_rw_vector(void *p)
 {
     SheepdogAIOCB *acb = p;
     int ret = 0;
@@ -2138,7 +2126,7 @@ static int coroutine_fn sd_co_rw_vector(void *p)
         ret = sd_create_branch(s);
         if (ret) {
             acb->ret = -EIO;
-            goto out;
+            return;
         }
     }
 
@@ -2212,11 +2200,9 @@ static int coroutine_fn sd_co_rw_vector(void *p)
         idx++;
         done += len;
     }
-out:
-    if (!--acb->nr_pending) {
-        return acb->ret;
+    if (--acb->nr_pending) {
+        qemu_coroutine_yield();
     }
-    return 1;
 }
 
 static bool check_overlapping_aiocb(BDRVSheepdogState *s, SheepdogAIOCB *aiocb)
@@ -2249,7 +2235,6 @@ static coroutine_fn int sd_co_writev(BlockDriverState *bs, int64_t sector_num,
     }
 
     acb = sd_aio_setup(bs, qiov, sector_num, nb_sectors);
-    acb->aio_done_func = sd_write_done;
     acb->aiocb_type = AIOCB_WRITE_UDATA;
 
 retry:
@@ -2258,20 +2243,14 @@ retry:
         goto retry;
     }
 
-    ret = sd_co_rw_vector(acb);
-    if (ret <= 0) {
-        QLIST_REMOVE(acb, aiocb_siblings);
-        qemu_co_queue_restart_all(&s->overlapping_queue);
-        qemu_aio_unref(acb);
-        return ret;
-    }
-
-    qemu_coroutine_yield();
+    sd_co_rw_vector(acb);
+    sd_write_done(acb);
 
     QLIST_REMOVE(acb, aiocb_siblings);
     qemu_co_queue_restart_all(&s->overlapping_queue);
-
-    return acb->ret;
+    ret = acb->ret;
+    qemu_aio_unref(acb);
+    return ret;
 }
 
 static coroutine_fn int sd_co_readv(BlockDriverState *bs, int64_t sector_num,
@@ -2283,7 +2262,6 @@ static coroutine_fn int sd_co_readv(BlockDriverState *bs, int64_t sector_num,
 
     acb = sd_aio_setup(bs, qiov, sector_num, nb_sectors);
     acb->aiocb_type = AIOCB_READ_UDATA;
-    acb->aio_done_func = sd_finish_aiocb;
 
 retry:
     if (check_overlapping_aiocb(s, acb)) {
@@ -2291,25 +2269,20 @@ retry:
         goto retry;
     }
 
-    ret = sd_co_rw_vector(acb);
-    if (ret <= 0) {
-        QLIST_REMOVE(acb, aiocb_siblings);
-        qemu_co_queue_restart_all(&s->overlapping_queue);
-        qemu_aio_unref(acb);
-        return ret;
-    }
-
-    qemu_coroutine_yield();
+    sd_co_rw_vector(acb);
 
     QLIST_REMOVE(acb, aiocb_siblings);
     qemu_co_queue_restart_all(&s->overlapping_queue);
-    return acb->ret;
+    ret = acb->ret;
+    qemu_aio_unref(acb);
+    return ret;
 }
 
 static int coroutine_fn sd_co_flush_to_disk(BlockDriverState *bs)
 {
     BDRVSheepdogState *s = bs->opaque;
     SheepdogAIOCB *acb;
+    int ret;
     AIOReq *aio_req;
 
     if (s->cache_flags != SD_FLAG_CMD_CACHE) {
@@ -2318,15 +2291,19 @@ static int coroutine_fn sd_co_flush_to_disk(BlockDriverState *bs)
 
     acb = sd_aio_setup(bs, NULL, 0, 0);
     acb->aiocb_type = AIOCB_FLUSH_CACHE;
-    acb->aio_done_func = sd_finish_aiocb;
 
+    acb->nr_pending++;
     aio_req = alloc_aio_req(s, acb, vid_to_vdi_oid(s->inode.vdi_id),
                             0, 0, 0, false, 0, 0);
     QLIST_INSERT_HEAD(&s->inflight_aio_head, aio_req, aio_siblings);
     add_aio_request(s, aio_req, NULL, 0, acb->aiocb_type);
 
-    qemu_coroutine_yield();
-    return acb->ret;
+    if (--acb->nr_pending) {
+        qemu_coroutine_yield();
+    }
+    ret = acb->ret;
+    qemu_aio_unref(acb);
+    return ret;
 }
 
 static int sd_snapshot_create(BlockDriverState *bs, QEMUSnapshotInfo *sn_info)
@@ -2783,7 +2760,6 @@ static coroutine_fn int sd_co_pdiscard(BlockDriverState *bs, int64_t offset,
     acb = sd_aio_setup(bs, &discard_iov, offset >> BDRV_SECTOR_BITS,
                        count >> BDRV_SECTOR_BITS);
     acb->aiocb_type = AIOCB_DISCARD_OBJ;
-    acb->aio_done_func = sd_finish_aiocb;
 
 retry:
     if (check_overlapping_aiocb(s, acb)) {
@@ -2791,20 +2767,13 @@ retry:
         goto retry;
     }
 
-    ret = sd_co_rw_vector(acb);
-    if (ret <= 0) {
-        QLIST_REMOVE(acb, aiocb_siblings);
-        qemu_co_queue_restart_all(&s->overlapping_queue);
-        qemu_aio_unref(acb);
-        return ret;
-    }
-
-    qemu_coroutine_yield();
+    sd_co_rw_vector(acb);
 
     QLIST_REMOVE(acb, aiocb_siblings);
     qemu_co_queue_restart_all(&s->overlapping_queue);
-
-    return acb->ret;
+    ret = acb->ret;
+    qemu_aio_unref(acb);
+    return ret;
 }
 
 static coroutine_fn int64_t
-- 
2.9.3
