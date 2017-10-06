Received: from eggs.gnu.org ([2001:4830:134:3::10]:43355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cS3-0001wZ-Er
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:54:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cS1-0007f3-V9
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:54:43 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:50:05 -0300
Message-Id: <20171006235023.11952-71-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 70/88] block: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, qemu-block@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 block/backup.c         |  2 +-
 block/blkdebug.c       |  4 ++--
 block/commit.c         |  2 +-
 block/linux-aio.c      |  2 +-
 block/mirror.c         |  2 +-
 block/qapi.c           |  4 ++--
 block/qcow2-refcount.c | 12 +++++-------
 block/qed-l2-cache.c   |  2 +-
 block/sheepdog.c       |  2 +-
 block/stream.c         |  2 +-
 block/vhdx.c           |  2 +-
 block/win32-aio.c      |  2 +-
 12 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 06ddbfd03d..cd73e7d905 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -514,7 +514,7 @@ static void coroutine_fn backup_run(void *opaque)
     qemu_co_rwlock_unlock(&job->flush_rwlock);
     g_free(job->done_bitmap);
 
-    data = g_malloc(sizeof(*data));
+    data = g_new(BackupCompleteData, 1);
     data->ret = ret;
     block_job_defer_to_main_loop(&job->common, backup_complete, data);
 }
diff --git a/block/blkdebug.c b/block/blkdebug.c
index 46e53f2f09..4d05bcb1d9 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -175,7 +175,7 @@ static int add_rule(void *opaque, QemuOpts *opts, Error **errp)
     }
 
     /* Set attributes common for all actions */
