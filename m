Received: from eggs.gnu.org ([2001:4830:134:3::10]:55797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ek7ac-0002Yj-Lh
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 07:15:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ek7aX-0005Q9-Mb
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 07:15:38 -0500
Received: from indium.canonical.com ([91.189.90.7]:60272)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ek7aX-0005PK-Gk
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 07:15:33 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ek7aW-0000sx-31
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 12:15:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1484E2E80C7
	for <qemu-devel@nongnu.org>; Fri,  9 Feb 2018 12:15:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Feb 2018 12:08:25 -0000
From: Robert Pasz <1748434@bugs.launchpad.net>
Reply-To: Bug 1748434 <1748434@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <151817810596.29573.3248344286701751294.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1748434] [NEW] Possibly wrong GICv3 behavior when
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

Public bug reported:

I an tried arm-aarch64 interrupt routing to EL3, by SCR_EL3.FIQ=3D1. First =
I am started QEMU with secure=3Don and GICv3 support.
I programmed secure and non-secure timers and set-up appropriate interrupts=
.Secure timer to be GRP1_Secure and non-secure timer to be GRP1_NonSecure. =
ICC_PMR =3D 0xff. Then I switched CPU to EL1. =

With that setup no interrupt was delivered to PE. GIC interface showed that=
 non secure IRQ is pending. ICC_PMR read at EL1 returns 0 (shall return val=
ue ((PMR_(el3) << 1) & 0xff) according to GIC specification.
Than I tried to increase interrupt priority mask  - so I set ICC_PMR =3D 0x=
7f (at EL3). Then I read at EL1 ICC_PMR=3D0xfe - (is shall be 0). With this=
 setup IRQ of secure timer was taken at EL3, non secure timer didn't rise I=
RQ (as it is masked by PMR). =

I dig to qemu code and see wrong condition in file arm_gicv3_cpuif.c in fun=
ction  icc_pmr_read(). This behavior is opposite of ARM specification.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1748434

Title:
  Possibly wrong GICv3 behavior when secure enabled

Status in QEMU:
  New

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
