Received: from eggs.gnu.org ([2001:4830:134:3::10]:43156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tomeu.vizoso@gmail.com>) id 1fFgPo-0004Mm-J0
	for qemu-devel@nongnu.org; Mon, 07 May 2018 09:42:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tomeu.vizoso@gmail.com>) id 1fFgPl-00006A-Gv
	for qemu-devel@nongnu.org; Mon, 07 May 2018 09:42:56 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35443)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tomeu.vizoso@gmail.com>)
	id 1fFgPl-00005z-9T
	for qemu-devel@nongnu.org; Mon, 07 May 2018 09:42:53 -0400
Received: by mail-wm0-x244.google.com with SMTP id o78-v6so15564184wmg.0
	for <qemu-devel@nongnu.org>; Mon, 07 May 2018 06:42:52 -0700 (PDT)
Sender: Tomeu Vizoso <tomeu.vizoso@gmail.com>
From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Date: Mon,  7 May 2018 15:42:37 +0200
Message-Id: <20180507134237.14996-1-tomeu.vizoso@collabora.com>
Subject: [Qemu-devel] [PATCH] ui/gtk: Only try to initialize EGL/X11 if
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>

The commit referenced below changed the logic by causing the gtk-egl
backend to be initialized regardless of whether GtkGlArea initialization
succeeded. This causes eglInitialize to crash in Wayland systems without
XWayland.

This patch restores the previous logic.

Fixes: 4c70280592f5 ("ui/gtk: use GtkGlArea on wayland only")
Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 ui/gtk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index ef5bc42094a3..72e2e246244d 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2448,7 +2448,7 @@ static void early_gtk_display_init(DisplayOptions *opts)
         if (GDK_IS_WAYLAND_DISPLAY(gdk_display_get_default())) {
             gtk_use_gl_area = true;
             gtk_gl_area_init();
-        }
+        } else
 #endif
         {
             gtk_egl_init();
-- 
2.17.0
