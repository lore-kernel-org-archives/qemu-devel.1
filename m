Received: from eggs.gnu.org ([2001:4830:134:3::10]:35847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e9qSi-0001qF-4v
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 06:41:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e9qSf-00022Z-1X
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 06:41:32 -0400
Received: from indium.canonical.com ([91.189.90.7]:39000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e9qSe-00022L-RK
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 06:41:28 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e9qSb-000576-BT
	for <qemu-devel@nongnu.org>; Wed, 01 Nov 2017 10:41:25 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 54E8F2E80CE
	for <qemu-devel@nongnu.org>; Wed,  1 Nov 2017 10:41:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Nov 2017 10:32:13 -0000
From: Denys Zagorui <1719339@bugs.launchpad.net>
Reply-To: Bug 1719339 <1719339@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150635197143.30872.17188090859541401647.malonedeb@wampee.canonical.com>
Message-Id: <150953233486.4653.6797865281205611933.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1719339] Re: serial8250: too much work for irq3
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
     Assignee: Denys Zagorui (dzagorui) =3D> (unassigned)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1719339

Title:
  serial8250: too much work for irq3

Status in QEMU:
  In Progress

Bug description:
  It's know issue and sometimes mentioned since 2007. But it seems not
  fixed.

  http://lists.gnu.org/archive/html/qemu-devel/2008-02/msg00140.html
  https://bugzilla.redhat.com/show_bug.cgi?id=3D986761
  http://old-list-archives.xenproject.org/archives/html/xen-devel/2009-02/m=
sg00696.html

  I don't think fixes like increases PASS_LIMIT
  (/drivers/tty/serial/8250.c) or remove this annoying message
  (https://patchwork.kernel.org/patch/3920801/) is real fix. Some fix
  was proposed by H. Peter Anvin  https://lkml.org/lkml/2008/2/7/485.

  Can reproduce on Debian Strech host (Qemu 1:2.8+dfsg-6+deb9u2), Ubuntu
  16.04.2 LTS (Qemu 1:2.5+dfsg-5ubuntu10.15) also tried to use master
  branch (QEMU emulator version 2.10.50 (v2.10.0-766-ga43415ebfd-dirty))
  if we write a lot of message into console (dmesg or dd if=3D/dev/zero
  of=3D/dev/ttyS1).

  /usr/local/bin/qemu-system-x86_64 -name guest=3Dultra1,debug-threads=3Don
  -S -object
  secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/domain-2=
7-ultra1
  /master-key.aes -machine pc-i440fx-2.8,accel=3Dkvm,usb=3Doff,dump-guest-
  core=3Doff -cpu Skylake-
  Client,ds=3Don,acpi=3Don,ss=3Don,ht=3Don,tm=3Don,pbe=3Don,dtes64=3Don,mon=
itor=3Don,ds_cpl=3Don,vmx=3Don,smx=3Don,est=3Don,tm2=3Don,xtpr=3Don,pdcm=3D=
on,osxsave=3Don,tsc_adjust=3Don,clflushopt=3Don,pdpe1gb=3Don
  -m 4096 -realtime mlock=3Doff -smp 4,sockets=3D1,cores=3D4,threads=3D1 -u=
uid
  4537ca29-73b2-40c3-9b43-666de182ba5f -display none -no-user-config
  -nodefaults -chardev
  socket,id=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/domain-27-ultra1/mon=
itor.sock,server,nowait
  -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc
  base=3Dutc,driftfix=3Dslew -global kvm-pit.lost_tick_policy=3Ddelay -no-h=
pet
  -no-shutdown -global PIIX4_PM.disable_s3=3D1 -global
  PIIX4_PM.disable_s4=3D1 -boot strict=3Don -device ich9-usb-
  ehci1,id=3Dusb,bus=3Dpci.0,addr=3D0x8.0x7 -drive
  file=3D/home/dzagorui/csr/csr_disk.qcow2,format=3Dqcow2,if=3Dnone,id=3Ddr=
ive-
  ide0-0-0 -device ide-hd,bus=3Dide.0,unit=3D0,drive=3Ddrive-
  ide0-0-0,id=3Dide0-0-0,bootindex=3D1 -netdev tap,fd=3D26,id=3Dhostnet0 -d=
evice
  e1000,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:a9:4c:86,bus=3Dpci.0,add=
r=3D0x3
  -chardev
  socket,id=3Dcharserial0,host=3D127.0.0.1,port=3D4000,telnet,server,nowait
  -device isa-serial,chardev=3Dcharserial0,id=3Dserial0 -chardev
  socket,id=3Dcharserial1,host=3D127.0.0.1,port=3D4001,telnet,server,nowait
  -device isa-serial,chardev=3Dcharserial1,id=3Dserial1 -device virtio-
  balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x2 -msg timestamp=3Don

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1719339/+subscriptions
