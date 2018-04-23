Received: from eggs.gnu.org ([2001:4830:134:3::10]:33170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fAYUo-0000sD-AQ
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 06:14:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fAYUl-0000YE-4w
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 06:14:54 -0400
Received: from 5.mo173.mail-out.ovh.net ([46.105.40.148]:44400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fAYUk-0000WB-TD
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 06:14:51 -0400
Received: from player774.ha.ovh.net (unknown [10.109.122.116])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 22486BF71C
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 12:14:49 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 23 Apr 2018 12:14:33 +0200
Message-Id: <20180423101433.17759-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] timer/aspeed: fix vmstate version id
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
aspeed_timer") increased the vmstate version of aspeed.timer because
the state had changed, but it also bumped the version of the
VMSTATE_STRUCT_ARRAY under the aspeed.timerctrl which did not need to.

Change back this version to fix migration.

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


 Changes since v1:

 - change version of VMSTATE_STRUCT_ARRAY and not vmstate_aspeed_timer_st=
ate

 hw/timer/aspeed_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index 50acbf530a3a..1e31e22b6f1f 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -504,7 +504,7 @@ static const VMStateDescription vmstate_aspeed_timer_=
state =3D {
         VMSTATE_UINT32(ctrl, AspeedTimerCtrlState),
         VMSTATE_UINT32(ctrl2, AspeedTimerCtrlState),
         VMSTATE_STRUCT_ARRAY(timers, AspeedTimerCtrlState,
-                             ASPEED_TIMER_NR_TIMERS, 2, vmstate_aspeed_t=
imer,
+                             ASPEED_TIMER_NR_TIMERS, 1, vmstate_aspeed_t=
imer,
                              AspeedTimer),
         VMSTATE_END_OF_LIST()
     }
--=20
2.13.6
