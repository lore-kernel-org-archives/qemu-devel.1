Received: from eggs.gnu.org ([2001:4830:134:3::10]:39616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1casKt-0000Ib-5B
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 18:04:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1casKo-0007tq-8Z
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 18:04:39 -0500
Received: from indium.canonical.com ([91.189.90.7]:52694)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1casKo-0007th-3X
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 18:04:34 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1casKm-0002zo-72
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 23:04:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 22D652E80C6
	for <qemu-devel@nongnu.org>; Mon,  6 Feb 2017 23:04:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Feb 2017 22:52:38 -0000
From: Thomas Huth <808588@bugs.launchpad.net>
Reply-To: Bug 808588 <808588@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110711030201.19964.12865.malonedeb@gac.canonical.com>
Message-Id: <20170206225238.6191.8738.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 808588] Re: Netperf tests cause i82551 network
 down
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The patch mentioned in comment #3 had been included in the kernel here:
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=
=3D7734f6e6bcd7ba78b00e93e74a4ddafd9886cdea
So I guess we can close this bug nowadays? Or can you still reproduce this =
issue with the current kernel and current version of QEMU?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/808588

Title:
  Netperf tests cause i82551 network down

Status in QEMU:
  Incomplete

Bug description:
  1. boot up a guest with 82551 nic
  # qemu-kvm -net nic,model=3Di82551 ...
  2. launch netperf server in the guest
  3.on the host =

  for b in 32 64 128 256 512 1024 1460 2048 4096 8192  9000 16384 32768  65=
495 65507
  do ./netperf -t TCP_STREAM -f m -H <guest ip> -P 0 -l 10 -- -m $b
  done

  for b in 32 64 128 256 512 1024 1460 2048 4096 8192  9000 16384 32768  65=
495 65507
  do ./netperf -t UDP_STREAM -f m -H <guest ip> -P 0 -l 10 -- -m $b
  done

  =

  Result:
  Guest network becomes down

  =

  netperf client output:
  ./netperf -t TCP_STREAM -f m -H 10.66.9.39 -P 0 -l 10 -- -m 32
   87380  16384     32    10.97      19.61
  ./netperf -t TCP_STREAM -f m -H 10.66.9.39 -P 0 -l 10 -- -m 64
   87380  16384     64    11.55      79.68
  ./netperf -t TCP_STREAM -f m -H 10.66.9.39 -P 0 -l 10 -- -m 128
   87380  16384    128    10.16      14.20
  ./netperf -t TCP_STREAM -f m -H 10.66.9.39 -P 0 -l 10 -- -m 256
   87380  16384    256    11.17      12.85
  ./netperf -t TCP_STREAM -f m -H 10.66.9.39 -P 0 -l 10 -- -m 512
   87380  16384    512    10.01      16.38
  ./netperf -t TCP_STREAM -f m -H 10.66.9.39 -P 0 -l 10 -- -m 1024
  Interrupted system call
  netperf: remote error 4./netperf -t TCP_STREAM -f m -H 10.66.9.39 -P 0 -l=
 10 -- -m 1460
  establish control: are you sure there is a netserver listening on 10.66.9=
.39 at port 12865?
  establish_control could not establish the control connection from 0.0.0.0=
 port 0 address family AF_UNSPEC to 10.66.9.39 port 12865 address family AF=
_UNSPEC
  ./netperf -t TCP_STREAM -f m -H 10.66.9.39 -P 0 -l 10 -- -m 2048

  =

  qemu debug message:
  ....
  EE100   nic_receive             command 0x0000, link 0x3d3e6822, addr 0xf=
fffffff, size 1518
  EE100   nic_can_receive         0x29a0180
  EE100   nic_receive             0x29a0180 received broadcast, len=3D60
  EE100   nic_receive             Receive buffer (0 bytes) too small for da=
ta (60 bytes); data truncated
  EE100   nic_receive             command 0x8000, link 0x37b32022, addr 0xf=
fffffff, size 0
                                                   ^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^
  EE100   nic_receive             receive: Running out of frames
                                                   ^^^^^^^^^^^^^^^^^^^^^^^^
  EE100   eepro100_write1         addr=3DCommand/Status+1 val=3D0x20

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/808588/+subscriptions
