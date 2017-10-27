Received: from eggs.gnu.org ([2001:4830:134:3::10]:50096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8BlN-0004BP-CB
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 17:01:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8BlK-0001Lf-88
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 17:01:57 -0400
Received: from indium.canonical.com ([91.189.90.7]:60108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e8BlJ-0001LP-Ur
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 17:01:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e8BlH-0006XE-4e
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 21:01:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 796042E80D1
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 21:01:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Oct 2017 20:42:44 -0000
From: Bug Watch Updater <761469@bugs.launchpad.net>
Reply-To: Bug 761469 <761469@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110415072945.23093.78774.malonedeb@wampee.canonical.com>
Message-Id: <150913696544.24013.334874896523709363.launchpad@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 761469] Re: multicast VPN breaks IPv6 Duplicate
 Address Detection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Launchpad has imported 14 comments from the remote bug at
https://bugzilla.redhat.com/show_bug.cgi?id=3D557188.

If you reply to an imported comment from within Launchpad, your comment
will be sent to the remote bug automatically. Read more about
Launchpad's inter-bugtracker facilities at
https://help.launchpad.net/InterBugTracking.

------------------------------------------------------------------------
On 2010-01-20T17:14:20+00:00 Need wrote:

Description of problem:

Virtual NIC of type "mcast" receives copies of what it sent, resulting
in many disastrous behaviors if you add one to a Linux software ethernet
bridge.

Version-Release number of selected component (if applicable):


How reproducible:

Always.


Steps to Reproduce:
1. create a kvm/qemu guest with an mcast NIC as eth0
2. create a bridge br0 in the guest, enabling STP
3. add eth0 to br0 as its only slave
  =

Actual results:

Once STP starts sending frames, the host starts reporting:

eth0: received packet with own address as source address

Expected results:

eth0 should not receive copies of what it sends.

Additional info:

This happens as above when the NIC goes into promiscuous mode. I have
not bothered to verify whether it happens for multicast or broadcast
traffic in non-promiscuous mode.

Things become more obvious and destructive if you add another slave to
the bridge.  Any incoming broadcast or multicast traffic from the other
slave gets bridged into the mcast NIC, reflected back, and creating a
kind of psuedo-loop. This confuses the user, upsets everyone on the
other LAN, and also confuses the Linux software bridge as it starts
falsely discovering all the reflected MACs as if they are reachable
behind the mcast NIC.

With a manually created list of the MAC addresses actually behind the
mcast LAN, one can create draconian ebtables filters to drop all
reflected packets via a command like:

ebtables -t nat -A PREROUTING -i ethX --among-src-file ! /etc/mcast-mac-
addrs -j dnat --dnat-target DROP

This will drop the bad frames before they confuse the bridging code, and
you end up with a working bridged mcast network.  This proves that the
problem is reflected packets coming back to the sender via the mcast
NIC.

Reply at: https://bugs.launchpad.net/qemu/+bug/761469/comments/0

------------------------------------------------------------------------
On 2010-01-20T21:58:57+00:00 David wrote:

This would presumably break all IPv6 duplicate address detection, so
guests don't work with IPv6?

Reply at: https://bugs.launchpad.net/qemu/+bug/761469/comments/1

------------------------------------------------------------------------
On 2010-01-20T22:16:22+00:00 Need wrote:

I am not using IPv6 in my test environment, so I cannot confirm nor
deny. The network goes haywire very rapidly if one does this experiment
without the ebtables rule above, leading one to rip cables out of walls
as fast as one can.

It is a great DoS attack on the victim LAN that you bridge into such an
mcast tunnel, as it reflects all broadcast traffic such as mDNS and
probably confuses hardware switches as well as the Linux software
bridge.  As such, I won't be performing more detailed tests of this
failure mode in my environment!

Reply at: https://bugs.launchpad.net/qemu/+bug/761469/comments/2

------------------------------------------------------------------------
On 2010-01-21T09:49:20+00:00 Daniel wrote:

Your initial description doesn't entirely make sense. The QEMU 'mcast'
nic type is totally isolated from the host network, but in the steps to
reproduce you're talking about setting up bridges in the host which
implies the 'tap' nic type in QEMU.

Please provide the exact QEMU command line you are invoking, and the
output of 'ifconfig -a', 'brctl show' and 'route -n' on the host OS.

Reply at: https://bugs.launchpad.net/qemu/+bug/761469/comments/3

------------------------------------------------------------------------
On 2010-01-21T15:15:30+00:00 Need wrote:

No, I described setting up a bridge in the guest with the mcast NIC!

So the bug-triggering guest needs only one NIC, eth0, which is defined
like this:

    <interface type=3D'mcast'>
      <mac address=3D'...'/>
      <source address=3D'...' port=3D'5558'/>
    </interface>

(with actual local MAC and multicast address assignments).

After booting that guest, use brctl to create a bridge br0, and simply
slave that virtual eth0 to the bridge (as its only "physical" port).
This will exhibit the problem, with no real networks involved.

When I mentioned the host LAN, I had created a second NIC in a
privileged guest, so it had one mcast NIC and one tap NIC already
bridged into the host LAN by libvirt.  Then that guest bridged its two
NICs, allowing other unprivileged guests to use an mcast NIC to
participate in the host LAN.  Because of this mcast bug, you can only do
this once this privileged guest has the severe ebtables workaround I
reported.

But this extra step is unnecessary to demonstrate the bug.  It is only
interesting in that it does something useful once the ebtables
workaround is in place (allowing unprivileged guests to participate in a
real LAN).

Reply at: https://bugs.launchpad.net/qemu/+bug/761469/comments/4

------------------------------------------------------------------------
On 2010-03-09T16:53:57+00:00 Fedora wrote:

This package has changed ownership in the Fedora Package Database.
Reassigning to the new owner of this component.

Reply at: https://bugs.launchpad.net/qemu/+bug/761469/comments/5

------------------------------------------------------------------------
On 2010-03-09T17:19:49+00:00 Fedora wrote:

This package has changed ownership in the Fedora Package Database.
Reassigning to the new owner of this component.

Reply at: https://bugs.launchpad.net/qemu/+bug/761469/comments/6

------------------------------------------------------------------------
On 2010-03-15T14:08:33+00:00 Bug wrote:


This bug appears to have been reported against 'rawhide' during the Fedora =
13 development cycle.
Changing version to '13'.

More information and reason for this action is here:
http://fedoraproject.org/wiki/BugZappers/HouseKeeping

Reply at: https://bugs.launchpad.net/qemu/+bug/761469/comments/7

------------------------------------------------------------------------
On 2011-02-15T16:25:53+00:00 Jan wrote:

I found this bug too.

Simple way how to reproduce:

Run kvm guest 1 and 2, with net something like this:
g1:-net nic,vlan=3D0,model=3Dvirtio,macaddr=3D52:54:00:00:01:01 -net socket=
,vlan=3D0,mcast=3D239.255.0.1:4097

g2: -net nic,vlan=3D0,model=3Dvirtio,macaddr=3D52:54:00:00:02:01 -net
socket,vlan=3D0,mcast=3D239.255.0.1:4097

This should give you two running vm on same net.

Now in each guest configure ip addresses:
g1: ifconfig eth0 192.168.1.1
g2: ifconfig eth0 192.168.1.2

now on g2 ping 192.168.1.1

and on g1 run tcpdump -i eth0 icmp
and every second you will get:
time ip 192.168.1.2 ... ICMP echo request
time ip 192.168.1.1 ... ICMP echo reply
time ip 192.168.1.1 ... ICMP echo reply

There shouldn't be two echo replies, but only one.

Another effect is, that Duplicate Address Detection (for ipv6) simply
doesn't work (this is what original bug is talking about).


Of course, solution is not to disable loopback for mcast socket, because th=
ere must be chance to run more then one VM on same host on same mcast addre=
ss:port.

Solution may be to detect sending socket ip:port pair and simply drop
packets received from this ip:port.

Reply at: https://bugs.launchpad.net/qemu/+bug/761469/comments/8

------------------------------------------------------------------------
On 2011-02-15T16:41:39+00:00 Jan wrote:

Just one extra note, I was able to reproduce this bug on  qemu-
system-x86-0.13.0-1.fc14.i686

Reply at: https://bugs.launchpad.net/qemu/+bug/761469/comments/9

------------------------------------------------------------------------
On 2011-04-15T17:57:50+00:00 Neil wrote:

Logged as Qemu bug on Launchpad:

https://bugs.launchpad.net/qemu/+bug/761469

Reply at: https://bugs.launchpad.net/qemu/+bug/761469/comments/11

------------------------------------------------------------------------
On 2011-06-02T16:48:53+00:00 Bug wrote:


This message is a reminder that Fedora 13 is nearing its end of life.
Approximately 30 (thirty) days from now Fedora will stop maintaining
and issuing updates for Fedora 13.  It is Fedora's policy to close all
bug reports from releases that are no longer maintained.  At that time
this bug will be closed as WONTFIX if it remains open with a Fedora =

'version' of '13'.

Package Maintainer: If you wish for this bug to remain open because you
plan to fix it in a currently maintained version, simply change the 'versio=
n' =

to a later Fedora version prior to Fedora 13's end of life.

Bug Reporter: Thank you for reporting this issue and we are sorry that =

we may not be able to fix it before Fedora 13 is end of life.  If you =

would still like to see this bug fixed and are able to reproduce it =

against a later version of Fedora please change the 'version' of this =

bug to the applicable version.  If you are unable to change the version, =

please add a comment here and someone will do it for you.

Although we aim to fix as many bugs as possible during every release's =

lifetime, sometimes those efforts are overtaken by events.  Often a =

more recent Fedora release includes newer upstream software that fixes =

bugs or makes them obsolete.

The process we are following is described here: =

http://fedoraproject.org/wiki/BugZappers/HouseKeeping

Reply at: https://bugs.launchpad.net/qemu/+bug/761469/comments/12

------------------------------------------------------------------------
On 2011-06-03T06:10:19+00:00 Jan wrote:

Bug is reproducible on fc14 too

Reply at: https://bugs.launchpad.net/qemu/+bug/761469/comments/13

------------------------------------------------------------------------
On 2012-05-20T22:03:18+00:00 Cole wrote:

F14 is end-of-life now. If anyone is still affected by this bug with
newer qemu versions, I'd recommend following up in the (still open)
upstream bug report mentioned in Comment #10

Reply at: https://bugs.launchpad.net/qemu/+bug/761469/comments/14


** Changed in: fedora
       Status: Unknown =3D> Won't Fix

** Changed in: fedora
   Importance: Unknown =3D> High

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/761469

Title:
  multicast VPN breaks IPv6 Duplicate Address Detection

Status in QEMU:
  New
Status in Fedora:
  Won't Fix

Bug description:
  The multicast VPN facility in Qemu uses Multicast Loopback to make
  sure that other Qemu processes on the Host server receive the
  transmission. The side effect of this is that the process sending the
  packet also gets the packet back on its receive channel and currently
  this is not filtered but passed directly to the Virtual Machine.

  You can see this effect by running tcpdump in the virtual machine.
  Every packet sent appears to be duplicated.

  For IPv4 it doesn't appear to cause much of a problem, however with
  IPv6 the duplicate neighbor solicitation packet is precisely what the
  system uses to detect duplicate addresses. So IPv6 addresses fail to
  establish.

  If you run 'ip addr' on a virtual Linux machine with IPv6 enabled you
  will see 'dadfailed' next to the link local address. 'ping6' will then
  not work.

  Checked against 0.12.1.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/761469/+subscriptions
