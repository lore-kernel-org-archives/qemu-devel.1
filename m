Received: from eggs.gnu.org ([2001:4830:134:3::10]:60217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fcbN3-0007W1-Lw
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 14:58:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fcbN2-000312-CS
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 14:58:49 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  9 Jul 2018 20:58:28 +0200
Message-Id: <20180709185828.4248-8-mreitz@redhat.com>
In-Reply-To: <20180709185828.4248-1-mreitz@redhat.com>
References: <20180709185828.4248-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 7/7] qcow2: add overlap check for bitmap
 directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20180705151515.779173-1-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json   | 21 +++++++++++---------
 block/qcow2.h          | 45 ++++++++++++++++++++++--------------------
 block/qcow2-bitmap.c   |  7 ++++++-
 block/qcow2-refcount.c | 10 ++++++++++
 block/qcow2.c          | 22 +++++++++++++--------
 5 files changed, 66 insertions(+), 39 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 38b31250f9..13798b982d 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2696,18 +2696,21 @@
 # @template: Specifies a template mode which can be adjusted using the other
 #            flags, defaults to 'cached'
 #
+# @bitmap-directory: since 3.0
+#
 # Since: 2.9
 ##
 { 'struct': 'Qcow2OverlapCheckFlags',
-  'data': { '*template':       'Qcow2OverlapCheckMode',
-            '*main-header':    'bool',
-            '*active-l1':      'bool',
-            '*active-l2':      'bool',
-            '*refcount-table': 'bool',
-            '*refcount-block': 'bool',
-            '*snapshot-table': 'bool',
-            '*inactive-l1':    'bool',
-            '*inactive-l2':    'bool' } }
+  'data': { '*template':         'Qcow2OverlapCheckMode',
+            '*main-header':      'bool',
+            '*active-l1':        'bool',
+            '*active-l2':        'bool',
+            '*refcount-table':   'bool',
+            '*refcount-block':   'bool',
+            '*snapshot-table':   'bool',
+            '*inactive-l1':      'bool',
+            '*inactive-l2':      'bool',
+            '*bitmap-directory': 'bool' } }
 
 ##
 # @Qcow2OverlapChecks:
diff --git a/block/qcow2.h b/block/qcow2.h
index d6aca687d6..81b844e936 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -94,6 +94,7 @@
 #define QCOW2_OPT_OVERLAP_SNAPSHOT_TABLE "overlap-check.snapshot-table"
 #define QCOW2_OPT_OVERLAP_INACTIVE_L1 "overlap-check.inactive-l1"
 #define QCOW2_OPT_OVERLAP_INACTIVE_L2 "overlap-check.inactive-l2"
+#define QCOW2_OPT_OVERLAP_BITMAP_DIRECTORY "overlap-check.bitmap-directory"
 #define QCOW2_OPT_CACHE_SIZE "cache-size"
 #define QCOW2_OPT_L2_CACHE_SIZE "l2-cache-size"
 #define QCOW2_OPT_L2_CACHE_ENTRY_SIZE "l2-cache-entry-size"
