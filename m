Received: from eggs.gnu.org ([2001:4830:134:3::10]:51847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cVyDC-0007Kj-9w
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:20:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cVyD8-0004Gs-9t
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:20:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cVyD8-0004Gm-4R
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:20:22 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 24 Jan 2017 11:20:17 +0100
Message-Id: <1485253217-7405-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] console: fix console resize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 1658634@bugs.launchpad.net, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Only skip surface reallocation in case the old surface was created using
qemu_alloc_display (via qemu_create_displaysurface) too, otherwise we
might end up with a DisplaySurface with the wrong backing storage.

Cc: 1658634@bugs.launchpad.net
Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Fixes: cd958edb1fae85d0c7d1e1acbff82d22724e8d64
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/console.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/console.c b/ui/console.c
index b9575f2..67c65b7 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -2121,7 +2121,7 @@ void qemu_console_resize(QemuConsole *s, int width,=
 int height)
=20
     assert(s->console_type =3D=3D GRAPHIC_CONSOLE);
=20
-    if (s->surface &&
+    if (s->surface && (surface->flags & QEMU_ALLOCATED_FLAG) &&
         pixman_image_get_width(s->surface->image) =3D=3D width &&
         pixman_image_get_height(s->surface->image) =3D=3D height) {
         return;
--=20
1.8.3.1
