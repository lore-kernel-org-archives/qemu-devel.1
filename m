Received: from eggs.gnu.org ([2001:4830:134:3::10]:48324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBPDa-0005xI-Lp
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 14:32:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBPDZ-0004QV-FY
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 14:32:38 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 25 Apr 2018 13:32:17 -0500
Message-Id: <20180425183223.580566-3-eblake@redhat.com>
In-Reply-To: <20180425183223.580566-1-eblake@redhat.com>
References: <20180425183223.580566-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 2/8] qcow: Switch get_cluster_offset to be
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:qcow" <qemu-block@nongnu.org>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Make the change for the internal helper function
get_cluster_offset(), by changing n_start and n_end to by byte
offsets rather than sector indices within the cluster being
allocated.

A later patch will then switch the qcow driver as a whole over
to byte-based operation.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/qcow.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/block/qcow.c b/block/qcow.c
index dd042b8ddbe..32730a8dd91 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -345,8 +345,8 @@ static int qcow_reopen_prepare(BDRVReopenState *state,
  *
  * 0 to not allocate.
  *
- * 1 to allocate a normal cluster (for sector indexes 'n_start' to
- * 'n_end')
+ * 1 to allocate a normal cluster (for byte offsets 'n_start' to
+ * 'n_end' within the cluster)
  *
  * 2 to allocate a compressed cluster of size
  * 'compressed_size'. 'compressed_size' must be > 0 and <
@@ -442,7 +442,7 @@ static int get_cluster_offset(BlockDriverState *bs,
         BLKDBG_EVENT(bs->file, BLKDBG_CLUSTER_ALLOC);
         /* allocate a new cluster */
         if ((cluster_offset & QCOW_OFLAG_COMPRESSED) &&
-            (n_end - n_start) < s->cluster_sectors) {
+            (n_end - n_start) < s->cluster_size) {
             /* if the cluster is already compressed, we must
                decompress it in the case it is not completely
                overwritten */
@@ -480,16 +480,15 @@ static int get_cluster_offset(BlockDriverState *bs,
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
@@ -497,8 +496,9 @@ static int get_cluster_offset(BlockDriverState *bs,
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
@@ -758,8 +758,8 @@ static coroutine_fn int qcow_co_writev(BlockDriverState *bs, int64_t sector_num,
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
2.14.3
