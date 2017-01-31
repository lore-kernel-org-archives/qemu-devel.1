Received: from eggs.gnu.org ([2001:4830:134:3::10]:38029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYahf-00055D-AN
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:50:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYahd-0001V6-EV
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:50:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cYahd-0001UC-75
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:50:41 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 31 Jan 2017 16:50:31 +0100
Message-Id: <1485877831-28786-12-git-send-email-kraxel@redhat.com>
In-Reply-To: <1485877831-28786-1-git-send-email-kraxel@redhat.com>
References: <1485877831-28786-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 11/11] console: fix console resize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 1658634@bugs.launchpad.net

Only skip surface reallocation in case the old surface was created using
qemu_alloc_display (via qemu_create_displaysurface) too, otherwise we
might end up with a DisplaySurface with the wrong backing storage.

Cc: 1658634@bugs.launchpad.net
Fixes: cd958edb1fae85d0c7d1e1acbff82d22724e8d64
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Tested-by: Laszlo Ersek <lersek@redhat.com>
Message-id: 1485256239-12219-1-git-send-email-kraxel@redhat.com
---
 ui/console.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/console.c b/ui/console.c
index fe03a66..e353c85 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -2116,7 +2116,7 @@ void qemu_console_resize(QemuConsole *s, int width,=
 int height)
=20
     assert(s->console_type =3D=3D GRAPHIC_CONSOLE);
=20
-    if (s->surface &&
+    if (s->surface && (s->surface->flags & QEMU_ALLOCATED_FLAG) &&
         pixman_image_get_width(s->surface->image) =3D=3D width &&
         pixman_image_get_height(s->surface->image) =3D=3D height) {
         return;
--=20
1.8.3.1
