Received: from eggs.gnu.org ([2001:4830:134:3::10]:40318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eqMBW-0000fJ-4u
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 12:03:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eqMBU-0005SF-LA
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 12:03:30 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 26 Feb 2018 18:03:13 +0100
Message-Id: <20180226170313.8178-1-mreitz@redhat.com>
Subject: [Qemu-devel] [RFC] qemu-img: Drop BLK_ZERO from convert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

There are filesystems (among which is tmpfs) that have a hard time
reporting allocation status.  That is definitely a bug in them.

However, there is no good reason why qemu-img convert should query the
allocation status in the first place.  It does zero detection by itself
anyway, so we can detect unallocated areas ourselves.

Furthermore, if a filesystem driver has any sense, reading unallocated
data should take just as much time as lseek(SEEK_DATA) + memset().  So
the only overhead we introduce by dropping the manual lseek() call is a
memset() in the driver and a buffer_is_zero() in qemu-img, both of which
should be relatively quick.

On the other hand, if we query the allocation status repeatedly for a
file that is nearly fully allocated, we do many lseek(SEEK_DATA/HOLE)
calls for nothing.  While we can easily blame bugs in filesystem
drivers, it still is a fact that this can cause considerable overhead.

Note that we still have to invoke bdrv_is_allocated() when copying only
the top overlay image.  But this is quick and completely under our
control because it only involves the format layer and does not go down
to the protocol level; so this will never leave qemu.

Buglink: https://bugs.launchpad.net/qemu/+bug/1751264
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
If we decide against this patch, we can still do the same if -S 0 has
been specified.  Then, if the user uses a buggy filesystem, we can tell
them to use -S 0 so that converting at least works (even if we don't do
any zero detection then).

(And we definitely should do this for -S 0.  Our current implementation
 then is to detect zero areas, create a bounce buffer, zero it, and
 write that to the destination.  But that's exactly what the source
 filesystem driver would do if we simply read the data from it, so we're
 just introducing overhead because of another lseek(SEEK_DATA).)
---
 qemu-img.c                 | 41 +++++++++----------------------
 tests/qemu-iotests/086.out | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 30 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index aa99fd32e9..d9e39c8901 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1522,7 +1522,6 @@ out4:
 
 enum ImgConvertBlockStatus {
     BLK_DATA,
-    BLK_ZERO,
     BLK_BACKING_FILE,
 };
 
@@ -1581,30 +1580,20 @@ static int convert_iteration_sectors(ImgConvertState *s, int64_t sector_num)
         int64_t count = n * BDRV_SECTOR_SIZE;
 
         if (s->target_has_backing) {
-
-            ret = bdrv_block_status(blk_bs(s->src[src_cur]),
+            ret = bdrv_is_allocated(blk_bs(s->src[src_cur]),
                                     (sector_num - src_cur_offset) *
                                     BDRV_SECTOR_SIZE,
-                                    count, &count, NULL, NULL);
-        } else {
-            ret = bdrv_block_status_above(blk_bs(s->src[src_cur]), NULL,
-                                          (sector_num - src_cur_offset) *
-                                          BDRV_SECTOR_SIZE,
-                                          count, &count, NULL, NULL);
-        }
-        if (ret < 0) {
-            return ret;
-        }
-        n = DIV_ROUND_UP(count, BDRV_SECTOR_SIZE);
+                                    count, &count);
+            if (ret < 0) {
+                return ret;
+            }
 
-        if (ret & BDRV_BLOCK_ZERO) {
-            s->status = BLK_ZERO;
-        } else if (ret & BDRV_BLOCK_DATA) {
-            s->status = BLK_DATA;
+            s->status = ret ? BLK_DATA : BLK_BACKING_FILE;
         } else {
-            s->status = s->target_has_backing ? BLK_BACKING_FILE : BLK_DATA;
+            s->status = BLK_DATA;
         }
 
+        n = DIV_ROUND_UP(count, BDRV_SECTOR_SIZE);
         s->sector_next_status = sector_num + n;
     }
 
