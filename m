Received: from eggs.gnu.org ([2001:4830:134:3::10]:33208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKkm-0000sy-Hq
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKkk-0006ak-0b
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:20 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 17:18:45 +0100
Message-Id: <20180309161933.8168-9-kwolf@redhat.com>
In-Reply-To: <20180309161933.8168-1-kwolf@redhat.com>
References: <20180309161933.8168-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 08/56] qcow2: Generalize validate_table_offset()
 into qcow2_validate_table()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Alberto Garcia <berto@igalia.com>

This function checks that the offset and size of a table are valid.

While the offset checks are fine, the size check is too generic, since
it only verifies that the total size in bytes fits in a 64-bit
integer. In practice all tables used in qcow2 have much smaller size
limits, so the size needs to be checked again for each table using its
actual limit.

This patch generalizes this function by allowing the caller to specify
the maximum size for that table. In addition to that it allows passing
an Error variable.

The function is also renamed and made public since we're going to use
it in other parts of the code.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.h              | 10 +++---
 block/qcow2.c              | 77 ++++++++++++++++++----------------------------
 tests/qemu-iotests/080.out | 16 +++++-----
 3 files changed, 43 insertions(+), 60 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 965846f7af..ccb92a9696 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -485,11 +485,6 @@ static inline int64_t qcow2_vm_state_offset(BDRVQcow2State *s)
     return (int64_t)s->l1_vm_state_index << (s->cluster_bits + s->l2_bits);
 }
 
