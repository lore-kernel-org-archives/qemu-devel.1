Received: from eggs.gnu.org ([2001:4830:134:3::10]:50894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f3hnJ-0003xJ-Mf
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 08:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f3hnG-00014t-IO
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 08:45:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:35774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f3hnG-00013u-C4
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 08:45:38 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f3hnF-0000GN-CL
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 12:45:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 50C382E805D
	for <qemu-devel@nongnu.org>; Wed,  4 Apr 2018 12:45:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Apr 2018 12:38:33 -0000
From: Matthieu Gautier <1761153@bugs.launchpad.net>
Reply-To: Bug 1761153 <1761153@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152284551397.28710.6742910020765706357.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1761153] [NEW] qemu-user incorrect mmap for large
 files on 64bits host and 32bits executable.
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

qemu-user seems to incorrectly mmap a file if the offset is > 4GiB and
guest binary is 32 bits elf.

See attached test program `test_mmap.c`.

```
$ gcc -g -m32 -march=3Di386 test_mmap.c -o test_mmap
$ file test_mmap
test_mmap: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), dynami=
cally linked, interpreter /lib/ld-linux.so.2, for GNU/Linux 3.2.0, BuildID[=
sha1]=3De36db05f4dfd8a9cfde8a969214a242c1f5a4b49, with debug_info, not stri=
pped
$ uname -a
Linux localhost.localdomain 4.15.10-300.fc27.x86_64 #1 SMP Thu Mar 15 17:13=
:04 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux
$ qemu-i386 --version
qemu-i386 version 2.10.1(qemu-2.10.1-2.fc27)
Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
$ ./test_mmap
$ qemu-i386 test_mmap
Incorrect data 1
```

Tested with qemu-i386 packaged in Fedora 27 and qemu-i386 compiled from
git master (094b62cd9c)

The issue was firstly detected on (more complex program) using qemu-arm
(with 32bits binary) so it is probably a 32/64bits problem independently
of the cpu family.

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "test_mmap.c"
   https://bugs.launchpad.net/bugs/1761153/+attachment/5101253/+files/test_=
mmap.c

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1761153

Title:
  qemu-user incorrect mmap for large files on 64bits host and 32bits
  executable.

Status in QEMU:
  New

Bug description:
  qemu-user seems to incorrectly mmap a file if the offset is > 4GiB and
  guest binary is 32 bits elf.

  See attached test program `test_mmap.c`.

  ```
  $ gcc -g -m32 -march=3Di386 test_mmap.c -o test_mmap
  $ file test_mmap
  test_mmap: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), dyna=
mically linked, interpreter /lib/ld-linux.so.2, for GNU/Linux 3.2.0, BuildI=
D[sha1]=3De36db05f4dfd8a9cfde8a969214a242c1f5a4b49, with debug_info, not st=
ripped
  $ uname -a
  Linux localhost.localdomain 4.15.10-300.fc27.x86_64 #1 SMP Thu Mar 15 17:=
13:04 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux
  $ qemu-i386 --version
  qemu-i386 version 2.10.1(qemu-2.10.1-2.fc27)
  Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
  $ ./test_mmap
  $ qemu-i386 test_mmap
  Incorrect data 1
  ```

  Tested with qemu-i386 packaged in Fedora 27 and qemu-i386 compiled
  from git master (094b62cd9c)

  The issue was firstly detected on (more complex program) using qemu-
  arm (with 32bits binary) so it is probably a 32/64bits problem
  independently of the cpu family.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1761153/+subscriptions
