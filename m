Received: from eggs.gnu.org ([209.51.188.92]:40700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hHXcs-00067p-WC
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 13:48:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hHXcq-0003xy-K8
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 13:48:38 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 19 Apr 2019 20:48:32 +0300
Message-Id: <20190419174832.146377-3-vsementsov@virtuozzo.com>
In-Reply-To: <20190419174832.146377-1-vsementsov@virtuozzo.com>
References: <20190419174832.146377-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 2/2] blockjob: use blk_new_pinned in
 block_job_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: jsnow@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com

child_role job already has .stay_at_node=true, so on bdrv_replace_node
operation these child are unchanged. Make block job blk behave in same
manner, to avoid inconsistent intermediate graph states and workarounds
like in mirror.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/mirror.c | 6 +-----
 blockjob.c     | 2 +-
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index ff15cfb197..c2cb6bccff 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -713,12 +713,8 @@ static int mirror_exit_common(Job *job)
                             &error_abort);
     bdrv_replace_node(mirror_top_bs, backing_bs(mirror_top_bs), &error_abort);
 
-    /* We just changed the BDS the job BB refers to (with either or both of the
-     * bdrv_replace_node() calls), so switch the BB back so the cleanup does
-     * the right thing. We don't need any permissions any more now. */
-    blk_remove_bs(bjob->blk);
+    /* We don't need any permissions any more now. */
     blk_set_perm(bjob->blk, 0, BLK_PERM_ALL, &error_abort);
-    blk_insert_bs(bjob->blk, mirror_top_bs, &error_abort);
 
     bs_opaque->job = NULL;
 
diff --git a/blockjob.c b/blockjob.c
index 730101d282..47466bdfcf 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -396,7 +396,7 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
         job_id = bdrv_get_device_name(bs);
     }
 
-    blk = blk_new(perm, shared_perm);
+    blk = blk_new_pinned(perm, shared_perm);
     ret = blk_insert_bs(blk, bs, errp);
     if (ret < 0) {
         blk_unref(blk);
-- 
2.18.0
