Received: from eggs.gnu.org ([2001:4830:134:3::10]:55867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4CbF-000217-2m
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:34:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4CbE-0001Pp-AH
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:34:45 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 28 Apr 2017 22:33:29 +0200
Message-Id: <1493411622-5343-22-git-send-email-kwolf@redhat.com>
In-Reply-To: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
References: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 21/34] qemu-img/convert: Move bs_n > 1 && -B
 check down
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Max Reitz <mreitz@redhat.com>

It does not make much sense to use a backing image for the target when
you concatenate multiple images (because then there is no correspondence
between the source images' backing files and the target's); but it was
still possible to give one by using -o backing_file=X instead of -B X.

Fix this by moving the check.

(Also, change the error message because -B is not the only way to
 specify the backing file, evidently.)

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c                 | 13 +++++++------
 tests/qemu-iotests/122.out |  4 ++--
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index e0503ae..7044884 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2089,12 +2089,6 @@ static int img_convert(int argc, char **argv)
     }
 
 
-    if (s.src_num > 1 && out_baseimg) {
-        error_report("-B makes no sense when concatenating multiple input "
-                     "images");
-        goto fail_getopt;
-    }
-
     /* ret is still -EINVAL until here */
     ret = bdrv_parse_cache_mode(src_cache, &src_flags, &src_writethrough);
     if (ret < 0) {
@@ -2208,6 +2202,13 @@ static int img_convert(int argc, char **argv)
     }
     s.target_has_backing = (bool) out_baseimg;
 
+    if (s.src_num > 1 && out_baseimg) {
+        error_report("Having a backing file for the target makes no sense when "
+                     "concatenating multiple input images");
+        ret = -1;
+        goto out;
+    }
+
     /* Check if compression is supported */
     if (s.compressed) {
         bool encryption =
diff --git a/tests/qemu-iotests/122.out b/tests/qemu-iotests/122.out
index 98814de..9317d80 100644
--- a/tests/qemu-iotests/122.out
+++ b/tests/qemu-iotests/122.out
@@ -61,8 +61,8 @@ read 65536/65536 bytes at offset 4194304
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 65536/65536 bytes at offset 8388608
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-img: -B makes no sense when concatenating multiple input images
-qemu-img: -B makes no sense when concatenating multiple input images
+qemu-img: Having a backing file for the target makes no sense when concatenating multiple input images
+qemu-img: Having a backing file for the target makes no sense when concatenating multiple input images
 
 === Compression with misaligned allocations and image sizes ===
 
-- 
1.8.3.1
