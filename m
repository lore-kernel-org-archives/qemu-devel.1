Received: from eggs.gnu.org ([2001:4830:134:3::10]:46380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1duLlt-0005Zp-Cn
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:53:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1duLls-0001mL-HS
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:53:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1duLls-0001la-8A
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:53:16 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 19 Sep 2017 18:52:08 +0200
Message-Id: <20170919165226.23022-10-marcandre.lureau@redhat.com>
In-Reply-To: <20170919165226.23022-1-marcandre.lureau@redhat.com>
References: <20170919165226.23022-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 09/27] vhost-user-scsi: use glib allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, changpeng.liu@intel.com, f4bug@amsat.org, felipe@nutanix.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Use g_new/g_free instead of plain malloc. This simplify a bit memory
handling since glib will abort if it cannot allocate.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 contrib/vhost-user-scsi/vhost-user-scsi.c | 35 ++++++++-----------------=
------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-us=
er-scsi/vhost-user-scsi.c
index fe567452cd..cf2793ef02 100644
--- a/contrib/vhost-user-scsi/vhost-user-scsi.c
+++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
@@ -312,12 +312,7 @@ static struct scsi_task *scsi_task_new(int cdb_len, =
uint8_t *cdb, int dir,
     assert(cdb_len > 0);
     assert(cdb);
=20
-    task =3D calloc(1, sizeof(struct scsi_task));
-    if (!task) {
-        PERR("Error allocating task: %s", strerror(errno));
-        return NULL;
-    }
-
+    task =3D g_new0(struct scsi_task, 1);
     memcpy(task->cdb, cdb, cdb_len);
     task->cdb_size =3D cdb_len;
     task->xfer_dir =3D dir;
@@ -393,10 +388,6 @@ static int handle_cmd_sync(struct iscsi_context *ctx=
,
     }
=20
     task =3D scsi_task_new(cdb_len, req->cdb, dir, len);
-    if (!task) {
-        PERR("Unable to create iscsi task");
-        return -1;
-    }
=20
     if (dir =3D=3D SCSI_XFER_TO_DEV) {
         task->iovector_out.iov =3D (struct scsi_iovec *)out;
@@ -410,7 +401,7 @@ static int handle_cmd_sync(struct iscsi_context *ctx,
          cdb_len, dir, task);
     if (!iscsi_scsi_command_sync(ctx, 0, task, NULL)) {
         PERR("Error serving SCSI command");
-        free(task);
+        g_free(task);
         return -1;
     }
=20
@@ -425,7 +416,7 @@ static int handle_cmd_sync(struct iscsi_context *ctx,
         memcpy(rsp->sense, &task->datain.data[2], rsp->sense_len);
     }
=20
-    free(task);
+    g_free(task);
=20
     PDBG("Filled in rsp: status=3D%hhX, resid=3D%u, response=3D%hhX, sen=
se_len=3D%u",
          rsp->status, rsp->resid, rsp->response, rsp->sense_len);
@@ -692,7 +683,7 @@ static vhost_scsi_dev_t *vdev_scsi_find_by_vu(VuDev *=
vu_dev)
     return NULL;
 }
=20
-static void vdev_scsi_deinit(vhost_scsi_dev_t *vdev_scsi)
+static void vdev_scsi_free(vhost_scsi_dev_t *vdev_scsi)
 {
     if (!vdev_scsi) {
         return;
@@ -716,18 +707,14 @@ static void vdev_scsi_deinit(vhost_scsi_dev_t *vdev=
_scsi)
         g_main_loop_unref(vdev_scsi->loop);
         vdev_scsi->loop =3D NULL;
     }
+    g_free(vdev_scsi);
 }
=20
 static vhost_scsi_dev_t *vdev_scsi_new(int server_sock)
 {
-    vhost_scsi_dev_t *vdev_scsi =3D NULL;
-
-    vdev_scsi =3D calloc(1, sizeof(vhost_scsi_dev_t));
-    if (!vdev_scsi) {
-        PERR("calloc: %s", strerror(errno));
-        return NULL;
-    }
+    vhost_scsi_dev_t *vdev_scsi;
=20
+    vdev_scsi =3D g_new0(vhost_scsi_dev_t, 1);
     vdev_scsi->server_sock =3D server_sock;
     vdev_scsi->loop =3D g_main_loop_new(NULL, FALSE);
     if (!vdev_scsi->loop) {
@@ -744,8 +731,7 @@ static vhost_scsi_dev_t *vdev_scsi_new(int server_soc=
k)
     return vdev_scsi;
=20
 err:
-    vdev_scsi_deinit(vdev_scsi);
-    free(vdev_scsi);
+    vdev_scsi_free(vdev_scsi);
=20
     return NULL;
 }
@@ -852,10 +838,7 @@ int main(int argc, char **argv)
     }
=20
 out:
-    if (vdev_scsi) {
-        vdev_scsi_deinit(vdev_scsi);
-        free(vdev_scsi);
-    }
+    vdev_scsi_free(vdev_scsi);
     g_free(unix_fn);
     g_free(iscsi_uri);
=20
--=20
2.14.1.146.gd35faa819
