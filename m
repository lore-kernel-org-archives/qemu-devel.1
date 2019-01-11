Received: from eggs.gnu.org ([209.51.188.92]:40197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gi2mP-0006RV-0B
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 14:47:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gi2mN-0004zm-Jv
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 14:47:44 -0500
From: Eric Blake <eblake@redhat.com>
Date: Fri, 11 Jan 2019 13:47:16 -0600
Message-Id: <20190111194720.15671-5-eblake@redhat.com>
In-Reply-To: <20190111194720.15671-1-eblake@redhat.com>
References: <20190111194720.15671-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 4/8] nbd: Merge nbd_export_set_name into
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

The existing NBD code had a weird split where nbd_export_new()
created an export but did not add it to the list of exported
names until a later nbd_export_set_name() came along and grabbed
a second reference on the object; later, the first call to
nbd_export_close() drops the second reference while removing
the export from the list.  This is in part because the QAPI
NbdServerRemoveNode enum documents the possibility of adding a
mode where we could do a soft disconnect: preventing new clients,
but waiting for existing clients to gracefully quit, based on
the mode used when calling nbd_export_close().

But in spite of all that, note that we never change the name of
an NBD export while it is exposed, which means it is easier to
just inline the process of setting the name as part of creating
the export.

Inline the contents of nbd_export_set_name() and
nbd_export_set_description() into the two points in an export
lifecycle where they matter, then adjust both callers to pass
the name up front.  Note that for creation, all callers pass a
non-NULL name, (passing NULL at creation was for old style
servers, but we removed support for that in commit 7f7dfe2a),
so we can add an assert and do things unconditionally; but for
cleanup, because of the dual nature of nbd_export_close(), we
still have to be careful to avoid use-after-free.  Along the
way, add a comment reminding ourselves of the potential of
adding a middle mode disconnect.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

---
v3: add comment on potential close mode semantics [Vladimir],
rebase to 'exp' rename [Phillipe]; no major code change so R-b added
---
 include/block/nbd.h |  3 +--
 blockdev-nbd.c      |  5 ++---
 nbd/server.c        | 52 ++++++++++++++++++++-------------------------
 qemu-nbd.c          |  8 +++----
 4 files changed, 29 insertions(+), 39 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 65402d33964..2f9a2aeb73c 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -295,6 +295,7 @@ typedef struct NBDExport NBDExport;
 typedef struct NBDClient NBDClient;

 NBDExport *nbd_export_new(BlockDriverState *bs, off_t dev_offset, off_t =
size,
+                          const char *name, const char *description,
                           uint16_t nbdflags, void (*close)(NBDExport *),
                           bool writethrough, BlockBackend *on_eject_blk,
                           Error **errp);
@@ -306,8 +307,6 @@ void nbd_export_put(NBDExport *exp);
 BlockBackend *nbd_export_get_blockdev(NBDExport *exp);

 NBDExport *nbd_export_find(const char *name);
