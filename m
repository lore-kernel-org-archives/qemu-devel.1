Received: from eggs.gnu.org ([2001:4830:134:3::10]:33847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dFei7-0004hm-Ih
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:49:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dFei6-0005Bh-Ll
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:49:11 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:6389 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dFei6-0005Am-Ar
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:49:10 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 30 May 2017 13:48:57 +0300
Message-Id: <20170530104857.70083-5-vsementsov@virtuozzo.com>
In-Reply-To: <20170530104857.70083-1-vsementsov@virtuozzo.com>
References: <20170530104857.70083-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 4/4] qemu-img check: improve
 dump_human_format_alloc_info
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

Improve dump_human_format_alloc_info() by specifying format names.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qemu-img.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 55f8c1776c..3c03690a4f 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -560,7 +560,8 @@ static void dump_json_image_check(ImageCheck *check, bool quiet)
     QDECREF(str);
 }
 
-static void dump_human_format_alloc_info(BlockFormatAllocInfo *bfai, bool quiet)
+static void dump_human_format_alloc_info(BlockDriverState *bs,
+                                         BlockFormatAllocInfo *bfai, bool quiet)
 {
     char *alloc_alloc = size_to_str(bfai->alloc_alloc);
     char *alloc_hole = size_to_str(bfai->alloc_hole);
@@ -568,13 +569,28 @@ static void dump_human_format_alloc_info(BlockFormatAllocInfo *bfai, bool quiet)
     char *hole_alloc = size_to_str(bfai->hole_alloc);
     char *hole_hole = size_to_str(bfai->hole_hole);
 
+    const char *format = bdrv_get_format_name(bs);
+    const char *f_format =
+        bs->file ? bdrv_get_format_name(bs->file->bs) : "file";
+    int format_len, cw;
+
+    if (format == NULL) {
+        format = "format";
+    }
+    if (f_format == NULL) {
+        f_format = "file";
+    }
+    format_len = strlen(format);
+    cw = MAX(10, strlen(f_format) + 6);
+
     qprintf(quiet,
             "Format allocation info (including metadata):\n"
-            "               file-alloc   file-hole   after-eof\n"
-            "format-alloc   %10s  %10s  %10s\n"
-            "format-hole    %10s  %10s\n",
-            alloc_alloc, alloc_hole, alloc_overhead,
-            hole_alloc, hole_hole);
+            "%*s         %*s-alloc  %*s-hole  %*s\n"
+            "%s-alloc   %*s  %*s  %*s\n"
+            "%s-hole    %*s  %*s\n",
+            format_len, "", cw - 6, f_format, cw - 5, f_format, cw, "after-eof",
+            format, cw, alloc_alloc, cw, alloc_hole, cw, alloc_overhead,
+            format, cw, hole_alloc, cw, hole_hole);
 
     g_free(alloc_alloc);
     g_free(alloc_hole);
@@ -583,7 +599,8 @@ static void dump_human_format_alloc_info(BlockFormatAllocInfo *bfai, bool quiet)
     g_free(hole_hole);
 }
 
-static void dump_human_image_check(ImageCheck *check, bool quiet)
+static void dump_human_image_check(BlockDriverState *bs, ImageCheck *check,
+                                   bool quiet)
 {
     if (!(check->corruptions || check->leaks || check->check_errors)) {
         qprintf(quiet, "No errors were found on the image.\n");
@@ -626,7 +643,7 @@ static void dump_human_image_check(ImageCheck *check, bool quiet)
     }
 
     if (check->has_format_alloc_info) {
-        dump_human_format_alloc_info(check->format_alloc_info, quiet);
+        dump_human_format_alloc_info(bs, check->format_alloc_info, quiet);
     }
 }
 
@@ -840,7 +857,7 @@ static int img_check(int argc, char **argv)
     if (!ret) {
         switch (output_format) {
         case OFORMAT_HUMAN:
-            dump_human_image_check(check, quiet);
+            dump_human_image_check(bs, check, quiet);
             break;
         case OFORMAT_JSON:
             dump_json_image_check(check, quiet);
-- 
2.11.1
