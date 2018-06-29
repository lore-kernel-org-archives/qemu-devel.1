Received: from eggs.gnu.org ([2001:4830:134:3::10]:49936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYu6j-0004FR-DA
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:10:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYu6i-0004VV-Ec
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:10:41 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 29 Jun 2018 16:09:58 +0200
Message-Id: <20180629140959.6690-29-kwolf@redhat.com>
In-Reply-To: <20180629140959.6690-1-kwolf@redhat.com>
References: <20180629140959.6690-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 28/29] vhdx: Switch to byte-based calls
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
into the block layer from the vhdx driver.

Ideally, the vhdx driver should switch to doing everything
byte-based, but that's a more invasive change that requires a
bit more auditing.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vhdx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/vhdx.c b/block/vhdx.c
index a677703a9e..4d0819750f 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1127,9 +1127,9 @@ static coroutine_fn int vhdx_co_readv(BlockDriverState *bs, int64_t sector_num,
                 break;
             case PAYLOAD_BLOCK_FULLY_PRESENT:
                 qemu_co_mutex_unlock(&s->lock);
-                ret = bdrv_co_readv(bs->file,
-                                    sinfo.file_offset >> BDRV_SECTOR_BITS,
-                                    sinfo.sectors_avail, &hd_qiov);
+                ret = bdrv_co_preadv(bs->file, sinfo.file_offset,
+                                     sinfo.sectors_avail * BDRV_SECTOR_SIZE,
+                                     &hd_qiov, 0);
                 qemu_co_mutex_lock(&s->lock);
                 if (ret < 0) {
                     goto exit;
@@ -1349,9 +1349,9 @@ static coroutine_fn int vhdx_co_writev(BlockDriverState *bs, int64_t sector_num,
                 }
                 /* block exists, so we can just overwrite it */
                 qemu_co_mutex_unlock(&s->lock);
-                ret = bdrv_co_writev(bs->file,
-                                    sinfo.file_offset >> BDRV_SECTOR_BITS,
-                                    sectors_to_write, &hd_qiov);
+                ret = bdrv_co_pwritev(bs->file, sinfo.file_offset,
+                                      sectors_to_write * BDRV_SECTOR_SIZE,
+                                      &hd_qiov, 0);
                 qemu_co_mutex_lock(&s->lock);
                 if (ret < 0) {
                     goto error_bat_restore;
-- 
2.13.6
