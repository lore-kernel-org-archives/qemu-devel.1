Received: from eggs.gnu.org ([2001:4830:134:3::10]:45190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fFcrx-0002AH-AJ
	for qemu-devel@nongnu.org; Mon, 07 May 2018 05:55:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fFcrw-0005Ee-5n
	for qemu-devel@nongnu.org; Mon, 07 May 2018 05:55:45 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  7 May 2018 11:55:38 +0200
Message-Id: <20180507095539.19584-4-kraxel@redhat.com>
In-Reply-To: <20180507095539.19584-1-kraxel@redhat.com>
References: <20180507095539.19584-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/4] ui: switch gtk display to qapi parser
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>

Drop the gtk option parser from parse_display(), so parse_display_qapi()
will handle it instead.

With this change the parser will accept gl=core and gl=es too, gtk
must catch the unsupported gles variant now.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/gtk.c |  6 +++++-
 vl.c     | 32 --------------------------------
 2 files changed, 5 insertions(+), 33 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index bb3214cffb..7859b506ea 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2434,7 +2434,11 @@ static void early_gtk_display_init(DisplayOptions *opts)
     }
 
     assert(opts->type == DISPLAY_TYPE_GTK);
-    if (opts->has_gl && opts->gl) {
+    if (opts->has_gl && opts->gl != DISPLAYGL_MODE_OFF) {
+        if (opts->gl == DISPLAYGL_MODE_ES) {
+            error_report("gtk: opengl es not supported");
+            return;
+        }
 #if defined(CONFIG_OPENGL)
 #if defined(CONFIG_GTK_GL) && defined(GDK_WINDOWING_WAYLAND)
         if (GDK_IS_WAYLAND_DISPLAY(gdk_display_get_default())) {
diff --git a/vl.c b/vl.c
index 1bd6758f3a..03ac9a2cbb 100644
--- a/vl.c
+++ b/vl.c
@@ -2185,38 +2185,6 @@ static void parse_display(const char *p)
             error_report("VNC requires a display argument vnc=<display>");
             exit(1);
         }
-    } else if (strstart(p, "gtk", &opts)) {
-        dpy.type = DISPLAY_TYPE_GTK;
-        while (*opts) {
-            const char *nextopt;
-
-            if (strstart(opts, ",grab_on_hover=", &nextopt)) {
-                opts = nextopt;
-                dpy.u.gtk.has_grab_on_hover = true;
-                if (strstart(opts, "on", &nextopt)) {
-                    dpy.u.gtk.grab_on_hover = true;
-                } else if (strstart(opts, "off", &nextopt)) {
-                    dpy.u.gtk.grab_on_hover = false;
-                } else {
-                    goto invalid_gtk_args;
-                }
-            } else if (strstart(opts, ",gl=", &nextopt)) {
-                opts = nextopt;
-                dpy.has_gl = true;
-                if (strstart(opts, "on", &nextopt)) {
-                    dpy.gl = DISPLAYGL_MODE_ON;
-                } else if (strstart(opts, "off", &nextopt)) {
-                    dpy.gl = DISPLAYGL_MODE_OFF;
-                } else {
-                    goto invalid_gtk_args;
-                }
-            } else {
-            invalid_gtk_args:
-                error_report("invalid GTK option string");
-                exit(1);
-            }
-            opts = nextopt;
-        }
     } else {
         parse_display_qapi(p);
     }
-- 
2.9.3
