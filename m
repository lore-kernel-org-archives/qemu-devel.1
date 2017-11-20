Received: from eggs.gnu.org ([2001:4830:134:3::10]:40831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eGr9u-0002hH-Qe
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 13:51:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eGr9r-0007eB-HR
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 13:51:06 -0500
Received: from indium.canonical.com ([91.189.90.7]:38166)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eGr9r-0007dD-Az
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 13:51:03 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eGr9p-0004hZ-MD
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 18:51:01 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8D8D22E80D2
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 18:51:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Nov 2017 18:36:40 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1673976 <1673976@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170318142657.21676.52259.malonedeb@chaenomeles.canonical.com>
Message-Id: <151120300007.28762.2157378064855965898.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1673976] Re: linux-user clone() can't handle
 glibc posix_spawn() (causes locale-gen to assert)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

OK, this can't be as simple as "posix_spawn() fails", because I've just
tried the test program from the posix_spawn manpage
(http://man7.org/linux/man-pages/man3/posix_spawn.3.html) and that works
fine for x86-64 guest, aarch64 guest and armhf guest. In the x86 and
armhf cases the libc I have seems to use the NR_vfork syscall, but for
aarch64 it uses clone(CLONE_VM | CLONE_VFORK | SIGCHLD, ...) which is
what the glibc sources linked in comment #5 do, and that all works fine.

And locale-gen runs fine for my xenial-armhf chroot using current head-
of-git QEMU:

root@e104462:/# locale-gen   =

Generating locales (this might take a while)...
  en_GB.UTF-8... done
Generation complete.

So can I ask that people: (1) please try with current head of git (or
with 2.11-rc1, which is almost the same thing); (2) if there's still a
problem with localegen or with programs calling posix_spawn() or other
real-world code, please provide full repro instructions so I can try to
reproduce locally.

I don't think we can make clone() in general work, so oddball demo code
like the example program in the clone(2) manpage is out of scope, but
there may well be specific cases we can address.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1673976

Title:
  linux-user clone() can't handle glibc posix_spawn() (causes locale-gen
  to assert)

Status in QEMU:
  New

Bug description:
  I'm running a command (locale-gen) inside of an armv7h chroot mounted
  on my x86_64 desktop by putting qemu-arm-static into /usr/bin/ of the
  chroot file system and I get a core dump.

  locale-gen
  Generating locales...
  =C2=A0=C2=A0en_US.UTF-8...localedef: ../sysdeps/unix/sysv/linux/spawni.c:=
360: __spawnix: Assertion `ec >=3D 0' failed.
  qemu: uncaught target signal 6 (Aborted) - core dumped
  /usr/bin/locale-gen: line 41:    34 Aborted                 (core dumped)=
 localedef -i $input -c -f $charset -A /usr/share/locale/locale.alias $loca=
le

  I've done this same thing successfully for years, but this breakage
  has appeared some time in the last 3 or so months. Possibly with the
  update to qemu version 2.8.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1673976/+subscriptions
