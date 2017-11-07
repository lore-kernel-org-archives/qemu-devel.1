Received: from eggs.gnu.org ([2001:4830:134:3::10]:47008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eC604-0005I0-5m
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:41:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eC5zz-0003aU-5l
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:41:16 -0500
Received: from indium.canonical.com ([91.189.90.7]:33424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eC5zy-0003ZS-VH
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:41:11 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eC5zx-00009g-I3
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 15:41:09 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7334F2E80CD
	for <qemu-devel@nongnu.org>; Tue,  7 Nov 2017 15:41:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Nov 2017 15:30:52 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1673976 <1673976@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170318142657.21676.52259.malonedeb@chaenomeles.canonical.com>
Message-Id: <151006865268.9047.4727090632573580550.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1673976] Re: locale-gen dumps core run under
 arm-linux-user on x86-64 host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This happens because QEMU is now stricter about its checking of the
flags passed to clone() -- previously we would silently allow flags we
couldn't support and create new threads with the wrong behaviour. Now we
check and fail the clone() syscall if the requested behaviour is
something we can't implement. Unfortunately we don't have any way to
distinguish "guest program is asking for something odd that it doesn't
really need" from "guest program is asking for something odd that it
does need". So we err on the safe side and tell the guest we can't do
it.

It's particularly unfortunate that the glibc implementation of
posix_spawn() runs into this, though.


** Summary changed:

- locale-gen dumps core run under arm-linux-user on x86-64 host
+ linux-user clone() can't handle glibc posix_spawn() (causes locale-gen to=
 assert)

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
