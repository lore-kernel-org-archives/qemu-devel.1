Received: from eggs.gnu.org ([2001:4830:134:3::10]:41848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fpdN1-0004bp-JX
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:44:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fpdMm-00082i-Ck
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:44:39 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 14 Aug 2018 20:01:26 +0300
Message-Id: <20180814170126.56461-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [RFC v2] new, node-graph-based fleecing and backup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, famz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

[v2 is just a resend. I forget to add Den an me to cc, and I don't see the
letter in my thunderbird at all. strange. sorry for that]

Hi all!

Here is an idea and kind of proof-of-concept of how to unify and improve
push/pull backup schemes.

Let's start from fleecing, a way of importing a point-in-time snapshot not
creating a real snapshot. Now we do it with help of backup(sync=none)..

Proposal:

For fleecing we need two nodes:

1. fleecing hook. It's a filter which should be inserted on top of active
disk. It's main purpose is handling guest writes by copy-on-write operation,
i.e. it's a substitution for write-notifier in backup job.

2. fleecing cache. It's a target node for COW operations by fleecing-hook.
It also represents a point-in-time snapshot of active disk for the readers.

The simplest realization of fleecing cache is a qcow2 temporary image, backed
by active disk, i.e.:

    +-------+
    | Guest |
    +---+---+
        |
        v
    +---+-----------+  file     +-----------------------+
    | Fleecing hook +---------->+ Fleecing cache(qcow2) |
    +---+-----------+           +---+-------------------+
        |                           |
backing |                           |
        v                           |
    +---+---------+      backing    |
    | Active disk +<----------------+
    +-------------+

Hm. No, because of permissions I can't do so, I have to do like this:

    +-------+
    | Guest |
    +---+---+
        |
        v
    +---+-----------+  file     +-----------------------+
    | Fleecing hook +---------->+ Fleecing cache(qcow2) |
    +---+-----------+           +-----+-----------------+
        |                             |
backing |                             | backing
        v                             v
    +---+---------+   backing   +-----+---------------------+
    | Active disk +<------------+ hack children permissions |
    +-------------+             |     filter node           |
                                +---------------------------+

Ok, this works, it's an image fleecing scheme without any block jobs.

Problems with realization:

1 What to do with hack-permissions-node? What is a true way to implement
something like this? How to tune permissions to avoid this additional node?

2 Inserting/removing the filter. Do we have working way or developments on
it?

3. Interesting: we can't setup backing link to active disk before inserting
fleecing-hook, otherwise, it will damage this link on insertion. This means,
that we can't create fleecing cache node in advance with all backing to
reference it when creating fleecing hook. And we can't prepare all the nodes
in advance and then insert the filter.. We have to:
1. create all the nodes with all links in one big json, or
2. set backing links/create nodes automatically, as it is done in this RFC
 (it's a bad way I think, not clear, not transparent)

4. Is it a good idea to use "backing" and "file" links in such way?

Benefits, or, what can be done:

1. We can implement special Fleecing cache filter driver, which will be a real
cache: it will store some recently written clusters and RAM, it can have a
backing (or file?) qcow2 child, to flush some clusters to the disk, etc. So,
for each cluster of active disk we will have the following characteristics:

- changed (changed in active disk since backup start)
- copy (we need this cluster for fleecing user. For example, in RFC patch all
clusters are "copy", cow_bitmap is initialized to all ones. We can use some
existent bitmap to initialize cow_bitmap, and it will provide an "incremental"
fleecing (for use in incremental backup push or pull)
- cached in RAM
- cached in disk

On top of these characteristics we can implement the following features:

1. COR, we can cache clusters not only on writes but on reads too, if we have
free space in ram-cache (and if not, do not cache at all, don't write to
disk-cache). It may be done like bdrv_write(..., BDRV_REQ_UNNECESARY)

2. Benefit for guest: if cluster is unchanged and ram-cached, we can skip reading
from the devise

3. If needed, we can drop unchanged ram-cached clusters from ram-cache

4. On guest write, if cluster is already cached, we just mark it "changed"

5. Lazy discards: in some setups, discards are not guaranteed to do something,
so, we can at least defer some discards to the end of backup, if ram-cache is
full.

6. We can implement discard operation in fleecing cache, to make cluster
not needed (drop from cache, drop "copy" flag), so further reads of this
cluster will return error. So, fleecing client may read cluster by cluster
and discard them to reduce COW-load of the drive. We even can combine read
and discard into one command, something like "read-once", or it may be a
flag for fleecing-cache, that all reads are "read-once".

7. We can provide recommendations, on which clusters should fleecing-client
copy first. Examples:
a. copy ram-cached clusters first (obvious, to unload cache and reduce io
   overhead)
b. copy zero-clusters last (the don't occupy place in cache, so, lets copy
   other clusters first)
c. copy disk-cached clusters list (if we don't care about disk space,
   we can say, that for disk-cached clusters we already have a maximum
   io overhead, so let's copy other clusters first)
d. copy disk-cached clusters with high priority (but after ram-cached) -
   if we don't have enough disk space

So, there is a wide range of possible politics. How to provide these
recommendations?
1. block_status
2. create separate interface
3. internal backup job may access shared fleecing object directly.

About internal backup:
Of course, we need a job which will copy clusters. But it will be simplified:
it should not care about guest writes, it copies clusters from a kind of
snapshot which is not changing in time. This job should follow recommendations
from fleecing scheme [7].

What about the target?

We can use separate node as target, and copy from fleecing cache to the target.
If we have only ram-cache, it would be equal to current approach (data is copied
directly to the target, even on COW). If we have both ram- and disk- caches, it's
a cool solution for slow-target: instead of make guest wait for long write to
backup target (when ram-cache is full) we can write to disk-cache which is local
and fast.

Another option is to combine fleecing cache and target somehow (I didn't think
about this really).

Finally, with one - two (three?) special filters we can implement all current
fleecing/backup schemes in unique and very configurable way  and do a lot more
cool features and possibilities.

What do you think?

I really need help with fleecing graph creating/inserting/destroying, my code
about it is a hack, I don't like it, it just works.

About testing: to show that this work I use existing fleecing test - 222, a bit
tuned (drop block-job and use new qmp command to remove filter).

Based on:
   [PATCH v3 0/8] dirty-bitmap: rewrite bdrv_dirty_iter_next_area
   and
   [PATCH 0/2] block: make .bdrv_close optional
 qapi/block-core.json       |  23 +++-
 block/fleecing-hook.c      | 280 +++++++++++++++++++++++++++++++++++++++++++++
 blockdev.c                 |  37 ++++++
 block/Makefile.objs        |   2 +
 tests/qemu-iotests/222     |  21 ++--
 tests/qemu-iotests/222.out |   1 -
 6 files changed, 352 insertions(+), 12 deletions(-)
 create mode 100644 block/fleecing-hook.c

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 5b9084a394..70849074b3 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2549,7 +2549,8 @@
             'host_cdrom', 'host_device', 'http', 'https', 'iscsi', 'luks',
             'nbd', 'nfs', 'null-aio', 'null-co', 'nvme', 'parallels', 'qcow',
             'qcow2', 'qed', 'quorum', 'raw', 'rbd', 'replication', 'sheepdog',
-            'ssh', 'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'vxhs' ] }
+            'ssh', 'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'vxhs',
+            'fleecing-hook'] }
 
 ##
 # @BlockdevOptionsFile:
@@ -3636,7 +3637,8 @@
       'vmdk':       'BlockdevOptionsGenericCOWFormat',
       'vpc':        'BlockdevOptionsGenericFormat',
       'vvfat':      'BlockdevOptionsVVFAT',
-      'vxhs':       'BlockdevOptionsVxHS'
+      'vxhs':       'BlockdevOptionsVxHS',
+      'fleecing-hook': 'BlockdevOptionsGenericCOWFormat'
   } }
 
 ##
