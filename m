Received: from eggs.gnu.org ([2001:4830:134:3::10]:46599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVzVP-0003kE-Ac
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:15:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVzVO-0003ou-48
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:15:35 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri, 14 Jul 2017 07:14:44 -0500
Message-Id: <20170714121457.10322-8-eblake@redhat.com>
In-Reply-To: <20170714121457.10322-1-eblake@redhat.com>
References: <20170714121457.10322-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 07/20] iscsi: Switch to
 .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Update the iscsi driver accordingly.  In this case,
it is handy to teach iscsi_co_block_status() to handle a NULL file
parameter, even though the block layer passes a non-NULL value,
because we also call the function directly.  For now, there are
no optimizations done based on the mapping flag.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: rebase to mapping parameter
---
 block/iscsi.c | 54 ++++++++++++++++++++++++++----------------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 682a316..a848817 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -680,9 +680,10 @@ out_unlock:



-static int64_t coroutine_fn iscsi_co_get_block_status(BlockDriverState *bs,
-                                                  int64_t sector_num,
-                                                  int nb_sectors, int *pnum,
+static int64_t coroutine_fn iscsi_co_block_status(BlockDriverState *bs,
+                                                  bool mapping,
+                                                  int64_t offset,
+                                                  int64_t bytes, int64_t *pnum,
                                                   BlockDriverState **file)
 {
     IscsiLun *iscsilun = bs->opaque;
@@ -693,15 +694,15 @@ static int64_t coroutine_fn iscsi_co_get_block_status(BlockDriverState *bs,

     iscsi_co_init_iscsitask(iscsilun, &iTask);

-    if (!is_sector_request_lun_aligned(sector_num, nb_sectors, iscsilun)) {
+    if (!is_byte_request_lun_aligned(offset, bytes, iscsilun)) {
         ret = -EINVAL;
         goto out;
     }

     /* default to all sectors allocated */
     ret = BDRV_BLOCK_DATA;
-    ret |= (sector_num << BDRV_SECTOR_BITS) | BDRV_BLOCK_OFFSET_VALID;
-    *pnum = nb_sectors;
+    ret |= (offset & BDRV_BLOCK_OFFSET_MASK) | BDRV_BLOCK_OFFSET_VALID;
+    *pnum = bytes;

     /* LUN does not support logical block provisioning */
     if (!iscsilun->lbpme) {
@@ -711,7 +712,7 @@ static int64_t coroutine_fn iscsi_co_get_block_status(BlockDriverState *bs,
     qemu_mutex_lock(&iscsilun->mutex);
 retry:
     if (iscsi_get_lba_status_task(iscsilun->iscsi, iscsilun->lun,
-                                  sector_qemu2lun(sector_num, iscsilun),
+                                  offset / iscsilun->block_size,
                                   8 + 16, iscsi_co_generic_cb,
                                   &iTask) == NULL) {
         ret = -ENOMEM;
@@ -750,12 +751,12 @@ retry:

     lbasd = &lbas->descriptors[0];

-    if (sector_qemu2lun(sector_num, iscsilun) != lbasd->lba) {
+    if (offset / iscsilun->block_size != lbasd->lba) {
         ret = -EIO;
         goto out_unlock;
     }

-    *pnum = sector_lun2qemu(lbasd->num_blocks, iscsilun);
+    *pnum = lbasd->num_blocks * iscsilun->block_size;

     if (lbasd->provisioning == SCSI_PROVISIONING_TYPE_DEALLOCATED ||
         lbasd->provisioning == SCSI_PROVISIONING_TYPE_ANCHORED) {
@@ -766,15 +767,13 @@ retry:
     }

     if (ret & BDRV_BLOCK_ZERO) {
-        iscsi_allocmap_set_unallocated(iscsilun, sector_num * BDRV_SECTOR_SIZE,
-                                       *pnum * BDRV_SECTOR_SIZE);
+        iscsi_allocmap_set_unallocated(iscsilun, offset, *pnum);
     } else {
-        iscsi_allocmap_set_allocated(iscsilun, sector_num * BDRV_SECTOR_SIZE,
-                                     *pnum * BDRV_SECTOR_SIZE);
+        iscsi_allocmap_set_allocated(iscsilun, offset, *pnum);
     }

-    if (*pnum > nb_sectors) {
-        *pnum = nb_sectors;
+    if (*pnum > bytes) {
+        *pnum = bytes;
     }
 out_unlock:
     qemu_mutex_unlock(&iscsilun->mutex);
@@ -782,7 +781,7 @@ out:
     if (iTask.task != NULL) {
         scsi_free_scsi_task(iTask.task);
     }
-    if (ret > 0 && ret & BDRV_BLOCK_OFFSET_VALID) {
+    if (ret > 0 && ret & BDRV_BLOCK_OFFSET_VALID && file) {
         *file = bs;
     }
     return ret;
@@ -821,25 +820,24 @@ static int coroutine_fn iscsi_co_readv(BlockDriverState *bs,
                                  nb_sectors * BDRV_SECTOR_SIZE) &&
         !iscsi_allocmap_is_allocated(iscsilun, sector_num * BDRV_SECTOR_SIZE,
                                      nb_sectors * BDRV_SECTOR_SIZE)) {
-        int pnum;
-        BlockDriverState *file;
+        int64_t pnum;
         /* check the block status from the beginning of the cluster
          * containing the start sector */
-        int cluster_sectors = iscsilun->cluster_size >> BDRV_SECTOR_BITS;
-        int head;
+        int64_t head;
         int64_t ret;

-        assert(cluster_sectors);
-        head = sector_num % cluster_sectors;
-        ret = iscsi_co_get_block_status(bs, sector_num - head,
-                                        BDRV_REQUEST_MAX_SECTORS, &pnum,
-                                        &file);
+        assert(iscsilun->cluster_size);
+        head = (sector_num * BDRV_SECTOR_SIZE) % iscsilun->cluster_size;
+        ret = iscsi_co_block_status(bs, false,
+                                    sector_num * BDRV_SECTOR_SIZE - head,
+                                    BDRV_REQUEST_MAX_BYTES, &pnum, NULL);
         if (ret < 0) {
             return ret;
         }
         /* if the whole request falls into an unallocated area we can avoid
          * reading and directly return zeroes instead */
-        if (ret & BDRV_BLOCK_ZERO && pnum >= nb_sectors + head) {
+        if (ret & BDRV_BLOCK_ZERO &&
+            pnum >= nb_sectors * BDRV_SECTOR_SIZE + head) {
             qemu_iovec_memset(iov, 0, 0x00, iov->size);
             return 0;
         }
@@ -2225,7 +2223,7 @@ static BlockDriver bdrv_iscsi = {
     .bdrv_truncate   = iscsi_truncate,
     .bdrv_refresh_limits = iscsi_refresh_limits,

-    .bdrv_co_get_block_status = iscsi_co_get_block_status,
+    .bdrv_co_block_status  = iscsi_co_block_status,
     .bdrv_co_pdiscard      = iscsi_co_pdiscard,
     .bdrv_co_pwrite_zeroes = iscsi_co_pwrite_zeroes,
     .bdrv_co_readv         = iscsi_co_readv,
@@ -2260,7 +2258,7 @@ static BlockDriver bdrv_iser = {
     .bdrv_truncate   = iscsi_truncate,
     .bdrv_refresh_limits = iscsi_refresh_limits,

-    .bdrv_co_get_block_status = iscsi_co_get_block_status,
+    .bdrv_co_block_status  = iscsi_co_block_status,
     .bdrv_co_pdiscard      = iscsi_co_pdiscard,
     .bdrv_co_pwrite_zeroes = iscsi_co_pwrite_zeroes,
     .bdrv_co_readv         = iscsi_co_readv,
-- 
2.9.4
