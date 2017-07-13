Received: from eggs.gnu.org ([2001:4830:134:3::10]:42111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dVh2f-0002MQ-H1
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:32:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dVh2b-0003wm-JR
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:32:41 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Jul 2017 18:31:52 +0200
Message-Id: <20170713163219.9024-3-marcandre.lureau@redhat.com>
In-Reply-To: <20170713163219.9024-1-marcandre.lureau@redhat.com>
References: <20170713163219.9024-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 02/29] vnc: use QEMU_ALIGN_DOWN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

I used the clang-tidy qemu-round check to generate the fix:
https://github.com/elmarco/clang-tools-extra

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 26136f5d29..9710f11be8 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2624,8 +2624,8 @@ static int vnc_refresh_lossy_rect(VncDisplay *vd, i=
nt x, int y)
     int stx =3D x / VNC_STAT_RECT;
     int has_dirty =3D 0;
=20
-    y =3D y / VNC_STAT_RECT * VNC_STAT_RECT;
-    x =3D x / VNC_STAT_RECT * VNC_STAT_RECT;
+    y =3D QEMU_ALIGN_DOWN(y, VNC_STAT_RECT);
+    x =3D QEMU_ALIGN_DOWN(x, VNC_STAT_RECT);
=20
     QTAILQ_FOREACH(vs, &vd->clients, next) {
         int j;
@@ -2714,8 +2714,8 @@ double vnc_update_freq(VncState *vs, int x, int y, =
int w, int h)
     double total =3D 0;
     int num =3D 0;
=20
-    x =3D  (x / VNC_STAT_RECT) * VNC_STAT_RECT;
-    y =3D  (y / VNC_STAT_RECT) * VNC_STAT_RECT;
+    x =3D  QEMU_ALIGN_DOWN(x, VNC_STAT_RECT);
+    y =3D  QEMU_ALIGN_DOWN(y, VNC_STAT_RECT);
=20
     for (j =3D y; j <=3D y + h; j +=3D VNC_STAT_RECT) {
         for (i =3D x; i <=3D x + w; i +=3D VNC_STAT_RECT) {
--=20
2.13.1.395.gf7b71de06
