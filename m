Received: from eggs.gnu.org ([2001:4830:134:3::10]:60827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fs0nT-0001XM-Ao
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 03:09:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fs0a1-00014g-Ov
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:55:57 -0400
Received: from indium.canonical.com ([91.189.90.7]:45118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fs0a1-00013q-IO
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:55:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fs0a0-0006q5-CM
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 06:55:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5B0ED2E851C
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 06:55:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Aug 2018 06:41:39 -0000
From: Thomas Huth <1297487@bugs.launchpad.net>
Reply-To: Bug 1297487 <1297487@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140325201253.30630.89237.malonedeb@gac.canonical.com>
Message-Id: <153483369983.17158.9568695423820857651.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1297487] Re: MTU not honored in virtio vnet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Closing for QEMU since there hasn't been any response within a year.

** Changed in: qemu
       Status: Incomplete =3D> Won't Fix

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1297487

Title:
  MTU not honored in virtio vnet

Status in QEMU:
  Won't Fix
Status in Salt:
  New
Status in qemu-kvm package in Ubuntu:
  Confirmed

Bug description:
  I am observing a potential regression/different behavior between rel.
  14.04 (dev branch) and release 13.04.

  My hardware is: Cisco UCS blade B200-M3 and the network adapter card:
  Cisco UCS VIC 1240.

  lsb_release -rd
  Description:	Ubuntu Trusty Tahr (development branch)
  Release:	14.04

  uname -a
  Linux konan2 3.13.0-19-generic #40-Ubuntu SMP Mon Mar 24 02:36:06 UTC 201=
4 x86_64 x86_64 x86_64 GNU/Linux

  The problem:
  After starting a kvm with virtio interfaces I am passing HTTP traffic via=
 an external network traffic simulator.
  The tool is sending a TCP packet of 3481B, because the tool MTU is set to=
 1400B, it splits the packets into 3 TCP segments.
  When the 3 segments are received at the host eth1 interface, the host (ub=
untu 14.04) reassembles the TCP packets into a larger packet (GRO), then pa=
sses the packet up on vnet1. At this point, because vnet1 MTU is 1500B, it =
is supposed to re-segment the packet and pass the 3 segments up to the VM. =
But it passes the big 3481B packet instead.

  This behavior did not happen when I tried the same scenario in release
  13.04

  I can disable this behavior by disabling TSO (TCP segment offloading
  in the vnet), but I did not have to do this in rel. 13.04 and I feel
  the MTU is not honored as it should be with rel. 14.04.

   ip link show | grep eth1
  3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master br1 s=
tate UP mode DEFAULT group default qlen 1000
   ip link show | grep vnet1
  16: vnet1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast ma=
ster br1 state UNKNOWN mode DEFAULT group default qlen 500

  I am attaching two tcpdump/pcap traces that show a TCP transaction
  passing on vnet1 when TSO is on and when TSO is off.

  Please see:

  - vnet1_tso_on.pcap
  - vnet1_tso_off.pcap

  in attachment.

  I noticed there was a driver upgrade in rel. 14.04:

  in 14.04:

  ethtool -i eth1
  driver: enic
  version: 2.1.1.50  =

  firmware-version: 2.1(3a)
  bus-info: 0000:07:00.0
  supports-statistics: yes
  supports-test: no
  supports-eeprom-access: no
  supports-register-dump: no
  supports-priv-flags: no

  ethtool -i vnet1
  driver: tun
  version: 1.6
  firmware-version: =

  bus-info: tap
  supports-statistics: no
  supports-test: no
  supports-eeprom-access: no
  supports-register-dump: no
  supports-priv-flags: no

  ethtool -k vnet1
  Features for vnet1:
  rx-checksumming: off [fixed]
  tx-checksumming: on
  	tx-checksum-ipv4: off [fixed]
  	tx-checksum-ip-generic: on
  	tx-checksum-ipv6: off [fixed]
  	tx-checksum-fcoe-crc: off [fixed]
  	tx-checksum-sctp: off [fixed]
  scatter-gather: on
  	tx-scatter-gather: on
  	tx-scatter-gather-fraglist: on
  tcp-segmentation-offload: off
  	tx-tcp-segmentation: off
  	tx-tcp-ecn-segmentation: off
  	tx-tcp6-segmentation: off
  udp-fragmentation-offload: on
  generic-segmentation-offload: on
  generic-receive-offload: on
  large-receive-offload: off [fixed]
  rx-vlan-offload: off [fixed]
  tx-vlan-offload: on
  ntuple-filters: off [fixed]
  receive-hashing: off [fixed]
  highdma: off [fixed]
  rx-vlan-filter: off [fixed]
  vlan-challenged: off [fixed]
  tx-lockless: off [fixed]
  netns-local: off [fixed]
  tx-gso-robust: off [fixed]
  tx-fcoe-segmentation: off [fixed]
  tx-gre-segmentation: off [fixed]
  tx-ipip-segmentation: off [fixed]
  tx-sit-segmentation: off [fixed]
  tx-udp_tnl-segmentation: off [fixed]
  tx-mpls-segmentation: off [fixed]
  fcoe-mtu: off [fixed]
  tx-nocache-copy: on
  loopback: off [fixed]
  rx-fcs: off [fixed]
  rx-all: off [fixed]
  tx-vlan-stag-hw-insert: on
  rx-vlan-stag-hw-parse: off [fixed]
  rx-vlan-stag-filter: off [fixed]
  l2-fwd-offload: off [fixed]


  in 13.04 :

  ethtool -i eth1
  driver: enic
  version: 2.1.1.39
  firmware-version: 2.1(3a)
  bus-info: 0000:07:00.0
  supports-statistics: yes
  supports-test: no
  supports-eeprom-access: no
  supports-register-dump: no
  supports-priv-flags: no

  =

  ethtool -i vnet1
  driver: tun
  version: 1.6
  firmware-version: =

  bus-info: tap
  supports-statistics: no
  supports-test: no
  supports-eeprom-access: no
  supports-register-dump: no
  supports-priv-flags: no

  =

  ethtool -k vnet1
  Features for vnet1:
  rx-checksumming: off [fixed]
  tx-checksumming: on
  	tx-checksum-ipv4: off [fixed]
  	tx-checksum-ip-generic: on
  	tx-checksum-ipv6: off [fixed]
  	tx-checksum-fcoe-crc: off [fixed]
  	tx-checksum-sctp: off [fixed]
  scatter-gather: on
  	tx-scatter-gather: on
  	tx-scatter-gather-fraglist: on
  tcp-segmentation-offload: on
  	tx-tcp-segmentation: on
  	tx-tcp-ecn-segmentation: on
  	tx-tcp6-segmentation: on
  udp-fragmentation-offload: on
  generic-segmentation-offload: on
  generic-receive-offload: on
  large-receive-offload: off [fixed]
  rx-vlan-offload: off [fixed]
  tx-vlan-offload: off [fixed]
  ntuple-filters: off [fixed]
  receive-hashing: off [fixed]
  highdma: off [fixed]
  rx-vlan-filter: off [fixed]
  vlan-challenged: off [fixed]
  tx-lockless: off [fixed]
  netns-local: off [fixed]
  tx-gso-robust: off [fixed]
  tx-fcoe-segmentation: off [fixed]
  fcoe-mtu: off [fixed]

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1297487/+subscriptions
