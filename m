Received: from eggs.gnu.org ([2001:4830:134:3::10]:42884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fXotk-0001rN-43
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 10:24:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fXoti-000378-Vb
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 10:24:48 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 26 Jun 2018 16:24:31 +0200
Message-Id: <20180626142434.22090-4-kwolf@redhat.com>
In-Reply-To: <20180626142434.22090-1-kwolf@redhat.com>
References: <20180626142434.22090-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/6] qcow2: Remove coroutine trampoline for
 preallocate_co()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

All callers are coroutine_fns now, so we can just directly call
preallocate_co().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c | 51 ++++++++-------------------------------------------
 1 file changed, 8 insertions(+), 43 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index cd1836bc5b..3062e34f5e 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2521,15 +2521,6 @@ static int qcow2_set_up_encryption(BlockDriverState *bs,
     return ret;
 }
 
-
-typedef struct PreallocCo {
-    BlockDriverState *bs;
-    uint64_t offset;
-    uint64_t new_length;
-
-    int ret;
-} PreallocCo;
-
 /**
  * Preallocates metadata structures for data clusters between @offset (in the
  * guest disk) and @new_length (which is thus generally the new guest disk
@@ -2537,12 +2528,9 @@ typedef struct PreallocCo {
  *
  * Returns: 0 on success, -errno on failure.
  */
-static void coroutine_fn preallocate_co(void *opaque)
+static int coroutine_fn preallocate_co(BlockDriverState *bs, uint64_t offset,
+                                       uint64_t new_length)
 {
-    PreallocCo *params = opaque;
-    BlockDriverState *bs = params->bs;
-    uint64_t offset = params->offset;
-    uint64_t new_length = params->new_length;
     uint64_t bytes;
     uint64_t host_offset = 0;
     unsigned int cur_bytes;
@@ -2557,7 +2545,7 @@ static void coroutine_fn preallocate_co(void *opaque)
         ret = qcow2_alloc_cluster_offset(bs, offset, &cur_bytes,
                                          &host_offset, &meta);
         if (ret < 0) {
-            goto done;
+            return ret;
         }
 
         while (meta) {
@@ -2567,7 +2555,7 @@ static void coroutine_fn preallocate_co(void *opaque)
             if (ret < 0) {
                 qcow2_free_any_clusters(bs, meta->alloc_offset,
                                         meta->nb_clusters, QCOW2_DISCARD_NEVER);
-                goto done;
+                return ret;
             }
 
             /* There are no dependent requests, but we need to remove our
@@ -2594,34 +2582,11 @@ static void coroutine_fn preallocate_co(void *opaque)
         ret = bdrv_pwrite(bs->file, (host_offset + cur_bytes) - 1,
                           &data, 1);
         if (ret < 0) {
-            goto done;
+            return ret;
         }
     }
 
-    ret = 0;
-
-done:
-    params->ret = ret;
-}
-
-static int preallocate(BlockDriverState *bs,
-                       uint64_t offset, uint64_t new_length)
-{
-    PreallocCo params = {
-        .bs         = bs,
-        .offset     = offset,
-        .new_length = new_length,
-        .ret        = -EINPROGRESS,
-    };
-
-    if (qemu_in_coroutine()) {
-        preallocate_co(&params);
-    } else {
-        Coroutine *co = qemu_coroutine_create(preallocate_co, &params);
-        bdrv_coroutine_enter(bs, co);
-        BDRV_POLL_WHILE(bs, params.ret == -EINPROGRESS);
-    }
-    return params.ret;
+    return 0;
 }
 
 /* qcow2_refcount_metadata_size:
@@ -3039,7 +3004,7 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
     if (qcow2_opts->preallocation != PREALLOC_MODE_OFF) {
         BDRVQcow2State *s = blk_bs(blk)->opaque;
         qemu_co_mutex_lock(&s->lock);
-        ret = preallocate(blk_bs(blk), 0, qcow2_opts->size);
+        ret = preallocate_co(blk_bs(blk), 0, qcow2_opts->size);
         qemu_co_mutex_unlock(&s->lock);
 
         if (ret < 0) {
@@ -3547,7 +3512,7 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
         break;
 
     case PREALLOC_MODE_METADATA:
-        ret = preallocate(bs, old_length, offset);
+        ret = preallocate_co(bs, old_length, offset);
         if (ret < 0) {
             error_setg_errno(errp, -ret, "Preallocation failed");
             goto fail;
-- 
2.13.6
