Received: from eggs.gnu.org ([2001:4830:134:3::10]:34796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clwPa-0000H2-EM
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:39:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clwPZ-0006Wm-FK
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:39:14 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu,  9 Mar 2017 12:38:58 +0100
Message-Id: <1489059542-14232-3-git-send-email-kwolf@redhat.com>
In-Reply-To: <1489059542-14232-1-git-send-email-kwolf@redhat.com>
References: <1489059542-14232-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 2/6] block: Request block status from *file for
 BDRV_BLOCK_RAW
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This fixes bdrv_co_get_block_status() for the bdrv_mirror_top block
driver, which must fall through to bs->backing instead of bs->file.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index 8f38d46..2709a70 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1760,7 +1760,7 @@ static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
 
     if (ret & BDRV_BLOCK_RAW) {
         assert(ret & BDRV_BLOCK_OFFSET_VALID);
-        ret = bdrv_get_block_status(bs->file->bs, ret >> BDRV_SECTOR_BITS,
+        ret = bdrv_get_block_status(*file, ret >> BDRV_SECTOR_BITS,
                                     *pnum, pnum, file);
         goto out;
     }
-- 
1.8.3.1
