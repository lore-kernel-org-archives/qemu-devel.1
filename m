Received: from eggs.gnu.org ([2001:4830:134:3::10]:43791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dkYP2-0005zQ-Lp
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:21:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dkYP1-0007aK-HK
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:21:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dkYP1-0007Zq-8H
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:21:11 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Aug 2017 18:19:55 +0200
Message-Id: <20170823162004.27337-19-marcandre.lureau@redhat.com>
In-Reply-To: <20170823162004.27337-1-marcandre.lureau@redhat.com>
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 18/27] vhost-user-scsi: rename VUS types
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

- use Vus prefix consistently
- use CamelCase, since that's glib & libvhost-user style
- avoid _t postfix, usually for system headers

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 contrib/vhost-user-scsi/vhost-user-scsi.c | 46 +++++++++++++++----------=
------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-us=
er-scsi/vhost-user-scsi.c
index 882d887a32..2ceca964f4 100644
--- a/contrib/vhost-user-scsi/vhost-user-scsi.c
+++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
@@ -55,18 +55,18 @@
=20
 #define VUS_ISCSI_INITIATOR "iqn.2016-11.com.nutanix:vhost-user-scsi"
=20
-typedef struct iscsi_lun {
+typedef struct VusIscsiLun {
     struct iscsi_context *iscsi_ctx;
     int iscsi_lun;
-} iscsi_lun_t;
+} VusIscsiLun;
=20
-typedef struct vhost_scsi_dev {
+typedef struct VusDev {
     VuDev vu_dev;
     int server_sock;
     GMainLoop *loop;
     GTree *fdmap;   /* fd -> gsource context id */
-    iscsi_lun_t lun;
-} vhost_scsi_dev_t;
+    VusIscsiLun lun;
+} VusDev;
=20
 /** glib event loop integration for libvhost-user and misc callbacks **/
=20
@@ -78,7 +78,7 @@ QEMU_BUILD_BUG_ON((int)G_IO_HUP !=3D (int)VU_WATCH_HUP)=
;
=20
 typedef struct vus_gsrc {
     GSource parent;
-    vhost_scsi_dev_t *vdev_scsi;
+    VusDev *vdev_scsi;
     GPollFD gfd;
     vu_watch_cb vu_cb;
 } vus_gsrc_t;
