Received: from eggs.gnu.org ([2001:4830:134:3::10]:48845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dQZUF-0005jO-3R
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:28:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dQZUD-0001KP-Te
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:27:59 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 29 Jun 2017 15:27:41 +0200
Message-Id: <20170629132749.997-4-pbonzini@redhat.com>
In-Reply-To: <20170629132749.997-1-pbonzini@redhat.com>
References: <20170629132749.997-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 03/11] vdi: make it thread-safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, qemu-block@nongnu.org, kwolf@redhat.com

The VirtualBox driver is using a mutex to order all allocating writes,
but it is not protecting accesses to the bitmap because they implicitly
happen under the AioContext mutex.  Change this to use a CoRwlock
explicitly.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/vdi.c | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/block/vdi.c b/block/vdi.c
index 79af47763b..080e1562e3 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -172,7 +172,7 @@ typedef struct {
     /* VDI header (converted to host endianness). */
     VdiHeader header;
 
-    CoMutex write_lock;
+    CoRwlock bmap_lock;
 
     Error *migration_blocker;
 } BDRVVdiState;
@@ -485,7 +485,7 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail_free_bmap;
     }
 
-    qemu_co_mutex_init(&s->write_lock);
+    qemu_co_rwlock_init(&s->bmap_lock);
 
     return 0;
 
@@ -557,7 +557,9 @@ vdi_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
                n_bytes, offset);
 
         /* prepare next AIO request */
+        qemu_co_rwlock_rdlock(&s->bmap_lock);
         bmap_entry = le32_to_cpu(s->bmap[block_index]);
+        qemu_co_rwlock_unlock(&s->bmap_lock);
         if (!VDI_IS_ALLOCATED(bmap_entry)) {
             /* Block not allocated, return zeros, no need to wait. */
             qemu_iovec_memset(qiov, bytes_done, 0, n_bytes);
@@ -595,6 +597,7 @@ vdi_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
     uint32_t block_index;
     uint32_t offset_in_block;
     uint32_t n_bytes;
+    uint64_t data_offset;
     uint32_t bmap_first = VDI_UNALLOCATED;
     uint32_t bmap_last = VDI_UNALLOCATED;
     uint8_t *block = NULL;
@@ -614,10 +617,19 @@ vdi_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
                n_bytes, offset);
 
         /* prepare next AIO request */
+        qemu_co_rwlock_rdlock(&s->bmap_lock);
         bmap_entry = le32_to_cpu(s->bmap[block_index]);
         if (!VDI_IS_ALLOCATED(bmap_entry)) {
             /* Allocate new block and write to it. */
             uint64_t data_offset;
+            qemu_co_rwlock_upgrade(&s->bmap_lock);
+            bmap_entry = le32_to_cpu(s->bmap[block_index]);
+            if (VDI_IS_ALLOCATED(bmap_entry)) {
+                /* A concurrent allocation did the work for us.  */
+                qemu_co_rwlock_downgrade(&s->bmap_lock);
+                goto nonallocating_write;
+            }
+
             bmap_entry = s->header.blocks_allocated;
             s->bmap[block_index] = cpu_to_le32(bmap_entry);
             s->header.blocks_allocated++;
@@ -635,30 +647,18 @@ vdi_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
             memset(block + offset_in_block + n_bytes, 0,
                    s->block_size - n_bytes - offset_in_block);
 
-            /* Note that this coroutine does not yield anywhere from reading the
-             * bmap entry until here, so in regards to all the coroutines trying
-             * to write to this cluster, the one doing the allocation will
-             * always be the first to try to acquire the lock.
-             * Therefore, it is also the first that will actually be able to
-             * acquire the lock and thus the padded cluster is written before
-             * the other coroutines can write to the affected area. */
-            qemu_co_mutex_lock(&s->write_lock);
+            /* Write the new block under CoRwLock write-side protection,
+             * so this full-cluster write does not overlap a partial write
+             * of the same cluster, issued from the "else" branch.
+             */
             ret = bdrv_pwrite(bs->file, data_offset, block, s->block_size);
-            qemu_co_mutex_unlock(&s->write_lock);
+            qemu_co_rwlock_unlock(&s->bmap_lock);
         } else {
-            uint64_t data_offset = s->header.offset_data +
-                                   (uint64_t)bmap_entry * s->block_size +
-                                   offset_in_block;
-            qemu_co_mutex_lock(&s->write_lock);
-            /* This lock is only used to make sure the following write operation
-             * is executed after the write issued by the coroutine allocating
-             * this cluster, therefore we do not need to keep it locked.
-             * As stated above, the allocating coroutine will always try to lock
-             * the mutex before all the other concurrent accesses to that
-             * cluster, therefore at this point we can be absolutely certain
-             * that that write operation has returned (there may be other writes
-             * in flight, but they do not concern this very operation). */
-            qemu_co_mutex_unlock(&s->write_lock);
+nonallocating_write:
+            data_offset = s->header.offset_data +
+                           (uint64_t)bmap_entry * s->block_size +
+                           offset_in_block;
+            qemu_co_rwlock_unlock(&s->bmap_lock);
 
             qemu_iovec_reset(&local_qiov);
             qemu_iovec_concat(&local_qiov, qiov, bytes_done, n_bytes);
-- 
2.13.0
