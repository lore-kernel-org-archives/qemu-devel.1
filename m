Received: from eggs.gnu.org ([2001:4830:134:3::10]:46358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eqaIM-0001dx-T0
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 03:07:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eqaIL-0003F0-5U
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 03:07:30 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55976 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eqaIL-0003Eh-0I
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 03:07:29 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B08BF17CEF1
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 08:07:28 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 27 Feb 2018 09:07:17 +0100
Message-Id: <20180227080724.13585-6-kraxel@redhat.com>
In-Reply-To: <20180227080724.13585-1-kraxel@redhat.com>
References: <20180227080724.13585-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 05/12] egl-headless: switch over to new display
 registry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20180221131537.31341-6-kraxel@redhat.com
---
 include/ui/console.h |  3 ---
 ui/egl-headless.c    | 20 +++++++++++++++++++-
 vl.c                 | 12 ------------
 3 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 3ea6cf0870..94726cf190 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -456,7 +456,4 @@ int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp);
 /* input.c */
 int index_from_key(const char *key, size_t key_length);
 
-/* egl-headless.c */
-void egl_headless_init(DisplayOptions *opts);
-
 #endif
diff --git a/ui/egl-headless.c b/ui/egl-headless.c
index b33e0b21fd..7c877122d3 100644
--- a/ui/egl-headless.c
+++ b/ui/egl-headless.c
@@ -164,7 +164,12 @@ static const DisplayChangeListenerOps egl_ops = {
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
@@ -188,3 +193,16 @@ void egl_headless_init(DisplayOptions *opts)
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
index 2b4af34fbb..47c953f8dc 100644
--- a/vl.c
+++ b/vl.c
@@ -2153,13 +2153,7 @@ static void parse_display(const char *p)
             exit(1);
         }
     } else if (strstart(p, "egl-headless", &opts)) {
-#ifdef CONFIG_OPENGL_DMABUF
-        display_opengl = 1;
         dpy.type = DISPLAY_TYPE_EGL_HEADLESS;
-#else
-        error_report("egl support is disabled");
-        exit(1);
-#endif
     } else if (strstart(p, "curses", &opts)) {
         dpy.type = DISPLAY_TYPE_CURSES;
     } else if (strstart(p, "gtk", &opts)) {
@@ -4659,12 +4653,6 @@ int main(int argc, char **argv, char **envp)
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
