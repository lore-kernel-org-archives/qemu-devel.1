Received: from eggs.gnu.org ([2001:4830:134:3::10]:60917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d996p-0002tG-Ig
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:51:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d996o-00056R-JM
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:51:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:7915)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d996o-00055x-E6
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:51:46 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 12 May 2017 13:51:35 +0200
Message-Id: <20170512115135.17379-11-kraxel@redhat.com>
In-Reply-To: <20170512115135.17379-1-kraxel@redhat.com>
References: <20170512115135.17379-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/10] vnc: replace hweight_long() with ctpopl()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>

From: C=C3=A9dric Le Goater <clg@kaod.org>

ctpopl() has a better implementation than hweight_long() and ui/vnc.c
being the last user of hweight_long(), we can simply remove it.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 1489415605-13105-1-git-send-email-clg@kaod.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/qemu/bitops.h | 10 ----------
 ui/vnc.c              |  6 +++---
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/include/qemu/bitops.h b/include/qemu/bitops.h
index 1881284cb5..3f0926cf40 100644
--- a/include/qemu/bitops.h
+++ b/include/qemu/bitops.h
@@ -201,16 +201,6 @@ static inline unsigned long find_first_zero_bit(cons=
t unsigned long *addr,
     return find_next_zero_bit(addr, size, 0);
 }
=20
-static inline unsigned long hweight_long(unsigned long w)
-{
-    unsigned long count;
-
-    for (count =3D 0; w; w >>=3D 1) {
-        count +=3D w & 1;
-    }
-    return count;
-}
-
 /**
  * rol8 - rotate an 8-bit value left
  * @word: value to rotate
diff --git a/ui/vnc.c b/ui/vnc.c
index 601f9ec539..47b49c7318 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2061,15 +2061,15 @@ static void set_pixel_format(VncState *vs, int bi=
ts_per_pixel,
     }
=20
     vs->client_pf.rmax =3D red_max ? red_max : 0xFF;
-    vs->client_pf.rbits =3D hweight_long(red_max);
+    vs->client_pf.rbits =3D ctpopl(red_max);
     vs->client_pf.rshift =3D red_shift;
     vs->client_pf.rmask =3D red_max << red_shift;
     vs->client_pf.gmax =3D green_max ? green_max : 0xFF;
-    vs->client_pf.gbits =3D hweight_long(green_max);
+    vs->client_pf.gbits =3D ctpopl(green_max);
     vs->client_pf.gshift =3D green_shift;
     vs->client_pf.gmask =3D green_max << green_shift;
     vs->client_pf.bmax =3D blue_max ? blue_max : 0xFF;
-    vs->client_pf.bbits =3D hweight_long(blue_max);
+    vs->client_pf.bbits =3D ctpopl(blue_max);
     vs->client_pf.bshift =3D blue_shift;
     vs->client_pf.bmask =3D blue_max << blue_shift;
     vs->client_pf.bits_per_pixel =3D bits_per_pixel;
--=20
2.9.3
