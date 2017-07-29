Received: from eggs.gnu.org ([2001:4830:134:3::10]:37696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dbUo7-00060O-10
	for qemu-devel@nongnu.org; Sat, 29 Jul 2017 12:41:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dbUo3-00018D-Tp
	for qemu-devel@nongnu.org; Sat, 29 Jul 2017 12:41:39 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:35283 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dbUo3-00017B-Id
	for qemu-devel@nongnu.org; Sat, 29 Jul 2017 12:41:35 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Sat, 29 Jul 2017 19:41:04 +0300
Message-Id: <20170729164104.29537-4-vsementsov@virtuozzo.com>
In-Reply-To: <20170729164104.29537-1-vsementsov@virtuozzo.com>
References: <20170729164104.29537-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 3/3] qemu-img check: add format allocation
 info
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
 qemu-img.c           | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 93f6995381..d662786261 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -249,6 +249,9 @@
 #                       field is present if the driver for the image format
 #                       supports it
 #
+# @format-alloc-info: Format-allocation information, see
+#                     BlockFormatAllocInfo description. (Since: 2.11)
+#
 # Since: 1.4
 #
 ##
@@ -257,7 +260,8 @@
            '*image-end-offset': 'int', '*corruptions': 'int', '*leaks': 'int',
            '*corruptions-fixed': 'int', '*leaks-fixed': 'int',
            '*total-clusters': 'int', '*allocated-clusters': 'int',
-           '*fragmented-clusters': 'int', '*compressed-clusters': 'int' } }
+           '*fragmented-clusters': 'int', '*compressed-clusters': 'int',
+           '*format-alloc-info': 'BlockFormatAllocInfo' } }
 
 ##
 # @MapEntry:
diff --git a/qemu-img.c b/qemu-img.c
index b506839ef0..b3adf9a1a2 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -560,6 +560,35 @@ static void dump_json_image_check(ImageCheck *check, bool quiet)
     QDECREF(str);
 }
 
+static void dump_human_format_alloc_info(BlockFormatAllocInfo *bfai, bool quiet)
+{
+    char *used_data = size_to_str(bfai->used_data);
+    char *used_zero = size_to_str(bfai->used_zero);
+    char *used_discarded = size_to_str(bfai->used_discarded);
+    char *used_overrun = size_to_str(bfai->used_overrun);
+
+    char *unused_data = size_to_str(bfai->unused_data);
+    char *unused_zero = size_to_str(bfai->unused_zero);
+    char *unused_discarded = size_to_str(bfai->unused_discarded);
+
+    qprintf(quiet,
+            "Format allocation info (including metadata):\n"
+            "               data        zero   discarded   after-eof\n"
+            "used     %10s  %10s  %10s  %10s\n"
+            "unused   %10s  %10s  %10s\n",
+            used_data, used_zero, used_discarded, used_overrun,
+            unused_data, unused_zero, unused_discarded);
+
+    g_free(used_data);
+    g_free(used_zero);
+    g_free(used_discarded);
+    g_free(used_overrun);
+
+    g_free(unused_data);
+    g_free(unused_zero);
+    g_free(unused_discarded);
+}
+
 static void dump_human_image_check(ImageCheck *check, bool quiet)
 {
     if (!(check->corruptions || check->leaks || check->check_errors)) {
@@ -601,6 +630,10 @@ static void dump_human_image_check(ImageCheck *check, bool quiet)
         qprintf(quiet,
                 "Image end offset: %" PRId64 "\n", check->image_end_offset);
     }
+
+    if (check->has_format_alloc_info) {
+        dump_human_format_alloc_info(check->format_alloc_info, quiet);
+    }
 }
 
 static int collect_image_check(BlockDriverState *bs,
@@ -611,6 +644,7 @@ static int collect_image_check(BlockDriverState *bs,
 {
     int ret;
     BdrvCheckResult result;
+    BlockFormatAllocInfo *bfai = g_new0(BlockFormatAllocInfo, 1);
 
     ret = bdrv_check(bs, &result, fix);
     if (ret < 0) {
@@ -639,6 +673,14 @@ static int collect_image_check(BlockDriverState *bs,
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
