Received: from eggs.gnu.org ([209.51.188.92]:59706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2F5o-0008Vo-Qh
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:59:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2F5l-0007Rm-8L
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:59:16 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  8 Mar 2019 13:58:08 +0100
Message-Id: <20190308125823.32535-19-kwolf@redhat.com>
In-Reply-To: <20190308125823.32535-1-kwolf@redhat.com>
References: <20190308125823.32535-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 18/33] qcow2: Don't assume 0 is an invalid
 cluster offset
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

The cluster allocation code uses 0 as an invalid offset that is used in
case of errors or as "offset not yet determined". With external data
files, a host cluster offset of 0 becomes valid, though.

Define a constant INV_OFFSET (which is not cluster aligned and will
therefore never be a valid offset) that can be used for such purposes.

This removes the additional host_offset =3D=3D 0 check that commit
ff52aab2df5 introduced; the confusion between an invalid offset and
(erroneous) allocation at offset 0 is removed with this change.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.h         |  2 ++
 block/qcow2-cluster.c | 59 ++++++++++++++++++++-----------------------
 2 files changed, 29 insertions(+), 32 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 8fe2d55005..e3bf322be1 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -463,6 +463,8 @@ typedef enum QCow2MetadataOverlap {
=20
 #define REFT_OFFSET_MASK 0xfffffffffffffe00ULL
=20
+#define INV_OFFSET (-1ULL)
+
 static inline bool has_data_file(BlockDriverState *bs)
 {
     BDRVQcow2State *s =3D bs->opaque;
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 660161bf00..1d09f5454e 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1109,9 +1109,9 @@ static int handle_dependencies(BlockDriverState *bs=
, uint64_t guest_offset,
=20
 /*
  * Checks how many already allocated clusters that don't require a copy =
on
- * write there are at the given guest_offset (up to *bytes). If
- * *host_offset is not zero, only physically contiguous clusters beginni=
ng at
- * this host offset are counted.
+ * write there are at the given guest_offset (up to *bytes). If *host_of=
fset is
+ * not INV_OFFSET, only physically contiguous clusters beginning at this=
 host
+ * offset are counted.
  *
  * Note that guest_offset may not be cluster aligned. In this case, the
  * returned *host_offset points to exact byte referenced by guest_offset=
 and
@@ -1143,8 +1143,8 @@ static int handle_copied(BlockDriverState *bs, uint=
64_t guest_offset,
     trace_qcow2_handle_copied(qemu_coroutine_self(), guest_offset, *host=
_offset,
                               *bytes);
=20
-    assert(*host_offset =3D=3D 0 ||    offset_into_cluster(s, guest_offs=
et)
-                                =3D=3D offset_into_cluster(s, *host_offs=
et));
+    assert(*host_offset =3D=3D INV_OFFSET || offset_into_cluster(s, gues=
t_offset)
+                                      =3D=3D offset_into_cluster(s, *hos=
t_offset));
=20
     /*
      * Calculate the number of clusters to look for. We stop at L2 slice
@@ -1182,7 +1182,7 @@ static int handle_copied(BlockDriverState *bs, uint=
64_t guest_offset,
             goto out;
         }
=20
-        if (*host_offset !=3D 0 && !offset_matches) {
+        if (*host_offset !=3D INV_OFFSET && !offset_matches) {
             *bytes =3D 0;
             ret =3D 0;
             goto out;
@@ -1225,10 +1225,10 @@ out:
  * contain the number of clusters that have been allocated and are conti=
guous
  * in the image file.
  *
- * If *host_offset is non-zero, it specifies the offset in the image fil=
e at
- * which the new clusters must start. *nb_clusters can be 0 on return in=
 this
- * case if the cluster at host_offset is already in use. If *host_offset=
 is
- * zero, the clusters can be allocated anywhere in the image file.
+ * If *host_offset is not INV_OFFSET, it specifies the offset in the ima=
ge file
+ * at which the new clusters must start. *nb_clusters can be 0 on return=
 in
+ * this case if the cluster at host_offset is already in use. If *host_o=
ffset
+ * is INV_OFFSET, the clusters can be allocated anywhere in the image fi=
le.
  *
  * *host_offset is updated to contain the offset into the image file at =
which
  * the first allocated cluster starts.
@@ -1247,7 +1247,7 @@ static int do_alloc_cluster_offset(BlockDriverState=
 *bs, uint64_t guest_offset,
=20
     /* Allocate new clusters */
     trace_qcow2_cluster_alloc_phys(qemu_coroutine_self());
-    if (*host_offset =3D=3D 0) {
+    if (*host_offset =3D=3D INV_OFFSET) {
         int64_t cluster_offset =3D
             qcow2_alloc_clusters(bs, *nb_clusters * s->cluster_size);
         if (cluster_offset < 0) {
@@ -1267,8 +1267,8 @@ static int do_alloc_cluster_offset(BlockDriverState=
 *bs, uint64_t guest_offset,
=20
 /*
  * Allocates new clusters for an area that either is yet unallocated or =
needs a
- * copy on write. If *host_offset is non-zero, clusters are only allocat=
ed if
- * the new allocation can match the specified host offset.
+ * copy on write. If *host_offset is not INV_OFFSET, clusters are only
+ * allocated if the new allocation can match the specified host offset.
  *
  * Note that guest_offset may not be cluster aligned. In this case, the
  * returned *host_offset points to exact byte referenced by guest_offset=
 and
@@ -1296,7 +1296,7 @@ static int handle_alloc(BlockDriverState *bs, uint6=
4_t guest_offset,
     int ret;
     bool keep_old_clusters =3D false;
=20
-    uint64_t alloc_cluster_offset =3D 0;
+    uint64_t alloc_cluster_offset =3D INV_OFFSET;
=20
     trace_qcow2_handle_alloc(qemu_coroutine_self(), guest_offset, *host_=
offset,
                              *bytes);
@@ -1335,7 +1335,7 @@ static int handle_alloc(BlockDriverState *bs, uint6=
4_t guest_offset,
=20
     if (qcow2_get_cluster_type(bs, entry) =3D=3D QCOW2_CLUSTER_ZERO_ALLO=
C &&
         (entry & QCOW_OFLAG_COPIED) &&
-        (!*host_offset ||
+        (*host_offset =3D=3D INV_OFFSET ||
          start_of_cluster(s, *host_offset) =3D=3D (entry & L2E_OFFSET_MA=
SK)))
     {
         int preallocated_nb_clusters;
@@ -1367,9 +1367,10 @@ static int handle_alloc(BlockDriverState *bs, uint=
64_t guest_offset,
=20
     qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
=20
-    if (!alloc_cluster_offset) {
+    if (alloc_cluster_offset =3D=3D INV_OFFSET) {
         /* Allocate, if necessary at a given offset in the image file */
-        alloc_cluster_offset =3D start_of_cluster(s, *host_offset);
+        alloc_cluster_offset =3D *host_offset =3D=3D INV_OFFSET ? INV_OF=
FSET :
+                               start_of_cluster(s, *host_offset);
         ret =3D do_alloc_cluster_offset(bs, guest_offset, &alloc_cluster=
_offset,
                                       &nb_clusters);
         if (ret < 0) {
@@ -1382,16 +1383,7 @@ static int handle_alloc(BlockDriverState *bs, uint=
64_t guest_offset,
             return 0;
         }
=20
-        /* !*host_offset would overwrite the image header and is reserve=
d for
-         * "no host offset preferred". If 0 was a valid host offset, it'=
d
-         * trigger the following overlap check; do that now to avoid hav=
ing an
-         * invalid value in *host_offset. */
-        if (!alloc_cluster_offset) {
-            ret =3D qcow2_pre_write_overlap_check(bs, 0, alloc_cluster_o=
ffset,
-                                                nb_clusters * s->cluster=
_size);
-            assert(ret < 0);
-            goto fail;
-        }
+        assert(alloc_cluster_offset !=3D INV_OFFSET);
     }
=20
     /*
@@ -1483,14 +1475,14 @@ int qcow2_alloc_cluster_offset(BlockDriverState *=
bs, uint64_t offset,
 again:
     start =3D offset;
     remaining =3D *bytes;
-    cluster_offset =3D 0;
-    *host_offset =3D 0;
+    cluster_offset =3D INV_OFFSET;
+    *host_offset =3D INV_OFFSET;
     cur_bytes =3D 0;
     *m =3D NULL;
=20
     while (true) {
=20
-        if (!*host_offset) {
+        if (*host_offset =3D=3D INV_OFFSET && cluster_offset !=3D INV_OF=
FSET) {
             *host_offset =3D start_of_cluster(s, cluster_offset);
         }
=20
@@ -1498,7 +1490,10 @@ again:
=20
         start           +=3D cur_bytes;
         remaining       -=3D cur_bytes;
-        cluster_offset  +=3D cur_bytes;
+
+        if (cluster_offset !=3D INV_OFFSET) {
+            cluster_offset +=3D cur_bytes;
+        }
=20
         if (remaining =3D=3D 0) {
             break;
@@ -1570,7 +1565,7 @@ again:
=20
     *bytes -=3D remaining;
     assert(*bytes > 0);
-    assert(*host_offset !=3D 0);
+    assert(*host_offset !=3D INV_OFFSET);
=20
     return 0;
 }
--=20
2.20.1
