Received: from eggs.gnu.org ([2001:4830:134:3::10]:49636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1et8bo-0002EK-4f
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 04:10:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1et8bj-0000Si-2V
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 04:10:08 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39332 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1et8bi-0000Rg-To
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 04:10:02 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3C59684222
	for <qemu-devel@nongnu.org>; Tue,  6 Mar 2018 09:09:58 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  6 Mar 2018 10:09:49 +0100
Message-Id: <20180306090951.22932-5-kraxel@redhat.com>
In-Reply-To: <20180306090951.22932-1-kraxel@redhat.com>
References: <20180306090951.22932-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/6] ui/gtk: use GtkGlArea on wayland only
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

For dma-buf support we need a egl context.  The gtk x11 backend uses glx
contexts though.  We can't use the GtkGlArea widget on x11 because of
that, so use our own gtk-egl code instead.  wayland continues to use
the GtkGlArea widget.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/gtk.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 856429a02f..4a1622b887 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2440,12 +2440,15 @@ static void early_gtk_display_init(DisplayOptions *opts)
     assert(opts->type == DISPLAY_TYPE_GTK);
     if (opts->has_gl && opts->gl) {
 #if defined(CONFIG_OPENGL)
-#if defined(CONFIG_GTK_GL)
-        gtk_use_gl_area = true;
-        gtk_gl_area_init();
-#else
-        gtk_egl_init();
+#if defined(CONFIG_GTK_GL) && defined(GDK_WINDOWING_WAYLAND)
+        if (GDK_IS_WAYLAND_DISPLAY(gdk_display_get_default())) {
+            gtk_use_gl_area = true;
+            gtk_gl_area_init();
+        }
 #endif
+        {
+            gtk_egl_init();
+        }
 #endif
     }
 
-- 
2.9.3