-static inline uint64_t qcow2_max_refcount_clusters(BDRVQcow2State *s)
-{
-    return QCOW_MAX_REFTABLE_SIZE >> s->cluster_bits;
-}
-
 static inline QCow2ClusterType qcow2_get_cluster_type(uint64_t l2_entry)
 {
     if (l2_entry & QCOW_OFLAG_COMPRESSED) {
@@ -547,6 +542,11 @@ void qcow2_signal_corruption(BlockDriverState *bs, bool fatal, int64_t offset,
                              int64_t size, const char *message_format, ...)
                              GCC_FMT_ATTR(5, 6);
 
+int qcow2_validate_table(BlockDriverState *bs, uint64_t offset,
+                         uint64_t entries, size_t entry_len,
+                         int64_t max_size_bytes, const char *table_name,
+                         Error **errp);
+
 /* qcow2-refcount.c functions */
 int qcow2_refcount_init(BlockDriverState *bs);
 void qcow2_refcount_close(BlockDriverState *bs);
diff --git a/block/qcow2.c b/block/qcow2.c
index 9fb00f2373..369e374a9b 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -573,26 +573,23 @@ static int coroutine_fn qcow2_co_check(BlockDriverState *bs,
     return ret;
 }
 
-static int validate_table_offset(BlockDriverState *bs, uint64_t offset,
-                                 uint64_t entries, size_t entry_len)
+int qcow2_validate_table(BlockDriverState *bs, uint64_t offset,
+                         uint64_t entries, size_t entry_len,
+                         int64_t max_size_bytes, const char *table_name,
+                         Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
-    uint64_t size;
 
-    /* Use signed INT64_MAX as the maximum even for uint64_t header fields,
-     * because values will be passed to qemu functions taking int64_t. */
-    if (entries > INT64_MAX / entry_len) {
-        return -EINVAL;
-    }
-
-    size = entries * entry_len;
-
-    if (INT64_MAX - size < offset) {
-        return -EINVAL;
+    if (entries > max_size_bytes / entry_len) {
+        error_setg(errp, "%s too large", table_name);
+        return -EFBIG;
     }
 
-    /* Tables must be cluster aligned */
-    if (offset_into_cluster(s, offset) != 0) {
+    /* Use signed INT64_MAX as the maximum even for uint64_t header fields,
+     * because values will be passed to qemu functions taking int64_t. */
+    if ((INT64_MAX - entries * entry_len < offset) ||
+        (offset_into_cluster(s, offset) != 0)) {
+        error_setg(errp, "%s offset invalid", table_name);
         return -EINVAL;
     }
 
@@ -1323,47 +1320,42 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
     s->refcount_table_size =
         header.refcount_table_clusters << (s->cluster_bits - 3);
 
-    if (header.refcount_table_clusters > qcow2_max_refcount_clusters(s)) {
-        error_setg(errp, "Reference count table too large");
-        ret = -EINVAL;
-        goto fail;
-    }
-
     if (header.refcount_table_clusters == 0 && !(flags & BDRV_O_CHECK)) {
         error_setg(errp, "Image does not contain a reference count table");
         ret = -EINVAL;
         goto fail;
     }
 
-    ret = validate_table_offset(bs, s->refcount_table_offset,
-                                s->refcount_table_size, sizeof(uint64_t));
+    ret = qcow2_validate_table(bs, s->refcount_table_offset,
+                               header.refcount_table_clusters,
+                               s->cluster_size, QCOW_MAX_REFTABLE_SIZE,
+                               "Reference count table", errp);
     if (ret < 0) {
-        error_setg(errp, "Invalid reference count table offset");
         goto fail;
     }
 
-    /* Snapshot table offset/length */
-    if (header.nb_snapshots > QCOW_MAX_SNAPSHOTS) {
-        error_setg(errp, "Too many snapshots");
-        ret = -EINVAL;
-        goto fail;
-    }
-
-    ret = validate_table_offset(bs, header.snapshots_offset,
-                                header.nb_snapshots,
-                                sizeof(QCowSnapshotHeader));
+    /* The total size in bytes of the snapshot table is checked in
+     * qcow2_read_snapshots() because the size of each snapshot is
+     * variable and we don't know it yet.
+     * Here we only check the offset and number of snapshots. */
+    ret = qcow2_validate_table(bs, header.snapshots_offset,
+                               header.nb_snapshots,
+                               sizeof(QCowSnapshotHeader),
+                               sizeof(QCowSnapshotHeader) * QCOW_MAX_SNAPSHOTS,
+                               "Snapshot table", errp);
     if (ret < 0) {
-        error_setg(errp, "Invalid snapshot table offset");
         goto fail;
     }
 
     /* read the level 1 table */
-    if (header.l1_size > QCOW_MAX_L1_SIZE / sizeof(uint64_t)) {
-        error_setg(errp, "Active L1 table too large");
-        ret = -EFBIG;
+    ret = qcow2_validate_table(bs, header.l1_table_offset,
+                               header.l1_size, sizeof(uint64_t),
+                               QCOW_MAX_L1_SIZE, "Active L1 table", errp);
+    if (ret < 0) {
         goto fail;
     }
     s->l1_size = header.l1_size;
+    s->l1_table_offset = header.l1_table_offset;
 
     l1_vm_state_index = size_to_l1(s, header.size);
     if (l1_vm_state_index > INT_MAX) {
@@ -1381,15 +1373,6 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
         goto fail;
     }
 
-    ret = validate_table_offset(bs, header.l1_table_offset,
-                                header.l1_size, sizeof(uint64_t));
-    if (ret < 0) {
-        error_setg(errp, "Invalid L1 table offset");
-        goto fail;
-    }
-    s->l1_table_offset = header.l1_table_offset;
-
-
     if (s->l1_size > 0) {
         s->l1_table = qemu_try_blockalign(bs->file->bs,
             ROUND_UP(s->l1_size * sizeof(uint64_t), 512));
diff --git a/tests/qemu-iotests/080.out b/tests/qemu-iotests/080.out
index 6a7fda1356..4c7790c9ee 100644
--- a/tests/qemu-iotests/080.out
+++ b/tests/qemu-iotests/080.out
@@ -18,18 +18,18 @@ can't open device TEST_DIR/t.qcow2: Reference count table too large
 
 == Misaligned refcount table ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-can't open device TEST_DIR/t.qcow2: Invalid reference count table offset
+can't open device TEST_DIR/t.qcow2: Reference count table offset invalid
 
 == Huge refcount offset ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-can't open device TEST_DIR/t.qcow2: Invalid reference count table offset
+can't open device TEST_DIR/t.qcow2: Reference count table offset invalid
 
 == Invalid snapshot table ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-can't open device TEST_DIR/t.qcow2: Too many snapshots
-can't open device TEST_DIR/t.qcow2: Too many snapshots
-can't open device TEST_DIR/t.qcow2: Invalid snapshot table offset
-can't open device TEST_DIR/t.qcow2: Invalid snapshot table offset
+can't open device TEST_DIR/t.qcow2: Snapshot table too large
+can't open device TEST_DIR/t.qcow2: Snapshot table too large
+can't open device TEST_DIR/t.qcow2: Snapshot table offset invalid
+can't open device TEST_DIR/t.qcow2: Snapshot table offset invalid
 
 == Hitting snapshot table size limit ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
@@ -41,8 +41,8 @@ read 512/512 bytes at offset 0
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 can't open device TEST_DIR/t.qcow2: Active L1 table too large
 can't open device TEST_DIR/t.qcow2: Active L1 table too large
-can't open device TEST_DIR/t.qcow2: Invalid L1 table offset
-can't open device TEST_DIR/t.qcow2: Invalid L1 table offset
+can't open device TEST_DIR/t.qcow2: Active L1 table offset invalid
+can't open device TEST_DIR/t.qcow2: Active L1 table offset invalid
 
 == Invalid L1 table (with internal snapshot in the image) ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-- 
2.13.6
