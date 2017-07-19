Received: from eggs.gnu.org ([2001:4830:134:3::10]:33554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dXdpQ-0001UZ-09
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 21:31:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dXdpM-0000BN-QZ
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 21:31:03 -0400
Received: from indium.canonical.com ([91.189.90.7]:51033)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dXdpM-00009p-J9
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 21:31:00 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dXdpJ-00078Q-RX
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 01:30:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id EF01B2E80E8
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 01:30:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Jul 2017 01:20:42 -0000
From: A S <1703506@bugs.launchpad.net>
Reply-To: Bug 1703506 <1703506@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <149974876377.6612.10329067332937096720.malonedeb@gac.canonical.com>
Message-Id: <150042724228.24170.2953786811091683525.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1703506] Re: SMT not supported by QEMU on AMD
 Ryzen CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

>Please confirm what's the QEMU command-line being used (especially the
-smp and -cpu options), and check if the bug persists if using "-cpu
host".

I'm using -cpu host already, here's just the cpu and smp commands:

-cpu host,hv_vendor_id=3Dwhatever,kvm=3Doff,hv_relaxed,hv_spinlocks=3D0x1ff=
f,hv_vapic,hv_time,smep=3Doff                                              =
                                                                           =
         =

-smp 12,sockets=3D1,cores=3D6,threads=3D2

The extra commands are just for VGA passthrough, but the problem still
occurs with just -cpu host (plus smep=3Doff, problems with booting with it
enabled) and the above smp setting.

I've attached host output; I'm using a Windows guest and running
msinfo32 indicates:

AMD Ryzen 1600 Six-Core Processor, 3693 Mhz, 12 Core(s), 12 Logical
Processors(s)

Suggesting that the guest is seeing the host as 12 cores, 1 thread each,
rather than 6 cores, 2 threads each.

If Linux guest information would be more helpful, I'll set up a Linux
guest as well.

** Attachment added: "Host logs"
   https://bugs.launchpad.net/qemu/+bug/1703506/+attachment/4917236/+files/=
qemu-ryzen-smt-logs.tar.gz

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1703506

Title:
  SMT not supported by QEMU on AMD Ryzen CPU

Status in QEMU:
  New

Bug description:
  HyperThreading/SMT is supported by AMD Ryzen CPUs but results in this
  message when setting the topology to threads=3D2:

  qemu-system-x86_64: AMD CPU doesn't support hyperthreading. Please
  configure -smp options properly.

  Checking in a Windows 10 guest reveals that SMT is not enabled, and
  from what I understand, QEMU converts the topology from threads to
  cores internally on AMD CPUs. This appears to cause performance
  problems in the guest perhaps because programs are assuming that these
  threads are actual cores.

  Software: Linux 4.12, qemu 2.9.0 host with KVM enabled, Windows 10 pro
  guest

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1703506/+subscriptions
