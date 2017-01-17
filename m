Received: from eggs.gnu.org ([2001:4830:134:3::10]:44800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTbPX-00010U-1R
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 16:35:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTbPV-0005FT-Q8
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 16:35:23 -0500
Received: from indium.canonical.com ([91.189.90.7]:60027)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cTbPV-0005EB-KM
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 16:35:21 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cTbPU-0004Kk-CU
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 21:35:20 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4C68F2E80CF
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 21:35:20 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Jan 2017 21:19:14 -0000
From: Thomas Huth <741887@bugs.launchpad.net>
Reply-To: Bug 741887 <741887@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110324165753.17739.21728.malonedeb@soybean.canonical.com>
Message-Id: <20170117211916.21676.70286.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 741887] Re: virsh snapshot-create too slow (kvm,
 qcow2, savevm)
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
       Status: New =3D> Won't Fix

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/741887

Title:
  virsh snapshot-create too slow (kvm, qcow2, savevm)

Status in QEMU:
  Won't Fix
Status in qemu-kvm package in Ubuntu:
  Won't Fix

Bug description:
  Action
  =3D=3D=3D=3D=3D=3D
  # time virsh snapshot-create 1

  * Taking snapshot of a running KVM virtual machine

  Result
  =3D=3D=3D=3D=3D=3D
  Domain snapshot 1300983161 created
  real    4m46.994s
  user    0m0.000s
  sys     0m0.010s

  Expected result
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  * Snapshot taken after few seconds instead of minutes.

  Environment
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  * Ubuntu Natty Narwhal upgraded from Lucid and Meerkat, fully updated.

  * Stock natty packages of libvirt and qemu installed (libvirt-bin
  0.8.8-1ubuntu5; libvirt0 0.8.8-1ubuntu5; qemu-common 0.14.0+noroms-
  0ubuntu3; qemu-kvm 0.14.0+noroms-0ubuntu3).

  * Virtual machine disk format is qcow2 (debian 5 installed)
  image: /storage/debian.qcow2
  file format: qcow2
  virtual size: 10G (10737418240 bytes)
  disk size: 1.2G
  cluster_size: 65536
  Snapshot list:
  ID        TAG                 VM SIZE                DATE       VM CLOCK
  1         snap01                  48M 2011-03-24 09:46:33   00:00:58.899
  2         1300979368              58M 2011-03-24 11:09:28   00:01:03.589
  3         1300983161              57M 2011-03-24 12:12:41   00:00:51.905

  * qcow2 disk is stored on ext4 filesystem, without RAID or LVM or any
  special setup.

  * running guest VM takes about 40M RAM from inside, from outside 576M
  are given to that machine

  * host has fast dual-core pentium cpu with virtualization support,
  around 8G of RAM and 7200rpm harddrive (dd from urandom to file gives
  about 20M/s)

  * running processes: sshd, atd (empty), crond (empty), libvirtd, tmux,
  bash, rsyslogd, upstart-socket-bridge, udevd, dnsmasq, iotop (python)

  * networking is done by bridging and bonding

  =

  Detail description
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  * Under root, command 'virsh create-snapshot 1' is issued on booted
  and running KVM machine with debian inside.

  * After about four minutes, the process is done.

  * 'iotop' shows two 'kvm' processes reading/writing to disk. First one
  has IO around 1500 K/s, second one has around 400 K/s. That takes
  about three minutes. Then first process grabs about 3 M/s of IO and
  suddenly dissapears (1-2 sec). Then second process does about 7.5 M/s
  of IO for around a 1-2 minutes.

  * Snapshot is successfuly created and is usable for reverting or
  extracting.

  * Pretty much the same behaviour occurs when command 'savevm' is
  issued directly from qemu monitor, without using libvirt at all
  (actually, virsh snapshot-create just calls 'savevm' to the monitor
  socket).

  * This behaviour was observed on lucid, meerkat, natty and even with
  git version of libvirt (f44bfb7fb978c9313ce050a1c4149bf04aa0a670).
  Also slowsave packages from
  https://bugs.launchpad.net/ubuntu/+source/libvirt/+bug/524447 gave
  this issue.

  =

  Thank you for helping to solve this issue!

  ProblemType: Bug
  DistroRelease: Ubuntu 11.04
  Package: libvirt-bin 0.8.8-1ubuntu5
  ProcVersionSignature: Ubuntu 2.6.38-7.38-server 2.6.38
  Uname: Linux 2.6.38-7-server x86_64
  Architecture: amd64
  Date: Thu Mar 24 12:19:41 2011
  InstallationMedia: Ubuntu-Server 10.04.2 LTS "Lucid Lynx" - Release amd64=
 (20110211.1)
  ProcEnviron:
   LANG=3Den_US.UTF-8
   SHELL=3D/bin/bash
  SourcePackage: libvirt
  UpgradeStatus: No upgrade log present (probably fresh install)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/741887/+subscriptions
