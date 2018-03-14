Received: from eggs.gnu.org ([2001:4830:134:3::10]:36274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <junyan.he@hotmail.com>) id 1evv5g-0000Lo-WA
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 21:20:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <junyan.he@hotmail.com>) id 1evv5e-0006LN-Km
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 21:20:28 -0400
Received: from mga18.intel.com ([134.134.136.126]:28906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <junyan.he@hotmail.com>)
	id 1evv5e-0006Hx-9F
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 21:20:26 -0400
From: junyan.he@hotmail.com
Date: Wed, 14 Mar 2018 09:20:10 +0800
Message-Id: <1520990418-28258-3-git-send-email-junyan.he@hotmail.com>
In-Reply-To: <1520990418-28258-1-git-send-email-junyan.he@hotmail.com>
References: <1520990418-28258-1-git-send-email-junyan.he@hotmail.com>
Subject: [Qemu-devel] [PATCH 02/10] RFC: Implement qcow2's snapshot
 dependent saving function.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, quintela@redhat.com, rth@twiddle.net, dgilbert@redhat.com, famz@redhat.com, Junyan He <junyan.he@intel.com>

From: Junyan He <junyan.he@intel.com>

For qcow2 format, we can increase the cluster's reference count of
dependent snapshot content and link the offset to the L2 table of
the new snapshot point. This way can avoid obvious snapshot's dependent
relationship, so when we delete some snapshot point, just decrease the
cluster count and no need to check further.

Signed-off-by: Junyan He <junyan.he@intel.com>
---
 block/qcow2-snapshot.c | 154 +++++++++++++++++++++++++++++++++++++++++++++++++
 block/qcow2.c          |   2 +
 block/qcow2.h          |   7 +++
 3 files changed, 163 insertions(+)

diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index cee25f5..8e83084 100644
--- a/block/qcow2-snapshot.c
+++ b/block/qcow2-snapshot.c
@@ -736,3 +736,157 @@ int qcow2_snapshot_load_tmp(BlockDriverState *bs,
 
     return 0;
 }
