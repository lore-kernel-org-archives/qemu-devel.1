Received: from eggs.gnu.org ([2001:4830:134:3::10]:33887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6rL-0005X2-UY
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6rK-0004IV-LP
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:36 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cX6rK-0004I0-Cg
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:34 -0500
Received: by mail-wm0-x243.google.com with SMTP id d140so58625187wmd.2
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 05:46:34 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Jan 2017 14:45:45 +0100
Message-Id: <1485524749-118532-38-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
References: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 37/41] gtk: overwrite the console.c char driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Instead of registering a vc handler to allocate the Gtk VC Chardev,
overwrite the console.c char driver.

A later patch, when switching to QOM, will register a default console vc
QOM class if none has been registered before.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/char.h |  4 +---
 ui/console.c          | 24 +++++++-----------------
 ui/gtk.c              | 30 +++++++++++++++++++++---------
 3 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/include/sysemu/char.h b/include/sysemu/char.h
index 3a82d80..baa9e8f 100644
--- a/include/sysemu/char.h
+++ b/include/sysemu/char.h
@@ -507,9 +507,7 @@ void register_char_driver(const CharDriver *driver);
 
 extern int term_escape_char;
 
-
 /* console.c */
-typedef Chardev *(VcHandler)(ChardevVC *vc, Error **errp);
-void register_vc_handler(VcHandler *handler);
+void qemu_chr_parse_vc(QemuOpts *opts, ChardevBackend *backend, Error **errp);
 
 #endif
diff --git a/ui/console.c b/ui/console.c
index 7420f28..d8bc8a6 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -2058,8 +2058,12 @@ static void text_console_do_init(Chardev *chr, DisplayState *ds)
 
 static const CharDriver vc_driver;
 
-static Chardev *text_console_init(ChardevVC *vc, Error **errp)
+static Chardev *vc_init(const CharDriver *driver,
+                        const char *id, ChardevBackend *backend,
+                        ChardevReturn *ret, bool *be_opened,
+                        Error **errp)
 {
+    ChardevVC *vc = backend->u.vc.data;
     ChardevCommon *common = qapi_ChardevVC_base(vc);
     Chardev *chr;
     VCChardev *drv;
@@ -2105,26 +2109,13 @@ static Chardev *text_console_init(ChardevVC *vc, Error **errp)
     if (display_state) {
         text_console_do_init(chr, display_state);
     }
-    return chr;
-}
 
-static VcHandler *vc_handler = text_console_init;
-
-static Chardev *vc_init(const CharDriver *driver,
-                        const char *id, ChardevBackend *backend,
-                        ChardevReturn *ret, bool *be_opened,
-                        Error **errp)
-{
     /* console/chardev init sometimes completes elsewhere in a 2nd
      * stage, so defer OPENED events until they are fully initialized
      */
     *be_opened = false;
-    return vc_handler(backend->u.vc.data, errp);
-}
 
-void register_vc_handler(VcHandler *handler)
-{
-    vc_handler = handler;
+    return chr;
 }
 
 void qemu_console_resize(QemuConsole *s, int width, int height)
@@ -2162,8 +2153,7 @@ PixelFormat qemu_default_pixelformat(int bpp)
     return pf;
 }
 
-static void qemu_chr_parse_vc(QemuOpts *opts, ChardevBackend *backend,
-                              Error **errp)
+void qemu_chr_parse_vc(QemuOpts *opts, ChardevBackend *backend, Error **errp)
 {
     int val;
     ChardevVC *vc;
diff --git a/ui/gtk.c b/ui/gtk.c
index 175871a..04df0ad 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1712,16 +1712,14 @@ static void gd_vc_chr_set_echo(Chardev *chr, bool echo)
 
 static int nb_vcs;
 static Chardev *vcs[MAX_VCS];
+static const CharDriver gd_vc_driver;
 
-static Chardev *gd_vc_handler(ChardevVC *vc, Error **errp)
+static Chardev *vc_init(const CharDriver *driver,
+                        const char *id, ChardevBackend *backend,
+                        ChardevReturn *ret, bool *be_opened,
+                        Error **errp)
 {
-    static const CharDriver gd_vc_driver = {
-        .instance_size = sizeof(VCChardev),
-        .kind = CHARDEV_BACKEND_KIND_VC,
-        .chr_write = gd_vc_chr_write,
-        .chr_set_echo = gd_vc_chr_set_echo,
-    };
-
+    ChardevVC *vc = backend->u.vc.data;
     ChardevCommon *common = qapi_ChardevVC_base(vc);
     Chardev *chr;
 
@@ -1737,9 +1735,22 @@ static Chardev *gd_vc_handler(ChardevVC *vc, Error **errp)
 
     vcs[nb_vcs++] = chr;
 
+    /* console/chardev init sometimes completes elsewhere in a 2nd
+     * stage, so defer OPENED events until they are fully initialized
+     */
+    *be_opened = false;
+
     return chr;
 }
 
+static const CharDriver gd_vc_driver = {
+    .instance_size = sizeof(VCChardev),
+    .kind = CHARDEV_BACKEND_KIND_VC,
+    .parse = qemu_chr_parse_vc, .create = vc_init,
+    .chr_write = gd_vc_chr_write,
+    .chr_set_echo = gd_vc_chr_set_echo,
+};
+
 static gboolean gd_vc_in(VteTerminal *terminal, gchar *text, guint size,
                          gpointer user_data)
 {
@@ -2336,6 +2347,7 @@ void early_gtk_display_init(int opengl)
     }
 
 #if defined(CONFIG_VTE)
-    register_vc_handler(gd_vc_handler);
+    /* overwrite the console.c vc driver */
+    register_char_driver(&gd_vc_driver);
 #endif
 }
-- 
1.8.3.1
