Received: from eggs.gnu.org ([2001:4830:134:3::10]:43476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dkYOY-0005Vx-JH
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:20:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dkYOX-00070i-Bs
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:20:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dkYOW-00070X-NO
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:20:41 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Aug 2017 18:19:47 +0200
Message-Id: <20170823162004.27337-11-marcandre.lureau@redhat.com>
In-Reply-To: <20170823162004.27337-1-marcandre.lureau@redhat.com>
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 10/27] vhost-user-scsi: remove
 vdev_scsi_find_by_vu()
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

The *dev pointer belongs to the vhost_scsi_dev_t parent.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 contrib/vhost-user-scsi/vhost-user-scsi.c | 47 +++----------------------=
------
 1 file changed, 4 insertions(+), 43 deletions(-)

diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-us=
er-scsi/vhost-user-scsi.c
index d0456a5e7c..bb10848cd2 100644
--- a/contrib/vhost-user-scsi/vhost-user-scsi.c
+++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
@@ -55,8 +55,6 @@
=20
  /* Only 1 LUN and device supported today */
 #define VUS_MAX_LUNS 1
-#define VUS_MAX_DEVS 1
-
 #define VUS_ISCSI_INITIATOR "iqn.2016-11.com.nutanix:vhost-user-scsi"
=20
 typedef struct iscsi_lun {
@@ -72,8 +70,6 @@ typedef struct vhost_scsi_dev {
     iscsi_lun_t luns[VUS_MAX_LUNS];
 } vhost_scsi_dev_t;
=20
-static vhost_scsi_dev_t *vhost_scsi_devs[VUS_MAX_DEVS];
-
 /** glib event loop integration for libvhost-user and misc callbacks **/
=20
 QEMU_BUILD_BUG_ON((int)G_IO_IN !=3D (int)VU_WATCH_IN);
@@ -420,16 +416,13 @@ static int handle_cmd_sync(struct iscsi_context *ct=
x,
=20
 /** libvhost-user callbacks **/
=20
-static vhost_scsi_dev_t *vdev_scsi_find_by_vu(VuDev *vu_dev);
-
 static void vus_panic_cb(VuDev *vu_dev, const char *buf)
 {
     vhost_scsi_dev_t *vdev_scsi;
=20
     assert(vu_dev);
=20
-    vdev_scsi =3D vdev_scsi_find_by_vu(vu_dev);
-
+    vdev_scsi =3D container_of(vu_dev, vhost_scsi_dev_t, vu_dev);
     if (buf) {
         PERR("vu_panic: %s", buf);
     }
@@ -447,12 +440,7 @@ static void vus_add_watch_cb(VuDev *vu_dev, int fd, =
int vu_evt, vu_watch_cb cb,
     assert(fd >=3D 0);
     assert(cb);
=20
-    vdev_scsi =3D vdev_scsi_find_by_vu(vu_dev);
-    if (!vdev_scsi) {
-        vus_panic_cb(vu_dev, NULL);
-        return;
-    }
-
+    vdev_scsi =3D container_of(vu_dev, vhost_scsi_dev_t, vu_dev);
     id =3D (guint)(uintptr_t)g_tree_lookup(vdev_scsi->fdmap,
                                          (gpointer)(uintptr_t)fd);
     if (id) {
@@ -473,12 +461,7 @@ static void vus_del_watch_cb(VuDev *vu_dev, int fd)
     assert(vu_dev);
     assert(fd >=3D 0);
=20
-    vdev_scsi =3D vdev_scsi_find_by_vu(vu_dev);
-    if (!vdev_scsi) {
-        vus_panic_cb(vu_dev, NULL);
-        return;
-    }
-
+    vdev_scsi =3D container_of(vu_dev, vhost_scsi_dev_t, vu_dev);
     id =3D (guint)(uintptr_t)g_tree_lookup(vdev_scsi->fdmap,
                                          (gpointer)(uintptr_t)fd);
     if (id) {
@@ -506,12 +489,7 @@ static void vus_proc_req(VuDev *vu_dev, int idx)
=20
     assert(vu_dev);
=20
-    vdev_scsi =3D vdev_scsi_find_by_vu(vu_dev);
-    if (!vdev_scsi) {
-        vus_panic_cb(vu_dev, NULL);
-        return;
-    }
-
+    vdev_scsi =3D container_of(vu_dev, vhost_scsi_dev_t, vu_dev);
     if (idx < 0 || idx >=3D VHOST_MAX_NR_VIRTQUEUE) {
         PERR("VQ Index out of range: %d", idx);
         vus_panic_cb(vu_dev, NULL);
@@ -656,22 +634,6 @@ fail:
=20
 /** vhost-user-scsi **/
=20
-static vhost_scsi_dev_t *vdev_scsi_find_by_vu(VuDev *vu_dev)
-{
-    int i;
-
-    assert(vu_dev);
-
-    for (i =3D 0; i < VUS_MAX_DEVS; i++) {
-        if (&vhost_scsi_devs[i]->vu_dev =3D=3D vu_dev) {
-            return vhost_scsi_devs[i];
-        }
-    }
-
-    PERR("Unknown VuDev %p", vu_dev);
-    return NULL;
-}
-
 static void vdev_scsi_free(vhost_scsi_dev_t *vdev_scsi)
 {
     if (!vdev_scsi) {
@@ -792,7 +754,6 @@ int main(int argc, char **argv)
         goto err;
     }
     vdev_scsi =3D vdev_scsi_new(sock);
-    vhost_scsi_devs[0] =3D vdev_scsi;
=20
     if (vdev_scsi_add_iscsi_lun(vdev_scsi, iscsi_uri, 0) !=3D 0) {
         goto err;
--=20
2.14.1.146.gd35faa819
