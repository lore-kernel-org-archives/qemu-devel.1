Received: from eggs.gnu.org ([2001:4830:134:3::10]:40950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYdKI-0007tX-Rd
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:15:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYdKH-0007ZK-Kt
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:15:34 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 28 Jun 2018 15:15:19 -0500
Message-Id: <20180628201525.281787-3-eblake@redhat.com>
In-Reply-To: <20180628201525.281787-1-eblake@redhat.com>
References: <20180628201525.281787-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 2/8] qcow: Switch get_cluster_offset to be
 byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jcody@redhat.com, kwolf@redhat.com, famz@redhat.com, stefanha@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

We are gradually moving away from sector-based interfaces, towards
byte-based.  Make the change for the internal helper function
get_cluster_offset(), by changing n_start and n_end to be byte
offsets rather than sector indices within the cluster being
allocated.  However, assert that these values are still
sector-aligned (at least qcrypto_block_encrypt() still wants that).
For now we get that alignment for free because we still use
sector-based driver callbacks.

A later patch will then switch the qcow driver as a whole over
to byte-based operation; but will still leave things at sector
alignments as it is not worth auditing the qcow image format
to worry about sub-sector requests.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>

---
v3: commit message typo fix [Jeff]
v2: assert sector alignment [Max]
---
 block/qcow.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/block/qcow.c b/block/qcow.c
index 5532731b9fc..7c3dc8b3504 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -346,8 +346,8 @@ static int qcow_reopen_prepare(BDRVReopenState *state,
  *
  * 0 to not allocate.
  *
- * 1 to allocate a normal cluster (for sector indexes 'n_start' to
- * 'n_end')
+ * 1 to allocate a normal cluster (for sector-aligned byte offsets 'n_start'
+ * to 'n_end' within the cluster)
  *
  * 2 to allocate a compressed cluster of size
  * 'compressed_size'. 'compressed_size' must be > 0 and <
@@ -441,9 +441,10 @@ static int get_cluster_offset(BlockDriverState *bs,
         if (!allocate)
             return 0;
         BLKDBG_EVENT(bs->file, BLKDBG_CLUSTER_ALLOC);
+        assert(QEMU_IS_ALIGNED(n_start | n_end, BDRV_SECTOR_SIZE));
         /* allocate a new cluster */
         if ((cluster_offset & QCOW_OFLAG_COMPRESSED) &&
-            (n_end - n_start) < s->cluster_sectors) {
+            (n_end - n_start) < s->cluster_size) {
             /* if the cluster is already compressed, we must
                decompress it in the case it is not completely
                overwritten */
@@ -481,16 +482,15 @@ static int get_cluster_offset(BlockDriverState *bs,
                 /* if encrypted, we must initialize the cluster
                    content which won't be written */
                 if (bs->encrypted &&
-                    (n_end - n_start) < s->cluster_sectors) {
-                    uint64_t start_sect;
+                    (n_end - n_start) < s->cluster_size) {
+                    uint64_t start_offset;
                     assert(s->crypto);
-                    start_sect = (offset & ~(s->cluster_size - 1)) >> 9;
-                    for(i = 0; i < s->cluster_sectors; i++) {
+                    start_offset = offset & ~(s->cluster_size - 1);
+                    for (i = 0; i < s->cluster_size; i += BDRV_SECTOR_SIZE) {
                         if (i < n_start || i >= n_end) {
-                            memset(s->cluster_data, 0x00, 512);
+                            memset(s->cluster_data, 0x00, BDRV_SECTOR_SIZE);
                             if (qcrypto_block_encrypt(s->crypto,
-                                                      (start_sect + i) *
-                                                      BDRV_SECTOR_SIZE,
+                                                      start_offset + i,
                                                       s->cluster_data,
                                                       BDRV_SECTOR_SIZE,
                                                       NULL) < 0) {
@@ -498,8 +498,9 @@ static int get_cluster_offset(BlockDriverState *bs,
                             }
                             BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
                             ret = bdrv_pwrite(bs->file,
-                                              cluster_offset + i * 512,
-                                              s->cluster_data, 512);
+                                              cluster_offset + i,
+                                              s->cluster_data,
+                                              BDRV_SECTOR_SIZE);
                             if (ret < 0) {
                                 return ret;
                             }
@@ -759,8 +760,8 @@ static coroutine_fn int qcow_co_writev(BlockDriverState *bs, int64_t sector_num,
             n = nb_sectors;
         }
         ret = get_cluster_offset(bs, sector_num << 9, 1, 0,
-                                 index_in_cluster,
-                                 index_in_cluster + n, &cluster_offset);
+                                 index_in_cluster << 9,
+                                 (index_in_cluster + n) << 9, &cluster_offset);
         if (ret < 0) {
             break;
         }
-- 
2.14.4
