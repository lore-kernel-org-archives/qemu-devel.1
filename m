Received: from eggs.gnu.org ([2001:4830:134:3::10]:54160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fRIUi-0003BO-CT
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:36:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fRIUf-00085A-87
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:36:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:55226)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fRIUf-00083R-0q
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:35:57 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fRIUd-0006o1-5d
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 14:35:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 24FB62E80C9
	for <qemu-devel@nongnu.org>; Fri,  8 Jun 2018 14:35:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 Jun 2018 14:20:00 -0000
From: Thomas Huth <1463909@bugs.launchpad.net>
Reply-To: Bug 1463909 <1463909@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150610165514.12842.54988.malonedeb@wampee.canonical.com>
Message-Id: <152846760224.6241.15641799005520432301.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1463909] Re: virtio: networking not working when
 guest's eth0 is not in promiscuous mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Project changed: qemu =3D> qemu (Ubuntu)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1463909

Title:
  virtio: networking not working when guest's eth0 is not in promiscuous
  mode

Status in qemu package in Ubuntu:
  New

Bug description:
  We are unable to get http responses from qemu guest machine until
  interface inside qemu guest machine is in promiscuous mode.

  Our configuration is following:

  <pre>
       ------------------------
       |       Host server    |
       ------------------------
       |     /eth1.10(IP1)    |
  LAN2-|-eth1-eth1.11(IP2)    |
       |     \eth1.12(IP3)    |
       |                      |
  LAN1-|-eth0(IP4) <IP[1-4]>  |
       |              /       |
       |      iptables[nat]   |
       |    /  ________________
       |    |  | Guest system |
       |  tap0-|-eth0(guestIP)|
       ------------------------
  </pre>

  Host server is connected to LAN1 with eth0 and to LAN2 with eth1. eth0
  has IP4 assigned. eth1 is connected to the switch in trunk mode that
  has vlans 10, 11 and 12 allows. Thus in Host systems we have eth1.10,
  eth1.11 and eth1.12 interfaces with IP1, IP2 and IP3 respectfully.

  Inside Host systems we start Guest system using following command:

  > qemu-system-x86_64 -m 3G -nographic -monitor stdio -serial none
  -kernel /vmlinuz -initrd /webiface.gz -hda /data/data.img -net
  nic,model=3Dvirtio,macaddr=3Dfe:32:31:30:29:00 -net
  tap,ifname=3Dtap0,script=3Dno,downscript=3Dno

  tap interface was created with commands:
  > ip tuntap add dev tap0 mode tap user user                              =
                                                                =

  > ip addr add 172.31.31.253/30 brd + dev tap0
  > ip link set dev tap0 up

  =

  Routing for packets comming from LAN1 or LAN2 to guest system is identica=
l and is done by iptables DNAT target:

  > iptables -t nat -A PREROUTING -d <IP1> -p tcp --dport 8580 -j DNAT --to=
-destination <guest IP>:80
  ...
  > iptables -t nat -A PREROUTING -d <IP4> -p tcp --dport 8580 -j DNAT --to=
-destination <guest IP>:80

  Now the problem is that requests for @http://<IP4>:8580/index.html@
  stall, until we put eth0 on Guest system in promiscuous mode. Note
  this concerns only packets coming through eth0 on Host system.
  Requests for @http://<IP[1-3]>:8580/index.html@ work as the should!

  It is really strange how promiscuous mode of the interface on guest
  system affects the way it receives packets. So we did further debuging
  with tcpdump.

  For interesting (broken) case when packets arrive through eth0 of Host
  system, using tcpdump, we found that syn requests are coming out at
  tap0 interface:

  > 12:40:11.049007 c2:30:61:72:8d:14 > fe:32:31:30:29:00, ethertype
  IPv4 (0x0800), length 74: <IP>.45661 > <guestIP>.80: Flags [S], seq
  1998302974, win 29200, options [mss 1352,sackOK,TS val 3509464 ecr
  0,nop,wscale 7], length 0

  but no packet arrives on guest's eth0 interface! We confirmed that
  with tcpdump running with promiscuous mode disabled. So packets gone
  out from tap0 but never archived eth0 of the Guest system! Of course,
  once we run tcpdump without -p, guest interface will run in
  promiscuous mode and all packets/traffic will be visible on Guest also
  and everything works as expected.

  ifconfig shows no drops on tap0 interface. I've check MAC addresses of
  tap0(c2:30:61:72:8d:14) and guest's eth0 (fe:32:31:30:29:00). I don't
  see problem here.

  We've tried with eth1 interface not configured (no vlans) and still
  have this problem.

  This is Ubuntu 12.04.4 LTS server system with 3.2.0-67-generic kernel
  and QEMU emulator version 1.0 (qemu-kvm-1.0), Copyright (c) 2003-2008
  Fabrice Bellard.

  Googling we found that similar problem was reported with much older syste=
m (but very few details unfortunately):
  http://www.serverphorums.com/read.php?12,28222

  We failed to find any confirmation that this problem was fixed in
  newer version. Is this a known bug? Any suggestions how to debug?

To manage notifications about this bug go to:
https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1463909/+subscriptions
