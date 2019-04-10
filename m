Received: from eggs.gnu.org ([209.51.188.92]:49577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hECSN-00011X-Ix
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 08:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hECSM-0004hu-3R
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 08:35:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:45304)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hECSL-0004fP-RF
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 08:35:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hECSI-0000wM-LR
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 12:35:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 95A2B2E80C9
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 12:35:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Apr 2019 12:17:12 -0000
From: Thomas Huth <1525676@bugs.launchpad.net>
Reply-To: Bug 1525676 <1525676@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20151213173042.25355.35514.malonedeb@soybean.canonical.com>
Message-Id: <155489863276.21303.3473631160504038546.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1525676] Re: qemu runas and sandbox option
 incompatible, process will hang in futex after setgid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I haven't tried, but I think this should be fixed now with the new
elevateprivileges parameter of the -sandbox option. Have you tried to
reproduce the problem with the latest version of QEMU already?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1525676

Title:
  qemu runas and sandbox option incompatible, process will hang in futex
  after setgid

Status in QEMU:
  Incomplete
Status in qemu package in Ubuntu:
  Incomplete

Bug description:
  With -runas [user] and -sandbox on, qemu process will fail in the
  process of dropping privileges. While setgid() is done (see below),
  setuid() is not attempted. Instead process blocks waiting for a futex
  never to come.

  [pid 21769] +++ killed by SIGSYS +++
  [pid 21767] <... tgkill resumed> )      =3D 0
  [pid 21767] tgkill(21767, 21768, SIGRT_1 <unfinished ...>
  [pid 21768] <... nanosleep resumed> {0, 7284187}) =3D ? ERESTART_RESTARTB=
LOCK (Interrupted by signal)
  [pid 21768] --- SIGRT_1 {si_signo=3DSIGRT_1, si_code=3DSI_TKILL, si_pid=
=3D21767, si_uid=3D0} ---
  [pid 21768] setgid(100)                 =3D 0
  [pid 21768] futex(0x7f7f0f53fd1c, FUTEX_WAKE_PRIVATE, 1) =3D 0
  [pid 21768] rt_sigreturn()              =3D -1 EINTR (Interrupted system =
call)
  [pid 21768] nanosleep({0, 7284187},  <unfinished ...>
  [pid 21767] <... tgkill resumed> )      =3D 0
  [pid 21767] futex(0x7ffd5a9b6890, FUTEX_WAIT_PRIVATE, 3, NULL <unfinished=
 ...>
  [pid 21768] <... nanosleep resumed> 0x7f7f0f53eb00) =3D 0
  [pid 21768] futex(0x55f52acd1f44, FUTEX_WAIT, 4294967295, NULL

  This bug might be addresses in the discussion/patchset
  http://qemu.11.n7.nabble.com/PATCH-Add-syscalls-for-runas-and-chroot-
  to-the-seccomp-sandbox-td359588.html

  # lsb_release -rd
  Description:    Ubuntu 15.10
  Release:        15.10

  # apt-cache policy qemu-system-x86
  qemu-system-x86:
    Installed: 1:2.3+dfsg-5ubuntu9.1
    Candidate: 1:2.3+dfsg-5ubuntu9.1
    Version table:
   *** 1:2.3+dfsg-5ubuntu9.1 0
          500 http://archive.ubuntu.com/ubuntu/ wily-updates/main amd64 Pac=
kages
          500 http://archive.ubuntu.com/ubuntu/ wily-security/main amd64 Pa=
ckages
          100 /var/lib/dpkg/status
       1:2.3+dfsg-5ubuntu9 0
          500 http://archive.ubuntu.com/ubuntu/ wily/main amd64 Packages

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1525676/+subscriptions
