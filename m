Received: from eggs.gnu.org ([209.51.188.92]:38959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gk9gj-0001ld-GF
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:34:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gk9gh-0007bq-Kx
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:34:37 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 17 Jan 2019 17:33:55 +0200
Message-Id: <5c04485949b8cc3f63c6500b2bf6f70f4faaba4a.1547739122.git.berto@igalia.com>
In-Reply-To: <cover.1547739122.git.berto@igalia.com>
References: <cover.1547739122.git.berto@igalia.com>
In-Reply-To: <cover.1547739122.git.berto@igalia.com>
References: <cover.1547739122.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 04/13] block: Freeze the backing chain for the
 duration of the stream job
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
 block/stream.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/block/stream.c b/block/stream.c
index 7a49ac0992..39a2e10892 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -54,6 +54,14 @@ static int coroutine_fn stream_populate(BlockBackend *blk,
     return blk_co_preadv(blk, offset, qiov.size, &qiov, BDRV_REQ_COPY_ON_READ);
 }
 
+static void stream_abort(Job *job)
+{
+    StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
+    BlockJob *bjob = &s->common;
+
+    bdrv_unfreeze_backing_chain(blk_bs(bjob->blk), s->base);
+}
+
 static int stream_prepare(Job *job)
 {
     StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
@@ -63,6 +71,8 @@ static int stream_prepare(Job *job)
     Error *local_err = NULL;
     int ret = 0;
 
+    bdrv_unfreeze_backing_chain(bs, base);
+
     if (bs->backing) {
         const char *base_id = NULL, *base_fmt = NULL;
         if (base) {
@@ -213,6 +223,7 @@ static const BlockJobDriver stream_job_driver = {
         .free          = block_job_free,
         .run           = stream_run,
         .prepare       = stream_prepare,
+        .abort         = stream_abort,
         .clean         = stream_clean,
         .user_resume   = block_job_user_resume,
         .drain         = block_job_drain,
@@ -259,6 +270,11 @@ void stream_start(const char *job_id, BlockDriverState *bs,
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
-- 
2.11.0
