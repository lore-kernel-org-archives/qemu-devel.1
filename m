Received: from eggs.gnu.org ([2001:4830:134:3::10]:43189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d3Diq-0002LZ-CD
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 23:34:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d3Dip-0001ZJ-7z
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 23:34:32 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 26 Apr 2017 11:33:55 +0800
Message-Id: <20170426033413.17192-4-famz@redhat.com>
In-Reply-To: <20170426033413.17192-1-famz@redhat.com>
References: <20170426033413.17192-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v15 03/21] block: Add,
 parse and store "force-share" option
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
 block.c                   | 17 +++++++++++++++++
 include/block/block.h     |  1 +
 include/block/block_int.h |  1 +
 qapi/block-core.json      |  3 +++
 4 files changed, 22 insertions(+)

diff --git a/block.c b/block.c
index fce77bf..9db39b6 100644
--- a/block.c
+++ b/block.c
@@ -763,6 +763,7 @@ static void bdrv_inherited_options(int *child_flags, QDict *child_options,
      * the parent. */
     qdict_copy_default(child_options, parent_options, BDRV_OPT_CACHE_DIRECT);
     qdict_copy_default(child_options, parent_options, BDRV_OPT_CACHE_NO_FLUSH);
+    qdict_copy_default(child_options, parent_options, BDRV_OPT_FORCE_SHARE);
 
     /* Inherit the read-only option from the parent if it's not set */
     qdict_copy_default(child_options, parent_options, BDRV_OPT_READ_ONLY);
@@ -871,6 +872,7 @@ static void bdrv_backing_options(int *child_flags, QDict *child_options,
      * which is only applied on the top level (BlockBackend) */
     qdict_copy_default(child_options, parent_options, BDRV_OPT_CACHE_DIRECT);
     qdict_copy_default(child_options, parent_options, BDRV_OPT_CACHE_NO_FLUSH);
+    qdict_copy_default(child_options, parent_options, BDRV_OPT_FORCE_SHARE);
 
     /* backing files always opened read-only */
     qdict_set_default_str(child_options, BDRV_OPT_READ_ONLY, "on");
@@ -1115,6 +1117,11 @@ QemuOptsList bdrv_runtime_opts = {
             .type = QEMU_OPT_STRING,
             .help = "discard operation (ignore/off, unmap/on)",
         },
+        {
+            .name = BDRV_OPT_FORCE_SHARE,
+            .type = QEMU_OPT_BOOL,
+            .help = "always accept other writers (default: off)",
+        },
         { /* end of list */ }
     },
 };
@@ -1154,6 +1161,16 @@ static int bdrv_open_common(BlockDriverState *bs, BlockBackend *file,
     drv = bdrv_find_format(driver_name);
     assert(drv != NULL);
 
+    bs->force_share = qemu_opt_get_bool(opts, BDRV_OPT_FORCE_SHARE, false);
+
+    if (bs->force_share && (bs->open_flags & BDRV_O_RDWR)) {
+        error_setg(errp,
+                   BDRV_OPT_FORCE_SHARE
+                   "=on can only be used with read-only images");
+        ret = -EINVAL;
+        goto fail_opts;
+    }
+
     if (file != NULL) {
         filename = blk_bs(file)->filename;
     } else {
diff --git a/include/block/block.h b/include/block/block.h
index a798f10..feae379 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -109,6 +109,7 @@ typedef struct HDGeometry {
 #define BDRV_OPT_CACHE_NO_FLUSH "cache.no-flush"
 #define BDRV_OPT_READ_ONLY      "read-only"
 #define BDRV_OPT_DISCARD        "discard"
+#define BDRV_OPT_FORCE_SHARE    "force-share"
 
 
 #define BDRV_SECTOR_BITS   9
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 59400bd..94ba697 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -518,6 +518,7 @@ struct BlockDriverState {
     bool valid_key; /* if true, a valid encryption key has been set */
     bool sg;        /* if true, the device is a /dev/sg* */
     bool probed;    /* if true, format was probed rather than specified */
+    bool force_share; /* if true, always allow all shared permissions */
 
     BlockDriver *drv; /* NULL means no media */
     void *opaque;
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 033457c..5bc56969 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2880,6 +2880,8 @@
 #                 (default: false)
 # @detect-zeroes: detect and optimize zero writes (Since 2.1)
 #                 (default: off)
+# @force-share:   force share all permission on added nodes.
+#                 Requires read-only=true. (Since 2.10)
 #
 # Remaining options are determined by the block driver.
 #
@@ -2891,6 +2893,7 @@
             '*discard': 'BlockdevDiscardOptions',
             '*cache': 'BlockdevCacheOptions',
             '*read-only': 'bool',
+            '*force-share': 'bool',
             '*detect-zeroes': 'BlockdevDetectZeroesOptions' },
   'discriminator': 'driver',
   'data': {
-- 
2.9.3
