Received: from eggs.gnu.org ([2001:4830:134:3::10]:33326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKkq-0000yQ-1C
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKkk-0006bh-9n
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:23 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 17:18:43 +0100
Message-Id: <20180309161933.8168-7-kwolf@redhat.com>
In-Reply-To: <20180309161933.8168-1-kwolf@redhat.com>
References: <20180309161933.8168-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 06/56] block: convert bdrv_invalidate_cache
 callback to coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Paolo Bonzini <pbonzini@redhat.com>

QED's bdrv_invalidate_cache implementation would like to reuse functions
that acquire/release the metadata locks.  Call it from coroutine context
to simplify the logic.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <1516279431-30424-6-git-send-email-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int.h |  3 ++-
 block.c                   | 41 +++++++++++++++++++++++++++++++++++++----
 block/iscsi.c             |  6 +++---
 block/nfs.c               |  6 +++---
 block/qcow2.c             |  7 +++++--
 block/qed.c               | 13 +++++--------
 block/rbd.c               |  6 +++---
 7 files changed, 58 insertions(+), 24 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 64a5700f2b..e391cae53b 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -224,7 +224,8 @@ struct BlockDriver {
     /*
      * Invalidate any cached meta-data.
      */
-    void (*bdrv_invalidate_cache)(BlockDriverState *bs, Error **errp);
+    void coroutine_fn (*bdrv_co_invalidate_cache)(BlockDriverState *bs,
+                                                  Error **errp);
     int (*bdrv_inactivate)(BlockDriverState *bs);
 
     /*
diff --git a/block.c b/block.c
index 4f76714f6b..603befb325 100644
--- a/block.c
+++ b/block.c
@@ -4209,7 +4209,8 @@ void bdrv_init_with_whitelist(void)
     bdrv_init();
 }
 
-void bdrv_invalidate_cache(BlockDriverState *bs, Error **errp)
+static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
+                                                  Error **errp)
 {
     BdrvChild *child, *parent;
     uint64_t perm, shared_perm;
@@ -4225,7 +4226,7 @@ void bdrv_invalidate_cache(BlockDriverState *bs, Error **errp)
     }
 
     QLIST_FOREACH(child, &bs->children, next) {
-        bdrv_invalidate_cache(child->bs, &local_err);
+        bdrv_co_invalidate_cache(child->bs, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             return;
@@ -4255,8 +4256,8 @@ void bdrv_invalidate_cache(BlockDriverState *bs, Error **errp)
     }
     bdrv_set_perm(bs, perm, shared_perm);
 
-    if (bs->drv->bdrv_invalidate_cache) {
-        bs->drv->bdrv_invalidate_cache(bs, &local_err);
+    if (bs->drv->bdrv_co_invalidate_cache) {
+        bs->drv->bdrv_co_invalidate_cache(bs, &local_err);
         if (local_err) {
             bs->open_flags |= BDRV_O_INACTIVE;
             error_propagate(errp, local_err);
@@ -4282,6 +4283,38 @@ void bdrv_invalidate_cache(BlockDriverState *bs, Error **errp)
     }
 }
 
+typedef struct InvalidateCacheCo {
+    BlockDriverState *bs;
+    Error **errp;
+    bool done;
+} InvalidateCacheCo;
+
+static void coroutine_fn bdrv_invalidate_cache_co_entry(void *opaque)
+{
+    InvalidateCacheCo *ico = opaque;
+    bdrv_co_invalidate_cache(ico->bs, ico->errp);
+    ico->done = true;
+}
+
+void bdrv_invalidate_cache(BlockDriverState *bs, Error **errp)
+{
+    Coroutine *co;
+    InvalidateCacheCo ico = {
+        .bs = bs,
+        .done = false,
+        .errp = errp
+    };
+
+    if (qemu_in_coroutine()) {
+        /* Fast-path if already in coroutine context */
+        bdrv_invalidate_cache_co_entry(&ico);
+    } else {
+        co = qemu_coroutine_create(bdrv_invalidate_cache_co_entry, &ico);
+        qemu_coroutine_enter(co);
+        BDRV_POLL_WHILE(bs, !ico.done);
+    }
+}
+
 void bdrv_invalidate_cache_all(Error **errp)
 {
     BlockDriverState *bs;
diff --git a/block/iscsi.c b/block/iscsi.c
index 8bf0e87244..a82170f16e 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -2177,8 +2177,8 @@ static int iscsi_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
     return 0;
 }
 
