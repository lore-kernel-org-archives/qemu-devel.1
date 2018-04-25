Received: from eggs.gnu.org ([2001:4830:134:3::10]:47761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fBPBq-0004mN-DG
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 14:30:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fBPBn-0002Ed-4B
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 14:30:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:58688)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fBPBm-0002DS-To
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 14:30:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fBPBl-000515-S9
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 18:30:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D38342E80C8
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 18:30:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Apr 2018 18:25:12 -0000
From: John Snow <1766904@bugs.launchpad.net>
Reply-To: Bug 1766904 <1766904@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152466858890.21548.13995835103547275465.malonedeb@soybean.canonical.com>
Message-Id: <152468071259.557.5196931718900462756.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1766904] Re: Creating high hdd load (with
 constant fsyncs) on a SATA disk leads to freezes and errors in guest dmesg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Relevant bits appear to be:

-M pc-i1440fx-2.8
-cpu IvyBridge
-m 2048 =

-realtime mlock=3Doff =

-smp 2,sockets=3D2,cores=3D1,threads=3D1
-device ahci,id=3Dsata0,bus=3Dpci.0,addr=3D0x7 =

-drive file=3D/home/user/data/work/virt-images/myvm.local.qcow2,format=3Dqc=
ow2,if=3Dnone,id=3Ddrive-sata0-0-0 =

-device ide-hd,bus=3Dsata0.0,drive=3Ddrive-sata0-0-0,id=3Dsata0-0-0,bootind=
ex=3D1 =


So this is a 2.8 PC machine that we've configured to use AHCI instead. I
see some blips about CHS being zero, but that's expected in response to
a (successful) flush (0xE7) command, so it looks like it's stalling out.
I'll have to try to reproduce and see if I can trigger the hang.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1766904

Title:
  Creating high hdd load (with constant fsyncs) on a SATA disk leads to
  freezes and errors in guest dmesg

Status in QEMU:
  New

Bug description:
  After upgrading from qemu 2.10.0+dfsg-2 to 2.12~rc3+dfsg-2 (on debian
  sid host), centos 7 guest started to show freezes and ata errors in
  dmesg during hdd workloads with writing many small files and repeated
  fsyncs.

  Host kernel 4.15.0-3-amd64.
  Guest kernel 3.10.0-693.21.1.el7.x86_64 (slightly older guest kernel was =
tested too with same result).

  Script that reproduces the bug (first run usualy goes smooth, second
  and later runs result in dmesg errors and freezes):

  http://paste.debian.net/hidden/472fb220/

  Sample of error messages in guest dmesg:

  http://paste.debian.net/hidden/8219e234/

  This vm is launchd using virsh start. VM launch command (from logfile
  in /var/log/libvirt/qemu/):

  http://paste.debian.net/plainh/5604126f

  A workaround that I am using right now: I have detached this SATA
  storage and reattached the same .qcow2 file as SCSI - this has fixed
  the issue for me.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1766904/+subscriptions
