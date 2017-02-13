Received: from eggs.gnu.org ([2001:4830:134:3::10]:59646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKMG-0003e3-QT
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:24:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKMF-0006I9-F2
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:24:12 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 13 Feb 2017 18:22:49 +0100
Message-Id: <1487006583-24350-28-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 27/41] block: Add bdrv_new_open_driver()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This function allows to create more or less normal BlockDriverStates
even for BlockDrivers that aren't globally registered (e.g. helper
filters for block jobs).

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c               | 31 ++++++++++++++++++++++++++++++-
 include/block/block.h |  2 ++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 9c80cba..7d84d43 100644
--- a/block.c
+++ b/block.c
@@ -948,13 +948,16 @@ static int bdrv_open_driver(BlockDriverState *bs, BlockDriver *drv,
     }
 
     bs->drv = drv;
+    bs->read_only = !(bs->open_flags & BDRV_O_RDWR);
     bs->opaque = g_malloc0(drv->instance_size);
 
     if (drv->bdrv_file_open) {
         assert(!drv->bdrv_needs_filename || bs->filename[0]);
         ret = drv->bdrv_file_open(bs, options, open_flags, &local_err);
-    } else {
+    } else if (drv->bdrv_open) {
         ret = drv->bdrv_open(bs, options, open_flags, &local_err);
+    } else {
+        ret = 0;
     }
 
     if (ret < 0) {
@@ -995,6 +998,32 @@ free_and_fail:
     return ret;
 }
 
+int bdrv_new_open_driver(BlockDriver *drv, BlockDriverState **result,
+                         const char *node_name, int flags, Error **errp)
+{
+    BlockDriverState *bs;
+    int ret;
+
+    bs = bdrv_new();
+    bs->open_flags = flags;
+    bs->explicit_options = qdict_new();
+    bs->options = qdict_new();
+    bs->opaque = NULL;
+
+    update_options_from_flags(bs->options, flags);
+
+    ret = bdrv_open_driver(bs, drv, node_name, bs->options, flags, errp);
+    if (ret < 0) {
+        QDECREF(bs->explicit_options);
+        QDECREF(bs->options);
+        bdrv_unref(bs);
+        return ret;
+    }
+
+    *result = bs;
+    return 0;
+}
+
 QemuOptsList bdrv_runtime_opts = {
     .name = "bdrv_common",
     .head = QTAILQ_HEAD_INITIALIZER(bdrv_runtime_opts.head),
diff --git a/include/block/block.h b/include/block/block.h
index 93812df..3238850 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -215,6 +215,8 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
                            const char *bdref_key, Error **errp);
 BlockDriverState *bdrv_open(const char *filename, const char *reference,
                             QDict *options, int flags, Error **errp);
+int bdrv_new_open_driver(BlockDriver *drv, BlockDriverState **result,
+                         const char *node_name, int flags, Error **errp);
 BlockReopenQueue *bdrv_reopen_queue(BlockReopenQueue *bs_queue,
                                     BlockDriverState *bs,
                                     QDict *options, int flags);
-- 
1.8.3.1
