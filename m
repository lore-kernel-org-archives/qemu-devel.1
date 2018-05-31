Received: from eggs.gnu.org ([2001:4830:134:3::10]:47053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOUXQ-0003Ru-9k
	for qemu-devel@nongnu.org; Thu, 31 May 2018 16:51:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOUXP-0001kz-Di
	for qemu-devel@nongnu.org; Thu, 31 May 2018 16:51:12 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 31 May 2018 15:50:45 -0500
Message-Id: <20180531205046.153256-8-eblake@redhat.com>
In-Reply-To: <20180531205046.153256-1-eblake@redhat.com>
References: <20180531205046.153256-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 7/8] vhdx: Switch to byte-based calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, Jeff Cody <jcody@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Make the change for the last few sector-based calls
into the block layer from the vhdx driver.

Ideally, the vhdx driver should switch to doing everything
byte-based, but that's a more invasive change that requires a
bit more auditing.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/vhdx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/vhdx.c b/block/vhdx.c
index 0b1e21c7501..295d3276120 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1126,9 +1126,9 @@ static coroutine_fn int vhdx_co_readv(BlockDriverState *bs, int64_t sector_num,
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
@@ -1348,9 +1348,9 @@ static coroutine_fn int vhdx_co_writev(BlockDriverState *bs, int64_t sector_num,
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
2.14.3
