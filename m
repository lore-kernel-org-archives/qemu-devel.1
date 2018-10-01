Received: from eggs.gnu.org ([2001:4830:134:3::10]:40381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g6vSN-0004qb-MJ
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 06:29:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g6vSK-0002L3-Ey
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 06:29:39 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon,  1 Oct 2018 13:29:23 +0300
Message-Id: <20181001102928.20533-14-vsementsov@virtuozzo.com>
In-Reply-To: <20181001102928.20533-1-vsementsov@virtuozzo.com>
References: <20181001102928.20533-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 13/18] block: introduce new filter driver:
 fleecing-hook
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

Fleecing-hook filter does copy-before-write operation. It should be
inserted above active disk and has a target node for CBW, like the
following:

    +-------+
    | Guest |
    +---+---+
        |r,w
        v
    +---+-----------+  target   +---------------+
    | Fleecing hook |---------->| target(qcow2) |
    +---+-----------+   CBW     +---+-----------+
        |                           |
backing |r,w                        |
        v                           |
    +---+---------+      backing    |
    | Active disk |<----------------+
    +-------------+        r

Target's backing may point to active disk (should be set up
separately), which gives fleecing-scheme.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/block-core.json  |  22 +++-
 block/fleecing-hook.c | 298 ++++++++++++++++++++++++++++++++++++++++++
 block/Makefile.objs   |   2 +
 3 files changed, 320 insertions(+), 2 deletions(-)
 create mode 100644 block/fleecing-hook.c

diff --git a/qapi/block-core.json b/qapi/block-core.json
index c4774af18e..13cf90eab6 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2628,7 +2628,8 @@
             'host_cdrom', 'host_device', 'http', 'https', 'iscsi', 'luks',
             'nbd', 'nfs', 'null-aio', 'null-co', 'nvme', 'parallels', 'qcow',
             'qcow2', 'qed', 'quorum', 'raw', 'rbd', 'replication', 'sheepdog',
-            'ssh', 'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'vxhs' ] }
+            'ssh', 'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'vxhs',
+            'fleecing-hook'] }
 
 ##
 # @BlockdevOptionsFile:
@@ -2719,6 +2720,22 @@
 { 'struct': 'BlockdevOptionsGenericFormat',
   'data': { 'file': 'BlockdevRef' } }
 
+##
+# @BlockdevOptionsFleecingHook:
+#
+# Driver specific block device options for image format that have no option
+# besides their data source.
+#
+# @append-to:        reference to or definition of the data source block device
+# @target:        reference to or definition of the data source block device
+# @copy-bitmap:   name for the copy-bitmap of the process. May be shared TODO: normal description here
+#
+# Since: 2.9
+##
+  { 'struct': 'BlockdevOptionsFleecingHook',
+    'data': { 'append-to': 'str', 'target': 'BlockdevRef',
+              '*copy-bitmap': 'str'} }
+
 ##
 # @BlockdevOptionsLUKS:
 #
@@ -3718,7 +3735,8 @@
       'vmdk':       'BlockdevOptionsGenericCOWFormat',
       'vpc':        'BlockdevOptionsGenericFormat',
       'vvfat':      'BlockdevOptionsVVFAT',
-      'vxhs':       'BlockdevOptionsVxHS'
+      'vxhs':       'BlockdevOptionsVxHS',
+      'fleecing-hook': 'BlockdevOptionsFleecingHook'
   } }
 
 ##
