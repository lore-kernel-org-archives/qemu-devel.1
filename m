Received: from eggs.gnu.org ([2001:4830:134:3::10]:37669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cylRb-0003TL-CC
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 16:34:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cylRW-0002OX-7g
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 16:34:19 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Thu, 13 Apr 2017 22:34:01 +0200
Message-Id: <20170413203401.3213-4-mreitz@redhat.com>
In-Reply-To: <20170413203401.3213-1-mreitz@redhat.com>
References: <20170413203401.3213-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 3/3] qemu-img/convert: Move bs_n > 1
 && -B check down
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-stable <qemu-stable@nongnu.org>

It does not make much sense to use a backing image for the target when
you concatenate multiple images (because then there is no correspondence
between the source images' backing files and the target's); but it was
still possible to give one by using -o backing_file=X instead of -B X.

Fix this by moving the check.

(Also, change the error message because -B is not the only way to
 specify the backing file, evidently.)

Cc: qemu-stable <qemu-stable@nongnu.org>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c                 | 14 +++++++-------
 tests/qemu-iotests/122.out |  4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 70ffb07447..cfd1986efd 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2113,13 +2113,6 @@ static int img_convert(int argc, char **argv)
     }
 
 
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
@@ -2229,6 +2222,13 @@ static int img_convert(int argc, char **argv)
         out_baseimg = out_baseimg_param;
     }
 
+    if (bs_n > 1 && out_baseimg) {
+        error_report("Having a backing file for the target makes no sense when "
+                     "concatenating multiple input images");
+        ret = -1;
+        goto out;
+    }
+
     /* Check if compression is supported */
     if (compress) {
         bool encryption =
diff --git a/tests/qemu-iotests/122.out b/tests/qemu-iotests/122.out
index 98814de5d6..9317d801ad 100644
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
2.12.2
