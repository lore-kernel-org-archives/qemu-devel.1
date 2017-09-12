Received: from eggs.gnu.org ([2001:4830:134:3::10]:40969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1drl7m-0006as-6a
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:21:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1drl7i-0002Wl-Nh
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:21:10 -0400
Received: from indium.canonical.com ([91.189.90.7]:33000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1drl7i-0002W0-GZ
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:21:06 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1drl7e-0001QJ-Vz
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 13:21:03 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8556D2E8500
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 13:20:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 Sep 2017 13:11:12 -0000
From: Scott Moser <smoser@ubuntu.com>
Reply-To: Bug 1716028 <1716028@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150489404292.23034.16812601554685741285.malonedeb@wampee.canonical.com>
Message-Id: <150522187313.22438.18018057700251653602.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1716028] Re: qemu 2.10 locks images with no
 feature flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Your example does work (using -blockdev), but I can't get it to work with
-drive.

$ qemu-system-x86_64 \
   -drive id=3Dd01,file=3Ddisk1.img,format=3Dqcow2 \
   -device drive=3Dd01,serial=3Ds01,driver=3Dvirtio-blk,index=3D1,share-rw=
=3Don \
   -device drive=3Dd01,serial=3Ds01,driver=3Dvirtio-blk,index=3D2,share-rw=
=3Don
warning: TCG doesn't support requested feature: CPUID.01H:ECX.vmx [bit 5]
qemu-system-x86_64: -device drive=3Dd01,serial=3Ds01,driver=3Dvirtio-blk,in=
dex=3D1,share-rw=3Don: Drive 'd01' is already in use because it has been au=
tomatically connected to another device (did you need 'if=3Dnone' in the dr=
ive options?)


## ok, fix that error, add 'if=3Dnone' to the -drive.

$ qemu-system-x86_64  \
  -drive id=3Dd01,file=3Ddisk1.img,format=3Dqcow2,if=3Dnone \
  -device virtio-blk,drive=3Dd01,serial=3Ds01,index=3D1,share-rw=3Don \
  -device virtio-blk,drive=3Dd01,serial=3Ds01,index=3D2,share-rw=3Don
qemu-system-x86_64: -device drive=3Dd01,serial=3Ds01,driver=3Dvirtio-blk,in=
dex=3D1,share-rw=3Don: Property '.index' not found

## ok, index belongs on the -drive (which I should have known from
## the past, but which seems not the right place).  Try that anyway.

$ qemu-system-x86_64  \
  -drive id=3Dd01,file=3Ddisk1.img,format=3Dqcow2,if=3Dnone,index=3D1  \
  -device virtio-blk,drive=3Dd01,serial=3Ds01,share-rw=3Don \
  -device virtio-blk,drive=3Dd01,serial=3Ds01,share-rw=3Don
qemu-system-x86_64: -device drive=3Dd01,serial=3Ds01,driver=3Dvirtio-blk,sh=
are-rw=3Don: Drive 'd01' is already in use by another device

## Huh?  Isn't that what I said to explicitly allow with share-rw=3Don?

Note that I've also tried with 'format=3Draw'.  Is there something I'm
missing to try to use -drive and -device ?

Lastly (if you're still reading), how do  you specify the format of
the file to -blockdev ?  adding 'format=3Dqcow2' makes qemu complain that
"'format' is unexpected".

Thanks for your time.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1716028

Title:
  qemu 2.10 locks images with no feature flag

Status in QEMU:
  New
Status in qemu package in Ubuntu:
  New

Bug description:
  1) % lsb_release -rd
  Description:	Ubuntu Artful Aardvark (development branch)
  Release:	17.10

  2) % apt-cache policy qemu-system-x86
  qemu-system-x86:
    Installed: 1:2.10~rc3+dfsg-0ubuntu1
    Candidate: 1:2.10+dfsg-0ubuntu1
    Version table:
       1:2.10+dfsg-0ubuntu1 500
          500 http://archive.ubuntu.com//ubuntu devel/main amd64 Packages
   *** 1:2.10~rc3+dfsg-0ubuntu1 100
          100 /var/lib/dpkg/status

  3) qemu locks image files with no way to discover this feature nor how
  to disable it

  4) qemu provides a way to query if it supports image locking, and what
  the default value is, and how to disable the locking via cli

  qemu 2.10 now will lock image files and warn if an image is currently
  locked.  This prevent qemu from running (and possibly corrupting said
  image).

  However, qemu does not provide any way to determine if a qemu binary
  actually has this capability.  Normally behavior changing features are
  exposed via some change to the qemu help menu or QMP/QAPI output of
  capabilities.

  I believe this slipped through since libvirt already does image
  locking, but direct cli users will be caught by this change.

  In particular, we have a use-case where we simulate multipath disks by
  creating to disks which point to the same file which now breaks
  without adding the 'file.locking=3Doff' to the -drive parameters;  which
  is also completely undocumented and unexposed.

  Some parts of the cli like -device allow querying of settable options
  (qemu-system-x86 -device scsi_hd,?)  but nothing equivalent exists for
  -drive parameters.

  ProblemType: Bug
  DistroRelease: Ubuntu 17.10
  Package: qemu-system-x86 1:2.10~rc3+dfsg-0ubuntu1
  ProcVersionSignature: Ubuntu 4.12.0-11.12-generic 4.12.5
  Uname: Linux 4.12.0-11-generic x86_64
  NonfreeKernelModules: zfs zunicode zavl zcommon znvpair
  ApportVersion: 2.20.6-0ubuntu7
  Architecture: amd64
  Date: Fri Sep  8 12:56:53 2017
  JournalErrors:
   Hint: You are currently not seeing messages from other users and the sys=
tem.
         Users in groups 'adm', 'systemd-journal' can see all messages.
         Pass -q to turn off this notice.
   -- Logs begin at Mon 2017-01-30 11:56:02 CST, end at Fri 2017-09-08 12:5=
6:46 CDT. --
   -- No entries --
  KvmCmdLine: COMMAND         STAT  EUID  RUID   PID  PPID %CPU COMMAND
  MachineType: HP ProLiant DL360 Gen9
  ProcEnviron:
   TERM=3Dxterm
   PATH=3D(custom, no user)
   XDG_RUNTIME_DIR=3D<set>
   LANG=3Den_US.UTF-8
   SHELL=3D/bin/bash
  ProcKernelCmdLine: BOOT_IMAGE=3D/vmlinuz-4.12.0-11-generic root=3DUUID=3D=
45354276-e0c0-4bf6-9083-f130b89411cc ro --- console=3DttyS1,115200
  SourcePackage: qemu
  UpgradeStatus: No upgrade log present (probably fresh install)
  dmi.bios.date: 03/05/2015
  dmi.bios.vendor: HP
  dmi.bios.version: P89
  dmi.chassis.type: 23
  dmi.chassis.vendor: HP
  dmi.modalias: dmi:bvnHP:bvrP89:bd03/05/2015:svnHP:pnProLiantDL360Gen9:pvr=
:cvnHP:ct23:cvr:
  dmi.product.family: ProLiant
  dmi.product.name: ProLiant DL360 Gen9
  dmi.sys.vendor: HP

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1716028/+subscriptions
