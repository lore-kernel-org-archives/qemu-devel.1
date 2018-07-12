Received: from eggs.gnu.org ([2001:4830:134:3::10]:46738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fdhT3-0006W0-4C
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 15:41:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fdhSz-0005ZV-4o
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 15:41:33 -0400
Received: from indium.canonical.com ([91.189.90.7]:50554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fdhSy-0005Xu-TP
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 15:41:29 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fdhSw-00051A-8E
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 19:41:26 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 74E282E818D
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 19:41:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Jul 2018 19:26:01 -0000
From: Ke Liu <1779955@bugs.launchpad.net>
Reply-To: Bug 1779955 <1779955@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153065712229.13372.17157400567540509420.malonedeb@gac.canonical.com>
Message-Id: <153142356117.23539.11996526456841397705.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1779955] Re: qemu linux-user requires read
 permissions on memory passed to syscalls that should only need write access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Thanks Peter for your information.

I was hit by the bug when trying to compile bazel (a build system open-
sourced by Google: https://bazel.build) and the code is at
https://github.com/bazelbuild/bazel/blob/master/third_party/ijar/mapped_fil=
e_unix.cc#L116

Of course I can send PR to fix that in bazel source, but I would say it
is not true that "in practice no guest binaries set up memory that is
only writable and can't be read". It is legitimate requirement and
coding practice.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1779955

Title:
  qemu linux-user requires read permissions on memory passed to syscalls
  that should only need write access

Status in QEMU:
  Confirmed

Bug description:
  When read() function takes an mmap'ed address as output buffer, it
  returns EFAULT. The expected behavior is it should just work.

  The following code works for qemu-system-arm, but not for qemu-arm-
  static.

  QEMU version affected: latest release 2.12.0.

  Steps to reproduce (please substitute /path/to/qemu-arm-static with
  the path of the binary, and /tmp/a.cpp with the example source code
  attached):

  # First register binfmt_misc
  [hidden]$ docker run --rm --privileged multiarch/qemu-user-static:registe=
r --reset

  # Compile the code and run
  [hidden]$ docker run --rm -it -v /tmp/a.cpp:/tmp/a.cpp -v /path/to/qemu-a=
rm-static:/usr/bin/qemu-arm-static arm32v7/ubuntu:18.04 bash -c '{ apt upda=
te -y && apt install -y g++; } >& /dev/null && g++ -std=3Dc++14 /tmp/a.cpp =
-o /tmp/a.out && echo hehe > /tmp/haha.txt && /tmp/a.out'
  ofd=3D3
  ftruncate=3D0
  mmap=3D0xff3f5000
  fd=3D4
  0xff3f5023 -1 14

  The expected result in qemu-system-arm as well as natively on x86_64 host:
  hidden$ ./a.out
  ofd=3D3
  ftruncate=3D0
  mmap=3D0xb6fb7000
  fd=3D4
  0xb6fb7023 5 0

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1779955/+subscriptions
