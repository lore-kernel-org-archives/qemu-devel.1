Received: from eggs.gnu.org ([2001:4830:134:3::10]:32954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eDIpW-0002is-TA
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 18:35:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eDIpT-0006Wk-NN
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 18:35:22 -0500
Received: from indium.canonical.com ([91.189.90.7]:45416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eDIpT-0006Uw-DW
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 18:35:19 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eDIpP-0007jC-9A
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 23:35:15 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2A6A52E8078
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 23:35:15 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Nov 2017 23:22:20 -0000
From: "Robin H. Johnson" <1563887@bugs.launchpad.net>
Reply-To: Bug 1563887 <1563887@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160330141641.3353.24299.malonedeb@chaenomeles.canonical.com>
Message-Id: <151035614073.28762.53199958527078216.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1563887] Re: qemu-system-ppc64 freezes on
 starting image on ppc64le
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

TL;DR: pass '-vga none' with -nographic, or redirect the screen
somewhere!

I ended up digging into this after it was mentioned by smoser. The bug
is invalid because of a bad assumption in the QEMU inputs. smoser's
workaround of usb=3Doff removes USB as a workaround.

The kernel, OpenFirmware, and QEMU are behaving correctly, but the
original command-line hides the screen output.

If you have both a supported* keyboard AND screen, then OpenFirmware/SLOF s=
ets OF stdout to be the screen.
This causes the OF output of 'No console specified using screen & keyboard'

If you are missing either a keyboard OR screen, then OF sets stdout to be h=
vterm (serial).
This causes the OF output of 'No console specified using hvterm'

https://git.qemu.org/?p=3DSLOF.git;a=3Dblob;f=3Dboard-
qemu/slof/OF.fs;h=3D4e04b840d5e6ff6c39191939e1a4f70f3d169d5d;hb=3DHEAD#l215

Which devices are available depends on the QEMU commandline...
Base QEMU defaults to '-vga std'.
QEMU '-machine pseries' defaults to enabling USB.


Re supported keyboards: The OpenFirmware/SLOF only seems to support USB key=
boards at this time (virtio keyboard not supported).

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1563887

Title:
  qemu-system-ppc64 freezes on starting image on ppc64le

Status in QEMU:
  Invalid
Status in linux package in Ubuntu:
  Invalid
Status in livecd-rootfs package in Ubuntu:
  Invalid
Status in qemu package in Ubuntu:
  Invalid

Bug description:
  qemu-system-ppc64 running on Ubuntu 16.04 beta-2 fails to start an
  image as part of the certification process. This on an IBM ppc64le in
  PowerVM mode running Ubuntu 16.04 beta-2 deployed by MAAS 1.9.1. There
  is no error output.

  ubuntu@alpine01:~/kvm$ qemu-system-ppc64 -m 256 -display none -nographic =
-net nic -net user,net=3D10.0.0.0/8,host=3D10.0.0.1,hostfwd=3Dtcp::2222-:22=
 -machine pseries -drive file=3Dxenial-server-cloudimg-ppc64el-disk1.img,if=
=3Dvirtio -drive file=3Dseed.iso,if=3Dvirtio
  WARNING: Image format was not specified for 'seed.iso' and probing guesse=
d raw.
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Automatically detec=
ting the format is dangerous for raw images, write operations on block 0 wi=
ll be restricted.
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Specify the 'raw' f=
ormat explicitly to remove the restrictions.

  SLOF ********************************************************************=
**
  QEMU Starting
  =C2=A0Build Date =3D Jan 29 2016 18:58:37
  =C2=A0FW Version =3D buildd@ release 20151103
  =C2=A0Press "s" to enter Open Firmware.

  Populating /vdevice methods
  Populating /vdevice/vty@71000000
  Populating /vdevice/nvram@71000001
  Populating /vdevice/l-lan@71000002
  Populating /vdevice/v-scsi@71000003
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SCSI: Looking for devices
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A08200000000000=
000 CD-ROM   : "QEMU     QEMU CD-ROM      2.5+"
  Populating /pci@800000020000000
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A000 1800 (D) : 1af4 10=
01    virtio [ block ]
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A000 1000 (D) : 1af4 10=
01    virtio [ block ]
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A000 0800 (D) : 106b 00=
3f    serial bus [ usb-ohci ]
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A000 0000 (D) : 1234 11=
11    qemu vga
  No NVRAM common partition, re-initializing...
  Installing QEMU fb

  Scanning USB
  =C2=A0=C2=A0OHCI: initializing
  =C2=A0=C2=A0=C2=A0=C2=A0USB Keyboard
  =C2=A0=C2=A0=C2=A0=C2=A0USB mouse
  No console specified using screen & keyboard

  =C2=A0=C2=A0Welcome to Open Firmware

  =C2=A0=C2=A0Copyright (c) 2004, 2011 IBM Corporation All rights reserved.
  =C2=A0=C2=A0This program and the accompanying materials are made available
  =C2=A0=C2=A0under the terms of the BSD License available at
  =C2=A0=C2=A0http://www.opensource.org/licenses/bsd-license.php

  Trying to load:  from: /pci@800000020000000/scsi@3 ...
  E3404: Not a bootable device!
  Trying to load:  from: /pci@800000020000000/scsi@2 ...   Successfully loa=
ded
  Linux ppc64le
  #31-Ubuntu SMP F

  ProblemType: Bug
  DistroRelease: Ubuntu 16.04
  Package: qemu-system-ppc 1:2.5+dfsg-5ubuntu6
  ProcVersionSignature: Ubuntu 4.4.0-16.32-generic 4.4.6
  Uname: Linux 4.4.0-16-generic ppc64le
  ApportVersion: 2.20-0ubuntu3
  Architecture: ppc64el
  Date: Wed Mar 30 14:10:01 2016
  KvmCmdLine:
  =C2=A0COMMAND         STAT  EUID  RUID   PID  PPID %CPU COMMAND
  =C2=A0kvm-irqfd-clean S<       0     0  1172     2  0.0 [kvm-irqfd-clean]
  =C2=A0qemu-nbd        Ssl      0     0 13467     1  0.0 qemu-nbd -c /dev/=
nbd0 xenial-server-cloudimg-ppc64el-disk1.img
  =C2=A0qemu-system-ppc Sl+   1000  1000 18973 18896  101 qemu-system-ppc64=
 -m 256 -display none -nographic -net nic -net user,net=3D10.0.0.0/8,host=
=3D10.0.0.1,hostfwd=3Dtcp::2222-:22 -machine pseries -drive file=3Dxenial-s=
erver-cloudimg-ppc64el-disk1.img,if=3Dvirtio -drive file=3Dseed.iso,if=3Dvi=
rtio
  Lsusb: Error: command ['lsusb'] failed with exit code 1:
  ProcEnviron:
  =C2=A0TERM=3Dxterm
  =C2=A0PATH=3D(custom, no user)
  =C2=A0LANG=3Den_US.UTF-8
  =C2=A0SHELL=3D/bin/bash
  ProcKernelCmdLine: BOOT_IMAGE=3D/boot/vmlinux-4.4.0-16-generic root=3DUUI=
D=3D92d820c8-ab25-497b-9b1e-f1435992bbf3 ro
  ProcLoadAvg: 1.08 0.94 0.58 2/616 19571
  ProcLocks:
  =C2=A01: POSIX  ADVISORY  WRITE 886 00:13:381 0 EOF
  =C2=A02: POSIX  ADVISORY  WRITE 1339 00:13:528 0 EOF
  =C2=A03: FLOCK  ADVISORY  WRITE 1284 00:13:522 0 EOF
  =C2=A04: POSIX  ADVISORY  WRITE 2281 00:13:563 0 EOF
  =C2=A05: POSIX  ADVISORY  WRITE 1331 00:13:536 0 EOF
  ProcSwaps:
  =C2=A0Filename				Type		Size	Used	Priority
  =C2=A0/swap.img                               file		8388544	0	-1
  ProcVersion: Linux version 4.4.0-16-generic (buildd@bos01-ppc64el-001) (g=
cc version 5.3.1 20160320 (Ubuntu/Linaro/IBM 5.3.1-12ubuntu4) ) #32-Ubuntu =
SMP Thu Mar 24 22:31:14 UTC 2016
  SourcePackage: qemu
  UpgradeStatus: No upgrade log present (probably fresh install)
  bootlist:
  =C2=A0/pci@800000020000011/pci1014,034A@0/sas/disk@4068402c40
  =C2=A0/pci@800000020000018/ethernet@0:speed=3Dauto,duplex=3Dauto,csarch,0=
00.000.000.000,,000.000.000.000,000.000.000.000,5,5,000.000.000.000,512
  =C2=A0/pci@800000020000018/ethernet@0,1:speed=3Dauto,duplex=3Dauto,csarch=
,000.000.000.000,,000.000.000.000,000.000.000.000,5,5,000.000.000.000,512
  =C2=A0/pci@800000020000018/ethernet@0,2:speed=3Dauto,duplex=3Dauto,csarch=
,000.000.000.000,,000.000.000.000,000.000.000.000,5,5,000.000.000.000,512
  =C2=A0/pci@800000020000018/ethernet@0,3:speed=3Dauto,duplex=3Dauto,csarch=
,000.000.000.000,,000.000.000.000,000.000.000.000,5,5,000.000.000.000,512
  cpu_cores: Number of cores present =3D 8
  cpu_coreson: Number of cores online =3D 8
  cpu_smt: SMT=3D8
  lscfg_vp: Error: [Errno 2] No such file or directory: 'lscfg'
  lsmcode: Error: [Errno 2] No such file or directory: 'lsmcode'

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1563887/+subscriptions
