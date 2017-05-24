Received: from eggs.gnu.org ([2001:4830:134:3::10]:34215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDMQT-0000k9-E3
	for qemu-devel@nongnu.org; Tue, 23 May 2017 22:53:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDMQS-00075Y-CP
	for qemu-devel@nongnu.org; Tue, 23 May 2017 22:53:29 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 24 May 2017 10:52:29 +0800
Message-Id: <20170524025235.32190-11-famz@redhat.com>
In-Reply-To: <20170524025235.32190-1-famz@redhat.com>
References: <20170524025235.32190-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 10/16] mirror: Do initial aio context move
 of target via BB interface
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

While blockdev-backup tried to verify before moving target's aio context, the
same is missing for blockdev-mirror. Now that we have the right interface, fix
this as well.

As a bonus, the aio context move is now conditional, which avoids some
unnecessary operations in bdrv_set_aio_context.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/mirror.c | 54 ++++++++++++++++++++++++++++++++----------------------
 blockdev.c     |  4 ----
 2 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index a3337ee..4eccb8d 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1118,13 +1118,44 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
                              bool auto_complete, const char *filter_node_name,
                              Error **errp)
 {
+    AioContext *aio_context, *target_context;
     MirrorBlockJob *s;
     BlockDriverState *mirror_top_bs;
+    BlockBackend *target_blk;
     bool target_graph_mod;
     bool target_is_backing;
     Error *local_err = NULL;
     int ret;
 
+    /* No resize for the target either; while the mirror is still running, a
+     * consistent read isn't necessarily possible. We could possibly allow
+     * writes and graph modifications, though it would likely defeat the
+     * purpose of a mirror, so leave them blocked for now.
+     *
+     * In the case of active commit, things look a bit different, though,
+     * because the target is an already populated backing file in active use.
+     * We can allow anything except resize there.*/
+    target_is_backing = bdrv_chain_contains(bs, target);
+    target_graph_mod = (backing_mode != MIRROR_LEAVE_BACKING_CHAIN);
+    target_blk = blk_new(BLK_PERM_WRITE | BLK_PERM_RESIZE |
+                         BLK_PERM_AIO_CONTEXT_CHANGE |
+                         (target_graph_mod ? BLK_PERM_GRAPH_MOD : 0),
+                         BLK_PERM_WRITE_UNCHANGED |
+                         (target_is_backing ? BLK_PERM_CONSISTENT_READ |
+                                              BLK_PERM_WRITE |
+                                              BLK_PERM_GRAPH_MOD : 0));
+    ret = blk_insert_bs(target_blk, target, errp);
+    if (ret < 0) {
+        blk_unref(target_blk);
+        return;
+    }
+    aio_context = bdrv_get_aio_context(bs);
+    target_context = bdrv_get_aio_context(target);
+    if (target_context != aio_context) {
+        aio_context_acquire(target_context);
+        blk_set_aio_context(target_blk, aio_context);
+        aio_context_release(target_context);
+    }
     if (granularity == 0) {
         granularity = bdrv_get_default_bitmap_granularity(target);
     }
@@ -1179,28 +1210,7 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
     s->source = bs;
     s->mirror_top_bs = mirror_top_bs;
 
-    /* No resize for the target either; while the mirror is still running, a
-     * consistent read isn't necessarily possible. We could possibly allow
-     * writes and graph modifications, though it would likely defeat the
-     * purpose of a mirror, so leave them blocked for now.
-     *
-     * In the case of active commit, things look a bit different, though,
-     * because the target is an already populated backing file in active use.
-     * We can allow anything except resize there.*/
-    target_is_backing = bdrv_chain_contains(bs, target);
-    target_graph_mod = (backing_mode != MIRROR_LEAVE_BACKING_CHAIN);
-    s->target = blk_new(BLK_PERM_WRITE | BLK_PERM_RESIZE |
-                        BLK_PERM_AIO_CONTEXT_CHANGE |
-                        (target_graph_mod ? BLK_PERM_GRAPH_MOD : 0),
-                        BLK_PERM_WRITE_UNCHANGED |
-                        (target_is_backing ? BLK_PERM_CONSISTENT_READ |
-                                             BLK_PERM_WRITE |
-                                             BLK_PERM_GRAPH_MOD : 0));
-    ret = blk_insert_bs(s->target, target, errp);
-    if (ret < 0) {
-        goto fail;
-    }
-
+    s->target = target_blk;
     s->replaces = g_strdup(replaces);
     s->on_source_error = on_source_error;
     s->on_target_error = on_target_error;
diff --git a/blockdev.c b/blockdev.c
index e8f72a1..52d81c4 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3545,8 +3545,6 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
         goto out;
     }
 
-    bdrv_set_aio_context(target_bs, aio_context);
-
     blockdev_mirror_common(arg->has_job_id ? arg->job_id : NULL, bs, target_bs,
                            arg->has_replaces, arg->replaces, arg->sync,
                            backing_mode, arg->has_speed, arg->speed,
@@ -3597,8 +3595,6 @@ void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
     aio_context = bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
 
-    bdrv_set_aio_context(target_bs, aio_context);
-
     blockdev_mirror_common(has_job_id ? job_id : NULL, bs, target_bs,
                            has_replaces, replaces, sync, backing_mode,
                            has_speed, speed,
-- 
2.9.4
