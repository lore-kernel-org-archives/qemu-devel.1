Received: from eggs.gnu.org ([2001:4830:134:3::10]:45723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d79iA-0002bQ-6j
	for qemu-devel@nongnu.org; Sat, 06 May 2017 20:06:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d79i9-0007iC-0C
	for qemu-devel@nongnu.org; Sat, 06 May 2017 20:06:06 -0400
From: Eric Blake <eblake@redhat.com>
Date: Sat,  6 May 2017 19:05:41 -0500
Message-Id: <20170507000552.20847-2-eblake@redhat.com>
In-Reply-To: <20170507000552.20847-1-eblake@redhat.com>
References: <20170507000552.20847-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v13 01/12] qcow2: Nicer variable names in
 qcow2_update_snapshot_refcount()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com

In order to keep checkpatch happy when the next patch changes
indentation, we first have to shorten some long lines.  The easiest
approach is to use a new variable in place of
'offset & L2E_OFFSET_MASK', except that 'offset' is the best name
for that variable.  Change '[old_]offset' to '[old_]entry' to
make room.

While touching things, also fix checkpatch warnings about unusual
'for' statements.

Suggested by Max Reitz <mreitz@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>

---
v13: new patch
---
 block/qcow2-refcount.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 4efca7e..db0af2c 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1059,9 +1059,9 @@ int qcow2_update_snapshot_refcount(BlockDriverState *bs,
     int64_t l1_table_offset, int l1_size, int addend)
 {
     BDRVQcow2State *s = bs->opaque;
-    uint64_t *l1_table, *l2_table, l2_offset, offset, l1_size2, refcount;
+    uint64_t *l1_table, *l2_table, l2_offset, entry, l1_size2, refcount;
     bool l1_allocated = false;
-    int64_t old_offset, old_l2_offset;
+    int64_t old_entry, old_l2_offset;
     int i, j, l1_modified = 0, nb_csectors;
     int ret;

@@ -1089,15 +1089,16 @@ int qcow2_update_snapshot_refcount(BlockDriverState *bs,
             goto fail;
         }

-        for(i = 0;i < l1_size; i++)
+        for (i = 0; i < l1_size; i++) {
             be64_to_cpus(&l1_table[i]);
+        }
     } else {
         assert(l1_size == s->l1_size);
         l1_table = s->l1_table;
         l1_allocated = false;
     }

-    for(i = 0; i < l1_size; i++) {
+    for (i = 0; i < l1_size; i++) {
         l2_offset = l1_table[i];
         if (l2_offset) {
             old_l2_offset = l2_offset;
@@ -1117,20 +1118,22 @@ int qcow2_update_snapshot_refcount(BlockDriverState *bs,
                 goto fail;
             }

-            for(j = 0; j < s->l2_size; j++) {
+            for (j = 0; j < s->l2_size; j++) {
                 uint64_t cluster_index;
+                uint64_t offset;

-                offset = be64_to_cpu(l2_table[j]);
-                old_offset = offset;
-                offset &= ~QCOW_OFLAG_COPIED;
+                entry = be64_to_cpu(l2_table[j]);
+                old_entry = entry;
+                entry &= ~QCOW_OFLAG_COPIED;
+                offset = entry & L2E_OFFSET_MASK;

-                switch (qcow2_get_cluster_type(offset)) {
+                switch (qcow2_get_cluster_type(entry)) {
                     case QCOW2_CLUSTER_COMPRESSED:
-                        nb_csectors = ((offset >> s->csize_shift) &
+                        nb_csectors = ((entry >> s->csize_shift) &
                                        s->csize_mask) + 1;
                         if (addend != 0) {
                             ret = update_refcount(bs,
-                                (offset & s->cluster_offset_mask) & ~511,
+                                (entry & s->cluster_offset_mask) & ~511,
                                 nb_csectors * 512, abs(addend), addend < 0,
                                 QCOW2_DISCARD_SNAPSHOT);
                             if (ret < 0) {
@@ -1143,18 +1146,17 @@ int qcow2_update_snapshot_refcount(BlockDriverState *bs,

                     case QCOW2_CLUSTER_NORMAL:
                     case QCOW2_CLUSTER_ZERO:
-                        if (offset_into_cluster(s, offset & L2E_OFFSET_MASK)) {
+                        if (offset_into_cluster(s, offset)) {
                             qcow2_signal_corruption(bs, true, -1, -1, "Data "
-                                                    "cluster offset %#llx "
-                                                    "unaligned (L2 offset: %#"
+                                                    "cluster offset %#" PRIx64
+                                                    " unaligned (L2 offset: %#"
                                                     PRIx64 ", L2 index: %#x)",
-                                                    offset & L2E_OFFSET_MASK,
-                                                    l2_offset, j);
+                                                    offset, l2_offset, j);
                             ret = -EIO;
                             goto fail;
                         }

-                        cluster_index = (offset & L2E_OFFSET_MASK) >> s->cluster_bits;
+                        cluster_index = offset >> s->cluster_bits;
                         if (!cluster_index) {
                             /* unallocated */
                             refcount = 0;
@@ -1184,14 +1186,14 @@ int qcow2_update_snapshot_refcount(BlockDriverState *bs,
                 }

                 if (refcount == 1) {
-                    offset |= QCOW_OFLAG_COPIED;
+                    entry |= QCOW_OFLAG_COPIED;
                 }
-                if (offset != old_offset) {
+                if (entry != old_entry) {
                     if (addend > 0) {
                         qcow2_cache_set_dependency(bs, s->l2_table_cache,
                             s->refcount_block_cache);
                     }
-                    l2_table[j] = cpu_to_be64(offset);
+                    l2_table[j] = cpu_to_be64(entry);
                     qcow2_cache_entry_mark_dirty(bs, s->l2_table_cache,
                                                  l2_table);
                 }
-- 
2.9.3
