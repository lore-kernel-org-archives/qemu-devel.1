Received: from eggs.gnu.org ([2001:4830:134:3::10]:58551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1PgB-0005cG-8g
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 23:56:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1PgA-0003fR-BQ
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 23:56:19 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 21 Apr 2017 11:55:47 +0800
Message-Id: <20170421035606.448-2-famz@redhat.com>
In-Reply-To: <20170421035606.448-1-famz@redhat.com>
References: <20170421035606.448-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v14 01/20] block: Add,
 parse and store "force-shared-write" option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block.c                   | 9 +++++++++
 include/block/block.h     | 2 ++
 include/block/block_int.h | 1 +
 3 files changed, 12 insertions(+)

diff --git a/block.c b/block.c
index 1e668fb..f5c4e97 100644
--- a/block.c
+++ b/block.c
@@ -763,6 +763,7 @@ static void bdrv_inherited_options(int *child_flags, QDict *child_options,
      * the parent. */
     qdict_copy_default(child_options, parent_options, BDRV_OPT_CACHE_DIRECT);
     qdict_copy_default(child_options, parent_options, BDRV_OPT_CACHE_NO_FLUSH);
+    qdict_copy_default(child_options, parent_options, BDRV_OPT_FORCE_SHARED_WRITE);
 
     /* Inherit the read-only option from the parent if it's not set */
     qdict_copy_default(child_options, parent_options, BDRV_OPT_READ_ONLY);
@@ -871,6 +872,7 @@ static void bdrv_backing_options(int *child_flags, QDict *child_options,
      * which is only applied on the top level (BlockBackend) */
     qdict_copy_default(child_options, parent_options, BDRV_OPT_CACHE_DIRECT);
     qdict_copy_default(child_options, parent_options, BDRV_OPT_CACHE_NO_FLUSH);
+    qdict_copy_default(child_options, parent_options, BDRV_OPT_FORCE_SHARED_WRITE);
 
     /* backing files always opened read-only */
     qdict_set_default_str(child_options, BDRV_OPT_READ_ONLY, "on");
@@ -1115,6 +1117,11 @@ QemuOptsList bdrv_runtime_opts = {
             .type = QEMU_OPT_STRING,
             .help = "discard operation (ignore/off, unmap/on)",
         },
+        {
+            .name = BDRV_OPT_FORCE_SHARED_WRITE,
+            .type = QEMU_OPT_BOOL,
+            .help = "always accept other writers (default: off)",
+        },
         { /* end of list */ }
     },
 };
@@ -1154,6 +1161,8 @@ static int bdrv_open_common(BlockDriverState *bs, BlockBackend *file,
     drv = bdrv_find_format(driver_name);
     assert(drv != NULL);
 
+    bs->force_shared_write = qemu_opt_get_bool(opts, BDRV_OPT_FORCE_SHARED_WRITE, false);
+
     if (file != NULL) {
         filename = blk_bs(file)->filename;
     } else {
diff --git a/include/block/block.h b/include/block/block.h
index 5ddc0cf..d3afb75 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -109,6 +109,8 @@ typedef struct HDGeometry {
 #define BDRV_OPT_CACHE_NO_FLUSH "cache.no-flush"
 #define BDRV_OPT_READ_ONLY      "read-only"
 #define BDRV_OPT_DISCARD        "discard"
+#define BDRV_OPT_FORCE_SHARED_WRITE \
+                                "force-shared-write"
 
 
 #define BDRV_SECTOR_BITS   9
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 59400bd..fb81692 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -518,6 +518,7 @@ struct BlockDriverState {
     bool valid_key; /* if true, a valid encryption key has been set */
     bool sg;        /* if true, the device is a /dev/sg* */
     bool probed;    /* if true, format was probed rather than specified */
+    bool force_shared_write; /* if true, always allow shared write perm. */
 
     BlockDriver *drv; /* NULL means no media */
     void *opaque;
-- 
2.9.3
