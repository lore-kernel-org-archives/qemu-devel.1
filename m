Received: from eggs.gnu.org ([2001:4830:134:3::10]:59862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e2dvX-0007y0-Vb
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:53:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e2dvW-0004wA-Sw
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:53:32 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:39222 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1e2dvW-0004vL-Gx
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:53:30 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 12 Oct 2017 16:53:12 +0300
Message-Id: <20171012135313.227864-5-vsementsov@virtuozzo.com>
In-Reply-To: <20171012135313.227864-1-vsementsov@virtuozzo.com>
References: <20171012135313.227864-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 4/5] backup: simplify non-dirty bits progress
 processing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: jsnow@redhat.com, famz@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com, stefanha@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Set fake progress for non-dirty clusters in copy_bitmap initialization,
to. It simplifies code and allows further refactoring.

This patch changes user's view of backup progress, but formally it
doesn't changed: progress hops are just moved to the beginning.

Actually it's just a point of view: when do we actually skip clusters?
We can say in the very beginning, that we skip these clusters and do
not think about them later.

Of course, if go through disk sequentially, it's logical to say, that
we skip clusters between copied portions to the left and to the right
of them. But even now copying progress is not sequential because of
write notifiers. Future patches will introduce new backup architecture
which will do copying in several coroutines in parallel, so it will
make no sense to publish fake progress by parts in parallel with
other copying requests.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 block/backup.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 71ad59b417..04608836d7 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -369,7 +369,6 @@ static int coroutine_fn backup_run_incremental(BackupBlockJob *job)
     int64_t offset;
     int64_t cluster;
     int64_t end;
-    int64_t last_cluster = -1;
     BdrvDirtyBitmapIter *dbi;
 
     granularity = bdrv_dirty_bitmap_granularity(job->sync_bitmap);
@@ -380,12 +379,6 @@ static int coroutine_fn backup_run_incremental(BackupBlockJob *job)
     while ((offset = bdrv_dirty_iter_next(dbi)) >= 0) {
         cluster = offset / job->cluster_size;
 
-        /* Fake progress updates for any clusters we skipped */
-        if (cluster != last_cluster + 1) {
-            job->common.offset += ((cluster - last_cluster - 1) *
-                                   job->cluster_size);
-        }
-
         for (end = cluster + clusters_per_iter; cluster < end; cluster++) {
             do {
                 if (yield_and_check(job)) {
@@ -407,14 +400,6 @@ static int coroutine_fn backup_run_incremental(BackupBlockJob *job)
         if (granularity < job->cluster_size) {
             bdrv_set_dirty_iter(dbi, cluster * job->cluster_size);
         }
-
-        last_cluster = cluster - 1;
-    }
-
-    /* Play some final catchup with the progress meter */
-    end = DIV_ROUND_UP(job->common.len, job->cluster_size);
-    if (last_cluster + 1 < end) {
-        job->common.offset += ((end - last_cluster - 1) * job->cluster_size);
     }
 
 out:
@@ -456,6 +441,9 @@ static void backup_incremental_init_copy_bitmap(BackupBlockJob *job)
         bdrv_set_dirty_iter(dbi, next_cluster * job->cluster_size);
     }
 
+    job->common.offset = job->common.len -
+                         hbitmap_count(job->copy_bitmap) * job->cluster_size;
+
     bdrv_dirty_iter_free(dbi);
 }
 
-- 
2.11.1
