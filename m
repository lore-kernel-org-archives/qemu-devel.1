Received: from eggs.gnu.org ([2001:4830:134:3::10]:47818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1duLnN-0006r7-5f
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:54:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1duLnL-000304-N4
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:54:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1duLnL-0002zU-FR
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:54:47 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 19 Sep 2017 18:52:25 +0200
Message-Id: <20170919165226.23022-27-marcandre.lureau@redhat.com>
In-Reply-To: <20170919165226.23022-1-marcandre.lureau@redhat.com>
References: <20170919165226.23022-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 26/27] vhost-user-scsi: use libvhost-user
 glib helper
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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 contrib/vhost-user-scsi/vhost-user-scsi.c | 162 +++---------------------=
------
 1 file changed, 16 insertions(+), 146 deletions(-)

diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-us=
er-scsi/vhost-user-scsi.c
index ff817d6643..615e2a76bb 100644
--- a/contrib/vhost-user-scsi/vhost-user-scsi.c
+++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
@@ -11,7 +11,7 @@
  */
=20
 #include "qemu/osdep.h"
-#include "contrib/libvhost-user/libvhost-user.h"
+#include "contrib/libvhost-user/libvhost-user-glib.h"
 #include "standard-headers/linux/virtio_scsi.h"
 #include "iscsi/iscsi.h"
 #include "iscsi/scsi-lowlevel.h"
@@ -26,95 +26,13 @@ typedef struct VusIscsiLun {
 } VusIscsiLun;
=20
 typedef struct VusDev {
-    VuDev vu_dev;
+    VugDev parent;
+
     int server_sock;
-    GMainLoop *loop;
-    GHashTable *fdmap;   /* fd -> gsource */
     VusIscsiLun lun;
+    GMainLoop *loop;
 } VusDev;
=20
-/** glib event loop integration for libvhost-user and misc callbacks **/
-
-QEMU_BUILD_BUG_ON((int)G_IO_IN !=3D (int)VU_WATCH_IN);
-QEMU_BUILD_BUG_ON((int)G_IO_OUT !=3D (int)VU_WATCH_OUT);
-QEMU_BUILD_BUG_ON((int)G_IO_PRI !=3D (int)VU_WATCH_PRI);
-QEMU_BUILD_BUG_ON((int)G_IO_ERR !=3D (int)VU_WATCH_ERR);
-QEMU_BUILD_BUG_ON((int)G_IO_HUP !=3D (int)VU_WATCH_HUP);
-
-typedef struct vus_gsrc {
-    GSource parent;
-    VusDev *vdev_scsi;
-    GPollFD gfd;
-} vus_gsrc_t;
-
-static gboolean vus_gsrc_prepare(GSource *src, gint *timeout)
-{
-    assert(timeout);
-
-    *timeout =3D -1;
-    return FALSE;
-}
-
-static gboolean vus_gsrc_check(GSource *src)
-{
-    vus_gsrc_t *vus_src =3D (vus_gsrc_t *)src;
-
-    assert(vus_src);
-
-    return vus_src->gfd.revents & vus_src->gfd.events;
-}
-
-static gboolean vus_gsrc_dispatch(GSource *src, GSourceFunc cb, gpointer=
 data)
-{
-    VusDev *vdev_scsi;
-    vus_gsrc_t *vus_src =3D (vus_gsrc_t *)src;
-
-    assert(vus_src);
-
-    vdev_scsi =3D vus_src->vdev_scsi;
-
-    assert(vdev_scsi);
-
-    ((vu_watch_cb)cb)(&vdev_scsi->vu_dev, vus_src->gfd.revents, data);
-
-    return G_SOURCE_CONTINUE;
-}
-
-static GSourceFuncs vus_gsrc_funcs =3D {
-    vus_gsrc_prepare,
-    vus_gsrc_check,
-    vus_gsrc_dispatch,
-    NULL
-};
-
-static GSource *vus_gsrc_new(VusDev *vdev_scsi, int fd, GIOCondition con=
d,
-                             vu_watch_cb vu_cb, GSourceFunc gsrc_cb, gpo=
inter data)
-{
-    GSource *vus_gsrc;
-    vus_gsrc_t *vus_src;
-    guint id;
-
-    assert(vdev_scsi);
-    assert(fd >=3D 0);
-    assert(vu_cb || gsrc_cb);
-    assert(!(vu_cb && gsrc_cb));
-
-    vus_gsrc =3D g_source_new(&vus_gsrc_funcs, sizeof(vus_gsrc_t));
-    g_source_set_callback(vus_gsrc, (GSourceFunc) vu_cb, data, NULL);
-    vus_src =3D (vus_gsrc_t *)vus_gsrc;
-    vus_src->vdev_scsi =3D vdev_scsi;
-    vus_src->gfd.fd =3D fd;
-    vus_src->gfd.events =3D cond;
-
-    g_source_add_poll(vus_gsrc, &vus_src->gfd);
-    g_source_set_callback(vus_gsrc, gsrc_cb, data, NULL);
-    id =3D g_source_attach(vus_gsrc, NULL);
-    assert(id);
-    g_source_unref(vus_gsrc);
-
-    return vus_gsrc;
-}
-
 /** libiscsi integration **/
=20
 typedef struct virtio_scsi_cmd_req VirtIOSCSICmdReq;
