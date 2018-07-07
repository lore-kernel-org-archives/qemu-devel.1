Received: from eggs.gnu.org ([2001:4830:134:3::10]:50123)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1fblbZ-0001Lw-DX
	for qemu-devel@nongnu.org; Sat, 07 Jul 2018 07:42:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1fblbU-0000L8-Dl
	for qemu-devel@nongnu.org; Sat, 07 Jul 2018 07:42:21 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:43648 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1fblbU-0000J4-4C
	for qemu-devel@nongnu.org; Sat, 07 Jul 2018 07:42:16 -0400
Received: from submission.kamp.de ([195.62.97.28]) by kerio.kamp.de with ESMTPS
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	for qemu-devel@nongnu.org; Sat, 7 Jul 2018 13:42:04 +0200
From: Peter Lieven <pl@kamp.de>
Date: Sat,  7 Jul 2018 13:42:03 +0200
Message-Id: <1530963723-14380-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH V4] qemu-img: align result of
 is_allocated_sectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, Peter Lieven <pl@kamp.de>

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
---
V3->V4: - only focus on the end offset in is_allocated_sectors [Kevin]
V2->V3: - ensure that s.alignment is a power of 2
        - correctly handle n < alignment in is_allocated_sectors if
          sector_num % alignment > 0.
V1->V2: - take the current sector offset into account [Max]
        - try to figure out the target alignment [Max]

 qemu-img.c | 44 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index e1a506f..20e3236 100644
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
+        if (is_zero && i == tail) {
+            /* treat unallocated areas which only consist
+             * of a small tail as allocated. */
+            is_zero = 0;
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
@@ -2373,6 +2398,13 @@ static int img_convert(int argc, char **argv)
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
-- 
2.7.4
