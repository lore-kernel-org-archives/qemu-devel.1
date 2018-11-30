Received: from eggs.gnu.org ([2001:4830:134:3::10]:51504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gSkZa-0007S1-BY
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:19:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gSkZW-0006WF-CI
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:19:18 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 30 Nov 2018 17:17:40 +0200
Message-Id: <3a01a1e6b2d21077f92cb880c9f6600d278b4aed.1543590618.git.berto@igalia.com>
In-Reply-To: <cover.1543590618.git.berto@igalia.com>
References: <cover.1543590618.git.berto@igalia.com>
In-Reply-To: <cover.1543590618.git.berto@igalia.com>
References: <cover.1543590618.git.berto@igalia.com>
Subject: [Qemu-devel] [RFC PATCH v2 02/12] block: Freeze the backing chain
 for the duration of the commit job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

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
