Received: from eggs.gnu.org ([2001:4830:134:3::10]:41291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1g83ah-0003Cp-Nv
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:22:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1g83Ll-0004AN-MI
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:07:35 -0400
Received: from indium.canonical.com ([91.189.90.7]:36848)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1g83Lg-0003v4-NW
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:07:28 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1g83LW-0000uc-CO
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 13:07:14 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E96F82E81D9
	for <qemu-devel@nongnu.org>; Thu,  4 Oct 2018 13:07:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Oct 2018 12:37:24 -0000
From: Thomas Huth <1716292@bugs.launchpad.net>
Reply-To: Bug 1716292 <1716292@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150508616435.31900.3449336177179115668.malonedeb@soybean.canonical.com>
Message-Id: <153865664486.22456.15544683485044830416.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1716292] Re: User mode emulation returns wrong
 value for write(fd, NULL, 0)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Fix has been committed here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D58cfa6c2e6eb51b23cc98

** Changed in: qemu
       Status: New =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1716292

Title:
  User mode emulation returns wrong value for write(fd, NULL, 0)

Status in QEMU:
  Fix Committed

Bug description:
  QEMU version: latest master (fcea73709b966a7ded9efa7b106ea50c7fe9025c)
  OS version: Ubuntu 14.04.5
  Configured with: ../configure --target-list=3Dx86_64-linux-user

  QEMU Linux usermode emulation does not handle write() syscalls with
  zero length and a null pointer correctly: on Linux this returns 0, but
  in emulation this returns -1.

  I ran into this while using an aarch64 abuild-tar from Alpine Linux in
  user-mode emulation; here's the minimized reproduction test case:

  zhuowei@zhuowei-tablet:/tmp$ cat writezerobytes.c
  #include <stdio.h>
  #include <unistd.h>
  #include <fcntl.h>

  int main() {
  =C2=A0ssize_t ret =3D write(STDOUT_FILENO, NULL, 0);
  =C2=A0fprintf(stderr, "write returned %ld\n", ret);
  =C2=A0return 0;
  }
  zhuowei@zhuowei-tablet:/tmp$ gcc -o writezerobytes writezerobytes.c
  zhuowei@zhuowei-tablet:/tmp$ uname -a
  Linux zhuowei-tablet 3.13.0-129-generic #178-Ubuntu SMP Fri Aug 11 12:48:=
20 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux
  zhuowei@zhuowei-tablet:/tmp$ ./writezerobytes
  write returned 0
  zhuowei@zhuowei-tablet:/tmp$ /media/zhuowei/redhd/docs/repos/qemu/build4/=
x86_64-linux-user/qemu-x86_64 ./writezerobytes
  write returned -1
  zhuowei@zhuowei-tablet:/tmp$ /media/zhuowei/redhd/docs/repos/qemu/build4/=
x86_64-linux-user/qemu-x86_64 --version
  qemu-x86_64 version 2.10.50 (v2.10.0-471-gfcea737-dirty)
  Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1716292/+subscriptions
