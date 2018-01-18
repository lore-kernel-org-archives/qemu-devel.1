Received: from eggs.gnu.org ([2001:4830:134:3::10]:49207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ec6lc-0002nS-3N
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 04:45:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ec6lZ-0007Oi-F7
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 04:45:52 -0500
Received: from indium.canonical.com ([91.189.90.7]:34996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ec6lZ-0007OO-9J
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 04:45:49 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ec6lX-0008KG-40
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 09:45:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B65A62E857E
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 09:45:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jan 2018 09:39:17 -0000
From: qihaimou <1744009@bugs.launchpad.net>
Reply-To: Bug 1744009 <1744009@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151626726470.4861.474936740354528920.malonedeb@wampee.canonical.com>
Message-Id: <151626835728.10578.12105527491257095329.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1744009] Re: qemu for windows fails to use
 multicast socket as netdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

When I checked the source code, I think the problem is that on Microsoft
Windows bind() can not use a multicast address.

MSDN bind() reference
https://msdn.microsoft.com/en-us/library/windows/desktop/ms737550(v=3Dvs.85=
).aspx
seems to have indicated the point.

I changed the net_socket_mcast_create() in net/socket.c, make it bind to
htonl(INADDR_ANY). After compiling, it seems to work correctly.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1744009

Title:
  qemu for windows fails to use multicast socket as netdev

Status in QEMU:
  New

Bug description:
  My host OS is Windows 7 x64 SP1. I installed qemu for windows from
  https://qemu.weilnetz.de/w64/.The version is 2.10.1,
  qemu-w64-setup-20171006.exe. I run qemu with the following command:

  qemu-system-x86_64.exe -net nic -net socket,mcast=3D234.5.5.5:6000
  disk1.qcow2

  It stopped with error:
  bind: Unknown error
  qemu-system-x86_64.exe: -net socket,mcast=3D234.5.5.5:6000: Device 'socke=
t' could not be initialized

  Using the -netdev option has the same problem:
  qemu-system-x86_64.exe -netdev socket,id=3Dhostnet0,mcast=3D234.5.5.5:600=
0 -device e1000,netdev=3Dhostnet0 disk1.qcow2

  I tried many versions from https://qemu.weilnetz.de/w64/, but none of
  them could work.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1744009/+subscriptions
