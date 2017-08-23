Received: from eggs.gnu.org ([2001:4830:134:3::10]:44120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dkYPa-0006SM-8i
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:21:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dkYPX-0007qB-2D
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:21:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dkYPW-0007pa-QB
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:21:43 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Aug 2017 18:20:03 +0200
Message-Id: <20170823162004.27337-27-marcandre.lureau@redhat.com>
In-Reply-To: <20170823162004.27337-1-marcandre.lureau@redhat.com>
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 26/27] vhost-user-scsi: use libvhost-user glib
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: changpeng.liu@intel.com, felipe@nutanix.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 contrib/vhost-user-scsi/vhost-user-scsi.c | 155 +++++-------------------=
------
 Makefile.objs                             |   3 +-
 2 files changed, 23 insertions(+), 135 deletions(-)

diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-us=
er-scsi/vhost-user-scsi.c
index e3ec8b9b2c..cfd62b46ce 100644
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
@@ -26,93 +26,12 @@ typedef struct VusIscsiLun {
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
-    ((vu_watch_cb)cb) (&vdev_scsi->vu_dev, vus_src->gfd.revents, data);
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
-                             vu_watch_cb vu_cb, gpointer data)
-{
-    GSource *vus_gsrc;
-    vus_gsrc_t *vus_src;
-    guint id;
-
-    assert(vdev_scsi);
-    assert(fd >=3D 0);
-    assert(vu_cb);
-
-    vus_gsrc =3D g_source_new(&vus_gsrc_funcs, sizeof(vus_gsrc_t));
-    g_source_set_callback(vus_gsrc, (GSourceFunc) vu_cb, data, NULL);
-    vus_src =3D (vus_gsrc_t *)vus_gsrc;
-    vus_src->vdev_scsi =3D vdev_scsi;
-    vus_src->gfd.fd =3D fd;
-    vus_src->gfd.events =3D cond;
-
-    g_source_add_poll(vus_gsrc, &vus_src->gfd);
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
@@ -289,52 +208,28 @@ static int handle_cmd_sync(struct iscsi_context *ct=
x,
=20
 static void vus_panic_cb(VuDev *vu_dev, const char *buf)
 {
-    VusDev *vdev_scsi;
+    VugDev *gdev;
=20
     assert(vu_dev);
=20
-    vdev_scsi =3D container_of(vu_dev, VusDev, vu_dev);
+    gdev =3D container_of(vu_dev, VugDev, parent);
     if (buf) {
         g_warning("vu_panic: %s", buf);
     }
=20
-    g_main_loop_quit(vdev_scsi->loop);
-}
-
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
-    src =3D vus_gsrc_new(vdev_scsi, fd, vu_evt, cb, pvt);
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
+    g_main_loop_quit(gdev->loop);
 }
=20
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
@@ -421,9 +316,8 @@ static const VuDevIface vus_iface =3D {
 static gboolean vus_vhost_cb(GIOChannel *source, GIOCondition condition,
                              gpointer data)
 {
-    VuDev *vu_dev =3D (VuDev *)data;
-
-    assert(vu_dev);
+    VusDev *vdev_scsi =3D data;
+    VuDev *vu_dev =3D &vdev_scsi->parent.parent;
=20
     if (!vu_dispatch(vu_dev) !=3D 0) {
         g_warning("Error processing vhost message");
@@ -480,8 +374,6 @@ static void vdev_scsi_free(VusDev *vdev_scsi)
     if (vdev_scsi->server_sock >=3D 0) {
         close(vdev_scsi->server_sock);
     }
-    g_main_loop_unref(vdev_scsi->loop);
-    g_hash_table_unref(vdev_scsi->fdmap);
     g_free(vdev_scsi);
 }
=20
@@ -493,23 +385,19 @@ static VusDev *vdev_scsi_new(int server_sock)
=20
     vdev_scsi =3D g_new0(VusDev, 1);
     vdev_scsi->server_sock =3D server_sock;
-    vdev_scsi->loop =3D g_main_loop_new(NULL, FALSE);
-    vdev_scsi->fdmap =3D
-        g_hash_table_new_full(NULL, NULL, NULL,
-                              (GDestroyNotify) g_source_destroy);
=20
     return vdev_scsi;
 }
=20
 static int vdev_scsi_run(VusDev *vdev_scsi)
 {
+    GMainLoop *loop;
     GIOChannel *chan;
     int cli_sock;
     int ret =3D 0;
=20
     assert(vdev_scsi);
     assert(vdev_scsi->server_sock >=3D 0);
-    assert(vdev_scsi->loop);
=20
     cli_sock =3D accept(vdev_scsi->server_sock, NULL, NULL);
     if (cli_sock < 0) {
@@ -517,19 +405,20 @@ static int vdev_scsi_run(VusDev *vdev_scsi)
         return -1;
     }
=20
-    vu_init(&vdev_scsi->vu_dev,
-            cli_sock,
-            vus_panic_cb,
-            vus_add_watch_cb,
-            vus_del_watch_cb,
-            &vus_iface);
+    loop =3D g_main_loop_new(NULL, FALSE);
+    vug_init(&vdev_scsi->parent,
+             cli_sock,
+             loop,
+             vus_panic_cb,
+             &vus_iface);
=20
     chan =3D g_io_channel_unix_new(cli_sock);
-    g_io_add_watch(chan, G_IO_IN, vus_vhost_cb, &vdev_scsi->vu_dev);
-    g_main_loop_run(vdev_scsi->loop);
+    g_io_add_watch(chan, G_IO_IN, vus_vhost_cb, vdev_scsi);
+    g_main_loop_run(loop);
     g_io_channel_unref(chan);
+    g_main_loop_unref(loop);
=20
-    vu_deinit(&vdev_scsi->vu_dev);
+    vug_deinit(&vdev_scsi->parent);
=20
     return ret;
 }
diff --git a/Makefile.objs b/Makefile.objs
index 24a4ea08b8..88da7d88e9 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -111,9 +111,8 @@ ivshmem-client-obj-$(CONFIG_IVSHMEM) =3D contrib/ivsh=
mem-client/
 ivshmem-server-obj-$(CONFIG_IVSHMEM) =3D contrib/ivshmem-server/
 libvhost-user-obj-y =3D contrib/libvhost-user/
 vhost-user-scsi.o-cflags :=3D $(LIBISCSI_CFLAGS)
-vhost-user-scsi.o-libs :=3D $(LIBISCSI_LIBS)
+vhost-user-scsi.o-libs :=3D $(LIBISCSI_LIBS) libvhost-user.a
 vhost-user-scsi-obj-y =3D contrib/vhost-user-scsi/
-vhost-user-scsi-obj-y +=3D contrib/libvhost-user/libvhost-user.o
=20
 ######################################################################
 trace-events-subdirs =3D
--=20
2.14.1.146.gd35faa819
