Received: from eggs.gnu.org ([209.51.188.92]:34540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hCPlP-000591-MF
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 10:24:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hCPlO-0006Ie-6M
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 10:24:15 -0400
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Fri,  5 Apr 2019 17:24:04 +0300
Message-Id: <1554474244-553661-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH] block/io.c: fix for the allocation failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: stefanha@redhat.com, fam@euphon.net, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, andrey.shinkevich@virtuozzo.com

On a file system used by the customer, fallocate() returns an error
if the block is not properly aligned. So, bdrv_co_pwrite_zeroes()
fails. We can handle that case the same way as it is done for the
unsupported cases, namely, call to bdrv_driver_pwritev() that writes
zeroes to an image for the unaligned chunk of the block.

Suggested-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 block/io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index dfc153b..0412a51 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1516,7 +1516,7 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
             assert(!bs->supported_zero_flags);
         }
 
-        if (ret == -ENOTSUP && !(flags & BDRV_REQ_NO_FALLBACK)) {
+        if (ret < 0 && !(flags & BDRV_REQ_NO_FALLBACK)) {
             /* Fall back to bounce buffer if write zeroes is unsupported */
             BdrvRequestFlags write_flags = flags & ~BDRV_REQ_ZERO_WRITE;
 
-- 
1.8.3.1
