Received: from eggs.gnu.org ([209.51.188.92]:48958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUuw-00088z-3e
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUuu-0002Ay-H8
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:38 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 30 Apr 2019 17:42:36 +0200
Message-Id: <20190430154244.30083-20-kwolf@redhat.com>
In-Reply-To: <20190430154244.30083-1-kwolf@redhat.com>
References: <20190430154244.30083-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 19/27] block/qed: use buffer-based io
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Move to _co_ versions of io functions qed_read_table() and
qed_write_table(), as we use qemu_co_mutex_unlock()
anyway.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qed-table.c | 12 +++++-------
 block/qed.c       |  6 ++----
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/block/qed-table.c b/block/qed-table.c
index c497bd4aec..cf30edd977 100644
--- a/block/qed-table.c
+++ b/block/qed-table.c
@@ -21,22 +21,22 @@
 /* Called with table_lock held.  */
 static int qed_read_table(BDRVQEDState *s, uint64_t offset, QEDTable *ta=
ble)
 {
-    QEMUIOVector qiov =3D QEMU_IOVEC_INIT_BUF(
-        qiov, table->offsets, s->header.cluster_size * s->header.table_s=
ize);
+    unsigned int bytes =3D s->header.cluster_size * s->header.table_size=
;
+
     int noffsets;
     int i, ret;
=20
     trace_qed_read_table(s, offset, table);
=20
     qemu_co_mutex_unlock(&s->table_lock);
-    ret =3D bdrv_preadv(s->bs->file, offset, &qiov);
+    ret =3D bdrv_co_pread(s->bs->file, offset, bytes, table->offsets, 0)=
;
     qemu_co_mutex_lock(&s->table_lock);
     if (ret < 0) {
         goto out;
     }
=20
     /* Byteswap offsets */
-    noffsets =3D qiov.size / sizeof(uint64_t);
+    noffsets =3D bytes / sizeof(uint64_t);
     for (i =3D 0; i < noffsets; i++) {
         table->offsets[i] =3D le64_to_cpu(table->offsets[i]);
     }
@@ -66,7 +66,6 @@ static int qed_write_table(BDRVQEDState *s, uint64_t of=
fset, QEDTable *table,
     unsigned int sector_mask =3D BDRV_SECTOR_SIZE / sizeof(uint64_t) - 1=
;
     unsigned int start, end, i;
     QEDTable *new_table;
-    QEMUIOVector qiov;
     size_t len_bytes;
     int ret;
=20
@@ -79,7 +78,6 @@ static int qed_write_table(BDRVQEDState *s, uint64_t of=
fset, QEDTable *table,
     len_bytes =3D (end - start) * sizeof(uint64_t);
=20
     new_table =3D qemu_blockalign(s->bs, len_bytes);
-    qemu_iovec_init_buf(&qiov, new_table->offsets, len_bytes);
=20
     /* Byteswap table */
     for (i =3D start; i < end; i++) {
@@ -91,7 +89,7 @@ static int qed_write_table(BDRVQEDState *s, uint64_t of=
fset, QEDTable *table,
     offset +=3D start * sizeof(uint64_t);
=20
     qemu_co_mutex_unlock(&s->table_lock);
-    ret =3D bdrv_pwritev(s->bs->file, offset, &qiov);
+    ret =3D bdrv_co_pwrite(s->bs->file, offset, len_bytes, new_table->of=
fsets, 0);
     qemu_co_mutex_lock(&s->table_lock);
     trace_qed_write_table_cb(s, table, flush, ret);
     if (ret < 0) {
diff --git a/block/qed.c b/block/qed.c
index 89af05d524..912edaf56a 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -113,15 +113,13 @@ static int coroutine_fn qed_write_header(BDRVQEDSta=
te *s)
     int nsectors =3D DIV_ROUND_UP(sizeof(QEDHeader), BDRV_SECTOR_SIZE);
     size_t len =3D nsectors * BDRV_SECTOR_SIZE;
     uint8_t *buf;
-    QEMUIOVector qiov;
     int ret;
=20
     assert(s->allocating_acb || s->allocating_write_reqs_plugged);
=20
     buf =3D qemu_blockalign(s->bs, len);
-    qemu_iovec_init_buf(&qiov, buf, len);
=20
-    ret =3D bdrv_co_preadv(s->bs->file, 0, qiov.size, &qiov, 0);
+    ret =3D bdrv_co_pread(s->bs->file, 0, len, buf, 0);
     if (ret < 0) {
         goto out;
     }
@@ -129,7 +127,7 @@ static int coroutine_fn qed_write_header(BDRVQEDState=
 *s)
     /* Update header */
     qed_header_cpu_to_le(&s->header, (QEDHeader *) buf);
=20
-    ret =3D bdrv_co_pwritev(s->bs->file, 0, qiov.size,  &qiov, 0);
+    ret =3D bdrv_co_pwrite(s->bs->file, 0, len,  buf, 0);
     if (ret < 0) {
         goto out;
     }
--=20
2.20.1
