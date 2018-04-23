Received: from eggs.gnu.org ([2001:4830:134:3::10]:45762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fAV9f-0007s5-Pk
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 02:40:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fAV9a-0005io-SZ
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 02:40:51 -0400
Received: from 9.mo173.mail-out.ovh.net ([46.105.72.44]:50051)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fAV9a-0005dh-ML
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 02:40:46 -0400
Received: from player737.ha.ovh.net (unknown [10.109.108.121])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id F3B42B051C
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 08:40:36 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 23 Apr 2018 08:40:20 +0200
Message-Id: <20180423064020.25434-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] timer/aspeed: fix vmstate version id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

commit 1d3e65aa7ac5 ("hw/timer: Add value matching support to
aspeed_timer") increased the vmstate version of the timers array but
doing so, it broke migration. To fix, we also need to change the
vmstate version of the aspeed timer controller model.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 To test on a 'palmetto-bmc' board, download the latest built OpenBMC
 flash image :

   wget https://openpower.xyz/job/openbmc-build/distro=3Dubuntu,target=3D=
palmetto/lastSuccessfulBuild/artifact/deploy/images/palmetto/flash-palmet=
to

 start two instances of QEMU with :

   qemu-system-arm -m 512 -M palmetto-bmc -drive file=3D./flash-palmetto,=
format=3Draw,if=3Dmtd -serial mon:stdio -nographic -nodefaults

 and :
=20
   qemu-system-arm -m 512 -M palmetto-bmc -drive file=3D./flash-palmetto,=
format=3Draw,if=3Dmtd -serial mon:stdio -nographic -nodefaults -incoming =
tcp::1234

 then, run migrate from the monitor:
=20
   (qemu) migrate tcp:localhost:1234

 hw/timer/aspeed_timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index 50acbf530a3a..7df19bd9df91 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -498,8 +498,8 @@ static const VMStateDescription vmstate_aspeed_timer =
=3D {
=20
 static const VMStateDescription vmstate_aspeed_timer_state =3D {
     .name =3D "aspeed.timerctrl",
-    .version_id =3D 1,
-    .minimum_version_id =3D 1,
+    .version_id =3D 2,
+    .minimum_version_id =3D 2,
     .fields =3D (VMStateField[]) {
         VMSTATE_UINT32(ctrl, AspeedTimerCtrlState),
         VMSTATE_UINT32(ctrl2, AspeedTimerCtrlState),
--=20
2.13.6
