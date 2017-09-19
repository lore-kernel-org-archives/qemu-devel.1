Received: from eggs.gnu.org ([2001:4830:134:3::10]:47183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1duLmf-0006Dc-5U
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:54:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1duLme-0002W7-8S
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:54:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1duLme-0002Vc-22
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:54:04 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 19 Sep 2017 18:52:16 +0200
Message-Id: <20170919165226.23022-18-marcandre.lureau@redhat.com>
In-Reply-To: <20170919165226.23022-1-marcandre.lureau@redhat.com>
References: <20170919165226.23022-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 17/27] vhost-user-scsi: remove VUS_MAX_LUNS
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

There is no code to support more than 1 yet, no need for that today.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 contrib/vhost-user-scsi/vhost-user-scsi.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-us=
er-scsi/vhost-user-scsi.c
index 38fe451619..6b55cc71d3 100644
--- a/contrib/vhost-user-scsi/vhost-user-scsi.c
+++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
@@ -53,8 +53,6 @@
=20
 /** vhost-user-scsi specific definitions **/
=20
- /* Only 1 LUN and device supported today */
-#define VUS_MAX_LUNS 1
 #define VUS_ISCSI_INITIATOR "iqn.2016-11.com.nutanix:vhost-user-scsi"
=20
 typedef struct iscsi_lun {
@@ -67,7 +65,7 @@ typedef struct vhost_scsi_dev {
     int server_sock;
     GMainLoop *loop;
     GTree *fdmap;   /* fd -> gsource context id */
-    iscsi_lun_t luns[VUS_MAX_LUNS];
+    iscsi_lun_t lun;
 } vhost_scsi_dev_t;
=20
 /** glib event loop integration for libvhost-user and misc callbacks **/
@@ -535,7 +533,7 @@ static void vus_proc_req(VuDev *vu_dev, int idx)
         }
         rsp =3D (VirtIOSCSICmdResp *)elem->in_sg[0].iov_base;
=20
-        if (handle_cmd_sync(vdev_scsi->luns[0].iscsi_ctx,
+        if (handle_cmd_sync(vdev_scsi->lun.iscsi_ctx,
                             req, &elem->out_sg[1], elem->out_num - 1,
                             rsp, &elem->in_sg[1], elem->in_num - 1) !=3D=
 0) {
             vus_panic_cb(vu_dev, NULL);
@@ -720,7 +718,7 @@ int main(int argc, char **argv)
     }
     vdev_scsi =3D vdev_scsi_new(sock);
=20
-    if (iscsi_add_lun(&vdev_scsi->luns[0], iscsi_uri) !=3D 0) {
+    if (iscsi_add_lun(&vdev_scsi->lun, iscsi_uri) !=3D 0) {
         goto err;
     }
=20
--=20
2.14.1.146.gd35faa819
