Received: from eggs.gnu.org ([2001:4830:134:3::10]:58828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i3N-0000ca-L0
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:18:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i3M-000275-LB
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:18:33 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 26 Oct 2017 15:17:22 +0200
Message-Id: <20171026131741.5059-17-kwolf@redhat.com>
In-Reply-To: <20171026131741.5059-1-kwolf@redhat.com>
References: <20171026131741.5059-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 16/35] qemu-img: Speed up compare on
 pre-allocated larger file
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

Compare the following images with all-zero contents:
$ truncate --size 1M A
$ qemu-img create -f qcow2 -o preallocation=off B 1G
$ qemu-img create -f qcow2 -o preallocation=metadata C 1G

On my machine, the difference is noticeable for pre-patch speeds,
with more than an order of magnitude in difference caused by the
choice of preallocation in the qcow2 file:

$ time ./qemu-img compare -f raw -F qcow2 A B
Warning: Image size mismatch!
Images are identical.

real	0m0.014s
user	0m0.007s
sys	0m0.007s

$ time ./qemu-img compare -f raw -F qcow2 A C
Warning: Image size mismatch!
Images are identical.

real	0m0.341s
user	0m0.144s
sys	0m0.188s

Why? Because bdrv_is_allocated() returns false for image B but
true for image C, throwing away the fact that both images know
via lseek(SEEK_HOLE) that the entire image still reads as zero.
>From there, qemu-img ends up calling bdrv_pread() for every byte
of the tail, instead of quickly looking for the next allocation.
The solution: use block_status instead of is_allocated, giving:

$ time ./qemu-img compare -f raw -F qcow2 A C
Warning: Image size mismatch!
Images are identical.

real	0m0.014s
user	0m0.011s
sys	0m0.003s

which is on par with the speeds for no pre-allocation.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index cfa28d41d5..e4b84c4f56 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1480,11 +1480,11 @@ static int img_compare(int argc, char **argv)
         while (sector_num < progress_base) {
             int64_t count;
 
-            ret = bdrv_is_allocated_above(blk_bs(blk_over), NULL,
+            ret = bdrv_block_status_above(blk_bs(blk_over), NULL,
                                           sector_num * BDRV_SECTOR_SIZE,
                                           (progress_base - sector_num) *
                                           BDRV_SECTOR_SIZE,
-                                          &count);
+                                          &count, NULL, NULL);
             if (ret < 0) {
                 ret = 3;
                 error_report("Sector allocation test failed for %s",
@@ -1492,11 +1492,11 @@ static int img_compare(int argc, char **argv)
                 goto out;
 
             }
-            /* TODO relax this once bdrv_is_allocated_above does not enforce
+            /* TODO relax this once bdrv_block_status_above does not enforce
              * sector alignment */
             assert(QEMU_IS_ALIGNED(count, BDRV_SECTOR_SIZE));
             nb_sectors = count >> BDRV_SECTOR_BITS;
-            if (ret) {
+            if (ret & BDRV_BLOCK_ALLOCATED && !(ret & BDRV_BLOCK_ZERO)) {
                 nb_sectors = MIN(nb_sectors, IO_BUF_SIZE >> BDRV_SECTOR_BITS);
                 ret = check_empty_sectors(blk_over, sector_num, nb_sectors,
                                           filename_over, buf1, quiet);
-- 
2.13.6