@@ -400,34 +401,36 @@ typedef enum QCow2ClusterType {
 } QCow2ClusterType;
 
 typedef enum QCow2MetadataOverlap {
-    QCOW2_OL_MAIN_HEADER_BITNR    = 0,
-    QCOW2_OL_ACTIVE_L1_BITNR      = 1,
-    QCOW2_OL_ACTIVE_L2_BITNR      = 2,
-    QCOW2_OL_REFCOUNT_TABLE_BITNR = 3,
-    QCOW2_OL_REFCOUNT_BLOCK_BITNR = 4,
-    QCOW2_OL_SNAPSHOT_TABLE_BITNR = 5,
-    QCOW2_OL_INACTIVE_L1_BITNR    = 6,
-    QCOW2_OL_INACTIVE_L2_BITNR    = 7,
-
-    QCOW2_OL_MAX_BITNR            = 8,
-
-    QCOW2_OL_NONE           = 0,
-    QCOW2_OL_MAIN_HEADER    = (1 << QCOW2_OL_MAIN_HEADER_BITNR),
-    QCOW2_OL_ACTIVE_L1      = (1 << QCOW2_OL_ACTIVE_L1_BITNR),
-    QCOW2_OL_ACTIVE_L2      = (1 << QCOW2_OL_ACTIVE_L2_BITNR),
-    QCOW2_OL_REFCOUNT_TABLE = (1 << QCOW2_OL_REFCOUNT_TABLE_BITNR),
-    QCOW2_OL_REFCOUNT_BLOCK = (1 << QCOW2_OL_REFCOUNT_BLOCK_BITNR),
-    QCOW2_OL_SNAPSHOT_TABLE = (1 << QCOW2_OL_SNAPSHOT_TABLE_BITNR),
-    QCOW2_OL_INACTIVE_L1    = (1 << QCOW2_OL_INACTIVE_L1_BITNR),
+    QCOW2_OL_MAIN_HEADER_BITNR      = 0,
+    QCOW2_OL_ACTIVE_L1_BITNR        = 1,
+    QCOW2_OL_ACTIVE_L2_BITNR        = 2,
+    QCOW2_OL_REFCOUNT_TABLE_BITNR   = 3,
+    QCOW2_OL_REFCOUNT_BLOCK_BITNR   = 4,
+    QCOW2_OL_SNAPSHOT_TABLE_BITNR   = 5,
+    QCOW2_OL_INACTIVE_L1_BITNR      = 6,
+    QCOW2_OL_INACTIVE_L2_BITNR      = 7,
+    QCOW2_OL_BITMAP_DIRECTORY_BITNR = 8,
+
+    QCOW2_OL_MAX_BITNR              = 9,
+
+    QCOW2_OL_NONE             = 0,
+    QCOW2_OL_MAIN_HEADER      = (1 << QCOW2_OL_MAIN_HEADER_BITNR),
+    QCOW2_OL_ACTIVE_L1        = (1 << QCOW2_OL_ACTIVE_L1_BITNR),
+    QCOW2_OL_ACTIVE_L2        = (1 << QCOW2_OL_ACTIVE_L2_BITNR),
+    QCOW2_OL_REFCOUNT_TABLE   = (1 << QCOW2_OL_REFCOUNT_TABLE_BITNR),
+    QCOW2_OL_REFCOUNT_BLOCK   = (1 << QCOW2_OL_REFCOUNT_BLOCK_BITNR),
+    QCOW2_OL_SNAPSHOT_TABLE   = (1 << QCOW2_OL_SNAPSHOT_TABLE_BITNR),
+    QCOW2_OL_INACTIVE_L1      = (1 << QCOW2_OL_INACTIVE_L1_BITNR),
     /* NOTE: Checking overlaps with inactive L2 tables will result in bdrv
      * reads. */
-    QCOW2_OL_INACTIVE_L2    = (1 << QCOW2_OL_INACTIVE_L2_BITNR),
+    QCOW2_OL_INACTIVE_L2      = (1 << QCOW2_OL_INACTIVE_L2_BITNR),
+    QCOW2_OL_BITMAP_DIRECTORY = (1 << QCOW2_OL_BITMAP_DIRECTORY_BITNR),
 } QCow2MetadataOverlap;
 
 /* Perform all overlap checks which can be done in constant time */
 #define QCOW2_OL_CONSTANT \
     (QCOW2_OL_MAIN_HEADER | QCOW2_OL_ACTIVE_L1 | QCOW2_OL_REFCOUNT_TABLE | \
-     QCOW2_OL_SNAPSHOT_TABLE)
+     QCOW2_OL_SNAPSHOT_TABLE | QCOW2_OL_BITMAP_DIRECTORY)
 
 /* Perform all overlap checks which don't require disk access */
 #define QCOW2_OL_CACHED \
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 69485aa1de..ba978ad2aa 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -775,7 +775,12 @@ static int bitmap_list_store(BlockDriverState *bs, Qcow2BitmapList *bm_list,
         }
     }
 
-    ret = qcow2_pre_write_overlap_check(bs, 0, dir_offset, dir_size);
+    /* Actually, even in in-place case ignoring QCOW2_OL_BITMAP_DIRECTORY is not
+     * necessary, because we drop QCOW2_AUTOCLEAR_BITMAPS when updating bitmap
+     * directory in-place (actually, turn-off the extension), which is checked
+     * in qcow2_check_metadata_overlap() */
+    ret = qcow2_pre_write_overlap_check(
+            bs, in_place ? QCOW2_OL_BITMAP_DIRECTORY : 0, dir_offset, dir_size);
     if (ret < 0) {
         goto fail;
     }
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 18c729aa27..1b9ecb1ca0 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -2705,6 +2705,16 @@ int qcow2_check_metadata_overlap(BlockDriverState *bs, int ign, int64_t offset,
         }
     }
 
