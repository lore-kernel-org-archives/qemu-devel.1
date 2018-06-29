Received: from eggs.gnu.org ([2001:4830:134:3::10]:40083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fYv7U-0001G4-QB
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:15:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fYv7R-0006Ac-Ep
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:15:32 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 29 Jun 2018 18:15:23 +0300
Message-Id: <20180629151524.138542-3-vsementsov@virtuozzo.com>
In-Reply-To: <20180629151524.138542-1-vsementsov@virtuozzo.com>
References: <20180629151524.138542-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 2/3] block/fleecing-filter: new filter
 driver for fleecing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, famz@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

We need to synchronize backup job with reading from fleecing image
like it was done in block/replication.c.

Otherwise, the following situation is theoretically possible:

1. client start reading
2. client understand, that there is no corresponding cluster in
   fleecing image
3. client is going to read from backing file (i.e. active image)
4. guest writes to active image
5. this write is stopped by backup(sync=none) and cluster is copied to
   fleecing image
6. guest write continues...
7. and client reads _new_ (or partly new) date from active image

So, this fleecing-filter should be above fleecing image, the whole
picture of fleecing looks like this:

    +-------+           +------------+
    |       |           |            |
    | guest |           | NBD client +<------+
    |       |           |            |       |
    ++-----++           +------------+       |only read
     |     ^                                 |
     | IO  |                                 |
     v     |                           +-----+------+
    ++-----+---------+                 |            |
    |                |                 |  internal  |
    |  active image  +----+            | NBD server |
    |                |    |            |            |
    +-+--------------+    |backup      +-+----------+
      ^                   |sync=none     ^
      |backing            |              |only read
      |                   |              |
    +-+--------------+    |       +------+----------+
    |                |    |       |                 |
    | fleecing image +<---+       | fleecing filter |
    |                |            |                 |
    +--------+-------+            +-----+-----------+
             ^                          |
             |                          |
             +--------------------------+
                       file

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/block-core.json    |  6 ++--
 block/fleecing-filter.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++
 block/Makefile.objs     |  1 +
 3 files changed, 85 insertions(+), 2 deletions(-)
 create mode 100644 block/fleecing-filter.c

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 577ce5e999..43872c3d79 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2542,7 +2542,8 @@
             'host_device', 'http', 'https', 'iscsi', 'luks', 'nbd', 'nfs',
             'null-aio', 'null-co', 'nvme', 'parallels', 'qcow', 'qcow2', 'qed',
             'quorum', 'raw', 'rbd', 'replication', 'sheepdog', 'ssh',
-            'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'vxhs' ] }
+            'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'vxhs',
+            'fleecing-filter' ] }
 
 ##
 # @BlockdevOptionsFile:
@@ -3594,7 +3595,8 @@
       'vmdk':       'BlockdevOptionsGenericCOWFormat',
       'vpc':        'BlockdevOptionsGenericFormat',
       'vvfat':      'BlockdevOptionsVVFAT',
-      'vxhs':       'BlockdevOptionsVxHS'
+      'vxhs':       'BlockdevOptionsVxHS',
+      'fleecing-filter': 'BlockdevOptionsGenericFormat'
   } }
 
 ##
diff --git a/block/fleecing-filter.c b/block/fleecing-filter.c
new file mode 100644
index 0000000000..b501887c10
--- /dev/null
+++ b/block/fleecing-filter.c
@@ -0,0 +1,80 @@
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "block/blockjob.h"
+#include "block/block_int.h"
+#include "block/block_backup.h"
+
+static int64_t fleecing_getlength(BlockDriverState *bs)
+{
+    return bdrv_getlength(bs->file->bs);
+}
+
+static coroutine_fn int fleecing_co_preadv(BlockDriverState *bs,
+                                           uint64_t offset, uint64_t bytes,
+                                           QEMUIOVector *qiov, int flags)
+{
+    int ret;
+    BlockJob *job = bs->file->bs->backing->bs->job;
+    CowRequest req;
+
+    backup_wait_for_overlapping_requests(job, offset, bytes);
+    backup_cow_request_begin(&req, job, offset, bytes);
+
+    ret = bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
+
+    backup_cow_request_end(&req);
+
+    return ret;
+}
+
+static coroutine_fn int fleecing_co_pwritev(BlockDriverState *bs,
+                                            uint64_t offset, uint64_t bytes,
+                                            QEMUIOVector *qiov, int flags)
+{
+    return -EINVAL;
+}
+
+static bool fleecing_recurse_is_first_non_filter(BlockDriverState *bs,
+                                                 BlockDriverState *candidate)
+{
+    return bdrv_recurse_is_first_non_filter(bs->file->bs, candidate);
+}
+
+static int fleecing_open(BlockDriverState *bs, QDict *options,
+                         int flags, Error **errp)
+{
+    bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file, false,
+                               errp);
+
+    return bs->file ? 0 : -EINVAL;
+}
+
+static void fleecing_close(BlockDriverState *bs)
+{
+    /* Do nothing, we have to add .bdrv_close, because bdrv_close() don't check
+     * it, just call. */
+}
+
+BlockDriver bdrv_fleecing_filter = {
+    .format_name = "fleecing-filter",
+    .protocol_name = "fleecing-filter",
+    .instance_size = 0,
+
+    .bdrv_open = fleecing_open,
+    .bdrv_close = fleecing_close,
+
+    .bdrv_getlength = fleecing_getlength,
+    .bdrv_co_preadv = fleecing_co_preadv,
+    .bdrv_co_pwritev = fleecing_co_pwritev,
+
+    .is_filter = true,
+    .bdrv_recurse_is_first_non_filter = fleecing_recurse_is_first_non_filter,
+    .bdrv_child_perm        = bdrv_filter_default_perms,
+};
+
+static void bdrv_fleecing_init(void)
+{
+    bdrv_register(&bdrv_fleecing_filter);
+}
+
+block_init(bdrv_fleecing_init);
diff --git a/block/Makefile.objs b/block/Makefile.objs
index 899bfb5e2c..aa0a6dd971 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -27,6 +27,7 @@ block-obj-y += write-threshold.o
 block-obj-y += backup.o
 block-obj-$(CONFIG_REPLICATION) += replication.o
 block-obj-y += throttle.o copy-on-read.o
+block-obj-y += fleecing-filter.o
 
 block-obj-y += crypto.o
 
-- 
2.11.1