@@ -3757,6 +3759,23 @@
 { 'command': 'blockdev-del', 'data': { 'node-name': 'str' } }
 
 ##
+# @x-drop-fleecing:
+#
+# Deletes fleecing-hook filter from the top of the backing chain.
+#
+# @node-name: Name of the fleecing-hook node name.
+#
+# Since: 3.1
+#
+# -> { "execute": "x-drop-fleecing",
+#      "arguments": { "node-name": "fleece0" }
+#    }
+# <- { "return": {} }
+#
+##
+{ 'command': 'x-drop-fleecing', 'data': { 'node-name': 'str' } }
+
+##
 # @BlockdevCreateOptionsFile:
 #
 # Driver specific image creation options for file.
diff --git a/block/fleecing-hook.c b/block/fleecing-hook.c
new file mode 100644
index 0000000000..1728d503a7
--- /dev/null
+++ b/block/fleecing-hook.c
@@ -0,0 +1,280 @@
+#include "qemu/osdep.h"
+#include "qemu/cutils.h"
+#include "qemu-common.h"
+#include "qapi/error.h"
+#include "block/blockjob.h"
+#include "block/block_int.h"
+#include "block/block_backup.h"
+#include "block/qdict.h"
+#include "sysemu/block-backend.h"
+
+typedef struct BDRVFleecingHookState {
+    HBitmap *cow_bitmap; /* what should be copied to @file on guest write. */
+
+    /* use of common BlockDriverState fields:
+     * @backing: link to active disk. Fleecing hook is a filter, which should
+     *           replace active disk in block tree. Fleecing hook then transfers
+     *           requests to active disk through @backing link.
+     * @file: Fleecing cache. It's a storage for COW. @file should look like a
+     *        point-in-time snapshot of active disk for readers.
+     */
+} BDRVFleecingHookState;
+
+static coroutine_fn int fleecing_hook_co_preadv(BlockDriverState *bs,
+                                                uint64_t offset, uint64_t bytes,
+                                                QEMUIOVector *qiov, int flags)
+{
+    /* Features to be implemented:
+     * F1. COR. save read data to fleecing cache for fast access
+     *     (to reduce reads)
+     * F2. read from fleecing cache if data is in ram-cache and is unchanged
+     */
+
+    return bdrv_co_preadv(bs->backing, offset, bytes, qiov, flags);
+}
+
+static coroutine_fn int fleecing_hook_cow(BlockDriverState *bs, uint64_t offset,
+                                          uint64_t bytes)
+{
+    int ret = 0;
+    BDRVFleecingHookState *s = bs->opaque;
+    uint64_t gran = 1UL << hbitmap_granularity(s->cow_bitmap);
+    uint64_t end = QEMU_ALIGN_UP(offset + bytes, gran);
+    uint64_t off = QEMU_ALIGN_DOWN(offset, gran), len;
+    size_t align = MAX(bdrv_opt_mem_align(bs->backing->bs),
+                       bdrv_opt_mem_align(bs->file->bs));
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
+     * F6. don't cache clusters which are already cached by COR [see F1]
+     */
+
+    while (hbitmap_next_dirty_area(s->cow_bitmap, &off, end, &len)) {
+        iov.iov_len = qiov.size = len;
+        ret = bdrv_co_preadv(bs->backing, off, len, &qiov,
+                             BDRV_REQ_NO_SERIALISING);
+        if (ret < 0) {
+            goto finish;
+        }
+
+        ret = bdrv_co_pwritev(bs->file, off, len, &qiov, BDRV_REQ_SERIALISING);
+        if (ret < 0) {
+            goto finish;
+        }
+        hbitmap_reset(s->cow_bitmap, off, len);
+    }
+
+finish:
+    qemu_vfree(iov.iov_base);
+
+    return ret;
+}
+
+static int coroutine_fn fleecing_hook_co_pdiscard(
+        BlockDriverState *bs, int64_t offset, int bytes)
+{
+    int ret = fleecing_hook_cow(bs, offset, bytes);
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
+    int64_t offset, int bytes, BdrvRequestFlags flags)
+{
+    int ret = fleecing_hook_cow(bs, offset, bytes);
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
+    int ret = fleecing_hook_cow(bs, offset, bytes);
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
+    *nperm = BLK_PERM_CONSISTENT_READ;
+    *nshared = BLK_PERM_ALL;
+}
+
+static coroutine_fn int fleecing_cheat_co_preadv(BlockDriverState *bs,
+                                                uint64_t offset, uint64_t bytes,
+                                                QEMUIOVector *qiov, int flags)
+{
+    return bdrv_co_preadv(bs->backing, offset, bytes, qiov, flags);
+}
+
+static int coroutine_fn fleecing_cheat_co_pdiscard(
+        BlockDriverState *bs, int64_t offset, int bytes)
+{
+    return -EINVAL;
+}
+
+static coroutine_fn int fleecing_cheat_co_pwritev(BlockDriverState *bs,
+                                                 uint64_t offset,
+                                                 uint64_t bytes,
+                                                 QEMUIOVector *qiov, int flags)
+{
+    return -EINVAL;
+}
+
+BlockDriver bdrv_fleecing_cheat = {
+    .format_name = "fleecing-cheat",
+
+    .bdrv_co_preadv             = fleecing_cheat_co_preadv,
+    .bdrv_co_pwritev            = fleecing_cheat_co_pwritev,
+    .bdrv_co_pdiscard           = fleecing_cheat_co_pdiscard,
+
+    .bdrv_co_block_status       = bdrv_co_block_status_from_backing,
+
+    .bdrv_refresh_filename      = fleecing_hook_refresh_filename,
+    .bdrv_child_perm            = fleecing_hook_child_perm,
+};
+
+static int fleecing_hook_open(BlockDriverState *bs, QDict *options, int flags,
+                              Error **errp)
+{
+    BDRVFleecingHookState *s = bs->opaque;
+    Error *local_err = NULL;
+    const char *backing;
+    BlockDriverState *backing_bs, *cheat;
+
+    backing = qdict_get_try_str(options, "backing");
+    if (!backing) {
+        error_setg(errp, "No backing option");
+        return -EINVAL;
+    }
+
+    backing_bs = bdrv_lookup_bs(backing, backing, errp);
+    if (!backing_bs) {
+        return -EINVAL;
+    }
+
+    qdict_del(options, "backing");
+
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file,
+                               false, errp);
+    if (!bs->file) {
+        return -EINVAL;
+    }
+
+    bs->total_sectors = backing_bs->total_sectors;
+    bdrv_set_aio_context(bs, bdrv_get_aio_context(backing_bs));
+    bdrv_set_aio_context(bs->file->bs, bdrv_get_aio_context(backing_bs));
+
+    cheat = bdrv_new_open_driver(&bdrv_fleecing_cheat, "cheat",
+                                         BDRV_O_RDWR, errp);
+    cheat->total_sectors = backing_bs->total_sectors;
+    bdrv_set_aio_context(cheat, bdrv_get_aio_context(backing_bs));
+
+    bdrv_drained_begin(backing_bs);
+    bdrv_ref(bs);
+    bdrv_append(bs, backing_bs, &local_err);
+
+    bdrv_set_backing_hd(cheat, backing_bs, &error_abort);
+    bdrv_set_backing_hd(bs->file->bs, cheat, &error_abort);
+    bdrv_unref(cheat);
+
+    bdrv_drained_end(backing_bs);
+
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return -EINVAL;
+    }
+
+    s->cow_bitmap = hbitmap_alloc(bdrv_getlength(backing_bs), 16);
+    hbitmap_set(s->cow_bitmap, 0, bdrv_getlength(backing_bs));
+
+    return 0;
+}
+
+static void fleecing_hook_close(BlockDriverState *bs)
+{
+    BDRVFleecingHookState *s = bs->opaque;
+
+    if (s->cow_bitmap) {
+        hbitmap_free(s->cow_bitmap);
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
+    .bdrv_open                  = fleecing_hook_open,
+    .bdrv_close                 = fleecing_hook_close,
+
+    .bdrv_child_perm        = bdrv_filter_default_perms,
+};
+
+static void bdrv_fleecing_hook_init(void)
+{
+    bdrv_register(&bdrv_fleecing_hook_filter);
+}
+
+block_init(bdrv_fleecing_hook_init);
diff --git a/blockdev.c b/blockdev.c
index dcf8c8d2ab..0b734fa670 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -4284,6 +4284,43 @@ out:
     aio_context_release(aio_context);
 }
 
