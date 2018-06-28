Received: from eggs.gnu.org ([2001:4830:134:3::10]:53166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYcGm-0001k9-8a
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 15:07:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYcGe-0001Uo-KV
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 15:07:52 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 28 Jun 2018 14:07:18 -0500
Message-Id: <20180628190723.276458-2-eblake@redhat.com>
In-Reply-To: <20180628190723.276458-1-eblake@redhat.com>
References: <20180628190723.276458-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v7 1/6] qcow2: Prefer byte-based calls into
 bs->file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, berto@igalia.com

We had only a few sector-based stragglers left; convert them to use
our preferred byte-based accesses.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>

---
v5: commit message tweak
v2: indentation fix
---
 block/qcow2-cluster.c  | 5 ++---
 block/qcow2-refcount.c | 6 +++---
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 0d74584c9b4..4701fbc7a12 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1616,13 +1616,12 @@ int qcow2_decompress_cluster(BlockDriverState *bs, uint64_t cluster_offset)
         }

         BLKDBG_EVENT(bs->file, BLKDBG_READ_COMPRESSED);
-        ret = bdrv_read(bs->file, coffset >> 9, s->cluster_data,
-                        nb_csectors);
+        ret = bdrv_pread(bs->file, coffset, s->cluster_data, csize);
         if (ret < 0) {
             return ret;
         }
         if (decompress_buffer(s->cluster_cache, s->cluster_size,
-                              s->cluster_data + sector_offset, csize) < 0) {
+                              s->cluster_data, csize) < 0) {
             return -EIO;
         }
         s->cluster_cache_offset = coffset;
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 18c729aa276..20e6f2e29fc 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -2368,8 +2368,8 @@ write_refblocks:
         on_disk_refblock = (void *)((char *) *refcount_table +
                                     refblock_index * s->cluster_size);

-        ret = bdrv_write(bs->file, refblock_offset / BDRV_SECTOR_SIZE,
-                         on_disk_refblock, s->cluster_sectors);
+        ret = bdrv_pwrite(bs->file, refblock_offset, on_disk_refblock,
+                          s->cluster_size);
         if (ret < 0) {
             fprintf(stderr, "ERROR writing refblock: %s\n", strerror(-ret));
             goto fail;
@@ -2591,7 +2591,7 @@ fail:
  * - 0 if writing to this offset will not affect the mentioned metadata
  * - a positive QCow2MetadataOverlap value indicating one overlapping section
  * - a negative value (-errno) indicating an error while performing a check,
- *   e.g. when bdrv_read failed on QCOW2_OL_INACTIVE_L2
+ *   e.g. when bdrv_pread failed on QCOW2_OL_INACTIVE_L2
  */
 int qcow2_check_metadata_overlap(BlockDriverState *bs, int ign, int64_t offset,
                                  int64_t size)
-- 
2.14.4
