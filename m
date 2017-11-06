Received: from eggs.gnu.org ([2001:4830:134:3::10]:39143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eBnQJ-0000Bq-MP
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:51:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eBnQE-0004sb-S4
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:51:07 -0500
Received: from indium.canonical.com ([91.189.90.7]:50674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eBnQE-0004rW-Lm
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:51:02 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eBnQB-0002OV-GF
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 19:50:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D901D2E80CF
	for <qemu-devel@nongnu.org>; Mon,  6 Nov 2017 19:50:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Nov 2017 19:36:47 -0000
From: =?utf-8?q?W=C3=BCstengecko?= <1728256@bugs.launchpad.net>
Reply-To: Bug 1728256 <1728256@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150920686502.20214.12572544661418580428.malonedeb@soybean.canonical.com>
Message-Id: <150999700784.4047.12878586140882436918.malone@gac.canonical.com>
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

Unfortunately I have bad news, but I also have (kind of) good news.
Bad news is, 2.9 is NOT stable, contrary to what I believed earlier.
Good news is, I found a correlation between the crashes and converting larg=
e video files on an SMB share with ffmpeg, so effectively copying slowly wi=
th simultaneously high CPU load. In that constellation it crashed a few tim=
es after just hours (instead of days sometimes). I suspect it might be a ne=
twork related issue. I am now testing the different virtual network hardwar=
e that qemu supports (which proved to be difficult due to lack of driver su=
pport in Windows).

On that note, I remember right after setting up the VM I had some
strange networking related hangup issues with the rtl8139 virtual
adapter - the default -, where the VM would slowly grind to a complete
halt over a few seconds when I started a very network-heavy task (like
copying something from the host via SMB into the VM). I could prevent
the hang when I paused the copying for a few seconds. At that time I
assumed it was the hardware registering as 100Mbps adapter, but the
actual load being about 4 times that on average (during copying of
course), with peaks significantly higher (about 15-20 times). That issue
completely went away after switching the virtual network hardware to
virtio (which registers as 10Gbps adapter), and I considered that case
closed.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1728256

Title:
  (Regression) Memory corruption in Windows 10 guest / amd64

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
