Received: from eggs.gnu.org ([2001:4830:134:3::10]:47661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gZAGF-0006Wc-Bz
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 02:57:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gZAGC-0003lL-8F
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 02:57:51 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Tue, 18 Dec 2018 07:57:45 +0000
Message-ID: <20181218075707.12006-10-anton.nefedov@virtuozzo.com>
References: <20181218075707.12006-1-anton.nefedov@virtuozzo.com>
In-Reply-To: <20181218075707.12006-1-anton.nefedov@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v11 09/10] qcow2: skip writing zero buffers to
 empty COW areas
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>, "berto@igalia.com" <berto@igalia.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>

If COW areas of the newly allocated clusters are zeroes on the backing imag=
e,
efficient bdrv_write_zeroes(flags=3DBDRV_REQ_ALLOCATE) can be used on the w=
hole
cluster instead of writing explicit zero buffers later in perform_cow().

iotest 060:
write to the discarded cluster does not trigger COW anymore.
Use a backing image instead.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 qapi/block-core.json       |  4 +-
 block/qcow2.h              |  6 +++
 block/qcow2-cluster.c      |  2 +-
 block/qcow2.c              | 89 +++++++++++++++++++++++++++++++++++++-
 block/trace-events         |  1 +
 tests/qemu-iotests/060     |  7 ++-
 tests/qemu-iotests/060.out |  5 ++-
 7 files changed, 108 insertions(+), 6 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 762000f31f..204528b3f6 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3009,6 +3009,8 @@
 #
 # @cor_write: a write due to copy-on-read (since 2.11)
 #
+# @cluster_alloc_space: an allocation of file space for a cluster (since 4=
.0)
+#
 # Since: 2.9
 ##
 { 'enum': 'BlkdebugEvent', 'prefix': 'BLKDBG',
@@ -3027,7 +3029,7 @@
             'pwritev_rmw_tail', 'pwritev_rmw_after_tail', 'pwritev',
             'pwritev_zero', 'pwritev_done', 'empty_image_prepare',
             'l1_shrink_write_table', 'l1_shrink_free_l2_clusters',
-            'cor_write'] }
+            'cor_write', 'cluster_alloc_space'] }
=20
 ##
 # @BlkdebugInjectErrorOptions:
diff --git a/block/qcow2.h b/block/qcow2.h
index a98d24500b..32d2c04bfa 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -386,6 +386,12 @@ typedef struct QCowL2Meta
      */
     Qcow2COWRegion cow_end;
=20
+    /*
+     * Indicates that COW regions are already handled and do not require
+     * any more processing.
+     */
+    bool skip_cow;
+
     /**
      * The I/O vector with the data from the actual guest write request.
      * If non-NULL, this is meant to be merged together with the data
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index e2737429f5..23e0702027 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -806,7 +806,7 @@ static int perform_cow(BlockDriverState *bs, QCowL2Meta=
 *m)
     assert(start->offset + start->nb_bytes <=3D end->offset);
     assert(!m->data_qiov || m->data_qiov->size =3D=3D data_bytes);
=20
-    if (start->nb_bytes =3D=3D 0 && end->nb_bytes =3D=3D 0) {
+    if ((start->nb_bytes =3D=3D 0 && end->nb_bytes =3D=3D 0) || m->skip_co=
w) {
         return 0;
     }
=20
diff --git a/block/qcow2.c b/block/qcow2.c
index 4897abae5e..161b935962 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2021,6 +2021,11 @@ static bool merge_cow(uint64_t offset, unsigned byte=
s,
             continue;
         }
=20
+        /* If COW regions are handled already, skip this too */
+        if (m->skip_cow) {
+            continue;
+        }
+
         /* The data (middle) region must be immediately after the
          * start region */
         if (l2meta_cow_start(m) + m->cow_start.nb_bytes !=3D offset) {
@@ -2046,6 +2051,77 @@ static bool merge_cow(uint64_t offset, unsigned byte=
s,
     return false;
 }
=20
+static bool is_unallocated(BlockDriverState *bs, int64_t offset, int64_t b=
ytes)
+{
+    int64_t nr;
+    return !bytes ||
+        (!bdrv_is_allocated_above(bs, NULL, offset, bytes, &nr) && nr =3D=
=3D bytes);
+}
+
+static bool is_zero_cow(BlockDriverState *bs, QCowL2Meta *m)
+{
+    /*
+     * This check is designed for optimization shortcut so it must be
+     * efficient.
+     * Instead of is_zero(), use is_unallocated() as it is faster (but not
+     * as accurate and can result in false negatives).
+     */
+    return is_unallocated(bs, m->offset + m->cow_start.offset,
+                          m->cow_start.nb_bytes) &&
+           is_unallocated(bs, m->offset + m->cow_end.offset,
+                          m->cow_end.nb_bytes);
+}
+
+static int handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2meta)
+{
+    BDRVQcow2State *s =3D bs->opaque;
+    QCowL2Meta *m;
+
+    if (!(bs->file->bs->supported_zero_flags & BDRV_REQ_ALLOCATE)) {
+        return 0;
+    }
+
+    if (bs->encrypted) {
+        return 0;
+    }
+
+    for (m =3D l2meta; m !=3D NULL; m =3D m->next) {
+        int ret;
+
+        if (!m->cow_start.nb_bytes && !m->cow_end.nb_bytes) {
+            continue;
+        }
+
+        if (!is_zero_cow(bs, m)) {
+            continue;
+        }
+
+        /*
+         * Conventional place for qcow2_pre_write_overlap_check() but in t=
his
+         * case it is already done for these clusters
+         */
+
+        BLKDBG_EVENT(bs->file, BLKDBG_CLUSTER_ALLOC_SPACE);
+        /*
+         * instead of writing zero COW buffers,
+         * efficiently zero out the whole clusters
+         */
+        ret =3D bdrv_co_pwrite_zeroes(bs->file, m->alloc_offset,
+                                    m->nb_clusters * s->cluster_size,
+                                    BDRV_REQ_ALLOCATE);
+        if (ret < 0) {
+            if (ret !=3D -ENOTSUP && ret !=3D -EAGAIN) {
+                return ret;
+            }
+            continue;
+        }
+
+        trace_qcow2_skip_cow(qemu_coroutine_self(), m->offset, m->nb_clust=
ers);
+        m->skip_cow =3D true;
+    }
+    return 0;
+}
+
 static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t of=
