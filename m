Received: from eggs.gnu.org ([2001:4830:134:3::10]:53686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ft7t0-0000uK-Jc
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 04:56:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ft7sx-0004up-E4
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 04:56:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50708 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ft7sx-0004sD-89
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 04:56:03 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 261EF402315B
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 08:56:02 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 24 Aug 2018 10:46:58 +0200
Message-Id: <20180824084658.4285-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2] gtk: add zoom-to-fit to gtk options.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>

This allows to set the option on the command line, i.e. "-display
gtk,zoom-to-fit={on,off}", overriding the default choosen by qemu.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/gtk.c     | 8 ++++++++
 qapi/ui.json | 6 +++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 5cce6ed42d..3ddb5fe162 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2136,6 +2136,8 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, VirtualConsole *vc,
                               QemuConsole *con, int idx,
                               GSList *group, GtkWidget *view_menu)
 {
+    bool zoom_to_fit;
+
     vc->label = qemu_console_get_label(con);
     vc->s = s;
     vc->gfx.scale_x = 1.0;
@@ -2199,6 +2201,12 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, VirtualConsole *vc,
     group = gd_vc_menu_init(s, vc, idx, group, view_menu);
 
     if (dpy_ui_info_supported(vc->gfx.dcl.con)) {
+        zoom_to_fit = true;
+    }
+    if (s->opts->u.gtk.has_zoom_to_fit) {
+        zoom_to_fit = s->opts->u.gtk.zoom_to_fit;
+    }
+    if (zoom_to_fit) {
         gtk_menu_item_activate(GTK_MENU_ITEM(s->zoom_fit_item));
         s->free_scale = true;
     }
diff --git a/qapi/ui.json b/qapi/ui.json
index 4ca91bb45a..4d2387ce7b 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1022,12 +1022,16 @@
 # GTK display options.
 #
 # @grab-on-hover: Grab keyboard input on mouse hover.
+# @zoom-to-fit: Zoom guest display to fit into the host window.  When
+#               turned off the host window will be resized instead
+#               (since 3.1).
 #
 # Since: 2.12
 #
 ##
 { 'struct'  : 'DisplayGTK',
-  'data'    : { '*grab-on-hover' : 'bool' } }
+  'data'    : { '*grab-on-hover' : 'bool',
+                '*zoom-to-fit'   : 'bool'  } }
 
  ##
  # @DisplayGLMode:
-- 
2.9.3
