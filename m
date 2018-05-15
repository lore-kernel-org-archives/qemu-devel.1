Received: from eggs.gnu.org ([2001:4830:134:3::10]:39224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4l-00075V-JZ
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:41:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4k-0001tC-CP
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:41:19 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 15 May 2018 17:40:29 +0200
Message-Id: <20180515154033.19899-34-kwolf@redhat.com>
In-Reply-To: <20180515154033.19899-1-kwolf@redhat.com>
References: <20180515154033.19899-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 33/37] qemu-img: Check post-truncation size
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

Some block drivers (iscsi and file-posix when dealing with device files)
do not actually support truncation, even though they provide a
.bdrv_truncate() method and will happily return success when providing a
new size that does not exceed the current size.  This is because these
drivers expect the user to resize the image outside of qemu and then
provide qemu with that information through the block_resize command
(compare cb1b83e740384b4e0d950f3d7c81c02b8ce86c2e).

Of course, anyone using qemu-img resize will find that behavior useless.
So we should check the actual size of the image after the supposedly
successful truncation took place, emit an error if nothing changed and
emit a warning if the target size was not met.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1523065
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20180421163957.29872-1-mreitz@redhat.com
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index ea62d2d61e..62b29e7feb 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3381,7 +3381,7 @@ static int img_resize(int argc, char **argv)
     Error *err = NULL;
     int c, ret, relative;
     const char *filename, *fmt, *size;
-    int64_t n, total_size, current_size;
+    int64_t n, total_size, current_size, new_size;
     bool quiet = false;
     BlockBackend *blk = NULL;
     PreallocMode prealloc = PREALLOC_MODE_OFF;
@@ -3557,11 +3557,42 @@ static int img_resize(int argc, char **argv)
     }
 
     ret = blk_truncate(blk, total_size, prealloc, &err);
-    if (!ret) {
-        qprintf(quiet, "Image resized.\n");
-    } else {
+    if (ret < 0) {
         error_report_err(err);
+        goto out;
+    }
+
+    new_size = blk_getlength(blk);
+    if (new_size < 0) {
+        error_report("Failed to verify truncated image length: %s",
+                     strerror(-new_size));
+        ret = -1;
+        goto out;
     }
+
+    /* Some block drivers implement a truncation method, but only so
+     * the user can cause qemu to refresh the image's size from disk.
+     * The idea is that the user resizes the image outside of qemu and
+     * then invokes block_resize to inform qemu about it.
+     * (This includes iscsi and file-posix for device files.)
+     * Of course, that is not the behavior someone invoking
+     * qemu-img resize would find useful, so we catch that behavior
+     * here and tell the user. */
+    if (new_size != total_size && new_size == current_size) {
+        error_report("Image was not resized; resizing may not be supported "
+                     "for this image");
+        ret = -1;
+        goto out;
+    }
+
+    if (new_size != total_size) {
+        warn_report("Image should have been resized to %" PRIi64
+                    " bytes, but was resized to %" PRIi64 " bytes",
+                    total_size, new_size);
+    }
+
+    qprintf(quiet, "Image resized.\n");
+
 out:
     blk_unref(blk);
     if (ret) {
-- 
2.13.6