+void qmp_x_drop_fleecing(const char *node_name, Error **errp)
+{
+    AioContext *aio_context;
+    BlockDriverState *bs;
+
+    bs = bdrv_find_node(node_name);
+    if (!bs) {
+        error_setg(errp, "Cannot find node %s", node_name);
+        return;
+    }
+
+    if (!bdrv_has_blk(bs)) {
+        error_setg(errp, "Node %s is not inserted", node_name);
+        return;
+    }
+
+    if (!bs->backing) {
+        error_setg(errp, "'%s' has no backing", node_name);
+        return;
+    }
+
+    aio_context = bdrv_get_aio_context(bs);
+    aio_context_acquire(aio_context);
+
+    bdrv_drained_begin(bs);
+
+    bdrv_child_try_set_perm(bs->backing, 0, BLK_PERM_ALL, &error_abort);
+    bdrv_replace_node(bs, backing_bs(bs), &error_abort);
+    bdrv_set_backing_hd(bs, NULL, &error_abort);
+
+    bdrv_drained_end(bs);
+
+    qmp_blockdev_del(node_name, &error_abort);
+
+    aio_context_release(aio_context);
+}
+
 static BdrvChild *bdrv_find_child(BlockDriverState *parent_bs,
                                   const char *child_name)
 {
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
diff --git a/tests/qemu-iotests/222 b/tests/qemu-iotests/222
index 0ead56d574..bafb426f67 100644
--- a/tests/qemu-iotests/222
+++ b/tests/qemu-iotests/222
@@ -86,14 +86,19 @@ with iotests.FilePath('base.img') as base_img_path, \
             "driver": "file",
             "filename": fleece_img_path,
         },
