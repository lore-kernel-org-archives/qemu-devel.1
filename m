Received: from eggs.gnu.org ([2001:4830:134:3::10]:48527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fIW6u-0004Dw-8y
	for qemu-devel@nongnu.org; Tue, 15 May 2018 05:19:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fIW6q-0001Tm-6J
	for qemu-devel@nongnu.org; Tue, 15 May 2018 05:19:08 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 15 May 2018 11:18:54 +0200
Message-Id: <20180515091901.27774-4-kraxel@redhat.com>
In-Reply-To: <20180515091901.27774-1-kraxel@redhat.com>
References: <20180515091901.27774-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 03/10] ui/gtk: Only try to initialize EGL/X11 if
 GtkGlArea failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>

From: Tomeu Vizoso <tomeu.vizoso@collabora.com>

The commit referenced below changed the logic by causing the gtk-egl
backend to be initialized regardless of whether GtkGlArea initialization
succeeded. This causes eglInitialize to crash in Wayland systems without
XWayland.

This patch restores the previous logic.

Fixes: 4c70280592f5 ("ui/gtk: use GtkGlArea on wayland only")
Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Message-id: 20180507134237.14996-1-tomeu.vizoso@collabora.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/gtk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 9e5390f2c2..568c9563ce 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2484,7 +2484,7 @@ static void early_gtk_display_init(DisplayOptions *opts)
         if (GDK_IS_WAYLAND_DISPLAY(gdk_display_get_default())) {
             gtk_use_gl_area = true;
             gtk_gl_area_init();
-        }
+        } else
 #endif
         {
             gtk_egl_init();
-- 
2.9.3
