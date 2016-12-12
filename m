Received: from eggs.gnu.org ([2001:4830:134:3::10]:42974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGZKh-0003oX-6k
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:44:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGZKf-0003aI-Sa
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:44:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cGZKf-0003Zf-Jy
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:44:29 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B7035C04B320
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 22:44:28 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Dec 2016 01:42:45 +0300
Message-Id: <20161212224325.20790-15-marcandre.lureau@redhat.com>
In-Reply-To: <20161212224325.20790-1-marcandre.lureau@redhat.com>
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 14/54] gtk: overwrite the console.c char driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Instead of registering a vc handler to allocate the Gtk VC Chardev,
overwrite the console.c char driver.

A later patch, when switching to QOM, will register a default console vc
QOM class if none has been registered before.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 ui/console.c          | 24 +++++++-----------------
 ui/gtk.c              | 30 +++++++++++++++++++++---------
 include/sysemu/char.h |  4 +---
 3 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index 80d10c7a4c..9a16e1b743 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -2047,8 +2047,12 @@ static void text_console_do_init(Chardev *chr, Dis=
playState *ds)
=20
 static const CharDriver vc_driver;
=20
-static Chardev *text_console_init(ChardevVC *vc, Error **errp)
+static Chardev *vc_init(const CharDriver *driver,
+                        const char *id, ChardevBackend *backend,
+                        ChardevReturn *ret, bool *be_opened,
+                        Error **errp)
 {
+    ChardevVC *vc =3D backend->u.vc.data;
     ChardevCommon *common =3D qapi_ChardevVC_base(vc);
     Chardev *chr;
     VCChardev *drv;
@@ -2094,26 +2098,13 @@ static Chardev *text_console_init(ChardevVC *vc, =
Error **errp)
     if (display_state) {
         text_console_do_init(chr, display_state);
     }
-    return chr;
-}
=20
-static VcHandler *vc_handler =3D text_console_init;
-
-static Chardev *vc_init(const CharDriver *driver,
-                        const char *id, ChardevBackend *backend,
-                        ChardevReturn *ret, bool *be_opened,
-                        Error **errp)
-{
     /* console/chardev init sometimes completes elsewhere in a 2nd
      * stage, so defer OPENED events until they are fully initialized
      */
     *be_opened =3D false;
-    return vc_handler(backend->u.vc.data, errp);
-}
=20
-void register_vc_handler(VcHandler *handler)
-{
-    vc_handler =3D handler;
+    return chr;
 }
=20
 void qemu_console_resize(QemuConsole *s, int width, int height)
@@ -2151,8 +2142,7 @@ PixelFormat qemu_default_pixelformat(int bpp)
     return pf;
 }
=20
-static void qemu_chr_parse_vc(QemuOpts *opts, ChardevBackend *backend,
-                              Error **errp)
+void qemu_chr_parse_vc(QemuOpts *opts, ChardevBackend *backend, Error **=
errp)
 {
     int val;
     ChardevVC *vc;
diff --git a/ui/gtk.c b/ui/gtk.c
index 32df26e5d7..efa50524bf 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1702,16 +1702,14 @@ static void gd_vc_chr_set_echo(Chardev *chr, bool=
 echo)
=20
 static int nb_vcs;
 static Chardev *vcs[MAX_VCS];
+static const CharDriver gd_vc_driver;
=20
-static Chardev *gd_vc_handler(ChardevVC *vc, Error **errp)
+static Chardev *vc_init(const CharDriver *driver,
+                        const char *id, ChardevBackend *backend,
+                        ChardevReturn *ret, bool *be_opened,
+                        Error **errp)
 {
-    static const CharDriver gd_vc_driver =3D {
-        .instance_size =3D sizeof(VCChardev),
-        .kind =3D CHARDEV_BACKEND_KIND_VC,
-        .chr_write =3D gd_vc_chr_write,
-        .chr_set_echo =3D gd_vc_chr_set_echo,
-    };
-
+    ChardevVC *vc =3D backend->u.vc.data;
     ChardevCommon *common =3D qapi_ChardevVC_base(vc);
     Chardev *chr;
=20
@@ -1727,9 +1725,22 @@ static Chardev *gd_vc_handler(ChardevVC *vc, Error=
 **errp)
=20
     vcs[nb_vcs++] =3D chr;
=20
+    /* console/chardev init sometimes completes elsewhere in a 2nd
+     * stage, so defer OPENED events until they are fully initialized
+     */
+    *be_opened =3D false;
+
     return chr;
 }
=20
+static const CharDriver gd_vc_driver =3D {
+    .instance_size =3D sizeof(VCChardev),
+    .kind =3D CHARDEV_BACKEND_KIND_VC,
+    .parse =3D qemu_chr_parse_vc, .create =3D vc_init,
+    .chr_write =3D gd_vc_chr_write,
+    .chr_set_echo =3D gd_vc_chr_set_echo,
+};
+
 static gboolean gd_vc_in(VteTerminal *terminal, gchar *text, guint size,
                          gpointer user_data)
 {
@@ -2317,6 +2328,7 @@ void early_gtk_display_init(int opengl)
     }
=20
 #if defined(CONFIG_VTE)
-    register_vc_handler(gd_vc_handler);
+    /* overwrite the console.c vc driver */
+    register_char_driver(&gd_vc_driver);
 #endif
 }
diff --git a/include/sysemu/char.h b/include/sysemu/char.h
index 029b14c8b6..384f3ce9b7 100644
--- a/include/sysemu/char.h
+++ b/include/sysemu/char.h
@@ -505,9 +505,7 @@ void register_char_driver(const CharDriver *driver);
=20
 extern int term_escape_char;
=20
-
 /* console.c */
-typedef Chardev *(VcHandler)(ChardevVC *vc, Error **errp);
-void register_vc_handler(VcHandler *handler);
+void qemu_chr_parse_vc(QemuOpts *opts, ChardevBackend *backend, Error **=
errp);
=20
 #endif
--=20
2.11.0
