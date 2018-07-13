Received: from eggs.gnu.org ([2001:4830:134:3::10]:43865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fdw1y-0005lf-8c
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 07:14:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fdw1x-0002cZ-Bk
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 07:14:34 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 13 Jul 2018 13:14:23 +0200
Message-Id: <20180713111424.23670-3-mreitz@redhat.com>
In-Reply-To: <20180713111424.23670-1-mreitz@redhat.com>
References: <20180713111424.23670-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] qemu-img: Use zero writes after source
 backing EOF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Past the end of the source backing file, we memset() buf_old to zero, so
it is clearly easy to use blk_pwrite_zeroes() instead of blk_pwrite()
then.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index dd684d8bf0..2552e7dad6 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3403,6 +3403,8 @@ static int img_rebase(int argc, char **argv)
         }
 
         for (offset = 0; offset < size; offset += n) {
+            bool buf_old_is_zero = false;
+
             /* How many bytes can we handle with the next read? */
             n = MIN(IO_BUF_SIZE, size - offset);
 
@@ -3423,6 +3425,7 @@ static int img_rebase(int argc, char **argv)
              */
             if (offset >= old_backing_size) {
                 memset(buf_old, 0, n);
+                buf_old_is_zero = true;
             } else {
                 if (offset + n > old_backing_size) {
                     n = old_backing_size - offset;
@@ -3458,8 +3461,12 @@ static int img_rebase(int argc, char **argv)
                 if (compare_buffers(buf_old + written, buf_new + written,
                                     n - written, &pnum))
                 {
-                    ret = blk_pwrite(blk, offset + written,
-                                     buf_old + written, pnum, 0);
+                    if (buf_old_is_zero) {
+                        ret = blk_pwrite_zeroes(blk, offset + written, pnum, 0);
+                    } else {
+                        ret = blk_pwrite(blk, offset + written,
+                                         buf_old + written, pnum, 0);
+                    }
                     if (ret < 0) {
                         error_report("Error while writing to COW image: %s",
                             strerror(-ret));
-- 
2.17.1
