Received: from eggs.gnu.org ([2001:4830:134:3::10]:49893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dfRau-0003VQ-7L
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 10:04:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dfRas-0003ed-Lp
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 10:04:20 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Wed,  9 Aug 2017 17:02:56 +0300
Message-Id: <20170809140256.25584-7-el13635@mail.ntua.gr>
In-Reply-To: <20170809140256.25584-1-el13635@mail.ntua.gr>
References: <20170809140256.25584-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH v2 6/6] block: remove BlockBackendPublic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

All BlockBackend level throttling (via the implicit throttle filter node) is
done in block/block-backend.c and block/throttle-groups.c doesn't know
about BlockBackends anymore. Since BlockBackendPublic is not needed anymore, remove it.

Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 block/block-backend.c          | 43 +++++++++++++++++++-----------------------
 block/qapi.c                   |  4 ++--
 blockdev.c                     |  6 +++---
 include/sysemu/block-backend.h | 12 +-----------
 4 files changed, 25 insertions(+), 40 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 61983b7393..05f6e67222 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -36,7 +36,10 @@ struct BlockBackend {
     DriveInfo *legacy_dinfo;    /* null unless created by drive_new() */
     QTAILQ_ENTRY(BlockBackend) link;         /* for block_backends */
     QTAILQ_ENTRY(BlockBackend) monitor_link; /* for monitor_block_backends */
-    BlockBackendPublic public;
+
+    /* implicit throttle filter node for backwards compatibility with legacy
+     * throttling commands */
+    BlockDriverState *throttle_node;
 
     void *dev;                  /* attached device model, if any */
     bool legacy_dev;            /* true if dev is not a DeviceState */
@@ -283,7 +286,7 @@ static void blk_delete(BlockBackend *blk)
     assert(!blk->refcnt);
     assert(!blk->name);
     assert(!blk->dev);
-    if (blk->public.throttle_node) {
+    if (blk->throttle_node) {
         blk_io_limits_disable(blk);
     }
     if (blk->root) {
@@ -574,19 +577,11 @@ BlockBackend *blk_by_legacy_dinfo(DriveInfo *dinfo)
 }
 
 /*
- * Returns a pointer to the publicly accessible fields of @blk.
+ * Returns the throttle_node field of @blk.
  */
-BlockBackendPublic *blk_get_public(BlockBackend *blk)
+BlockDriverState *blk_get_throttle_node(BlockBackend *blk)
 {
-    return &blk->public;
-}
-
-/*
- * Returns a BlockBackend given the associated @public fields.
- */
-BlockBackend *blk_by_public(BlockBackendPublic *public)
-{
-    return container_of(public, BlockBackend, public);
+    return blk->throttle_node;
 }
 
 /*
@@ -1879,15 +1874,15 @@ int blk_commit_all(void)
 /* throttling disk I/O limits */
 void blk_set_io_limits(BlockBackend *blk, ThrottleConfig *cfg)
 {
-    assert(blk->public.throttle_node);
-    throttle_group_config(throttle_get_tgm(blk->public.throttle_node), cfg);
+    assert(blk->throttle_node);
+    throttle_group_config(throttle_get_tgm(blk->throttle_node), cfg);
 }
 
 void blk_io_limits_disable(BlockBackend *blk)
 {
     BlockDriverState *bs, *throttle_node;
 
-    throttle_node = blk_get_public(blk)->throttle_node;
+    throttle_node = blk->throttle_node;
 
     assert(throttle_node);
 
@@ -1903,7 +1898,7 @@ void blk_io_limits_disable(BlockBackend *blk)
      * blk, at this point it might have more than one parent, so use
      * bdrv_replace_node(). This destroys throttle_node */
     bdrv_replace_node(throttle_node, bs, &error_abort);
-    blk_get_public(blk)->throttle_node = NULL;
+    blk->throttle_node = NULL;
 
     bdrv_unref(bs);
     bdrv_drained_end(bs);
@@ -1944,7 +1939,7 @@ void blk_io_limits_enable(BlockBackend *blk, const char *group,  Error **errp)
 
 end:
     bdrv_drained_end(bs);
-    blk_get_public(blk)->throttle_node = throttle_node;
+    blk->throttle_node = throttle_node;
 }
 
 void blk_io_limits_update_group(BlockBackend *blk, const char *group, Error **errp)
@@ -1952,11 +1947,11 @@ void blk_io_limits_update_group(BlockBackend *blk, const char *group, Error **er
     ThrottleGroupMember *tgm;
 
     /* this BB is not part of any group */
-    if (!blk->public.throttle_node) {
+    if (!blk->throttle_node) {
         return;
     }
 
-    tgm = throttle_get_tgm(blk->public.throttle_node);
+    tgm = throttle_get_tgm(blk->throttle_node);
     /* this BB is a part of the same group than the one we want */
     if (!g_strcmp0(throttle_group_get_name(tgm),
                    group)) {
@@ -1981,8 +1976,8 @@ static void blk_root_drained_begin(BdrvChild *child)
 
     /* Note that blk->root may not be accessible here yet if we are just
      * attaching to a BlockDriverState that is drained. Use child instead. */
-    if (blk->public.throttle_node) {
-        tgm = throttle_get_tgm(blk->public.throttle_node);
+    if (blk->throttle_node) {
+        tgm = throttle_get_tgm(blk->throttle_node);
         if (atomic_fetch_inc(&tgm->io_limits_disabled) == 0) {
             throttle_group_restart_tgm(tgm);
         }
@@ -1995,8 +1990,8 @@ static void blk_root_drained_end(BdrvChild *child)
     BlockBackend *blk = child->opaque;
     assert(blk->quiesce_counter);
 
-    if (blk->public.throttle_node) {
-        tgm = throttle_get_tgm(blk->public.throttle_node);
+    if (blk->throttle_node) {
+        tgm = throttle_get_tgm(blk->throttle_node);
         assert(tgm->io_limits_disabled);
         atomic_dec(&tgm->io_limits_disabled);
     }
diff --git a/block/qapi.c b/block/qapi.c
index ab55db7134..2be44a6758 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -66,9 +66,9 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
 
     info->detect_zeroes = bs->detect_zeroes;
 
-    if (blk && blk_get_public(blk)->throttle_node) {
+    if (blk && blk_get_throttle_node(blk)) {
         ThrottleConfig cfg;
-        BlockDriverState *throttle_node = blk_get_public(blk)->throttle_node;
+        BlockDriverState *throttle_node = blk_get_throttle_node(blk);
         ThrottleGroupMember *tgm = throttle_get_tgm(throttle_node);
 
         throttle_group_get_config(tgm, &cfg);
diff --git a/blockdev.c b/blockdev.c
index 20e5513f87..5c11c245b0 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2714,7 +2714,7 @@ void qmp_block_set_io_throttle(BlockIOThrottle *arg, Error **errp)
     if (throttle_enabled(&cfg)) {
         /* Enable I/O limits if they're not enabled yet, otherwise
          * just update the throttling group. */
-        if (!blk_get_public(blk)->throttle_node) {
+        if (!blk_get_throttle_node(blk)) {
             blk_io_limits_enable(blk, arg->has_group ? arg->group :
                                  arg->has_device ? arg->device : arg->id,
                                  &local_err);
@@ -2733,10 +2733,10 @@ void qmp_block_set_io_throttle(BlockIOThrottle *arg, Error **errp)
             }
         }
 
-        throttle_node = blk_get_public(blk)->throttle_node;
+        throttle_node = blk_get_throttle_node(blk);
         tgm = throttle_get_tgm(throttle_node);
         throttle_group_config(tgm, &cfg);
-    } else if (blk_get_public(blk)->throttle_node) {
+    } else if (blk_get_throttle_node(blk)) {
         /*
          * If all throttling settings are set to 0, disable I/O limits
          * by deleting the legacy throttle node
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 4a7ca53685..a05d75fa5f 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -68,14 +68,6 @@ typedef struct BlockDevOps {
     void (*drained_end)(void *opaque);
 } BlockDevOps;
 
-/* This struct is embedded in (the private) BlockBackend struct and contains
- * fields that must be public. This is in particular for QLIST_ENTRY() and
- * friends so that BlockBackends can be kept in lists outside block-backend.c
- * */
-typedef struct BlockBackendPublic {
-    BlockDriverState *throttle_node;
-} BlockBackendPublic;
-
 BlockBackend *blk_new(uint64_t perm, uint64_t shared_perm);
 BlockBackend *blk_new_open(const char *filename, const char *reference,
                            QDict *options, int flags, Error **errp);
@@ -90,9 +82,7 @@ BlockBackend *blk_all_next(BlockBackend *blk);
 bool monitor_add_blk(BlockBackend *blk, const char *name, Error **errp);
 void monitor_remove_blk(BlockBackend *blk);
 
-BlockBackendPublic *blk_get_public(BlockBackend *blk);
-BlockBackend *blk_by_public(BlockBackendPublic *public);
-
+BlockDriverState *blk_get_throttle_node(BlockBackend *blk);
 BlockDriverState *blk_bs(BlockBackend *blk);
 void blk_remove_bs(BlockBackend *blk);
 int blk_insert_bs(BlockBackend *blk, BlockDriverState *bs, Error **errp);
-- 
2.11.0
