Received: from eggs.gnu.org ([2001:4830:134:3::10]:56090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1edkIP-0007RD-Gc
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 17:10:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1edkIO-0004F1-AD
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 17:10:29 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 22 Jan 2018 23:08:03 +0100
Message-Id: <20180122220806.22154-14-mreitz@redhat.com>
In-Reply-To: <20180122220806.22154-1-mreitz@redhat.com>
References: <20180122220806.22154-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 13/16] block/mirror: Add MirrorBDSOpaque
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This will allow us to access the block job data when the mirror block
driver becomes more complex.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/mirror.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/block/mirror.c b/block/mirror.c
index bb46f3c4e9..c1987b0230 100644
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
@@ -607,6 +611,7 @@ static void mirror_exit(BlockJob *job, void *opaque)
 {
     MirrorBlockJob *s = container_of(job, MirrorBlockJob, common);
     MirrorExitData *data = opaque;
+    MirrorBDSOpaque *bs_opaque = s->mirror_top_bs->opaque;
     AioContext *replace_aio_context = NULL;
     BlockDriverState *src = s->mirror_top_bs->backing->bs;
     BlockDriverState *target_bs = blk_bs(s->target);
@@ -699,6 +704,7 @@ static void mirror_exit(BlockJob *job, void *opaque)
     blk_set_perm(job->blk, 0, BLK_PERM_ALL, &error_abort);
     blk_insert_bs(job->blk, mirror_top_bs, &error_abort);
 
+    bs_opaque->job = NULL;
     block_job_completed(&s->common, data->ret);
 
     g_free(data);
@@ -1232,6 +1238,7 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
                              Error **errp)
 {
     MirrorBlockJob *s;
+    MirrorBDSOpaque *bs_opaque;
     BlockDriverState *mirror_top_bs;
     bool target_graph_mod;
     bool target_is_backing;
@@ -1265,6 +1272,8 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
         mirror_top_bs->implicit = true;
     }
     mirror_top_bs->total_sectors = bs->total_sectors;
+    bs_opaque = g_new0(MirrorBDSOpaque, 1);
+    mirror_top_bs->opaque = bs_opaque;
     bdrv_set_aio_context(mirror_top_bs, bdrv_get_aio_context(bs));
 
     /* bdrv_append takes ownership of the mirror_top_bs reference, need to keep
@@ -1289,6 +1298,8 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
     if (!s) {
         goto fail;
     }
+    bs_opaque->job = s;
+
     /* The block job now has a reference to this node */
     bdrv_unref(mirror_top_bs);
 
@@ -1378,6 +1389,7 @@ fail:
 
         g_free(s->replaces);
         blk_unref(s->target);
+        bs_opaque->job = NULL;
         block_job_early_fail(&s->common);
     }
 
-- 
2.14.3
