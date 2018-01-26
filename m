Received: from eggs.gnu.org ([2001:4830:134:3::10]:36505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ef6r4-0007Kl-3Y
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 11:27:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ef6qz-0004Uy-3v
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 11:27:54 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 26 Jan 2018 16:59:53 +0200
Message-Id: <0c81220cf2141a5b720629fb6eaff04f833e77a4.1516978645.git.berto@igalia.com>
In-Reply-To: <cover.1516978645.git.berto@igalia.com>
References: <cover.1516978645.git.berto@igalia.com>
In-Reply-To: <cover.1516978645.git.berto@igalia.com>
References: <cover.1516978645.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v3 26/39] qcow2: Prepare
 qcow2_update_snapshot_refcount() for adding L2 slice support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

Adding support for L2 slices to qcow2_update_snapshot_refcount() needs
(among other things) an extra loop that iterates over all slices of
each L2 table.

Putting all changes in one patch would make it hard to read because
all semantic changes would be mixed with pure indentation changes.

To make things easier this patch simply creates a new block and
changes the indentation of all lines of code inside it. Thus, all
modifications in this patch are cosmetic. There are no semantic
changes and no variables are renamed yet. The next patch will take
care of that.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-refcount.c | 140 ++++++++++++++++++++++++++-----------------------
 1 file changed, 73 insertions(+), 67 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 9df380d52c..dfa28301c4 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1236,91 +1236,97 @@ int qcow2_update_snapshot_refcount(BlockDriverState *bs,
                 goto fail;
             }
 
-            ret = qcow2_cache_get(bs, s->l2_table_cache, l2_offset,
-                (void**) &l2_table);
-            if (ret < 0) {
-                goto fail;
-            }
+            {
+                ret = qcow2_cache_get(bs, s->l2_table_cache,
+                                      l2_offset,
+                                      (void **) &l2_table);
+                if (ret < 0) {
+                    goto fail;
+                }
 
-            for (j = 0; j < s->l2_size; j++) {
-                uint64_t cluster_index;
-                uint64_t offset;
+                for (j = 0; j < s->l2_size; j++) {
+                    uint64_t cluster_index;
+                    uint64_t offset;
 
-                entry = be64_to_cpu(l2_table[j]);
-                old_entry = entry;
-                entry &= ~QCOW_OFLAG_COPIED;
-                offset = entry & L2E_OFFSET_MASK;
+                    entry = be64_to_cpu(l2_table[j]);
+                    old_entry = entry;
+                    entry &= ~QCOW_OFLAG_COPIED;
+                    offset = entry & L2E_OFFSET_MASK;
 
-                switch (qcow2_get_cluster_type(entry)) {
-                case QCOW2_CLUSTER_COMPRESSED:
-                    nb_csectors = ((entry >> s->csize_shift) &
-                                   s->csize_mask) + 1;
-                    if (addend != 0) {
-                        ret = update_refcount(bs,
-                                (entry & s->cluster_offset_mask) & ~511,
+                    switch (qcow2_get_cluster_type(entry)) {
+                    case QCOW2_CLUSTER_COMPRESSED:
+                        nb_csectors = ((entry >> s->csize_shift) &
+                                       s->csize_mask) + 1;
+                        if (addend != 0) {
+                            ret = update_refcount(
+                                bs, (entry & s->cluster_offset_mask) & ~511,
                                 nb_csectors * 512, abs(addend), addend < 0,
                                 QCOW2_DISCARD_SNAPSHOT);
-                        if (ret < 0) {
+                            if (ret < 0) {
+                                goto fail;
+                            }
+                        }
+                        /* compressed clusters are never modified */
+                        refcount = 2;
+                        break;
+
+                    case QCOW2_CLUSTER_NORMAL:
+                    case QCOW2_CLUSTER_ZERO_ALLOC:
+                        if (offset_into_cluster(s, offset)) {
+                            qcow2_signal_corruption(
+                                bs, true, -1, -1, "Cluster "
+                                "allocation offset %#" PRIx64
+                                " unaligned (L2 offset: %#"
+                                PRIx64 ", L2 index: %#x)",
+                                offset, l2_offset, j);
+                            ret = -EIO;
                             goto fail;
                         }
-                    }
-                    /* compressed clusters are never modified */
-                    refcount = 2;
-                    break;
-
-                case QCOW2_CLUSTER_NORMAL:
-                case QCOW2_CLUSTER_ZERO_ALLOC:
-                    if (offset_into_cluster(s, offset)) {
-                        qcow2_signal_corruption(bs, true, -1, -1, "Cluster "
-                                                "allocation offset %#" PRIx64
-                                                " unaligned (L2 offset: %#"
-                                                PRIx64 ", L2 index: %#x)",
-                                                offset, l2_offset, j);
-                        ret = -EIO;
-                        goto fail;
-                    }
 
-                    cluster_index = offset >> s->cluster_bits;
-                    assert(cluster_index);
-                    if (addend != 0) {
-                        ret = qcow2_update_cluster_refcount(bs,
-                                    cluster_index, abs(addend), addend < 0,
-                                    QCOW2_DISCARD_SNAPSHOT);
+                        cluster_index = offset >> s->cluster_bits;
+                        assert(cluster_index);
+                        if (addend != 0) {
+                            ret = qcow2_update_cluster_refcount(
+                                bs, cluster_index, abs(addend), addend < 0,
+                                QCOW2_DISCARD_SNAPSHOT);
+                            if (ret < 0) {
+                                goto fail;
+                            }
+                        }
+
+                        ret = qcow2_get_refcount(bs, cluster_index, &refcount);
                         if (ret < 0) {
                             goto fail;
                         }
-                    }
+                        break;
 
-                    ret = qcow2_get_refcount(bs, cluster_index, &refcount);
-                    if (ret < 0) {
-                        goto fail;
-                    }
-                    break;
+                    case QCOW2_CLUSTER_ZERO_PLAIN:
+                    case QCOW2_CLUSTER_UNALLOCATED:
+                        refcount = 0;
+                        break;
 
-                case QCOW2_CLUSTER_ZERO_PLAIN:
-                case QCOW2_CLUSTER_UNALLOCATED:
-                    refcount = 0;
-                    break;
-
-                default:
-                    abort();
-                }
+                    default:
+                        abort();
+                    }
 
-                if (refcount == 1) {
-                    entry |= QCOW_OFLAG_COPIED;
-                }
-                if (entry != old_entry) {
-                    if (addend > 0) {
-                        qcow2_cache_set_dependency(bs, s->l2_table_cache,
-                            s->refcount_block_cache);
+                    if (refcount == 1) {
+                        entry |= QCOW_OFLAG_COPIED;
+                    }
+                    if (entry != old_entry) {
+                        if (addend > 0) {
+                            qcow2_cache_set_dependency(bs, s->l2_table_cache,
+                                                       s->refcount_block_cache);
+                        }
+                        l2_table[j] = cpu_to_be64(entry);
+                        qcow2_cache_entry_mark_dirty(s->l2_table_cache,
+                                                     l2_table);
                     }
-                    l2_table[j] = cpu_to_be64(entry);
-                    qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_table);
                 }
+
+                qcow2_cache_put(s->l2_table_cache, (void **) &l2_table);
+
             }
 
-            qcow2_cache_put(s->l2_table_cache, (void **) &l2_table);
-
             if (addend != 0) {
                 ret = qcow2_update_cluster_refcount(bs, l2_offset >>
                                                         s->cluster_bits,
-- 
2.11.0
