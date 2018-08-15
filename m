Received: from eggs.gnu.org ([2001:4830:134:3::10]:51100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fppiY-0005QL-6h
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 02:55:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fppiT-0000D6-0D
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 02:55:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:39148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fppiS-000086-7f
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 02:55:36 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fppiR-0000vN-1H
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 06:55:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D5D762E8520
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 06:55:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Aug 2018 06:43:01 -0000
From: Gerd Hoffmann <1787070@bugs.launchpad.net>
Reply-To: Bug 1787070 <1787070@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153429832178.24411.17323780348611441441.malonedeb@soybean.canonical.com>
Message-Id: <153431538146.24212.12141378941809056192.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1787070] Re: Guests using the qxl-vga are freezing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Can you attach gdb to qemu when the guest hangs, then run "thread apply
all bt"?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1787070

Title:
  Guests using the qxl-vga are freezing

Status in QEMU:
  New

Bug description:
  I have noticed that guests using qxl-vga are freezing. They may freeze
  after a few minutes or after many hours. The freeze consists of the
  entire system hanging, except the cursor, but the cursor animation
  stops too. Changing to tty is not possible after this. There are three
  things noticed in common on the guests when they freeze:

  -The guest is using the QXL VGA (freezes weren't observed with other VGAs=
);
  -A new workload is starting;
  -The mouse cursor is the animated as the one of loading. For example, htt=
ps://i.imgur.com/raQFteG.png
   =

  The host is Xubuntu 18.04 amd64, QEMU version is 3.0.0-dirty. The guests =
tested were:

  -openSUSE Tumbleweed;
  -openSUSE Leap 15;
  -Xubuntu 18.04 Bionic Beaver;
  -CentOS 7.

  With openSUSE guests, the install process couldn't even be finished,
  as the installer would freeze. There were 2 GB of available memory
  (checked in a tty before the freeze) and netconsole was enabled.
  Unfortunately, it was impossible to obtain any information from them.
  This is an image of one openSUSE guest frozen:
  https://i.imgur.com/ZP0eQKq.png

  The command line used was:

  qemu-system-x86_64 -nodefaults -m 3072 -M pc,usb=3Dtrue -accel kvm -cpu
  host -smp cores=3D2,threads=3D2 -device qemu-xhci -drive
  id=3Dcentusb,if=3Dnone,file=3Dleap.qcow2 -device usb-
  storage,id=3Dcentusb,drive=3Dcentusb -netdev user,id=3Dn0 -device usb-
  tablet,id=3Dusbtablet -device e1000,netdev=3Dn0 -device usb-
  audio,id=3Dusbaudio -device qxl-vga,xres=3D1366,yres=3D768 -display gtk
  -monitor vc -serial vc  -cdrom "openSUSE-Leap-15.0-DVD-x86_64.iso"
  -boot d

  With CentOS guests, the install process fail sometimes, but sometimes
  it's able to install. However, on the yum update, it would freeze too.
  In one instance it froze while updating glibc, which made the guest
  unbootable. https://i.imgur.com/B3WhSDX.png

  The command line used was:

  qemu-system-x86_64 -nodefaults -m 2048 -M pc,usb=3Dtrue -accel kvm -cpu
  host -smp cores=3D2,threads=3D2 -device qemu-xhci -drive
  id=3Dcentusb,if=3Dnone,file=3Dcentos.qcow2 -device usb-
  storage,id=3Dcentusb,drive=3Dcentusb -netdev user,id=3Dn0 -device usb-
  tablet,id=3Dusbtablet -device e1000,netdev=3Dn0 -device usb-
  audio,id=3Dusbaudio -device virtio-vga,virgl=3Dtrue -display gtk -monitor
  vc -serial vc -cdrom "CentOS-7-livecd-GNOME-x86_64.iso" -bios
  /usr/share/ovmf/OVMF.fd

  With Xubuntu 18.04 guests, the system worked for many hours until the
  freeze happened. On this case it happened when opening Audacious.
  Fortunately, the logging services worked for some time, which allowed
  me to get a relevant message which can be seen at
  http://termbin.com/nuof . It repeated a few times, but then the
  logging stopped. https://i.imgur.com/2zckqj5.png shows the guest
  screen in the moment it froze.

  The command line used was:

  qemu-system-x86_64 -nodefaults -m 1024 -M pc,usb=3Dtrue -accel kvm -cpu
  host -smp cores=3D2,threads=3D2 -device qemu-xhci -drive
  id=3Dcentusb,if=3Dnone,file=3Dxubmini -device usb-
  storage,id=3Dcentusb,drive=3Dcentusb -netdev user,id=3Dn0 -device usb-
  tablet,id=3Dusbtablet -device e1000,netdev=3Dn0 -device usb-
  audio,id=3Dusbaudio -device qxl-vga,xres=3D1366,yres=3D768 -display gtk
  -monitor vc -serial vc

  I'm sorry for not having more detailed information but, even setting
  netconsole, openSUSE and CentOS guests were unable to print any
  information.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1787070/+subscriptions
