Received: from eggs.gnu.org ([2001:4830:134:3::10]:49810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYu6c-00045a-3V
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:10:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYu6Z-0004ET-Se
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:10:33 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 29 Jun 2018 16:09:52 +0200
Message-Id: <20180629140959.6690-23-kwolf@redhat.com>
In-Reply-To: <20180629140959.6690-1-kwolf@redhat.com>
References: <20180629140959.6690-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 22/29] parallels: Switch to byte-based calls
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

From: Eric Blake <eblake@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Make the change for the last few sector-based calls
into the block layer from the parallels driver.

Ideally, the parallels driver should switch to doing everything
byte-based, but that's a more invasive change that requires a
bit more auditing.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/parallels.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index fd215e202a..cc9445879d 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -227,14 +227,15 @@ static int64_t allocate_clusters(BlockDriverState *bs, int64_t sector_num,
         };
         qemu_iovec_init_external(&qiov, &iov, 1);
 
-        ret = bdrv_co_readv(bs->backing, idx * s->tracks, nb_cow_sectors,
-                            &qiov);
+        ret = bdrv_co_preadv(bs->backing, idx * s->tracks * BDRV_SECTOR_SIZE,
+                             nb_cow_bytes, &qiov, 0);
         if (ret < 0) {
             qemu_vfree(iov.iov_base);
             return ret;
         }
 
-        ret = bdrv_co_writev(bs->file, s->data_end, nb_cow_sectors, &qiov);
+        ret = bdrv_co_pwritev(bs->file, s->data_end * BDRV_SECTOR_SIZE,
+                              nb_cow_bytes, &qiov, 0);
         qemu_vfree(iov.iov_base);
         if (ret < 0) {
             return ret;
@@ -340,7 +341,8 @@ static coroutine_fn int parallels_co_writev(BlockDriverState *bs,
         qemu_iovec_reset(&hd_qiov);
         qemu_iovec_concat(&hd_qiov, qiov, bytes_done, nbytes);
 
-        ret = bdrv_co_writev(bs->file, position, n, &hd_qiov);
+        ret = bdrv_co_pwritev(bs->file, position * BDRV_SECTOR_SIZE, nbytes,
+                              &hd_qiov, 0);
         if (ret < 0) {
             break;
         }
@@ -379,7 +381,8 @@ static coroutine_fn int parallels_co_readv(BlockDriverState *bs,
 
         if (position < 0) {
             if (bs->backing) {
-                ret = bdrv_co_readv(bs->backing, sector_num, n, &hd_qiov);
+                ret = bdrv_co_preadv(bs->backing, sector_num * BDRV_SECTOR_SIZE,
+                                     nbytes, &hd_qiov, 0);
                 if (ret < 0) {
                     break;
                 }
@@ -387,7 +390,8 @@ static coroutine_fn int parallels_co_readv(BlockDriverState *bs,
                 qemu_iovec_memset(&hd_qiov, 0, 0, nbytes);
             }
         } else {
-            ret = bdrv_co_readv(bs->file, position, n, &hd_qiov);
+            ret = bdrv_co_preadv(bs->file, position * BDRV_SECTOR_SIZE, nbytes,
+                                 &hd_qiov, 0);
             if (ret < 0) {
                 break;
             }
-- 
2.13.6
