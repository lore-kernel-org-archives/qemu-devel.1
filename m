Received: from eggs.gnu.org ([2001:4830:134:3::10]:38075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jaywang0.tw@gmail.com>) id 1fye1X-00054u-Q5
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 10:15:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jaywang0.tw@gmail.com>) id 1fye1T-0005D3-L2
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 10:15:43 -0400
From: Yan-Jie Wang <jaywang0.tw@gmail.com>
Date: Sat,  8 Sep 2018 22:15:28 +0800
Message-Id: <20180908141528.71260-1-jaywang0.tw@gmail.com>
Subject: [Qemu-devel] [PATCH] block/file-posix: fix the wrong result of
 find_allocation() in macOS.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yan-Jie Wang <jaywang0.tw@gmail.com>, qemu-stable@nongnu.org

In macOS, lseek with SEEK_DATA behaves differently.
It seeks to the next data region even though offset is in the middle of
a data region. In addition, there may be many data regions without any
hole among them, like this: |---Data---|---Data---|

Because of this, qemu-img convert with raw images as input may create
corrupted images in macOS especially for large files, and qemu-img
map may also report wrong things. This patch fixes this undesired
behaviors.

Signed-off-by: Yan-Jie Wang <jaywang0.tw@gmail.com>
---
 block/file-posix.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index fe83cbf0eb..5c208580e6 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2325,6 +2325,7 @@ static int find_allocation(BlockDriverState *bs, off_t start,
     BDRVRawState *s = bs->opaque;
     off_t offs;
 
+#if !(defined(__APPLE__) && defined(__MACH__))
     /*
      * SEEK_DATA cases:
      * D1. offs == start: start is in data
@@ -2395,6 +2396,64 @@ static int find_allocation(BlockDriverState *bs, off_t start,
         *hole = offs;
         return 0;
     }
+#else
+    /*
+     * In macOS, lseek with SEEK_DATA seeks to the next data region
+     * even though the offset is in the middle of a data region.
+     * In addition, there may be many data regions without any holes among
+     * them, like this:  |----Data----|----Data----|
+     *
+     * Although the behavior of lseek with SEEK_DATA is different in macOS,
+     * the behavior of lseek with SEEK_HOLE in macOS is the same as the one in
+     * Linux.
+     *
+     * Therefore, the cases D1, D2 and H2 are changed to the followings
+     * for macOS:
+     *  D1. offs == start: start is at the beginning of a data region.
+     *  D2. offs > start: either start is in a hole, next data at offs
+     *      or start is in the middle of a data region,
+     *      next data at offs.
+     *  H2. offs > start: start is in data, next hole at offs
+     */
+
+    offs = lseek(s->fd, start, SEEK_HOLE);
+    if (offs < 0) {
+        return -errno;  /* H3 or H4 */
+    }
+
+    if (offs < start) {
+        /* This is not a valid return by lseek().  We are safe to just return
+         * -EIO in this case, and we'll treat it like D4. */
+        return -EIO;
+    }
+
+    if (offs > start) {
+        /* H2: start is in data, next hole at offs */
+        *data = start;
+        *hole = offs;
+        return 0;
+    }
+
+    /* H1: start is in a hole */
+    offs = lseek(s->fd, start, SEEK_DATA);
+
+    if (offs < 0) {
+        return -errno;  /* H1 and (D3 or D4) */
+    }
+
+    if (offs < start) {
+        /* This is not a valid return by lseek().  We are safe to just return
+         * -EIO in this case, and we'll treat it like D4. */
+        return -EIO;
+    }
+
+    if (offs > start) {
+        /* H1 and D2: start is in a hole, next data at offs */
+        *hole = start;
+        *data = offs;
+        return 0;
+    }
+#endif
 
     /* D1 and H1 */
     return -EBUSY;
-- 
2.18.0
