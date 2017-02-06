Received: from eggs.gnu.org ([2001:4830:134:3::10]:40966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1casQG-0001pZ-4N
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 18:10:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1casQB-000151-6L
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 18:10:12 -0500
Received: from indium.canonical.com ([91.189.90.7]:53312)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1casQA-00013P-Uf
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 18:10:07 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1casQ9-0003UN-Ji
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 23:10:05 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8F1752E80C0
	for <qemu-devel@nongnu.org>; Mon,  6 Feb 2017 23:10:05 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Feb 2017 22:57:54 -0000
From: Thomas Huth <785668@bugs.launchpad.net>
Reply-To: Bug 785668 <785668@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110520100201.21566.45400.malonedeb@gac.canonical.com>
Message-Id: <20170206225755.4601.69769.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 785668] Re: bonding inside a bridge does not
 update ARP correctly when bridged net accessed from within a VM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** No longer affects: qemu

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/785668

Title:
  bonding inside a bridge does not update ARP correctly when bridged net
  accessed from within a VM

Status in linux package in Ubuntu:
  Confirmed
Status in qemu-kvm package in Ubuntu:
  Invalid

Bug description:
  Binary package hint: qemu-kvm

  Description: Ubuntu 10.4.2
  Release: 10.04

  When setting a KVM host with a bond0 interface made of eth0 and eth1
  and using this bond0 interface for a bridge to KVM VMs, the ARP tables
  do not get updated correctly so it is not possible for a VM to reach
  an IP on the bridged network up until that remote system has pinged
  the VM itself.

  Reproducible: 100%, with any of the load balancing mode

  How to reproduce the problem

  - Prerequisites:
  1 One KVM system with 10.04.02 server,  configured as a virtual host is n=
eeded. The following /etc/network/interfaces was used for the test :

  # grep  -v ^# /etc/network/interfaces
  auto lo
  iface lo inet loopback

  auto bond0
  iface bond0 inet manual
  =C2=A0post-up ifconfig $IFACE up
  =C2=A0pre-down ifconfig $IFACE down
  =C2=A0bond-slaves none
  =C2=A0bond_mode balance-rr
  =C2=A0bond-downdelay 250
  =C2=A0bond-updelay 120
  auto eth0
  allow-bond0 eth0
  iface eth0 inet manual
  =C2=A0bond-master bond0
  auto eth1
  allow-bond0 eth1
  iface eth1 inet manual
  =C2=A0bond-master bond0

  auto br0
  iface br0 inet dhcp
  =C2=A0# dns-* options are implemented by the resolvconf package, if insta=
lled
  =C2=A0bridge-ports bond0
  =C2=A0bridge-stp off
  =C2=A0bridge-fd 9
  =C2=A0bridge-hello 2
  =C2=A0bridge-maxage 12
  =C2=A0bridge_max_wait 0

  One VM running Maverick 10.10 server, standard installation, using the
  following /etc/network/interfaces file :

  grep -v ^# /etc/network/interfaces

  auto lo
  iface lo inet loopback

  auto eth0
  iface eth0 inet static
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0address 10.153.107.92
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0netmask 255.255.255.0
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0network 10.153.107.0
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0broadcast 10.153.107.255

  --------------
  On a remote bridged network system :
  $ arp -an
  ? (10.153.107.188) =C3=A0 00:1c:c4:6a:c0:dc [ether] sur tap0
  ? (16.1.1.1) =C3=A0 00:17:33:e9:ee:3c [ether] sur wlan0
  ? (10.153.107.52) =C3=A0 00:1c:c4:6a:c0:de [ether] sur tap0

  On KVMhost
  $ arp -an
  ? (10.153.107.80) at ee:99:73:68:f0:a5 [ether] on br0

  On VM
  $ arp -an
  ? (10.153.107.61) at <incomplete> on eth0

  1) Test #1 : ping from VM (10.153.107.92) to remote bridged network
  system (10.153.107.80) :

  - On remote bridged network system :
  caribou@marvin:~$ arp -an
  ? (10.153.107.188) =C3=A0 00:1c:c4:6a:c0:dc [ether] sur tap0
  ? (16.1.1.1) =C3=A0 00:17:33:e9:ee:3c [ether] sur wlan0
  ? (10.153.107.52) =C3=A0 00:1c:c4:6a:c0:de [ether] sur tap0

  - On KVMhost
  ubuntu@VMhost:~$ arp -an
  ? (10.153.107.80) at ee:99:73:68:f0:a5 [ether] on br0

  - On VM
  ubuntu@vm1:~$ ping 10.153.107.80
  PING 10.153.107.80 (10.153.107.80) 56(84) bytes of data.
  From 10.153.107.92 icmp_seq=3D1 Destination Host Unreachable
  From 10.153.107.92 icmp_seq=3D2 Destination Host Unreachable
  From 10.153.107.92 icmp_seq=3D3 Destination Host Unreachable
  ^C
  --- 10.153.107.80 ping statistics ---
  4 packets transmitted, 0 received, +3 errors, 100% packet loss, time 3010=
