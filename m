Received: from eggs.gnu.org ([2001:4830:134:3::10]:45937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1db89z-0003ml-Vn
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 12:30:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1db89y-0005Pz-Su
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 12:30:43 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 28 Jul 2017 18:30:04 +0200
Message-Id: <20170728163004.21905-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] iscsi: use scsi_create_task()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:iSCSI" <qemu-block@nongnu.org>

The function does the same initialization, and matches with
scsi_free_scsi_task() usage, and qemu doesn't need to know the
allocator details.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 block/iscsi.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

v2:
 - set cdb_size if API_VERSION < 20150510

diff --git a/block/iscsi.c b/block/iscsi.c
index d557c99668..9449c90631 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -1013,6 +1013,7 @@ static BlockAIOCB *iscsi_aio_ioctl(BlockDriverState=
 *bs,
     struct iscsi_context *iscsi =3D iscsilun->iscsi;
     struct iscsi_data data;
     IscsiAIOCB *acb;
+    int xfer_dir;
=20
     acb =3D qemu_aio_get(&iscsi_aiocb_info, bs, cb, opaque);
=20
@@ -1034,31 +1035,30 @@ static BlockAIOCB *iscsi_aio_ioctl(BlockDriverSta=
te *bs,
         return NULL;
     }
=20
-    acb->task =3D malloc(sizeof(struct scsi_task));
-    if (acb->task =3D=3D NULL) {
-        error_report("iSCSI: Failed to allocate task for scsi command. %=
s",
-                     iscsi_get_error(iscsi));
-        qemu_aio_unref(acb);
-        return NULL;
-    }
-    memset(acb->task, 0, sizeof(struct scsi_task));
-
     switch (acb->ioh->dxfer_direction) {
     case SG_DXFER_TO_DEV:
-        acb->task->xfer_dir =3D SCSI_XFER_WRITE;
+        xfer_dir =3D SCSI_XFER_WRITE;
         break;
     case SG_DXFER_FROM_DEV:
-        acb->task->xfer_dir =3D SCSI_XFER_READ;
+        xfer_dir =3D SCSI_XFER_READ;
         break;
     default:
-        acb->task->xfer_dir =3D SCSI_XFER_NONE;
+        xfer_dir =3D SCSI_XFER_NONE;
         break;
     }
=20
-    acb->task->cdb_size =3D acb->ioh->cmd_len;
-    memcpy(&acb->task->cdb[0], acb->ioh->cmdp, acb->ioh->cmd_len);
-    acb->task->expxferlen =3D acb->ioh->dxfer_len;
+    acb->task =3D scsi_create_task(acb->ioh->cmd_len, acb->ioh->cmdp,
+                                 xfer_dir, acb->ioh->dxfer_len);
+    if (acb->task =3D=3D NULL) {
+        error_report("iSCSI: Failed to allocate task for scsi command. %=
s",
+                     iscsi_get_error(iscsi));
+        qemu_aio_unref(acb);
+        return NULL;
+    }
=20
+#if LIBISCSI_API_VERSION < 20150510
+    acb->task->cdb_size =3D acb->ioh->cmd_len; /* fixed in libiscsi 1.13=
.0 */
+#endif
     data.size =3D 0;
     qemu_mutex_lock(&iscsilun->mutex);
     if (acb->task->xfer_dir =3D=3D SCSI_XFER_WRITE) {
--=20
2.14.0.rc0.1.g40ca67566
