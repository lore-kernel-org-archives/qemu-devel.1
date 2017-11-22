Received: from eggs.gnu.org ([2001:4830:134:3::10]:33274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eHX9V-0003ta-58
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 10:41:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eHX9R-0004PK-Su
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 10:41:29 -0500
Received: from indium.canonical.com ([91.189.90.7]:33106)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eHX9R-0004OV-Lm
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 10:41:25 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eHX9P-0007nF-JV
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 15:41:23 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 907B62E80CD
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 15:41:23 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Nov 2017 15:26:39 -0000
From: James Cowgill <jcowgill@debian.org>
Reply-To: Bug 1673976 <1673976@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170318142657.21676.52259.malonedeb@chaenomeles.canonical.com>
Message-Id: <151136439958.7769.1815381628972958259.malone@chaenomeles.canonical.com>
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

I think I see the problem. This glibc commit rewrote the posix_spawn implem=
entation on Linux:
https://sourceware.org/git/?p=3Dglibc.git;a=3Dcommit;h=3D9ff72da471a509a8c1=
9791efe469f47fa6977410

It now relies on the exact behavior of clone(CLONE_VM | CLONE_VFORK) - ie:
- That the parent will wait for the child to exec before continuing.
- Writes to memory in the child are later visible in the parent

QEMU emulates this clone using fork() which no longer works properly and
causes the assertion failure.

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
