Received: from eggs.gnu.org ([209.51.188.92]:55154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghW3H-0008SQ-1Y
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 03:51:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghW0T-00062Q-MU
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 03:48:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ghW0T-00061h-H2
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 03:48:05 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1749AA0C2B
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 08:48:04 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 10 Jan 2019 09:47:45 +0100
Message-Id: <20190110084752.30510-2-kraxel@redhat.com>
In-Reply-To: <20190110084752.30510-1-kraxel@redhat.com>
References: <20190110084752.30510-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/8] egl-headless: add egl_create_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

We must set the correct context (via eglMakeCurrent) before
calling qemu_egl_create_context, so we need a thin wrapper and can't
hook qemu_egl_create_context directly as ->dpy_gl_ctx_create callback.

Reported-by: Frederik Carlier <frederik.carlier@quamotion.mobi>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20181129123502.30129-1-kraxel@redhat.com
---
 ui/egl-headless.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/ui/egl-headless.c b/ui/egl-headless.c
index 4cf3bbc0e4..519e7bad32 100644
--- a/ui/egl-headless.c
+++ b/ui/egl-headless.c
@@ -38,6 +38,14 @@ static void egl_gfx_switch(DisplayChangeListener *dcl,
     edpy->ds = new_surface;
 }
 
+static QEMUGLContext egl_create_context(DisplayChangeListener *dcl,
+                                        QEMUGLParams *params)
+{
+    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE, EGL_NO_SURFACE,
+                   qemu_egl_rn_ctx);
+    return qemu_egl_create_context(dcl, params);
+}
+
 static void egl_scanout_disable(DisplayChangeListener *dcl)
 {
     egl_dpy *edpy = container_of(dcl, egl_dpy, dcl);
@@ -150,7 +158,7 @@ static const DisplayChangeListenerOps egl_ops = {
     .dpy_gfx_update          = egl_gfx_update,
     .dpy_gfx_switch          = egl_gfx_switch,
 
-    .dpy_gl_ctx_create       = qemu_egl_create_context,
+    .dpy_gl_ctx_create       = egl_create_context,
     .dpy_gl_ctx_destroy      = qemu_egl_destroy_context,
     .dpy_gl_ctx_make_current = qemu_egl_make_context_current,
     .dpy_gl_ctx_get_current  = qemu_egl_get_current_context,
-- 
2.9.3
