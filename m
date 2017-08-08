Received: from eggs.gnu.org ([2001:4830:134:3::10]:42341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1df52H-0000BG-QQ
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:59:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1df52C-00022u-Sa
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:59:05 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  8 Aug 2017 15:58:25 +0200
Message-Id: <20170808135838.11525-6-kwolf@redhat.com>
In-Reply-To: <20170808135838.11525-1-kwolf@redhat.com>
References: <20170808135838.11525-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 05/18] block/vhdx: check error return of
 bdrv_flush()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org

From: Jeff Cody <jcody@redhat.com>

Reported-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vhdx-log.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/block/vhdx-log.c b/block/vhdx-log.c
index 95972230f0..a27dc059cd 100644
--- a/block/vhdx-log.c
+++ b/block/vhdx-log.c
@@ -565,7 +565,10 @@ static int vhdx_log_flush(BlockDriverState *bs, BDRVVHDXState *s,
         desc_entries = NULL;
     }
 
-    bdrv_flush(bs);
+    ret = bdrv_flush(bs);
+    if (ret < 0) {
+        goto exit;
+    }
     /* once the log is fully flushed, indicate that we have an empty log
      * now.  This also sets the log guid to 0, to indicate an empty log */
     vhdx_log_reset(bs, s);
@@ -1039,7 +1042,11 @@ int vhdx_log_write_and_flush(BlockDriverState *bs, BDRVVHDXState *s,
 
     /* Make sure data written (new and/or changed blocks) is stable
      * on disk, before creating log entry */
-    bdrv_flush(bs);
+    ret = bdrv_flush(bs);
+    if (ret < 0) {
+        goto exit;
+    }
+
     ret = vhdx_log_write(bs, s, data, length, offset);
     if (ret < 0) {
         goto exit;
@@ -1047,7 +1054,11 @@ int vhdx_log_write_and_flush(BlockDriverState *bs, BDRVVHDXState *s,
     logs.log = s->log;
 
     /* Make sure log is stable on disk */
-    bdrv_flush(bs);
+    ret = bdrv_flush(bs);
+    if (ret < 0) {
+        goto exit;
+    }
+
     ret = vhdx_log_flush(bs, s, &logs);
     if (ret < 0) {
         goto exit;
-- 
2.13.4
