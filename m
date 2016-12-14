Received: from eggs.gnu.org ([2001:4830:134:3::10]:47303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cHAUo-0002Ib-Ip
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 09:25:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cHAUi-0005MK-Ur
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 09:25:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cHAUi-0005Lr-Pt
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 09:25:20 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D491E7F7DB
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 14:25:19 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 14 Dec 2016 14:25:18 +0000
Message-Id: <20161214142518.10504-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.8] ui/gtk: fix "Copy" menu item segfault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

The "Copy" menu item copies VTE terminal text to the clipboard.  This
only works with VTE terminals, not with graphics consoles.

Disable the menu item when the current notebook page isn't a VTE
terminal.

This patch fixes a segfault.  Reproducer: Start QEMU and click the Copy
menu item when the guest display is visible.

Reported-by: Kevin Wolf <kwolf@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 ui/gtk.c | 8 ++++++++
 1 file changed, 8 insertions(+)

Gerd, Michael: if you post Reviewed-by I can merge this directly without
requiring you to send a pull request.  It's a user interface segfault so it
would be nice to resolve it in QEMU 2.8.

diff --git a/ui/gtk.c b/ui/gtk.c
index e816428..a216216 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1581,6 +1581,9 @@ static void gd_change_page(GtkNotebook *nb, gpointer arg1, guint arg2,
                                        TRUE);
     }
     gtk_widget_set_sensitive(s->grab_item, on_vga);
+#ifdef CONFIG_VTE
+    gtk_widget_set_sensitive(s->copy_item, vc->type == GD_VC_VTE);
+#endif
 
     gd_update_windowsize(vc);
     gd_update_cursor(vc);
@@ -2246,6 +2249,11 @@ void gtk_display_init(DisplayState *ds, bool full_screen, bool grab_on_hover)
     }
 #endif
 
+#ifdef CONFIG_VTE
+    gtk_widget_set_sensitive(s->copy_item,
+                             gd_vc_find_current(s)->type == GD_VC_VTE);
+#endif
+
     if (full_screen) {
         gtk_menu_item_activate(GTK_MENU_ITEM(s->full_screen_item));
     }
-- 
2.9.3
