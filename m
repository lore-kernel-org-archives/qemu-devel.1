Received: from eggs.gnu.org ([2001:4830:134:3::10]:57082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fTAMT-0003ZT-Uf
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 14:19:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fTAMS-0006cn-SG
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 14:19:13 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 13 Jun 2018 20:18:19 +0200
Message-Id: <20180613181823.13618-11-mreitz@redhat.com>
In-Reply-To: <20180613181823.13618-1-mreitz@redhat.com>
References: <20180613181823.13618-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v5 10/14] block/mirror: Add MirrorBDSOpaque
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jeff Cody <jcody@redhat.com>

This will allow us to access the block job data when the mirror block
driver becomes more complex.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
---
 block/mirror.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/block/mirror.c b/block/mirror.c
index fa94fd9d17..f060bd8bb4 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -76,6 +76,10 @@ typedef struct MirrorBlockJob {
     bool initial_zeroing_ongoing;
 } MirrorBlockJob;
 
+typedef struct MirrorBDSOpaque {
+    MirrorBlockJob *job;
+} MirrorBDSOpaque;
+
 struct MirrorOp {
     MirrorBlockJob *s;
     QEMUIOVector qiov;
@@ -599,6 +603,7 @@ static void mirror_exit(Job *job, void *opaque)
     MirrorBlockJob *s = container_of(job, MirrorBlockJob, common.job);
     BlockJob *bjob = &s->common;
     MirrorExitData *data = opaque;
+    MirrorBDSOpaque *bs_opaque = s->mirror_top_bs->opaque;
     AioContext *replace_aio_context = NULL;
     BlockDriverState *src = s->mirror_top_bs->backing->bs;
     BlockDriverState *target_bs = blk_bs(s->target);
@@ -691,6 +696,7 @@ static void mirror_exit(Job *job, void *opaque)
     blk_set_perm(bjob->blk, 0, BLK_PERM_ALL, &error_abort);
     blk_insert_bs(bjob->blk, mirror_top_bs, &error_abort);
 
+    bs_opaque->job = NULL;
     job_completed(job, data->ret, NULL);
 
     g_free(data);
@@ -1222,6 +1228,7 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
                              Error **errp)
 {
     MirrorBlockJob *s;
+    MirrorBDSOpaque *bs_opaque;
     BlockDriverState *mirror_top_bs;
     bool target_graph_mod;
     bool target_is_backing;
@@ -1257,6 +1264,8 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
     mirror_top_bs->total_sectors = bs->total_sectors;
     mirror_top_bs->supported_write_flags = BDRV_REQ_WRITE_UNCHANGED;
     mirror_top_bs->supported_zero_flags = BDRV_REQ_WRITE_UNCHANGED;
+    bs_opaque = g_new0(MirrorBDSOpaque, 1);
+    mirror_top_bs->opaque = bs_opaque;
     bdrv_set_aio_context(mirror_top_bs, bdrv_get_aio_context(bs));
 
     /* bdrv_append takes ownership of the mirror_top_bs reference, need to keep
@@ -1281,6 +1290,8 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
     if (!s) {
         goto fail;
     }
+    bs_opaque->job = s;
+
     /* The block job now has a reference to this node */
     bdrv_unref(mirror_top_bs);
 
@@ -1370,6 +1381,7 @@ fail:
 
         g_free(s->replaces);
         blk_unref(s->target);
+        bs_opaque->job = NULL;
         job_early_fail(&s->common.job);
     }
 
-- 
2.17.1
