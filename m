Received: from eggs.gnu.org ([209.51.188.92]:39103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gk9gp-0001ty-Bz
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:34:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gk9go-0007qJ-0R
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:34:43 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 17 Jan 2019 17:33:53 +0200
Message-Id: <2da7b388a740d1f1b7f40e1182fc821f8abb8fbb.1547739122.git.berto@igalia.com>
In-Reply-To: <cover.1547739122.git.berto@igalia.com>
References: <cover.1547739122.git.berto@igalia.com>
In-Reply-To: <cover.1547739122.git.berto@igalia.com>
References: <cover.1547739122.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 02/13] block: Freeze the backing chain for the
 duration of the commit job
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
 block/commit.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/commit.c b/block/commit.c
index 53148e610b..8824d135e0 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -73,6 +73,8 @@ static int commit_prepare(Job *job)
 {
     CommitBlockJob *s = container_of(job, CommitBlockJob, common.job);
 
+    bdrv_unfreeze_backing_chain(s->commit_top_bs, s->base_bs);
+
     /* Remove base node parent that still uses BLK_PERM_WRITE/RESIZE before
      * the normal backing chain can be restored. */
     blk_unref(s->base);
@@ -89,6 +91,8 @@ static void commit_abort(Job *job)
     CommitBlockJob *s = container_of(job, CommitBlockJob, common.job);
     BlockDriverState *top_bs = blk_bs(s->top);
 
+    bdrv_unfreeze_backing_chain(s->commit_top_bs, s->base_bs);
+
     /* Make sure commit_top_bs and top stay around until bdrv_replace_node() */
     bdrv_ref(top_bs);
     bdrv_ref(s->commit_top_bs);
@@ -336,6 +340,10 @@ void commit_start(const char *job_id, BlockDriverState *bs,
         }
     }
 
+    if (bdrv_freeze_backing_chain(commit_top_bs, base, errp) < 0) {
+        goto fail;
+    }
+
     ret = block_job_add_bdrv(&s->common, "base", base, 0, BLK_PERM_ALL, errp);
     if (ret < 0) {
         goto fail;
-- 
2.11.0
