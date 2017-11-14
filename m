Received: from eggs.gnu.org ([2001:4830:134:3::10]:44688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eEiFQ-00077z-Bb
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 15:55:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eEiFL-0001IO-Hw
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 15:55:56 -0500
Received: from indium.canonical.com ([91.189.90.7]:35154)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eEiFL-0001HO-BK
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 15:55:51 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eEiFI-0006KX-NS
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 20:55:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2A0882E80DC
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 20:55:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Nov 2017 20:47:30 -0000
From: =?utf-8?q?W=C3=BCstengecko?= <1728256@bugs.launchpad.net>
Reply-To: Bug 1728256 <1728256@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150920686502.20214.12572544661418580428.malonedeb@soybean.canonical.com>
Message-Id: <151069245104.1570.11113743350297474816.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1728256] Re: (Regression) Memory corruption in
 Windows 10 guest / amd64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

It happened again, both with the e1000 and the rtl8139 NICs under qemu
2.11.0.rc0-7-g4ffa88c99c. Kernel is the official Arch one, right now on
4.13.12.

At this point I have no idea anymore what could be causing this, and am
unable to test without having to remove basic functionality from the VM
(e.g. the graphics card) or downgrading the host kernel (which I really
want to avoid because I'm using btrfs).

That said, during the last several days I did not experience these weird
hangup issues that I described previously, however I did see very high
CPU load in the guest that was caused by the network (listed in task
manager as System Interrupts, and going as high as one full CPU core
during large network operations).

What is most interesting though is that it survived while I tried my
best to get it to crash (stress-testing CPU and network, mostly), and
then hit me with a Bluescreen in a most unexpected time almost a week
later. Since then however it started crashing anywhere between a few
hours and about two days of consecutive uptime again, just like before.

@larsk, could you elaborate on your setup? Like, in which ways is it differ=
ent (other than you using Ubuntu and thus different versions of the involve=
d software)?
Which hardware do you pass through, if any?

** Summary changed:

- (Regression) Memory corruption in Windows 10 guest / amd64
+ Memory corruption in Windows 10 guest / amd64

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1728256

Title:
  Memory corruption in Windows 10 guest / amd64

Status in QEMU:
  New

Bug description:
  I have a Win 10 Pro x64 guest inside a qemu/kvm running on an Arch x86_64=
 host. The VM has a physical GPU passed through, as well as the physical US=
B controllers, as well as a dedicated SSD attached via SATA; you can find t=
he complete libvirt xml here: https://pastebin.com/U1ZAXBNg
  I built qemu from source using the qemu-minimal-git AUR package; you can =
find the build script here: https://aur.archlinux.org/cgit/aur.git/tree/PKG=
BUILD?h=3Dqemu-minimal-git (if you aren't familiar with Arch, this is essen=
tially a bash script where build() and package() are run to build the files=
, and then install them into the $pkgdir to later tar them up.)

  Starting with qemu v2.10.0, Windows crashes randomly with a bluescreen
  about CRITICAL_STRUCTURE_CORRUPTION. I also tested the git heads
  f90ea7ba7c, 861cd431c9 and e822e81e35, before I went back to v2.9.0,
  which is running stable for over 50 hours right now.

  During my tests I found that locking the memory pages alleviates the
  problem somewhat, but never completely avoids it. However, with the
  crashes occuring randomly, that could as well be false conclusions; I
  had crashes within minutes after boot with that too.

  I will now start `git bisect`ing; if you have any other suggestions on
  what I could try or possible patches feel free to leave them with me.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1728256/+subscriptions
