Received: from eggs.gnu.org ([209.51.188.92]:40228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gi2mQ-0006TB-Iu
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 14:47:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gi2mO-00050R-7M
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 14:47:45 -0500
From: Eric Blake <eblake@redhat.com>
Date: Fri, 11 Jan 2019 13:47:19 -0600
Message-Id: <20190111194720.15671-8-eblake@redhat.com>
In-Reply-To: <20190111194720.15671-1-eblake@redhat.com>
References: <20190111194720.15671-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 7/8] nbd: Merge nbd_export_bitmap into
 nbd_export_new
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, jsnow@redhat.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

We only have one caller that wants to export a bitmap name,
which it does right after creation of the export. But there is
still a brief window of time where an NBD client could see the
export but not the dirty bitmap, which a robust client would
have to interpret as meaning the entire image should be treated
as dirty.  Better is to eliminate the window entirely, by
inlining nbd_export_bitmap() into nbd_export_new(), and refusing
to create the bitmap in the first place if the requested bitmap
can't be located.

We also no longer need logic for setting a different bitmap
name compared to the bitmap being exported.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

---
v3: rebase to 'exp' rename [Phillipe]
---
 include/block/nbd.h |  9 ++---
 blockdev-nbd.c      | 11 +-----
 nbd/server.c        | 87 +++++++++++++++++++++------------------------
 qemu-nbd.c          |  5 +--
 4 files changed, 47 insertions(+), 65 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 2f9a2aeb73c..1971b557896 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -296,9 +296,9 @@ typedef struct NBDClient NBDClient;

 NBDExport *nbd_export_new(BlockDriverState *bs, off_t dev_offset, off_t =
size,
                           const char *name, const char *description,
-                          uint16_t nbdflags, void (*close)(NBDExport *),
-                          bool writethrough, BlockBackend *on_eject_blk,
-                          Error **errp);
+                          const char *bitmap, uint16_t nbdflags,
+                          void (*close)(NBDExport *), bool writethrough,
+                          BlockBackend *on_eject_blk, Error **errp);
 void nbd_export_close(NBDExport *exp);
 void nbd_export_remove(NBDExport *exp, NbdServerRemoveMode mode, Error *=
*errp);
 void nbd_export_get(NBDExport *exp);
@@ -319,9 +319,6 @@ void nbd_client_put(NBDClient *client);
 void nbd_server_start(SocketAddress *addr, const char *tls_creds,
                       Error **errp);

-void nbd_export_bitmap(NBDExport *exp, const char *bitmap,
-                       const char *bitmap_export_name, Error **errp);
-
 /* nbd_read
  * Reads @size bytes from @ioc. Returns 0 on success.
  */
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index cd86b38cdaa..c76d5416b90 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -175,7 +175,7 @@ void qmp_nbd_server_add(const char *device, bool has_=
name, const char *name,
         writable =3D false;
     }

