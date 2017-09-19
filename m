Received: from eggs.gnu.org ([2001:4830:134:3::10]:46564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1duLm2-0005gA-5k
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:53:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1duLlx-0001s3-OD
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:53:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1duLlx-0001rV-FX
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:53:21 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 19 Sep 2017 18:52:09 +0200
Message-Id: <20170919165226.23022-11-marcandre.lureau@redhat.com>
In-Reply-To: <20170919165226.23022-1-marcandre.lureau@redhat.com>
References: <20170919165226.23022-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 10/27] vhost-user-scsi: glib calls that
 allocate don't return NULL
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

They abort instead, so get rid of failure conditions.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 contrib/vhost-user-scsi/vhost-user-scsi.c | 52 +++++--------------------=
------
 1 file changed, 7 insertions(+), 45 deletions(-)

diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-us=
er-scsi/vhost-user-scsi.c
index cf2793ef02..e3ae2bbd72 100644
--- a/contrib/vhost-user-scsi/vhost-user-scsi.c
+++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
@@ -139,8 +139,8 @@ static GSourceFuncs vus_gsrc_funcs =3D {
     NULL
 };
=20
-static int vus_gsrc_new(vhost_scsi_dev_t *vdev_scsi, int fd, GIOConditio=
n cond,
-                        vu_watch_cb vu_cb, GSourceFunc gsrc_cb, gpointer=
 data)
+static void vus_gsrc_new(vhost_scsi_dev_t *vdev_scsi, int fd, GIOConditi=
on cond,
+                         vu_watch_cb vu_cb, GSourceFunc gsrc_cb, gpointe=
r data)
 {
     GSource *vus_gsrc;
     vus_gsrc_t *vus_src;
@@ -152,10 +152,6 @@ static int vus_gsrc_new(vhost_scsi_dev_t *vdev_scsi,=
 int fd, GIOCondition cond,
     assert(!(vu_cb && gsrc_cb));
=20
     vus_gsrc =3D g_source_new(&vus_gsrc_funcs, sizeof(vus_gsrc_t));
-    if (!vus_gsrc) {
-        PERR("Error creating GSource for new watch");
-        return -1;
-    }
     vus_src =3D (vus_gsrc_t *)vus_gsrc;
=20
     vus_src->vdev_scsi =3D vdev_scsi;
@@ -171,8 +167,6 @@ static int vus_gsrc_new(vhost_scsi_dev_t *vdev_scsi, =
int fd, GIOCondition cond,
=20
     g_tree_insert(vdev_scsi->fdmap, (gpointer)(uintptr_t)fd,
                                     (gpointer)(uintptr_t)id);
-
-    return 0;
 }
=20
 /* from libiscsi's scsi-lowlevel.h **
@@ -440,10 +434,7 @@ static void vus_panic_cb(VuDev *vu_dev, const char *=
buf)
         PERR("vu_panic: %s", buf);
     }
=20
-    if (vdev_scsi) {
-        assert(vdev_scsi->loop);
-        g_main_loop_quit(vdev_scsi->loop);
-    }
+    g_main_loop_quit(vdev_scsi->loop);
 }
=20
 static void vus_add_watch_cb(VuDev *vu_dev, int fd, int vu_evt, vu_watch=
_cb cb,
@@ -471,9 +462,7 @@ static void vus_add_watch_cb(VuDev *vu_dev, int fd, i=
nt vu_evt, vu_watch_cb cb,
         (void)g_tree_remove(vdev_scsi->fdmap, (gpointer)(uintptr_t)fd);
     }
=20
-    if (vus_gsrc_new(vdev_scsi, fd, vu_evt, cb, NULL, pvt)) {
-        vus_panic_cb(vu_dev, NULL);
-    }
+    vus_gsrc_new(vdev_scsi, fd, vu_evt, cb, NULL, pvt);
 }
=20
 static void vus_del_watch_cb(VuDev *vu_dev, int fd)
@@ -703,10 +692,7 @@ static void vdev_scsi_free(vhost_scsi_dev_t *vdev_sc=
si)
         vdev_scsi->server_sock =3D -1;
     }
=20
-    if (vdev_scsi->loop) {
-        g_main_loop_unref(vdev_scsi->loop);
-        vdev_scsi->loop =3D NULL;
-    }
+    g_main_loop_unref(vdev_scsi->loop);
     g_free(vdev_scsi);
 }
=20
@@ -717,23 +703,9 @@ static vhost_scsi_dev_t *vdev_scsi_new(int server_so=
ck)
     vdev_scsi =3D g_new0(vhost_scsi_dev_t, 1);
     vdev_scsi->server_sock =3D server_sock;
     vdev_scsi->loop =3D g_main_loop_new(NULL, FALSE);
-    if (!vdev_scsi->loop) {
-        PERR("Error creating glib event loop");
-        goto err;
-    }
-
     vdev_scsi->fdmap =3D g_tree_new(vus_fdmap_compare);
-    if (!vdev_scsi->fdmap) {
-        PERR("Error creating glib tree for fdmap");
-        goto err;
-    }
=20
     return vdev_scsi;
-
-err:
-    vdev_scsi_free(vdev_scsi);
-
-    return NULL;
 }
=20
 static int vdev_scsi_add_iscsi_lun(vhost_scsi_dev_t *vdev_scsi,
@@ -777,21 +749,14 @@ static int vdev_scsi_run(vhost_scsi_dev_t *vdev_scs=
i)
             vus_del_watch_cb,
             &vus_iface);
=20
-    if (vus_gsrc_new(vdev_scsi, cli_sock, G_IO_IN, NULL, vus_vhost_cb,
-                     &vdev_scsi->vu_dev)) {
-        goto fail;
-    }
+    vus_gsrc_new(vdev_scsi, cli_sock, G_IO_IN, NULL, vus_vhost_cb,
+                 &vdev_scsi->vu_dev);
=20
     g_main_loop_run(vdev_scsi->loop);
=20
-out:
     vu_deinit(&vdev_scsi->vu_dev);
=20
     return ret;
-
-fail:
-    ret =3D -1;
-    goto out;
 }
=20
 int main(int argc, char **argv)
@@ -824,9 +789,6 @@ int main(int argc, char **argv)
         goto err;
     }
     vdev_scsi =3D vdev_scsi_new(sock);
-    if (!vdev_scsi) {
-        goto err;
-    }
     vhost_scsi_devs[0] =3D vdev_scsi;
=20
     if (vdev_scsi_add_iscsi_lun(vdev_scsi, iscsi_uri, 0) !=3D 0) {
--=20
2.14.1.146.gd35faa819
