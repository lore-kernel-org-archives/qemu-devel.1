Received: from eggs.gnu.org ([2001:4830:134:3::10]:56958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eAgyn-00071T-VT
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 14:46:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eAgyk-0004B4-TL
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 14:46:10 -0400
Received: from indium.canonical.com ([91.189.90.7]:36056)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eAgyk-0004Al-NQ
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 14:46:06 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eAgyi-0000K7-Dc
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 18:46:04 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 391AB2E822E
	for <qemu-devel@nongnu.org>; Fri,  3 Nov 2017 18:45:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Nov 2017 18:35:35 -0000
From: pgnet <1689367@bugs.launchpad.net>
Reply-To: Bug 1689367 <1689367@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170508175438.13498.58008.malonedeb@chaenomeles.canonical.com>
Message-Id: <150973413579.20841.4819343689338931367.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1689367] Re: In qemu chroot,
 repeating "qemu: Unsupported syscall: 384" messages. sys_getrandom ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

> Can you just run  /usr/bin/qemu-arm-static --version  in the chroot,
please ? (or whatever suse calls its statically linked binary).

Yep, as soon as I'm sitting back in front of the machine with the chroot
on it.  Bit later ...

> The other interesting question is what version of the (host) kernel
headers the QEMU binary was built against -- if that's earlier than 3.17
then the headers won't define __NR_getrandom for the host system and we
won't implement the syscall.

The qemu build uses headers from a repo which tracks Kernel/Stable's
regular releases.  It _currently_ holds kernel 4.13.10.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1689367

Title:
  In qemu chroot, repeating "qemu: Unsupported syscall: 384" messages.
  sys_getrandom ?

Status in QEMU:
  Incomplete

Bug description:
  On exec of an armv7 qemu chroot on my local x86_64 desktop, launched
  via

          /usr/sbin/qemu-binfmt-conf.sh

  from

          qemu-linux-user-2.9.0-374.1.x86_64

  on the host, inside the chroot any compile activity is laced with
  repetitions of

          qemu: Unsupported syscall: 384

  messages.

  This wasn't always the case -- but, TBH, it's been ~ 6 months since I
  used this env, and there have been scads of usual pkg updates in the
  interim.  These messages appear to be non-fatal, with no particular
  effect at all; at least not so far ...

  From a chat in #IRC,

  	[10:05] davidgiluk clever/pgnd: I see it as getrandom
  	[10:05] davidgiluk pgnd: https://fedora.juszkiewicz.com.pl/syscalls.html=
   sort it on the ARM table and you can easily see it
  	[10:05] clever arch/arm/tools/syscall.tbl:384  common  getrandom        =
       sys_getrandom
  	[10:06] davidgiluk pgnd: my *guess* is that something is calling getrand=
om, getting told it's not implemented and then falling back to using /dev/u=
random
  	[10:10] pgnd davidgiluk: If that *is* the case, is it to be considered a=
 problem, or just informational?
  	[10:12] davidgiluk pgnd: As long as it's falling back probably informati=
onal; but someone should probably go and wire up sys_getrandom at some point

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1689367/+subscriptions
