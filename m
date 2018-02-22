Received: from eggs.gnu.org ([2001:4830:134:3::10]:50265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eoo2E-0003J0-Ii
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 05:23:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eoo2B-0001ze-CW
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 05:23:30 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38390 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eoo2B-0001yP-5y
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 05:23:27 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9F94F404085A
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 10:23:24 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 22 Feb 2018 11:23:11 +0100
Message-Id: <20180222102317.25776-4-kraxel@redhat.com>
In-Reply-To: <20180222102317.25776-1-kraxel@redhat.com>
References: <20180222102317.25776-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 3/9] egl-headless: cursor_dmabuf: handle NULL
 cursor
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

The cursor dmabuf can be NULL, in case no cursor defined by the guest.
Happens for example when linux guests show the framebuffer console.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20180220110433.20353-3-kraxel@redhat.com
---
 ui/egl-headless.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/ui/egl-headless.c b/ui/egl-headless.c
index 00ff2c036a..b33e0b21fd 100644
--- a/ui/egl-headless.c
+++ b/ui/egl-headless.c
@@ -89,13 +89,16 @@ static void egl_cursor_dmabuf(DisplayChangeListener *dcl,
 {
     egl_dpy *edpy = container_of(dcl, egl_dpy, dcl);
 
-    egl_dmabuf_import_texture(dmabuf);
-    if (!dmabuf->texture) {
-        return;
+    if (dmabuf) {
+        egl_dmabuf_import_texture(dmabuf);
+        if (!dmabuf->texture) {
+            return;
+        }
+        egl_fb_setup_for_tex(&edpy->cursor_fb, dmabuf->width, dmabuf->height,
+                             dmabuf->texture, false);
+    } else {
+        egl_fb_destroy(&edpy->cursor_fb);
     }
-
-    egl_fb_setup_for_tex(&edpy->cursor_fb, dmabuf->width, dmabuf->height,
-                         dmabuf->texture, false);
 }
 
 static void egl_cursor_position(DisplayChangeListener *dcl,
-- 
2.9.3
