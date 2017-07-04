Received: from eggs.gnu.org ([2001:4830:134:3::10]:48621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVwQ-0007tM-A2
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:05:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVwP-0000EM-41
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:05:06 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  5 Jul 2017 00:03:22 +0200
Message-Id: <20170704220346.29244-12-marcandre.lureau@redhat.com>
In-Reply-To: <20170704220346.29244-1-marcandre.lureau@redhat.com>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 11/35] qcow2: mark coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:qcow" <qemu-block@nongnu.org>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 block/qcow2.h         |  6 ++++--
 block/qcow.c          |  4 +++-
 block/qcow2-cluster.c | 11 +++++++----
 block/qcow2.c         | 15 ++++++++++-----
 4 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 87b15eb4aa..a32b47b7f6 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -550,14 +550,16 @@ int qcow2_encrypt_sectors(BDRVQcow2State *s, int64_=
t sector_num,
=20
 int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
                              unsigned int *bytes, uint64_t *cluster_offs=
et);
-int qcow2_alloc_cluster_offset(BlockDriverState *bs, uint64_t offset,
+int coroutine_fn
+qcow2_alloc_cluster_offset(BlockDriverState *bs, uint64_t offset,
                                unsigned int *bytes, uint64_t *host_offse=
t,
                                QCowL2Meta **m);
 uint64_t qcow2_alloc_compressed_cluster_offset(BlockDriverState *bs,
                                          uint64_t offset,
                                          int compressed_size);
=20
-int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m);
+int coroutine_fn
+qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m);
 int qcow2_cluster_discard(BlockDriverState *bs, uint64_t offset,
                           uint64_t bytes, enum qcow2_discard_type type,
                           bool full_discard);
diff --git a/block/qcow.c b/block/qcow.c
index 7bd94dcd46..d84ae7fb74 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -796,7 +796,9 @@ static void qcow_close(BlockDriverState *bs)
     error_free(s->migration_blocker);
 }
=20
-static int qcow_create(const char *filename, QemuOpts *opts, Error **err=
p)
+
+static int coroutine_fn
+qcow_create(const char *filename, QemuOpts *opts, Error **errp)
 {
     int header_size, backing_filename_len, l1_size, shift, i;
     QCowHeader header;
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 3d341fd9cb..964d23aee8 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -761,7 +761,8 @@ uint64_t qcow2_alloc_compressed_cluster_offset(BlockD=
riverState *bs,
     return cluster_offset;
 }
=20
-static int perform_cow(BlockDriverState *bs, QCowL2Meta *m)
+static int coroutine_fn
+perform_cow(BlockDriverState *bs, QCowL2Meta *m)
 {
     BDRVQcow2State *s =3D bs->opaque;
     Qcow2COWRegion *start =3D &m->cow_start;
@@ -890,7 +891,7 @@ fail:
     return ret;
 }
=20
-int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m)
+int coroutine_fn qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL=
2Meta *m)
 {
     BDRVQcow2State *s =3D bs->opaque;
     int i, j =3D 0, l2_index, ret;
@@ -1014,7 +1015,8 @@ out:
  *           information on cluster allocation may be invalid now. The c=
aller
  *           must start over anyway, so consider *cur_bytes undefined.
  */
-static int handle_dependencies(BlockDriverState *bs, uint64_t guest_offs=
et,
+static int coroutine_fn
+handle_dependencies(BlockDriverState *bs, uint64_t guest_offset,
     uint64_t *cur_bytes, QCowL2Meta **m)
 {
     BDRVQcow2State *s =3D bs->opaque;
@@ -1413,7 +1415,8 @@ fail:
  *
  * Return 0 on success and -errno in error cases
  */
-int qcow2_alloc_cluster_offset(BlockDriverState *bs, uint64_t offset,
+int coroutine_fn
+qcow2_alloc_cluster_offset(BlockDriverState *bs, uint64_t offset,
                                unsigned int *bytes, uint64_t *host_offse=
t,
                                QCowL2Meta **m)
 {
diff --git a/block/qcow2.c b/block/qcow2.c
index 2f94f0326e..6ecf1489dc 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2079,7 +2079,8 @@ static int qcow2_change_backing_file(BlockDriverSta=
te *bs,
     return qcow2_update_header(bs);
 }
=20
-static int preallocate(BlockDriverState *bs)
+static int coroutine_fn
+preallocate(BlockDriverState *bs)
 {
     uint64_t bytes;
     uint64_t offset;
@@ -2140,7 +2141,8 @@ static int preallocate(BlockDriverState *bs)
     return 0;
 }
=20
-static int qcow2_create2(const char *filename, int64_t total_size,
+static int coroutine_fn
+qcow2_create2(const char *filename, int64_t total_size,
                          const char *backing_file, const char *backing_f=
ormat,
                          int flags, size_t cluster_size, PreallocMode pr=
ealloc,
                          QemuOpts *opts, int version, int refcount_order=
,
@@ -2390,7 +2392,8 @@ out:
     return ret;
 }
=20
-static int qcow2_create(const char *filename, QemuOpts *opts, Error **er=
rp)
+static int coroutine_fn
+qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
 {
     char *backing_file =3D NULL;
     char *backing_fmt =3D NULL;
@@ -3011,7 +3014,8 @@ static void dump_refcounts(BlockDriverState *bs)
 }
 #endif
=20
-static int qcow2_save_vmstate(BlockDriverState *bs, QEMUIOVector *qiov,
+static int coroutine_fn
+qcow2_save_vmstate(BlockDriverState *bs, QEMUIOVector *qiov,
                               int64_t pos)
 {
     BDRVQcow2State *s =3D bs->opaque;
@@ -3021,7 +3025,8 @@ static int qcow2_save_vmstate(BlockDriverState *bs,=
 QEMUIOVector *qiov,
                                     qiov->size, qiov, 0);
 }
=20
-static int qcow2_load_vmstate(BlockDriverState *bs, QEMUIOVector *qiov,
+static int coroutine_fn
+qcow2_load_vmstate(BlockDriverState *bs, QEMUIOVector *qiov,
                               int64_t pos)
 {
     BDRVQcow2State *s =3D bs->opaque;
--=20
2.13.1.395.gf7b71de06