@@ -107,7 +107,7 @@ static gboolean vus_gsrc_check(GSource *src)
=20
 static gboolean vus_gsrc_dispatch(GSource *src, GSourceFunc cb, gpointer=
 data)
 {
-    vhost_scsi_dev_t *vdev_scsi;
+    VusDev *vdev_scsi;
     vus_gsrc_t *vus_src =3D (vus_gsrc_t *)src;
=20
     assert(vus_src);
@@ -133,7 +133,7 @@ static GSourceFuncs vus_gsrc_funcs =3D {
     NULL
 };
=20
-static void vus_gsrc_new(vhost_scsi_dev_t *vdev_scsi, int fd, GIOConditi=
on cond,
+static void vus_gsrc_new(VusDev *vdev_scsi, int fd, GIOCondition cond,
                          vu_watch_cb vu_cb, gpointer data)
 {
     GSource *vus_gsrc;
@@ -245,7 +245,7 @@ struct scsi_task {
=20
 /** libiscsi integration **/
=20
-static int iscsi_add_lun(iscsi_lun_t *lun, char *iscsi_uri)
+static int iscsi_add_lun(VusIscsiLun *lun, char *iscsi_uri)
 {
     struct iscsi_url *iscsi_url;
     struct iscsi_context *iscsi_ctx;
@@ -415,11 +415,11 @@ static int handle_cmd_sync(struct iscsi_context *ct=
x,
=20
 static void vus_panic_cb(VuDev *vu_dev, const char *buf)
 {
-    vhost_scsi_dev_t *vdev_scsi;
+    VusDev *vdev_scsi;
=20
     assert(vu_dev);
=20
-    vdev_scsi =3D container_of(vu_dev, vhost_scsi_dev_t, vu_dev);
+    vdev_scsi =3D container_of(vu_dev, VusDev, vu_dev);
     if (buf) {
         PERR("vu_panic: %s", buf);
     }
@@ -430,14 +430,14 @@ static void vus_panic_cb(VuDev *vu_dev, const char =
*buf)
 static void vus_add_watch_cb(VuDev *vu_dev, int fd, int vu_evt, vu_watch=
_cb cb,
                              void *pvt)
 {
-    vhost_scsi_dev_t *vdev_scsi;
+    VusDev *vdev_scsi;
     guint id;
=20
     assert(vu_dev);
     assert(fd >=3D 0);
     assert(cb);
=20
-    vdev_scsi =3D container_of(vu_dev, vhost_scsi_dev_t, vu_dev);
+    vdev_scsi =3D container_of(vu_dev, VusDev, vu_dev);
     id =3D (guint)(uintptr_t)g_tree_lookup(vdev_scsi->fdmap,
                                          (gpointer)(uintptr_t)fd);
     if (id) {
@@ -452,13 +452,13 @@ static void vus_add_watch_cb(VuDev *vu_dev, int fd,=
 int vu_evt, vu_watch_cb cb,
=20
 static void vus_del_watch_cb(VuDev *vu_dev, int fd)
 {
-    vhost_scsi_dev_t *vdev_scsi;
+    VusDev *vdev_scsi;
     guint id;
=20
     assert(vu_dev);
     assert(fd >=3D 0);
=20
-    vdev_scsi =3D container_of(vu_dev, vhost_scsi_dev_t, vu_dev);
+    vdev_scsi =3D container_of(vu_dev, VusDev, vu_dev);
     id =3D (guint)(uintptr_t)g_tree_lookup(vdev_scsi->fdmap,
                                          (gpointer)(uintptr_t)fd);
     if (id) {
@@ -471,12 +471,12 @@ static void vus_del_watch_cb(VuDev *vu_dev, int fd)
=20
 static void vus_proc_req(VuDev *vu_dev, int idx)
 {
-    vhost_scsi_dev_t *vdev_scsi;
+    VusDev *vdev_scsi;
     VuVirtq *vq;
=20
     assert(vu_dev);
=20
-    vdev_scsi =3D container_of(vu_dev, vhost_scsi_dev_t, vu_dev);
+    vdev_scsi =3D container_of(vu_dev, VusDev, vu_dev);
     if (idx < 0 || idx >=3D VHOST_MAX_NR_VIRTQUEUE) {
         PERR("VQ Index out of range: %d", idx);
         vus_panic_cb(vu_dev, NULL);
@@ -617,7 +617,7 @@ fail:
=20
 /** vhost-user-scsi **/
=20
-static void vdev_scsi_free(vhost_scsi_dev_t *vdev_scsi)
+static void vdev_scsi_free(VusDev *vdev_scsi)
 {
     if (vdev_scsi->server_sock >=3D 0) {
         close(vdev_scsi->server_sock);
@@ -627,13 +627,13 @@ static void vdev_scsi_free(vhost_scsi_dev_t *vdev_s=
csi)
     g_free(vdev_scsi);
 }
=20
-static vhost_scsi_dev_t *vdev_scsi_new(int server_sock)
+static VusDev *vdev_scsi_new(int server_sock)
 {
-    vhost_scsi_dev_t *vdev_scsi;
+    VusDev *vdev_scsi;
=20
     assert(server_sock >=3D 0);
=20
-    vdev_scsi =3D g_new0(vhost_scsi_dev_t, 1);
+    vdev_scsi =3D g_new0(VusDev, 1);
     vdev_scsi->server_sock =3D server_sock;
     vdev_scsi->loop =3D g_main_loop_new(NULL, FALSE);
     vdev_scsi->fdmap =3D g_tree_new(vus_fdmap_compare);
@@ -641,7 +641,7 @@ static vhost_scsi_dev_t *vdev_scsi_new(int server_soc=
k)
     return vdev_scsi;
 }
=20
-static int vdev_scsi_run(vhost_scsi_dev_t *vdev_scsi)
+static int vdev_scsi_run(VusDev *vdev_scsi)
 {
     GIOChannel *chan;
     int cli_sock;
@@ -676,7 +676,7 @@ static int vdev_scsi_run(vhost_scsi_dev_t *vdev_scsi)
=20
 int main(int argc, char **argv)
 {
-    vhost_scsi_dev_t *vdev_scsi =3D NULL;
+    VusDev *vdev_scsi =3D NULL;
     char *unix_fn =3D NULL;
     char *iscsi_uri =3D NULL;
     int sock, opt, err =3D EXIT_SUCCESS;
--=20
2.14.1.146.gd35faa819
