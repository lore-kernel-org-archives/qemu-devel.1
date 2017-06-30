Received: from eggs.gnu.org ([2001:4830:134:3::10]:57065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQwdH-0004W9-MA
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 10:10:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQwdG-0001Zx-JW
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 10:10:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dQwdG-0001ZK-BP
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 10:10:50 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 30 Jun 2017 22:10:39 +0800
Message-Id: <20170630141040.15353-2-famz@redhat.com>
In-Reply-To: <20170630141040.15353-1-famz@redhat.com>
References: <20170630141040.15353-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 1/2] block: Add BDRV_BLOCK_EOF to
 bdrv_get_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>

From: Eric Blake <eblake@redhat.com>

Just as the block layer already sets BDRV_BLOCK_ALLOCATED as a
shortcut for subsequent operations, there are also some optimizations
that are made easier if we can quickly tell that *pnum will advance
us to the end of a file, via a new BDRV_BLOCK_EOF which gets set
by the block layer.

This just plumbs up the new bit; subsequent patches will make use
of it.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20170505021500.19315-2-eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/io.c            | 15 +++++++++++----
 include/block/block.h |  2 ++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/block/io.c b/block/io.c
index 9bba730..7e6abef 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1711,15 +1711,16 @@ typedef struct BdrvCoGetBlockStatusData {
  * Drivers not implementing the functionality are assumed to not support
  * backing files, hence all their sectors are reported as allocated.
  *
- * If 'sector_num' is beyond the end of the disk image the return value is 0
- * and 'pnum' is set to 0.
+ * If 'sector_num' is beyond the end of the disk image the return value is
+ * BDRV_BLOCK_EOF and 'pnum' is set to 0.
  *
  * 'pnum' is set to the number of sectors (including and immediately following
  * the specified sector) that are known to be in the same
  * allocated/unallocated state.
  *
  * 'nb_sectors' is the max value 'pnum' should be set to.  If nb_sectors goes
- * beyond the end of the disk image it will be clamped.
+ * beyond the end of the disk image it will be clamped; if 'pnum' is set to
+ * the end of the image, then the returned value will include BDRV_BLOCK_EOF.
  *
  * If returned value is positive and BDRV_BLOCK_OFFSET_VALID bit is set, 'file'
  * points to the BDS which the sector range is allocated in.
@@ -1740,7 +1741,7 @@ static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
 
     if (sector_num >= total_sectors) {
         *pnum = 0;
-        return 0;
+        return BDRV_BLOCK_EOF;
     }
 
     n = total_sectors - sector_num;
@@ -1751,6 +1752,9 @@ static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
     if (!bs->drv->bdrv_co_get_block_status) {
         *pnum = nb_sectors;
         ret = BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED;
+        if (sector_num + nb_sectors == total_sectors) {
+            ret |= BDRV_BLOCK_EOF;
+        }
         if (bs->drv->protocol_name) {
             ret |= BDRV_BLOCK_OFFSET_VALID | (sector_num * BDRV_SECTOR_SIZE);
         }
@@ -1814,6 +1818,9 @@ static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
 
 out:
     bdrv_dec_in_flight(bs);
+    if (ret >= 0 && sector_num + *pnum == total_sectors) {
+        ret |= BDRV_BLOCK_EOF;
+    }
     return ret;
 }
 
diff --git a/include/block/block.h b/include/block/block.h
index 85e4be7..4c149ad 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -129,6 +129,7 @@ typedef struct HDGeometry {
  * BDRV_BLOCK_OFFSET_VALID: an associated offset exists for accessing raw data
  * BDRV_BLOCK_ALLOCATED: the content of the block is determined by this
  *                       layer (short for DATA || ZERO), set by block layer
+ * BDRV_BLOCK_EOF: the returned pnum covers through end of file for this layer
  *
  * Internal flag:
  * BDRV_BLOCK_RAW: used internally to indicate that the request was
@@ -157,6 +158,7 @@ typedef struct HDGeometry {
 #define BDRV_BLOCK_OFFSET_VALID 0x04
 #define BDRV_BLOCK_RAW          0x08
 #define BDRV_BLOCK_ALLOCATED    0x10
+#define BDRV_BLOCK_EOF          0x20
 #define BDRV_BLOCK_OFFSET_MASK  BDRV_SECTOR_MASK
 
 typedef QSIMPLEQ_HEAD(BlockReopenQueue, BlockReopenQueueEntry) BlockReopenQueue;
-- 
2.9.4
