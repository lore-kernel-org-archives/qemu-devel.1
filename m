Received: from eggs.gnu.org ([2001:4830:134:3::10]:52631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eR1oX-00071E-16
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 15:15:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eR1oS-0003mc-Gx
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 15:15:04 -0500
Received: from indium.canonical.com ([91.189.90.7]:59500)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eR1oS-0003mC-A9
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 15:15:00 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eR1oQ-0006Xy-Fr
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 20:14:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 760E72E804E
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 20:14:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 Dec 2017 20:04:35 -0000
From: Benjamin <omega52390@yahoo.com>
Reply-To: Bug 1580459 <1580459@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160511061916.21125.98809.malonedeb@wampee.canonical.com>
Message-Id: <151362747558.19433.15910695202952780964.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1580459] Re: Windows (10?) guest freezes entire
 host on shutdown if using PCI passthrough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I've been experiencing something that sounds very similar to what has
been described in this issue post and want to see if you guys think it's
the same issue. For me from a cold boot everything is fine for a while
and I can restart my vm and such just fine. but after a long time or
stressful stuff mining/gaming if I shutdown my vm the host displays will
all go to sleep and the system locks up which I had been assuming is a
display driver crash. I can also sometimes trigger the exact same lockup
by calling lspci. once such a lockup has happened I have to hard reset.
where this gets even weirder is that after this happens I will get the
same lockup during the startup process around when xorg loads. when this
happens I either have to leave my computer alone for around 30 minutes
to an hour, or I can get it to boot by disabling iommu with iommu=3Doff as
a kernel param, and then if I wait around 30 minutes to an hour I can
restart and it will boot fine again with iommu=3Dpt (I get a kernel panic
if i don't use iommu=3Dpt)

Hardware
Ryzen R5 1600
asrock ab350m pro4
32gb ram
Host gpu RX580
Guest gpu GTX1070

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1580459

Title:
  Windows (10?) guest freezes entire host on shutdown if using PCI
  passthrough

Status in libvirt:
  New
Status in QEMU:
  New
Status in Arch Linux:
  New
Status in Debian:
  New
Status in Fedora:
  New

Bug description:
  Problem: after leaving a Windows VM that uses PCI passthrough (as we
  do for gaming graphics cards, sound cards, and in my case, a USB card)
  running for some amount of time between 1 and 2 hours (it's not
  consistent with exactly how long), and for any amount of time longer
  than that, shutting down that guest will, right as it finishes
  shutting down, freeze the host computer, making it require a hard
  reboot. Unbinding (or in the other user's case, unbinding and THEN
  binding) any PCI device in sysfs, even one that has nothing to do with
  the VM, also has the same effect as shutting down the VM (if the VM
  has been running long enough). So, it's probably an issue related to
  unbinding and binding PCI devices.

  There's a lot of info on this problem over at https://bbs.archlinux.org/v=
iewtopic.php?id=3D206050
  Here's a better-organized list of main details:
  -at least 2 confirmed victims of this bug; 2 (including me) have provided=
 lots of info in the link
  -I'm on Arch Linux and the other one is on Gentoo (distro-nonspecific)
  -issue affects my Windows 10 guest and others' Windows guests, but not my=
 Arch Linux guest (the others don't have non-Windows guests to test)
  -I'm using libvirt but the other user is not, so it's not an issue with l=
ibvirt
  -It seems to be version non-specific, too. I first noticed it at, or when=
 testing versions still had the issue at (whichever version is lower), Linu=
x 4.1 and qemu 2.4.0. It still persists in all releases of both since, incl=
uding the newest ones.
  -I can't track down exactly what package downgrade can fix it, as downgra=
ding further than Linux 4.1 and qemu 2.4.0 requires Herculean and system-de=
stroying changes such as downgrading ncurses, meaning I don't know whether =
it's a bug in QEMU, the Linux kernel, or some weird seemingly unrelated thi=
ng.
  -According to the other user, "graphics intensive gameplay (GTA V) can ca=
use the crash to happen sooner," as soon as "15 minutes"
  -Also, "bringing up a second passthrough VM with separate hardware will c=
ause the same crash," and "bringing up another VM before the two-hour mark =
will not result in a crash," further cementing that it's triggered by the u=
n/binding of PCI devices.
  -This is NOT related to the very similar bug that can be worked around by=
 not passing through the HDMI device or sound card. Even when we removed al=
l traces of any sort of sound card from the VM, it still had the same behav=
ior.

To manage notifications about this bug go to:
https://bugs.launchpad.net/libvirt/+bug/1580459/+subscriptions
