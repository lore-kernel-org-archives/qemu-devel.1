Received: from eggs.gnu.org ([209.51.188.92]:59930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2F5z-0000F3-9V
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:59:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2F5t-0008DK-Pm
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:59:25 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  8 Mar 2019 13:58:11 +0100
Message-Id: <20190308125823.32535-22-kwolf@redhat.com>
In-Reply-To: <20190308125823.32535-1-kwolf@redhat.com>
References: <20190308125823.32535-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 21/33] qcow2: External file I/O
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

This changes the qcow2 implementation to direct all guest data I/O to
s->data_file rather than bs->file, while metadata I/O still uses
bs->file. At the moment, this is still always the same, but soon we'll
add options to set s->data_file to an external data file.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.h          |  2 +-
 block/qcow2-bitmap.c   |  7 +++---
 block/qcow2-cache.c    |  6 ++---
 block/qcow2-cluster.c  | 46 +++++++++++++++++++++++++++++++------
 block/qcow2-refcount.c | 39 +++++++++++++++++++++++--------
 block/qcow2-snapshot.c |  7 +++---
 block/qcow2.c          | 52 +++++++++++++++++++++++++++++++++---------
 7 files changed, 122 insertions(+), 37 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index fad6abf602..aac7fc4348 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -622,7 +622,7 @@ void qcow2_process_discards(BlockDriverState *bs, int=
 ret);
 int qcow2_check_metadata_overlap(BlockDriverState *bs, int ign, int64_t =
offset,
                                  int64_t size);
 int qcow2_pre_write_overlap_check(BlockDriverState *bs, int ign, int64_t=
 offset,
-                                  int64_t size);
+                                  int64_t size, bool data_file);
 int qcow2_inc_refcounts_imrt(BlockDriverState *bs, BdrvCheckResult *res,
                              void **refcount_table,
                              int64_t *refcount_table_size,
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 3ee524da4b..9d968bdcda 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -778,7 +778,8 @@ static int bitmap_list_store(BlockDriverState *bs, Qc=
ow2BitmapList *bm_list,
      * directory in-place (actually, turn-off the extension), which is c=
hecked
      * in qcow2_check_metadata_overlap() */
     ret =3D qcow2_pre_write_overlap_check(
-            bs, in_place ? QCOW2_OL_BITMAP_DIRECTORY : 0, dir_offset, di=
r_size);
+            bs, in_place ? QCOW2_OL_BITMAP_DIRECTORY : 0, dir_offset, di=
r_size,
+            false);
     if (ret < 0) {
         goto fail;
     }
@@ -1224,7 +1225,7 @@ static uint64_t *store_bitmap_data(BlockDriverState=
 *bs,
             memset(buf + write_size, 0, s->cluster_size - write_size);
         }
=20
-        ret =3D qcow2_pre_write_overlap_check(bs, 0, off, s->cluster_siz=
e);
+        ret =3D qcow2_pre_write_overlap_check(bs, 0, off, s->cluster_siz=
e, false);
         if (ret < 0) {
             error_setg_errno(errp, -ret, "Qcow2 overlap check failed");
             goto fail;
@@ -1292,7 +1293,7 @@ static int store_bitmap(BlockDriverState *bs, Qcow2=
Bitmap *bm, Error **errp)
     }
=20
     ret =3D qcow2_pre_write_overlap_check(bs, 0, tb_offset,
-                                        tb_size * sizeof(tb[0]));
+                                        tb_size * sizeof(tb[0]), false);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Qcow2 overlap check failed");
         goto fail;
diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index d9dafa31e5..df02e7b20a 100644
--- a/block/qcow2-cache.c
+++ b/block/qcow2-cache.c
@@ -205,13 +205,13 @@ static int qcow2_cache_entry_flush(BlockDriverState=
 *bs, Qcow2Cache *c, int i)