+    if ((chk & QCOW2_OL_BITMAP_DIRECTORY) &&
+        (s->autoclear_features & QCOW2_AUTOCLEAR_BITMAPS))
+    {
+        if (overlaps_with(s->bitmap_directory_offset,
+                          s->bitmap_directory_size))
+        {
+            return QCOW2_OL_BITMAP_DIRECTORY;
+        }
+    }
+
     return 0;
 }
 
diff --git a/block/qcow2.c b/block/qcow2.c
index f327116e52..5d668fc617 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -679,6 +679,11 @@ static QemuOptsList qcow2_runtime_opts = {
             .type = QEMU_OPT_BOOL,
             .help = "Check for unintended writes into an inactive L2 table",
         },
+        {
+            .name = QCOW2_OPT_OVERLAP_BITMAP_DIRECTORY,
+            .type = QEMU_OPT_BOOL,
+            .help = "Check for unintended writes into the bitmap directory",
+        },
         {
             .name = QCOW2_OPT_CACHE_SIZE,
             .type = QEMU_OPT_SIZE,
@@ -712,14 +717,15 @@ static QemuOptsList qcow2_runtime_opts = {
 };
 
 static const char *overlap_bool_option_names[QCOW2_OL_MAX_BITNR] = {
-    [QCOW2_OL_MAIN_HEADER_BITNR]    = QCOW2_OPT_OVERLAP_MAIN_HEADER,
-    [QCOW2_OL_ACTIVE_L1_BITNR]      = QCOW2_OPT_OVERLAP_ACTIVE_L1,
-    [QCOW2_OL_ACTIVE_L2_BITNR]      = QCOW2_OPT_OVERLAP_ACTIVE_L2,
-    [QCOW2_OL_REFCOUNT_TABLE_BITNR] = QCOW2_OPT_OVERLAP_REFCOUNT_TABLE,
-    [QCOW2_OL_REFCOUNT_BLOCK_BITNR] = QCOW2_OPT_OVERLAP_REFCOUNT_BLOCK,
-    [QCOW2_OL_SNAPSHOT_TABLE_BITNR] = QCOW2_OPT_OVERLAP_SNAPSHOT_TABLE,
-    [QCOW2_OL_INACTIVE_L1_BITNR]    = QCOW2_OPT_OVERLAP_INACTIVE_L1,
-    [QCOW2_OL_INACTIVE_L2_BITNR]    = QCOW2_OPT_OVERLAP_INACTIVE_L2,
+    [QCOW2_OL_MAIN_HEADER_BITNR]      = QCOW2_OPT_OVERLAP_MAIN_HEADER,
+    [QCOW2_OL_ACTIVE_L1_BITNR]        = QCOW2_OPT_OVERLAP_ACTIVE_L1,
+    [QCOW2_OL_ACTIVE_L2_BITNR]        = QCOW2_OPT_OVERLAP_ACTIVE_L2,
+    [QCOW2_OL_REFCOUNT_TABLE_BITNR]   = QCOW2_OPT_OVERLAP_REFCOUNT_TABLE,
+    [QCOW2_OL_REFCOUNT_BLOCK_BITNR]   = QCOW2_OPT_OVERLAP_REFCOUNT_BLOCK,
+    [QCOW2_OL_SNAPSHOT_TABLE_BITNR]   = QCOW2_OPT_OVERLAP_SNAPSHOT_TABLE,
+    [QCOW2_OL_INACTIVE_L1_BITNR]      = QCOW2_OPT_OVERLAP_INACTIVE_L1,
+    [QCOW2_OL_INACTIVE_L2_BITNR]      = QCOW2_OPT_OVERLAP_INACTIVE_L2,
+    [QCOW2_OL_BITMAP_DIRECTORY_BITNR] = QCOW2_OPT_OVERLAP_BITMAP_DIRECTORY,
 };
 
 static void cache_clean_timer_cb(void *opaque)
-- 
2.17.1
