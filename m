Received: from eggs.gnu.org ([209.51.188.92]:48701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUup-000807-O2
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUun-00023g-8Q
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:31 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 30 Apr 2019 17:42:27 +0200
Message-Id: <20190430154244.30083-11-kwolf@redhat.com>
In-Reply-To: <20190430154244.30083-1-kwolf@redhat.com>
References: <20190430154244.30083-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/27] qcow2: Add errp to preallocate_co()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

We'll add a bdrv_co_truncate() call in the next patch which can return
an Error that we don't want to discard. So add an errp parameter to
preallocate_co().

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/qcow2.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index dfac74c264..b4f9f5a240 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2721,7 +2721,7 @@ static int qcow2_set_up_encryption(BlockDriverState=
 *bs,
  * Returns: 0 on success, -errno on failure.
  */
 static int coroutine_fn preallocate_co(BlockDriverState *bs, uint64_t of=
fset,
-                                       uint64_t new_length)
+                                       uint64_t new_length, Error **errp=
)
 {
     BDRVQcow2State *s =3D bs->opaque;
     uint64_t bytes;
@@ -2738,6 +2738,7 @@ static int coroutine_fn preallocate_co(BlockDriverS=
tate *bs, uint64_t offset,
         ret =3D qcow2_alloc_cluster_offset(bs, offset, &cur_bytes,
                                          &host_offset, &meta);
         if (ret < 0) {
+            error_setg_errno(errp, -ret, "Allocating clusters failed");
             return ret;
         }
=20
@@ -2746,6 +2747,7 @@ static int coroutine_fn preallocate_co(BlockDriverS=
tate *bs, uint64_t offset,
=20
             ret =3D qcow2_alloc_cluster_link_l2(bs, meta);
             if (ret < 0) {
+                error_setg_errno(errp, -ret, "Mapping clusters failed");
                 qcow2_free_any_clusters(bs, meta->alloc_offset,
                                         meta->nb_clusters, QCOW2_DISCARD=
_NEVER);
                 return ret;
@@ -2775,6 +2777,7 @@ static int coroutine_fn preallocate_co(BlockDriverS=
tate *bs, uint64_t offset,
         ret =3D bdrv_pwrite(s->data_file, (host_offset + cur_bytes) - 1,
                           &data, 1);
         if (ret < 0) {
+            error_setg_errno(errp, -ret, "Writing to EOF failed");
             return ret;
         }
     }
@@ -3748,9 +3751,8 @@ static int coroutine_fn qcow2_co_truncate(BlockDriv=
erState *bs, int64_t offset,
         break;
=20
     case PREALLOC_MODE_METADATA:
-        ret =3D preallocate_co(bs, old_length, offset);
+        ret =3D preallocate_co(bs, old_length, offset, errp);
         if (ret < 0) {
-            error_setg_errno(errp, -ret, "Preallocation failed");
             goto fail;
         }
         break;
@@ -3766,9 +3768,8 @@ static int coroutine_fn qcow2_co_truncate(BlockDriv=
erState *bs, int64_t offset,
         /* With a data file, preallocation means just allocating the met=
adata
          * and forwarding the truncate request to the data file */
         if (has_data_file(bs)) {
-            ret =3D preallocate_co(bs, old_length, offset);
+            ret =3D preallocate_co(bs, old_length, offset, errp);
             if (ret < 0) {
-                error_setg_errno(errp, -ret, "Preallocation failed");
                 goto fail;
             }
             break;
--=20
2.20.1
