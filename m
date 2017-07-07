Received: from eggs.gnu.org ([2001:4830:134:3::10]:41730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWlG-00055v-I5
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:09:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWlB-0007ti-LH
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:09:46 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Jul 2017 19:07:39 +0200
Message-Id: <1499447335-6125-25-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 024/100] stream: Switch stream_run() to
 byte-based
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

From: Eric Blake <eblake@redhat.com>

We are gradually converting to byte-based interfaces, as they are
easier to reason about than sector-based.  Change the internal
loop iteration of streaming to track by bytes instead of sectors
(although we are still guaranteed that we iterate by steps that
are sector-aligned).

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/stream.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/block/stream.c b/block/stream.c
index 12f1659..e3dd2ac 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -107,12 +107,11 @@ static void coroutine_fn stream_run(void *opaque)
     BlockBackend *blk = s->common.blk;
     BlockDriverState *bs = blk_bs(blk);
     BlockDriverState *base = s->base;
-    int64_t sector_num = 0;
-    int64_t end = -1;
+    int64_t offset = 0;
     uint64_t delay_ns = 0;
     int error = 0;
     int ret = 0;
-    int n = 0;
+    int n = 0; /* sectors */
     void *buf;
 
     if (!bs->backing) {
@@ -125,7 +124,6 @@ static void coroutine_fn stream_run(void *opaque)
         goto out;
     }
 
-    end = s->common.len >> BDRV_SECTOR_BITS;
     buf = qemu_blockalign(bs, STREAM_BUFFER_SIZE);
 
     /* Turn on copy-on-read for the whole block device so that guest read
@@ -137,7 +135,7 @@ static void coroutine_fn stream_run(void *opaque)
         bdrv_enable_copy_on_read(bs);
     }
 
-    for (sector_num = 0; sector_num < end; sector_num += n) {
+    for ( ; offset < s->common.len; offset += n * BDRV_SECTOR_SIZE) {
         bool copy;
 
         /* Note that even when no rate limit is applied we need to yield
@@ -150,28 +148,26 @@ static void coroutine_fn stream_run(void *opaque)
 
         copy = false;
 
-        ret = bdrv_is_allocated(bs, sector_num,
+        ret = bdrv_is_allocated(bs, offset / BDRV_SECTOR_SIZE,
                                 STREAM_BUFFER_SIZE / BDRV_SECTOR_SIZE, &n);
         if (ret == 1) {
             /* Allocated in the top, no need to copy.  */
         } else if (ret >= 0) {
             /* Copy if allocated in the intermediate images.  Limit to the
-             * known-unallocated area [sector_num, sector_num+n).  */
+             * known-unallocated area [offset, offset+n*BDRV_SECTOR_SIZE).  */
             ret = bdrv_is_allocated_above(backing_bs(bs), base,
-                                          sector_num, n, &n);
+                                          offset / BDRV_SECTOR_SIZE, n, &n);
 
             /* Finish early if end of backing file has been reached */
             if (ret == 0 && n == 0) {
-                n = end - sector_num;
+                n = (s->common.len - offset) / BDRV_SECTOR_SIZE;
             }
 
             copy = (ret == 1);
         }
-        trace_stream_one_iteration(s, sector_num * BDRV_SECTOR_SIZE,
-                                   n * BDRV_SECTOR_SIZE, ret);
+        trace_stream_one_iteration(s, offset, n * BDRV_SECTOR_SIZE, ret);
         if (copy) {
-            ret = stream_populate(blk, sector_num * BDRV_SECTOR_SIZE,
-                                  n * BDRV_SECTOR_SIZE, buf);
+            ret = stream_populate(blk, offset, n * BDRV_SECTOR_SIZE, buf);
         }
         if (ret < 0) {
             BlockErrorAction action =
-- 
1.8.3.1
