Received: from eggs.gnu.org ([209.51.188.92]:59789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1giNaU-0003dC-BN
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 13:00:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1giNYM-0001sm-SF
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 12:58:40 -0500
From: Eric Blake <eblake@redhat.com>
Date: Sat, 12 Jan 2019 11:57:57 -0600
Message-Id: <20190112175812.27068-5-eblake@redhat.com>
In-Reply-To: <20190112175812.27068-1-eblake@redhat.com>
References: <20190112175812.27068-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 04/19] nbd/server: Hoist length check to
 qemp_nbd_server_add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: nsoffer@redhat.com, rjones@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

We only had two callers to nbd_export_new; qemu-nbd.c always
passed a valid offset/length pair (because it already checked
the file length, to ensure that offset was in bounds), while
blockdev-nbd always passed 0/-1.  Then nbd_export_new reduces
the size to a multiple of BDRV_SECTOR_SIZE (can only happen
when offset is not sector-aligned, since bdrv_getlength()
currently rounds up), which can result in offset being greater
than the enforced length, but that's not fatal (the server
rejects client requests that exceed the advertised length).

However, I'm finding it easier to work with the code if we are
consistent on having both callers pass in a valid length, and
just assert that things are sane in nbd_export_new.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v3: new patch
---
 blockdev-nbd.c | 10 +++++++++-
 nbd/server.c   |  9 ++-------
 2 files changed, 11 insertions(+), 8 deletions(-)

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
index e8c56607eff..c9937ccdc2a 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1499,13 +1499,8 @@ NBDExport *nbd_export_new(BlockDriverState *bs, of=
f_t dev_offset, off_t size,
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
+    assert(dev_offset <=3D size);
+    exp->size =3D QEMU_ALIGN_DOWN(size, BDRV_SECTOR_SIZE);

     if (bitmap) {
         BdrvDirtyBitmap *bm =3D NULL;
--=20
2.20.1
