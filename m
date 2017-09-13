Received: from eggs.gnu.org ([2001:4830:134:3::10]:46731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ds2XW-0000Zu-Fe
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:56:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ds2XU-00065y-Bl
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:56:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:43898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ds2XT-00064O-SI
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:56:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1ds2XS-00048e-74
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 07:56:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 829712E84A7
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 07:56:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 Sep 2017 07:45:38 -0000
From: Thomas Huth <808588@bugs.launchpad.net>
Reply-To: Bug 808588 <808588@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110711030201.19964.12865.malonedeb@gac.canonical.com>
Message-Id: <150528873894.31818.3946146637738497300.malone@soybean.canonical.com>
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

There hasn't been a reply to my question in the last comment within
months, so I assume nobody cares about this anymore. So I'm closing this
ticket now...

** Changed in: qemu
       Status: Incomplete =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/808588

Title:
  Netperf tests cause i82551 network down

Status in QEMU:
  Fix Released

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
