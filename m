Received: from eggs.gnu.org ([2001:4830:134:3::10]:37391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pB4-0002wg-JV
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:34:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pB3-0008Cc-I5
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:34:50 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 11 May 2017 16:32:51 +0200
Message-Id: <1494513181-7900-49-git-send-email-kwolf@redhat.com>
In-Reply-To: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
References: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 48/58] block: Update comments on BDRV_BLOCK_*
 meanings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

We had some conflicting documentation: a nice 8-way table that
described all possible combinations of DATA, ZERO, and
OFFSET_VALID, contrasted with text that implied that OFFSET_VALID
always meant raw data could be read directly.  Furthermore, the
text refers a lot to bs->file, even though the interface was
updated back in 67a0fd2a to let the driver pass back a specific
BDS (not necessarily bs->file).  As the 8-way table is the
intended semantics, simplify the rest of the text to get rid of
the confusion.

ALLOCATED is always set by the block layer for convenience (drivers
do not have to worry about it).  RAW is used only internally, but
by more than the raw driver.  Document these additional items on
the driver callback.

Suggested-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20170507000552.20847-4-eblake@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block.h     | 35 +++++++++++++++++++----------------
 include/block/block_int.h |  7 +++++++
 2 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 90932b4..9b355e9 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -121,29 +121,32 @@ typedef struct HDGeometry {
 #define BDRV_REQUEST_MAX_BYTES (BDRV_REQUEST_MAX_SECTORS << BDRV_SECTOR_BITS)
 
 /*
- * Allocation status flags
- * BDRV_BLOCK_DATA: data is read from a file returned by bdrv_get_block_status.
- * BDRV_BLOCK_ZERO: sectors read as zero
- * BDRV_BLOCK_OFFSET_VALID: sector stored as raw data in a file returned by
- *                          bdrv_get_block_status.
+ * Allocation status flags for bdrv_get_block_status() and friends.
+ *
+ * Public flags:
+ * BDRV_BLOCK_DATA: allocation for data at offset is tied to this layer
+ * BDRV_BLOCK_ZERO: offset reads as zero
+ * BDRV_BLOCK_OFFSET_VALID: an associated offset exists for accessing raw data
  * BDRV_BLOCK_ALLOCATED: the content of the block is determined by this
- *                       layer (as opposed to the backing file)
- * BDRV_BLOCK_RAW: used internally to indicate that the request
- *                 was answered by the raw driver and that one
- *                 should look in bs->file directly.
+ *                       layer (short for DATA || ZERO), set by block layer
  *
- * If BDRV_BLOCK_OFFSET_VALID is set, bits 9-62 represent the offset in
- * bs->file where sector data can be read from as raw data.
+ * Internal flag:
+ * BDRV_BLOCK_RAW: used internally to indicate that the request was
+ *                 answered by a passthrough driver such as raw and that the
+ *                 block layer should recompute the answer from bs->file.
  *
- * DATA == 0 && ZERO == 0 means that data is read from backing_hd if present.
+ * If BDRV_BLOCK_OFFSET_VALID is set, bits 9-62 (BDRV_BLOCK_OFFSET_MASK)
+ * represent the offset in the returned BDS that is allocated for the
+ * corresponding raw data; however, whether that offset actually contains
+ * data also depends on BDRV_BLOCK_DATA and BDRV_BLOCK_ZERO, as follows:
  *
  * DATA ZERO OFFSET_VALID
- *  t    t        t       sectors read as zero, bs->file is zero at offset
- *  t    f        t       sectors read as valid from bs->file at offset
- *  f    t        t       sectors preallocated, read as zero, bs->file not
+ *  t    t        t       sectors read as zero, returned file is zero at offset
+ *  t    f        t       sectors read as valid from file at offset
+ *  f    t        t       sectors preallocated, read as zero, returned file not
  *                        necessarily zero at offset
  *  f    f        t       sectors preallocated but read from backing_hd,
- *                        bs->file contains garbage at offset
+ *                        returned file contains garbage at offset
  *  t    t        f       sectors preallocated, read as zero, unknown offset
  *  t    f        f       sectors read from unknown file or offset
  *  f    t        f       not allocated or unknown offset, read as zero
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 5750a44..8d3724c 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -165,6 +165,13 @@ struct BlockDriver {
         int64_t offset, int count, BdrvRequestFlags flags);
     int coroutine_fn (*bdrv_co_pdiscard)(BlockDriverState *bs,
         int64_t offset, int count);
+
+    /*
+     * Building block for bdrv_block_status[_above]. The driver should
+     * answer only according to the current layer, and should not
+     * set BDRV_BLOCK_ALLOCATED, but may set BDRV_BLOCK_RAW.  See block.h
+     * for the meaning of _DATA, _ZERO, and _OFFSET_VALID.
+     */
     int64_t coroutine_fn (*bdrv_co_get_block_status)(BlockDriverState *bs,
         int64_t sector_num, int nb_sectors, int *pnum,
         BlockDriverState **file);
-- 
1.8.3.1
