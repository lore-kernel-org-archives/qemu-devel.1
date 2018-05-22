Received: from eggs.gnu.org ([2001:4830:134:3::10]:33501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fL2J0-00040T-Qd
	for qemu-devel@nongnu.org; Tue, 22 May 2018 04:06:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fL2Iu-0001RZ-O6
	for qemu-devel@nongnu.org; Tue, 22 May 2018 04:06:02 -0400
Received: from indium.canonical.com ([91.189.90.7]:33626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fL2Iu-0001RT-I9
	for qemu-devel@nongnu.org; Tue, 22 May 2018 04:05:56 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fL2Is-0007kv-0c
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 08:05:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 02F9A2E8F3C
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 08:05:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 May 2018 07:54:10 -0000
From: Gerd Hoffmann <1772262@bugs.launchpad.net>
Reply-To: Bug 1772262 <1772262@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152682211859.2906.10549449814583426718.malonedeb@gac.canonical.com>
Message-Id: <152697565052.17016.4910860570227506007.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1772262] Re: Adding -spice doesn't respect
 environment variable QEMU_AUDIO_DRV
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Doesn't reproduce.  The *default* driver is changed to spice when spice
is enabled, but overriding using QEMU_AUDIO_DRV is not disabled.  Any
chance you didn't export QEMU_AUDIO_DRV?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1772262

Title:
  Adding -spice doesn't respect environment variable QEMU_AUDIO_DRV

Status in QEMU:
  New

Bug description:
  When -spice is added to the commandline, QEMU_AUDIO_DRV=3Dalsa is not
  respected and I receive no audio from the guest using the alsa driver.
  When -spice options are omitted, audio works as usual.

  I want to channel mouse and keyboard events to the guest using spice
  (with looking-glass) instead of a third-party product over a network
  interface (with synergy), but audio ends up over the spice protocol as
  well instead of using alsa despite asking otherwise.  For example, one
  will only hear audio when a program like spicy is running.  Naturally
  it would be nice if this were not needed, since spice audio is gappier
  than regular audio on my machine.

  Perhaps if -spice added an option similar to agent-mouse=3Doff but for
  audio, (say audio-pipe=3Doff or so for example,) this might mitigate the
  issue in a more naive fashion UX-wise, without having to force the
  issue with environment variables that unfortunately for me don't seem
  to work. :(

  QEMU emulator version 2.12.0

  Commandline

          qemu-system-x86_64 \
            -ctrl-grab \
            -enable-kvm \
            -cpu host,hv-time,kvm=3Doff \
            -smp cores=3D4 \
            -m 8G \
            -M q35 \
            -vga none \
            -netdev tap,id=3Dhostnet,ifname=3Dtap1,script=3Dno,downscript=
=3Dno \
            -net nic,model=3Dvirtio,macaddr=3D52:54:FD:BF:F7:9A,netdev=3Dho=
stnet \
            -netdev user,id=3Dusernet,smb=3D/media/DRIVE-C/tux/vms/share \
            -net nic,model=3Dvirtio,macaddr=3D52:54:2E:40:4F:C8,netdev=3Dus=
ernet \
            -usb \
            -device usb-ehci,id=3Dehci \
            -device ioh3420,bus=3Dpcie.0,addr=3D1c,multifunction=3Don,port=
=3D1,chassis=3D1,id=3Droot.1 \
            -device vfio-pci,host=3D07:00.0,bus=3Droot.1,addr=3D00.0,multif=
unction=3Don,x-vga=3Don \
            -device ich9-intel-hda \
            -device hda-micro \
            -drive if=3Dvirtio,file=3Dvm/win10/disk.img,media=3Ddisk \
            -boot menu=3Don,splash=3Dsplash/boot.jpg,splash-time=3D5000 \
            -name win10 \
            -device ivshmem-plain,memdev=3Divshmem \
            -object memory-backend-file,id=3Divshmem,share=3Don,mem-path=3D=
/dev/shm/looking-glass,size=3D32M \
            -device virtio-serial-pci \
            -device virtserialport,chardev=3Dspicechannel0,name=3Dcom.redha=
t.spice.0 \
            -chardev spicevmc,id=3Dspicechannel0,name=3Dvdagent \
            -spice addr=3D127.0.0.1,port=3D5900,disable-ticketing

  When the last four options are not present, audio works as expected.
  This is with both a windows 10 guest and a windows 7 guest.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1772262/+subscriptions