-    rule = g_malloc0(sizeof(*rule));
+    rule = g_new(struct BlkdebugRule, 1);
     *rule = (struct BlkdebugRule) {
         .event  = event,
         .action = d->action,
@@ -727,7 +727,7 @@ static int blkdebug_debug_breakpoint(BlockDriverState *bs, const char *event,
         return -ENOENT;
     }
 
-    rule = g_malloc(sizeof(*rule));
+    rule = g_new(struct BlkdebugRule, 1);
     *rule = (struct BlkdebugRule) {
         .event  = blkdebug_event,
         .action = ACTION_SUSPEND,
diff --git a/block/commit.c b/block/commit.c
index 5036eec434..e698311d5f 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -210,7 +210,7 @@ static void coroutine_fn commit_run(void *opaque)
 out:
     qemu_vfree(buf);
 
-    data = g_malloc(sizeof(*data));
+    data = g_new(CommitCompleteData, 1);
     data->ret = ret;
     block_job_defer_to_main_loop(&s->common, commit_complete, data);
 }
diff --git a/block/linux-aio.c b/block/linux-aio.c
index 88b8d55ec7..e5a9d7fdeb 100644
--- a/block/linux-aio.c
+++ b/block/linux-aio.c
@@ -474,7 +474,7 @@ LinuxAioState *laio_init(void)
 {
     LinuxAioState *s;
 
-    s = g_malloc0(sizeof(*s));
+    s = g_new0(LinuxAioState, 1);
     if (event_notifier_init(&s->e, false) < 0) {
         goto out_free_state;
     }
diff --git a/block/mirror.c b/block/mirror.c
index 153758ca9f..948e5321a7 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -904,7 +904,7 @@ immediate_exit:
     g_free(s->in_flight_bitmap);
     bdrv_dirty_iter_free(s->dbi);
 
-    data = g_malloc(sizeof(*data));
+    data = g_new(MirrorExitData, 1);
     data->ret = ret;
 
     if (need_drain) {
diff --git a/block/qapi.c b/block/qapi.c
index 7fa2437923..808246bfc4 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -455,7 +455,7 @@ static BlockStats *bdrv_query_bds_stats(BlockDriverState *bs,
 {
     BlockStats *s = NULL;
 
-    s = g_malloc0(sizeof(*s));
+    s = g_new0(BlockStats, 1);
     s->stats = g_malloc0(sizeof(*s->stats));
 
     if (!bs) {
@@ -503,7 +503,7 @@ BlockInfoList *qmp_query_block(Error **errp)
             continue;
         }
 
-        info = g_malloc0(sizeof(*info));
+        info = g_new0(BlockInfoList, 1);
         bdrv_query_info(blk, &info->value, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index aa3fd6cf17..dd2387d2bb 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -755,7 +755,7 @@ static void update_refcount_discard(BlockDriverState *bs,
         }
     }
 
-    d = g_malloc(sizeof(*d));
+    d = g_new(Qcow2DiscardRegion, 1);
     *d = (Qcow2DiscardRegion) {
         .bs     = bs,
         .offset = offset,
@@ -2189,9 +2189,8 @@ write_refblocks:
 
             reftable_size = ROUND_UP((refblock_index + 1) * sizeof(uint64_t),
                                      s->cluster_size) / sizeof(uint64_t);
-            new_on_disk_reftable = g_try_realloc(on_disk_reftable,
-                                                 reftable_size *
-                                                 sizeof(uint64_t));
+            new_on_disk_reftable = g_try_renew(uint64_t, on_disk_reftable,
+                                               reftable_size);
             if (!new_on_disk_reftable) {
                 res->check_errors++;
                 ret = -ENOMEM;
@@ -2656,8 +2655,7 @@ static int alloc_refblock(BlockDriverState *bs, uint64_t **reftable,
             return -ENOTSUP;
         }
 
-        new_reftable = g_try_realloc(*reftable, new_reftable_size *
-                                                sizeof(uint64_t));
+        new_reftable = g_try_renew(uint64_t, *reftable, new_reftable_size);
         if (!new_reftable) {
             error_setg(errp, "Failed to increase reftable buffer size");
             return -ENOMEM;
@@ -3119,7 +3117,7 @@ int qcow2_shrink_reftable(BlockDriverState *bs)
 {
     BDRVQcow2State *s = bs->opaque;
     uint64_t *reftable_tmp =
-        g_malloc(s->refcount_table_size * sizeof(uint64_t));
+        g_new(uint64_t, s->refcount_table_size);
     int i, ret;
 
     for (i = 0; i < s->refcount_table_size; i++) {
diff --git a/block/qed-l2-cache.c b/block/qed-l2-cache.c
index b548362398..48689a6650 100644
--- a/block/qed-l2-cache.c
+++ b/block/qed-l2-cache.c
@@ -90,7 +90,7 @@ CachedL2Table *qed_alloc_l2_cache_entry(L2TableCache *l2_cache)
 {
     CachedL2Table *entry;
 
-    entry = g_malloc0(sizeof(*entry));
+    entry = g_new0(CachedL2Table, 1);
     entry->ref++;
 
     trace_qed_alloc_l2_cache_entry(l2_cache, entry);
diff --git a/block/sheepdog.c b/block/sheepdog.c
index 696a71442a..1f67ed43ca 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -467,7 +467,7 @@ static inline AIOReq *alloc_aio_req(BDRVSheepdogState *s, SheepdogAIOCB *acb,
 {
     AIOReq *aio_req;
 
-    aio_req = g_malloc(sizeof(*aio_req));
+    aio_req = g_new(AIOReq, 1);
     aio_req->aiocb = acb;
     aio_req->iov_offset = iov_offset;
     aio_req->oid = oid;
diff --git a/block/stream.c b/block/stream.c
index e6f72346e5..2b4c67de41 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -202,7 +202,7 @@ static void coroutine_fn stream_run(void *opaque)
 
 out:
     /* Modify backing chain and close BDSes in main loop */
-    data = g_malloc(sizeof(*data));
+    data = g_new(StreamCompleteData, 1);
     data->ret = ret;
     block_job_defer_to_main_loop(&s->common, stream_complete, data);
 }
diff --git a/block/vhdx.c b/block/vhdx.c
index 7ae4589879..8260fb46cd 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -244,7 +244,7 @@ static void vhdx_region_register(BDRVVHDXState *s,
 {
     VHDXRegionEntry *r;
 
-    r = g_malloc0(sizeof(*r));
+    r = g_new0(VHDXRegionEntry, 1);
 
     r->start = start;
     r->end = start + length;
diff --git a/block/win32-aio.c b/block/win32-aio.c
index 3be8f458fa..dfa062562f 100644
--- a/block/win32-aio.c
+++ b/block/win32-aio.c
@@ -190,7 +190,7 @@ QEMUWin32AIOState *win32_aio_init(void)
 {
     QEMUWin32AIOState *s;
 
-    s = g_malloc0(sizeof(*s));
+    s = g_new0(QEMUWin32AIOState, 1);
     if (event_notifier_init(&s->e, false) < 0) {
         goto out_free_state;
     }
-- 
2.14.2
