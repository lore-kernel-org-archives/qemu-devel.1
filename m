Received: from eggs.gnu.org ([2001:4830:134:3::10]:34125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eqmqV-00072l-4Q
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 16:31:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eqmqP-0001Qf-7B
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 16:31:35 -0500
Received: from indium.canonical.com ([91.189.90.7]:54170)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eqmqP-0001QT-18
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 16:31:29 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eqmqM-0003MW-11
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 21:31:26 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9CA632E820A
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 21:31:15 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Feb 2018 21:19:30 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1673976 <1673976@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170318142657.21676.52259.malonedeb@chaenomeles.canonical.com>
Message-Id: <151976637087.6138.134803498427786681.malone@soybean.canonical.com>
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

That glibc change has caused the assert to go away, but QEMU's
spawn(CLONE_VFORK) still does not have the "always waits for child"
semantics that glibc has assumed since glibc commit 4b4d4056bb154. The
child and the parent will end up racing each other, and the child will
never be able to write to the parent's address space. I think that the
effect of that race will be that if the child fails (for instance if a
bad filename is passed and exec() fails) the parent will never notice
and will return a success code from the spawn function when it should
not.

So there remains a QEMU bug here; though it is also the case that I
can't see any way we can fix it.

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
