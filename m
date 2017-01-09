Received: from eggs.gnu.org ([2001:4830:134:3::10]:33565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cQaG3-00078r-Nk
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:45:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cQaFx-00034q-Or
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:45:07 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  9 Jan 2017 14:44:33 +0100
Message-Id: <1483969476-7172-12-git-send-email-kwolf@redhat.com>
In-Reply-To: <1483969476-7172-1-git-send-email-kwolf@redhat.com>
References: <1483969476-7172-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 11/14] blkdebug: Implement
 bdrv_co_preadv/pwritev/flush
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

This enables byte granularity requests for blkdebug, and at the same
time gets us rid of another user of the BDS-level AIO emulation.

Note that unless align=512 is specified, this can behave subtly
different from the old behaviour because bdrv_co_preadv/pwritev don't
have to perform alignment adjustments any more.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/blkdebug.c | 86 ++++++++++++++++++++++++++------------------------------
 1 file changed, 40 insertions(+), 46 deletions(-)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index 4127571..acccf85 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -58,10 +58,6 @@ typedef struct BlkdebugSuspendedReq {
     QLIST_ENTRY(BlkdebugSuspendedReq) next;
 } BlkdebugSuspendedReq;
 
-static const AIOCBInfo blkdebug_aiocb_info = {
-    .aiocb_size    = sizeof(BlkdebugAIOCB),
-};
-
 enum {
     ACTION_INJECT_ERROR,
     ACTION_SET_STATE,
@@ -77,7 +73,7 @@ typedef struct BlkdebugRule {
             int error;
             int immediately;
             int once;
-            int64_t sector;
+            int64_t offset;
         } inject;
         struct {
             int new_state;
@@ -174,6 +170,7 @@ static int add_rule(void *opaque, QemuOpts *opts, Error **errp)
     const char* event_name;
     BlkdebugEvent event;
     struct BlkdebugRule *rule;
+    int64_t sector;
 
     /* Find the right event for the rule */
     event_name = qemu_opt_get(opts, "event");
@@ -200,7 +197,9 @@ static int add_rule(void *opaque, QemuOpts *opts, Error **errp)
         rule->options.inject.once  = qemu_opt_get_bool(opts, "once", 0);
         rule->options.inject.immediately =
             qemu_opt_get_bool(opts, "immediately", 0);
-        rule->options.inject.sector = qemu_opt_get_number(opts, "sector", -1);
+        sector = qemu_opt_get_number(opts, "sector", -1);
+        rule->options.inject.offset =
+            sector == -1 ? -1 : sector * BDRV_SECTOR_SIZE;
         break;
 
     case ACTION_SET_STATE:
@@ -408,17 +407,14 @@ out:
 
 static void error_callback_bh(void *opaque)
 {
-    struct BlkdebugAIOCB *acb = opaque;
-    acb->common.cb(acb->common.opaque, acb->ret);
-    qemu_aio_unref(acb);
+    Coroutine *co = opaque;
+    qemu_coroutine_enter(co);
 }
 
-static BlockAIOCB *inject_error(BlockDriverState *bs,
-    BlockCompletionFunc *cb, void *opaque, BlkdebugRule *rule)
+static int inject_error(BlockDriverState *bs, BlkdebugRule *rule)
 {
     BDRVBlkdebugState *s = bs->opaque;
     int error = rule->options.inject.error;
-    struct BlkdebugAIOCB *acb;
     bool immediately = rule->options.inject.immediately;
 
     if (rule->options.inject.once) {
@@ -426,81 +422,79 @@ static BlockAIOCB *inject_error(BlockDriverState *bs,
         remove_rule(rule);
     }
 
-    if (immediately) {
-        return NULL;
+    if (!immediately) {
+        aio_bh_schedule_oneshot(bdrv_get_aio_context(bs), error_callback_bh,
+                                qemu_coroutine_self());
+        qemu_coroutine_yield();
     }
 
-    acb = qemu_aio_get(&blkdebug_aiocb_info, bs, cb, opaque);
-    acb->ret = -error;
-
-    aio_bh_schedule_oneshot(bdrv_get_aio_context(bs), error_callback_bh, acb);
-
-    return &acb->common;
+    return -error;
 }
 
-static BlockAIOCB *blkdebug_aio_readv(BlockDriverState *bs,
-    int64_t sector_num, QEMUIOVector *qiov, int nb_sectors,
-    BlockCompletionFunc *cb, void *opaque)
+static int coroutine_fn
+blkdebug_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+                   QEMUIOVector *qiov, int flags)
 {
     BDRVBlkdebugState *s = bs->opaque;
     BlkdebugRule *rule = NULL;
 
     QSIMPLEQ_FOREACH(rule, &s->active_rules, active_next) {
-        if (rule->options.inject.sector == -1 ||
-            (rule->options.inject.sector >= sector_num &&
-             rule->options.inject.sector < sector_num + nb_sectors)) {
+        uint64_t inject_offset = rule->options.inject.offset;
+
+        if (inject_offset == -1 ||
+            (inject_offset >= offset && inject_offset < offset + bytes))
+        {
             break;
         }
     }
 
     if (rule && rule->options.inject.error) {
-        return inject_error(bs, cb, opaque, rule);
+        return inject_error(bs, rule);
     }
 
-    return bdrv_aio_readv(bs->file, sector_num, qiov, nb_sectors,
-                          cb, opaque);
+    return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
 }
 
-static BlockAIOCB *blkdebug_aio_writev(BlockDriverState *bs,
-    int64_t sector_num, QEMUIOVector *qiov, int nb_sectors,
-    BlockCompletionFunc *cb, void *opaque)
+static int coroutine_fn
+blkdebug_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+                    QEMUIOVector *qiov, int flags)
 {
     BDRVBlkdebugState *s = bs->opaque;
     BlkdebugRule *rule = NULL;
 
     QSIMPLEQ_FOREACH(rule, &s->active_rules, active_next) {
-        if (rule->options.inject.sector == -1 ||
-            (rule->options.inject.sector >= sector_num &&
-             rule->options.inject.sector < sector_num + nb_sectors)) {
+        uint64_t inject_offset = rule->options.inject.offset;
+
+        if (inject_offset == -1 ||
+            (inject_offset >= offset && inject_offset < offset + bytes))
+        {
             break;
         }
     }
 
     if (rule && rule->options.inject.error) {
-        return inject_error(bs, cb, opaque, rule);
+        return inject_error(bs, rule);
     }
 
-    return bdrv_aio_writev(bs->file, sector_num, qiov, nb_sectors,
-                           cb, opaque);
+    return bdrv_co_pwritev(bs->file, offset, bytes, qiov, flags);
 }
 
-static BlockAIOCB *blkdebug_aio_flush(BlockDriverState *bs,
-    BlockCompletionFunc *cb, void *opaque)
+static int blkdebug_co_flush(BlockDriverState *bs)
 {
     BDRVBlkdebugState *s = bs->opaque;
     BlkdebugRule *rule = NULL;
 
     QSIMPLEQ_FOREACH(rule, &s->active_rules, active_next) {
-        if (rule->options.inject.sector == -1) {
+        if (rule->options.inject.offset == -1) {
             break;
         }
     }
 
     if (rule && rule->options.inject.error) {
-        return inject_error(bs, cb, opaque, rule);
+        return inject_error(bs, rule);
     }
 
-    return bdrv_aio_flush(bs->file->bs, cb, opaque);
+    return bdrv_co_flush(bs->file->bs);
 }
 
 
@@ -752,9 +746,9 @@ static BlockDriver bdrv_blkdebug = {
     .bdrv_refresh_filename  = blkdebug_refresh_filename,
     .bdrv_refresh_limits    = blkdebug_refresh_limits,
 
-    .bdrv_aio_readv         = blkdebug_aio_readv,
-    .bdrv_aio_writev        = blkdebug_aio_writev,
-    .bdrv_aio_flush         = blkdebug_aio_flush,
+    .bdrv_co_preadv         = blkdebug_co_preadv,
+    .bdrv_co_pwritev        = blkdebug_co_pwritev,
+    .bdrv_co_flush_to_disk  = blkdebug_co_flush,
 
     .bdrv_debug_event           = blkdebug_debug_event,
     .bdrv_debug_breakpoint      = blkdebug_debug_breakpoint,
-- 
1.8.3.1
