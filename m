Received: from eggs.gnu.org ([2001:4830:134:3::10]:37068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pAh-0002be-Sd
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:34:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pAf-0007mF-6C
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:34:27 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 11 May 2017 16:32:41 +0200
Message-Id: <1494513181-7900-39-git-send-email-kwolf@redhat.com>
In-Reply-To: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
References: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 38/58] qemu-io: Switch 'alloc' command to
 byte-based length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

For the 'alloc' command, accepting an offset in bytes but a length
in sectors, and reporting output in sectors, is confusing.  Do
everything in bytes, and adjust the expected output accordingly.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-id: 20170429191419.30051-3-eblake@redhat.com
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-io-cmds.c                    | 30 ++++++++++++++++++------------
 tests/qemu-iotests/019.out        |  8 ++++----
 tests/qemu-iotests/common.pattern |  2 +-
 3 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 6a0024b..1e0ebb4 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -1760,7 +1760,7 @@ out:
 static int alloc_f(BlockBackend *blk, int argc, char **argv)
 {
     BlockDriverState *bs = blk_bs(blk);
-    int64_t offset, sector_num, nb_sectors, remaining;
+    int64_t offset, sector_num, nb_sectors, remaining, count;
     char s1[64];
     int num, ret;
     int64_t sum_alloc;
@@ -1776,18 +1776,24 @@ static int alloc_f(BlockBackend *blk, int argc, char **argv)
     }
 
     if (argc == 3) {
-        nb_sectors = cvtnum(argv[2]);
-        if (nb_sectors < 0) {
-            print_cvtnum_err(nb_sectors, argv[2]);
+        count = cvtnum(argv[2]);
+        if (count < 0) {
+            print_cvtnum_err(count, argv[2]);
             return 0;
-        } else if (nb_sectors > INT_MAX) {
-            printf("length argument cannot exceed %d, given %s\n",
-                   INT_MAX, argv[2]);
+        } else if (count > INT_MAX * BDRV_SECTOR_SIZE) {
+            printf("length argument cannot exceed %llu, given %s\n",
+                   INT_MAX * BDRV_SECTOR_SIZE, argv[2]);
             return 0;
         }
     } else {
-        nb_sectors = 1;
+        count = BDRV_SECTOR_SIZE;
+    }
+    if (!QEMU_IS_ALIGNED(count, BDRV_SECTOR_SIZE)) {
+        printf("%" PRId64 " is not a sector-aligned value for 'count'\n",
+               count);
+        return 0;
     }
+    nb_sectors = count >> BDRV_SECTOR_BITS;
 
     remaining = nb_sectors;
     sum_alloc = 0;
@@ -1811,8 +1817,8 @@ static int alloc_f(BlockBackend *blk, int argc, char **argv)
 
     cvtstr(offset, s1, sizeof(s1));
 
-    printf("%"PRId64"/%"PRId64" sectors allocated at offset %s\n",
-           sum_alloc, nb_sectors, s1);
+    printf("%"PRId64"/%"PRId64" bytes allocated at offset %s\n",
+           sum_alloc << BDRV_SECTOR_BITS, nb_sectors << BDRV_SECTOR_BITS, s1);
     return 0;
 }
 
@@ -1822,8 +1828,8 @@ static const cmdinfo_t alloc_cmd = {
     .argmin     = 1,
     .argmax     = 2,
     .cfunc      = alloc_f,
-    .args       = "off [sectors]",
-    .oneline    = "checks if a sector is present in the file",
+    .args       = "offset [count]",
+    .oneline    = "checks if offset is allocated in the file",
 };
 
 
diff --git a/tests/qemu-iotests/019.out b/tests/qemu-iotests/019.out
index 0124264..17a7c03 100644
--- a/tests/qemu-iotests/019.out
+++ b/tests/qemu-iotests/019.out
@@ -542,8 +542,8 @@ Testing conversion with -B TEST_DIR/t.IMGFMT.base
 
 Checking if backing clusters are allocated when they shouldn't
 
-0/128 sectors allocated at offset 1 MiB
-0/128 sectors allocated at offset 4.001 GiB
+0/65536 bytes allocated at offset 1 MiB
+0/65536 bytes allocated at offset 4.001 GiB
 Reading
 
 === IO: pattern 42
@@ -1086,8 +1086,8 @@ Testing conversion with -o backing_file=TEST_DIR/t.IMGFMT.base
 
 Checking if backing clusters are allocated when they shouldn't
 
-0/128 sectors allocated at offset 1 MiB
-0/128 sectors allocated at offset 4.001 GiB
+0/65536 bytes allocated at offset 1 MiB
+0/65536 bytes allocated at offset 4.001 GiB
 Reading
 
 === IO: pattern 42
diff --git a/tests/qemu-iotests/common.pattern b/tests/qemu-iotests/common.pattern
index ddfbca1..34f4a8d 100644
--- a/tests/qemu-iotests/common.pattern
+++ b/tests/qemu-iotests/common.pattern
@@ -18,7 +18,7 @@
 
 function do_is_allocated() {
     local start=$1
-    local size=$(( $2 / 512))
+    local size=$2
     local step=$3
     local count=$4
 
-- 
1.8.3.1
