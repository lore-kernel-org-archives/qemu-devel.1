Received: from eggs.gnu.org ([2001:4830:134:3::10]:47099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ciLHL-0002pk-Vs
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:23:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ciLHI-0003hf-1y
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:23:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40620)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ciLHH-0003hT-SI
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:23:47 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E756D81127
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 13:23:47 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 27 Feb 2017 13:23:43 +0000
Message-Id: <20170227132343.30824-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH] ui: Use XkbGetMap and XkbGetNames instead of
 XkbGetKeyboard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

XkbGetKeyboard does not work in XWayland and even on non-Wayland
X11 servers its use is discouraged:

  https://bugs.freedesktop.org/show_bug.cgi?id=89240

This resolves a problem whereby QEMU prints

  "could not lookup keycode name"

on startup when running under XWayland. Keymap handling is
however still broken after this commit, since Xwayland is
reporting a keymap we can't handle

  "unknown keycodes `(unnamed)', please report to qemu-devel@nongnu.org"

NB, native Wayland support (which is the default under GTK3) is
not affected - only XWayland (which can be requested with GDK_BACKEND
on GTK3, and is the only option for GTK2).

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 ui/gtk.c |  7 ++++---
 ui/sdl.c | 10 ++++++----
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index f21e9e7..6eb56e9 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2200,11 +2200,12 @@ static void gd_set_keycode_type(GtkDisplayState *s)
     GdkDisplay *display = gtk_widget_get_display(s->window);
     if (GDK_IS_X11_DISPLAY(display)) {
         Display *x11_display = gdk_x11_display_get_xdisplay(display);
-        XkbDescPtr desc = XkbGetKeyboard(x11_display, XkbGBN_AllComponentsMask,
-                                         XkbUseCoreKbd);
+        XkbDescPtr desc = XkbGetMap(x11_display, XkbGBN_AllComponentsMask,
+                                    XkbUseCoreKbd);
         char *keycodes = NULL;
 
-        if (desc && desc->names) {
+        if (desc &&
+            (XkbGetNames(x11_display, XkbKeycodesNameMask, desc) == Success)) {
             keycodes = XGetAtomName(x11_display, desc->names->keycodes);
         }
         if (keycodes == NULL) {
diff --git a/ui/sdl.c b/ui/sdl.c
index 19e8a84..37c21a0 100644
--- a/ui/sdl.c
+++ b/ui/sdl.c
@@ -233,10 +233,12 @@ static int check_for_evdev(void)
     if (!SDL_GetWMInfo(&info)) {
         return 0;
     }
-    desc = XkbGetKeyboard(info.info.x11.display,
-                          XkbGBN_AllComponentsMask,
-                          XkbUseCoreKbd);
-    if (desc && desc->names) {
+    desc = XkbGetMap(info.info.x11.display,
+                     XkbGBN_AllComponentsMask,
+                     XkbUseCoreKbd);
+    if (desc &&
+        (XkbGetNames(info.info.x11.display,
+                     XkbKeycodesNameMask, desc) == Success)) {
         keycodes = XGetAtomName(info.info.x11.display, desc->names->keycodes);
         if (keycodes == NULL) {
             fprintf(stderr, "could not lookup keycode name\n");
-- 
2.9.3
