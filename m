Received: from eggs.gnu.org ([209.51.188.92]:59757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1h1b2J-0004pG-C3
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 13:13:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1h1b2I-0006YU-0Y
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 13:12:58 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Wed,  6 Mar 2019 20:11:02 +0200
Message-Id: <3f8b614194f300595b337b011a7be9427bbc533f.1551895814.git.berto@igalia.com>
In-Reply-To: <cover.1551895813.git.berto@igalia.com>
References: <cover.1551895813.git.berto@igalia.com>
In-Reply-To: <cover.1551895813.git.berto@igalia.com>
References: <cover.1551895813.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 02/13] block: Freeze the backing chain for
 the duration of the commit job
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
 block/commit.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/block/commit.c b/block/commit.c
index 3b46ca7f97..ba60fef58a 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -39,6 +39,7 @@ typedef struct CommitBlockJob {
     BlockDriverState *base_bs;
     BlockdevOnError on_error;
     bool base_read_only;
+    bool chain_frozen;
     char *backing_file_str;
 } CommitBlockJob;
 
@@ -68,6 +69,9 @@ static int commit_prepare(Job *job)
 {
     CommitBlockJob *s = container_of(job, CommitBlockJob, common.job);
 
+    bdrv_unfreeze_backing_chain(s->commit_top_bs, s->base_bs);
+    s->chain_frozen = false;
+
     /* Remove base node parent that still uses BLK_PERM_WRITE/RESIZE before
      * the normal backing chain can be restored. */
     blk_unref(s->base);
@@ -84,6 +88,10 @@ static void commit_abort(Job *job)
     CommitBlockJob *s = container_of(job, CommitBlockJob, common.job);
     BlockDriverState *top_bs = blk_bs(s->top);
 
+    if (s->chain_frozen) {
+        bdrv_unfreeze_backing_chain(s->commit_top_bs, s->base_bs);
+    }
+
     /* Make sure commit_top_bs and top stay around until bdrv_replace_node() */
     bdrv_ref(top_bs);
     bdrv_ref(s->commit_top_bs);
@@ -330,6 +338,11 @@ void commit_start(const char *job_id, BlockDriverState *bs,
         }
     }
 
+    if (bdrv_freeze_backing_chain(commit_top_bs, base, errp) < 0) {
+        goto fail;
+    }
+    s->chain_frozen = true;
+
     ret = block_job_add_bdrv(&s->common, "base", base, 0, BLK_PERM_ALL, errp);
     if (ret < 0) {
         goto fail;
@@ -362,6 +375,9 @@ void commit_start(const char *job_id, BlockDriverState *bs,
     return;
 
 fail:
+    if (s->chain_frozen) {
+        bdrv_unfreeze_backing_chain(commit_top_bs, base);
+    }
     if (s->base) {
         blk_unref(s->base);
     }
-- 
2.11.0