-static void iscsi_invalidate_cache(BlockDriverState *bs,
-                                   Error **errp)
+static void coroutine_fn iscsi_co_invalidate_cache(BlockDriverState *bs,
+                                                   Error **errp)
 {
     IscsiLun *iscsilun = bs->opaque;
     iscsi_allocmap_invalidate(iscsilun);
@@ -2209,7 +2209,7 @@ static BlockDriver bdrv_iscsi = {
     .create_opts            = &iscsi_create_opts,
     .bdrv_reopen_prepare    = iscsi_reopen_prepare,
     .bdrv_reopen_commit     = iscsi_reopen_commit,
-    .bdrv_invalidate_cache  = iscsi_invalidate_cache,
+    .bdrv_co_invalidate_cache = iscsi_co_invalidate_cache,
 
     .bdrv_getlength  = iscsi_getlength,
     .bdrv_get_info   = iscsi_get_info,
diff --git a/block/nfs.c b/block/nfs.c
index 1d82ff5042..7433d25856 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -876,8 +876,8 @@ static void nfs_refresh_filename(BlockDriverState *bs, QDict *options)
 }
 
 #ifdef LIBNFS_FEATURE_PAGECACHE
-static void nfs_invalidate_cache(BlockDriverState *bs,
-                                 Error **errp)
+static void coroutine_fn nfs_co_invalidate_cache(BlockDriverState *bs,
+                                                 Error **errp)
 {
     NFSClient *client = bs->opaque;
     nfs_pagecache_invalidate(client->context, client->fh);
@@ -910,7 +910,7 @@ static BlockDriver bdrv_nfs = {
     .bdrv_refresh_filename          = nfs_refresh_filename,
 
 #ifdef LIBNFS_FEATURE_PAGECACHE
-    .bdrv_invalidate_cache          = nfs_invalidate_cache,
+    .bdrv_co_invalidate_cache       = nfs_co_invalidate_cache,
 #endif
 };
 
diff --git a/block/qcow2.c b/block/qcow2.c
index 4ac1a45e61..ac8703fa47 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2142,7 +2142,8 @@ static void qcow2_close(BlockDriverState *bs)
     qcow2_free_snapshots(bs);
 }
 
-static void qcow2_invalidate_cache(BlockDriverState *bs, Error **errp)
+static void coroutine_fn qcow2_co_invalidate_cache(BlockDriverState *bs,
+                                                   Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
     int flags = s->flags;
@@ -2165,7 +2166,9 @@ static void qcow2_invalidate_cache(BlockDriverState *bs, Error **errp)
     options = qdict_clone_shallow(bs->options);
 
     flags &= ~BDRV_O_INACTIVE;
+    qemu_co_mutex_lock(&s->lock);
     ret = qcow2_do_open(bs, options, flags, &local_err);
+    qemu_co_mutex_unlock(&s->lock);
     QDECREF(options);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -4406,7 +4409,7 @@ BlockDriver bdrv_qcow2 = {
     .bdrv_change_backing_file   = qcow2_change_backing_file,
 
     .bdrv_refresh_limits        = qcow2_refresh_limits,
-    .bdrv_invalidate_cache      = qcow2_invalidate_cache,
+    .bdrv_co_invalidate_cache   = qcow2_co_invalidate_cache,
     .bdrv_inactivate            = qcow2_inactivate,
 
     .create_opts         = &qcow2_create_opts,
diff --git a/block/qed.c b/block/qed.c
index 2996f14fb0..5a5414bfc3 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -1521,7 +1521,8 @@ static int bdrv_qed_change_backing_file(BlockDriverState *bs,
     return ret;
 }
 
-static void bdrv_qed_invalidate_cache(BlockDriverState *bs, Error **errp)
+static void coroutine_fn bdrv_qed_co_invalidate_cache(BlockDriverState *bs,
+                                                      Error **errp)
 {
     BDRVQEDState *s = bs->opaque;
     Error *local_err = NULL;
@@ -1530,13 +1531,9 @@ static void bdrv_qed_invalidate_cache(BlockDriverState *bs, Error **errp)
     bdrv_qed_close(bs);
 
     bdrv_qed_init_state(bs);
-    if (qemu_in_coroutine()) {
-        qemu_co_mutex_lock(&s->table_lock);
-    }
+    qemu_co_mutex_lock(&s->table_lock);
     ret = bdrv_qed_do_open(bs, NULL, bs->open_flags, &local_err);
-    if (qemu_in_coroutine()) {
-        qemu_co_mutex_unlock(&s->table_lock);
-    }
+    qemu_co_mutex_unlock(&s->table_lock);
     if (local_err) {
         error_propagate(errp, local_err);
         error_prepend(errp, "Could not reopen qed layer: ");
@@ -1611,7 +1608,7 @@ static BlockDriver bdrv_qed = {
     .bdrv_get_info            = bdrv_qed_get_info,
     .bdrv_refresh_limits      = bdrv_qed_refresh_limits,
     .bdrv_change_backing_file = bdrv_qed_change_backing_file,
-    .bdrv_invalidate_cache    = bdrv_qed_invalidate_cache,
+    .bdrv_co_invalidate_cache = bdrv_qed_co_invalidate_cache,
     .bdrv_check               = bdrv_qed_check,
     .bdrv_detach_aio_context  = bdrv_qed_detach_aio_context,
     .bdrv_attach_aio_context  = bdrv_qed_attach_aio_context,
diff --git a/block/rbd.c b/block/rbd.c
index c7dd32e213..c1275c1ec9 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -1093,8 +1093,8 @@ static BlockAIOCB *qemu_rbd_aio_pdiscard(BlockDriverState *bs,
 #endif
 
 #ifdef LIBRBD_SUPPORTS_INVALIDATE
-static void qemu_rbd_invalidate_cache(BlockDriverState *bs,
-                                      Error **errp)
+static void coroutine_fn qemu_rbd_co_invalidate_cache(BlockDriverState *bs,
+                                                      Error **errp)
 {
     BDRVRBDState *s = bs->opaque;
     int r = rbd_invalidate_cache(s->image);
@@ -1160,7 +1160,7 @@ static BlockDriver bdrv_rbd = {
     .bdrv_snapshot_list     = qemu_rbd_snap_list,
     .bdrv_snapshot_goto     = qemu_rbd_snap_rollback,
 #ifdef LIBRBD_SUPPORTS_INVALIDATE
-    .bdrv_invalidate_cache  = qemu_rbd_invalidate_cache,
+    .bdrv_co_invalidate_cache = qemu_rbd_co_invalidate_cache,
 #endif
 };
 
-- 
2.13.6