-    exp =3D nbd_export_new(bs, 0, -1, name, NULL,
+    exp =3D nbd_export_new(bs, 0, -1, name, NULL, bitmap,
                          writable ? 0 : NBD_FLAG_READ_ONLY,
                          NULL, false, on_eject_blk, errp);
     if (!exp) {
@@ -186,15 +186,6 @@ void qmp_nbd_server_add(const char *device, bool has=
_name, const char *name,
      * our only way of accessing it is through nbd_export_find(), so we =
can drop
      * the strong reference that is @exp. */
     nbd_export_put(exp);
-
-    if (has_bitmap) {
-        Error *err =3D NULL;
-        nbd_export_bitmap(exp, bitmap, bitmap, &err);
-        if (err) {
-            error_propagate(errp, err);
-            nbd_export_remove(exp, NBD_SERVER_REMOVE_MODE_HARD, NULL);
-        }
-    }
 }

 void qmp_nbd_server_remove(const char *name,
diff --git a/nbd/server.c b/nbd/server.c
index bb5438c448b..e8c56607eff 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1457,9 +1457,9 @@ static void nbd_eject_notifier(Notifier *n, void *d=
ata)

 NBDExport *nbd_export_new(BlockDriverState *bs, off_t dev_offset, off_t =
size,
                           const char *name, const char *description,
-                          uint16_t nbdflags, void (*close)(NBDExport *),
-                          bool writethrough, BlockBackend *on_eject_blk,
-                          Error **errp)
+                          const char *bitmap, uint16_t nbdflags,
+                          void (*close)(NBDExport *), bool writethrough,
+                          BlockBackend *on_eject_blk, Error **errp)
 {
     AioContext *ctx;
     BlockBackend *blk;
@@ -1507,6 +1507,43 @@ NBDExport *nbd_export_new(BlockDriverState *bs, of=
f_t dev_offset, off_t size,
     }
     exp->size -=3D exp->size % BDRV_SECTOR_SIZE;

+    if (bitmap) {
+        BdrvDirtyBitmap *bm =3D NULL;
+        BlockDriverState *bs =3D blk_bs(blk);
+
+        while (true) {
+            bm =3D bdrv_find_dirty_bitmap(bs, bitmap);
+            if (bm !=3D NULL || bs->backing =3D=3D NULL) {
+                break;
+            }
+
+            bs =3D bs->backing->bs;
+        }
+
+        if (bm =3D=3D NULL) {
+            error_setg(errp, "Bitmap '%s' is not found", bitmap);
+            goto fail;
+        }
+
+        if ((nbdflags & NBD_FLAG_READ_ONLY) && bdrv_is_writable(bs) &&
+            bdrv_dirty_bitmap_enabled(bm)) {
+            error_setg(errp,
+                       "Enabled bitmap '%s' incompatible with readonly e=
xport",
+                       bitmap);
+            goto fail;
+        }
+
+        if (bdrv_dirty_bitmap_user_locked(bm)) {
+            error_setg(errp, "Bitmap '%s' is in use", bitmap);
+            goto fail;
+        }
+
+        bdrv_dirty_bitmap_set_qmp_locked(bm, true);
+        exp->export_bitmap =3D bm;
+        exp->export_bitmap_context =3D g_strdup_printf("qemu:dirty-bitma=
p:%s",
+                                                     bitmap);
+    }
+
     exp->close =3D close;
     exp->ctx =3D blk_get_aio_context(blk);
     blk_add_aio_context_notifier(blk, blk_aio_attached, blk_aio_detach, =
exp);
@@ -2424,47 +2461,3 @@ void nbd_client_new(QIOChannelSocket *sioc,
     co =3D qemu_coroutine_create(nbd_co_client_start, client);
     qemu_coroutine_enter(co);
 }
-
-void nbd_export_bitmap(NBDExport *exp, const char *bitmap,
-                       const char *bitmap_export_name, Error **errp)
-{
-    BdrvDirtyBitmap *bm =3D NULL;
-    BlockDriverState *bs =3D blk_bs(exp->blk);
-
-    if (exp->export_bitmap) {
-        error_setg(errp, "Export bitmap is already set");
-        return;
-    }
-
-    while (true) {
-        bm =3D bdrv_find_dirty_bitmap(bs, bitmap);
-        if (bm !=3D NULL || bs->backing =3D=3D NULL) {
-            break;
-        }
-
-        bs =3D bs->backing->bs;
-    }
-
-    if (bm =3D=3D NULL) {
-        error_setg(errp, "Bitmap '%s' is not found", bitmap);
-        return;
-    }
-
-    if ((exp->nbdflags & NBD_FLAG_READ_ONLY) && bdrv_is_writable(bs) &&
-        bdrv_dirty_bitmap_enabled(bm)) {
-        error_setg(errp,
-                   "Enabled bitmap '%s' incompatible with readonly expor=
t",
-                   bitmap);
-        return;
-    }
-
-    if (bdrv_dirty_bitmap_user_locked(bm)) {
-        error_setg(errp, "Bitmap '%s' is in use", bitmap);
-        return;
-    }
-
-    bdrv_dirty_bitmap_set_qmp_locked(bm, true);
-    exp->export_bitmap =3D bm;
-    exp->export_bitmap_context =3D
-            g_strdup_printf("qemu:dirty-bitmap:%s", bitmap_export_name);
-}
diff --git a/qemu-nbd.c b/qemu-nbd.c
index b93fa196dac..1552274c189 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -1016,8 +1016,9 @@ int main(int argc, char **argv)
     }

     export =3D nbd_export_new(bs, dev_offset, fd_size, export_name,
-                            export_description, nbdflags, nbd_export_clo=
sed,
-                            writethrough, NULL, &error_fatal);
+                            export_description, NULL, nbdflags,
+                            nbd_export_closed, writethrough, NULL,
+                            &error_fatal);

     if (device) {
 #if HAVE_NBD_DEVICE
--=20
2.20.1