@@ -291,11 +209,13 @@ static int handle_cmd_sync(struct iscsi_context *ct=
x,
=20
 static void vus_panic_cb(VuDev *vu_dev, const char *buf)
 {
+    VugDev *gdev;
     VusDev *vdev_scsi;
=20
     assert(vu_dev);
=20
-    vdev_scsi =3D container_of(vu_dev, VusDev, vu_dev);
+    gdev =3D container_of(vu_dev, VugDev, parent);
+    vdev_scsi =3D container_of(gdev, VusDev, parent);
     if (buf) {
         g_warning("vu_panic: %s", buf);
     }
@@ -303,40 +223,16 @@ static void vus_panic_cb(VuDev *vu_dev, const char =
*buf)
     g_main_loop_quit(vdev_scsi->loop);
 }
=20
-static void vus_add_watch_cb(VuDev *vu_dev, int fd, int vu_evt, vu_watch=
_cb cb,
-                             void *pvt)
-{
-    GSource *src;
-    VusDev *vdev_scsi;
-
-    assert(vu_dev);
-    assert(fd >=3D 0);
-    assert(cb);
-
-    vdev_scsi =3D container_of(vu_dev, VusDev, vu_dev);
-    src =3D vus_gsrc_new(vdev_scsi, fd, vu_evt, cb, NULL, pvt);
-    g_hash_table_replace(vdev_scsi->fdmap, GINT_TO_POINTER(fd), src);
-}
-
-static void vus_del_watch_cb(VuDev *vu_dev, int fd)
-{
-    VusDev *vdev_scsi;
-
-    assert(vu_dev);
-    assert(fd >=3D 0);
-
-    vdev_scsi =3D container_of(vu_dev, VusDev, vu_dev);
-    g_hash_table_remove(vdev_scsi->fdmap, GINT_TO_POINTER(fd));
-}
-
 static void vus_proc_req(VuDev *vu_dev, int idx)
 {
+    VugDev *gdev;
     VusDev *vdev_scsi;
     VuVirtq *vq;
=20
     assert(vu_dev);
=20
-    vdev_scsi =3D container_of(vu_dev, VusDev, vu_dev);
+    gdev =3D container_of(vu_dev, VugDev, parent);
+    vdev_scsi =3D container_of(gdev, VusDev, parent);
     if (idx < 0 || idx >=3D VHOST_MAX_NR_VIRTQUEUE) {
         g_warning("VQ Index out of range: %d", idx);
         vus_panic_cb(vu_dev, NULL);
@@ -420,21 +316,6 @@ static const VuDevIface vus_iface =3D {
     .queue_set_started =3D vus_queue_set_started,
 };
=20
-static gboolean vus_vhost_cb(gpointer data)
-{
-    VuDev *vu_dev =3D (VuDev *)data;
-
-    assert(vu_dev);
-
-    if (!vu_dispatch(vu_dev) !=3D 0) {
-        g_warning("Error processing vhost message");
-        vus_panic_cb(vu_dev, NULL);
-        return G_SOURCE_REMOVE;
-    }
-
-    return G_SOURCE_CONTINUE;
-}
-
 /** misc helpers **/
=20
 static int unix_sock_new(char *unix_fn)
@@ -482,7 +363,6 @@ static void vdev_scsi_free(VusDev *vdev_scsi)
         close(vdev_scsi->server_sock);
     }
     g_main_loop_unref(vdev_scsi->loop);
-    g_hash_table_unref(vdev_scsi->fdmap);
     g_free(vdev_scsi);
 }
=20
@@ -493,9 +373,6 @@ static VusDev *vdev_scsi_new(int server_sock)
     vdev_scsi =3D g_new0(VusDev, 1);
     vdev_scsi->server_sock =3D server_sock;
     vdev_scsi->loop =3D g_main_loop_new(NULL, FALSE);
-    vdev_scsi->fdmap =3D
-        g_hash_table_new_full(NULL, NULL, NULL,
-                              (GDestroyNotify) g_source_destroy);
=20
     return vdev_scsi;
 }
@@ -503,11 +380,9 @@ static VusDev *vdev_scsi_new(int server_sock)
 static int vdev_scsi_run(VusDev *vdev_scsi)
 {
     int cli_sock;
-    int ret =3D 0;
=20
     assert(vdev_scsi);
     assert(vdev_scsi->server_sock >=3D 0);
-    assert(vdev_scsi->loop);
=20
     cli_sock =3D accept(vdev_scsi->server_sock, NULL, NULL);
     if (cli_sock < 0) {
@@ -515,21 +390,16 @@ static int vdev_scsi_run(VusDev *vdev_scsi)
         return -1;
     }
=20
-    vu_init(&vdev_scsi->vu_dev,
-            cli_sock,
-            vus_panic_cb,
-            vus_add_watch_cb,
-            vus_del_watch_cb,
-            &vus_iface);
-
-    vus_gsrc_new(vdev_scsi, cli_sock, G_IO_IN, NULL, vus_vhost_cb,
-                 &vdev_scsi->vu_dev);
+    vug_init(&vdev_scsi->parent,
+             cli_sock,
+             vus_panic_cb,
+             &vus_iface);
=20
     g_main_loop_run(vdev_scsi->loop);
=20
-    vu_deinit(&vdev_scsi->vu_dev);
+    vug_deinit(&vdev_scsi->parent);
=20
-    return ret;
+    return 0;
 }
=20
 int main(int argc, char **argv)
--=20
2.14.1.146.gd35faa819
