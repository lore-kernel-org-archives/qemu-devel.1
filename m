Received: from eggs.gnu.org ([209.51.188.92]:59887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2F5w-0000Bs-W7
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:59:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2F5v-0008Jt-0b
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:59:23 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  8 Mar 2019 13:58:13 +0100
Message-Id: <20190308125823.32535-24-kwolf@redhat.com>
In-Reply-To: <20190308125823.32535-1-kwolf@redhat.com>
References: <20190308125823.32535-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 23/33] qcow2: Support external data file in
 qemu-img check
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

For external data files, data clusters must be excluded from the
refcount calculations. Instead, an implicit refcount of 1 is assumed for
the COPIED flag.

Compressed clusters and internal snapshots are incompatible with
external data files, so print an error if they are in use for images
with an external data file.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2-refcount.c | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index df73580e5d..e0fe322500 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1605,6 +1605,13 @@ static int check_refcounts_l2(BlockDriverState *bs=
, BdrvCheckResult *res,
                 res->corruptions++;
             }
=20
+            if (has_data_file(bs)) {
+                fprintf(stderr, "ERROR compressed cluster %d with data f=
ile, "
+                        "entry=3D0x%" PRIx64 "\n", i, l2_entry);
+                res->corruptions++;
+                break;
+            }
+
             /* Mark cluster as used */
             nb_csectors =3D ((l2_entry >> s->csize_shift) &
                            s->csize_mask) + 1;
@@ -1695,11 +1702,13 @@ static int check_refcounts_l2(BlockDriverState *b=
s, BdrvCheckResult *res,
             }
=20
             /* Mark cluster as used */
-            ret =3D qcow2_inc_refcounts_imrt(bs, res,
-                                           refcount_table, refcount_tabl=
e_size,
-                                           offset, s->cluster_size);
-            if (ret < 0) {
-                goto fail;
+            if (!has_data_file(bs)) {
+                ret =3D qcow2_inc_refcounts_imrt(bs, res, refcount_table=
,
+                                               refcount_table_size,
+                                               offset, s->cluster_size);
+                if (ret < 0) {
+                    goto fail;
+                }
             }
             break;
         }
@@ -1884,12 +1893,16 @@ static int check_oflag_copied(BlockDriverState *b=
s, BdrvCheckResult *res,
=20
             if (cluster_type =3D=3D QCOW2_CLUSTER_NORMAL ||
                 cluster_type =3D=3D QCOW2_CLUSTER_ZERO_ALLOC) {
-                ret =3D qcow2_get_refcount(bs,
-                                         data_offset >> s->cluster_bits,
-                                         &refcount);
-                if (ret < 0) {
-                    /* don't print message nor increment check_errors */
-                    continue;
+                if (has_data_file(bs)) {
+                    refcount =3D 1;
+                } else {
+                    ret =3D qcow2_get_refcount(bs,
+                                             data_offset >> s->cluster_b=
its,
+                                             &refcount);
+                    if (ret < 0) {
+                        /* don't print message nor increment check_error=
s */
+                        continue;
+                    }
                 }
                 if ((refcount =3D=3D 1) !=3D ((l2_entry & QCOW_OFLAG_COP=
IED) !=3D 0)) {
                     fprintf(stderr, "%s OFLAG_COPIED data cluster: "
@@ -2083,6 +2096,12 @@ static int calculate_refcounts(BlockDriverState *b=
s, BdrvCheckResult *res,
     }
=20
     /* snapshots */
+    if (has_data_file(bs) && s->nb_snapshots) {
+        fprintf(stderr, "ERROR %d snapshots in image with data file\n",
+                s->nb_snapshots);
+        res->corruptions++;
+    }
+
     for (i =3D 0; i < s->nb_snapshots; i++) {
         sn =3D s->snapshots + i;
         if (offset_into_cluster(s, sn->l1_table_offset)) {
--=20
2.20.1
