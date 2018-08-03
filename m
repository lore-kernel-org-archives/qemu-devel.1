Received: from eggs.gnu.org ([2001:4830:134:3::10]:40261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fle0h-0008GT-ED
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:37:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fle0f-0001Y2-VQ
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:37:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37960 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fle0f-0001Xh-PC
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 13:37:05 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 540D58197021
	for <qemu-devel@nongnu.org>; Fri,  3 Aug 2018 17:37:05 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  3 Aug 2018 19:36:14 +0200
Message-Id: <20180803173614.12358-11-marcandre.lureau@redhat.com>
In-Reply-To: <20180803173614.12358-1-marcandre.lureau@redhat.com>
References: <20180803173614.12358-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 10/10] display: add -display app launching
 external application
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Add a new display backend that will configure Spice to allow a remote
client to control QEMU in a similar fashion as other display backend
like GTK.

For this to work, we set up Spice server with a unix socket, and
register a VC chardev that will be exposed as Spice ports. A QMP
monitor is also exposed as a Spice port, this allows the remote client
fuller qemu control and state handling.

- doesn't handle VC set_echo() - this doesn't seem a strong
  requirement, very few front-end use it
- spice options can be tweaked with other -spice arguments
- Windows support shouldn't be hard to do, but will probably use a TCP
  port instead
- we may want to watch the child process to quit automatically if it
  crashed

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi/ui.json     |   3 +-
 ui/app.c         | 179 +++++++++++++++++++++++++++++++++++++++++++++++
 qemu-options.hx  |   5 ++
 ui/Makefile.objs |   5 ++
 4 files changed, 191 insertions(+), 1 deletion(-)
 create mode 100644 ui/app.c

diff --git a/qapi/ui.json b/qapi/ui.json
index 4ca91bb45a..9b96f1f9d7 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1057,7 +1057,8 @@
 ##
 { 'enum'    : 'DisplayType',
   'data'    : [ 'default', 'none', 'gtk', 'sdl',
-                'egl-headless', 'curses', 'cocoa' ] }
+                'egl-headless', 'curses', 'cocoa',
+                'app'] }
=20
 ##
 # @DisplayOptions:
