Received: from eggs.gnu.org ([2001:4830:134:3::10]:51305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter@lekensteyn.nl>) id 1fGuf5-0002es-Dw
	for qemu-devel@nongnu.org; Thu, 10 May 2018 19:07:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter@lekensteyn.nl>) id 1fGuf3-0005HY-W7
	for qemu-devel@nongnu.org; Thu, 10 May 2018 19:07:47 -0400
Received: from mail.lekensteyn.nl ([2a02:2308::360:1:25]:51169)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter@lekensteyn.nl>) id 1fGuf3-0005GL-MK
	for qemu-devel@nongnu.org; Thu, 10 May 2018 19:07:45 -0400
From: Peter Wu <peter@lekensteyn.nl>
Date: Fri, 11 May 2018 01:07:38 +0200
Message-Id: <20180510230739.28459-1-peter@lekensteyn.nl>
Subject: [Qemu-devel] [PATCH 1/2] gtk: make it possible to hide the menu bar
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Saves some space and disables the F10 button as side-effect.

Fixes: https://bugs.launchpad.net/qemu/+bug/1726910
Signed-off-by: Peter Wu <peter@lekensteyn.nl>
---
 ui/gtk.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index bb3214cffb..9e5390f2c2 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -145,6 +145,7 @@
 #define GDK_KEY_2 GDK_2
 #define GDK_KEY_f GDK_f
 #define GDK_KEY_g GDK_g
+#define GDK_KEY_m GDK_m
 #define GDK_KEY_q GDK_q
 #define GDK_KEY_plus GDK_plus
 #define GDK_KEY_equal GDK_equal
@@ -208,6 +209,7 @@ struct GtkDisplayState {
 
     GtkWidget *show_tabs_item;
     GtkWidget *untabify_item;
+    GtkWidget *show_menubar_item;
 
     GtkWidget *vbox;
     GtkWidget *notebook;
@@ -1387,6 +1389,30 @@ static void gd_menu_untabify(GtkMenuItem *item, void *opaque)
     }
 }
 
+static void gd_menu_show_menubar(GtkMenuItem *item, void *opaque)
+{
+    GtkDisplayState *s = opaque;
+    VirtualConsole *vc = gd_vc_find_current(s);
+
+    if (s->full_screen) {
+        return;
+    }
+
+    if (gtk_check_menu_item_get_active(
+                GTK_CHECK_MENU_ITEM(s->show_menubar_item))) {
+        gtk_widget_show(s->menu_bar);
+    } else {
+        gtk_widget_hide(s->menu_bar);
+    }
+    gd_update_windowsize(vc);
+}
+
+static void gd_accel_show_menubar(void *opaque)
+{
+    GtkDisplayState *s = opaque;
+    gtk_menu_item_activate(GTK_MENU_ITEM(s->show_menubar_item));
+}
+
 static void gd_menu_full_screen(GtkMenuItem *item, void *opaque)
 {
     GtkDisplayState *s = opaque;
@@ -1403,7 +1429,10 @@ static void gd_menu_full_screen(GtkMenuItem *item, void *opaque)
     } else {
         gtk_window_unfullscreen(GTK_WINDOW(s->window));
         gd_menu_show_tabs(GTK_MENU_ITEM(s->show_tabs_item), s);
-        gtk_widget_show(s->menu_bar);
+        if (gtk_check_menu_item_get_active(
+                    GTK_CHECK_MENU_ITEM(s->show_menubar_item))) {
+            gtk_widget_show(s->menu_bar);
+        }
         s->full_screen = FALSE;
         if (vc->type == GD_VC_GFX) {
             vc->gfx.scale_x = 1.0;
@@ -2036,6 +2065,8 @@ static void gd_connect_signals(GtkDisplayState *s)
                      G_CALLBACK(gd_menu_show_tabs), s);
     g_signal_connect(s->untabify_item, "activate",
                      G_CALLBACK(gd_menu_untabify), s);
+    g_signal_connect(s->show_menubar_item, "activate",
+                     G_CALLBACK(gd_menu_show_menubar), s);
 
     g_signal_connect(s->window, "delete-event",
                      G_CALLBACK(gd_window_close), s);
@@ -2272,6 +2303,19 @@ static GtkWidget *gd_create_menu_view(GtkDisplayState *s)
     s->untabify_item = gtk_menu_item_new_with_mnemonic(_("Detach Tab"));
     gtk_menu_shell_append(GTK_MENU_SHELL(view_menu), s->untabify_item);
 
+    s->show_menubar_item = gtk_check_menu_item_new_with_mnemonic(
+            _("Show Menubar"));
+    gtk_check_menu_item_set_active(GTK_CHECK_MENU_ITEM(s->show_menubar_item),
+                                   TRUE);
+    gtk_accel_group_connect(s->accel_group, GDK_KEY_m, HOTKEY_MODIFIERS, 0,
+            g_cclosure_new_swap(G_CALLBACK(gd_accel_show_menubar), s, NULL));
+#if GTK_CHECK_VERSION(3, 8, 0)
+    gtk_accel_label_set_accel(
+            GTK_ACCEL_LABEL(gtk_bin_get_child(GTK_BIN(s->show_menubar_item))),
+            GDK_KEY_m, HOTKEY_MODIFIERS);
+#endif
+    gtk_menu_shell_append(GTK_MENU_SHELL(view_menu), s->show_menubar_item);
+
     return view_menu;
 }
 
-- 
2.17.0
