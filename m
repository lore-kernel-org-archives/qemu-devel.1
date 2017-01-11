Received: from eggs.gnu.org ([2001:4830:134:3::10]:40542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRQJf-0001Ys-Ms
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 16:20:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRQJb-00016N-H1
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 16:20:19 -0500
Received: from indium.canonical.com ([91.189.90.7]:45192)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cRQJb-000166-BM
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 16:20:15 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cRQJZ-0002RV-KB
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 21:20:13 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2F4702E80CB
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 21:20:13 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Jan 2017 21:00:49 -0000
From: Thomas Huth <1404690@bugs.launchpad.net>
Reply-To: Bug 1404690 <1404690@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20141221162142.24873.23893.malonedeb@wampee.canonical.com>
Message-Id: <20170111210049.26738.71739.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1404690] Re: Qemu crashes with chrooted m68k
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Peter's patch had been included here:
http://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D1669add752d9f2928
=3D=3D> Fix released

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1404690

Title:
  Qemu crashes with chrooted m68k

Status in QEMU:
  Fix Released

Bug description:
  I'm using qemu-m68k 2.2.0 to chroot into a m68k coldfire linux, which
  works fine on the coldfire machine.

  I've been able to use binfmt_msc and used the above code to use qemu
  with strace:

  #include <unistd.h>
  #include <string.h>

  int main(int argc, char **argv, char **envp) {
          char *newargv[argc + 4];

          newargv[0] =3D argv[0];
          newargv[1] =3D "-cpu";
          newargv[2] =3D "cfv4e";
          newargv[3] =3D "-strace";

          memcpy(&newargv[4], &argv[1], sizeof(*argv) * (argc - 1));
          newargv[argc + 3] =3D NULL;
          return execve("/usr/bin/qemu-m68k", newargv, envp);
  }

  Everything works fine. I can run bash, busybox, ash, but when I try to
  run a ls or just type an invalid command, I got the attached sequence
  of messages, which end like so:

  11351 waitpid(-1,0xf6fffa00,0x3) =3D -1 errno=3D10 (No child processes)
  qemu: fatal: Illegal instruction: 0000 @ f6fffa30
  D0 =3D ffffffff   A0 =3D f67dcf50   F0 =3D 0000000000000000 (           0)
  D1 =3D 0000000a   A1 =3D f66e0898   F1 =3D 0000000000000000 (           0)
  D2 =3D f6fffaa8   A2 =3D f67df268   F2 =3D 0000000000000000 (           0)
  D3 =3D 00000000   A3 =3D 00000000   F3 =3D 0000000000000000 (           0)
  D4 =3D 00000008   A4 =3D 800026c4   F4 =3D 0000000000000000 (           0)
  D5 =3D 00000000   A5 =3D f67d98e0   F5 =3D 0000000000000000 (           0)
  D6 =3D f6fffaa8   A6 =3D f6fffa7c   F6 =3D 0000000000000000 (           0)
  D7 =3D 00000002   A7 =3D f6fffa24   F7 =3D 0000000000000000 (           0)
  PC =3D f6fffa30   SR =3D 0000 ----- FPRESULT =3D            0
  Aborted

  How can I debug it further to try to figure out if this is a qemu
  issue or not? Thanks

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1404690/+subscriptions
