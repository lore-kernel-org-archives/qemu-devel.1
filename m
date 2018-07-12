Received: from eggs.gnu.org ([2001:4830:134:3::10]:56817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fdeVq-0004jw-1y
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 12:32:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fdeVo-00069Q-HO
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 12:32:14 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 12 Jul 2018 18:31:52 +0200
Message-Id: <20180712163152.12521-8-kwolf@redhat.com>
In-Reply-To: <20180712163152.12521-1-kwolf@redhat.com>
References: <20180712163152.12521-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 7/7] qemu-img: align result of
 is_allocated_sectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Peter Lieven <pl@kamp.de>

We currently don't enforce that the sparse segments we detect during convert are
aligned. This leads to unnecessary and costly read-modify-write cycles either
internally in Qemu or in the background on the storage device as nearly all
modern filesystems or hardware have a 4k alignment internally.

This patch modifies is_allocated_sectors so that its *pnum result will always
end at an alignment boundary. This way all requests will end at an alignment
boundary. The start of all requests will also be aligned as long as the results
of get_block_status do not lead to an unaligned offset.

The number of RMW cycles when converting an example image [1] to a raw device that
has 4k sector size is about 4600 4k read requests to perform a total of about 15000
write requests. With this path the additional 4600 read requests are eliminated while
the number of total write requests stays constant.

[1] https://cloud-images.ubuntu.com/releases/16.04/release/ubuntu-16.04-server-cloudimg-amd64-disk1.vmdk

Signed-off-by: Peter Lieven <pl@kamp.de>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c                 | 44 ++++++++++++++++++++++++++++++++++++++------
 tests/qemu-iotests/122.out | 18 ++++++++----------
 2 files changed, 46 insertions(+), 16 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index f4074ebf75..4a7ce43dc9 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1105,11 +1105,15 @@ static int64_t find_nonzero(const uint8_t *buf, int64_t n)
  *
  * 'pnum' is set to the number of sectors (including and immediately following
  * the first one) that are known to be in the same allocated/unallocated state.
+ * The function will try to align the end offset to alignment boundaries so
+ * that the request will at least end aligned and consequtive requests will
+ * also start at an aligned offset.
  */
-static int is_allocated_sectors(const uint8_t *buf, int n, int *pnum)
+static int is_allocated_sectors(const uint8_t *buf, int n, int *pnum,
+                                int64_t sector_num, int alignment)
 {
     bool is_zero;
-    int i;
+    int i, tail;
 
     if (n <= 0) {
         *pnum = 0;
@@ -1122,6 +1126,23 @@ static int is_allocated_sectors(const uint8_t *buf, int n, int *pnum)
             break;
         }
     }
+
+    tail = (sector_num + i) & (alignment - 1);
+    if (tail) {
+        if (is_zero && i <= tail) {
+            /* treat unallocated areas which only consist
+             * of a small tail as allocated. */
+            is_zero = false;
+        }
+        if (!is_zero) {
+            /* align up end offset of allocated areas. */
+            i += alignment - tail;
+            i = MIN(i, n);
+        } else {
+            /* align down end offset of zero areas. */
+            i -= tail;
+        }
+    }
     *pnum = i;
     return !is_zero;
 }
