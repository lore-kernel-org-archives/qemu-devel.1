Received: from eggs.gnu.org ([2001:4830:134:3::10]:52336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0m9y-00040N-Tb
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:44:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0m9v-0005Jc-Rh
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:44:26 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 19 Apr 2017 17:43:44 +0800
Message-Id: <20170419094356.19826-5-famz@redhat.com>
In-Reply-To: <20170419094356.19826-1-famz@redhat.com>
References: <20170419094356.19826-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 04/16] blockjob: Allow aio context change on
 intermediate nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

The intermediate nodes do work with aio context change, so allow that
operations.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/commit.c | 3 ++-
 block/mirror.c | 3 ++-
 block/stream.c | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index 91d2c34..c07ee00 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -365,7 +365,8 @@ void commit_start(const char *job_id, BlockDriverState *bs,
          * for its backing file). The other options would be a second filter
          * driver above s->base. */
         ret = block_job_add_bdrv(&s->common, "intermediate node", iter, 0,
-                                 BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE,
+                                 BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE |
+                                 BLK_PERM_AIO_CONTEXT_CHANGE,
                                  errp);
         if (ret < 0) {
             goto fail;
diff --git a/block/mirror.c b/block/mirror.c
index 164438f..7ab3289 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1231,7 +1231,8 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
              * also blocked for its backing file). The other options would be a
              * second filter driver above s->base (== target). */
             ret = block_job_add_bdrv(&s->common, "intermediate node", iter, 0,
-                                     BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE,
+                                     BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE |
+                                     BLK_PERM_AIO_CONTEXT_CHANGE,
                                      errp);
             if (ret < 0) {
                 goto fail;
diff --git a/block/stream.c b/block/stream.c
index 0113710..2fab1f4 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -265,7 +265,8 @@ void stream_start(const char *job_id, BlockDriverState *bs,
      * and resizes. */
     for (iter = backing_bs(bs); iter && iter != base; iter = backing_bs(iter)) {
         block_job_add_bdrv(&s->common, "intermediate node", iter, 0,
-                           BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED,
+                           BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
+                           BLK_PERM_AIO_CONTEXT_CHANGE,
                            &error_abort);
     }
 
-- 
2.9.3
