Received: from eggs.gnu.org ([2001:4830:134:3::10]:35320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e4B6a-0005ba-Sl
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 15:31:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e4B6W-0004Ut-MZ
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 15:31:16 -0400
Received: from indium.canonical.com ([91.189.90.7]:43320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e4B6W-0004Tc-Gt
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 15:31:12 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e4B6T-0006CZ-4d
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 19:31:09 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2211C2E80D2
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 19:31:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Oct 2017 19:23:12 -0000
From: Dominique Belhachemi <domibel@debian.org>
Reply-To: Bug 1673976 <1673976@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170318142657.21676.52259.malonedeb@chaenomeles.canonical.com>
Message-Id: <150818179251.22405.2937719550170053465.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1673976] Re: core dump
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

It is possible to reproduce the issue with a simple clone example taken
from

   http://man7.org/linux/man-pages/man2/clone.2.html


# qemu-aarch64-static -strace  ./a.out testname
585 brk(NULL) =3D 0x0000004000013000
585 uname(0x4000812d08) =3D 0
585 faccessat(AT_FDCWD,"/etc/ld.so.nohwcap",F_OK,0x82e888) =3D -1 errno=3D2=
 (No such file or directory)
585 mmap(NULL,12288,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS,-1,0) =
=3D 0x0000004000843000
585 faccessat(AT_FDCWD,"/etc/ld.so.preload",R_OK,AT_SYMLINK_NOFOLLOW|0x82d8=
48) =3D -1 errno=3D2 (No such file or directory)
585 openat(AT_FDCWD,"/etc/ld.so.cache",O_RDONLY|O_CLOEXEC) =3D 3
585 fstat(3,0x0000004000812680) =3D 0
585 mmap(NULL,20645,PROT_READ,MAP_PRIVATE,3,0) =3D 0x0000004000846000
585 close(3) =3D 0
585 faccessat(AT_FDCWD,"/etc/ld.so.nohwcap",F_OK,0x82e888) =3D -1 errno=3D2=
 (No such file or directory)
585 openat(AT_FDCWD,"/lib/aarch64-linux-gnu/libc.so.6",O_RDONLY|O_CLOEXEC) =
=3D 3
585 read(3,0x812830,832) =3D 832
585 fstat(3,0x00000040008126d0) =3D 0
585 mmap(NULL,1393456,PROT_EXEC|PROT_READ,MAP_PRIVATE|MAP_DENYWRITE,3,0) =
=3D 0x000000400084c000
585 mprotect(0x0000004000987000,65536,PROT_NONE) =3D 0
585 mmap(0x0000004000997000,24576,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_DENY=
WRITE|MAP_FIXED,3,0x13b000) =3D 0x0000004000997000
585 mmap(0x000000400099d000,13104,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANON=
YMOUS|MAP_FIXED,-1,0) =3D 0x000000400099d000
585 close(3) =3D 0
585 mprotect(0x0000004000997000,16384,PROT_READ) =3D 0
585 mprotect(0x0000004000011000,4096,PROT_READ) =3D 0
585 mprotect(0x0000004000840000,4096,PROT_READ) =3D 0
585 munmap(0x0000004000846000,20645) =3D 0
585 brk(NULL) =3D 0x0000004000013000
585 brk(0x0000004000034000) =3D 0x0000004000013000
585 mmap(NULL,1048576,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS,-1,0) =
=3D 0x00000040009a1000
585 mmap(NULL,1052672,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS,-1,0) =
=3D 0x0000004000aa1000
585 clone(CLONE_NEWUTS|0x11,child_stack=3D0x0000004000ba1010,parent_tidptr=
=3D0x0000004000aa1010,tls=3D0x0000000000000000,child_tidptr=3D0x00000000000=
00000) =3D -1 errno=3D22 (Invalid argument)
585 dup(2,4222427270,274886578000,22,0,0) =3D 3
585 fcntl(3,F_GETFL) =3D 1026
585 fstat(3,0x0000004000812628) =3D 0
585 write(3,0x9a1490,24)clone: Invalid argument
 =3D 24
585 close(3) =3D 0
585 exit_group(1)


# strace ./a.out testname
qemu: Unsupported syscall: 117
qemu: Unsupported syscall: 117
/usr/bin/strace: ptrace(PTRACE_TRACEME, ...): Function not implemented
+++ exited with 1 +++

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1673976

Title:
  core dump

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