diff --git a/ui/app.c b/ui/app.c
new file mode 100644
index 0000000000..d29f630a70
--- /dev/null
+++ b/ui/app.c
@@ -0,0 +1,179 @@
+/*
+ * QEMU external app display driver
+ *
+ * Copyright (c) 2018 Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.co=
m>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
+ * of this software and associated documentation files (the "Software"),=
 to deal
+ * in the Software without restriction, including without limitation the=
 rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be includ=
ed in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
+ * THE SOFTWARE.
+ */
+#include "qemu/osdep.h"
+
+#include <gio/gio.h>
+
+#include "qemu-common.h"
+#include "ui/console.h"
+#include "qemu/config-file.h"
+#include "qemu/option.h"
+#include "qemu/cutils.h"
+#include "qapi/error.h"
+#include "io/channel-command.h"
+#include "chardev/spice.h"
+#include "sysemu/sysemu.h"
+
+static char *tmp_dir;
+static char *sock_path;
+
+typedef struct VCChardev {
+    SpiceChardev parent;
+} VCChardev;
+
+#define TYPE_CHARDEV_VC "chardev-vc"
+#define VC_CHARDEV(obj) OBJECT_CHECK(VCChardev, (obj), TYPE_CHARDEV_VC)
+
+static ChardevBackend *
+chr_spice_backend_new(void)
+{
+    ChardevBackend *be =3D g_new0(ChardevBackend, 1);
+
+    be->type =3D CHARDEV_BACKEND_KIND_SPICEPORT;
+    be->u.spiceport.data =3D g_new0(ChardevSpicePort, 1);
+
+    return be;
+}
+
+static void vc_chr_open(Chardev *chr,
+                        ChardevBackend *backend,
+                        bool *be_opened,
+                        Error **errp)
+{
+    ChardevBackend *be;
+    const char *fqdn =3D NULL;
+
+    if (strstart(chr->label, "serial", NULL)) {
+        fqdn =3D "org.qemu.console.serial.0";
+    } else if (strstart(chr->label, "parallel", NULL)) {
+        fqdn =3D "org.qemu.console.parallel.0";
+    } else if (strstart(chr->label, "compat_monitor", NULL)) {
+        fqdn =3D "org.qemu.monitor.hmp.0";
+    }
+
+    be =3D chr_spice_backend_new();
+    be->u.spiceport.data->fqdn =3D fqdn ?
+        g_strdup(fqdn) : g_strdup_printf("org.qemu.console.%s", chr->lab=
el);
+    qemu_chr_open_spice_port(chr, be, be_opened, errp);
+    qapi_free_ChardevBackend(be);
+}
+
+static void vc_chr_set_echo(Chardev *chr, bool echo)
+{
+    /* TODO: set echo for frontends QMP and qtest */
+}
+
+static void char_vc_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc =3D CHARDEV_CLASS(oc);
+
+    cc->parse =3D qemu_chr_parse_vc;
+    cc->open =3D vc_chr_open;
+    cc->chr_set_echo =3D vc_chr_set_echo;
+}
+
+static const TypeInfo char_vc_type_info =3D {
+    .name =3D TYPE_CHARDEV_VC,
+    .parent =3D TYPE_CHARDEV_SPICEPORT,
+    .instance_size =3D sizeof(VCChardev),
+    .class_init =3D char_vc_class_init,
+};
+
+static void app_atexit(void)
+{
+    if (sock_path) {
+        unlink(sock_path);
+    }
+    if (tmp_dir) {
+        rmdir(tmp_dir);
+    }
+    g_free(sock_path);
+    g_free(tmp_dir);
+}
+
+static void app_display_early_init(DisplayOptions *opts)
+{
+    QemuOpts *qopts;
+    ChardevBackend *be =3D chr_spice_backend_new();
+    GError *err =3D NULL;
+
+    atexit(app_atexit);
+    tmp_dir =3D g_dir_make_tmp(NULL, &err);
+    if (err) {
+        error_report("Failed to create temporary directory: %s", err->me=
ssage);
+        abort();
+    }
+
+    type_register(&char_vc_type_info);
+
+    sock_path =3D g_strjoin("", tmp_dir, "/", "spice.sock", NULL);
+    qopts =3D qemu_opts_create(qemu_find_opts("spice"), NULL, 0, &error_=
abort);
+    qemu_opt_set(qopts, "disable-ticketing", "on", &error_abort);
+    qemu_opt_set(qopts, "unix", "on", &error_abort);
+    qemu_opt_set(qopts, "addr", sock_path, &error_abort);
+    qemu_opt_set(qopts, "image-compression", "off", &error_abort);
+    qemu_opt_set(qopts, "streaming-video", "off", &error_abort);
+    qemu_opt_set(qopts, "gl", opts->has_gl ? "on" : "off", &error_abort)=
;
+    display_opengl =3D opts->has_gl;
+
+    be->u.spiceport.data->fqdn =3D g_strdup("org.qemu.monitor.qmp.0");
+    qemu_chardev_new("org.qemu.monitor.qmp", TYPE_CHARDEV_SPICEPORT,
+                     be, &error_abort);
+    qopts =3D qemu_opts_create(qemu_find_opts("mon"),
+                             NULL, 0, &error_fatal);
+    qemu_opt_set(qopts, "chardev", "org.qemu.monitor.qmp", &error_abort)=
;
+    qemu_opt_set(qopts, "mode", "control", &error_abort);
+
+    if (!qemu_name) {
+        qemu_name =3D "QEMU";
+    }
+    qapi_free_ChardevBackend(be);
+}
+
+static void app_display_init(DisplayState *ds, DisplayOptions *opts)
+{
+    GError *err =3D NULL;
+    gchar *uri;
+
+    uri =3D g_strjoin("", "spice+unix://", tmp_dir, "/", "spice.sock", N=
ULL);
+    g_app_info_launch_default_for_uri(uri, NULL, &err);
+    if (err) {
+        error_report("Failed to launch %s URI: %s", uri, err->message);
+        exit(1);
+    }
+    g_free(uri);
+}
+
+static QemuDisplay qemu_display_app =3D {
+    .type       =3D DISPLAY_TYPE_APP,
+    .early_init =3D app_display_early_init,
+    .init       =3D app_display_init,
+};
+
+static void register_app(void)
+{
+    qemu_display_register(&qemu_display_app);
+}
+
+type_init(register_app);
diff --git a/qemu-options.hx b/qemu-options.hx
index b1bf0f485f..846e0b5c65 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1239,6 +1239,7 @@ STEXI
 ETEXI
=20
 DEF("display", HAS_ARG, QEMU_OPTION_display,
+    "-display app[,gl=3Don|off]\n"
     "-display sdl[,frame=3Don|off][,alt_grab=3Don|off][,ctrl_grab=3Don|o=
ff]\n"
     "            [,window_close=3Don|off][,gl=3Don|core|es|off]\n"
     "-display gtk[,grab_on_hover=3Don|off][,gl=3Don|off]|\n"
@@ -1286,6 +1287,10 @@ menus and other UI elements to configure and contr=
ol the VM during
 runtime.
 @item vnc
 Start a VNC server on display <arg>
+@item app
+Start QEMU as a Spice server and launch the default Spice client
+application. The Spice server will redirect the serial consoles and
+QEMU monitors.
 @end table
 ETEXI
=20
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index 00f6976c30..11178fbe24 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -54,6 +54,11 @@ curses.mo-objs :=3D curses.o
 curses.mo-cflags :=3D $(CURSES_CFLAGS)
 curses.mo-libs :=3D $(CURSES_LIBS)
=20
+common-obj-$(call land,$(CONFIG_SPICE),$(CONFIG_GIO)) +=3D app.mo
+app.mo-objs :=3D app.o
+app.mo-cflags :=3D $(GIO_CFLAGS)
+app.mo-libs :=3D $(GIO_LIBS)
+
 common-obj-$(CONFIG_OPENGL) +=3D shader.o
 common-obj-$(CONFIG_OPENGL) +=3D console-gl.o
 common-obj-$(CONFIG_OPENGL) +=3D egl-helpers.o
--=20
2.18.0.547.g1d89318c48
