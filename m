Received: from eggs.gnu.org ([2001:4830:134:3::10]:47930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dNXLH-0007Fp-Nj
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 00:34:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dNXLE-0003OI-LG
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 00:34:11 -0400
Received: from smtp2-g21.free.fr ([2a01:e0c:1:1599::11]:30075)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1dNXLE-0003N9-G5
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 00:34:08 -0400
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Wed, 21 Jun 2017 06:34:01 +0200
Message-Id: <20170621043401.19842-3-hpoussin@reactos.org>
In-Reply-To: <20170621043401.19842-1-hpoussin@reactos.org>
References: <20170621043401.19842-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/2] audio/adlib: remove limitation of one
 adlib card
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>

Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
---
 hw/audio/adlib.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
index be4203476a..6a5d39a8c8 100644
--- a/hw/audio/adlib.c
+++ b/hw/audio/adlib.c
@@ -74,8 +74,6 @@ typedef struct {
     PortioList port_list;
 } AdlibState;
=20
-static AdlibState *glob_adlib;
-
 static void adlib_stop_opl_timer (AdlibState *s, size_t n)
 {
     OPLTimerOver (s->opl, n);
@@ -132,7 +130,7 @@ static uint32_t adlib_read(void *opaque, uint32_t npo=
rt)
=20
 static void timer_handler (void *opaque, int c, double interval_Sec)
 {
-    AdlibState *s =3D glob_adlib;
+    AdlibState *s =3D opaque;
     unsigned n =3D c & 1;
 #ifdef DEBUG
     double interval;
@@ -259,19 +257,13 @@ static void adlib_realizefn (DeviceState *dev, Erro=
r **errp)
     AdlibState *s =3D ADLIB(dev);
     struct audsettings as;
=20
-    if (glob_adlib) {
-        error_setg (errp, "Cannot create more than 1 adlib device");
-        return;
-    }
-    glob_adlib =3D s;
-
     s->opl =3D OPLCreate (3579545, s->freq);
     if (!s->opl) {
         error_setg (errp, "OPLCreate %d failed", s->freq);
         return;
     }
     else {
-        OPLSetTimerHandler (s->opl, timer_handler, 0);
+        OPLSetTimerHandler(s->opl, timer_handler, s);
         s->enabled =3D 1;
     }
=20
--=20
2.11.0