-        "backing": src_node,
+        # backing is unset, otherwise we can't insert filter,
+        # instead, fleecing_hook will set backing link for
+        # tgt_node automatically.
     }))
 
-    # Establish COW from source to fleecing node
-    log(vm.qmp("blockdev-backup",
-               device=src_node,
-               target=tgt_node,
-               sync="none"))
+    # Establish COW from source to fleecing node, also,
+    # source becomes backing file of target.
+    log(vm.qmp("blockdev-add", **{
+        "driver": "fleecing-hook",
+        "node-name": "hook",
+        "file": tgt_node,
+        "backing": src_node,
+    }))
 
     log('')
     log('--- Setting up NBD Export ---')
@@ -137,10 +142,8 @@ with iotests.FilePath('base.img') as base_img_path, \
     log('--- Cleanup ---')
     log('')
 
-    log(vm.qmp('block-job-cancel', device=src_node))
-    log(vm.event_wait('BLOCK_JOB_CANCELLED'),
-        filters=[iotests.filter_qmp_event])
     log(vm.qmp('nbd-server-stop'))
+    log(vm.qmp('x-drop-fleecing', node_name="hook"))
     log(vm.qmp('blockdev-del', node_name=tgt_node))
     vm.shutdown()
 
diff --git a/tests/qemu-iotests/222.out b/tests/qemu-iotests/222.out
index 48f336a02b..be925601a8 100644
--- a/tests/qemu-iotests/222.out
+++ b/tests/qemu-iotests/222.out
@@ -50,7 +50,6 @@ read -P0 0x3fe0000 64k
 --- Cleanup ---
 
 {u'return': {}}
-{u'timestamp': {u'seconds': 'SECS', u'microseconds': 'USECS'}, u'data': {u'device': u'drive0', u'type': u'backup', u'speed': 0, u'len': 67108864, u'offset': 393216}, u'event': u'BLOCK_JOB_CANCELLED'}
 {u'return': {}}
 {u'return': {}}
 
-- 
2.11.1
