Received: from eggs.gnu.org ([209.51.188.92]:39930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gliNp-0001FZ-VN
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 17:49:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gliNn-00054V-PR
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 17:49:32 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 21 Jan 2019 16:48:51 -0600
Message-Id: <20190121224907.26634-6-eblake@redhat.com>
In-Reply-To: <20190121224907.26634-1-eblake@redhat.com>
References: <20190121224907.26634-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/21] nbd/server: Hoist length check to
 qmp_nbd_server_add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

We only had two callers to nbd_export_new; qemu-nbd.c always
passed a valid offset/length pair (because it already checked
the file length, to ensure that offset was in bounds), while
blockdev-nbd.c always passed 0/-1.  Then nbd_export_new reduces
the size to a multiple of BDRV_SECTOR_SIZE (can only happen
when offset is not sector-aligned, since bdrv_getlength()
currently rounds up) (someday, it would be nice to have
byte-accurate lengths - but not today).

However, I'm finding it easier to work with the code if we are
consistent on having both callers pass in a valid length, and
just assert that things are sane in nbd_export_new, meaning
that no negative values were passed, and that offset+size does
not exceed 63 bits (as that really is a fundamental limit to
later operations, whether we use off_t or uint64_t).

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190117193658.16413-6-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 blockdev-nbd.c | 10 +++++++++-
 nbd/server.c   | 10 +++-------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index c76d5416b90..d73ac1b026a 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -146,6 +146,7 @@ void qmp_nbd_server_add(const char *device, bool has_=
name, const char *name,
     BlockDriverState *bs =3D NULL;
     BlockBackend *on_eject_blk;
     NBDExport *exp;
+    int64_t len;

     if (!nbd_server) {
         error_setg(errp, "NBD server not running");
@@ -168,6 +169,13 @@ void qmp_nbd_server_add(const char *device, bool has=
_name, const char *name,
         return;
     }

+    len =3D bdrv_getlength(bs);
+    if (len < 0) {
+        error_setg_errno(errp, -len,
+                         "Failed to determine the NBD export's length");
+        return;
+    }
+
     if (!has_writable) {
         writable =3D false;
     }
@@ -175,7 +183,7 @@ void qmp_nbd_server_add(const char *device, bool has_=
name, const char *name,
         writable =3D false;
     }

-    exp =3D nbd_export_new(bs, 0, -1, name, NULL, bitmap,
+    exp =3D nbd_export_new(bs, 0, len, name, NULL, bitmap,
                          writable ? 0 : NBD_FLAG_READ_ONLY,
                          NULL, false, on_eject_blk, errp);
     if (!exp) {
diff --git a/nbd/server.c b/nbd/server.c
index 6b136019f82..51ee8094e02 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1495,17 +1495,13 @@ NBDExport *nbd_export_new(BlockDriverState *bs, o=
ff_t dev_offset, off_t size,
     exp->refcount =3D 1;
     QTAILQ_INIT(&exp->clients);
     exp->blk =3D blk;
+    assert(dev_offset >=3D 0 && dev_offset <=3D INT64_MAX);
     exp->dev_offset =3D dev_offset;
     exp->name =3D g_strdup(name);
     exp->description =3D g_strdup(description);
     exp->nbdflags =3D nbdflags;
-    exp->size =3D size < 0 ? blk_getlength(blk) : size;
-    if (exp->size < 0) {
-        error_setg_errno(errp, -exp->size,
-                         "Failed to determine the NBD export's length");
-        goto fail;
-    }
-    exp->size -=3D exp->size % BDRV_SECTOR_SIZE;
+    assert(size >=3D 0 && size <=3D INT64_MAX - dev_offset);
+    exp->size =3D QEMU_ALIGN_DOWN(size, BDRV_SECTOR_SIZE);

     if (bitmap) {
         BdrvDirtyBitmap *bm =3D NULL;
--=20
2.20.1
