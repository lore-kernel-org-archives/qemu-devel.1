Received: from eggs.gnu.org ([2001:4830:134:3::10]:47296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fJa0X-0001tg-3C
	for qemu-devel@nongnu.org; Fri, 18 May 2018 03:40:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fJa0U-00052v-0h
	for qemu-devel@nongnu.org; Fri, 18 May 2018 03:40:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60610 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fJa0T-00052l-SC
	for qemu-devel@nongnu.org; Fri, 18 May 2018 03:40:53 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 18 May 2018 09:40:52 +0200
Message-Id: <20180518074052.31724-4-kraxel@redhat.com>
In-Reply-To: <20180518074052.31724-1-kraxel@redhat.com>
References: <20180518074052.31724-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/3] sdl: Move use of surface pointer below
 check for whether it is NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

In commit 2ab858c6c38ee1 we added a use of the 'surf' variable
in sdl2_2d_update() that was unfortunately placed above the
early-exit-if-NULL check. Move it to where it ought to be.

Fixes: Coverity CID 1390598
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20180515185814.1374-1-peter.maydell@linaro.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/sdl2-2d.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/ui/sdl2-2d.c b/ui/sdl2-2d.c
index 1f34817bae..85484407be 100644
--- a/ui/sdl2-2d.c
+++ b/ui/sdl2-2d.c
@@ -36,9 +36,7 @@ void sdl2_2d_update(DisplayChangeListener *dcl,
     struct sdl2_console *scon =3D container_of(dcl, struct sdl2_console,=
 dcl);
     DisplaySurface *surf =3D qemu_console_surface(dcl->con);
     SDL_Rect rect;
-    size_t surface_data_offset =3D surface_bytes_per_pixel(surf) * x +
-                                 surface_stride(surf) * y;
-
+    size_t surface_data_offset;
     assert(!scon->opengl);
=20
     if (!surf) {
@@ -48,6 +46,8 @@ void sdl2_2d_update(DisplayChangeListener *dcl,
         return;
     }
=20
+    surface_data_offset =3D surface_bytes_per_pixel(surf) * x +
+                          surface_stride(surf) * y;
     rect.x =3D x;
     rect.y =3D y;
     rect.w =3D w;
--=20
2.9.3
