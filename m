Received: from eggs.gnu.org ([2001:4830:134:3::10]:56845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fuDHA-0005XI-5I
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 04:53:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fuDH5-0004k1-4p
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 04:53:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56010 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fuDH4-0004jX-Uh
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 04:53:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 945E240201BE
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 08:53:26 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 27 Aug 2018 10:53:15 +0200
Message-Id: <20180827085320.9732-8-kraxel@redhat.com>
In-Reply-To: <20180827085320.9732-1-kraxel@redhat.com>
References: <20180827085320.9732-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/12] spice-display: access ptr_x/ptr_y under
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
Cc: libvir-list@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

The OpenGL-enabled SPICE code was not accessing the cursor position
under the SimpleSpiceDisplay lock.  Fix this.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20180720063109.4631-2-pbonzini@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/spice-display.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/ui/spice-display.c b/ui/spice-display.c
index fe734821dd..46df673cd7 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -976,8 +976,10 @@ static void qemu_spice_gl_cursor_position(DisplayCha=
ngeListener *dcl,
 {
     SimpleSpiceDisplay *ssd =3D container_of(dcl, SimpleSpiceDisplay, dc=
l);
=20
+    qemu_mutex_lock(&ssd->lock);
     ssd->ptr_x =3D pos_x;
     ssd->ptr_y =3D pos_y;
+    qemu_mutex_unlock(&ssd->lock);
 }
=20
 static void qemu_spice_gl_release_dmabuf(DisplayChangeListener *dcl,
@@ -1055,10 +1057,15 @@ static void qemu_spice_gl_update(DisplayChangeLis=
tener *dcl,
     }
=20
     if (render_cursor) {
+        int x, y;
+        qemu_mutex_lock(&ssd->lock);
+        x =3D ssd->ptr_x;
+        y =3D ssd->ptr_y;
+        qemu_mutex_unlock(&ssd->lock);
         egl_texture_blit(ssd->gls, &ssd->blit_fb, &ssd->guest_fb,
                          !y_0_top);
         egl_texture_blend(ssd->gls, &ssd->blit_fb, &ssd->cursor_fb,
-                          !y_0_top, ssd->ptr_x, ssd->ptr_y);
+                          !y_0_top, x, y);
         glFlush();
     }
=20
--=20
2.9.3
