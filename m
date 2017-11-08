Received: from eggs.gnu.org ([2001:4830:134:3::10]:46536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eCT6J-0007C4-11
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:21:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eCT6C-0000QP-IL
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:21:14 -0500
Received: from indium.canonical.com ([91.189.90.7]:43042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eCT6C-0000Pr-B1
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:21:08 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eCT6B-0005Ed-2V
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 16:21:07 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0BDF12E80C9
	for <qemu-devel@nongnu.org>; Wed,  8 Nov 2017 16:21:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Nov 2017 16:10:24 -0000
From: ChristianEhrhardt <1716028@bugs.launchpad.net>
Reply-To: Bug 1716028 <1716028@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150489404292.23034.16812601554685741285.malonedeb@wampee.canonical.com>
Message-Id: <151015742406.3019.333660367492678765.malone@gac.canonical.com>
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

We had a discussion today on how to workaround if you drive qmeu via libvir=
t.
While discussions often and up at the correctness of such setups they exist=
s, I think it is worth to document until libvirt supports that officially.

TL:DR:
- no native libvirt feature yet
- discussions if <shareable/> should set it
- workaround available via cmdline

Details on the workaround:
- To use the workaround you have to check your log usually in /var/log/libv=
irt/qemu/<guestname>.log
- Get the id of the device that matters to you
- then use [1] to tweak qemu cmdline
- example is from [2] to [3]

[1]: http://blog.vmsplice.net/2011/04/how-to-pass-qemu-command-line-options=
.html
[2]: https://gist.github.com/anonymous/a2ce3cbf7878995537212f0dafd06d99
[3]: https://gist.github.com/anonymous/07a357af9e34172b60c83d410fe63fdd

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