=20
     if (c =3D=3D s->refcount_block_cache) {
         ret =3D qcow2_pre_write_overlap_check(bs, QCOW2_OL_REFCOUNT_BLOC=
K,
-                c->entries[i].offset, c->table_size);
+                c->entries[i].offset, c->table_size, false);
     } else if (c =3D=3D s->l2_table_cache) {
         ret =3D qcow2_pre_write_overlap_check(bs, QCOW2_OL_ACTIVE_L2,
-                c->entries[i].offset, c->table_size);
+                c->entries[i].offset, c->table_size, false);
     } else {
         ret =3D qcow2_pre_write_overlap_check(bs, 0,
-                c->entries[i].offset, c->table_size);
+                c->entries[i].offset, c->table_size, false);
     }
=20
     if (ret < 0) {
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 8c4b4005ff..7579f5a5ae 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -153,7 +153,7 @@ int qcow2_grow_l1_table(BlockDriverState *bs, uint64_=
t min_size,
     /* the L1 position has not yet been updated, so these clusters must
      * indeed be completely free */
     ret =3D qcow2_pre_write_overlap_check(bs, 0, new_l1_table_offset,
-                                        new_l1_size2);
+                                        new_l1_size2, false);
     if (ret < 0) {
         goto fail;
     }
@@ -238,7 +238,7 @@ int qcow2_write_l1_entry(BlockDriverState *bs, int l1=
_index)
     }
=20
     ret =3D qcow2_pre_write_overlap_check(bs, QCOW2_OL_ACTIVE_L1,
-            s->l1_table_offset + 8 * l1_start_index, sizeof(buf));
+            s->l1_table_offset + 8 * l1_start_index, sizeof(buf), false)=
;
     if (ret < 0) {
         return ret;
     }
