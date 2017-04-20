Received: from eggs.gnu.org ([2001:4830:134:3::10]:50598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1d18Fw-0004eC-9i
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 05:20:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1d18Fs-0001fJ-8n
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 05:20:04 -0400
From: jemmy858585@gmail.com
Date: Thu, 20 Apr 2017 17:19:52 +0800
Message-Id: <1492679992-7805-1-git-send-email-lidongchen@tencent.com>
Subject: [Qemu-devel] [PATCH v2] qemu-img: check bs_n when use old style
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, Lidong Chen <lidongchen@tencent.com>

From: Lidong Chen <lidongchen@tencent.com>

When use old style option like -o backing_file, img_convert
continue run when bs_n > 1, this patch fix this bug.

Signed-off-by: Lidong Chen <lidongchen@tencent.com>
---
v2 changelog:
    avoid duplicating code.
---
 qemu-img.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index b220cf7..b4d9255 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2108,14 +2108,6 @@ static int img_convert(int argc, char **argv)
         error_exit("Must specify image file name");
     }
 
-
-    if (bs_n > 1 && out_baseimg) {
-        error_report("-B makes no sense when concatenating multiple input "
-                     "images");
-        ret = -1;
-        goto out;
-    }
-
     src_flags = 0;
     ret = bdrv_parse_cache_mode(src_cache, &src_flags, &src_writethrough);
     if (ret < 0) {
@@ -2225,6 +2217,13 @@ static int img_convert(int argc, char **argv)
         out_baseimg = out_baseimg_param;
     }
 
+    if (bs_n > 1 && out_baseimg) {
+        error_report("Specifying backing image makes no sense when "
+                     "concatenating multiple input images");
+        ret = -1;
+        goto out;
+    }
+
     /* Check if compression is supported */
     if (compress) {
         bool encryption =
-- 
1.8.3.1
