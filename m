Received: from eggs.gnu.org ([208.118.235.92]:43333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gdhOq-0001g1-Kk
	for qemu-devel@nongnu.org; Sun, 30 Dec 2018 15:09:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gdhOn-0008El-Ds
	for qemu-devel@nongnu.org; Sun, 30 Dec 2018 15:09:28 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Sun, 30 Dec 2018 23:09:12 +0300
Message-Id: <1546200557-774583-2-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1546200557-774583-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1546200557-774583-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v5 1/6] Stream block job involves copy-on-read
 filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, dgilbert@redhat.com, eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, andrey.shinkevich@virtuozzo.com

The copy-on-read filter is applied to block-stream operation.
It is necessary for further block discard option.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 block/stream.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 88 insertions(+), 2 deletions(-)

diff --git a/block/stream.c b/block/stream.c
index 7a49ac0..20e768e 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -16,6 +16,7 @@
 #include "block/block_int.h"
 #include "block/blockjob_int.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/ratelimit.h"
 #include "sysemu/block-backend.h"
@@ -35,8 +36,14 @@ typedef struct StreamBlockJob {
     BlockdevOnError on_error;
     char *backing_file_str;
     bool bs_read_only;
+    BlockDriverState *cor_filter_bs;
 } StreamBlockJob;
 
+static BlockDriverState *child_file_bs(BlockDriverState *bs)
+{
+    return bs->file ? bs->file->bs : NULL;
+}
+
 static int coroutine_fn stream_populate(BlockBackend *blk,
                                         int64_t offset, uint64_t bytes,
                                         void *buf)
@@ -54,7 +61,7 @@ static int coroutine_fn stream_populate(BlockBackend *blk,
     return blk_co_preadv(blk, offset, qiov.size, &qiov, BDRV_REQ_COPY_ON_READ);
 }
 
-static int stream_prepare(Job *job)
+static int stream_change_backing_file(Job *job)
 {
     StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
     BlockJob *bjob = &s->common;
@@ -82,6 +89,43 @@ static int stream_prepare(Job *job)
     return ret;
 }
 
+static void remove_filter(BlockDriverState *cor_filter_bs)
+{
+    BlockDriverState *bs = child_file_bs(cor_filter_bs);
+
+    /* Hold a guest back from writing until we remove the filter */
+    bdrv_drained_begin(bs);
+    bdrv_child_try_set_perm(cor_filter_bs->file, 0, BLK_PERM_ALL,
+                            &error_abort);
+    bdrv_replace_node(cor_filter_bs, bs, &error_abort);
+    bdrv_drained_end(bs);
+
+    bdrv_unref(cor_filter_bs);
+}
+
+static void stream_exit(Job *job)
+{
+    StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
+    if (s->cor_filter_bs == NULL) {
+        return;
+    }
+    /* Remove the filter driver from the graph */
+    remove_filter(s->cor_filter_bs);
+    s->cor_filter_bs = NULL;
+}
+
+static int stream_prepare(Job *job)
+{
+    stream_exit(job);
+
+    return stream_change_backing_file(job);
+}
+
+static void stream_abort(Job *job)
+{
+    stream_exit(job);
+}
+
 static void stream_clean(Job *job)
 {
     StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
@@ -102,7 +146,7 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
 {
     StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
     BlockBackend *blk = s->common.blk;
-    BlockDriverState *bs = blk_bs(blk);
+    BlockDriverState *bs = child_file_bs(s->cor_filter_bs);
     BlockDriverState *base = s->base;
     int64_t len;
     int64_t offset = 0;
@@ -206,6 +250,42 @@ out:
     return ret;
 }
 
+static BlockDriverState *create_filter_node(BlockDriverState *bs, Error **errp)
+{
+    QDict *opts = qdict_new();
+
+    qdict_put_str(opts, "driver", "copy-on-read");
+    qdict_put_str(opts, "file", bdrv_get_node_name(bs));
+
+    return bdrv_open(NULL, NULL, opts, BDRV_O_RDWR, errp);
+}
+
+static BlockDriverState *insert_filter(BlockDriverState *bs, Error **errp)
+{
+    BlockDriverState *cor_filter_bs;
+    Error *local_err = NULL;
+
+    cor_filter_bs = create_filter_node(bs, errp);
+    if (cor_filter_bs == NULL) {
+        error_prepend(errp, "Could not create filter node: ");
+        return NULL;
+    }
+
+    bdrv_set_aio_context(cor_filter_bs, bdrv_get_aio_context(bs));
+
+    bdrv_drained_begin(bs);
+    bdrv_replace_node(bs, cor_filter_bs, &local_err);
+    bdrv_drained_end(bs);
+
+    if (local_err) {
+        bdrv_unref(cor_filter_bs);
+        error_propagate(errp, local_err);
+        return NULL;
+    }
+
+    return cor_filter_bs;
+}
+
 static const BlockJobDriver stream_job_driver = {
     .job_driver = {
         .instance_size = sizeof(StreamBlockJob),
@@ -213,6 +293,7 @@ static const BlockJobDriver stream_job_driver = {
         .free          = block_job_free,
         .run           = stream_run,
         .prepare       = stream_prepare,
+        .abort         = stream_abort,
         .clean         = stream_clean,
         .user_resume   = block_job_user_resume,
         .drain         = block_job_drain,
@@ -259,6 +340,11 @@ void stream_start(const char *job_id, BlockDriverState *bs,
                            &error_abort);
     }
 
+    s->cor_filter_bs = insert_filter(bs, errp);
+    if (s->cor_filter_bs == NULL) {
+        goto fail;
+    }
+
     s->base = base;
     s->backing_file_str = g_strdup(backing_file_str);
     s->bs_read_only = bs_read_only;
-- 
1.8.3.1
