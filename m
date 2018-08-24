Received: from eggs.gnu.org ([2001:4830:134:3::10]:54971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ft6aj-0006qH-Rw
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 03:33:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ft6ah-0000eo-FS
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 03:33:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48988 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ft6af-0000YS-Fy
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 03:33:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8EFFF4023475
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 07:33:02 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 24 Aug 2018 09:32:54 +0200
Message-Id: <20180824073256.19626-2-kraxel@redhat.com>
In-Reply-To: <20180824073256.19626-1-kraxel@redhat.com>
References: <20180824073256.19626-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/3] ui: remove support for GTK2 in favour of
 GTK3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

GTK2 was deprecated in the 2.12.0 release with:

  commit b7715af2b31f47060cc5b4be930d16c13be93fa9
  Author: Daniel P. Berrange <berrange@redhat.com>
  Date:   Tue Dec 12 11:34:40 2017 +0000

    ui: deprecate use of GTK 2.x in favour of 3.x series

    The GTK 3.0 release was made in Feb, 2011:

      https://blog.gtk.org/2011/02/10/gtk-3-0-released/

    That will soon be 7 years ago, which is enough time to consider
    the 3.x series widely supported.

    Thus we deprecate the GTK 2.x support, which will allow us to
    delete it in the last release of 2018. By this time, GTK 3.x
    will be almost 8 years old.

    Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
    Message-id: 20171212113440.16483-1-berrange@redhat.com
    Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

It is thus able to be removed in the 3.1.0 release.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-id: 20180822131554.3398-2-berrange@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure            |  51 +++-----------
 include/ui/gtk.h     |   9 ---
 ui/gtk-egl.c         |  10 ++-
 ui/gtk.c             | 192 ++++-----------------------------------------=
------
 qemu-deprecated.texi |   7 --
 5 files changed, 26 insertions(+), 243 deletions(-)

diff --git a/configure b/configure
index e7bddc04b0..f982d8bd61 100755
--- a/configure
+++ b/configure
@@ -453,7 +453,6 @@ glusterfs_discard=3D"no"
 glusterfs_fallocate=3D"no"
 glusterfs_zerofill=3D"no"
 gtk=3D""
-gtkabi=3D""
 gtk_gl=3D"no"
 tls_priority=3D"NORMAL"
 gnutls=3D""
@@ -1369,8 +1368,6 @@ for opt do
   ;;
   --disable-pvrdma) pvrdma=3D"no"
   ;;
-  --with-gtkabi=3D*) gtkabi=3D"$optarg"
-  ;;
   --disable-vte) vte=3D"no"
   ;;
   --enable-vte) vte=3D"yes"
@@ -1658,7 +1655,6 @@ disabled with --disable-FEATURE, default is enabled=
 if available:
   sdl             SDL UI
   --with-sdlabi     select preferred SDL ABI 1.2 or 2.0
   gtk             gtk UI
-  --with-gtkabi     select preferred GTK ABI 2.0 or 3.0
   vte             vte support for the gtk UI
   curses          curses UI
   vnc             VNC UI support
@@ -2648,24 +2644,9 @@ fi
 # GTK probe
=20
 if test "$gtk" !=3D "no"; then
-    if test "$gtkabi" =3D ""; then
-        # The GTK ABI was not specified explicitly, so try whether 3.0 i=
s available.
-        # Use 2.0 as a fallback if that is available.
-        if $pkg_config --exists "gtk+-3.0 >=3D 3.0.0"; then
-            gtkabi=3D3.0
-        elif $pkg_config --exists "gtk+-2.0 >=3D 2.18.0"; then
-            gtkabi=3D2.0
-        else
-            gtkabi=3D3.0
-        fi
-    fi
-    gtkpackage=3D"gtk+-$gtkabi"
-    gtkx11package=3D"gtk+-x11-$gtkabi"
-    if test "$gtkabi" =3D "3.0" ; then
-      gtkversion=3D"3.0.0"
-    else
-      gtkversion=3D"2.18.0"
-    fi
+    gtkpackage=3D"gtk+-3.0"
+    gtkx11package=3D"gtk+-x11-3.0"
+    gtkversion=3D"3.0.0"
     if $pkg_config --exists "$gtkpackage >=3D $gtkversion"; then
         gtk_cflags=3D$($pkg_config --cflags $gtkpackage)
         gtk_libs=3D$($pkg_config --libs $gtkpackage)
