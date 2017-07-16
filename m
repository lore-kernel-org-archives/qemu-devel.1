Received: from eggs.gnu.org ([2001:4830:134:3::10]:60295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dWmRi-0003W1-Iq
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 12:31:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dWmRf-00068p-Ep
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 12:31:02 -0400
Received: from indium.canonical.com ([91.189.90.7]:35464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dWmRf-000683-8u
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 12:30:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dWmRe-00049X-2k
	for <qemu-devel@nongnu.org>; Sun, 16 Jul 2017 16:30:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0CB822E8195
	for <qemu-devel@nongnu.org>; Sun, 16 Jul 2017 16:30:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Jul 2017 16:23:14 -0000
From: Bruno Haible <bruno@clisp.org>
Reply-To: Bug 1704658 <1704658@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150022185647.5906.17655055691802268187.malonedeb@gac.canonical.com>
Message-Id: <150022219457.6469.8920259422420791099.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1704658] Re: O_CLOEXEC not handled in dup3 system
 call in user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I see this bug for hppa, sparc64.
I don't see it for m68k, mips, mips64, powerpc, powerpc64.
Most likely because the binary values of O_CLOEXEC on hppa and sparc64 are =
different than on other platforms. Looking in the glibc source code:

$ grep -r 'define.*O_CLOEXEC' glibc
glibc/bits/fcntl.h:# define O_CLOEXEC   0x00400000      /* Set close_on_exe=
c.  */
glibc/sysdeps/mach/hurd/bits/fcntl.h:# define O_CLOEXEC 0x00400000 /* Set F=
D_CLOEXEC.  */
glibc/sysdeps/unix/sysv/linux/sparc/bits/fcntl.h:#define __O_CLOEXEC    0x4=
00000 /* Set close_on_exit.  */
glibc/sysdeps/unix/sysv/linux/bits/fcntl-linux.h:# define __O_CLOEXEC   020=
00000
glibc/sysdeps/unix/sysv/linux/bits/fcntl-linux.h:# define O_CLOEXEC     __O=
_CLOEXEC     /* Set close_on_exec.  */
glibc/sysdeps/unix/sysv/linux/hppa/bits/fcntl.h:#define __O_CLOEXEC     010=
000000 /* Set close_on_exec.  */
glibc/sysdeps/unix/sysv/linux/microblaze/bits/fcntl.h:#define __O_CLOEXEC  =
      02000000       /* Set close_on_exec.  */
glibc/sysdeps/unix/sysv/linux/alpha/bits/fcntl.h:#define __O_CLOEXEC    010=
000000 /* Set close_on_exec.  */
glibc/sysdeps/nacl/bits/fcntl.h:# define O_CLOEXEC      02000000        /* =
Set close_on_exec.  */

So, what's missing is probably that the O_CLOEXEC of the target platform
gets mapped to O_CLOEXEC of the host platform, during the dup3 system
call emulation.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1704658

Title:
  O_CLOEXEC not handled in dup3 system call in user mode

Status in QEMU:
  New

Bug description:
  In qemu user mode, for hppa and sparc64 targets, the parameter of the
  dup3 is not passed correctly when it contains the O_CLOEXEC flag.

  When the attached program runs, the expected output is:
  errno=3D9=3DEBADF

  How to reproduce on hppa:
  - Compile the program: hppa-linux-gnu-gcc-5 -O -Wall -static testdup3.c -=
o testdup3-hppa
  - Set environment variables for running qemu-hppa.
  - ~/inst-qemu/2.9.0/bin/qemu-hppa testdup3-hppa
  errno=3D22=3DEINVAL
  testdup3.c:54: assertion 'errno =3D=3D EBADF' failed

  How to reproduce on sparc64:
  - Compile the program: sparc64-linux-gnu-gcc-5 -O -Wall -static testdup3.=
c -o testdup3-sparc64
  - Set environment variables for running qemu-sparc64.
  - ~/inst-qemu/2.9.0/bin/qemu-sparc64 testdup3-sparc64
  errno=3D22=3DEINVAL
  testdup3.c:54: assertion 'errno =3D=3D EBADF' failed

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1704658/+subscriptions
