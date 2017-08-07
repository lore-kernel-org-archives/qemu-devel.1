Received: from eggs.gnu.org ([2001:4830:134:3::10]:53517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dehIv-0003Wb-Ii
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:38:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dehIq-0003Je-Qw
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:38:41 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Mon,  7 Aug 2017 08:38:21 -0400
Message-Id: <3f89708534aeb149ebf4a0e3e54b4c24b44a1116.1502109078.git.jcody@redhat.com>
In-Reply-To: <cover.1502109078.git.jcody@redhat.com>
References: <cover.1502109078.git.jcody@redhat.com>
In-Reply-To: <cover.1502109078.git.jcody@redhat.com>
References: <cover.1502109078.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.10 3/4] block/vhdx: check error return
 of bdrv_flush()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, kwolf@redhat.com, eblake@redhat.com

Reported-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/vhdx-log.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/block/vhdx-log.c b/block/vhdx-log.c
index 9597223..a27dc05 100644
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
2.9.4