-void nbd_export_set_name(NBDExport *exp, const char *name);
-void nbd_export_set_description(NBDExport *exp, const char *description)=
;
 void nbd_export_close_all(void);

 void nbd_client_new(QIOChannelSocket *sioc,
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index ca584919194..582ffded77f 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -174,14 +174,13 @@ void qmp_nbd_server_add(const char *device, bool ha=
s_name, const char *name,
         writable =3D false;
     }

-    exp =3D nbd_export_new(bs, 0, -1, writable ? 0 : NBD_FLAG_READ_ONLY,
+    exp =3D nbd_export_new(bs, 0, -1, name, NULL,
+                         writable ? 0 : NBD_FLAG_READ_ONLY,
                          NULL, false, on_eject_blk, errp);
     if (!exp) {
         return;
     }

-    nbd_export_set_name(exp, name);
-
     /* The list of named exports has a strong reference to this export n=
ow and
      * our only way of accessing it is through nbd_export_find(), so we =
can drop
      * the strong reference that is @exp. */
diff --git a/nbd/server.c b/nbd/server.c
index 98327088cb4..bb5438c448b 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1456,6 +1456,7 @@ static void nbd_eject_notifier(Notifier *n, void *d=
ata)
 }

 NBDExport *nbd_export_new(BlockDriverState *bs, off_t dev_offset, off_t =
size,
+                          const char *name, const char *description,
                           uint16_t nbdflags, void (*close)(NBDExport *),
                           bool writethrough, BlockBackend *on_eject_blk,
                           Error **errp)
@@ -1471,6 +1472,7 @@ NBDExport *nbd_export_new(BlockDriverState *bs, off=
_t dev_offset, off_t size,
      * that BDRV_O_INACTIVE is cleared and the image is ready for write
      * access since the export could be available before migration hando=
ver.
      */
+    assert(name);
     ctx =3D bdrv_get_aio_context(bs);
     aio_context_acquire(ctx);
     bdrv_invalidate_cache(bs, NULL);
@@ -1494,6 +1496,8 @@ NBDExport *nbd_export_new(BlockDriverState *bs, off=
_t dev_offset, off_t size,
     QTAILQ_INIT(&exp->clients);
     exp->blk =3D blk;
     exp->dev_offset =3D dev_offset;
+    exp->name =3D g_strdup(name);
+    exp->description =3D g_strdup(description);
     exp->nbdflags =3D nbdflags;
     exp->size =3D size < 0 ? blk_getlength(blk) : size;
     if (exp->size < 0) {
@@ -1513,10 +1517,14 @@ NBDExport *nbd_export_new(BlockDriverState *bs, o=
ff_t dev_offset, off_t size,
         exp->eject_notifier.notify =3D nbd_eject_notifier;
         blk_add_remove_bs_notifier(on_eject_blk, &exp->eject_notifier);
     }
+    QTAILQ_INSERT_TAIL(&exports, exp, next);
+    nbd_export_get(exp);
     return exp;

 fail:
     blk_unref(blk);
+    g_free(exp->name);
+    g_free(exp->description);
     g_free(exp);
     return NULL;
 }
@@ -1533,43 +1541,29 @@ NBDExport *nbd_export_find(const char *name)
     return NULL;
 }

-void nbd_export_set_name(NBDExport *exp, const char *name)
-{
-    if (exp->name =3D=3D name) {
-        return;
-    }
-
-    nbd_export_get(exp);
-    if (exp->name !=3D NULL) {
-        g_free(exp->name);
-        exp->name =3D NULL;
-        QTAILQ_REMOVE(&exports, exp, next);
-        nbd_export_put(exp);
-    }
-    if (name !=3D NULL) {
-        nbd_export_get(exp);
-        exp->name =3D g_strdup(name);
-        QTAILQ_INSERT_TAIL(&exports, exp, next);
-    }
-    nbd_export_put(exp);
-}
-
-void nbd_export_set_description(NBDExport *exp, const char *description)
-{
-    g_free(exp->description);
-    exp->description =3D g_strdup(description);
-}
-
 void nbd_export_close(NBDExport *exp)
 {
     NBDClient *client, *next;

     nbd_export_get(exp);
+    /*
+     * TODO: Should we expand QMP NbdServerRemoveNode enum to allow a
+     * close mode that stops advertising the export to new clients but
+     * still permits existing clients to run to completion? Because of
+     * that possibility, nbd_export_close() can be called more than
+     * once on an export.
+     */
     QTAILQ_FOREACH_SAFE(client, &exp->clients, next, next) {
         client_close(client, true);
     }
-    nbd_export_set_name(exp, NULL);
-    nbd_export_set_description(exp, NULL);
+    if (exp->name) {
+        nbd_export_put(exp);
+        g_free(exp->name);
+        exp->name =3D NULL;
+        QTAILQ_REMOVE(&exports, exp, next);
+    }
+    g_free(exp->description);
+    exp->description =3D NULL;
     nbd_export_put(exp);
 }

diff --git a/qemu-nbd.c b/qemu-nbd.c
index 6ca02b6d87b..b93fa196dac 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -1015,11 +1015,9 @@ int main(int argc, char **argv)
         }
     }

-    export =3D nbd_export_new(bs, dev_offset, fd_size, nbdflags,
-                            nbd_export_closed, writethrough,
-                            NULL, &error_fatal);
-    nbd_export_set_name(export, export_name);
-    nbd_export_set_description(export, export_description);
+    export =3D nbd_export_new(bs, dev_offset, fd_size, export_name,
+                            export_description, nbdflags, nbd_export_clo=
sed,
+                            writethrough, NULL, &error_fatal);

     if (device) {
 #if HAVE_NBD_DEVICE
--=20
2.20.1