@@ -2909,16 +2890,11 @@ fi
 # VTE probe
=20
 if test "$vte" !=3D "no"; then
-    if test "$gtkabi" =3D "3.0"; then
-      vteminversion=3D"0.32.0"
-      if $pkg_config --exists "vte-2.91"; then
-        vtepackage=3D"vte-2.91"
-      else
-        vtepackage=3D"vte-2.90"
-      fi
+    vteminversion=3D"0.32.0"
+    if $pkg_config --exists "vte-2.91"; then
+      vtepackage=3D"vte-2.91"
     else
-      vtepackage=3D"vte"
-      vteminversion=3D"0.24.0"
+      vtepackage=3D"vte-2.90"
     fi
     if $pkg_config --exists "$vtepackage >=3D $vteminversion"; then
         vte_cflags=3D$($pkg_config --cflags $vtepackage)
@@ -2926,11 +2902,7 @@ if test "$vte" !=3D "no"; then
         vteversion=3D$($pkg_config --modversion $vtepackage)
         vte=3D"yes"
     elif test "$vte" =3D "yes"; then
-        if test "$gtkabi" =3D "3.0"; then
-            feature_not_found "vte" "Install libvte-2.90/2.91 devel"
-        else
-            feature_not_found "vte" "Install libvte devel"
-        fi
+        feature_not_found "vte" "Install libvte-2.90/2.91 devel"
     else
         vte=3D"no"
     fi
@@ -6089,12 +6061,6 @@ if test "$sdl_too_old" =3D "yes"; then
 echo "-> Your SDL version is too old - please upgrade to have SDL suppor=
t"
 fi
=20
-if test "$gtkabi" =3D "2.0"; then
-    echo
-    echo "WARNING: Use of GTK 2.0 is deprecated and will be removed in"
-    echo "WARNING: future releases. Please switch to using GTK 3.0"
-fi
-
 if test "$sdlabi" =3D "1.2"; then
     echo
     echo "WARNING: Use of SDL 1.2 is deprecated and will be removed in"
@@ -6414,7 +6380,6 @@ if test "$glib_subprocess" =3D "yes" ; then
 fi
 if test "$gtk" =3D "yes" ; then
   echo "CONFIG_GTK=3Dm" >> $config_host_mak
-  echo "CONFIG_GTKABI=3D$gtkabi" >> $config_host_mak
   echo "GTK_CFLAGS=3D$gtk_cflags" >> $config_host_mak
   echo "GTK_LIBS=3D$gtk_libs" >> $config_host_mak
   if test "$gtk_gl" =3D "yes" ; then
diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index a79780afc7..99edd3c085 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -27,15 +27,6 @@
 #include "ui/egl-context.h"
 #endif
=20
-/* Compatibility define to let us build on both Gtk2 and Gtk3 */
-#if GTK_CHECK_VERSION(3, 0, 0)
-static inline void gdk_drawable_get_size(GdkWindow *w, gint *ww, gint *w=
h)
-{
-    *ww =3D gdk_window_get_width(w);
-    *wh =3D gdk_window_get_height(w);
-}
-#endif
-
 typedef struct GtkDisplayState GtkDisplayState;
=20
 typedef struct VirtualGfxConsole {
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index fb00ad12ec..a77c25b490 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -48,11 +48,7 @@ void gd_egl_init(VirtualConsole *vc)
         return;
     }
=20
-#if GTK_CHECK_VERSION(3, 0, 0)
     Window x11_window =3D gdk_x11_window_get_xid(gdk_window);
-#else
-    Window x11_window =3D gdk_x11_drawable_get_xid(gdk_window);
-#endif
     if (!x11_window) {
         return;
     }
@@ -82,7 +78,8 @@ void gd_egl_draw(VirtualConsole *vc)
                        vc->gfx.esurface, vc->gfx.ectx);
=20
         window =3D gtk_widget_get_window(vc->gfx.drawing_area);
