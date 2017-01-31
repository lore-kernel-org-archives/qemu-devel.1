Received: from eggs.gnu.org ([2001:4830:134:3::10]:38017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYahe-00054d-Od
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:50:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYahd-0001Uf-0B
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:50:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cYahc-0001U3-RP
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:50:40 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 31 Jan 2017 16:50:27 +0100
Message-Id: <1485877831-28786-8-git-send-email-kraxel@redhat.com>
In-Reply-To: <1485877831-28786-1-git-send-email-kraxel@redhat.com>
References: <1485877831-28786-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL v2 07/11] ui/gtk.c: add ctrl-alt-= support for
 zoom in acceleration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ziyue Yang <yzylivezh@hotmail.com>, Ziyue Yang <skiver.cloud.yzy@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Ziyue Yang <yzylivezh@hotmail.com>

Solving wishlist item at
https://bugs.launchpad.net/qemu/+bug/1656710
by accepting Ctrl-Alt-= as an additional zoom-in acceleration.

Using gtk_accel_group_connect to support multiple accelerations
triggering a single menu item since that gtk_accel_map_add_entry
seems to support only one acceleration. A wrapper function
gd_accel_zoom_in is added to support gtk_accel_group_connect's
callback activities.

Signed-off-by: Ziyue Yang <skiver.cloud.yzy@gmail.com>
Message-id: 1485826335-15686-1-git-send-email-skiver.cloud.yzy@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/gtk.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/ui/gtk.c b/ui/gtk.c
index 2f81863..b734c0b 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -105,6 +105,7 @@
 #define GDK_KEY_g GDK_g
 #define GDK_KEY_q GDK_q
 #define GDK_KEY_plus GDK_plus
+#define GDK_KEY_equal GDK_equal
 #define GDK_KEY_minus GDK_minus
 #define GDK_KEY_Pause GDK_Pause
 #define GDK_KEY_Delete GDK_Delete
@@ -1342,6 +1343,12 @@ static void gd_menu_zoom_in(GtkMenuItem *item, void *opaque)
     gd_update_windowsize(vc);
 }
 
+static void gd_accel_zoom_in(void *opaque)
+{
+    GtkDisplayState *s = opaque;
+    gtk_menu_item_activate(GTK_MENU_ITEM(s->zoom_in_item));
+}
+
 static void gd_menu_zoom_out(GtkMenuItem *item, void *opaque)
 {
     GtkDisplayState *s = opaque;
@@ -2109,6 +2116,8 @@ static GtkWidget *gd_create_menu_view(GtkDisplayState *s)
                                  "<QEMU>/View/Zoom In");
     gtk_accel_map_add_entry("<QEMU>/View/Zoom In", GDK_KEY_plus,
                             HOTKEY_MODIFIERS);
+    gtk_accel_group_connect(s->accel_group, GDK_KEY_equal, HOTKEY_MODIFIERS, 0,
+            g_cclosure_new_swap(G_CALLBACK(gd_accel_zoom_in), s, NULL));
     gtk_menu_shell_append(GTK_MENU_SHELL(view_menu), s->zoom_in_item);
 
     s->zoom_out_item = gtk_menu_item_new_with_mnemonic(_("Zoom _Out"));
-- 
1.8.3.1