ms
  pipe 3
  ubuntu@vm1:~$ arp -an
  ? (10.153.107.61) at <incomplete> on eth0
  ? (10.153.107.80) at <incomplete> on eth0

  2) Test #2 : ping from remote bridged network system (10.153.107.80)
  to VM (10.153.107.92) :

  - On remote bridged network system :
  $ ping 10.153.107.92
  PING 10.153.107.92 (10.153.107.92) 56(84) bytes of data.
  64 bytes from 10.153.107.92: icmp_req=3D1 ttl=3D64 time=3D327 ms
  64 bytes from 10.153.107.92: icmp_req=3D2 ttl=3D64 time=3D158 ms
  64 bytes from 10.153.107.92: icmp_req=3D3 ttl=3D64 time=3D157 ms
  ^C
  --- 10.153.107.92 ping statistics ---
  3 packets transmitted, 3 received, 0% packet loss, time 2003ms
  rtt min/avg/max/mdev =3D 157.289/214.500/327.396/79.831 ms
  caribou@marvin:~$ arp -an
  ? (10.153.107.188) =C3=A0 00:1c:c4:6a:c0:dc [ether] sur tap0
  ? (16.1.1.1) =C3=A0 00:17:33:e9:ee:3c [ether] sur wlan0
  ? (10.153.107.52) =C3=A0 00:1c:c4:6a:c0:de [ether] sur tap0
  ? (10.153.107.92) =C3=A0 52:54:00:8c:e0:3c [ether] sur tap0

  - On KVMhost
  $ arp -an
  ? (10.153.107.80) at ee:99:73:68:f0:a5 [ether] on br0

  - On VM
  arp -an
  ? (10.153.107.61) at <incomplete> on eth0
  ? (10.153.107.80) at ee:99:73:68:f0:a5 [ether] on eth0

  3) Test #3 : New ping from VM (10.153.107.92) to remote bridged network s=
ystem (10.153.107.80) :
  - On remote bridged network system :
  $ arp -an
  ? (10.153.107.188) =C3=A0 00:1c:c4:6a:c0:dc [ether] sur tap0
  ? (16.1.1.1) =C3=A0 00:17:33:e9:ee:3c [ether] sur wlan0
  ? (10.153.107.52) =C3=A0 00:1c:c4:6a:c0:de [ether] sur tap0
  ? (10.153.107.92) =C3=A0 52:54:00:8c:e0:3c [ether] sur tap0

  - On KVMhost
  ubuntu@VMhost:~$ arp -an
  ? (10.153.107.80) at ee:99:73:68:f0:a5 [ether] on br0

  - On VM
  ubuntu@vm1:~$ ping 10.153.107.80
  PING 10.153.107.80 (10.153.107.80) 56(84) bytes of data.
  64 bytes from 10.153.107.80: icmp_req=3D1 ttl=3D64 time=3D154 ms
  64 bytes from 10.153.107.80: icmp_req=3D2 ttl=3D64 time=3D170 ms
  64 bytes from 10.153.107.80: icmp_req=3D3 ttl=3D64 time=3D154 ms
  ^C
  --- 10.153.107.80 ping statistics ---
  3 packets transmitted, 3 received, 0% packet loss, time 2003ms
  rtt min/avg/max/mdev =3D 154.072/159.465/170.058/7.504 ms

  tcpdump traces are available for those tests. Test system is available
  upon request.

  Workaround:

  Use the bonded device in "active-backup" mode

  ProblemType: Bug
  DistroRelease: Ubuntu 10.04.02
  Package: qemu-kvm-0.12.3+noroms-0ubuntu9.6
  Uname: Linux 2.6.35-25-serverr x86_64
  Architecture: amd64

To manage notifications about this bug go to:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/785668/+subscriptions
