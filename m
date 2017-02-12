Received: from eggs.gnu.org ([2001:4830:134:3::10]:47504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ccj8d-0007gh-Qa
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 20:39:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ccj8c-0007Uo-FC
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 20:39:39 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Sun, 12 Feb 2017 02:39:27 +0100
Message-Id: <20170212013929.6793-2-mreitz@redhat.com>
In-Reply-To: <20170212013440.5919-1-mreitz@redhat.com>
References: <20170212013440.5919-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 19/21] qemu-io: don't allow I/O operations
 larger than BDRV_REQUEST_MAX_BYTES
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Alberto Garcia <berto@igalia.com>

Passing a request size larger than BDRV_REQUEST_MAX_BYTES to any of the
I/O commands results in an error. While 'read' and 'write' handle the
error correctly, 'aio_read' and 'aio_write' hit an assertion:

blk_aio_read_entry: Assertion `rwco->qiov->size == acb->bytes' failed.

The reason is that the QEMU I/O code cannot handle request sizes
larger than BDRV_REQUEST_MAX_BYTES, so this patch makes qemu-io check
that all values are within range.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Message-id: 79f66648c685929a144396bda24d13a207131dcf.1485878688.git.berto@igalia.com
[mreitz: Use BDRV_REQUEST_MAX_BYTES instead of INT_MAX]
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-io-cmds.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 95bcde1d88..e415b03cd0 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -388,9 +388,15 @@ create_iovec(BlockBackend *blk, QEMUIOVector *qiov, char **argv, int nr_iov,
             goto fail;
         }
 
-        if (len > SIZE_MAX) {
-            printf("Argument '%s' exceeds maximum size %llu\n", arg,
-                   (unsigned long long)SIZE_MAX);
+        if (len > BDRV_REQUEST_MAX_BYTES) {
+            printf("Argument '%s' exceeds maximum size %" PRIu64 "\n", arg,
+                   (uint64_t)BDRV_REQUEST_MAX_BYTES);
+            goto fail;
+        }
+
+        if (count > BDRV_REQUEST_MAX_BYTES - len) {
+            printf("The total number of bytes exceed the maximum size %" PRIu64
+                   "\n", (uint64_t)BDRV_REQUEST_MAX_BYTES);
             goto fail;
         }
 
@@ -682,9 +688,9 @@ static int read_f(BlockBackend *blk, int argc, char **argv)
     if (count < 0) {
         print_cvtnum_err(count, argv[optind]);
         return 0;
-    } else if (count > SIZE_MAX) {
+    } else if (count > BDRV_REQUEST_MAX_BYTES) {
         printf("length cannot exceed %" PRIu64 ", given %s\n",
-               (uint64_t) SIZE_MAX, argv[optind]);
+               (uint64_t)BDRV_REQUEST_MAX_BYTES, argv[optind]);
         return 0;
     }
 
@@ -1004,9 +1010,9 @@ static int write_f(BlockBackend *blk, int argc, char **argv)
     if (count < 0) {
         print_cvtnum_err(count, argv[optind]);
         return 0;
-    } else if (count > SIZE_MAX) {
+    } else if (count > BDRV_REQUEST_MAX_BYTES) {
         printf("length cannot exceed %" PRIu64 ", given %s\n",
-               (uint64_t) SIZE_MAX, argv[optind]);
+               (uint64_t)BDRV_REQUEST_MAX_BYTES, argv[optind]);
         return 0;
     }
 
-- 
2.11.0