@@ -490,6 +490,7 @@ static int coroutine_fn do_perform_cow_write(BlockDri=
verState *bs,
                                              unsigned offset_in_cluster,
                                              QEMUIOVector *qiov)
 {
+    BDRVQcow2State *s =3D bs->opaque;
     int ret;
=20
     if (qiov->size =3D=3D 0) {
@@ -497,13 +498,13 @@ static int coroutine_fn do_perform_cow_write(BlockD=
riverState *bs,
     }
=20
     ret =3D qcow2_pre_write_overlap_check(bs, 0,
-            cluster_offset + offset_in_cluster, qiov->size);
+            cluster_offset + offset_in_cluster, qiov->size, true);
     if (ret < 0) {
         return ret;
     }
=20
     BLKDBG_EVENT(bs->file, BLKDBG_COW_WRITE);
-    ret =3D bdrv_co_pwritev(bs->file, cluster_offset + offset_in_cluster=
,
+    ret =3D bdrv_co_pwritev(s->data_file, cluster_offset + offset_in_clu=
ster,
                           qiov->size, qiov, 0);
     if (ret < 0) {
         return ret;
@@ -607,6 +608,14 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, u=
int64_t offset,
     }
     switch (type) {
     case QCOW2_CLUSTER_COMPRESSED:
+        if (has_data_file(bs)) {
+            qcow2_signal_corruption(bs, true, -1, -1, "Compressed cluste=
r "
+                                    "entry found in image with external =
data "
+                                    "file (L2 offset: %#" PRIx64 ", L2 i=
ndex: "
+                                    "%#x)", l2_offset, l2_index);
+            ret =3D -EIO;
+            goto fail;
+        }
         /* Compressed clusters can only be processed one by one */
         c =3D 1;
         *cluster_offset &=3D L2E_COMPRESSED_OFFSET_SIZE_MASK;
@@ -633,6 +642,17 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, u=
int64_t offset,
             ret =3D -EIO;
             goto fail;
         }
+        if (has_data_file(bs) && *cluster_offset !=3D offset - offset_in=
_cluster)
+        {
+            qcow2_signal_corruption(bs, true, -1, -1,
+                                    "External data file host cluster off=
set %#"
+                                    PRIx64 " does not match guest cluste=
r "
+                                    "offset: %#" PRIx64
+                                    ", L2 index: %#x)", *cluster_offset,
+                                    offset - offset_in_cluster, l2_index=
);
+            ret =3D -EIO;
+            goto fail;
+        }
         break;
     default:
         abort();
@@ -753,6 +773,10 @@ int qcow2_alloc_compressed_cluster_offset(BlockDrive=
rState *bs,
     int64_t cluster_offset;
     int nb_csectors;
=20
+    if (has_data_file(bs)) {
+        return 0;
+    }
+
     ret =3D get_cluster_table(bs, offset, &l2_slice, &l2_index);
     if (ret < 0) {
         return ret;
@@ -1243,6 +1267,13 @@ static int do_alloc_cluster_offset(BlockDriverStat=
e *bs, uint64_t guest_offset,
     trace_qcow2_do_alloc_clusters_offset(qemu_coroutine_self(), guest_of=
fset,
                                          *host_offset, *nb_clusters);
=20
+    if (has_data_file(bs)) {
+        assert(*host_offset =3D=3D INV_OFFSET ||
+               *host_offset =3D=3D start_of_cluster(s, guest_offset));
+        *host_offset =3D start_of_cluster(s, guest_offset);
+        return 0;
+    }
+
     /* Allocate new clusters */
     trace_qcow2_cluster_alloc_phys(qemu_coroutine_self());
     if (*host_offset =3D=3D INV_OFFSET) {
@@ -1919,7 +1950,7 @@ static int expand_zero_clusters_in_l1(BlockDriverSt=
ate *bs, uint64_t *l1_table,
                 }
=20
                 ret =3D qcow2_pre_write_overlap_check(bs, 0, offset,
-                                                    s->cluster_size);
+                                                    s->cluster_size, tru=
e);
                 if (ret < 0) {
                     if (cluster_type =3D=3D QCOW2_CLUSTER_ZERO_PLAIN) {
                         qcow2_free_clusters(bs, offset, s->cluster_size,
@@ -1928,7 +1959,8 @@ static int expand_zero_clusters_in_l1(BlockDriverSt=
ate *bs, uint64_t *l1_table,
                     goto fail;
                 }
=20
-                ret =3D bdrv_pwrite_zeroes(bs->file, offset, s->cluster_=
size, 0);
+                ret =3D bdrv_pwrite_zeroes(s->data_file, offset,
+                                         s->cluster_size, 0);
                 if (ret < 0) {
                     if (cluster_type =3D=3D QCOW2_CLUSTER_ZERO_PLAIN) {
                         qcow2_free_clusters(bs, offset, s->cluster_size,
@@ -1955,7 +1987,7 @@ static int expand_zero_clusters_in_l1(BlockDriverSt=
ate *bs, uint64_t *l1_table,
                 if (l2_dirty) {
                     ret =3D qcow2_pre_write_overlap_check(
                         bs, QCOW2_OL_INACTIVE_L2 | QCOW2_OL_ACTIVE_L2,
-                        slice_offset, slice_size2);
+                        slice_offset, slice_size2, false);
                     if (ret < 0) {
                         goto fail;
                     }
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 05e7974d7e..df73580e5d 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1156,8 +1156,20 @@ void qcow2_free_any_clusters(BlockDriverState *bs,=
 uint64_t l2_entry,
                              int nb_clusters, enum qcow2_discard_type ty=
pe)
 {
     BDRVQcow2State *s =3D bs->opaque;
+    QCow2ClusterType ctype =3D qcow2_get_cluster_type(bs, l2_entry);
=20
-    switch (qcow2_get_cluster_type(bs, l2_entry)) {
+    if (has_data_file(bs)) {
+        if (s->discard_passthrough[type] &&
+            (ctype =3D=3D QCOW2_CLUSTER_NORMAL ||
+             ctype =3D=3D QCOW2_CLUSTER_ZERO_ALLOC))
+        {
+            bdrv_pdiscard(s->data_file, l2_entry & L2E_OFFSET_MASK,
+                          nb_clusters << s->cluster_bits);
+        }
+        return;
+    }
+
+    switch (ctype) {
     case QCOW2_CLUSTER_COMPRESSED:
         {
             int nb_csectors;
@@ -1649,7 +1661,7 @@ static int check_refcounts_l2(BlockDriverState *bs,=
 BdrvCheckResult *res,
                         l2_table[i] =3D cpu_to_be64(l2_entry);
                         ret =3D qcow2_pre_write_overlap_check(bs,
                                 QCOW2_OL_ACTIVE_L2 | QCOW2_OL_INACTIVE_L=
2,
-                                l2e_offset, sizeof(uint64_t));
+                                l2e_offset, sizeof(uint64_t), false);
                         if (ret < 0) {
                             fprintf(stderr, "ERROR: Overlap check failed=
\n");
                             res->check_errors++;
@@ -1898,7 +1910,8 @@ static int check_oflag_copied(BlockDriverState *bs,=
 BdrvCheckResult *res,
=20
         if (l2_dirty) {
             ret =3D qcow2_pre_write_overlap_check(bs, QCOW2_OL_ACTIVE_L2=
,
-                                                l2_offset, s->cluster_si=
ze);
+                                                l2_offset, s->cluster_si=
ze,
+                                                false);
             if (ret < 0) {
                 fprintf(stderr, "ERROR: Could not write L2 table; metada=
ta "
                         "overlap check failed: %s\n", strerror(-ret));
@@ -2366,7 +2379,7 @@ write_refblocks:
         }
=20
         ret =3D qcow2_pre_write_overlap_check(bs, 0, refblock_offset,
-                                            s->cluster_size);
+                                            s->cluster_size, false);
         if (ret < 0) {
             fprintf(stderr, "ERROR writing refblock: %s\n", strerror(-re=
t));
             goto fail;
@@ -2417,7 +2430,8 @@ write_refblocks:
     }
=20
     ret =3D qcow2_pre_write_overlap_check(bs, 0, reftable_offset,
-                                        reftable_size * sizeof(uint64_t)=
);
+                                        reftable_size * sizeof(uint64_t)=
,
+                                        false);
     if (ret < 0) {
         fprintf(stderr, "ERROR writing reftable: %s\n", strerror(-ret));
         goto fail;
@@ -2751,10 +2765,15 @@ QEMU_BUILD_BUG_ON(QCOW2_OL_MAX_BITNR !=3D ARRAY_S=
IZE(metadata_ol_names));
  * overlaps; or a negative value (-errno) on error.
  */
 int qcow2_pre_write_overlap_check(BlockDriverState *bs, int ign, int64_t=
 offset,
-                                  int64_t size)
+                                  int64_t size, bool data_file)
 {
-    int ret =3D qcow2_check_metadata_overlap(bs, ign, offset, size);
+    int ret;
+
+    if (data_file && has_data_file(bs)) {
+        return 0;
+    }
=20
+    ret =3D qcow2_check_metadata_overlap(bs, ign, offset, size);
     if (ret < 0) {
         return ret;
     } else if (ret > 0) {
@@ -2855,7 +2874,8 @@ static int flush_refblock(BlockDriverState *bs, uin=
t64_t **reftable,
     if (reftable_index < *reftable_size && (*reftable)[reftable_index]) =
{
         offset =3D (*reftable)[reftable_index];
=20
-        ret =3D qcow2_pre_write_overlap_check(bs, 0, offset, s->cluster_=
size);
+        ret =3D qcow2_pre_write_overlap_check(bs, 0, offset, s->cluster_=
size,
+                                            false);
         if (ret < 0) {
             error_setg_errno(errp, -ret, "Overlap check failed");
             return ret;
@@ -3121,7 +3141,8 @@ int qcow2_change_refcount_order(BlockDriverState *b=
s, int refcount_order,
=20
     /* Write the new reftable */
     ret =3D qcow2_pre_write_overlap_check(bs, 0, new_reftable_offset,
-                                        new_reftable_size * sizeof(uint6=
4_t));
+                                        new_reftable_size * sizeof(uint6=
4_t),
+                                        false);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Overlap check failed");
         goto done;
diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index 20e8472191..5ae3407f68 100644
--- a/block/qcow2-snapshot.c
+++ b/block/qcow2-snapshot.c
@@ -184,7 +184,7 @@ static int qcow2_write_snapshots(BlockDriverState *bs=
)
=20
     /* The snapshot list position has not yet been updated, so these clu=
sters
      * must indeed be completely free */
-    ret =3D qcow2_pre_write_overlap_check(bs, 0, offset, snapshots_size)=
;
+    ret =3D qcow2_pre_write_overlap_check(bs, 0, offset, snapshots_size,=
 false);
     if (ret < 0) {
         goto fail;
     }
@@ -389,7 +389,7 @@ int qcow2_snapshot_create(BlockDriverState *bs, QEMUS=
napshotInfo *sn_info)
     }
=20
     ret =3D qcow2_pre_write_overlap_check(bs, 0, sn->l1_table_offset,
-                                        s->l1_size * sizeof(uint64_t));
+                                        s->l1_size * sizeof(uint64_t), f=
alse);
     if (ret < 0) {
         goto fail;
     }
@@ -528,7 +528,8 @@ int qcow2_snapshot_goto(BlockDriverState *bs, const c=
har *snapshot_id)
     }
=20
     ret =3D qcow2_pre_write_overlap_check(bs, QCOW2_OL_ACTIVE_L1,
-                                        s->l1_table_offset, cur_l1_bytes=
);
+                                        s->l1_table_offset, cur_l1_bytes=
,
+                                        false);
     if (ret < 0) {
         goto fail;
     }
diff --git a/block/qcow2.c b/block/qcow2.c
index 8d1f667e91..f048763e10 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -140,7 +140,7 @@ static ssize_t qcow2_crypto_hdr_init_func(QCryptoBloc=
k *block, size_t headerlen,
     /* Zero fill remaining space in cluster so it has predictable
      * content in case of future spec changes */
     clusterlen =3D size_to_clusters(s, headerlen) * s->cluster_size;
-    assert(qcow2_pre_write_overlap_check(bs, 0, ret, clusterlen) =3D=3D =
0);
+    assert(qcow2_pre_write_overlap_check(bs, 0, ret, clusterlen, false) =
=3D=3D 0);
     ret =3D bdrv_pwrite_zeroes(bs->file,
                              ret + headerlen,
                              clusterlen - headerlen, 0);
@@ -1965,7 +1965,7 @@ static coroutine_fn int qcow2_co_preadv(BlockDriver=
State *bs, uint64_t offset,
                  */
                 if (!cluster_data) {
                     cluster_data =3D
-                        qemu_try_blockalign(bs->file->bs,
+                        qemu_try_blockalign(s->data_file->bs,
                                             QCOW_MAX_CRYPT_CLUSTERS
                                             * s->cluster_size);
                     if (cluster_data =3D=3D NULL) {
@@ -1981,7 +1981,7 @@ static coroutine_fn int qcow2_co_preadv(BlockDriver=
State *bs, uint64_t offset,
=20
             BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
             qemu_co_mutex_unlock(&s->lock);
-            ret =3D bdrv_co_preadv(bs->file,
+            ret =3D bdrv_co_preadv(s->data_file,
                                  cluster_offset + offset_in_cluster,
                                  cur_bytes, &hd_qiov, 0);
             qemu_co_mutex_lock(&s->lock);
@@ -2140,7 +2140,7 @@ static coroutine_fn int qcow2_co_pwritev(BlockDrive=
rState *bs, uint64_t offset,
         }
=20
         ret =3D qcow2_pre_write_overlap_check(bs, 0,
-                cluster_offset + offset_in_cluster, cur_bytes);
+                cluster_offset + offset_in_cluster, cur_bytes, true);
         if (ret < 0) {
             goto fail;
         }
@@ -2154,7 +2154,7 @@ static coroutine_fn int qcow2_co_pwritev(BlockDrive=
rState *bs, uint64_t offset,
             BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
             trace_qcow2_writev_data(qemu_coroutine_self(),
                                     cluster_offset + offset_in_cluster);
-            ret =3D bdrv_co_pwritev(bs->file,
+            ret =3D bdrv_co_pwritev(s->data_file,
                                   cluster_offset + offset_in_cluster,
                                   cur_bytes, &hd_qiov, 0);
             qemu_co_mutex_lock(&s->lock);
@@ -3356,7 +3356,7 @@ qcow2_co_copy_range_from(BlockDriverState *bs,
             goto out;
=20
         case QCOW2_CLUSTER_NORMAL:
-            child =3D bs->file;
+            child =3D s->data_file;
             copy_offset +=3D offset_into_cluster(s, src_offset);
             if ((copy_offset & 511) !=3D 0) {
                 ret =3D -EIO;
@@ -3426,14 +3426,14 @@ qcow2_co_copy_range_to(BlockDriverState *bs,
         assert((cluster_offset & 511) =3D=3D 0);
=20
         ret =3D qcow2_pre_write_overlap_check(bs, 0,
-                cluster_offset + offset_in_cluster, cur_bytes);
+                cluster_offset + offset_in_cluster, cur_bytes, true);
         if (ret < 0) {
             goto fail;
         }
=20
         qemu_co_mutex_unlock(&s->lock);
         ret =3D bdrv_co_copy_range_to(src, src_offset,
-                                    bs->file,
+                                    s->data_file,
                                     cluster_offset + offset_in_cluster,
                                     cur_bytes, read_flags, write_flags);
         qemu_co_mutex_lock(&s->lock);
@@ -3588,6 +3588,17 @@ static int coroutine_fn qcow2_co_truncate(BlockDri=
verState *bs, int64_t offset,
         int64_t old_file_size, new_file_size;
         uint64_t nb_new_data_clusters, nb_new_l2_tables;
=20
+        /* With a data file, preallocation means just allocating the met=
adata
+         * and forwarding the truncate request to the data file */
+        if (has_data_file(bs)) {
+            ret =3D preallocate_co(bs, old_length, offset);
+            if (ret < 0) {
+                error_setg_errno(errp, -ret, "Preallocation failed");
+                goto fail;
+            }
+            break;
+        }
+
         old_file_size =3D bdrv_getlength(bs->file->bs);
         if (old_file_size < 0) {
             error_setg_errno(errp, -old_file_size,
@@ -3696,6 +3707,16 @@ static int coroutine_fn qcow2_co_truncate(BlockDri=
verState *bs, int64_t offset,
=20
     bs->total_sectors =3D offset / BDRV_SECTOR_SIZE;
=20
+    if (has_data_file(bs)) {
+        if (prealloc =3D=3D PREALLOC_MODE_METADATA) {
+            prealloc =3D PREALLOC_MODE_OFF;
+        }
+        ret =3D bdrv_co_truncate(s->data_file, offset, prealloc, errp);
+        if (ret < 0) {
+            goto fail;
+        }
+    }
+
     /* write updated header.size */
     offset =3D cpu_to_be64(offset);
     ret =3D bdrv_pwrite_sync(bs->file, offsetof(QCowHeader, size),
@@ -3898,6 +3919,10 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, =
uint64_t offset,
     uint8_t *buf, *out_buf;
     uint64_t cluster_offset;
=20
+    if (has_data_file(bs)) {
+        return -ENOTSUP;
+    }
+
     if (bytes =3D=3D 0) {
         /* align end of file to a sector boundary to ease reading with
            sector based I/Os */
@@ -3949,7 +3974,7 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, u=
int64_t offset,
         goto fail;
     }
=20
-    ret =3D qcow2_pre_write_overlap_check(bs, 0, cluster_offset, out_len=
);
+    ret =3D qcow2_pre_write_overlap_check(bs, 0, cluster_offset, out_len=
, true);
     qemu_co_mutex_unlock(&s->lock);
     if (ret < 0) {
         goto fail;
@@ -3957,8 +3982,8 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, u=
int64_t offset,
=20
     qemu_iovec_init_buf(&hd_qiov, out_buf, out_len);
=20
-    BLKDBG_EVENT(bs->file, BLKDBG_WRITE_COMPRESSED);
-    ret =3D bdrv_co_pwritev(bs->file, cluster_offset, out_len, &hd_qiov,=
 0);
+    BLKDBG_EVENT(s->data_file, BLKDBG_WRITE_COMPRESSED);
+    ret =3D bdrv_co_pwritev(s->data_file, cluster_offset, out_len, &hd_q=
iov, 0);
     if (ret < 0) {
         goto fail;
     }
@@ -4547,6 +4572,11 @@ static int qcow2_downgrade(BlockDriverState *bs, i=
nt target_version,
         return -ENOTSUP;
     }
=20
+    if (has_data_file(bs)) {
+        error_setg(errp, "Cannot downgrade an image with a data file");
+        return -ENOTSUP;
+    }
+
     /* clear incompatible features */
     if (s->incompatible_features & QCOW2_INCOMPAT_DIRTY) {
         ret =3D qcow2_mark_clean(bs);
--=20
2.20.1
