Received: from eggs.gnu.org ([2001:4830:134:3::10]:46756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fgOwe-0005IQ-2c
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 02:31:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fgOwb-0007d5-Tl
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 02:31:16 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:50787)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fgOwb-0007cd-M7
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 02:31:13 -0400
Received: by mail-wm0-x241.google.com with SMTP id v25-v6so8373028wmc.0
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 23:31:13 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 20 Jul 2018 08:31:08 +0200
Message-Id: <20180720063109.4631-2-pbonzini@redhat.com>
In-Reply-To: <20180720063109.4631-1-pbonzini@redhat.com>
References: <20180720063109.4631-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] spice-display: access ptr_x/ptr_y under
 Mutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The OpenGL-enabled SPICE code was not accessing the cursor position
under the SimpleSpiceDisplay lock.  Fix this.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 ui/spice-display.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/ui/spice-display.c b/ui/spice-display.c
index fe734821dd..46df673cd7 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -976,8 +976,10 @@ static void qemu_spice_gl_cursor_position(DisplayChangeListener *dcl,
 {
     SimpleSpiceDisplay *ssd = container_of(dcl, SimpleSpiceDisplay, dcl);
 
+    qemu_mutex_lock(&ssd->lock);
     ssd->ptr_x = pos_x;
     ssd->ptr_y = pos_y;
+    qemu_mutex_unlock(&ssd->lock);
 }
 
 static void qemu_spice_gl_release_dmabuf(DisplayChangeListener *dcl,
@@ -1055,10 +1057,15 @@ static void qemu_spice_gl_update(DisplayChangeListener *dcl,
     }
 
     if (render_cursor) {
+        int x, y;
+        qemu_mutex_lock(&ssd->lock);
+        x = ssd->ptr_x;
+        y = ssd->ptr_y;
+        qemu_mutex_unlock(&ssd->lock);
         egl_texture_blit(ssd->gls, &ssd->blit_fb, &ssd->guest_fb,
                          !y_0_top);
         egl_texture_blend(ssd->gls, &ssd->blit_fb, &ssd->cursor_fb,
-                          !y_0_top, ssd->ptr_x, ssd->ptr_y);
+                          !y_0_top, x, y);
         glFlush();
     }
 
-- 
2.17.1
