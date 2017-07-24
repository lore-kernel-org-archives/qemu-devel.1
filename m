Received: from eggs.gnu.org ([2001:4830:134:3::10]:52531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dZewR-0002ps-8F
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 11:06:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dZewN-0003sL-Ph
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 11:06:39 -0400
Received: from indium.canonical.com ([91.189.90.7]:41048)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dZewN-0003qq-JF
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 11:06:35 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dZewM-0001rl-A3
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 15:06:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2FCE42E80D5
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 15:06:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Jul 2017 14:45:56 -0000
From: Peter Maloney <1488363@bugs.launchpad.net>
Reply-To: Bug 1488363 <1488363@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150825072208.27483.25891.malonedeb@chaenomeles.canonical.com>
Message-Id: <150090755716.6327.14843448706448084568.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1488363] Re: qemu 2.4.0 hangs using vfio for pci
 passthrough of graphics card
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
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1488363

Title:
  qemu 2.4.0 hangs using vfio for pci passthrough of graphics card

Status in QEMU:
  Fix Released

Bug description:
  2.3.0 (manjaro distro package) works fine. 2.4.0 (manjaro or the arch
  vanilla one) hangs on the SeaBIOS screen when saying "Press F12 for
  boot menu". All tested with the same hardware, OS, command and
  configuration. It also starts without the GPU passed through, even
  with the USB passed through. I am using the latest SeaBIOS 1.8.2.

  The release notes say:
   VFIO
      Support for resetting AMD Bonaire and Hawaii GPUs
      Platform device passthrough support for Calxeda xgmac devices =

      =

  So maybe something there broke it.
      =

  I am using the arch qemu 2.4.0 PKGBUILD (modified to have make -j8 and re=
moved iscsi, gluster, ceph, etc.), which uses vanilla sources and no patche=
s. https://projects.archlinux.org/svntogit/packages.git/tree/trunk?h=3Dpack=
ages/qemu

  I am not using a frontend. I am using a script I wrote that generates
  the command below.

  Guest OS here would be 64 bit windows 7, but it didn't start so that's
  not relevant. Also a Manjaro Linux VM won't start.

  CPU is AMD FX-8150; board is Gigabyte GA-990FXA-UD5 (990FX chipset).

  full command line (without the \ after each line) is:

  qemu-system-x86_64
      -enable-kvm
      -M q35
      -m 3584
      -cpu host
      -boot c
      -smp 7,sockets=3D1,cores=3D7,threads=3D1
      -vga none
      -device ioh3420,bus=3Dpcie.0,addr=3D1c.0,port=3D1,chassis=3D1,id=3Dro=
ot.1
      -device vfio-pci,host=3D04:00.0,bus=3Droot.1,multifunction=3Don,x-vga=
=3Don,addr=3D0.0,romfile=3DSapphire.R7260X.1024.131106.rom
      -device vfio-pci,host=3D00:14.2,bus=3Dpcie.0
      -device vfio-pci,host=3D00:16.0,bus=3Droot.1
      -device vfio-pci,host=3D00:16.2,bus=3Droot.1
      -usb
      -device ahci,bus=3Dpcie.0,id=3Dahci
      -drive file=3D/dev/data/vm1,id=3Ddisk1,format=3Draw,if=3Dvirtio,index=
=3D0,media=3Ddisk,discard=3Don
      -drive media=3Dcdrom,id=3Dcdrom,index=3D5,media=3Dcdrom
      -netdev type=3Dtap,id=3Dnet0,ifname=3Dtap-vm1
      -device virtio-net-pci,netdev=3Dnet0,mac=3D00:01:02:03:04:05
      -monitor stdio
      -boot menu=3Don

  =

  $ lspci -nn | grep -E "04:00.0|00:14.2|00:16.0|00:16.2"
  00:14.2 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ATI] SBx00=
 Azalia (Intel HDA) [1002:4383] (rev 40)
  00:16.0 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD/ATI] SB7=
x0/SB8x0/SB9x0 USB OHCI0 Controller [1002:4397]
  00:16.2 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD/ATI] SB7=
x0/SB8x0/SB9x0 USB EHCI Controller [1002:4396]
  04:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [A=
MD/ATI] Bonaire XTX [Radeon R7 260X] [1002:6658]

  =

  Also I have this one that also hangs:
  05:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [A=
MD/ATI] Juniper XT [Radeon HD 6770] [1002:68ba]

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1488363/+subscriptions
