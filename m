Received: from eggs.gnu.org ([2001:4830:134:3::10]:37898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSrXs-0004v1-D3
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 17:09:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSrXn-0002ez-8g
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 17:09:12 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed,  5 Jul 2017 16:08:26 -0500
Message-Id: <20170705210842.960-6-eblake@redhat.com>
In-Reply-To: <20170705210842.960-1-eblake@redhat.com>
References: <20170705210842.960-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 05/21] stream: Switch stream_run() to
 byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

We are gradually converting to byte-based interfaces, as they are
easier to reason about than sector-based.  Change the internal
loop iteration of streaming to track by bytes instead of sectors
(although we are still guaranteed that we iterate by steps that
are sector-aligned).

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>

---
v4: avoid reached_end change by rebasing to earlier changes [Kevin], R-b kept
v2-v3: no change
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
2.9.4
