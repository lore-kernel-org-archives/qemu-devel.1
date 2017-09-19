Received: from eggs.gnu.org ([2001:4830:134:3::10]:47618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1duLn6-0006dG-Im
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:54:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1duLn5-0002qg-CA
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:54:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1duLn5-0002q2-3n
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:54:31 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 19 Sep 2017 18:52:22 +0200
Message-Id: <20170919165226.23022-24-marcandre.lureau@redhat.com>
In-Reply-To: <20170919165226.23022-1-marcandre.lureau@redhat.com>
References: <20170919165226.23022-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 23/27] vhost-user-scsi: simplify source
 handling
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

Using a hashtable.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 contrib/vhost-user-scsi/vhost-user-scsi.c | 45 +++++++++----------------=
------
 1 file changed, 12 insertions(+), 33 deletions(-)

diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-us=
er-scsi/vhost-user-scsi.c
index 0e6784187c..2e1100dea3 100644
--- a/contrib/vhost-user-scsi/vhost-user-scsi.c
+++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
@@ -65,7 +65,7 @@ typedef struct VusDev {
     VuDev vu_dev;
     int server_sock;
     GMainLoop *loop;
-    GTree *fdmap;   /* fd -> gsource context id */
+    GHashTable *fdmap;   /* fd -> gsource */
     VusIscsiLun lun;
 } VusDev;
=20
@@ -83,11 +83,6 @@ typedef struct vus_gsrc {
     GPollFD gfd;
 } vus_gsrc_t;
=20
-static gint vus_fdmap_compare(gconstpointer a, gconstpointer b)
-{
-    return (b > a) - (b < a);
-}
-
 static gboolean vus_gsrc_prepare(GSource *src, gint *timeout)
 {
     assert(timeout);
@@ -128,8 +123,8 @@ static GSourceFuncs vus_gsrc_funcs =3D {
     NULL
 };
=20
-static void vus_gsrc_new(VusDev *vdev_scsi, int fd, GIOCondition cond,
-                         vu_watch_cb vu_cb, GSourceFunc gsrc_cb, gpointe=
r data)
+static GSource *vus_gsrc_new(VusDev *vdev_scsi, int fd, GIOCondition con=
d,
+                             vu_watch_cb vu_cb, GSourceFunc gsrc_cb, gpo=
inter data)
 {
     GSource *vus_gsrc;
     vus_gsrc_t *vus_src;
@@ -143,7 +138,6 @@ static void vus_gsrc_new(VusDev *vdev_scsi, int fd, G=
IOCondition cond,
     vus_gsrc =3D g_source_new(&vus_gsrc_funcs, sizeof(vus_gsrc_t));
     g_source_set_callback(vus_gsrc, (GSourceFunc) vu_cb, data, NULL);
     vus_src =3D (vus_gsrc_t *)vus_gsrc;
-
     vus_src->vdev_scsi =3D vdev_scsi;
     vus_src->gfd.fd =3D fd;
     vus_src->gfd.events =3D cond;
@@ -154,8 +148,7 @@ static void vus_gsrc_new(VusDev *vdev_scsi, int fd, G=
IOCondition cond,
     assert(id);
     g_source_unref(vus_gsrc);
=20
-    g_tree_insert(vdev_scsi->fdmap, (gpointer)(uintptr_t)fd,
-                                    (gpointer)(uintptr_t)id);
+    return vus_gsrc;
 }
=20
 /** libiscsi integration **/
@@ -348,43 +341,27 @@ static void vus_panic_cb(VuDev *vu_dev, const char =
*buf)
 static void vus_add_watch_cb(VuDev *vu_dev, int fd, int vu_evt, vu_watch=
_cb cb,
                              void *pvt)
 {
+    GSource *src;
     VusDev *vdev_scsi;
-    guint id;
=20
     assert(vu_dev);
     assert(fd >=3D 0);
     assert(cb);
=20
     vdev_scsi =3D container_of(vu_dev, VusDev, vu_dev);
-    id =3D (guint)(uintptr_t)g_tree_lookup(vdev_scsi->fdmap,
-                                         (gpointer)(uintptr_t)fd);
-    if (id) {
-        GSource *vus_src =3D g_main_context_find_source_by_id(NULL, id);
-        assert(vus_src);
-        g_source_destroy(vus_src);
-        (void)g_tree_remove(vdev_scsi->fdmap, (gpointer)(uintptr_t)fd);
-    }
-
-    vus_gsrc_new(vdev_scsi, fd, vu_evt, cb, NULL, pvt);
+    src =3D vus_gsrc_new(vdev_scsi, fd, vu_evt, cb, NULL, pvt);
+    g_hash_table_replace(vdev_scsi->fdmap, GINT_TO_POINTER(fd), src);
 }
=20
 static void vus_del_watch_cb(VuDev *vu_dev, int fd)
 {
     VusDev *vdev_scsi;
-    guint id;
=20
     assert(vu_dev);
     assert(fd >=3D 0);
=20
     vdev_scsi =3D container_of(vu_dev, VusDev, vu_dev);
-    id =3D (guint)(uintptr_t)g_tree_lookup(vdev_scsi->fdmap,
-                                         (gpointer)(uintptr_t)fd);
-    if (id) {
-        GSource *vus_src =3D g_main_context_find_source_by_id(NULL, id);
-        assert(vus_src);
-        g_source_destroy(vus_src);
-        (void)g_tree_remove(vdev_scsi->fdmap, (gpointer)(uintptr_t)fd);
-    }
+    g_hash_table_remove(vdev_scsi->fdmap, GINT_TO_POINTER(fd));
 }
=20
 static void vus_proc_req(VuDev *vu_dev, int idx)
@@ -540,7 +517,7 @@ static void vdev_scsi_free(VusDev *vdev_scsi)
         close(vdev_scsi->server_sock);
     }
     g_main_loop_unref(vdev_scsi->loop);
-    g_tree_destroy(vdev_scsi->fdmap);
+    g_hash_table_unref(vdev_scsi->fdmap);
     g_free(vdev_scsi);
 }
=20
@@ -551,7 +528,9 @@ static VusDev *vdev_scsi_new(int server_sock)
     vdev_scsi =3D g_new0(VusDev, 1);
     vdev_scsi->server_sock =3D server_sock;
     vdev_scsi->loop =3D g_main_loop_new(NULL, FALSE);
-    vdev_scsi->fdmap =3D g_tree_new(vus_fdmap_compare);
+    vdev_scsi->fdmap =3D
+        g_hash_table_new_full(NULL, NULL, NULL,
+                              (GDestroyNotify) g_source_destroy);
=20
     return vdev_scsi;
 }
--=20
2.14.1.146.gd35faa819
