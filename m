Received: from eggs.gnu.org ([2001:4830:134:3::10]:52822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gMUm0-0005wu-9x
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 04:14:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gMUb1-0000LT-2q
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 04:02:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gMUb0-0000K0-Sb
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 04:02:55 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 13 Nov 2018 10:02:49 +0100
Message-Id: <20181113090249.15658-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] gtk: sync guest display updates to host
 display refresh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, tgfbeta@me.com

Reduce console refresh timer to idle refresh rate.  Register a frame
tick callback (called by gtk on each display frame) and use that to kick
display updates instead.

That should sync qemu refresh rate to display refresh rate.  It'll also
stop updating the qemu display in case the qemu is not visible (gtk
stops calling the frame tick callback then).

Buglink: https://bugs.launchpad.net/bugs/1802915
Suggested-by: Chen Zhang <tgfbeta@me.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/gtk.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/ui/gtk.c b/ui/gtk.c
index 579990b865..8f79dfe42c 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1661,6 +1661,16 @@ static gboolean gd_configure(GtkWidget *widget,
     return FALSE;
 }
 
+static gboolean gd_frame_tick(GtkWidget *widget,
+                              GdkFrameClock *frame_clock,
+                              gpointer opaque)
+{
+    VirtualConsole *vc = opaque;
+
+    vc->gfx.dcl.ops->dpy_refresh(&vc->gfx.dcl);
+    return G_SOURCE_CONTINUE;
+}
+
 /** Virtual Console Callbacks **/
 
 static GSList *gd_vc_menu_init(GtkDisplayState *s, VirtualConsole *vc,
@@ -1911,6 +1921,12 @@ static void gd_connect_vc_gfx_signals(VirtualConsole *vc)
                          G_CALLBACK(gd_focus_out_event), vc);
         g_signal_connect(vc->gfx.drawing_area, "configure-event",
                          G_CALLBACK(gd_configure), vc);
+        if (1 /* make that a config option ??? */) {
+            update_displaychangelistener(&vc->gfx.dcl,
+                                         GUI_REFRESH_INTERVAL_IDLE);
+            gtk_widget_add_tick_callback(vc->gfx.drawing_area,
+                                         gd_frame_tick, vc, NULL);
+        }
     } else {
         g_signal_connect(vc->gfx.drawing_area, "key-press-event",
                          G_CALLBACK(gd_text_key_down), vc);
-- 
2.9.3