diff --git a/block/fleecing-hook.c b/block/fleecing-hook.c
new file mode 100644
index 0000000000..f4e2f3ce83
--- /dev/null
+++ b/block/fleecing-hook.c
@@ -0,0 +1,298 @@
+/*
+ * Fleecing Hook filter driver
+ *
+ * The driver performs Copy-Before-Write (CBW) operation: it is injected above
+ * some node, and before each write it copies _old_ data to the target node.
+ *
+ * Copyright (c) 2018 Virtuozzo International GmbH. All rights reserved.
+ *
+ * Author:
+ *  Sementsov-Ogievskiy Vladimir <vsementsov@virtuozzo.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/cutils.h"
+#include "qapi/error.h"
+#include "block/block_int.h"
+#include "block/qdict.h"
+
+typedef struct BDRVFleecingHookState {
+    BdrvDirtyBitmap *cbw_bitmap; /* what should be copied to @target
+                                    on guest write. */
+    BdrvChild *target;
+    bool cbw_bitmap_created;
+} BDRVFleecingHookState;
+
+static coroutine_fn int fleecing_hook_co_preadv(
+        BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+        QEMUIOVector *qiov, int flags)
+{
+    /* Features to be implemented:
+     * F1. COR. save read data to fleecing target for fast access
+     *     (to reduce reads). This possibly may be done with use of copy-on-read
+     *     filter, but we need an ability to make COR requests optional: for
+     *     example, if target is a ram-cache, and if it is full now, we should
+     *     skip doing COR request, as it is actually not necessary.
+     *
+     * F2. Feature for guest: read from fleecing target if data is in ram-cache
+     *     and is unchanged
+     */
+
+    return bdrv_co_preadv(bs->backing, offset, bytes, qiov, flags);
+}
+
+static coroutine_fn int fleecing_hook_cbw(BlockDriverState *bs, uint64_t offset,
+                                          uint64_t bytes)
+{
+    int ret = 0;
+    BDRVFleecingHookState *s = bs->opaque;
+    uint64_t gran = bdrv_dirty_bitmap_granularity(s->cbw_bitmap);
+    uint64_t end = QEMU_ALIGN_UP(offset + bytes, gran);
+    uint64_t off = QEMU_ALIGN_DOWN(offset, gran), len;
+    size_t align = MAX(bdrv_opt_mem_align(bs->backing->bs),
+                       bdrv_opt_mem_align(s->target->bs));
+    struct iovec iov = {
+        .iov_base = qemu_memalign(align, end - off),
+        .iov_len = end - off
+    };
+    QEMUIOVector qiov;
+
+    qemu_iovec_init_external(&qiov, &iov, 1);
+
+    /* Features to be implemented:
+     * F3. parallelize copying loop
+     * F4. detect zeros
+     * F5. use block_status ?
+     * F6. don't copy clusters which are already cached by COR [see F1]
+     */
+
+    len = end - off;
+    while (bdrv_dirty_bitmap_next_dirty_area(s->cbw_bitmap, &off, &len)) {
+        iov.iov_len = qiov.size = len;
+
+        bdrv_reset_dirty_bitmap(s->cbw_bitmap, off, len);
+
+        ret = bdrv_co_preadv(bs->backing, off, len, &qiov,
+                             BDRV_REQ_NO_SERIALISING);
+        if (ret < 0) {
+            bdrv_set_dirty_bitmap(s->cbw_bitmap, off, len);
+            goto finish;
+        }
+
+        ret = bdrv_co_pwritev(s->target, off, len, &qiov, BDRV_REQ_SERIALISING);
+        if (ret < 0) {
+            bdrv_set_dirty_bitmap(s->cbw_bitmap, off, len);
+            goto finish;
+        }
+
+        off += len;
+        if (off >= end) {
+            break;
+        }
+        len = end - off;
+    }
+
+finish:
+    qemu_vfree(iov.iov_base);
+
+    return ret;
+}
+
+static int coroutine_fn fleecing_hook_co_pdiscard(BlockDriverState *bs,
+                                                  int64_t offset, int bytes)
+{
+    int ret = fleecing_hook_cbw(bs, offset, bytes);
+    if (ret < 0) {
+        return ret;
+    }
+
+    /* Features to be implemented:
+     * F7. possibility of lazy discard: just defer the discard after fleecing
+     *     completion. If write (or new discard) occurs to the same area, just
+     *     drop deferred discard.
+     */
+
+    return bdrv_co_pdiscard(bs->backing, offset, bytes);
+}
+
+static int coroutine_fn fleecing_hook_co_pwrite_zeroes(BlockDriverState *bs,
+        int64_t offset, int bytes, BdrvRequestFlags flags)
+{
+    int ret = fleecing_hook_cbw(bs, offset, bytes);
+    if (ret < 0) {
+        /* F8. Additional option to break fleecing instead of breaking guest
+         * write here */
+        return ret;
+    }
+
+    return bdrv_co_pwrite_zeroes(bs->backing, offset, bytes, flags);
+}
+
+static coroutine_fn int fleecing_hook_co_pwritev(BlockDriverState *bs,
+                                                 uint64_t offset,
+                                                 uint64_t bytes,
+                                                 QEMUIOVector *qiov, int flags)
+{
+    int ret = fleecing_hook_cbw(bs, offset, bytes);
+    if (ret < 0) {
+        return ret;
+    }
+
+    return bdrv_co_pwritev(bs->backing, offset, bytes, qiov, flags);
+}
+
+static int coroutine_fn fleecing_hook_co_flush(BlockDriverState *bs)
+{
+    if (!bs->backing) {
+        return 0;
+    }
+
+    return bdrv_co_flush(bs->backing->bs);
+}
+
+static void fleecing_hook_refresh_filename(BlockDriverState *bs, QDict *opts)
+{
+    if (bs->backing == NULL) {
+        /* we can be here after failed bdrv_attach_child in
+         * bdrv_set_backing_hd */
+        return;
+    }
+    bdrv_refresh_filename(bs->backing->bs);
+    pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),
+            bs->backing->bs->filename);
+}
+
+static void fleecing_hook_child_perm(BlockDriverState *bs, BdrvChild *c,
+                                       const BdrvChildRole *role,
+                                       BlockReopenQueue *reopen_queue,
+                                       uint64_t perm, uint64_t shared,
+                                       uint64_t *nperm, uint64_t *nshared)
+{
+    bdrv_filter_default_perms(bs, c, role, reopen_queue, perm, shared, nperm,
+                              nshared);
+
+    if (role == &child_file) {
+        /* share write to target, to not interfere guest writes to it's disk
+         * which will be in target backing chain */
+        *nshared = *nshared | BLK_PERM_WRITE;
+    }
+}
+
+static int fleecing_hook_open(BlockDriverState *bs, QDict *options, int flags,
+                              Error **errp)
+{
+    BDRVFleecingHookState *s = bs->opaque;
+    Error *local_err = NULL;
+    const char *append_to, *copy_bitmap_name;
+    BlockDriverState *backing_bs;
+
+    append_to = qdict_get_str(options, "append-to");
+    qdict_del(options, "append-to");
+    backing_bs = bdrv_lookup_bs(append_to, append_to, errp);
+    if (!backing_bs) {
+        return -EINVAL;
+    }
+
+    bs->total_sectors = backing_bs->total_sectors;
+
+    copy_bitmap_name = qdict_get_try_str(options, "copy-bitmap");
+    if (copy_bitmap_name) {
+        qdict_del(options, "copy-bitmap");
+        s->cbw_bitmap = bdrv_find_dirty_bitmap(backing_bs, copy_bitmap_name);
+    }
+
+    if (!s->cbw_bitmap) {
+        s->cbw_bitmap = bdrv_create_dirty_bitmap(bs, 65536, copy_bitmap_name,
+                                                 errp);
+        if (!s->cbw_bitmap) {
+            return -EINVAL;
+        }
+        s->cbw_bitmap_created = true;
+    }
+
+    bdrv_disable_dirty_bitmap(s->cbw_bitmap);
+    bdrv_set_dirty_bitmap(s->cbw_bitmap, 0, bdrv_getlength(backing_bs));
+
+    s->target = bdrv_open_child(NULL, options, "target", bs, &child_file,
+                               false, errp);
+    if (!s->target) {
+        return -EINVAL;
+    }
+
+    bdrv_set_aio_context(bs, bdrv_get_aio_context(backing_bs));
+    bdrv_set_aio_context(s->target->bs, bdrv_get_aio_context(backing_bs));
+
+    bdrv_drained_begin(backing_bs);
+
+    bdrv_ref(bs);
+    bdrv_append(bs, backing_bs, &local_err);
+
+    if (local_err) {
+        bdrv_unref(bs);
+    }
+
+    bdrv_drained_end(backing_bs);
+
+    if (local_err) {
+        bdrv_unref_child(bs, s->target);
+        error_propagate(errp, local_err);
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+static void fleecing_hook_close(BlockDriverState *bs)
+{
+    BDRVFleecingHookState *s = bs->opaque;
+
+    if (s->cbw_bitmap && s->cbw_bitmap_created) {
+        bdrv_release_dirty_bitmap(bs, s->cbw_bitmap);
+    }
+
+    if (s->target) {
+        bdrv_unref_child(bs, s->target);
+    }
+}
+
+BlockDriver bdrv_fleecing_hook_filter = {
+    .format_name = "fleecing-hook",
+    .instance_size = sizeof(BDRVFleecingHookState),
+
+    .bdrv_co_preadv             = fleecing_hook_co_preadv,
+    .bdrv_co_pwritev            = fleecing_hook_co_pwritev,
+    .bdrv_co_pwrite_zeroes      = fleecing_hook_co_pwrite_zeroes,
+    .bdrv_co_pdiscard           = fleecing_hook_co_pdiscard,
+    .bdrv_co_flush              = fleecing_hook_co_flush,
+
+    .bdrv_co_block_status       = bdrv_co_block_status_from_backing,
+
+    .bdrv_refresh_filename      = fleecing_hook_refresh_filename,
+
+    .bdrv_open                  = fleecing_hook_open,
+    .bdrv_close                 = fleecing_hook_close,
+
+    .bdrv_child_perm            = fleecing_hook_child_perm,
+
+    .is_filter = true,
+};
+
+static void bdrv_fleecing_hook_init(void)
+{
+    bdrv_register(&bdrv_fleecing_hook_filter);
+}
+
+block_init(bdrv_fleecing_hook_init);
diff --git a/block/Makefile.objs b/block/Makefile.objs
index c8337bf186..081720b14f 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -31,6 +31,8 @@ block-obj-y += throttle.o copy-on-read.o
 
 block-obj-y += crypto.o
 
+block-obj-y += fleecing-hook.o
+
 common-obj-y += stream.o
 
 nfs.o-libs         := $(LIBNFS_LIBS)
-- 
2.18.0
