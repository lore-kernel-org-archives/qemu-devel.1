Received: from eggs.gnu.org ([2001:4830:134:3::10]:51302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter@lekensteyn.nl>) id 1fGuf4-0002eo-Tl
	for qemu-devel@nongnu.org; Thu, 10 May 2018 19:07:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter@lekensteyn.nl>) id 1fGuf3-0005HT-Vy
	for qemu-devel@nongnu.org; Thu, 10 May 2018 19:07:46 -0400
Received: from mail.lekensteyn.nl ([2a02:2308::360:1:25]:54765)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter@lekensteyn.nl>) id 1fGuf3-0005GM-MI
	for qemu-devel@nongnu.org; Thu, 10 May 2018 19:07:45 -0400
From: Peter Wu <peter@lekensteyn.nl>
Date: Fri, 11 May 2018 01:07:39 +0200
Message-Id: <20180510230739.28459-2-peter@lekensteyn.nl>
In-Reply-To: <20180510230739.28459-1-peter@lekensteyn.nl>
References: <20180510230739.28459-1-peter@lekensteyn.nl>
Subject: [Qemu-devel] [PATCH 2/2] gtk: disable the F10 menubar key
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

The F10 key is used in various applications, disable it unconditionally
(do not limit it to grab mode). Note that this property is deprecated
and might be removed in the future (GTK+ commit b082fb598d).

Fixes: https://bugs.launchpad.net/qemu/+bug/1726910
Signed-off-by: Peter Wu <peter@lekensteyn.nl>
---
 ui/gtk.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/ui/gtk.c b/ui/gtk.c
index 9e5390f2c2..6ad6cacfaa 100644
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
2.17.0