@@ -1132,7 +1153,7 @@ static int is_allocated_sectors(const uint8_t *buf, int n, int *pnum)
  * breaking up write requests for only small sparse areas.
  */
 static int is_allocated_sectors_min(const uint8_t *buf, int n, int *pnum,
-    int min)
+    int min, int64_t sector_num, int alignment)
 {
     int ret;
     int num_checked, num_used;
@@ -1141,7 +1162,7 @@ static int is_allocated_sectors_min(const uint8_t *buf, int n, int *pnum,
         min = n;
     }
 
-    ret = is_allocated_sectors(buf, n, pnum);
+    ret = is_allocated_sectors(buf, n, pnum, sector_num, alignment);
     if (!ret) {
         return ret;
     }
@@ -1149,13 +1170,15 @@ static int is_allocated_sectors_min(const uint8_t *buf, int n, int *pnum,
     num_used = *pnum;
     buf += BDRV_SECTOR_SIZE * *pnum;
     n -= *pnum;
+    sector_num += *pnum;
     num_checked = num_used;
 
     while (n > 0) {
-        ret = is_allocated_sectors(buf, n, pnum);
+        ret = is_allocated_sectors(buf, n, pnum, sector_num, alignment);
 
         buf += BDRV_SECTOR_SIZE * *pnum;
         n -= *pnum;
+        sector_num += *pnum;
         num_checked += *pnum;
         if (ret) {
             num_used = num_checked;
@@ -1560,6 +1583,7 @@ typedef struct ImgConvertState {
     bool wr_in_order;
     bool copy_range;
     int min_sparse;
+    int alignment;
     size_t cluster_sectors;
     size_t buf_sectors;
     long num_coroutines;
@@ -1724,7 +1748,8 @@ static int coroutine_fn convert_co_write(ImgConvertState *s, int64_t sector_num,
              * zeroed. */
             if (!s->min_sparse ||
                 (!s->compressed &&
-                 is_allocated_sectors_min(buf, n, &n, s->min_sparse)) ||
+                 is_allocated_sectors_min(buf, n, &n, s->min_sparse,
+                                          sector_num, s->alignment)) ||
                 (s->compressed &&
                  !buffer_is_zero(buf, n * BDRV_SECTOR_SIZE)))
             {
@@ -2368,6 +2393,13 @@ static int img_convert(int argc, char **argv)
                                 out_bs->bl.pdiscard_alignment >>
                                 BDRV_SECTOR_BITS)));
 
+    /* try to align the write requests to the destination to avoid unnecessary
+     * RMW cycles. */
+    s.alignment = MAX(pow2floor(s.min_sparse),
+                      DIV_ROUND_UP(out_bs->bl.request_alignment,
+                                   BDRV_SECTOR_SIZE));
+    assert(is_power_of_2(s.alignment));
+
     if (skip_create) {
         int64_t output_sectors = blk_nb_sectors(s.target);
         if (output_sectors < 0) {
diff --git a/tests/qemu-iotests/122.out b/tests/qemu-iotests/122.out
index 6c7ee1da6c..c576705284 100644
--- a/tests/qemu-iotests/122.out
+++ b/tests/qemu-iotests/122.out
@@ -194,12 +194,12 @@ wrote 1024/1024 bytes at offset 17408
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 convert -S 4k
-[{ "start": 0, "length": 1024, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 1024, "length": 7168, "depth": 0, "zero": true, "data": false},
-{ "start": 8192, "length": 1024, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 9216, "length": 8192, "depth": 0, "zero": true, "data": false},
-{ "start": 17408, "length": 1024, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 18432, "length": 67090432, "depth": 0, "zero": true, "data": false}]
+[{ "start": 0, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
+{ "start": 4096, "length": 4096, "depth": 0, "zero": true, "data": false},
+{ "start": 8192, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
+{ "start": 12288, "length": 4096, "depth": 0, "zero": true, "data": false},
+{ "start": 16384, "length": 4096, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
+{ "start": 20480, "length": 67088384, "depth": 0, "zero": true, "data": false}]
 
 convert -c -S 4k
 [{ "start": 0, "length": 1024, "depth": 0, "zero": false, "data": true},
@@ -210,10 +210,8 @@ convert -c -S 4k
 { "start": 18432, "length": 67090432, "depth": 0, "zero": true, "data": false}]
 
 convert -S 8k
-[{ "start": 0, "length": 9216, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 9216, "length": 8192, "depth": 0, "zero": true, "data": false},
-{ "start": 17408, "length": 1024, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
-{ "start": 18432, "length": 67090432, "depth": 0, "zero": true, "data": false}]
+[{ "start": 0, "length": 24576, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
+{ "start": 24576, "length": 67084288, "depth": 0, "zero": true, "data": false}]
 
 convert -c -S 8k
 [{ "start": 0, "length": 1024, "depth": 0, "zero": false, "data": true},
-- 
2.13.6
