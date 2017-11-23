Received: from eggs.gnu.org ([2001:4830:134:3::10]:34613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eHmh9-0002Qj-QW
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 03:17:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eHmh4-0006wl-Re
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 03:17:15 -0500
Received: from indium.canonical.com ([91.189.90.7]:42952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eHmh4-0006wG-LJ
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 03:17:10 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eHmh3-0005wA-Jd
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 08:17:09 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9170A2E80C3
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 08:17:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Nov 2017 08:00:15 -0000
From: Matt Keys <1329956@bugs.launchpad.net>
Reply-To: Bug 1329956 <1329956@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140613211439.4618.98205.malonedeb@soybean.canonical.com>
Message-Id: <151142401627.14751.15319431308166729819.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1329956] Re: multi-core FreeBSD guest hangs after
 warm reboot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Also affects: debian
   Importance: Undecided
       Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1329956

Title:
  multi-core FreeBSD guest hangs after warm reboot

Status in QEMU:
  Fix Released
Status in Debian:
  New

Bug description:
  On some Linux KVM hosts in our environment, FreeBSD guests fail to
  reboot properly if they have more than one CPU (socket, core, and/or
  thread). They will boot fine the first time, but after issuing a
  "reboot" command via the OS the guest starts to boot but hangs during
  SMP initialization. Fully shutting down and restarting the guest works
  in all cases.

  The only meaningful difference between hosts with the problem and those w=
ithout is the CPU. Hosts with Xeon E5-26xx v2 processors have the problem, =
including at least the "Intel(R) Xeon(R) CPU E5-2667 v2" and the "Intel(R) =
Xeon(R) CPU E5-2650 v2".
  Hosts with any other CPU, including "Intel(R) Xeon(R) CPU E5-2650 0", "In=
tel(R) Xeon(R) CPU E5-2620 0", or "AMD Opteron(TM) Processor 6274" do not h=
ave the problem. Note the "v2" in the names of the problematic CPUs.

  On hosts with a "v2" Xeon, I can reproduce the problem under Linux
  kernel 3.10 or 3.12 and Qemu 1.7.0 or 2.0.0.

  The problem occurs with all currently-supported versions of FreeBSD,
  including 8.4, 9.2, 10.0 and 11-CURRENT.

  On a Linux KVM host with a "v2" Xeon, this command line is adequate to
  reproduce the problem:

  /usr/bin/qemu-system-x86_64 -machine accel=3Dkvm -name bsdtest -m 512
  -smp 2,sockets=3D1,cores=3D1,threads=3D2 -drive
  file=3D./20140613_FreeBSD_9.2-RELEASE_ufs.qcow2,if=3Dnone,id=3Ddrive0,for=
mat=3Dqcow2
  -device virtio-blk-pci,scsi=3Doff,drive=3Ddrive0 -vnc 0.0.0.0:0 -net none

  I have tried many variations including different models of -machine
  and -cpu for the guest with no visible difference.

  A native FreeBSD installation on a host with a "v2" Xeon does not have
  the problem, nor do a paravirtualized FreeBSD guests under bhyve (the
  BSD legacy-free hypervisor) using the same FreeBSD disk images as on
  the Linux hosts. So it seems unlikely the cause is on the FreeBSD side
  of things.

  I would greatly appreciate any feedback or developer attention to
  this. I am happy to provide additional details, test patches, etc.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1329956/+subscriptions
