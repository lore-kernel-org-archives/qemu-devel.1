Received: from eggs.gnu.org ([209.51.188.92]:38067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gxBVL-0002SV-NQ
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:08:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gxBVF-0001wf-UQ
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:08:39 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 22 Feb 2019 14:07:39 +0000
Message-Id: <20190222140756.29834-11-stefanha@redhat.com>
In-Reply-To: <20190222140756.29834-1-stefanha@redhat.com>
References: <20190222140756.29834-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/27] block/qed: use qemu_iovec_init_buf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Use new qemu_iovec_init_buf() instead of
qemu_iovec_init_external( ... , 1), which simplifies the code.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20190218140926.333779-11-vsementsov@virtuozzo.com
Message-Id: <20190218140926.333779-11-vsementsov@virtuozzo.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/qed-table.c | 16 +++-------------
 block/qed.c       | 31 +++++++++----------------------
 2 files changed, 12 insertions(+), 35 deletions(-)

diff --git a/block/qed-table.c b/block/qed-table.c
index 7df5680adb..c497bd4aec 100644
--- a/block/qed-table.c
+++ b/block/qed-table.c
@@ -21,16 +21,11 @@
 /* Called with table_lock held.  */
 static int qed_read_table(BDRVQEDState *s, uint64_t offset, QEDTable *ta=
ble)
 {
-    QEMUIOVector qiov;
+    QEMUIOVector qiov =3D QEMU_IOVEC_INIT_BUF(
+        qiov, table->offsets, s->header.cluster_size * s->header.table_s=
ize);
     int noffsets;
     int i, ret;
=20
-    struct iovec iov =3D {
-        .iov_base =3D table->offsets,
-        .iov_len =3D s->header.cluster_size * s->header.table_size,
-    };
-    qemu_iovec_init_external(&qiov, &iov, 1);
-
     trace_qed_read_table(s, offset, table);
=20
     qemu_co_mutex_unlock(&s->table_lock);
@@ -71,7 +66,6 @@ static int qed_write_table(BDRVQEDState *s, uint64_t of=
fset, QEDTable *table,
     unsigned int sector_mask =3D BDRV_SECTOR_SIZE / sizeof(uint64_t) - 1=
;
     unsigned int start, end, i;
     QEDTable *new_table;
-    struct iovec iov;
     QEMUIOVector qiov;
     size_t len_bytes;
     int ret;
@@ -85,11 +79,7 @@ static int qed_write_table(BDRVQEDState *s, uint64_t o=
ffset, QEDTable *table,
     len_bytes =3D (end - start) * sizeof(uint64_t);
=20
     new_table =3D qemu_blockalign(s->bs, len_bytes);
-    iov =3D (struct iovec) {
-        .iov_base =3D new_table->offsets,
-        .iov_len =3D len_bytes,
-    };
-    qemu_iovec_init_external(&qiov, &iov, 1);
+    qemu_iovec_init_buf(&qiov, new_table->offsets, len_bytes);
=20
     /* Byteswap table */
     for (i =3D start; i < end; i++) {
diff --git a/block/qed.c b/block/qed.c
index 1280870024..c5e6d6ad41 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -113,18 +113,13 @@ static int coroutine_fn qed_write_header(BDRVQEDSta=
te *s)
     int nsectors =3D DIV_ROUND_UP(sizeof(QEDHeader), BDRV_SECTOR_SIZE);
     size_t len =3D nsectors * BDRV_SECTOR_SIZE;
     uint8_t *buf;
-    struct iovec iov;
     QEMUIOVector qiov;
     int ret;
=20
     assert(s->allocating_acb || s->allocating_write_reqs_plugged);
=20
     buf =3D qemu_blockalign(s->bs, len);
-    iov =3D (struct iovec) {
-        .iov_base =3D buf,
-        .iov_len =3D len,
-    };
-    qemu_iovec_init_external(&qiov, &iov, 1);
+    qemu_iovec_init_buf(&qiov, buf, len);
=20
     ret =3D bdrv_co_preadv(s->bs->file, 0, qiov.size, &qiov, 0);
     if (ret < 0) {
@@ -913,7 +908,6 @@ static int coroutine_fn qed_copy_from_backing_file(BD=
RVQEDState *s,
 {
     QEMUIOVector qiov;
     QEMUIOVector *backing_qiov =3D NULL;
-    struct iovec iov;
     int ret;
=20
     /* Skip copy entirely if there is no work to do */
@@ -921,11 +915,7 @@ static int coroutine_fn qed_copy_from_backing_file(B=
DRVQEDState *s,
         return 0;
     }
=20
-    iov =3D (struct iovec) {
-        .iov_base =3D qemu_blockalign(s->bs, len),
-        .iov_len =3D len,
-    };
-    qemu_iovec_init_external(&qiov, &iov, 1);
+    qemu_iovec_init_buf(&qiov, qemu_blockalign(s->bs, len), len);
=20
     ret =3D qed_read_backing_file(s, pos, &qiov, &backing_qiov);
=20
@@ -946,7 +936,7 @@ static int coroutine_fn qed_copy_from_backing_file(BD=
RVQEDState *s,
     }
     ret =3D 0;
 out:
-    qemu_vfree(iov.iov_base);
+    qemu_vfree(qemu_iovec_buf(&qiov));
     return ret;
 }
=20
@@ -1447,8 +1437,12 @@ static int coroutine_fn bdrv_qed_co_pwrite_zeroes(=
BlockDriverState *bs,
                                                   BdrvRequestFlags flags=
)
 {
     BDRVQEDState *s =3D bs->opaque;
-    QEMUIOVector qiov;
-    struct iovec iov;
+
+    /*
+     * Zero writes start without an I/O buffer.  If a buffer becomes nec=
essary
+     * then it will be allocated during request processing.
+     */
+    QEMUIOVector qiov =3D QEMU_IOVEC_INIT_BUF(qiov, NULL, bytes);
=20
     /* Fall back if the request is not aligned */
     if (qed_offset_into_cluster(s, offset) ||
@@ -1456,13 +1450,6 @@ static int coroutine_fn bdrv_qed_co_pwrite_zeroes(=
BlockDriverState *bs,
         return -ENOTSUP;
     }
=20
-    /* Zero writes start without an I/O buffer.  If a buffer becomes nec=
essary
-     * then it will be allocated during request processing.
-     */
-    iov.iov_base =3D NULL;
-    iov.iov_len =3D bytes;
-
-    qemu_iovec_init_external(&qiov, &iov, 1);
     return qed_co_request(bs, offset >> BDRV_SECTOR_BITS, &qiov,
                           bytes >> BDRV_SECTOR_BITS,
                           QED_AIOCB_WRITE | QED_AIOCB_ZERO);
--=20
2.20.1
