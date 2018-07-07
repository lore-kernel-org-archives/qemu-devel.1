Received: from eggs.gnu.org ([2001:4830:134:3::10]:52273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fberj-0004tS-6d
	for qemu-devel@nongnu.org; Sat, 07 Jul 2018 00:30:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fberh-0006K9-Km
	for qemu-devel@nongnu.org; Sat, 07 Jul 2018 00:30:35 -0400
Received: from indium.canonical.com ([91.189.90.7]:47382)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fberh-0006Jm-Ab
	for qemu-devel@nongnu.org; Sat, 07 Jul 2018 00:30:33 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fberg-0006AH-Fp
	for <qemu-devel@nongnu.org>; Sat, 07 Jul 2018 04:30:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7494F2E8197
	for <qemu-devel@nongnu.org>; Sat,  7 Jul 2018 04:30:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Jul 2018 04:17:44 -0000
From: Launchpad Bug Tracker <1405385@bugs.launchpad.net>
Reply-To: Bug 1405385 <1405385@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20141224102108.30804.4332.malonedeb@chaenomeles.canonical.com>
Message-Id: <153093706457.30384.10743917142286854065.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1405385] Re: QEMU crashes when virtio network
 cards are used together with e1000 network cards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1405385

Title:
  QEMU crashes when virtio network cards are used together with e1000
  network cards

Status in QEMU:
  Expired

Bug description:
  QEMU version: QEMU emulator version 2.2.50, Copyright (c) 2003-2008 Fabri=
ce Bellard
  QEMU GIT version: ab0302ee764fd702465aef6d88612cdff4302809
  Configure flags: ./configure --enable-kvm --prefix=3D/opt/qemu-devel
  Linux version: Ubuntu 14.04.1 LTS
  Kernel version: 3.13.0-43-generic #72-Ubuntu SMP Mon Dec 8 19:35:06 UTC 2=
014 x86_64 x86_64 x86_64 GNU/Linux

  Problem:

          QEMU crashes when using one (or more) virtio network cards
  together with one (or more) e1000 (and possibly others) network cards
  when those cards are bound to a linux bridge. When the cards are *not*
  bound to a bridge QEMU does not crash.

  Bridge configuration:

  	iface bridge0 inet dhcp
  	bridge_ports eth1
  	bridge_stp off
  	bridge_fd 0

  Start-up command (including binding the network cards to the bridge +
  strace logging):

  ./qemu-system-x86_64 -daemonize -smp 1 -m 128 -vnc 0.0.0.0:0 \
  -netdev tap,id=3Dtap_1,script=3Dno,downscript=3Dno,ifname=3Dnet_1_1,vhost=
=3Don \
  -device virtio-net-pci,bootindex=3D1,id=3Dnic_1,netdev=3Dtap_1,mac=3D02:1=
6:3F:00:00:FA \
  -netdev tap,id=3Dtap_2,script=3Dno,downscript=3Dno,ifname=3Dnet_1_2 \
  -device e1000,bootindex=3D2,id=3Dnic_2,netdev=3Dtap_2,mac=3D02:16:3F:00:0=
0:FB; \
  brctl addif bridge0 net_1_1; \
  brctl addif bridge0 net_1_2; \
  ifconfig net_1_1 0.0.0.0 up; \
  ifconfig net_1_2 0.0.0.0 up; \
  sleep 2; \
  strace -p `ps x |grep qemu-system-x86_64 |grep -v grep|awk '{print $1}'` =
-o /tmp/qemu-devel-trace.txt =


  Kernel log:

  Dec 24 11:12:08 bramws kernel: [12466.885581] device net_1_1 entered prom=
iscuous mode
  Dec 24 11:12:08 bramws kernel: [12466.886238] device net_1_2 entered prom=
iscuous mode
  Dec 24 11:12:08 bramws kernel: [12466.887084] bridge0: port 2(net_1_1) en=
tered forwarding state
  Dec 24 11:12:08 bramws kernel: [12466.887089] bridge0: port 2(net_1_1) en=
tered forwarding state
  Dec 24 11:12:08 bramws kernel: [12466.888940] bridge0: port 3(net_1_2) en=
tered forwarding state
  Dec 24 11:12:08 bramws kernel: [12466.888947] bridge0: port 3(net_1_2) en=
tered forwarding state
  Dec 24 11:12:29 bramws kernel: [12488.026376] bridge0: port 2(net_1_1) en=
