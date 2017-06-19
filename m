Received: from eggs.gnu.org ([2001:4830:134:3::10]:56873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dMwuz-0008RR-Ow
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 09:40:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dMwuw-0001dk-Ix
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 09:40:37 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Mon, 19 Jun 2017 16:40:06 +0300
Message-Id: <211edb0098536dd65a1c4c966f23852884428b3b.1497879398.git.berto@igalia.com>
In-Reply-To: <cover.1497879398.git.berto@igalia.com>
References: <cover.1497879398.git.berto@igalia.com>
In-Reply-To: <cover.1497879398.git.berto@igalia.com>
References: <cover.1497879398.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v4 5/7] qcow2: Allow reading both COW regions
 with only one request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, "Denis V . Lunev" <den@openvz.org>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>

Reading both COW regions requires two separate requests, but it's
perfectly possible to merge them and perform only one. This generally
improves performance, particularly on rotating disk drives. The
downside is that the data in the middle region is read but discarded.

This patch takes a conservative approach and only merges reads when
the size of the middle region is <= 16KB.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2-cluster.c | 51 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 3c9ace8a96..20fb531932 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -777,20 +777,38 @@ static int perform_cow(BlockDriverState *bs, QCowL2Meta *m)
     Qcow2COWRegion *start = &m->cow_start;
     Qcow2COWRegion *end = &m->cow_end;
     unsigned buffer_size;
+    unsigned data_bytes = end->offset - (start->offset + start->nb_bytes);
+    bool merge_reads;
     uint8_t *start_buffer, *end_buffer;
     int ret;
 
     assert(start->nb_bytes <= UINT_MAX - end->nb_bytes);
+    assert(start->nb_bytes + end->nb_bytes <= UINT_MAX - data_bytes);
+    assert(start->offset + start->nb_bytes <= end->offset);
 
     if (start->nb_bytes == 0 && end->nb_bytes == 0) {
         return 0;
     }
 
-    /* Reserve a buffer large enough to store the data from both the
-     * start and end COW regions. Add some padding in the middle if
-     * necessary to make sure that the end region is optimally aligned */
-    buffer_size = QEMU_ALIGN_UP(start->nb_bytes, bdrv_opt_mem_align(bs)) +
-        end->nb_bytes;
+    /* If we have to read both the start and end COW regions and the
+     * middle region is not too large then perform just one read
+     * operation */
+    merge_reads = start->nb_bytes && end->nb_bytes && data_bytes <= 16384;
+    if (merge_reads) {
+        buffer_size = start->nb_bytes + data_bytes + end->nb_bytes;
+    } else {
+        /* If we have to do two reads, add some padding in the middle
+         * if necessary to make sure that the end region is optimally
+         * aligned. */
+        size_t align = bdrv_opt_mem_align(bs);
+        assert(align > 0 && align <= UINT_MAX);
+        assert(QEMU_ALIGN_UP(start->nb_bytes, align) <=
+               UINT_MAX - end->nb_bytes);
+        buffer_size = QEMU_ALIGN_UP(start->nb_bytes, align) + end->nb_bytes;
+    }
+
+    /* Reserve a buffer large enough to store all the data that we're
+     * going to read */
     start_buffer = qemu_try_blockalign(bs, buffer_size);
     if (start_buffer == NULL) {
         return -ENOMEM;
@@ -799,15 +817,22 @@ static int perform_cow(BlockDriverState *bs, QCowL2Meta *m)
     end_buffer = start_buffer + buffer_size - end->nb_bytes;
 
     qemu_co_mutex_unlock(&s->lock);
-    /* First we read the existing data from both COW regions */
-    ret = do_perform_cow_read(bs, m->offset, start->offset,
-                              start_buffer, start->nb_bytes);
-    if (ret < 0) {
-        goto fail;
-    }
+    /* First we read the existing data from both COW regions. We
+     * either read the whole region in one go, or the start and end
+     * regions separately. */
+    if (merge_reads) {
+        ret = do_perform_cow_read(bs, m->offset, start->offset,
+                                  start_buffer, buffer_size);
+    } else {
+        ret = do_perform_cow_read(bs, m->offset, start->offset,
+                                  start_buffer, start->nb_bytes);
+        if (ret < 0) {
+            goto fail;
+        }
 
-    ret = do_perform_cow_read(bs, m->offset, end->offset,
-                              end_buffer, end->nb_bytes);
+        ret = do_perform_cow_read(bs, m->offset, end->offset,
+                                  end_buffer, end->nb_bytes);
+    }
     if (ret < 0) {
         goto fail;
     }
-- 
2.11.0
