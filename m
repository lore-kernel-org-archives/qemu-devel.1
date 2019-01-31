Received: from eggs.gnu.org ([209.51.188.92]:51383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpGZa-0005yY-HA
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 12:56:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpGZX-00059p-6c
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 12:56:22 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 31 Jan 2019 18:55:44 +0100
Message-Id: <20190131175549.11691-7-kwolf@redhat.com>
In-Reply-To: <20190131175549.11691-1-kwolf@redhat.com>
References: <20190131175549.11691-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 06/11] qcow2: Don't assume 0 is an invalid
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
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

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
index b17bd502f5..1f87c45977 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -461,6 +461,8 @@ typedef enum QCow2MetadataOverlap {
=20
 #define REFT_OFFSET_MASK 0xfffffffffffffe00ULL
=20
+#define INV_OFFSET (-1ULL)
+
 static inline bool has_data_file(BlockDriverState *bs)
 {
     BDRVQcow2State *s =3D bs->opaque;
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 73ea0f99d6..4889c166e8 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1106,9 +1106,9 @@ static int handle_dependencies(BlockDriverState *bs=
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
@@ -1140,8 +1140,8 @@ static int handle_copied(BlockDriverState *bs, uint=
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
@@ -1179,7 +1179,7 @@ static int handle_copied(BlockDriverState *bs, uint=
64_t guest_offset,
             goto out;
         }
=20
-        if (*host_offset !=3D 0 && !offset_matches) {
+        if (*host_offset !=3D INV_OFFSET && !offset_matches) {
             *bytes =3D 0;
             ret =3D 0;
             goto out;
@@ -1222,10 +1222,10 @@ out:
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
@@ -1244,7 +1244,7 @@ static int do_alloc_cluster_offset(BlockDriverState=
 *bs, uint64_t guest_offset,
=20
     /* Allocate new clusters */
     trace_qcow2_cluster_alloc_phys(qemu_coroutine_self());
-    if (*host_offset =3D=3D 0) {
+    if (*host_offset =3D=3D INV_OFFSET) {
         int64_t cluster_offset =3D
             qcow2_alloc_clusters(bs, *nb_clusters * s->cluster_size);
         if (cluster_offset < 0) {
@@ -1264,8 +1264,8 @@ static int do_alloc_cluster_offset(BlockDriverState=
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
@@ -1293,7 +1293,7 @@ static int handle_alloc(BlockDriverState *bs, uint6=
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
@@ -1332,7 +1332,7 @@ static int handle_alloc(BlockDriverState *bs, uint6=
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
@@ -1364,9 +1364,10 @@ static int handle_alloc(BlockDriverState *bs, uint=
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
@@ -1379,16 +1380,7 @@ static int handle_alloc(BlockDriverState *bs, uint=
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
@@ -1480,14 +1472,14 @@ int qcow2_alloc_cluster_offset(BlockDriverState *=
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
@@ -1495,7 +1487,10 @@ again:
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
@@ -1567,7 +1562,7 @@ again:
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
