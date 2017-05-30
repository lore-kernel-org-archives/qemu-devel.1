Received: from eggs.gnu.org ([2001:4830:134:3::10]:59011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dFeWI-0005ps-GU
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:37:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dFeWH-0001R9-B8
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:36:58 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:39146 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dFeWG-0001Qf-W8
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:36:57 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 30 May 2017 13:36:40 +0300
Message-Id: <20170530103641.68891-4-vsementsov@virtuozzo.com>
In-Reply-To: <20170530103641.68891-1-vsementsov@virtuozzo.com>
References: <20170530103641.68891-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 3/4] qemu-img check: add format allocation info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/block-core.json |  6 +++++-
 qemu-img.c           | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 365070b3eb..3357b61811 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -203,6 +203,9 @@
 #                       field is present if the driver for the image format
 #                       supports it
 #
+# @format-alloc-info: Format-allocation information, see
+#                     BlockFormatAllocInfo description. (Since: 2.10)
+#
 # Since: 1.4
 #
 ##
@@ -211,7 +214,8 @@
            '*image-end-offset': 'int', '*corruptions': 'int', '*leaks': 'int',
            '*corruptions-fixed': 'int', '*leaks-fixed': 'int',
            '*total-clusters': 'int', '*allocated-clusters': 'int',
-           '*fragmented-clusters': 'int', '*compressed-clusters': 'int' } }
+           '*fragmented-clusters': 'int', '*compressed-clusters': 'int',
+           '*format-alloc-info': 'BlockFormatAllocInfo' } }
 
 ##
 # @MapEntry:
diff --git a/qemu-img.c b/qemu-img.c
index b506839ef0..55f8c1776c 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -560,6 +560,29 @@ static void dump_json_image_check(ImageCheck *check, bool quiet)
     QDECREF(str);
 }
 
+static void dump_human_format_alloc_info(BlockFormatAllocInfo *bfai, bool quiet)
+{
+    char *alloc_alloc = size_to_str(bfai->alloc_alloc);
+    char *alloc_hole = size_to_str(bfai->alloc_hole);
+    char *alloc_overhead = size_to_str(bfai->alloc_overhead);
+    char *hole_alloc = size_to_str(bfai->hole_alloc);
+    char *hole_hole = size_to_str(bfai->hole_hole);
+
+    qprintf(quiet,
+            "Format allocation info (including metadata):\n"
+            "               file-alloc   file-hole   after-eof\n"
+            "format-alloc   %10s  %10s  %10s\n"
+            "format-hole    %10s  %10s\n",
+            alloc_alloc, alloc_hole, alloc_overhead,
+            hole_alloc, hole_hole);
+
+    g_free(alloc_alloc);
+    g_free(alloc_hole);
+    g_free(alloc_overhead);
+    g_free(hole_alloc);
+    g_free(hole_hole);
+}
+
 static void dump_human_image_check(ImageCheck *check, bool quiet)
 {
     if (!(check->corruptions || check->leaks || check->check_errors)) {
@@ -601,6 +624,10 @@ static void dump_human_image_check(ImageCheck *check, bool quiet)
         qprintf(quiet,
                 "Image end offset: %" PRId64 "\n", check->image_end_offset);
     }
+
+    if (check->has_format_alloc_info) {
+        dump_human_format_alloc_info(check->format_alloc_info, quiet);
+    }
 }
 
 static int collect_image_check(BlockDriverState *bs,
@@ -611,6 +638,7 @@ static int collect_image_check(BlockDriverState *bs,
 {
     int ret;
     BdrvCheckResult result;
+    BlockFormatAllocInfo *bfai = g_new0(BlockFormatAllocInfo, 1);
 
     ret = bdrv_check(bs, &result, fix);
     if (ret < 0) {
@@ -639,6 +667,14 @@ static int collect_image_check(BlockDriverState *bs,
     check->compressed_clusters      = result.bfi.compressed_clusters;
     check->has_compressed_clusters  = result.bfi.compressed_clusters != 0;
 
+    ret = bdrv_get_format_alloc_stat(bs, bfai);
+    if (ret < 0) {
+        qapi_free_BlockFormatAllocInfo(bfai);
+    } else {
+        check->has_format_alloc_info = true;
+        check->format_alloc_info = bfai;
+    }
+
     return 0;
 }
 
-- 
2.11.1
