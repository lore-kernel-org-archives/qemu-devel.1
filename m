Received: from eggs.gnu.org ([2001:4830:134:3::10]:49625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d3NHd-0001ZV-HP
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:47:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d3NHZ-0002Lt-GU
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:47:05 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 26 Apr 2017 15:46:48 +0200
Message-Id: <20170426134649.9042-3-mreitz@redhat.com>
In-Reply-To: <20170426134649.9042-1-mreitz@redhat.com>
References: <20170426134649.9042-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/3] qemu-img/convert: Move bs_n > 1 && -B
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

It does not make much sense to use a backing image for the target when
you concatenate multiple images (because then there is no correspondence
between the source images' backing files and the target's); but it was
still possible to give one by using -o backing_file=X instead of -B X.

Fix this by moving the check.

(Also, change the error message because -B is not the only way to
 specify the backing file, evidently.)

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c                 | 13 +++++++------
 tests/qemu-iotests/122.out |  4 ++--
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index ae6f27f899..9eb82830f7 100644
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
