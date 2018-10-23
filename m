Received: from eggs.gnu.org ([2001:4830:134:3::10]:39781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gF5zB-0005G6-NS
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 19:21:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gF5z7-0002YM-EX
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 19:21:17 -0400
Received: from indium.canonical.com ([91.189.90.7]:42418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gF5z7-0002Tu-6X
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 19:21:13 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gF5z3-0006GO-Rb
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 23:21:10 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 769192E8241
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 23:20:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Oct 2018 23:11:48 -0000
From: Roman Bolshakov <1798451@bugs.launchpad.net>
Reply-To: Bug 1798451 <1798451@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153980387714.3465.12419240219281347614.malonedeb@soybean.canonical.com>
Message-Id: <154033630894.29002.18383873182871790494.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1798451] Re: HVF linux on OSX hangs 2nd time
 started after adding socket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Considering the fact that both Ubuntu and Elementary require SSE to
boot, I'd wait to get decoding fixed. I wrote a test kernel module that
reliably reproduces your issue on qemu edu device. Whenever QEMU prints
Unimplemented handler Instruction pointer only moves two bytes further,
instead of the instruction length. That corrupts code execution as the
next instruction after unimplemented handler is decoded from the wrong
address.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1798451

Title:
  HVF linux on OSX hangs 2nd time started after adding socket

Status in QEMU:
  New

Bug description:
  =

  Robs-MacBook-Pro-2:~ robmaskell$ qemu-system-x86_64 --version
  QEMU emulator version 3.0.0

  Host: MacOS - 10.13.6
    Model Name:	MacBook Pro
    Model Identifier:	MacBookPro14,3
    Processor Name:	Intel Core i7
    Processor Speed:	2.8 GHz
    Number of Processors:	1
    Total Number of Cores:	4
    L2 Cache (per Core):	256 KB
    L3 Cache:	6 MB
    Memory:	16 GB

  Guest OS: Elementary Linux Loki 0.4.1, patched up to date

  Command used to start QEMU:

  qemu-system-x86_64 \
    -name ElementaryLokiDev \
    -machine pc,accel=3Dhvf \
    -cpu max \
    -smp cpus=3D2,sockets=3D2,cores=3D1,threads=3D1,maxcpus=3D2 \
    -numa node,nodeid=3D0 \
    -numa cpu,node-id=3D0,socket-id=3D0 -numa cpu,node-id=3D0,socket-id=3D1=
 \
    -m 8G \
    -vga vmware \
    -hda e4.qcow2

  Symptoms: Started without the -smp / -numa commands to install the OS,
  then added -smp / -numa and the machine boots and lscpu reports extra
  cpu as expected. Restart VM and it hangs on startup. Remove -smp /
  -numa and machine starts again.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1798451/+subscriptions
