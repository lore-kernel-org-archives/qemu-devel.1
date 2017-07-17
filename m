Received: from eggs.gnu.org ([2001:4830:134:3::10]:47847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dX2LN-0001NB-6l
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:29:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dX2LI-0003gy-PU
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:29:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dX2LI-0003gO-JS
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:29:28 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 17 Jul 2017 11:29:23 +0200
Message-Id: <20170717092923.12317-4-kraxel@redhat.com>
In-Reply-To: <20170717092923.12317-1-kraxel@redhat.com>
References: <20170717092923.12317-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/3] audio/adlib: remove limitation of one adlib
 card
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Gerd Hoffmann <kraxel@redhat.com>

From: Herv=C3=A9 Poussineau <hpoussin@reactos.org>

Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20170621043401.19842-3-hpoussin@reactos.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/adlib.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
index be4203476a..97b876c7e0 100644
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
2.9.3
