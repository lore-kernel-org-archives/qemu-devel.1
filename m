Received: from eggs.gnu.org ([2001:4830:134:3::10]:43921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fjxir-0004DT-Tz
	for qemu-devel@nongnu.org; Sun, 29 Jul 2018 22:15:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fjxio-0007go-Lq
	for qemu-devel@nongnu.org; Sun, 29 Jul 2018 22:15:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:43974)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fjxio-0007gT-DA
	for qemu-devel@nongnu.org; Sun, 29 Jul 2018 22:15:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fjxim-0005SO-BD
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 02:15:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 505522E8052
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 02:15:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 30 Jul 2018 02:05:39 -0000
From: umarcor <1783362@bugs.launchpad.net>
Reply-To: Bug 1783362 <1783362@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153244909751.11925.3364609945591086988.malonedeb@gac.canonical.com>
Message-Id: <153291634076.16627.13000337932523048103.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1783362] Re: qemu-user: mmap should return
 failure (MAP_FAILED, -1) instead of success (NULL, 0) when len==0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: New =3D> In Progress

** Changed in: qemu (Ubuntu)
       Status: New =3D> In Progress

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1783362

Title:
  qemu-user: mmap should return failure (MAP_FAILED, -1) instead of
  success (NULL, 0) when len=3D=3D0

Status in QEMU:
  In Progress
Status in qemu package in Ubuntu:
  In Progress

Bug description:
  As shown in https://github.com/beehive-
  lab/mambo/issues/19#issuecomment-407420602, with len=3D=3D0 mmap returns
  success (NULL, 0) instead of failure (MAP_FAILED, -1) in a x86_64 host
  executing a ELF 64-bit LSB executable, ARM aarch64 binary.

  Steps to reproduce the bug:

  - (cross-)compile the attached source file:

  $ aarch64-linux-gnu-gcc -static -std=3Dgnu99 -lpthread test/mmap_qemu.c
  -o mmap_qemu

  - Execute in a x86_64 host with qemu-user and qemu-user-binfmt:

  $ ./mmap_qemu
  alloc: 0
  MAP_FAILED: -1
  errno: 0
  mmap_qemu: test/mmap_qemu.c:15: main: Assertion `alloc =3D=3D MAP_FAILED'=
 failed.
  qemu: uncaught target signal 6 (Aborted) - core dumped
  Aborted (core dumped)

  - Execute in a ARM host without any additional dependecy:

  $ ./mmap_qemu
  alloc: -1
  MAP_FAILED: -1
  errno: 22

  The bug is present in Fedora:

  $ qemu-aarch64 --version
  qemu-aarch64 version 2.11.2(qemu-2.11.2-1.fc28)
  Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
  $ uname -r
  4.17.7-200.fc28.x86_64

  And also in Ubuntu:

  $ qemu-aarch64 --version
  qemu-aarch64 version 2.12.0 (Debian 1:2.12+dfsg-3ubuntu3)
  Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
  $ uname -r
  4.15.0-23-generic

  Possibly related to:

  - https://lists.freebsd.org/pipermail/freebsd-hackers/2009-July/029109.ht=
ml
  - https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=3D203852

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1783362/+subscriptions
