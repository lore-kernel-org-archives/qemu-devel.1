Received: from eggs.gnu.org ([2001:4830:134:3::10]:50488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cYEcM-0000Wv-B5
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 11:15:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cYEcH-0003bQ-Bj
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 11:15:46 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Mon, 30 Jan 2017 18:14:41 +0200
Message-Id: <20170130161441.30493-1-berto@igalia.com>
Subject: [Qemu-devel] [PATCH] qcow2: Optimize the refcount-block overlap
 check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

The metadata overlap checks introduced in a40f1c2add help detect
corruption in the qcow2 image by verifying that data writes don't
overlap with existing metadata sections.

The 'refcount-block' check in particular iterates over the refcount
table in order to get the addresses of all refcount blocks and check
that none of them overlap with the region where we want to write.

The problem with the refcount table is that since it always occupies
complete clusters its size is usually very big. With the default
values of cluster_size=64KB and refcount_bits=16 this table holds 8192
entries, each one of them enough to map 2GB worth of host clusters.

So unless we're using images with several TB of allocated data this
table is going to be mostly empty, and iterating over it is a waste of
CPU. If the storage backend is fast enough this can have an effect on
I/O performance.

This patch keeps the index of the last used (i.e. non-zero) entry in
the refcount table and updates it every time the table changes. The
refcount-block overlap check then uses that index instead of reading
the whole table.

In my tests with a 4GB qcow2 file stored in RAM this doubles the
amount of write IOPS.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-refcount.c | 21 ++++++++++++++++++++-
 block/qcow2.c          |  1 +
 block/qcow2.h          |  1 +
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index cbfb3fe064..5e4d36587f 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -83,6 +83,16 @@ static Qcow2SetRefcountFunc *const set_refcount_funcs[] = {
 /*********************************************************/
 /* refcount handling */
 
+static void update_max_refcount_table_index(BDRVQcow2State *s)
+{
+    unsigned i = s->refcount_table_size - 1;
+    while (i > 0 && (s->refcount_table[i] & REFT_OFFSET_MASK) == 0) {
+        i--;
+    }
+    /* Set s->max_refcount_table_index to the index of the last used entry */
+    s->max_refcount_table_index = i;
+}
+
 int qcow2_refcount_init(BlockDriverState *bs)
 {
     BDRVQcow2State *s = bs->opaque;
@@ -111,6 +121,7 @@ int qcow2_refcount_init(BlockDriverState *bs)
         }
         for(i = 0; i < s->refcount_table_size; i++)
             be64_to_cpus(&s->refcount_table[i]);
+        update_max_refcount_table_index(s);
     }
     return 0;
  fail:
@@ -439,6 +450,7 @@ static int alloc_refcount_block(BlockDriverState *bs,
         }
 
         s->refcount_table[refcount_table_index] = new_block;
+        s->max_refcount_table_index = refcount_table_index;
 
         /* The new refcount block may be where the caller intended to put its
          * data, so let it restart the search. */
@@ -580,6 +592,7 @@ static int alloc_refcount_block(BlockDriverState *bs,
     s->refcount_table = new_table;
     s->refcount_table_size = table_size;
     s->refcount_table_offset = table_offset;
+    update_max_refcount_table_index(s);
 
     /* Free old table. */
     qcow2_free_clusters(bs, old_table_offset, old_table_size * sizeof(uint64_t),
@@ -2171,6 +2184,7 @@ write_refblocks:
     s->refcount_table = on_disk_reftable;
     s->refcount_table_offset = reftable_offset;
     s->refcount_table_size = reftable_size;
+    update_max_refcount_table_index(s);
 
     return 0;
 
@@ -2383,7 +2397,11 @@ int qcow2_check_metadata_overlap(BlockDriverState *bs, int ign, int64_t offset,
     }
 
     if ((chk & QCOW2_OL_REFCOUNT_BLOCK) && s->refcount_table) {
-        for (i = 0; i < s->refcount_table_size; i++) {
+        unsigned last_entry = s->max_refcount_table_index;
+        assert(last_entry < s->refcount_table_size);
+        assert(last_entry + 1 == s->refcount_table_size ||
+               (s->refcount_table[last_entry + 1] & REFT_OFFSET_MASK) == 0);
+        for (i = 0; i <= last_entry; i++) {
             if ((s->refcount_table[i] & REFT_OFFSET_MASK) &&
                 overlaps_with(s->refcount_table[i] & REFT_OFFSET_MASK,
                 s->cluster_size)) {
@@ -2871,6 +2889,7 @@ int qcow2_change_refcount_order(BlockDriverState *bs, int refcount_order,
     /* Now update the rest of the in-memory information */
     old_reftable = s->refcount_table;
     s->refcount_table = new_reftable;
+    update_max_refcount_table_index(s);
 
     s->refcount_bits = 1 << refcount_order;
     s->refcount_max = UINT64_C(1) << (s->refcount_bits - 1);
diff --git a/block/qcow2.c b/block/qcow2.c
index 96fb8a8f16..3e274bd1ba 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2743,6 +2743,7 @@ static int make_completely_empty(BlockDriverState *bs)
 
     s->refcount_table_offset = s->cluster_size;
     s->refcount_table_size   = s->cluster_size / sizeof(uint64_t);
+    s->max_refcount_table_index = 0;
 
     g_free(s->refcount_table);
     s->refcount_table = new_reftable;
diff --git a/block/qcow2.h b/block/qcow2.h
index 182341483a..f8aeb08794 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -251,6 +251,7 @@ typedef struct BDRVQcow2State {
     uint64_t *refcount_table;
     uint64_t refcount_table_offset;
     uint32_t refcount_table_size;
+    uint32_t max_refcount_table_index; /* Last used entry in refcount_table */
     uint64_t free_cluster_index;
     uint64_t free_byte_offset;
 
-- 
2.11.0
