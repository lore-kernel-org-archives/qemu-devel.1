Received: from eggs.gnu.org ([209.51.188.92]:59856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2F5v-0000Ae-1P
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:59:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2F5t-0008CO-Jh
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:59:22 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  8 Mar 2019 13:58:09 +0100
Message-Id: <20190308125823.32535-20-kwolf@redhat.com>
In-Reply-To: <20190308125823.32535-1-kwolf@redhat.com>
References: <20190308125823.32535-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 19/33] qcow2: Return 0/-errno in
 qcow2_alloc_compressed_cluster_offset()
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

qcow2_alloc_compressed_cluster_offset() used to return the cluster
offset for success and 0 for error. This doesn't only conflict with 0 as
a valid host offset, but also loses the error code.

Similar to the change made to qcow2_alloc_cluster_offset() for
uncompressed clusters in commit 148da7ea9d6, make the function return
0/-errno and return the allocated cluster offset in a by-reference
parameter.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.h              |  7 ++++---
 block/qcow2-cluster.c      | 28 +++++++++++++---------------
 block/qcow2.c              | 19 ++++++++-----------
 tests/qemu-iotests/220.out |  2 +-
 4 files changed, 26 insertions(+), 30 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index e3bf322be1..fad6abf602 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -647,9 +647,10 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, u=
int64_t offset,
 int qcow2_alloc_cluster_offset(BlockDriverState *bs, uint64_t offset,
                                unsigned int *bytes, uint64_t *host_offse=
t,
                                QCowL2Meta **m);
-uint64_t qcow2_alloc_compressed_cluster_offset(BlockDriverState *bs,
-                                         uint64_t offset,
-                                         int compressed_size);
+int qcow2_alloc_compressed_cluster_offset(BlockDriverState *bs,
+                                          uint64_t offset,
+                                          int compressed_size,
+                                          uint64_t *host_offset);
=20
 int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m);
 void qcow2_alloc_cluster_abort(BlockDriverState *bs, QCowL2Meta *m);
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 1d09f5454e..8c4b4005ff 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -736,19 +736,16 @@ static int get_cluster_table(BlockDriverState *bs, =
uint64_t offset,
 /*
  * alloc_compressed_cluster_offset
  *
- * For a given offset of the disk image, return cluster offset in
- * qcow2 file.
- *
- * If the offset is not found, allocate a new compressed cluster.
- *
- * Return the cluster offset if successful,
- * Return 0, otherwise.
+ * For a given offset on the virtual disk, allocate a new compressed clu=
ster
+ * and put the host offset of the cluster into *host_offset. If a cluste=
r is
+ * already allocated at the offset, return an error.
  *
+ * Return 0 on success and -errno in error cases
  */
-
-uint64_t qcow2_alloc_compressed_cluster_offset(BlockDriverState *bs,
-                                               uint64_t offset,
-                                               int compressed_size)
+int qcow2_alloc_compressed_cluster_offset(BlockDriverState *bs,
+                                          uint64_t offset,
+                                          int compressed_size,
+                                          uint64_t *host_offset)
 {
     BDRVQcow2State *s =3D bs->opaque;
     int l2_index, ret;
@@ -758,7 +755,7 @@ uint64_t qcow2_alloc_compressed_cluster_offset(BlockD=
riverState *bs,
=20
     ret =3D get_cluster_table(bs, offset, &l2_slice, &l2_index);
     if (ret < 0) {
-        return 0;
+        return ret;
     }
=20
     /* Compression can't overwrite anything. Fail if the cluster was alr=
eady
@@ -766,13 +763,13 @@ uint64_t qcow2_alloc_compressed_cluster_offset(Bloc=
kDriverState *bs,
     cluster_offset =3D be64_to_cpu(l2_slice[l2_index]);
     if (cluster_offset & L2E_OFFSET_MASK) {
         qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
-        return 0;
+        return -EIO;
     }
=20
     cluster_offset =3D qcow2_alloc_bytes(bs, compressed_size);
     if (cluster_offset < 0) {
         qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
-        return 0;
+        return cluster_offset;
     }
=20
     nb_csectors =3D ((cluster_offset + compressed_size - 1) >> 9) -
@@ -790,7 +787,8 @@ uint64_t qcow2_alloc_compressed_cluster_offset(BlockD=
riverState *bs,
     l2_slice[l2_index] =3D cpu_to_be64(cluster_offset);
     qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
=20
-    return cluster_offset;
+    *host_offset =3D cluster_offset & s->cluster_offset_mask;
+    return 0;
 }
=20
 static int perform_cow(BlockDriverState *bs, QCowL2Meta *m)
diff --git a/block/qcow2.c b/block/qcow2.c
index 59cf706dc2..eaccd1c11a 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3896,17 +3896,16 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs,=
 uint64_t offset,
     int ret;
     size_t out_len;
     uint8_t *buf, *out_buf;
-    int64_t cluster_offset;
+    uint64_t cluster_offset;
=20
     if (bytes =3D=3D 0) {
         /* align end of file to a sector boundary to ease reading with
            sector based I/Os */
-        cluster_offset =3D bdrv_getlength(bs->file->bs);
-        if (cluster_offset < 0) {
-            return cluster_offset;
+        int64_t len =3D bdrv_getlength(bs->file->bs);
+        if (len < 0) {
+            return len;
         }
-        return bdrv_co_truncate(bs->file, cluster_offset, PREALLOC_MODE_=
OFF,
-                                NULL);
+        return bdrv_co_truncate(bs->file, len, PREALLOC_MODE_OFF, NULL);
     }
=20
     if (offset_into_cluster(s, offset)) {
@@ -3943,14 +3942,12 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs,=
 uint64_t offset,
     }
=20
     qemu_co_mutex_lock(&s->lock);
-    cluster_offset =3D
-        qcow2_alloc_compressed_cluster_offset(bs, offset, out_len);
-    if (!cluster_offset) {
+    ret =3D qcow2_alloc_compressed_cluster_offset(bs, offset, out_len,
+                                                &cluster_offset);
+    if (ret < 0) {
         qemu_co_mutex_unlock(&s->lock);
-        ret =3D -EIO;
         goto fail;
     }
-    cluster_offset &=3D s->cluster_offset_mask;
=20
     ret =3D qcow2_pre_write_overlap_check(bs, 0, cluster_offset, out_len=
);
     qemu_co_mutex_unlock(&s->lock);
diff --git a/tests/qemu-iotests/220.out b/tests/qemu-iotests/220.out
index af3021fd88..33b994b8a1 100644
--- a/tests/qemu-iotests/220.out
+++ b/tests/qemu-iotests/220.out
@@ -38,7 +38,7 @@ wrote 2097152/2097152 bytes at offset 37748736
 No errors were found on the image.
 image size 39845888
 =3D=3D Trying to write compressed cluster =3D=3D
-write failed: Input/output error
+write failed: File too large
 image size 562949957615616
 =3D=3D Writing normal cluster =3D=3D
 wrote 2097152/2097152 bytes at offset 0
--=20
2.20.1
