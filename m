Received: from eggs.gnu.org ([2001:4830:134:3::10]:41898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1er67J-0004nJ-DP
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:06:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1er67I-0004g9-9c
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:06:13 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 28 Feb 2018 19:05:04 +0100
Message-Id: <20180228180507.3964-14-mreitz@redhat.com>
In-Reply-To: <20180228180507.3964-1-mreitz@redhat.com>
References: <20180228180507.3964-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 13/16] block/mirror: Add MirrorBDSOpaque
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This will allow us to access the block job data when the mirror block
driver becomes more complex.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/mirror.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/block/mirror.c b/block/mirror.c
index addfdff4dd..d7bd1d3195 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -78,6 +78,10 @@ typedef struct MirrorBlockJob {
     bool initial_zeroing_ongoing;
 } MirrorBlockJob;
 
+typedef struct MirrorBDSOpaque {
+    MirrorBlockJob *job;
+} MirrorBDSOpaque;
+
 struct MirrorOp {
     MirrorBlockJob *s;
     QEMUIOVector qiov;
@@ -602,6 +606,7 @@ static void mirror_exit(BlockJob *job, void *opaque)
 {
     MirrorBlockJob *s = container_of(job, MirrorBlockJob, common);
     MirrorExitData *data = opaque;
+    MirrorBDSOpaque *bs_opaque = s->mirror_top_bs->opaque;
     AioContext *replace_aio_context = NULL;
     BlockDriverState *src = s->mirror_top_bs->backing->bs;
     BlockDriverState *target_bs = blk_bs(s->target);
@@ -694,6 +699,7 @@ static void mirror_exit(BlockJob *job, void *opaque)
     blk_set_perm(job->blk, 0, BLK_PERM_ALL, &error_abort);
     blk_insert_bs(job->blk, mirror_top_bs, &error_abort);
 
+    bs_opaque->job = NULL;
     block_job_completed(&s->common, data->ret);
 
     g_free(data);
@@ -1227,6 +1233,7 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
                              Error **errp)
 {
     MirrorBlockJob *s;
+    MirrorBDSOpaque *bs_opaque;
     BlockDriverState *mirror_top_bs;
     bool target_graph_mod;
     bool target_is_backing;
@@ -1260,6 +1267,8 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
         mirror_top_bs->implicit = true;
     }
     mirror_top_bs->total_sectors = bs->total_sectors;
+    bs_opaque = g_new0(MirrorBDSOpaque, 1);
+    mirror_top_bs->opaque = bs_opaque;
     bdrv_set_aio_context(mirror_top_bs, bdrv_get_aio_context(bs));
 
     /* bdrv_append takes ownership of the mirror_top_bs reference, need to keep
@@ -1284,6 +1293,8 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
     if (!s) {
         goto fail;
     }
+    bs_opaque->job = s;
+
     /* The block job now has a reference to this node */
     bdrv_unref(mirror_top_bs);
 
@@ -1373,6 +1384,7 @@ fail:
 
         g_free(s->replaces);
         blk_unref(s->target);
+        bs_opaque->job = NULL;
         block_job_early_fail(&s->common);
     }
 
-- 
2.14.3
