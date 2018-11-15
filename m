Received: from eggs.gnu.org ([2001:4830:134:3::10]:53520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gN70g-0002EC-67
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 21:03:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gN70e-0005dq-9X
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 21:03:58 -0500
From: Eric Blake <eblake@redhat.com>
Date: Wed, 14 Nov 2018 20:03:25 -0600
Message-Id: <20181115020334.1189829-5-eblake@redhat.com>
In-Reply-To: <20181115020334.1189829-1-eblake@redhat.com>
References: <20181115020334.1189829-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 04/13] block: Removed unused sector-based
 blocking I/O
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Now that all callers of blocking I/O have been converted
to use our preferred byte-based bdrv_p{read,write}(), we can
delete the unused bdrv_{read,write}().

Note that the old byte-based code checked that callers passed values
for transactions that did not exceed 2G limits (to prevent scaling
the caller's input by the sector size from exceeding a signed 32-bit
length). We can double-check that the block layer does the same thing
for byte-based code, by noting that even though the newer signatures
allow a 64-bit length parameter, the block layer is actually
fragmenting things to honor both bl.max_transfer (0 if the driver
has no inherent limit, or has not been audited for 64-bit cleanness;
non-zero if the driver wants to enforce a particular cap) as well as
some sanity sizing, as follows:

- bdrv_merge_limits(): Uses the smaller cap of either driver (or leaves things
uncapped if both drivers enforce no cap)
- bdrv_co_do_copy_on_readv(): Caps things to 2G if driver did not request cap
- bdrv_aligned_preadv(): Caps things to 2G if driver did not request cap
- bdrv_co_do_pwrite_zeroes(): Caps things to MAX_BOUNCE_BUFFER if driver
did not request cap
- bdrv_aligned_pwritev(): Caps things to 2G if driver did not request cap

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

---
v2: Enhance commit message with audit results
---
 include/block/block.h |  4 ----
 block/io.c            | 48 ++++++++-----------------------------------
 2 files changed, 8 insertions(+), 44 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 7f5453b45b6..52b18373807 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -307,10 +307,6 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state,
                         BlockReopenQueue *queue, Error **errp);
 void bdrv_reopen_commit(BDRVReopenState *reopen_state);
 void bdrv_reopen_abort(BDRVReopenState *reopen_state);
-int bdrv_read(BdrvChild *child, int64_t sector_num,
-              uint8_t *buf, int nb_sectors);
-int bdrv_write(BdrvChild *child, int64_t sector_num,
-               const uint8_t *buf, int nb_sectors);
 int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
                        int bytes, BdrvRequestFlags flags);
 int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags);
diff --git a/block/io.c b/block/io.c
index bd9d688f8ba..39d4e7a3ae1 100644
--- a/block/io.c
+++ b/block/io.c
@@ -836,45 +836,6 @@ static int bdrv_prwv_co(BdrvChild *child, int64_t offset,
     return rwco.ret;
 }

-/*
- * Process a synchronous request using coroutines
- */
-static int bdrv_rw_co(BdrvChild *child, int64_t sector_num, uint8_t *buf,
-                      int nb_sectors, bool is_write, BdrvRequestFlags flags)
-{
-    QEMUIOVector qiov;
-    struct iovec iov = {
-        .iov_base = (void *)buf,
-        .iov_len = nb_sectors * BDRV_SECTOR_SIZE,
-    };
-
-    if (nb_sectors < 0 || nb_sectors > BDRV_REQUEST_MAX_SECTORS) {
-        return -EINVAL;
-    }
-
-    qemu_iovec_init_external(&qiov, &iov, 1);
-    return bdrv_prwv_co(child, sector_num << BDRV_SECTOR_BITS,
-                        &qiov, is_write, flags);
-}
-
-/* return < 0 if error. See bdrv_write() for the return codes */
-int bdrv_read(BdrvChild *child, int64_t sector_num,
-              uint8_t *buf, int nb_sectors)
-{
-    return bdrv_rw_co(child, sector_num, buf, nb_sectors, false, 0);
-}
-
-/* Return < 0 if error. Important errors are:
-  -EIO         generic I/O error (may happen for all errors)
-  -ENOMEDIUM   No media inserted.
-  -EINVAL      Invalid sector number or nb_sectors
-  -EACCES      Trying to write a read-only device
-*/
-int bdrv_write(BdrvChild *child, int64_t sector_num,
-               const uint8_t *buf, int nb_sectors)
-{
-    return bdrv_rw_co(child, sector_num, (uint8_t *)buf, nb_sectors, true, 0);
-}

 int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
                        int bytes, BdrvRequestFlags flags)
@@ -897,7 +858,7 @@ int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
  * flags are passed through to bdrv_pwrite_zeroes (e.g. BDRV_REQ_MAY_UNMAP,
  * BDRV_REQ_FUA).
  *
- * Returns < 0 on error, 0 on success. For error codes see bdrv_write().
+ * Returns < 0 on error, 0 on success. For error codes see bdrv_pwrite().
  */
 int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags)
 {
@@ -935,6 +896,7 @@ int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags)
     }
 }

+/* return < 0 if error. See bdrv_pwrite() for the return codes */
 int bdrv_preadv(BdrvChild *child, int64_t offset, QEMUIOVector *qiov)
 {
     int ret;
@@ -975,6 +937,12 @@ int bdrv_pwritev(BdrvChild *child, int64_t offset, QEMUIOVector *qiov)
     return qiov->size;
 }

+/* Return < 0 if error. Important errors are:
+  -EIO         generic I/O error (may happen for all errors)
+  -ENOMEDIUM   No media inserted.
+  -EINVAL      Invalid sector number or nb_sectors
+  -EACCES      Trying to write a read-only device
+*/
 int bdrv_pwrite(BdrvChild *child, int64_t offset, const void *buf, int bytes)
 {
     QEMUIOVector qiov;
-- 
2.17.2
