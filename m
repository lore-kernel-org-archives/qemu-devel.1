Received: from eggs.gnu.org ([2001:4830:134:3::10]:47339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxmi-0002Y9-HP
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:13:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxmh-0007WT-Gy
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:13:12 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 11 Jul 2017 18:08:11 +0200
Message-Id: <20170711160814.20941-83-mreitz@redhat.com>
In-Reply-To: <20170711160814.20941-1-mreitz@redhat.com>
References: <20170711160814.20941-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 82/85] block/qcow2: Rename "fail_block" to just
 "fail"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

Now alloc_refcount_block() only contains a single fail label, so it
makes more sense to just name it "fail" instead of "fail_block".

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20170613202107.10125-14-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-refcount.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 082b5de..1aca645 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -381,7 +381,7 @@ static int alloc_refcount_block(BlockDriverState *bs,
         ret = qcow2_cache_get_empty(bs, s->refcount_block_cache, new_block,
                                     refcount_block);
         if (ret < 0) {
-            goto fail_block;
+            goto fail;
         }
 
         memset(*refcount_block, 0, s->cluster_size);
@@ -396,12 +396,12 @@ static int alloc_refcount_block(BlockDriverState *bs,
         ret = update_refcount(bs, new_block, s->cluster_size, 1, false,
                               QCOW2_DISCARD_NEVER);
         if (ret < 0) {
-            goto fail_block;
+            goto fail;
         }
 
         ret = qcow2_cache_flush(bs, s->refcount_block_cache);
         if (ret < 0) {
-            goto fail_block;
+            goto fail;
         }
 
         /* Initialize the new refcount block only after updating its refcount,
@@ -409,7 +409,7 @@ static int alloc_refcount_block(BlockDriverState *bs,
         ret = qcow2_cache_get_empty(bs, s->refcount_block_cache, new_block,
                                     refcount_block);
         if (ret < 0) {
-            goto fail_block;
+            goto fail;
         }
 
         memset(*refcount_block, 0, s->cluster_size);
@@ -420,7 +420,7 @@ static int alloc_refcount_block(BlockDriverState *bs,
     qcow2_cache_entry_mark_dirty(bs, s->refcount_block_cache, *refcount_block);
     ret = qcow2_cache_flush(bs, s->refcount_block_cache);
     if (ret < 0) {
-        goto fail_block;
+        goto fail;
     }
 
     /* If the refcount table is big enough, just hook the block up there */
@@ -431,7 +431,7 @@ static int alloc_refcount_block(BlockDriverState *bs,
             s->refcount_table_offset + refcount_table_index * sizeof(uint64_t),
             &data64, sizeof(data64));
         if (ret < 0) {
-            goto fail_block;
+            goto fail;
         }
 
         s->refcount_table[refcount_table_index] = new_block;
@@ -495,7 +495,7 @@ static int alloc_refcount_block(BlockDriverState *bs,
      * allocated metadata. Make the caller search some new space. */
     return -EAGAIN;
 
-fail_block:
+fail:
     if (*refcount_block != NULL) {
         qcow2_cache_put(bs, s->refcount_block_cache, refcount_block);
     }
-- 
2.9.4
