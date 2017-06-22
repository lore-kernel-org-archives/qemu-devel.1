Received: from eggs.gnu.org ([2001:4830:134:3::10]:44946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dO1RJ-0005sP-BJ
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:42:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dO1RF-0005lq-Dr
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:42:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42243)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dO1RF-0005kk-7B
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:42:21 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2FC2110C96
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 12:42:20 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Jun 2017 14:41:35 +0200
Message-Id: <20170622124204.19407-3-marcandre.lureau@redhat.com>
In-Reply-To: <20170622124204.19407-1-marcandre.lureau@redhat.com>
References: <20170622124204.19407-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 02/31] vnc: use QEMU_ALIGN_DOWN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

I used the clang-tidy qemu-round check to generate the fix:
https://github.com/elmarco/clang-tools-extra

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 47b49c7318..5b77f70a45 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2625,8 +2625,8 @@ static int vnc_refresh_lossy_rect(VncDisplay *vd, i=
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
@@ -2715,8 +2715,8 @@ double vnc_update_freq(VncState *vs, int x, int y, =
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
