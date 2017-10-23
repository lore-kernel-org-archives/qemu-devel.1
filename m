Received: from eggs.gnu.org ([2001:4830:134:3::10]:41986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e6bSW-0006nd-4e
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 08:04:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e6bSS-0000EC-B1
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 08:03:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e6bSS-0000Dr-59
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 08:03:52 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1705EBBD9
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 12:03:51 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 23 Oct 2017 14:03:16 +0200
Message-Id: <20171023120317.8296-4-kraxel@redhat.com>
In-Reply-To: <20171023120317.8296-1-kraxel@redhat.com>
References: <20171023120317.8296-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] gtk: use GtkGlArea on wayland only
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

For dma-buf imports we need a egl context.  The GtkGlArea widget uses
glx though when running on X11.  So use the GtkGlArea code on wayland
only.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/gtk.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 33cd848db3..d794fb7fa9 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2374,12 +2374,15 @@ void early_gtk_display_init(int opengl)
         break;
     case 1: /* on */
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
         break;
     default:
-- 
2.9.3
