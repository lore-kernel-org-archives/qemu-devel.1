Received: from eggs.gnu.org ([2001:4830:134:3::10]:59216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <briansteffens@gmail.com>) id 1dnsHc-0000z1-Du
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 16:11:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <briansteffens@gmail.com>) id 1dnsHb-0000eD-9g
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 16:11:16 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:34636)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <briansteffens@gmail.com>)
	id 1dnsHb-0000dT-41
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 16:11:15 -0400
Received: by mail-oi0-x242.google.com with SMTP id w10so1007195oie.1
	for <qemu-devel@nongnu.org>; Fri, 01 Sep 2017 13:11:13 -0700 (PDT)
From: Brian Steffens <briansteffens@gmail.com>
Date: Fri,  1 Sep 2017 20:10:54 +0000
Message-Id: <20170901201054.11738-1-briansteffens@gmail.com>
Subject: [Qemu-devel] [PATCH 1/1] block: add block device shared field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Brian Steffens <briansteffens@gmail.com>

This adds a boolean option called 'shared' to block devices. It defaults
to off/false. When enabled for a particular block device, the 'shared' option
causes the block migration code to skip over syncing of that device. This
allows controlling exactly which block devices get synced during a migration.

Signed-off-by: Brian Steffens <briansteffens@gmail.com>
---
 block.c                   | 7 +++++++
 block/qapi.c              | 2 ++
 include/block/block.h     | 1 +
 include/block/block_int.h | 3 +++
 migration/block.c         | 4 ++++
 qapi/block-core.json      | 2 +-
 6 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 3308814bba..6dafcce046 100644
--- a/block.c
+++ b/block.c
@@ -2466,6 +2466,13 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
         bdrv_backing_options(&flags, options, flags, options);
     }
 
+    /* Check for shared flag */
+    /* See cautionary note on accessing @options above */
+    bs->shared =
+        g_strcmp0(qdict_get_try_str(options, BDRV_OPT_SHARED), "on") == 0 ||
+        qdict_get_try_bool(options, BDRV_OPT_SHARED, false);
+    qdict_del(options, BDRV_OPT_SHARED);
+
     bs->open_flags = flags;
     bs->options = options;
     options = qdict_clone_shallow(options);
diff --git a/block/qapi.c b/block/qapi.c
index 5f1a71f5d2..42e2a33008 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -66,6 +66,8 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
 
     info->detect_zeroes = bs->detect_zeroes;
 
+    info->shared = bs->shared;
+
     if (blk && blk_get_public(blk)->throttle_state) {
         ThrottleConfig cfg;
 
diff --git a/include/block/block.h b/include/block/block.h
index ab80195378..8f6ab743d2 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -110,6 +110,7 @@ typedef struct HDGeometry {
 #define BDRV_OPT_READ_ONLY      "read-only"
 #define BDRV_OPT_DISCARD        "discard"
 #define BDRV_OPT_FORCE_SHARE    "force-share"
+#define BDRV_OPT_SHARED         "shared"
 
 
 #define BDRV_SECTOR_BITS   9
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 7571c0aaaf..6508c90ca9 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -672,6 +672,9 @@ struct BlockDriverState {
 
     /* Only read/written by whoever has set active_flush_req to true.  */
     unsigned int flushed_gen;             /* Flushed write generation */
+
+    /* Shared devices are not migrated. */
+    bool shared;
 };
 
 struct BlockBackendRootState {
diff --git a/migration/block.c b/migration/block.c
index 9171f60028..b347c3dc61 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -402,6 +402,10 @@ static int init_blk_migration(QEMUFile *f)
     bmds_bs = g_malloc0(num_bs * sizeof(*bmds_bs));
 
     for (i = 0, bs = bdrv_first(&it); bs; bs = bdrv_next(&it), i++) {
+        if (bs->shared) {
+            continue;
+        }
+
         if (bdrv_is_read_only(bs)) {
             continue;
         }
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 833c602150..a52e10f9cd 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -365,7 +365,7 @@
             '*bps_wr_max_length': 'int', '*iops_max_length': 'int',
             '*iops_rd_max_length': 'int', '*iops_wr_max_length': 'int',
             '*iops_size': 'int', '*group': 'str', 'cache': 'BlockdevCacheInfo',
-            'write_threshold': 'int' } }
+            'write_threshold': 'int', 'shared': 'bool' } }
 
 ##
 # @BlockDeviceIoStatus:
-- 
2.13.1
