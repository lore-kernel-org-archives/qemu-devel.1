Received: from eggs.gnu.org ([209.51.188.92]:51323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpGZO-0005oH-71
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 12:56:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpGZM-00056w-JK
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 12:56:10 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 31 Jan 2019 18:55:41 +0100
Message-Id: <20190131175549.11691-4-kwolf@redhat.com>
In-Reply-To: <20190131175549.11691-1-kwolf@redhat.com>
References: <20190131175549.11691-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 03/11] qcow2: Pass bs to
 qcow2_get_cluster_type()
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

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.h          |  3 ++-
 block/qcow2-cluster.c  | 37 +++++++++++++++++++------------------
 block/qcow2-refcount.c | 10 +++++-----
 3 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index a242a43fe7..2cb763bf11 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -508,7 +508,8 @@ static inline int64_t qcow2_vm_state_offset(BDRVQcow2=
State *s)
     return (int64_t)s->l1_vm_state_index << (s->cluster_bits + s->l2_bit=
s);
 }
=20
-static inline QCow2ClusterType qcow2_get_cluster_type(uint64_t l2_entry)
+static inline QCow2ClusterType qcow2_get_cluster_type(BlockDriverState *=
bs,
+                                                      uint64_t l2_entry)
 {
     if (l2_entry & QCOW_OFLAG_COMPRESSED) {
         return QCOW2_CLUSTER_COMPRESSED;
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 30eca26c47..7c86e3f205 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -377,8 +377,8 @@ fail:
  * as contiguous. (This allows it, for example, to stop at the first com=
pressed
  * cluster which may require a different handling)
  */
-static int count_contiguous_clusters(int nb_clusters, int cluster_size,
-        uint64_t *l2_slice, uint64_t stop_flags)
+static int count_contiguous_clusters(BlockDriverState *bs, int nb_cluste=
rs,
+        int cluster_size, uint64_t *l2_slice, uint64_t stop_flags)
 {
     int i;
     QCow2ClusterType first_cluster_type;
@@ -391,7 +391,7 @@ static int count_contiguous_clusters(int nb_clusters,=
 int cluster_size,
     }
=20
     /* must be allocated */
-    first_cluster_type =3D qcow2_get_cluster_type(first_entry);
+    first_cluster_type =3D qcow2_get_cluster_type(bs, first_entry);
     assert(first_cluster_type =3D=3D QCOW2_CLUSTER_NORMAL ||
            first_cluster_type =3D=3D QCOW2_CLUSTER_ZERO_ALLOC);
=20
@@ -409,7 +409,8 @@ static int count_contiguous_clusters(int nb_clusters,=
 int cluster_size,
  * Checks how many consecutive unallocated clusters in a given L2
  * slice have the same cluster type.
  */
-static int count_contiguous_clusters_unallocated(int nb_clusters,
+static int count_contiguous_clusters_unallocated(BlockDriverState *bs,
+                                                 int nb_clusters,
                                                  uint64_t *l2_slice,
                                                  QCow2ClusterType wanted=
_type)
 {
@@ -419,7 +420,7 @@ static int count_contiguous_clusters_unallocated(int =
nb_clusters,
            wanted_type =3D=3D QCOW2_CLUSTER_UNALLOCATED);
     for (i =3D 0; i < nb_clusters; i++) {
         uint64_t entry =3D be64_to_cpu(l2_slice[i]);
-        QCow2ClusterType type =3D qcow2_get_cluster_type(entry);
+        QCow2ClusterType type =3D qcow2_get_cluster_type(bs, entry);
=20
         if (type !=3D wanted_type) {
             break;
@@ -592,7 +593,7 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, ui=
nt64_t offset,
      * true */
     assert(nb_clusters <=3D INT_MAX);
=20
-    type =3D qcow2_get_cluster_type(*cluster_offset);
+    type =3D qcow2_get_cluster_type(bs, *cluster_offset);
     if (s->qcow_version < 3 && (type =3D=3D QCOW2_CLUSTER_ZERO_PLAIN ||
                                 type =3D=3D QCOW2_CLUSTER_ZERO_ALLOC)) {
         qcow2_signal_corruption(bs, true, -1, -1, "Zero cluster entry fo=
und"
@@ -610,14 +611,14 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, =
uint64_t offset,
     case QCOW2_CLUSTER_ZERO_PLAIN:
     case QCOW2_CLUSTER_UNALLOCATED:
         /* how many empty clusters ? */
-        c =3D count_contiguous_clusters_unallocated(nb_clusters,
+        c =3D count_contiguous_clusters_unallocated(bs, nb_clusters,
                                                   &l2_slice[l2_index], t=
ype);
         *cluster_offset =3D 0;
         break;
     case QCOW2_CLUSTER_ZERO_ALLOC:
     case QCOW2_CLUSTER_NORMAL:
         /* how many allocated clusters ? */
-        c =3D count_contiguous_clusters(nb_clusters, s->cluster_size,
+        c =3D count_contiguous_clusters(bs, nb_clusters, s->cluster_size=
,
                                       &l2_slice[l2_index], QCOW_OFLAG_ZE=
RO);
         *cluster_offset &=3D L2E_OFFSET_MASK;
         if (offset_into_cluster(s, *cluster_offset)) {
@@ -1010,14 +1011,14 @@ void qcow2_alloc_cluster_abort(BlockDriverState *=
bs, QCowL2Meta *m)
  * write, but require COW to be performed (this includes yet unallocated=
 space,
  * which must copy from the backing file)
  */
-static int count_cow_clusters(BDRVQcow2State *s, int nb_clusters,
+static int count_cow_clusters(BlockDriverState *bs, int nb_clusters,
     uint64_t *l2_slice, int l2_index)
 {
     int i;
=20
     for (i =3D 0; i < nb_clusters; i++) {
         uint64_t l2_entry =3D be64_to_cpu(l2_slice[l2_index + i]);
-        QCow2ClusterType cluster_type =3D qcow2_get_cluster_type(l2_entr=
y);
+        QCow2ClusterType cluster_type =3D qcow2_get_cluster_type(bs, l2_=
entry);
=20
         switch(cluster_type) {
         case QCOW2_CLUSTER_NORMAL:
@@ -1162,7 +1163,7 @@ static int handle_copied(BlockDriverState *bs, uint=
64_t guest_offset,
     cluster_offset =3D be64_to_cpu(l2_slice[l2_index]);
=20
     /* Check how many clusters are already allocated and don't need COW =
*/
-    if (qcow2_get_cluster_type(cluster_offset) =3D=3D QCOW2_CLUSTER_NORM=
AL
+    if (qcow2_get_cluster_type(bs, cluster_offset) =3D=3D QCOW2_CLUSTER_=
NORMAL
         && (cluster_offset & QCOW_OFLAG_COPIED))
     {
         /* If a specific host_offset is required, check it */
@@ -1186,7 +1187,7 @@ static int handle_copied(BlockDriverState *bs, uint=
64_t guest_offset,
=20
         /* We keep all QCOW_OFLAG_COPIED clusters */
         keep_clusters =3D
-            count_contiguous_clusters(nb_clusters, s->cluster_size,
+            count_contiguous_clusters(bs, nb_clusters, s->cluster_size,
                                       &l2_slice[l2_index],
                                       QCOW_OFLAG_COPIED | QCOW_OFLAG_ZER=
O);
         assert(keep_clusters <=3D nb_clusters);
@@ -1321,7 +1322,7 @@ static int handle_alloc(BlockDriverState *bs, uint6=
4_t guest_offset,
     if (entry & QCOW_OFLAG_COMPRESSED) {
         nb_clusters =3D 1;
     } else {
-        nb_clusters =3D count_cow_clusters(s, nb_clusters, l2_slice, l2_=
index);
+        nb_clusters =3D count_cow_clusters(bs, nb_clusters, l2_slice, l2=
_index);
     }
=20
     /* This function is only called when there were no non-COW clusters,=
 so if
@@ -1329,7 +1330,7 @@ static int handle_alloc(BlockDriverState *bs, uint6=
4_t guest_offset,
      * wrong with our code. */
     assert(nb_clusters > 0);
=20
-    if (qcow2_get_cluster_type(entry) =3D=3D QCOW2_CLUSTER_ZERO_ALLOC &&
+    if (qcow2_get_cluster_type(bs, entry) =3D=3D QCOW2_CLUSTER_ZERO_ALLO=
C &&
         (entry & QCOW_OFLAG_COPIED) &&
         (!*host_offset ||
          start_of_cluster(s, *host_offset) =3D=3D (entry & L2E_OFFSET_MA=
SK)))
@@ -1349,7 +1350,7 @@ static int handle_alloc(BlockDriverState *bs, uint6=
4_t guest_offset,
          * would be fine, too, but count_cow_clusters() above has limite=
d
          * nb_clusters already to a range of COW clusters */
         preallocated_nb_clusters =3D
-            count_contiguous_clusters(nb_clusters, s->cluster_size,
+            count_contiguous_clusters(bs, nb_clusters, s->cluster_size,
                                       &l2_slice[l2_index], QCOW_OFLAG_CO=
PIED);
         assert(preallocated_nb_clusters > 0);
=20
@@ -1613,7 +1614,7 @@ static int discard_in_l2_slice(BlockDriverState *bs=
, uint64_t offset,
          * If full_discard is true, the sector should not read back as z=
eroes,
          * but rather fall through to the backing file.
          */
-        switch (qcow2_get_cluster_type(old_l2_entry)) {
+        switch (qcow2_get_cluster_type(bs, old_l2_entry)) {
         case QCOW2_CLUSTER_UNALLOCATED:
             if (full_discard || !bs->backing) {
                 continue;
@@ -1726,7 +1727,7 @@ static int zero_in_l2_slice(BlockDriverState *bs, u=
int64_t offset,
          * Minimize L2 changes if the cluster already reads back as
          * zeroes with correct allocation.
          */
-        cluster_type =3D qcow2_get_cluster_type(old_offset);
+        cluster_type =3D qcow2_get_cluster_type(bs, old_offset);
         if (cluster_type =3D=3D QCOW2_CLUSTER_ZERO_PLAIN ||
             (cluster_type =3D=3D QCOW2_CLUSTER_ZERO_ALLOC && !unmap)) {
             continue;
@@ -1868,7 +1869,7 @@ static int expand_zero_clusters_in_l1(BlockDriverSt=
ate *bs, uint64_t *l1_table,
                 uint64_t l2_entry =3D be64_to_cpu(l2_slice[j]);
                 int64_t offset =3D l2_entry & L2E_OFFSET_MASK;
                 QCow2ClusterType cluster_type =3D
-                    qcow2_get_cluster_type(l2_entry);
+                    qcow2_get_cluster_type(bs, l2_entry);
=20
                 if (cluster_type !=3D QCOW2_CLUSTER_ZERO_PLAIN &&
                     cluster_type !=3D QCOW2_CLUSTER_ZERO_ALLOC) {
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 6f13d470d3..05e7974d7e 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1157,7 +1157,7 @@ void qcow2_free_any_clusters(BlockDriverState *bs, =
uint64_t l2_entry,
 {
     BDRVQcow2State *s =3D bs->opaque;
=20
-    switch (qcow2_get_cluster_type(l2_entry)) {
+    switch (qcow2_get_cluster_type(bs, l2_entry)) {
     case QCOW2_CLUSTER_COMPRESSED:
         {
             int nb_csectors;
@@ -1300,7 +1300,7 @@ int qcow2_update_snapshot_refcount(BlockDriverState=
 *bs,
                     entry &=3D ~QCOW_OFLAG_COPIED;
                     offset =3D entry & L2E_OFFSET_MASK;
=20
-                    switch (qcow2_get_cluster_type(entry)) {
+                    switch (qcow2_get_cluster_type(bs, entry)) {
                     case QCOW2_CLUSTER_COMPRESSED:
                         nb_csectors =3D ((entry >> s->csize_shift) &
                                        s->csize_mask) + 1;
@@ -1582,7 +1582,7 @@ static int check_refcounts_l2(BlockDriverState *bs,=
 BdrvCheckResult *res,
     for(i =3D 0; i < s->l2_size; i++) {
         l2_entry =3D be64_to_cpu(l2_table[i]);
=20
-        switch (qcow2_get_cluster_type(l2_entry)) {
+        switch (qcow2_get_cluster_type(bs, l2_entry)) {
         case QCOW2_CLUSTER_COMPRESSED:
             /* Compressed clusters don't have QCOW_OFLAG_COPIED */
             if (l2_entry & QCOW_OFLAG_COPIED) {
@@ -1633,7 +1633,7 @@ static int check_refcounts_l2(BlockDriverState *bs,=
 BdrvCheckResult *res,
=20
             /* Correct offsets are cluster aligned */
             if (offset_into_cluster(s, offset)) {
-                if (qcow2_get_cluster_type(l2_entry) =3D=3D
+                if (qcow2_get_cluster_type(bs, l2_entry) =3D=3D
                     QCOW2_CLUSTER_ZERO_ALLOC)
                 {
                     fprintf(stderr, "%s offset=3D%" PRIx64 ": Preallocat=
ed zero "
@@ -1868,7 +1868,7 @@ static int check_oflag_copied(BlockDriverState *bs,=
 BdrvCheckResult *res,
         for (j =3D 0; j < s->l2_size; j++) {
             uint64_t l2_entry =3D be64_to_cpu(l2_table[j]);
             uint64_t data_offset =3D l2_entry & L2E_OFFSET_MASK;
-            QCow2ClusterType cluster_type =3D qcow2_get_cluster_type(l2_=
entry);
+            QCow2ClusterType cluster_type =3D qcow2_get_cluster_type(bs,=
 l2_entry);
=20
             if (cluster_type =3D=3D QCOW2_CLUSTER_NORMAL ||
                 cluster_type =3D=3D QCOW2_CLUSTER_ZERO_ALLOC) {
--=20
2.20.1
