Received: from eggs.gnu.org ([2001:4830:134:3::10]:49737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1drBlF-00041m-LU
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 19:35:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1drBlC-0000fU-Hz
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 19:35:33 -0400
Received: from indium.canonical.com ([91.189.90.7]:52658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1drBlC-0000f6-Bi
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 19:35:30 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1drBlB-0001Cx-95
	for <qemu-devel@nongnu.org>; Sun, 10 Sep 2017 23:35:29 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3D6EC2E8489
	for <qemu-devel@nongnu.org>; Sun, 10 Sep 2017 23:35:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 10 Sep 2017 23:29:24 -0000
From: Zhuowei Zhang <1716292@bugs.launchpad.net>
Reply-To: Bug 1716292 <1716292@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150508616435.31900.3449336177179115668.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1716292] [NEW] User mode emulation returns wrong
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

Public bug reported:

QEMU version: latest master (fcea73709b966a7ded9efa7b106ea50c7fe9025c)
OS version: Ubuntu 14.04.5
Configured with: ../configure --target-list=3Dx86_64-linux-user

QEMU Linux usermode emulation does not handle write() syscalls with zero
length and a null pointer correctly: on Linux this returns 0, but in
emulation this returns -1.

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
Linux zhuowei-tablet 3.13.0-129-generic #178-Ubuntu SMP Fri Aug 11 12:48:20=
 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux
zhuowei@zhuowei-tablet:/tmp$ ./writezerobytes
write returned 0
zhuowei@zhuowei-tablet:/tmp$ /media/zhuowei/redhd/docs/repos/qemu/build4/x8=
6_64-linux-user/qemu-x86_64 ./writezerobytes
write returned -1
zhuowei@zhuowei-tablet:/tmp$ /media/zhuowei/redhd/docs/repos/qemu/build4/x8=
6_64-linux-user/qemu-x86_64 --version
qemu-x86_64 version 2.10.50 (v2.10.0-471-gfcea737-dirty)
Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

** Affects: qemu
     Importance: Undecided
         Status: New

** Description changed:

  QEMU version: latest master (fcea73709b966a7ded9efa7b106ea50c7fe9025c)
- OS version: Ubuntu 14.04.3
+ OS version: Ubuntu 14.04.5
  Configured with: ../configure --target-list=3Dx86_64-linux-user
  =

  QEMU Linux usermode emulation does not handle write() syscalls with zero
  length and a null pointer correctly: on Linux this returns 0, but in
  emulation this returns -1.
  =

  I ran into this while using an aarch64 abuild-tar from Alpine Linux in
  user-mode emulation; here's the minimized reproduction test case:
  =

  zhuowei@zhuowei-tablet:/tmp$ cat writezerobytes.c
  #include <stdio.h>
  #include <unistd.h>
  #include <fcntl.h>
  =

  int main() {
- 	ssize_t ret =3D write(STDOUT_FILENO, NULL, 0);
- 	fprintf(stderr, "write returned %ld\n", ret);
- 	return 0;
+ =C2=A0ssize_t ret =3D write(STDOUT_FILENO, NULL, 0);
+ =C2=A0fprintf(stderr, "write returned %ld\n", ret);
+ =C2=A0return 0;
  }
  zhuowei@zhuowei-tablet:/tmp$ gcc -o writezerobytes writezerobytes.c
  zhuowei@zhuowei-tablet:/tmp$ uname -a
  Linux zhuowei-tablet 3.13.0-129-generic #178-Ubuntu SMP Fri Aug 11 12:48:=
20 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux
- zhuowei@zhuowei-tablet:/tmp$ ./writezerobytes =

- write returned 0        =

+ zhuowei@zhuowei-tablet:/tmp$ ./writezerobytes
+ write returned 0
  zhuowei@zhuowei-tablet:/tmp$ /media/zhuowei/redhd/docs/repos/qemu/build4/=
x86_64-linux-user/qemu-x86_64 ./writezerobytes
  write returned -1
  zhuowei@zhuowei-tablet:/tmp$ /media/zhuowei/redhd/docs/repos/qemu/build4/=
x86_64-linux-user/qemu-x86_64 --version
  qemu-x86_64 version 2.10.50 (v2.10.0-471-gfcea737-dirty)
  Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1716292

Title:
  User mode emulation returns wrong value for write(fd, NULL, 0)

Status in QEMU:
  New

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