fset,
                                          uint64_t bytes, QEMUIOVector *qio=
v,
                                          int flags)
@@ -2126,24 +2202,33 @@ static coroutine_fn int qcow2_co_pwritev(BlockDrive=
rState *bs, uint64_t offset,
             goto fail;
         }
=20
+        qemu_co_mutex_unlock(&s->lock);
+
+        ret =3D handle_alloc_space(bs, l2meta);
+        if (ret < 0) {
+            qemu_co_mutex_lock(&s->lock);
+            goto fail;
+        }
+
         /* If we need to do COW, check if it's possible to merge the
          * writing of the guest data together with that of the COW regions=
.
          * If it's not possible (or not necessary) then write the
          * guest data now. */
         if (!merge_cow(offset, cur_bytes, &hd_qiov, l2meta)) {
-            qemu_co_mutex_unlock(&s->lock);
             BLKDBG_EVENT(bs->file, BLKDBG_WRITE_AIO);
             trace_qcow2_writev_data(qemu_coroutine_self(),
                                     cluster_offset + offset_in_cluster);
             ret =3D bdrv_co_pwritev(bs->file,
                                   cluster_offset + offset_in_cluster,
                                   cur_bytes, &hd_qiov, 0);
-            qemu_co_mutex_lock(&s->lock);
             if (ret < 0) {
+                qemu_co_mutex_lock(&s->lock);
                 goto fail;
             }
         }
=20
+        qemu_co_mutex_lock(&s->lock);
+
         ret =3D qcow2_handle_l2meta(bs, &l2meta, true);
         if (ret) {
             goto fail;
diff --git a/block/trace-events b/block/trace-events
index 3e8c47bb24..f3f6d66dcc 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -69,6 +69,7 @@ qcow2_writev_done_part(void *co, int cur_bytes) "co %p cu=
r_bytes %d"
 qcow2_writev_data(void *co, uint64_t offset) "co %p offset 0x%" PRIx64
 qcow2_pwrite_zeroes_start_req(void *co, int64_t offset, int count) "co %p =
offset 0x%" PRIx64 " count %d"
 qcow2_pwrite_zeroes(void *co, int64_t offset, int count) "co %p offset 0x%=
" PRIx64 " count %d"
+qcow2_skip_cow(void *co, uint64_t offset, int nb_clusters) "co %p offset 0=
x%" PRIx64 " nb_clusters %d"
=20
 # block/qcow2-cluster.c
 qcow2_alloc_clusters_offset(void *co, uint64_t offset, int bytes) "co %p o=
ffset 0x%" PRIx64 " bytes %d"
diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index af0588ae9a..163fb075ea 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -150,10 +150,15 @@ $QEMU_IO -c "$OPEN_RO" -c "read -P 1 0 512" | _filter=
_qemu_io
 echo
 echo "=3D=3D=3D Testing overlap while COW is in flight =3D=3D=3D"
 echo
+BACKING_IMG=3D$TEST_IMG.base
+TEST_IMG=3D$BACKING_IMG _make_test_img 1G
+
+$QEMU_IO -c 'write 0k 64k' "$BACKING_IMG" | _filter_qemu_io
+
 # compat=3D0.10 is required in order to make the following discard actuall=
y
 # unallocate the sector rather than make it a zero sector - we want COW, a=
fter
 # all.
-IMGOPTS=3D'compat=3D0.10' _make_test_img 1G
+IMGOPTS=3D'compat=3D0.10' _make_test_img -b "$BACKING_IMG" 1G
 # Write two clusters, the second one enforces creation of an L2 table afte=
r
 # the first data cluster.
 $QEMU_IO -c 'write 0k 64k' -c 'write 512M 64k' "$TEST_IMG" | _filter_qemu_=
io
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index d67c6234a4..1d582d4b36 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -97,7 +97,10 @@ read 512/512 bytes at offset 0
=20
 =3D=3D=3D Testing overlap while COW is in flight =3D=3D=3D
=20
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D1073741824
+wrote 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824 backing_fil=
e=3DTEST_DIR/t.IMGFMT.base
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 65536/65536 bytes at offset 536870912
--=20
2.17.1
