Received: from eggs.gnu.org ([209.51.188.92]:59496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1h1b1e-0004D5-Aj
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 13:12:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1h1b1a-0005tV-WD
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 13:12:17 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Wed,  6 Mar 2019 20:11:04 +0200
Message-Id: <cda663cba111ae10cf017ac7a6bf65a525bf7dfa.1551895814.git.berto@igalia.com>
In-Reply-To: <cover.1551895813.git.berto@igalia.com>
References: <cover.1551895813.git.berto@igalia.com>
In-Reply-To: <cover.1551895813.git.berto@igalia.com>
References: <cover.1551895813.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 04/13] block: Freeze the backing chain for
 the duration of the stream job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/stream.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/block/stream.c b/block/stream.c
index e14579ff80..6253c86fae 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -35,6 +35,7 @@ typedef struct StreamBlockJob {
     BlockdevOnError on_error;
     char *backing_file_str;
     bool bs_read_only;
+    bool chain_frozen;
 } StreamBlockJob;
 
 static int coroutine_fn stream_populate(BlockBackend *blk,
@@ -49,6 +50,16 @@ static int coroutine_fn stream_populate(BlockBackend *blk,
     return blk_co_preadv(blk, offset, qiov.size, &qiov, BDRV_REQ_COPY_ON_READ);
 }
 
+static void stream_abort(Job *job)
+{
+    StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
+
+    if (s->chain_frozen) {
+        BlockJob *bjob = &s->common;
+        bdrv_unfreeze_backing_chain(blk_bs(bjob->blk), s->base);
+    }
+}
+
 static int stream_prepare(Job *job)
 {
     StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
@@ -58,6 +69,9 @@ static int stream_prepare(Job *job)
     Error *local_err = NULL;
     int ret = 0;
 
+    bdrv_unfreeze_backing_chain(bs, base);
+    s->chain_frozen = false;
+
     if (bs->backing) {
         const char *base_id = NULL, *base_fmt = NULL;
         if (base) {
@@ -208,6 +222,7 @@ static const BlockJobDriver stream_job_driver = {
         .free          = block_job_free,
         .run           = stream_run,
         .prepare       = stream_prepare,
+        .abort         = stream_abort,
         .clean         = stream_clean,
         .user_resume   = block_job_user_resume,
         .drain         = block_job_drain,
@@ -254,9 +269,15 @@ void stream_start(const char *job_id, BlockDriverState *bs,
                            &error_abort);
     }
 
+    if (bdrv_freeze_backing_chain(bs, base, errp) < 0) {
+        job_early_fail(&s->common.job);
+        goto fail;
+    }
+
     s->base = base;
     s->backing_file_str = g_strdup(backing_file_str);
     s->bs_read_only = bs_read_only;
+    s->chain_frozen = true;
 
     s->on_error = on_error;
     trace_stream_start(bs, base, s);
-- 
2.11.0
