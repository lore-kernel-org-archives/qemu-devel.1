Received: from eggs.gnu.org ([2001:4830:134:3::10]:45350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dO1S6-0006lX-SM
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:43:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dO1S2-0006OY-UA
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:43:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dO1S2-0006Mp-Ns
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:43:10 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A479718E687
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 12:43:09 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Jun 2017 14:41:44 +0200
Message-Id: <20170622124204.19407-12-marcandre.lureau@redhat.com>
In-Reply-To: <20170622124204.19407-1-marcandre.lureau@redhat.com>
References: <20170622124204.19407-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 11/31] vnc: use DIV_ROUND_UP
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
 ui/vnc-enc-tight.c | 2 +-
 ui/vnc.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/vnc-enc-tight.c b/ui/vnc-enc-tight.c
index 1e53b1cf84..15a49ee53d 100644
--- a/ui/vnc-enc-tight.c
+++ b/ui/vnc-enc-tight.c
@@ -980,7 +980,7 @@ static int send_mono_rect(VncState *vs, int x, int y,
     }
 #endif
=20
-    bytes =3D ((w + 7) / 8) * h;
+    bytes =3D (DIV_ROUND_UP(w, 8)) * h;
=20
     vnc_write_u8(vs, (stream | VNC_TIGHT_EXPLICIT_FILTER) << 4);
     vnc_write_u8(vs, VNC_TIGHT_FILTER_PALETTE);
diff --git a/ui/vnc.c b/ui/vnc.c
index 5b77f70a45..4315807469 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2782,7 +2782,7 @@ static int vnc_refresh_server_surface(VncDisplay *v=
d)
             PIXMAN_FORMAT_BPP(pixman_image_get_format(vd->guest.fb));
         guest_row0 =3D (uint8_t *)pixman_image_get_data(vd->guest.fb);
         guest_stride =3D pixman_image_get_stride(vd->guest.fb);
-        guest_ll =3D pixman_image_get_width(vd->guest.fb) * ((guest_bpp =
+ 7) / 8);
+        guest_ll =3D pixman_image_get_width(vd->guest.fb) * (DIV_ROUND_U=
P(guest_bpp, 8));
     }
     line_bytes =3D MIN(server_stride, guest_ll);
=20
--=20
2.13.1.395.gf7b71de06
