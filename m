Received: from eggs.gnu.org ([2001:4830:134:3::10]:60626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fTsra-0004UV-7n
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 13:50:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fTsrX-0000NM-VN
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 13:50:18 -0400
Received: from indium.canonical.com ([91.189.90.7]:47030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fTsrX-0000Mr-PO
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 13:50:15 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fTsrW-00080f-Tc
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 17:50:14 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DB24F2E80C7
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 17:50:14 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Jun 2018 17:35:13 -0000
From: Thomas Huth <1036363@bugs.launchpad.net>
Reply-To: Bug 1036363 <1036363@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120813200139.30374.90976.malonedeb@chaenomeles.canonical.com>
Message-Id: <152908411398.27316.13610272668761148146.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1036363] Re: Major network performance problems
 on AMD hardware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: Incomplete =3D> Won't Fix

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1036363

Title:
  Major network performance problems on AMD hardware

Status in QEMU:
  Won't Fix
Status in qemu-kvm:
  New

Bug description:
  Hi,

  I am experiencing some major performance problems with all of our
  beefy AMD Opteron 6274 servers running Fedora 17 (kernel
  3.4.4-5.fc17.x86_64, qemu 1.0-17).  The network performance between
  host and the virtual machine is terrible:

  # iperf -c 10.10.11.22 -r
  ------------------------------------------------------------
  Server listening on TCP port 5001
  TCP window size: 85.3 KByte (default)
  ------------------------------------------------------------
  ------------------------------------------------------------
  Client connecting to 10.10.11.22, TCP port 5001
  TCP window size:  197 KByte (default)
  ------------------------------------------------------------
  [  5] local 10.10.11.199 port 44192 connected with 10.10.11.22 port 5001
  [ ID] Interval       Transfer     Bandwidth
  [  5]  0.0-10.0 sec  2.45 GBytes  2.11 Gbits/sec
  [  4] local 10.10.11.199 port 5001 connected with 10.10.11.22 port 42601
  [  4]  0.0-10.0 sec  8.97 GBytes  7.71 Gbits/sec

  So the VM's receive is super slow.  I would be happy with 7.71 Gbps
  because it's closer to matching the speed of the 10G ethernet adapters
  but the iSCSI drive's write performance is few times faster than read.
  Now running a similar test on the slowest machine I have, Intel core
  i3 I see this:

  # iperf -c 192.168.7.60 -r
  ------------------------------------------------------------
  Server listening on TCP port 5001
  TCP window size: 85.3 KByte (default)
  ------------------------------------------------------------
  ------------------------------------------------------------
  Client connecting to 192.168.7.60, TCP port 5001
  TCP window size:  306 KByte (default)
  ------------------------------------------------------------
  [  5] local 192.168.7.98 port 53992 connected with 192.168.7.60 port 5001
  [ ID] Interval       Transfer     Bandwidth
  [  5]  0.0-10.0 sec  22.5 GBytes  19.3 Gbits/sec
  [  4] local 192.168.7.98 port 5001 connected with 192.168.7.60 port 53339
  [  4]  0.0-10.0 sec  25.1 GBytes  21.5 Gbits/sec

  As you can image this is a huge difference in network IO.  Most setups
  are identical down to the same versions.  Vhost-net is enabled and it
  appears to use MSI-X on the VM.  I've tried all kinds of settings and
  while they improve performance a little I feel it's just masking a
  bigger problem.  All 12 of my AMD servers have this issue and it
  appears I'm not the only one complaining.  Any help would be
  appreciated.  Thanks.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1036363/+subscriptions
