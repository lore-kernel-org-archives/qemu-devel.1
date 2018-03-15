Received: from eggs.gnu.org ([2001:4830:134:3::10]:49429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ewUdE-00069A-2L
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 11:17:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ewUd9-0002co-SX
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 11:17:28 -0400
Received: from indium.canonical.com ([91.189.90.7]:55980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ewUd9-0002bp-LO
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 11:17:23 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ewUd6-0006RK-RB
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 15:17:21 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 598D62E80E3
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 15:17:19 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Mar 2018 15:01:28 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1748434 <1748434@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151817810596.29573.3248344286701751294.malonedeb@chaenomeles.canonical.com>
Message-Id: <152112608820.3381.8235238939104232708.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1748434] Re: Possibly wrong GICv3 behavior when
 secure enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Patch which should fix this:
https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg04537.html


** Changed in: qemu
       Status: New =3D> In Progress

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1748434

Title:
  Possibly wrong GICv3 behavior when secure enabled

Status in QEMU:
  In Progress

Bug description:
  I an tried arm-aarch64 interrupt routing to EL3, by SCR_EL3.FIQ=3D1. Firs=
t I am started QEMU with secure=3Don and GICv3 support.
  I programmed secure and non-secure timers and set-up appropriate interrup=
ts.Secure timer to be GRP1_Secure and non-secure timer to be GRP1_NonSecure=
. ICC_PMR =3D 0xff. Then I switched CPU to EL1. =

  With that setup no interrupt was delivered to PE. GIC interface showed th=
at non secure IRQ is pending. ICC_PMR read at EL1 returns 0 (shall return v=
alue ((PMR_(el3) << 1) & 0xff) according to GIC specification.
  Than I tried to increase interrupt priority mask  - so I set ICC_PMR =3D =
0x7f (at EL3). Then I read at EL1 ICC_PMR=3D0xfe - (is shall be 0). With th=
is setup IRQ of secure timer was taken at EL3, non secure timer didn't rise=
 IRQ (as it is masked by PMR). =

  I dig to qemu code and see wrong condition in file arm_gicv3_cpuif.c in f=
unction  icc_pmr_read(). This behavior is opposite of ARM specification.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1748434/+subscriptions
