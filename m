Received: from eggs.gnu.org ([2001:4830:134:3::10]:40380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g6vSN-0004qc-MH
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 06:29:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g6vSK-0002LN-PO
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 06:29:39 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon,  1 Oct 2018 13:29:24 +0300
Message-Id: <20181001102928.20533-15-vsementsov@virtuozzo.com>
In-Reply-To: <20181001102928.20533-1-vsementsov@virtuozzo.com>
References: <20181001102928.20533-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 14/18] block/fleecing-hook: internal api
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com, stefanha@redhat.com, jsnow@redhat.com, famz@redhat.com, jcody@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Add some functions to use fleecing-hook internally from backup job in
further commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block.h |  9 ++++++++
 block/fleecing-hook.c | 51 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/include/block/block.h b/include/block/block.h
index 4edc1e8afa..018751b6ea 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -710,4 +710,13 @@ int coroutine_fn bdrv_co_copy_range(BdrvChild *src, uint64_t src_offset,
                                     BdrvChild *dst, uint64_t dst_offset,
                                     uint64_t bytes, BdrvRequestFlags read_flags,
                                     BdrvRequestFlags write_flags);
+
+
+BlockDriverState *bdrv_fleecing_hook_append(BlockDriverState *source,
+                                            BlockDriverState *target,
+                                            const char *copy_bitmap_name,
+                                            Error **errp);
+void bdrv_fleecing_hook_drop(BlockDriverState *hook);
+uint64_t bdrv_fleecing_hook_progress(BlockDriverState *hook);
+
 #endif
diff --git a/block/fleecing-hook.c b/block/fleecing-hook.c
index f4e2f3ce83..1471b985b2 100644
--- a/block/fleecing-hook.c
+++ b/block/fleecing-hook.c
@@ -34,6 +34,8 @@ typedef struct BDRVFleecingHookState {
                                     on guest write. */
     BdrvChild *target;
     bool cbw_bitmap_created;
+
+    uint64_t bytes_copied;
 } BDRVFleecingHookState;
 
 static coroutine_fn int fleecing_hook_co_preadv(
@@ -98,6 +100,7 @@ static coroutine_fn int fleecing_hook_cbw(BlockDriverState *bs, uint64_t offset,
             goto finish;
         }
 
+        s->bytes_copied += len;
         off += len;
         if (off >= end) {
             break;
@@ -296,3 +299,51 @@ static void bdrv_fleecing_hook_init(void)
 }
 
 block_init(bdrv_fleecing_hook_init);
+
+BlockDriverState *bdrv_fleecing_hook_append(BlockDriverState *source,
+                                            BlockDriverState *target,
+                                            const char *copy_bitmap_name,
+                                            Error **errp)
+{
+    QDict *opts = qdict_new();
+
+    qdict_put_str(opts, "driver", "fleecing-hook");
+    qdict_put_str(opts, "append-to", bdrv_get_node_name(source));
+    qdict_put_str(opts, "target", bdrv_get_node_name(target));
+    if (copy_bitmap_name) {
+        qdict_put_str(opts, "copy-bitmap", copy_bitmap_name);
+    }
+
+    /* set defaults like qmp_blockdev_add */
+    qdict_put_str(opts, BDRV_OPT_CACHE_DIRECT, "off");
+    qdict_put_str(opts, BDRV_OPT_CACHE_NO_FLUSH, "off");
+    qdict_put_str(opts, BDRV_OPT_READ_ONLY, "off");
+
+    return bdrv_open(NULL, NULL, opts, 0, errp);
+}
+
+void bdrv_fleecing_hook_drop(BlockDriverState *hook)
+{
+    AioContext *aio_context = bdrv_get_aio_context(hook);
+
+    aio_context_acquire(aio_context);
+
+    bdrv_drained_begin(hook);
+
+    bdrv_child_try_set_perm(hook->backing, 0, BLK_PERM_ALL, &error_abort);
+    bdrv_replace_node(hook, backing_bs(hook), &error_abort);
+    bdrv_set_backing_hd(hook, NULL, &error_abort);
+
+    bdrv_drained_end(hook);
+
+    bdrv_unref(hook);
+
+    aio_context_release(aio_context);
+}
+
+uint64_t bdrv_fleecing_hook_progress(BlockDriverState *hook)
+{
+    BDRVFleecingHookState *s = hook->opaque;
+
+    return s->bytes_copied;
+}
-- 
2.18.0
