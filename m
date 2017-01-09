Received: from eggs.gnu.org ([2001:4830:134:3::10]:53748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cQW8e-0004Fj-EJ
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 04:21:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cQW8Z-0003ty-Ht
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 04:21:12 -0500
Received: from indium.canonical.com ([91.189.90.7]:40159)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cQW8Z-0003tf-BH
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 04:21:07 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cQW8U-0001tD-Sz
	for <qemu-devel@nongnu.org>; Mon, 09 Jan 2017 09:21:03 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7763E2E80E5
	for <qemu-devel@nongnu.org>; Mon,  9 Jan 2017 09:21:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Jan 2017 09:01:43 -0000
From: Thomas Huth <551545@bugs.launchpad.net>
Reply-To: Bug 551545 <551545@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100330095419.20764.2684.malonedeb@potassium.ubuntu.com>
Message-Id: <20170109090143.21242.82806.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 551545] Re: PXE netboot not booting localboot
 from virtio-disk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Since it has been fixed in Precise ... I assume this has also been fixed
in upstream QEMU? Or is there still anything left to do here?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/551545

Title:
  PXE netboot not booting localboot from virtio-disk

Status in QEMU:
  Incomplete
Status in qemu-kvm package in Ubuntu:
  Fix Released
Status in qemu-kvm package in Fedora:
  Unknown

Bug description:
  Binary package hint: qemu-kvm

  lsb_release -rd
  Description:	Ubuntu lucid (development branch)
  Release:	10.04

  apt-cache policy qemu-kvm
  qemu-kvm:
    Installiert: 0.12.3+noroms-0ubuntu3
    Kandidat: 0.12.3+noroms-0ubuntu3
    Versions-Tabelle:
   *** 0.12.3+noroms-0ubuntu3 0
          500 http://intranet/ubuntu/ lucid/main Packages
          100 /var/lib/dpkg/status

  Description of the problem:

  Starting a guest like this:

  vdekvm \
    -m 256M \
    -cpu host \
    -smp 1 \
    -name karmic \
    -boot order=3Dnc \
    -drive file=3D/dev/vg01/test,if=3Dvirtio,boot=3Don,cache=3Dnone \
    -net nic,vlan=3D0,macaddr=3D00:2f:8d:b6:cf:d0,model=3Dvirtio \
    -net vde,vlan=3D0,sock=3D/var/run/vde2/vde0.ctl \
    -watchdog i6300esb \
    -vnc :0 \
    -serial telnet:localhost:23,server,nowait \
    -monitor tcp:127.0.0.1:12000,server,nowait \
    -runas kvmguest

  On "telnet localhost" you can see that the following boot-menu
  appears:

  - Boot Menu -
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  local
  rescue

  It is loaded from this pxelinux.cfg/default file:

  SERIAL 0 9600n8

  DISPLAY boot.txt

  TIMEOUT 120
  DEFAULT local
  PROMPT 1

  LABEL local
  	localboot 0

  LABEL rescue
  	kernel lucid
  	append initrd=3Dlucid-initrd.gz rescue/enable=3Dtrue -- quiet console=3D=
ttyS0,9600n8

  =

  After the timeout, the guest tries to boot, but fails and reloads the boo=
t menu. This is an endless loop, until I break it or choose the rescue menu=
 entry.

  I would expect that it boots from first virtio-disk

  ProblemType: Bug
  DistroRelease: Ubuntu 10.04
  Package: qemu-kvm 0.12.3+noroms-0ubuntu3
  ProcVersionSignature: Ubuntu 2.6.32-18.27-generic 2.6.32.10+drm33.1
  Uname: Linux 2.6.32-18-generic x86_64
  Architecture: amd64
  Date: Tue Mar 30 11:40:59 2010
  ExecutablePath: /usr/bin/qemu-system-x86_64
  MachineType: MICRO-STAR INTERANTIONAL CO.,LTD MS-7368
  ProcCmdLine: root=3DUUID=3D0d27271c-feaa-40d9-bbbd-baff4ca1d3cc rw init=
=3D/bin/bash
  ProcEnviron:
   LANG=3Dde_DE.UTF-8
   SHELL=3D/bin/bash
  SourcePackage: qemu-kvm
  dmi.bios.date: 10/31/2007
  dmi.bios.vendor: American Megatrends Inc.
  dmi.bios.version: V1.5B2
  dmi.board.asset.tag: To Be Filled By O.E.M.
  dmi.board.name: MS-7368
  dmi.board.vendor: MICRO-STAR INTERANTIONAL CO.,LTD
  dmi.board.version: 1.0
  dmi.chassis.asset.tag: To Be Filled By O.E.M.
  dmi.chassis.type: 3
  dmi.chassis.vendor: To Be Filled By O.E.M.
  dmi.chassis.version: To Be Filled By O.E.M.
  dmi.modalias: dmi:bvnAmericanMegatrendsInc.:bvrV1.5B2:bd10/31/2007:svnMIC=
RO-STARINTERANTIONALCO.,LTD:pnMS-7368:pvr1.0:rvnMICRO-STARINTERANTIONALCO.,=
LTD:rnMS-7368:rvr1.0:cvnToBeFilledByO.E.M.:ct3:cvrToBeFilledByO.E.M.:
  dmi.product.name: MS-7368
  dmi.product.version: 1.0
  dmi.sys.vendor: MICRO-STAR INTERANTIONAL CO.,LTD

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/551545/+subscriptions
