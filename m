Received: from eggs.gnu.org ([2001:4830:134:3::10]:49814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdvE-0000n0-1K
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:30:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdvB-0007N9-RT
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:30:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eFdvB-0007LN-Hh
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:30:53 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BBDA1C0587D9
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 10:30:52 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 17 Nov 2017 11:30:40 +0100
Message-Id: <20171117103046.15943-19-kraxel@redhat.com>
In-Reply-To: <20171117103046.15943-1-kraxel@redhat.com>
References: <20171117103046.15943-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 18/24] egl-headless: hook up to display registry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/console.h |  3 ---
 ui/egl-headless.c    | 20 +++++++++++++++++++-
 vl.c                 | 12 ------------
 3 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index c93a331d35..6c89599355 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -478,7 +478,4 @@ static inline int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)
 /* input.c */
 int index_from_key(const char *key, size_t key_length);
 
-/* egl-headless.c */
-void egl_headless_init(DisplayOptions *opts);
-
 #endif
diff --git a/ui/egl-headless.c b/ui/egl-headless.c
index 38b3766548..655ef4eecb 100644
--- a/ui/egl-headless.c
+++ b/ui/egl-headless.c
@@ -154,7 +154,12 @@ static const DisplayChangeListenerOps egl_ops = {
     .dpy_gl_update           = egl_scanout_flush,
 };
 
-void egl_headless_init(DisplayOptions *opts)
+static void early_egl_headless_init(DisplayOptions *opts)
+{
+    display_opengl = 1;
+}
+
+static void egl_headless_init(DisplayState *ds, DisplayOptions *opts)
 {
     QemuConsole *con;
     egl_dpy *edpy;
@@ -178,3 +183,16 @@ void egl_headless_init(DisplayOptions *opts)
         register_displaychangelistener(&edpy->dcl);
     }
 }
+
+static QemuDisplay qemu_display_egl = {
+    .type       = DISPLAY_TYPE_EGL_HEADLESS,
+    .early_init = early_egl_headless_init,
+    .init       = egl_headless_init,
+};
+
+static void register_egl(void)
+{
+    qemu_display_register(&qemu_display_egl);
+}
+
+type_init(register_egl);
diff --git a/vl.c b/vl.c
index 07f049044b..df0c10398d 100644
--- a/vl.c
+++ b/vl.c
@@ -2189,13 +2189,7 @@ static void parse_display(const char *p)
             exit(1);
         }
     } else if (strstart(p, "egl-headless", &opts)) {
-#ifdef CONFIG_OPENGL_DMABUF
-        display_opengl = 1;
         dpy.type = DISPLAY_TYPE_EGL_HEADLESS;
-#else
-        fprintf(stderr, "egl support is disabled\n");
-        exit(1);
-#endif
     } else if (strstart(p, "curses", &opts)) {
         dpy.type = DISPLAY_TYPE_CURSES;
     } else if (strstart(p, "gtk", &opts)) {
@@ -4778,12 +4772,6 @@ int main(int argc, char **argv, char **envp)
         qemu_spice_display_init();
     }
 
-#ifdef CONFIG_OPENGL_DMABUF
-    if (dpy.type == DISPLAY_TYPE_EGL_HEADLESS) {
-        egl_headless_init(&dpy);
-    }
-#endif
-
     if (foreach_device_config(DEV_GDB, gdbserver_start) < 0) {
         exit(1);
     }
-- 
2.9.3
