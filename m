Received: from eggs.gnu.org ([2001:4830:134:3::10]:38285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8RZQ-0006bB-6E
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 09:54:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8RZN-0003uk-Op
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 09:54:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:55912)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e8RZN-0003uJ-HU
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 09:54:37 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e8RZM-0006lu-Fu
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 13:54:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 6DB6D2E80CB
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 13:54:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Oct 2017 13:44:16 -0000
From: Thomas Huth <1279500@bugs.launchpad.net>
Reply-To: Bug 1279500 <1279500@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140212201614.1380.47280.malonedeb@gac.canonical.com>
Message-Id: <150919825642.19979.61030700971846962.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1279500] Re: system_powerdown causes SMP OpenBSD
 guest to freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets... can you still reproduce this issue with the
latest version of QEMU and OpenBSD? Or could we close this ticket
nowadays?


** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1279500

Title:
  system_powerdown causes SMP OpenBSD guest to freeze

Status in QEMU:
  Incomplete

Bug description:
  system_powerdown causes an SMP OpenBSD guest to freeze. I can
  reproduce it with the following systems/versions:

    - Debian 6: QEMU PC emulator version 0.12.5 (qemu-kvm-0.12.5)
    - Fedora 20:
       qemu-system-x86-1.6.1 (from Fedora repository)
       qemu-1.7.0 (latest release version)
       qemu-1.7.50 (latest development snapshot, "git cloned" today, 201402=
12)

  all of the above hosts are running x86_64 linux.

  The first OpenBSD version that I ran as a VM, v5.1, experienced the
  problem. All subsequent versions experience the problem. The above
  tests were performed using OpenBSD v5.4 (amd64).

  I will open an OpenBSD bug report for this problem as well, and update
  this report with the OpenBSD bug ID.

  There's an interesting RedHat bug report concerning this problem:
    URL: https://bugzilla.redhat.com/show_bug.cgi?id=3D508801#c34

  Here an excerpt:
  -snip-
  Gleb Natapov 2009-12-23 10:37:44 EST

  I posted patch to provide correct PCI irq routing info in mptable to kvm =

  mailing list. It works for all devices except for SCI interrupt. BIOS
  programs SCI interrupt to be 9 as spec requires, but OpenBSD thinks that
  it is smarter and moves it to interrupts 10. Qemu will still send it on
  vector 9 and OpenBSD will enter the same infinity recursion. This can
  be triggered by issuing system_powerdown on qemu monitor.
  -snip-

  Michael Tokarev reported this problem on the kvm mailing list in 2011:
    URL: http://www.spinics.net/lists/kvm/msg51311.html

  I compiled qemu as follows:
  -snip-
  cd qemu-src-dir
  mkdir -p bin/native
  cd bin/native
  ../../configure \
  	--prefix=3D/usr/local/qemu-dev-snapshot-20140212 \
  	--target-list=3Dx86_64-softmmu \
  	--enable-kvm \
  	--enable-spice \
  	--with-gtkabi=3D"3.0" \
  	--audio-drv-list=3Dpa,sdl,alsa,oss \
  	--extra-cflags=3D'-I/usr/include/SDL'
  -snip-

  I'm running OpenBSD with the following command:
  -snip-
  #!/bin/bash

  DEF=3D/usr/bin/qemu-system-x86_64
  QEMU_LATEST=3D/usr/local/qemu-1.7.0/bin/qemu-system-x86_64
  QEMU_DEV=3D/usr/local/qemu-dev-snapshot-20140212/bin/qemu-system-x86_64

  $QEMU_DEV \
  	-machine accel=3Dkvm \
  	-name obsdtest-v54 \
  	-S \
  	-machine pc-i440fx-1.6,accel=3Dkvm,usb=3Doff \
  	-boot c \
  	-m 2048 \
  	-realtime mlock=3Doff \
  	-smp 2,sockets=3D2,cores=3D1,threads=3D1 \
  	-uuid 8b685793-2510-473e-b97e-822a4cf2fbca \
  	-no-user-config \
  	-monitor stdio \
  	-rtc base=3Dutc,driftfix=3Dslew \
  	-global kvm-pit.lost_tick_policy=3Ddiscard \
  	-no-hpet \
  	-drive file=3D/guest_images/obsdtest_v54.raw,if=3Dnone,id=3Ddrive-virtio=
-disk0,format=3Draw,cache=3Dnone \
  	-device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x4,drive=3Ddrive-v=
irtio-disk0,id=3Dvirtio-disk0,bootindex=3D1 \
  	-drive if=3Dnone,id=3Ddrive-ide0-0-0,readonly=3Don,format=3Draw \
  	-device ide-cd,bus=3Dide.0,unit=3D0,drive=3Ddrive-ide0-0-0,id=3Dide0-0-0=
 \
  	-chardev pty,id=3Dcharserial0 \
  	-device isa-serial,chardev=3Dcharserial0,id=3Dserial0 \
  	-k en-us \
  	-device cirrus-vga,id=3Dvideo0,bus=3Dpci.0,addr=3D0x3 \
  	-device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x5 \
  	-net nic \
  	-net user
  -snip-

  The OpenBSD disk image I used for testing is 143MB compressed, 10G
  uncompressed. It can be found here:

    http://www.spielwiese.de/OpenBSD/obsd54.raw.7z

  The root password is "x".

  Rob Urban

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1279500/+subscriptions
