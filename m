Received: from eggs.gnu.org ([2001:4830:134:3::10]:44233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g6vew-00069Z-So
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 06:42:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g6veu-0000ha-62
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 06:42:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:16376)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1g6veu-0000hA-0D
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 06:42:36 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com
	[10.5.11.24])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4DFFB9090A
	for <qemu-devel@nongnu.org>; Mon,  1 Oct 2018 10:42:35 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  1 Oct 2018 12:42:30 +0200
Message-Id: <20181001104230.17779-4-kraxel@redhat.com>
In-Reply-To: <20181001104230.17779-1-kraxel@redhat.com>
References: <20181001104230.17779-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 3/3] gtk: add zoom-to-fit to gtk options.
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
gtk,zoom-to-fit={on,off}", overriding the default chosen by qemu.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-id: 20180827095620.26774-1-kraxel@redhat.com
---
 ui/gtk.c     |  8 ++++++++
 qapi/ui.json | 10 +++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

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
index 4ca91bb45a..bf9e157d5a 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1022,12 +1022,20 @@
 # GTK display options.
 #
 # @grab-on-hover: Grab keyboard input on mouse hover.
+# @zoom-to-fit: Zoom guest display to fit into the host window.  When
+#               turned off the host window will be resized instead.
+#               In case the display device can notify the guest on
+#               window resizes (virtio-gpu) this will default to "on",
+#               assuming the guest will resize the display to match
+#               the window size then.  Otherwise it defaults to "off".
+#               Since 3.1
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