+
+int qcow2_snapshot_save_dependency(BlockDriverState *bs,
+                                   const char *depend_snapshot_id,
+                                   int64_t depend_offset,
+                                   int64_t depend_size,
+                                   int64_t offset,
+                                   Error **errp)
+{
+    int snapshot_index;
+    BDRVQcow2State *s = bs->opaque;
+    QCowSnapshot *sn;
+    int ret;
+    int64_t i;
+    int64_t total_bytes = depend_size;
+    int64_t depend_offset1, offset1;
+    uint64_t *depend_l1_table = NULL;
+    uint64_t depend_l1_bytes;
+    uint64_t *depend_l2_table = NULL;
+    uint64_t depend_l2_offset;
+    uint64_t depend_entry;
+    QCowL2Meta l2meta;
+
+    assert(bs->read_only == false);
+
+    if (depend_snapshot_id == NULL) {
+        return 0;
+    }
+
+    if (!QEMU_IS_ALIGNED(depend_offset,  s->cluster_size)) {
+        error_setg(errp, "Specified snapshot offset is not multiple of %u",
+                s->cluster_size);
+        return -EINVAL;
+    }
+
+    if (!QEMU_IS_ALIGNED(offset,  s->cluster_size)) {
+        error_setg(errp, "Offset is not multiple of %u", s->cluster_size);
+        return -EINVAL;
+    }
+
+    if (!QEMU_IS_ALIGNED(depend_size,  s->cluster_size)) {
+        error_setg(errp, "depend_size is not multiple of %u", s->cluster_size);
+        return -EINVAL;
+    }
+
+    snapshot_index = find_snapshot_by_id_and_name(bs, NULL, depend_snapshot_id);
+    /* Search the snapshot */
+    if (snapshot_index < 0) {
+        error_setg(errp, "Can't find snapshot");
+        return -ENOENT;
+    }
+
+    sn = &s->snapshots[snapshot_index];
+    if (sn->disk_size != bs->total_sectors * BDRV_SECTOR_SIZE) {
+        error_report("qcow2: depend on the snapshots with different disk "
+                "size is not implemented");
+        return -ENOTSUP;
+    }
+
+    /* Only can save dependency of snapshot's vmstate data */
+    depend_offset1 = depend_offset + qcow2_vm_state_offset(s);
+    offset1 = offset + qcow2_vm_state_offset(s);
+
+    depend_l1_bytes = s->l1_size * sizeof(uint64_t);
+    depend_l1_table = g_try_malloc0(depend_l1_bytes);
+    if (depend_l1_table == NULL) {
+        return -ENOMEM;
+    }
+
+    ret = bdrv_pread(bs->file, sn->l1_table_offset, depend_l1_table,
+                     depend_l1_bytes);
+    if (ret < 0) {
+        g_free(depend_l1_table);
+        goto out;
+    }
+    for (i = 0; i < depend_l1_bytes / sizeof(uint64_t); i++) {
+        be64_to_cpus(&depend_l1_table[i]);
+    }
+
+    while (total_bytes) {
+        assert(total_bytes > 0);
+        /* Find the cluster of depend */
+        depend_l2_offset =
+            depend_l1_table[depend_offset1 >> (s->l2_bits + s->cluster_bits)];
+        depend_l2_offset &= L1E_OFFSET_MASK;
+        if (depend_l2_offset == 0) {
+            ret = -EINVAL;
+            goto out;
+        }
+
+        if (offset_into_cluster(s, depend_l2_offset)) {
+            qcow2_signal_corruption(bs, true, -1, -1, "L2 table offset %#"
+                                    PRIx64 " unaligned (L1 index: %#"
+                                    PRIx64 ")",
+                                    depend_l2_offset,
+                                    depend_offset1 >>
+                                        (s->l2_bits + s->cluster_bits));
+            return -EIO;
+        }
+
+        ret = qcow2_cache_get(bs, s->l2_table_cache, depend_l2_offset,
+                              (void **)(&depend_l2_table));
+        if (ret < 0) {
+            goto out;
+        }
+
+        depend_entry =
+            be64_to_cpu(
+                depend_l2_table[offset_to_l2_index(s, depend_offset1)]);
+        if (depend_entry == 0) {
+            ret = -EINVAL;
+            qcow2_cache_put(s->l2_table_cache, (void **)(&depend_l2_table));
+            goto out;
+        }
+
+        memset(&l2meta, 0, sizeof(l2meta));
+        l2meta.offset = offset1;
+        l2meta.alloc_offset = (depend_entry & L2E_OFFSET_MASK);
+        l2meta.nb_clusters = 1;
+        /* Add a ref to this cluster */
+        ret = qcow2_update_cluster_refcount(
+                  bs, l2meta.alloc_offset >> s->cluster_bits,
+                  1, false, QCOW2_DISCARD_SNAPSHOT);
+        if (ret < 0) {
+            qcow2_cache_put(s->l2_table_cache, (void **)(&depend_l2_table));
+            goto out;
+        }
+
+        ret = qcow2_alloc_cluster_link_l2(bs, &l2meta);
+        if (ret < 0) {
+            qcow2_cache_put(s->l2_table_cache, (void **)(&depend_l2_table));
+            goto out;
+        }
+
+        total_bytes -= s->cluster_size;
+        offset1 += s->cluster_size;
+        depend_offset1 += s->cluster_size;
+
+        qcow2_cache_put(s->l2_table_cache, (void **)(&depend_l2_table));
+    }
+
+out:
+    g_free(depend_l1_table);
+    return ret;
+}
+
+int qcow2_snapshot_support_dependency(BlockDriverState *bs, int32_t *alignment)
+{
+    BDRVQcow2State *s = bs->opaque;
+    if (alignment) {
+        *alignment = s->cluster_size;
+    }
+
+    return 1;
+}
diff --git a/block/qcow2.c b/block/qcow2.c
index 071dc4d..9786ba4 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4371,6 +4371,8 @@ BlockDriver bdrv_qcow2 = {
     .bdrv_snapshot_delete   = qcow2_snapshot_delete,
     .bdrv_snapshot_list     = qcow2_snapshot_list,
     .bdrv_snapshot_load_tmp = qcow2_snapshot_load_tmp,
+    .bdrv_snapshot_support_dependency = qcow2_snapshot_support_dependency,
+    .bdrv_snapshot_save_dependency = qcow2_snapshot_save_dependency,
     .bdrv_measure           = qcow2_measure,
     .bdrv_get_info          = qcow2_get_info,
     .bdrv_get_specific_info = qcow2_get_specific_info,
diff --git a/block/qcow2.h b/block/qcow2.h
index 1a84cc7..dc7ef45 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -640,6 +640,13 @@ int qcow2_snapshot_load_tmp(BlockDriverState *bs,
 
 void qcow2_free_snapshots(BlockDriverState *bs);
 int qcow2_read_snapshots(BlockDriverState *bs);
+int qcow2_snapshot_save_dependency(BlockDriverState *bs,
+                                  const char *depend_snapshot_id,
+                                  int64_t depend_offset,
+                                  int64_t depend_size,
+                                  int64_t offset,
+                                  Error **errp);
+int qcow2_snapshot_support_dependency(BlockDriverState *bs, int32_t *alignment);
 
 /* qcow2-cache.c functions */
 Qcow2Cache *qcow2_cache_create(BlockDriverState *bs, int num_tables,
-- 
2.7.4
