Received: from eggs.gnu.org ([2001:4830:134:3::10]:47064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOUXR-0003Sq-BQ
	for qemu-devel@nongnu.org; Thu, 31 May 2018 16:51:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOUXQ-0001m2-F4
	for qemu-devel@nongnu.org; Thu, 31 May 2018 16:51:13 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 31 May 2018 15:50:46 -0500
Message-Id: <20180531205046.153256-9-eblake@redhat.com>
In-Reply-To: <20180531205046.153256-1-eblake@redhat.com>
References: <20180531205046.153256-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 8/8] block: Remove unused sector-based
 vectored I/O
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Now that all callers of vectored I/O have been converted
to use our preferred byte-based bdrv_co_p{read,write}v(), we can
delete the unused bdrv_co_{read,write}v().

Furthermore, this gets rid of the signature difference between the
public bdrv_co_writev() and the callback .bdrv_co_writev (the
latter still exists, because some drivers still need more work
before they are fully byte-based).

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
v2: commit typo fix [Kashyap]
---
 include/block/block.h |  4 ----
 block/io.c            | 36 ------------------------------------
 2 files changed, 40 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 3894edda9de..fe40d2929ac 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -285,10 +285,6 @@ int bdrv_pwrite(BdrvChild *child, int64_t offset, const void *buf, int bytes);
 int bdrv_pwritev(BdrvChild *child, int64_t offset, QEMUIOVector *qiov);
 int bdrv_pwrite_sync(BdrvChild *child, int64_t offset,
                      const void *buf, int count);
-int coroutine_fn bdrv_co_readv(BdrvChild *child, int64_t sector_num,
-                               int nb_sectors, QEMUIOVector *qiov);
-int coroutine_fn bdrv_co_writev(BdrvChild *child, int64_t sector_num,
-                               int nb_sectors, QEMUIOVector *qiov);
 /*
  * Efficiently zero a region of the disk image.  Note that this is a regular
  * I/O request like read or write and should have a reasonable size.  This
diff --git a/block/io.c b/block/io.c
index ca96b487eb8..1d86bfc0072 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1341,24 +1341,6 @@ int coroutine_fn bdrv_co_preadv(BdrvChild *child,
     return ret;
 }

-static int coroutine_fn bdrv_co_do_readv(BdrvChild *child,
-    int64_t sector_num, int nb_sectors, QEMUIOVector *qiov,
-    BdrvRequestFlags flags)
-{
-    if (nb_sectors < 0 || nb_sectors > BDRV_REQUEST_MAX_SECTORS) {
-        return -EINVAL;
-    }
-
-    return bdrv_co_preadv(child, sector_num << BDRV_SECTOR_BITS,
-                          nb_sectors << BDRV_SECTOR_BITS, qiov, flags);
-}
-
-int coroutine_fn bdrv_co_readv(BdrvChild *child, int64_t sector_num,
-                               int nb_sectors, QEMUIOVector *qiov)
-{
-    return bdrv_co_do_readv(child, sector_num, nb_sectors, qiov, 0);
-}
-
 static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
     int64_t offset, int bytes, BdrvRequestFlags flags)
 {
@@ -1801,24 +1783,6 @@ out:
     return ret;
 }

-static int coroutine_fn bdrv_co_do_writev(BdrvChild *child,
-    int64_t sector_num, int nb_sectors, QEMUIOVector *qiov,
-    BdrvRequestFlags flags)
-{
-    if (nb_sectors < 0 || nb_sectors > BDRV_REQUEST_MAX_SECTORS) {
-        return -EINVAL;
-    }
-
-    return bdrv_co_pwritev(child, sector_num << BDRV_SECTOR_BITS,
-                           nb_sectors << BDRV_SECTOR_BITS, qiov, flags);
-}
-
-int coroutine_fn bdrv_co_writev(BdrvChild *child, int64_t sector_num,
-    int nb_sectors, QEMUIOVector *qiov)
-{
-    return bdrv_co_do_writev(child, sector_num, nb_sectors, qiov, 0);
-}
-
 int coroutine_fn bdrv_co_pwrite_zeroes(BdrvChild *child, int64_t offset,
                                        int bytes, BdrvRequestFlags flags)
 {
-- 
2.14.3
