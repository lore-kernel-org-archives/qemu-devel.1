Received: from eggs.gnu.org ([2001:4830:134:3::10]:36813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1g9dQF-0006tN-CB
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 17:50:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1g9dQC-0000Py-4y
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 17:50:39 -0400
Received: from indium.canonical.com ([91.189.90.7]:56542)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1g9dQB-0000Pf-Ta
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 17:50:36 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1g9dQA-0006zT-Rv
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 21:50:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id AE55F2E80C9
	for <qemu-devel@nongnu.org>; Mon,  8 Oct 2018 21:50:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Oct 2018 21:43:17 -0000
From: Ke Liu <1796754@bugs.launchpad.net>
Reply-To: Bug 1796754 <1796754@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153902784309.8245.8166003544722634075.malonedeb@soybean.canonical.com>
Message-Id: <153903499788.12323.5168552902265405655.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1796754] Re: ioctl SIOCGIFCONF causes
 qemu-aarch64-static to crash with "received signal outside vCPU context"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I was hit by this issue when I tried to run some Java program. And it
turns out jdk sets the buf to NULL:
http://hg.openjdk.java.net/jdk7/jdk7/jdk/file/887e525597f8/src/solaris/nati=
ve/java/net/NetworkInterface.c#l1042

Setting to NULL is valid according to http://man7.org/linux/man-
pages/man7/netdevice.7.html

But qemu doesn=E2=80=99t handle the case:
https://github.com/qemu/qemu/blob/aa8e26de9617756febcbf794dda965df307fdaaa
/linux-user/syscall.c#L4105

I guess qemu developers didn=E2=80=99t handle the case because the Linux ke=
rnel
changed and they were based on behavior of old version:
https://linux.die.net/man/7/netdevice

Please add the support for it otherwise a wide range of network related
Java programs won=E2=80=99t run.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1796754

Title:
  ioctl SIOCGIFCONF causes qemu-aarch64-static to crash with "received
  signal outside vCPU context"

Status in QEMU:
  New

Bug description:
  To reproduce it, compile the attached crash.c under aarch64 to a.out and =
execute on x86_64
  qemu-aarch64-static ./a.out

  It will print the following and crash:

  socket=3D3
  qemu:handle_cpu_signal received signal outside vCPU context @ pc=3D0x6003=
8cd6
  qemu:handle_cpu_signal received signal outside vCPU context @ pc=3D0x6000=
157a

  The version of qemu-aarch64-static is

  qemu-aarch64 version 3.0.0 (qemu-3.0.0-1.fc29)
  Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

  But it did also happen in previous versions so it is not a regression
  but a bug existed ever since.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1796754/+subscriptions
