Received: from eggs.gnu.org ([2001:4830:134:3::10]:56438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fW1mo-0005DN-20
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 11:46:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fW1mj-0001yr-Tz
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 11:46:14 -0400
Received: from indium.canonical.com ([91.189.90.7]:43316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fW1mj-0001yT-O7
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 11:46:09 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fW1mi-0001dV-5O
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 15:46:08 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1FAB72E80D3
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 15:46:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 Jun 2018 15:35:03 -0000
From: =?utf-8?q?Murilo_Opsfelder_Ara=C3=BAjo?= <623852@bugs.launchpad.net>
Reply-To: Bug 623852 <623852@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100825083959.9657.28618.malonedeb@soybean.canonical.com>
Message-Id: <152959530419.1873.15388228966925973868.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 623852] Re: PPC emulation loops on booting a
 FreeBSD kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi, Nigel.

Support for powerpc64 is available since FreeBSD 9.0-RELEASE, I think.
FreeBSD 11.2-RC2 boots fine in QEMU (at commit 46012db666990ff2eed1d3dc)
running on an x86 host with accel=3Dtcg.  Below are the steps I have
followed to boot it.

Build QEMU:

$ mkdir build && cd build
$ ../configure --target-list=3Dppc64-softmmu
$ make -j$(nproc)

Boot FreeBSD:

$ wget http://ftp.freebsd.org/pub/FreeBSD/releases/powerpc/powerpc64/ISO-IM=
AGES/11.2/FreeBSD-11.2-RC2-powerpc-powerpc64-disc1.iso
$ ./qemu-img create -f qcow2 freebsd.qcow2 10G
$ ./ppc64-softmmu/qemu-system-ppc64 -name freebsd -machine pseries,accel=3D=
tcg,usb=3Doff -m 1024 -realtime mlock=3Doff -smp 4,sockets=3D4,cores=3D1,th=
reads=3D1 -nographic -no-user-config -nodefaults -rtc base=3Dutc -no-shutdo=
wn -boot strict=3Don -device pci-bridge,chassis_nr=3D1,id=3Dpci.1,bus=3Dpci=
.0,addr=3D0x1 -device pci-ohci,id=3Dusb,bus=3Dpci.0,addr=3D0x2 -device spap=
r-vscsi,id=3Dscsi0,reg=3D0x2000 -drive file=3Dfreebsd.qcow2,format=3Dqcow2,=
if=3Dnone,id=3Ddrive-scsi0-0-0-0 -device scsi-hd,bus=3Dscsi0.0,channel=3D0,=
scsi-id=3D0,lun=3D0,drive=3Ddrive-scsi0-0-0-0,id=3Dscsi0-0-0-0,bootindex=3D=
1 -drive file=3DFreeBSD-11.2-RC2-powerpc-powerpc64-disc1.iso,format=3Draw,i=
f=3Dnone,id=3Ddrive-scsi0-0-1-0,readonly=3Don -device scsi-cd,bus=3Dscsi0.0=
,channel=3D0,scsi-id=3D1,lun=3D0,drive=3Ddrive-scsi0-0-1-0,id=3Dscsi0-0-1-0=
,bootindex=3D2 -netdev user,id=3Dhostnet0 -device spapr-vlan,netdev=3Dhostn=
et0,id=3Dnet0,mac=3D4c:45:42:45:01:18,reg=3D0x1000 -device virtio-balloon-p=
ci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x4 -msg timestamp=3Don -serial mon:std=
io

Since this bug is almost 8 years old and FreeBSD powerpc64 seems to be
working just fine, I will close it.  Feel free to submit a new one if
needed.

Cheers
Murilo

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/623852

Title:
  PPC emulation loops on booting a FreeBSD kernel

Status in QEMU:
  Invalid

Bug description:
  Has anyone tried booting FreeBSD8.1-ppc under QEMU (Linux x86_64 host;
  PPC guest)?  I can get Linux/PPC to run fine, and FreeBSD8.1-i386 as
  well; but there seems to be a problem with whatever the FreeBSD8.1
  kernel does, that QEMU's PPC emulation can't handle.

  I am using the latest version of QEMU from GIT as of 25/8/10.  I don't
  know how to get a "git commit hash", so I can't quote it.

  The kernel starts OK then loops after "Kernel entry at 0x100100 ...".

  The command I am running is

  qemu-system-ppc -cdrom FreeBSD-8.1-RELEASE-powerpc-disc1.iso -hda
  freebsd8.1-ppc -m 94 -boot d"

  I obtained the kernel from
  ftp://ftp.freebsd.org/pub/FreeBSD/releases/powerpc/ISO-
  IMAGES/8.1/FreeBSD-8.1-RELEASE-powerpc-disc1.iso.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/623852/+subscriptions