tered disabled state
  Dec 24 11:12:29 bramws kernel: [12488.026820] device net_1_1 left promisc=
uous mode
  Dec 24 11:12:29 bramws kernel: [12488.026832] bridge0: port 2(net_1_1) en=
tered disabled state
  Dec 24 11:12:29 bramws kernel: [12488.049636] bridge0: port 3(net_1_2) en=
tered disabled state
  Dec 24 11:12:29 bramws kernel: [12488.050058] device net_1_2 left promisc=
uous mode
  Dec 24 11:12:29 bramws kernel: [12488.050074] bridge0: port 3(net_1_2) en=
tered disabled state

  Strace log: (full log attached)

  ppoll([{fd=3D13, events=3DPOLLIN|POLLERR|POLLHUP}, {fd=3D7, events=3DPOLL=
IN|POLLERR|POLLHUP}, {fd=3D12, events=3DPOLLIN|POLLERR|POLLHUP}, {fd=3D3, e=
vents=3DPOLLIN|POLLERR|POLLHUP}, {fd=3D6, events=3DPOLLIN}, {fd=3D5, events=
=3DPOLLIN}], 6, {0, 28646613}, NULL, 8) =3D 0 (Timeout)
  write(5, "\1\0\0\0\0\0\0\0", 8)         =3D 8
  ppoll([{fd=3D13, events=3DPOLLIN|POLLERR|POLLHUP}, {fd=3D7, events=3DPOLL=
IN|POLLERR|POLLHUP}, {fd=3D12, events=3DPOLLIN|POLLERR|POLLHUP}, {fd=3D3, e=
vents=3DPOLLIN|POLLERR|POLLHUP}, {fd=3D6, events=3DPOLLIN}, {fd=3D5, events=
=3DPOLLIN}], 6, {0, 10899760}, NULL, 8) =3D 1 ([{fd=3D5, revents=3DPOLLIN}]=
, left {0, 10895457})
  write(6, "\1\0\0\0\0\0\0\0", 8)         =3D 8
  read(5, "\1\0\0\0\0\0\0\0", 512)        =3D 8
  write(6, "\1\0\0\0\0\0\0\0", 8)         =3D 8
  ppoll([{fd=3D13, events=3DPOLLIN|POLLERR|POLLHUP}, {fd=3D7, events=3DPOLL=
IN|POLLERR|POLLHUP}, {fd=3D12, events=3DPOLLIN|POLLERR|POLLHUP}, {fd=3D3, e=
vents=3DPOLLIN|POLLERR|POLLHUP}, {fd=3D6, events=3DPOLLIN}, {fd=3D5, events=
=3DPOLLIN}], 6, {0, 0}, NULL, 8) =3D 1 ([{fd=3D6, revents=3DPOLLIN}], left =
{0, 0})
  ppoll([{fd=3D13, events=3DPOLLIN|POLLERR|POLLHUP}, {fd=3D7, events=3DPOLL=
IN|POLLERR|POLLHUP}, {fd=3D12, events=3DPOLLIN|POLLERR|POLLHUP}, {fd=3D3, e=
vents=3DPOLLIN|POLLERR|POLLHUP}, {fd=3D6, events=3DPOLLIN}, {fd=3D5, events=
=3DPOLLIN}], 6, {0, 0}, NULL, 8) =3D 1 ([{fd=3D6, revents=3DPOLLIN}], left =
{0, 0})
  read(6, "\2\0\0\0\0\0\0\0", 16)         =3D 8
  ppoll([{fd=3D13, events=3DPOLLIN|POLLERR|POLLHUP}, {fd=3D7, events=3DPOLL=
IN|POLLERR|POLLHUP}, {fd=3D12, events=3DPOLLIN|POLLERR|POLLHUP}, {fd=3D3, e=
vents=3DPOLLIN|POLLERR|POLLHUP}, {fd=3D6, events=3DPOLLIN}, {fd=3D5, events=
=3DPOLLIN}], 6, {0, 0}, NULL, 8) =3D 0 (Timeout)
  read(6, 0x7fff697320e0, 16)             =3D -1 EAGAIN (Resource temporari=
ly unavailable)
  ppoll([{fd=3D13, events=3DPOLLIN|POLLERR|POLLHUP}, {fd=3D7, events=3DPOLL=
IN|POLLERR|POLLHUP}, {fd=3D12, events=3DPOLLIN|POLLERR|POLLHUP}, {fd=3D3, e=
vents=3DPOLLIN|POLLERR|POLLHUP}, {fd=3D6, events=3DPOLLIN}, {fd=3D5, events=
=3DPOLLIN}], 6, {0, 9570429}, NULL, 8) =3D 0 (Timeout)
  futex(0x7f011c8ef094, FUTEX_CMP_REQUEUE_PRIVATE, 1, 2147483647, 0x7f011aa=
a0860, 224) =3D 1
  write(5, "\1\0\0\0\0\0\0\0", 8)         =3D 8
  write(5, "\1\0\0\0\0\0\0\0", 8)         =3D 8
  futex(0x7f011aaa0860, FUTEX_WAKE_PRIVATE, 1) =3D 1
  ppoll([{fd=3D13, events=3DPOLLIN|POLLERR|POLLHUP}, {fd=3D7, events=3DPOLL=
IN|POLLERR|POLLHUP}, {fd=3D12, events=3DPOLLIN|POLLERR|POLLHUP}, {fd=3D3, e=
vents=3DPOLLIN|POLLERR|POLLHUP}, {fd=3D6, events=3DPOLLIN}, {fd=3D5, events=
=3DPOLLIN}], 6, {0, 54463396}, NULL, 8) =3D 1 ([{fd=3D5, revents=3DPOLLIN}]=
, left {0, 54459649})
  tgkill(7779, 7784, SIGUSR1)             =3D 0
  futex(0x7f011aaa0824, FUTEX_CMP_REQUEUE_PRIVATE, 1, 2147483647, 0x7f011aa=
a0860, 1650) =3D 1
  write(6, "\1\0\0\0\0\0\0\0", 8)         =3D 8
  read(5, "\2\0\0\0\0\0\0\0", 512)        =3D 8
  write(6, "\1\0\0\0\0\0\0\0", 8)         =3D 8
  ppoll([{fd=3D13, events=3DPOLLIN|POLLERR|POLLHUP}, {fd=3D7, events=3DPOLL=
IN|POLLERR|POLLHUP}, {fd=3D12, events=3DPOLLIN|POLLERR|POLLHUP}, {fd=3D3, e=
vents=3DPOLLIN|POLLERR|POLLHUP}, {fd=3D6, events=3DPOLLIN}, {fd=3D5, events=
=3DPOLLIN}], 6, {0, 0}, NULL, 8) =3D 1 ([{fd=3D6, revents=3DPOLLIN}], left =
{0, 0})
  ppoll([{fd=3D13, events=3DPOLLIN|POLLERR|POLLHUP}, {fd=3D7, events=3DPOLL=
IN|POLLERR|POLLHUP}, {fd=3D12, events=3DPOLLIN|POLLERR|POLLHUP}, {fd=3D3, e=
vents=3DPOLLIN|POLLERR|POLLHUP}, {fd=3D6, events=3DPOLLIN}, {fd=3D5, events=
=3DPOLLIN}], 6, {0, 0}, NULL, 8) =3D 1 ([{fd=3D6, revents=3DPOLLIN}], left =
{0, 0})
  read(6, "\2\0\0\0\0\0\0\0", 16)         =3D 8
  ppoll([{fd=3D13, events=3DPOLLIN|POLLERR|POLLHUP}, {fd=3D7, events=3DPOLL=
IN|POLLERR|POLLHUP}, {fd=3D12, events=3DPOLLIN|POLLERR|POLLHUP}, {fd=3D3, e=
vents=3DPOLLIN|POLLERR|POLLHUP}, {fd=3D6, events=3DPOLLIN}, {fd=3D5, events=
=3DPOLLIN}], 6, {0, 0}, NULL, 8) =3D 0 (Timeout)
  read(6, 0x7fff697320e0, 16)             =3D -1 EAGAIN (Resource temporari=
ly unavailable)
  futex(0x7f011aaa0860, FUTEX_WAKE_PRIVATE, 1) =3D 1
  ppoll([{fd=3D13, events=3DPOLLIN|POLLERR|POLLHUP}, {fd=3D7, events=3DPOLL=
IN|POLLERR|POLLHUP}, {fd=3D12, events=3DPOLLIN|POLLERR|POLLHUP}, {fd=3D3, e=
vents=3DPOLLIN|POLLERR|POLLHUP}, {fd=3D6, events=3DPOLLIN}, {fd=3D5, events=
=3DPOLLIN}], 6, {0, 53843633}, NULL, 8 <unfinished ...>
  +++ killed by SIGABRT +++

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1405385/+subscriptions
