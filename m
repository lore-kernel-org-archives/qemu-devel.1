Received: from eggs.gnu.org ([2001:4830:134:3::10]:40857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eKnkq-0005Ia-AN
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:02:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eKnk7-00018i-2y
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:01:31 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 30 Nov 2017 19:47:49 +0300
Message-Id: <20171130164750.47320-2-vsementsov@virtuozzo.com>
In-Reply-To: <20171130164750.47320-1-vsementsov@virtuozzo.com>
References: <20171130164750.47320-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 1/2] qcow2: add overlap check for bitmap
 directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.h          |  7 +++++--
 block/qcow2-refcount.c | 12 ++++++++++++
 block/qcow2.c          |  6 ++++++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 6f0ff15dd0..8f226a3609 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -98,6 +98,7 @@
 #define QCOW2_OPT_OVERLAP_SNAPSHOT_TABLE "overlap-check.snapshot-table"
 #define QCOW2_OPT_OVERLAP_INACTIVE_L1 "overlap-check.inactive-l1"
 #define QCOW2_OPT_OVERLAP_INACTIVE_L2 "overlap-check.inactive-l2"
+#define QCOW2_OPT_OVERLAP_BITMAP_DIRECTORY "overlap-check.bitmap-directory"
 #define QCOW2_OPT_CACHE_SIZE "cache-size"
 #define QCOW2_OPT_L2_CACHE_SIZE "l2-cache-size"
 #define QCOW2_OPT_REFCOUNT_CACHE_SIZE "refcount-cache-size"
@@ -406,8 +407,9 @@ typedef enum QCow2MetadataOverlap {
     QCOW2_OL_SNAPSHOT_TABLE_BITNR = 5,
     QCOW2_OL_INACTIVE_L1_BITNR    = 6,
     QCOW2_OL_INACTIVE_L2_BITNR    = 7,
+    QCOW2_OL_BITMAP_DIRECTORY_BITNR = 8,
 
-    QCOW2_OL_MAX_BITNR            = 8,
+    QCOW2_OL_MAX_BITNR              = 9,
 
     QCOW2_OL_NONE           = 0,
     QCOW2_OL_MAIN_HEADER    = (1 << QCOW2_OL_MAIN_HEADER_BITNR),
@@ -420,12 +422,13 @@ typedef enum QCow2MetadataOverlap {
     /* NOTE: Checking overlaps with inactive L2 tables will result in bdrv
      * reads. */
     QCOW2_OL_INACTIVE_L2    = (1 << QCOW2_OL_INACTIVE_L2_BITNR),
+    QCOW2_OL_BITMAP_DIRECTORY = (1 << QCOW2_OL_BITMAP_DIRECTORY_BITNR),
 } QCow2MetadataOverlap;
 
 /* Perform all overlap checks which can be done in constant time */
 #define QCOW2_OL_CONSTANT \
     (QCOW2_OL_MAIN_HEADER | QCOW2_OL_ACTIVE_L1 | QCOW2_OL_REFCOUNT_TABLE | \
-     QCOW2_OL_SNAPSHOT_TABLE)
+     QCOW2_OL_SNAPSHOT_TABLE | QCOW2_OL_BITMAP_DIRECTORY)
 
 /* Perform all overlap checks which don't require disk access */
 #define QCOW2_OL_CACHED \
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 3de1ab51ba..a7a2703f26 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -2585,6 +2585,18 @@ int qcow2_check_metadata_overlap(BlockDriverState *bs, int ign, int64_t offset,
         }
     }
 
+    if ((chk & QCOW2_OL_BITMAP_DIRECTORY) &&
+        (s->autoclear_features & QCOW2_AUTOCLEAR_BITMAPS))
+    {
+        /* update_ext_header_and_dir_in_place firstly drop autoclear flag,
+         * so it will not fail */
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
index 1914a940e5..8278c0e124 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -655,6 +655,11 @@ static QemuOptsList qcow2_runtime_opts = {
             .help = "Check for unintended writes into an inactive L2 table",
         },
         {
+            .name = QCOW2_OPT_OVERLAP_BITMAP_DIRECTORY,
+            .type = QEMU_OPT_BOOL,
+            .help = "Check for unintended writes into the bitmap directory",
+        },
+        {
             .name = QCOW2_OPT_CACHE_SIZE,
             .type = QEMU_OPT_SIZE,
             .help = "Maximum combined metadata (L2 tables and refcount blocks) "
@@ -690,6 +695,7 @@ static const char *overlap_bool_option_names[QCOW2_OL_MAX_BITNR] = {
     [QCOW2_OL_SNAPSHOT_TABLE_BITNR] = QCOW2_OPT_OVERLAP_SNAPSHOT_TABLE,
     [QCOW2_OL_INACTIVE_L1_BITNR]    = QCOW2_OPT_OVERLAP_INACTIVE_L1,
     [QCOW2_OL_INACTIVE_L2_BITNR]    = QCOW2_OPT_OVERLAP_INACTIVE_L2,
+    [QCOW2_OL_BITMAP_DIRECTORY_BITNR] = QCOW2_OPT_OVERLAP_BITMAP_DIRECTORY,
 };
 
 static void cache_clean_timer_cb(void *opaque)
-- 
2.11.1
