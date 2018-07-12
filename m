Received: from eggs.gnu.org ([2001:4830:134:3::10]:60761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fdiEc-0008L5-EI
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 16:30:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fdiEX-0001kI-62
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 16:30:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:40662)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fdiEW-0001j2-J3
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 16:30:37 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fdiEV-0005Ja-B8
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 20:30:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4F1F72E8019
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 20:30:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Jul 2018 20:24:17 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1779955 <1779955@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153065712229.13372.17157400567540509420.malonedeb@gac.canonical.com>
Message-Id: <153142705736.23616.14705020349449635933.malone@chaenomeles.canonical.com>
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

Oh, yes, I see -- it's mmapping the file specifically in order to write
the data to the file system. Yes, I agree that's a reasonable thing to
do.

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
