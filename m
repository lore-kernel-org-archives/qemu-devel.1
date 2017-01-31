Received: from eggs.gnu.org ([2001:4830:134:3::10]:43104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cYb0i-0006Qj-E5
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:10:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cYb0f-0006lL-M4
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:10:24 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Tue, 31 Jan 2017 18:09:54 +0200
Message-Id: <79f66648c685929a144396bda24d13a207131dcf.1485878688.git.berto@igalia.com>
In-Reply-To: <cover.1485878688.git.berto@igalia.com>
References: <cover.1485878688.git.berto@igalia.com>
In-Reply-To: <cover.1485878688.git.berto@igalia.com>
References: <cover.1485878688.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 1/2] qemu-io: don't allow I/O operations larger
 than INT_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>

Passing a request size larger than INT_MAX to any of the I/O commands
results in an error. While 'read' and 'write' handle the error
correctly, 'aio_read' and 'aio_write' hit an assertion:

blk_aio_read_entry: Assertion `rwco->qiov->size == acb->bytes' failed.

The reason is that the QEMU I/O code cannot handle request sizes
larger than INT_MAX, so this patch makes qemu-io check that all values
are within range.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 qemu-io-cmds.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 95bcde1d88..d806a83076 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -388,9 +388,14 @@ create_iovec(BlockBackend *blk, QEMUIOVector *qiov, char **argv, int nr_iov,
             goto fail;
         }
 
-        if (len > SIZE_MAX) {
-            printf("Argument '%s' exceeds maximum size %llu\n", arg,
-                   (unsigned long long)SIZE_MAX);
+        if (len > INT_MAX) {
+            printf("Argument '%s' exceeds maximum size %d\n", arg, INT_MAX);
+            goto fail;
+        }
+
+        if (count > INT_MAX - len) {
+            printf("The total number of bytes exceed the maximum size %d\n",
+                   INT_MAX);
             goto fail;
         }
 
@@ -682,9 +687,8 @@ static int read_f(BlockBackend *blk, int argc, char **argv)
     if (count < 0) {
         print_cvtnum_err(count, argv[optind]);
         return 0;
-    } else if (count > SIZE_MAX) {
-        printf("length cannot exceed %" PRIu64 ", given %s\n",
-               (uint64_t) SIZE_MAX, argv[optind]);
+    } else if (count > INT_MAX) {
+        printf("length cannot exceed %d, given %s\n", INT_MAX, argv[optind]);
         return 0;
     }
 
@@ -1004,9 +1008,8 @@ static int write_f(BlockBackend *blk, int argc, char **argv)
     if (count < 0) {
         print_cvtnum_err(count, argv[optind]);
         return 0;
-    } else if (count > SIZE_MAX) {
-        printf("length cannot exceed %" PRIu64 ", given %s\n",
-               (uint64_t) SIZE_MAX, argv[optind]);
+    } else if (count > INT_MAX) {
+        printf("length cannot exceed %d, given %s\n", INT_MAX, argv[optind]);
         return 0;
     }
 
-- 
2.11.0
