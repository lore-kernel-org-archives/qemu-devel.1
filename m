Received: from eggs.gnu.org ([2001:4830:134:3::10]:48568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fIW6v-0004E1-83
	for qemu-devel@nongnu.org; Tue, 15 May 2018 05:19:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fIW6t-0001Vo-Go
	for qemu-devel@nongnu.org; Tue, 15 May 2018 05:19:09 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 15 May 2018 11:19:01 +0200
Message-Id: <20180515091901.27774-11-kraxel@redhat.com>
In-Reply-To: <20180515091901.27774-1-kraxel@redhat.com>
References: <20180515091901.27774-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 10/10] gtk: disable the F10 menubar key
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Peter Wu <peter@lekensteyn.nl>

From: Peter Wu <peter@lekensteyn.nl>

The F10 key is used in various applications, disable it unconditionally
(do not limit it to grab mode). Note that this property is deprecated
and might be removed in the future (GTK+ commit b082fb598d).

Fixes: https://bugs.launchpad.net/qemu/+bug/1726910
Signed-off-by: Peter Wu <peter@lekensteyn.nl>
Message-id: 20180510230739.28459-2-peter@lekensteyn.nl
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/gtk.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/ui/gtk.c b/ui/gtk.c
index ef6ca7179e..dbce970dc4 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2321,6 +2321,8 @@ static GtkWidget *gd_create_menu_view(GtkDisplayState *s)
 
 static void gd_create_menus(GtkDisplayState *s)
 {
+    GtkSettings *settings;
+
     s->accel_group = gtk_accel_group_new();
     s->machine_menu = gd_create_menu_machine(s);
     s->view_menu = gd_create_menu_view(s);
@@ -2336,6 +2338,10 @@ static void gd_create_menus(GtkDisplayState *s)
 
     g_object_set_data(G_OBJECT(s->window), "accel_group", s->accel_group);
     gtk_window_add_accel_group(GTK_WINDOW(s->window), s->accel_group);
+
+    /* Disable the default "F10" menu shortcut. */
+    settings = gtk_widget_get_settings(s->window);
+    g_object_set(G_OBJECT(settings), "gtk-menu-bar-accel", "", NULL);
 }
 
 
-- 
2.9.3