@@ -1713,9 +1702,8 @@ static int coroutine_fn convert_co_write(ImgConvertState *s, int64_t sector_num,
                 }
                 break;
             }
-            /* fall-through */
 
-        case BLK_ZERO:
+            /* Zero the target */
             if (s->has_zero_init) {
                 assert(!s->target_has_backing);
                 break;
@@ -1774,15 +1762,12 @@ static void coroutine_fn convert_co_do_copy(void *opaque)
         /* save current sector and allocation status to local variables */
         sector_num = s->sector_num;
         status = s->status;
-        if (!s->min_sparse && s->status == BLK_ZERO) {
-            n = MIN(n, s->buf_sectors);
-        }
         /* increment global sector counter so that other coroutines can
          * already continue reading beyond this request */
         s->sector_num += n;
         qemu_co_mutex_unlock(&s->lock);
 
-        if (status == BLK_DATA || (!s->min_sparse && status == BLK_ZERO)) {
+        if (status == BLK_DATA) {
             s->allocated_done += n;
             qemu_progress_print(100.0 * s->allocated_done /
                                         s->allocated_sectors, 0);
@@ -1795,9 +1780,6 @@ static void coroutine_fn convert_co_do_copy(void *opaque)
                              ": %s", sector_num, strerror(-ret));
                 s->ret = ret;
             }
-        } else if (!s->min_sparse && status == BLK_ZERO) {
-            status = BLK_DATA;
-            memset(buf, 0x00, n * BDRV_SECTOR_SIZE);
         }
 
         if (s->wr_in_order) {
@@ -1879,8 +1861,7 @@ static int convert_do_copy(ImgConvertState *s)
         if (n < 0) {
             return n;
         }
-        if (s->status == BLK_DATA || (!s->min_sparse && s->status == BLK_ZERO))
-        {
+        if (s->status == BLK_DATA) {
             s->allocated_sectors += n;
         }
         sector_num += n;
diff --git a/tests/qemu-iotests/086.out b/tests/qemu-iotests/086.out
index 5ff996101b..057a21abdb 100644
--- a/tests/qemu-iotests/086.out
+++ b/tests/qemu-iotests/086.out
@@ -9,9 +9,69 @@ wrote 1048576/1048576 bytes at offset 4194304
 wrote 1048576/1048576 bytes at offset 33554432
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
     (0.00/100%)
+    (1.56/100%)
+    (3.12/100%)
+    (4.69/100%)
+    (6.25/100%)
+    (7.81/100%)
+    (9.38/100%)
+    (10.94/100%)
+    (12.50/100%)
+    (14.06/100%)
+    (15.62/100%)
+    (17.19/100%)
+    (18.75/100%)
+    (20.31/100%)
+    (21.88/100%)
+    (23.44/100%)
     (25.00/100%)
+    (26.56/100%)
+    (28.12/100%)
+    (29.69/100%)
+    (31.25/100%)
+    (32.81/100%)
+    (34.38/100%)
+    (35.94/100%)
+    (37.50/100%)
+    (39.06/100%)
+    (40.62/100%)
+    (42.19/100%)
+    (43.75/100%)
+    (45.31/100%)
+    (46.88/100%)
+    (48.44/100%)
     (50.00/100%)
+    (51.56/100%)
+    (53.12/100%)
+    (54.69/100%)
+    (56.25/100%)
+    (57.81/100%)
+    (59.38/100%)
+    (60.94/100%)
+    (62.50/100%)
+    (64.06/100%)
+    (65.62/100%)
+    (67.19/100%)
+    (68.75/100%)
+    (70.31/100%)
+    (71.88/100%)
+    (73.44/100%)
     (75.00/100%)
+    (76.56/100%)
+    (78.12/100%)
+    (79.69/100%)
+    (81.25/100%)
+    (82.81/100%)
+    (84.38/100%)
+    (85.94/100%)
+    (87.50/100%)
+    (89.06/100%)
+    (90.62/100%)
+    (92.19/100%)
+    (93.75/100%)
+    (95.31/100%)
+    (96.88/100%)
+    (98.44/100%)
     (100.00/100%)
     (100.00/100%)
 
-- 
2.14.3
