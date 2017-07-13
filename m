Received: from eggs.gnu.org ([2001:4830:134:3::10]:54338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVgM1-0005xB-Tp
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:48:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVgM0-0006Hu-V9
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:48:37 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 13 Jul 2017 10:47:02 -0500
Message-Id: <20170713154711.32374-15-eblake@redhat.com>
In-Reply-To: <20170713154711.32374-1-eblake@redhat.com>
References: <20170713154711.32374-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 14/23] qemu-img: Speed up compare on
 pre-allocated larger file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org, el13635@mail.ntua.gr, Max Reitz <mreitz@redhat.com>

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

---
v3: new patch
---
 qemu-img.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index bc21d00..46f9da5 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1471,11 +1471,11 @@ static int img_compare(int argc, char **argv)
         while (sector_num < progress_base) {
             int64_t count;

-            ret = bdrv_is_allocated_above(blk_bs(blk_over), NULL,
+            ret = bdrv_block_status_above(blk_bs(blk_over), NULL,
                                           sector_num * BDRV_SECTOR_SIZE,
                                           (progress_base - sector_num) *
                                           BDRV_SECTOR_SIZE,
-                                          &count);
+                                          &count, NULL);
             if (ret < 0) {
                 ret = 3;
                 error_report("Sector allocation test failed for %s",
@@ -1483,11 +1483,11 @@ static int img_compare(int argc, char **argv)
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
2.9.4