-        gdk_drawable_get_size(window, &ww, &wh);
+        ww =3D gdk_window_get_width(window);
+        wh =3D gdk_window_get_height(window);
         surface_gl_setup_viewport(vc->gfx.gls, vc->gfx.ds, ww, wh);
         surface_gl_render_texture(vc->gfx.gls, vc->gfx.ds);
=20
@@ -265,7 +262,8 @@ void gd_egl_scanout_flush(DisplayChangeListener *dcl,
                    vc->gfx.esurface, vc->gfx.ectx);
=20
     window =3D gtk_widget_get_window(vc->gfx.drawing_area);
-    gdk_drawable_get_size(window, &ww, &wh);
+    ww =3D gdk_window_get_width(window);
+    wh =3D gdk_window_get_height(window);
     egl_fb_setup_default(&vc->gfx.win_fb, ww, wh);
     if (vc->gfx.cursor_fb.texture) {
         egl_texture_blit(vc->gfx.gls, &vc->gfx.win_fb, &vc->gfx.guest_fb=
,
diff --git a/ui/gtk.c b/ui/gtk.c
index 5cce6ed42d..9d09bc9e57 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -111,49 +111,6 @@
 # define VTE_CHECK_VERSION(a, b, c) 0
 #endif
=20
-#if defined(CONFIG_VTE) && !GTK_CHECK_VERSION(3, 0, 0)
-/*
- * The gtk2 vte terminal widget seriously messes up the window resize
- * for some reason.  You basically can't make the qemu window smaller
- * any more because the toplevel window geoemtry hints are overridden.
- *
- * Workaround that by hiding all vte widgets, except the one in the
- * current tab.
- *
- * Luckily everything works smooth in gtk3.
- */
-# define VTE_RESIZE_HACK 1
-#endif
-
-#if !GTK_CHECK_VERSION(2, 20, 0)
-#define gtk_widget_get_realized(widget) GTK_WIDGET_REALIZED(widget)
-#endif
-
-#ifndef GDK_IS_X11_DISPLAY
-#define GDK_IS_X11_DISPLAY(dpy) (dpy =3D=3D dpy)
-#endif
-#ifndef GDK_IS_WAYLAND_DISPLAY
-#define GDK_IS_WAYLAND_DISPLAY(dpy) (dpy =3D=3D dpy)
-#endif
-#ifndef GDK_IS_WIN32_DISPLAY
-#define GDK_IS_WIN32_DISPLAY(dpy) (dpy =3D=3D dpy)
-#endif
-
-#if !GTK_CHECK_VERSION(2, 22, 0)
-#define GDK_KEY_0 GDK_0
-#define GDK_KEY_1 GDK_1
-#define GDK_KEY_2 GDK_2
-#define GDK_KEY_f GDK_f
-#define GDK_KEY_g GDK_g
-#define GDK_KEY_m GDK_m
-#define GDK_KEY_q GDK_q
-#define GDK_KEY_plus GDK_plus
-#define GDK_KEY_equal GDK_equal
-#define GDK_KEY_minus GDK_minus
-#define GDK_KEY_Pause GDK_Pause
-#define GDK_KEY_Delete GDK_Delete
-#endif
-
 /* Some older mingw versions lack this constant or have
  * it conditionally defined */
 #ifdef _WIN32
@@ -455,7 +412,8 @@ static void gd_update_full_redraw(VirtualConsole *vc)
 {
     GtkWidget *area =3D vc->gfx.drawing_area;
     int ww, wh;
-    gdk_drawable_get_size(gtk_widget_get_window(area), &ww, &wh);
+    ww =3D gdk_window_get_width(gtk_widget_get_window(area));
+    wh =3D gdk_window_get_height(gtk_widget_get_window(area));
 #if defined(CONFIG_GTK_GL)
     if (vc->gfx.gls && gtk_use_gl_area) {
         gtk_gl_area_queue_render(GTK_GL_AREA(vc->gfx.drawing_area));
@@ -530,7 +488,8 @@ static void gd_update(DisplayChangeListener *dcl,
     if (!win) {
         return;
     }
-    gdk_drawable_get_size(win, &ww, &wh);
+    ww =3D gdk_window_get_width(win);
+    wh =3D gdk_window_get_height(win);
=20
     mx =3D my =3D 0;
     if (ww > fbw) {
@@ -549,7 +508,6 @@ static void gd_refresh(DisplayChangeListener *dcl)
     graphic_hw_update(dcl->con);
 }
=20
-#if GTK_CHECK_VERSION(3, 0, 0)
 static GdkDevice *gd_get_pointer(GdkDisplay *dpy)
 {
 #if GTK_CHECK_VERSION(3, 20, 0)
@@ -580,24 +538,6 @@ static void gd_mouse_set(DisplayChangeListener *dcl,
     vc->s->last_x =3D x;
     vc->s->last_y =3D y;
 }
-#else
-static void gd_mouse_set(DisplayChangeListener *dcl,
-                         int x, int y, int visible)
-{
-    VirtualConsole *vc =3D container_of(dcl, VirtualConsole, gfx.dcl);
-    gint x_root, y_root;
-
-    if (qemu_input_is_absolute()) {
-        return;
-    }
-
-    gdk_window_get_root_coords(gtk_widget_get_window(vc->gfx.drawing_are=
a),
-                               x, y, &x_root, &y_root);
-    gdk_display_warp_pointer(gtk_widget_get_display(vc->gfx.drawing_area=
),
-                             gtk_widget_get_screen(vc->gfx.drawing_area)=
,
-                             x_root, y_root);
-}
-#endif
=20
 static void gd_cursor_define(DisplayChangeListener *dcl,
                              QEMUCursor *c)
@@ -619,11 +559,7 @@ static void gd_cursor_define(DisplayChangeListener *=
dcl,
          pixbuf, c->hot_x, c->hot_y);
     gdk_window_set_cursor(gtk_widget_get_window(vc->gfx.drawing_area), c=
ursor);
     g_object_unref(pixbuf);
-#if !GTK_CHECK_VERSION(3, 0, 0)
-    gdk_cursor_unref(cursor);
-#else
     g_object_unref(cursor);
-#endif
 }
=20
 static void gd_switch(DisplayChangeListener *dcl,
@@ -863,7 +799,8 @@ static gboolean gd_draw_event(GtkWidget *widget, cair=
o_t *cr, void *opaque)
     fbw =3D surface_width(vc->gfx.ds);
     fbh =3D surface_height(vc->gfx.ds);
=20
-    gdk_drawable_get_size(gtk_widget_get_window(widget), &ww, &wh);
+    ww =3D gdk_window_get_width(gtk_widget_get_window(widget));
+    wh =3D gdk_window_get_height(gtk_widget_get_window(widget));
=20
     if (s->full_screen) {
         vc->gfx.scale_x =3D (double)ww / fbw;
@@ -907,29 +844,6 @@ static gboolean gd_draw_event(GtkWidget *widget, cai=
ro_t *cr, void *opaque)
     return TRUE;
 }
=20
-#if !GTK_CHECK_VERSION(3, 0, 0)
-static gboolean gd_expose_event(GtkWidget *widget, GdkEventExpose *expos=
e,
-                                void *opaque)
-{
-    cairo_t *cr;
-    gboolean ret;
-
-    cr =3D gdk_cairo_create(gtk_widget_get_window(widget));
-    cairo_rectangle(cr,
-                    expose->area.x,
-                    expose->area.y,
-                    expose->area.width,
-                    expose->area.height);
-    cairo_clip(cr);
-
-    ret =3D gd_draw_event(widget, cr, opaque);
-
-    cairo_destroy(cr);
-
-    return ret;
-}
-#endif
-
 static gboolean gd_motion_event(GtkWidget *widget, GdkEventMotion *motio=
n,
                                 void *opaque)
 {
@@ -947,8 +861,8 @@ static gboolean gd_motion_event(GtkWidget *widget, Gd=
kEventMotion *motion,
     fbw =3D surface_width(vc->gfx.ds) * vc->gfx.scale_x;
     fbh =3D surface_height(vc->gfx.ds) * vc->gfx.scale_y;
=20
-    gdk_drawable_get_size(gtk_widget_get_window(vc->gfx.drawing_area),
-                          &ww, &wh);
+    ww =3D gdk_window_get_width(gtk_widget_get_window(vc->gfx.drawing_ar=
ea));
+    wh =3D gdk_window_get_height(gtk_widget_get_window(vc->gfx.drawing_a=
rea));
=20
     mx =3D my =3D 0;
     if (ww > fbw) {
@@ -1026,13 +940,8 @@ static gboolean gd_motion_event(GtkWidget *widget, =
GdkEventMotion *motion,
         }
=20
         if (x !=3D (int)motion->x_root || y !=3D (int)motion->y_root) {
-#if GTK_CHECK_VERSION(3, 0, 0)
             GdkDevice *dev =3D gdk_event_get_device((GdkEvent *)motion);
             gdk_device_warp(dev, screen, x, y);
-#else
-            GdkDisplay *display =3D gtk_widget_get_display(widget);
-            gdk_display_warp_pointer(display, screen, x, y);
-#endif
             s->last_set =3D FALSE;
             return FALSE;
         }
@@ -1309,10 +1218,6 @@ static void gd_accel_switch_vc(void *opaque)
     VirtualConsole *vc =3D opaque;
=20
     gtk_check_menu_item_set_active(GTK_CHECK_MENU_ITEM(vc->menu_item), T=
RUE);
-#if !GTK_CHECK_VERSION(3, 0, 0)
-    /* GTK2 sends the accel key to the target console - ignore this unti=
l */
-    vc->s->ignore_keys =3D true;
-#endif
 }
=20
 static void gd_menu_show_tabs(GtkMenuItem *item, void *opaque)
@@ -1539,7 +1444,7 @@ static void gd_grab_update(VirtualConsole *vc, bool=
 kbd, bool ptr)
         gdk_seat_ungrab(seat);
     }
 }
-#elif GTK_CHECK_VERSION(3, 0, 0)
+#else
 static void gd_grab_devices(VirtualConsole *vc, bool grab,
                             GdkInputSource source, GdkEventMask mask,
                             GdkCursor *cursor)
@@ -1578,14 +1483,10 @@ static void gd_grab_keyboard(VirtualConsole *vc, =
const char *reason)
=20
 #if GTK_CHECK_VERSION(3, 20, 0)
     gd_grab_update(vc, true, vc->s->ptr_owner =3D=3D vc);
-#elif GTK_CHECK_VERSION(3, 0, 0)
+#else
     gd_grab_devices(vc, true, GDK_SOURCE_KEYBOARD,
                    GDK_KEY_PRESS_MASK | GDK_KEY_RELEASE_MASK,
                    NULL);
-#else
-    gdk_keyboard_grab(gtk_widget_get_window(vc->gfx.drawing_area),
-                      FALSE,
-                      GDK_CURRENT_TIME);
 #endif
     vc->s->kbd_owner =3D vc;
     gd_update_caption(vc->s);
@@ -1603,10 +1504,8 @@ static void gd_ungrab_keyboard(GtkDisplayState *s)
=20
 #if GTK_CHECK_VERSION(3, 20, 0)
     gd_grab_update(vc, false, vc->s->ptr_owner =3D=3D vc);
-#elif GTK_CHECK_VERSION(3, 0, 0)
+#else
     gd_grab_devices(vc, false, GDK_SOURCE_KEYBOARD, 0, NULL);
-#else
-    gdk_keyboard_ungrab(GDK_CURRENT_TIME);
 #endif
     gd_update_caption(s);
     trace_gd_ungrab(vc->label, "kbd");
@@ -1628,7 +1527,7 @@ static void gd_grab_pointer(VirtualConsole *vc, con=
st char *reason)
     gd_grab_update(vc, vc->s->kbd_owner =3D=3D vc, true);
     gdk_device_get_position(gd_get_pointer(display),
                             NULL, &vc->s->grab_x_root, &vc->s->grab_y_ro=
ot);
-#elif GTK_CHECK_VERSION(3, 0, 0)
+#else
     gd_grab_devices(vc, true, GDK_SOURCE_MOUSE,
                     GDK_POINTER_MOTION_MASK |
                     GDK_BUTTON_PRESS_MASK |
@@ -1638,19 +1537,6 @@ static void gd_grab_pointer(VirtualConsole *vc, co=
nst char *reason)
                     vc->s->null_cursor);
     gdk_device_get_position(gd_get_pointer(display),
                             NULL, &vc->s->grab_x_root, &vc->s->grab_y_ro=
ot);
-#else
-    gdk_pointer_grab(gtk_widget_get_window(vc->gfx.drawing_area),
-                     FALSE, /* All events to come to our window directly=
 */
-                     GDK_POINTER_MOTION_MASK |
-                     GDK_BUTTON_PRESS_MASK |
-                     GDK_BUTTON_RELEASE_MASK |
-                     GDK_BUTTON_MOTION_MASK |
-                     GDK_SCROLL_MASK,
-                     NULL, /* Allow cursor to move over entire desktop *=
/
-                     vc->s->null_cursor,
-                     GDK_CURRENT_TIME);
-    gdk_display_get_pointer(display, NULL,
-                            &vc->s->grab_x_root, &vc->s->grab_y_root, NU=
LL);
 #endif
     vc->s->ptr_owner =3D vc;
     gd_update_caption(vc->s);
@@ -1673,16 +1559,11 @@ static void gd_ungrab_pointer(GtkDisplayState *s)
     gdk_device_warp(gd_get_pointer(display),
                     gtk_widget_get_screen(vc->gfx.drawing_area),
                     vc->s->grab_x_root, vc->s->grab_y_root);
-#elif GTK_CHECK_VERSION(3, 0, 0)
+#else
     gd_grab_devices(vc, false, GDK_SOURCE_MOUSE, 0, NULL);
     gdk_device_warp(gd_get_pointer(display),
                     gtk_widget_get_screen(vc->gfx.drawing_area),
                     vc->s->grab_x_root, vc->s->grab_y_root);
-#else
-    gdk_pointer_ungrab(GDK_CURRENT_TIME);
-    gdk_display_warp_pointer(display,
-                             gtk_widget_get_screen(vc->gfx.drawing_area)=
,
-                             vc->s->grab_x_root, vc->s->grab_y_root);
 #endif
     gd_update_caption(s);
     trace_gd_ungrab(vc->label, "ptr");
@@ -1715,21 +1596,10 @@ static void gd_change_page(GtkNotebook *nb, gpoin=
ter arg1, guint arg2,
         return;
     }
=20
-#ifdef VTE_RESIZE_HACK
-    vc =3D gd_vc_find_current(s);
-    if (vc && vc->type =3D=3D GD_VC_VTE) {
-        gtk_widget_hide(vc->vte.terminal);
-    }
-#endif
     vc =3D gd_vc_find_by_page(s, arg2);
     if (!vc) {
         return;
     }
-#ifdef VTE_RESIZE_HACK
-    if (vc->type =3D=3D GD_VC_VTE) {
-        gtk_widget_show(vc->vte.terminal);
-    }
-#endif
     gtk_check_menu_item_set_active(GTK_CHECK_MENU_ITEM(vc->menu_item),
                                    TRUE);
     on_vga =3D (vc->type =3D=3D GD_VC_GFX &&
@@ -1963,20 +1833,15 @@ static GSList *gd_vc_vte_init(GtkDisplayState *s,=
 VirtualConsole *vc,
     vte_terminal_set_size(VTE_TERMINAL(vc->vte.terminal),
                           VC_TERM_X_MIN, VC_TERM_Y_MIN);
=20
-#if VTE_CHECK_VERSION(0, 28, 0) && GTK_CHECK_VERSION(3, 0, 0)
+#if VTE_CHECK_VERSION(0, 28, 0)
     vadjustment =3D gtk_scrollable_get_vadjustment
         (GTK_SCROLLABLE(vc->vte.terminal));
 #else
     vadjustment =3D vte_terminal_get_adjustment(VTE_TERMINAL(vc->vte.ter=
minal));
 #endif
=20
-#if GTK_CHECK_VERSION(3, 0, 0)
     box =3D gtk_box_new(GTK_ORIENTATION_HORIZONTAL, 2);
     scrollbar =3D gtk_scrollbar_new(GTK_ORIENTATION_VERTICAL, vadjustmen=
t);
-#else
-    box =3D gtk_hbox_new(false, 2);
-    scrollbar =3D gtk_vscrollbar_new(vadjustment);
-#endif
=20
     gtk_box_pack_end(GTK_BOX(box), scrollbar, FALSE, FALSE, 0);
     gtk_box_pack_end(GTK_BOX(box), vc->vte.terminal, TRUE, TRUE, 0);
@@ -2015,7 +1880,6 @@ static void gd_vcs_init(GtkDisplayState *s, GSList =
*group,
=20
 static void gd_connect_vc_gfx_signals(VirtualConsole *vc)
 {
-#if GTK_CHECK_VERSION(3, 0, 0)
     g_signal_connect(vc->gfx.drawing_area, "draw",
                      G_CALLBACK(gd_draw_event), vc);
 #if defined(CONFIG_GTK_GL)
@@ -2027,10 +1891,6 @@ static void gd_connect_vc_gfx_signals(VirtualConso=
le *vc)
                          G_CALLBACK(gd_resize_event), vc);
     }
 #endif
-#else
-    g_signal_connect(vc->gfx.drawing_area, "expose-event",
-                     G_CALLBACK(gd_expose_event), vc);
-#endif
     if (qemu_console_is_graphic(vc->gfx.dcl.con)) {
         g_signal_connect(vc->gfx.drawing_area, "event",
                          G_CALLBACK(gd_event), vc);
@@ -2226,11 +2086,9 @@ static GtkWidget *gd_create_menu_view(GtkDisplaySt=
ate *s)
=20
     gtk_accel_group_connect(s->accel_group, GDK_KEY_f, HOTKEY_MODIFIERS,=
 0,
             g_cclosure_new_swap(G_CALLBACK(gd_accel_full_screen), s, NUL=
L));
-#if GTK_CHECK_VERSION(3, 8, 0)
     gtk_accel_label_set_accel(
             GTK_ACCEL_LABEL(gtk_bin_get_child(GTK_BIN(s->full_screen_ite=
m))),
             GDK_KEY_f, HOTKEY_MODIFIERS);
-#endif
     gtk_menu_shell_append(GTK_MENU_SHELL(view_menu), s->full_screen_item=
);
=20
     separator =3D gtk_separator_menu_item_new();
@@ -2362,11 +2220,6 @@ static void gtk_display_init(DisplayState *ds, Dis=
playOptions *opts)
     assert(opts->type =3D=3D DISPLAY_TYPE_GTK);
     s->opts =3D opts;
=20
-#if !GTK_CHECK_VERSION(3, 0, 0)
-    g_printerr("Running QEMU with GTK 2.x is deprecated, and will be rem=
oved\n"
-               "in a future release. Please switch to GTK 3.x instead\n"=
);
-#endif
-
     s->window =3D gtk_window_new(GTK_WINDOW_TOPLEVEL);
 #if GTK_CHECK_VERSION(3, 2, 0)
     s->vbox =3D gtk_box_new(GTK_ORIENTATION_VERTICAL, 0);
@@ -2423,23 +2276,6 @@ static void gtk_display_init(DisplayState *ds, Dis=
playOptions *opts)
=20
     gtk_widget_show_all(s->window);
=20
-#ifdef VTE_RESIZE_HACK
-    {
-        VirtualConsole *cur =3D gd_vc_find_current(s);
-        if (cur) {
-            int i;
-
-            for (i =3D 0; i < s->nb_vcs; i++) {
-                VirtualConsole *vc =3D &s->vc[i];
-                if (vc && vc->type =3D=3D GD_VC_VTE && vc !=3D cur) {
-                    gtk_widget_hide(vc->vte.terminal);
-                }
-            }
-            gd_update_windowsize(cur);
-        }
-    }
-#endif
-
     vc =3D gd_vc_find_current(s);
     gtk_widget_set_sensitive(s->view_menu, vc !=3D NULL);
 #ifdef CONFIG_VTE
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 87212b62f2..a6a7228a06 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -19,13 +19,6 @@ deprecated.
=20
 @section Build options
=20
-@subsection GTK 2.x
-
-Previously QEMU has supported building against both GTK 2.x
-and 3.x series APIs. Support for the GTK 2.x builds will be
-discontinued, so maintainers should switch to using GTK 3.x,
-which is the default.
-
 @subsection SDL 1.2
=20
 Previously QEMU has supported building against both SDL 1.2
--=20
2.9.3
