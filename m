Received: from eggs.gnu.org ([2001:4830:134:3::10]:48800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eRq0P-0005Yc-Fc
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 20:50:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eRq0M-0000Cs-CF
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 20:50:41 -0500
Received: from indium.canonical.com ([91.189.90.7]:36010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eRq0M-0000CF-2e
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 20:50:38 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eRq0H-0007Ns-QS
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 01:50:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C44112E806B
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 01:50:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 Dec 2017 01:41:50 -0000
From: Gustavo Moreira <gmoreira@gmail.com>
Reply-To: Bug 1739378 <1739378@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151375741208.25451.9053884797959645588.malonedeb@wampee.canonical.com>
Message-Id: <151382051125.18701.14271864385452944829.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1739378] Re: qemu git master snapshot doesn't work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Description changed:

  I'm having different issues trying to have QEMU snapshots working using
  qemu-system-arm with vexpress-a15 board.
  =

  In this opportunity, I'm trying the git master head version:
  # git rev-parse HEAD
  af352675efb7e92a1f5f6461a042a12015ab3d12
  =

- $ /usr/local/bin/qemu-system-arm -kernel kernel/vmlinuz-4.10.0-42-generic=
 -initrd kernel/initrd.img-4.10.0-42-generic -M vexpress-a15 -m 2048 -appen=
d 'root=3D/dev/mmcblk0 rootwait console=3Dtty0' -sd vexpress-4G.qcow2 -dtb =
device-tree/vexpress-v2p-ca15-tc1.dtb  =

+ $ /usr/local/bin/qemu-system-arm -kernel kernel/vmlinuz-4.10.0-42-generic=
 -initrd kernel/initrd.img-4.10.0-42-generic -M vexpress-a15 -m 2048 -appen=
d 'root=3D/dev/mmcblk0 rootwait console=3Dtty0' -sd vexpress-4G.qcow2 -dtb =
device-tree/vexpress-v2p-ca15-tc1.dtb
  audio: Could not init `oss' audio driver
  =

  Later on, when the machine finishes booting I savevm ss and quit.
  However, when I try to restore it, I have that Missing section footer
  error:
  =

  $ /usr/local/bin/qemu-system-arm -kernel kernel/vmlinuz-4.10.0-42-generic=
 -initrd kernel/initrd.img-4.10.0-42-generic -M vexpress-a15 -m 2048 -appen=
d 'root=3D/dev/mmcblk0 rootwait console=3Dtty0' -sd vexpress-4G.qcow2 -dtb =
device-tree/vexpress-v2p-ca15-tc1.dtb  -loadvm ss
  audio: Could not init `oss' audio driver
  qemu-system-arm: Missing section footer for sd-card
  qemu-system-arm: Error -22 while loading VM state
  =

- =

  OS: Ubuntu 16.04.3 LTS (xenial)
  =

  $ gcc --version
  gcc (Ubuntu 5.4.0-6ubuntu1~16.04.5) 5.4.0 20160609
+ =

+ How have I built it?
+ # git clone git://git.qemu.org/qemu.git
+ # cd qemu
+ # git submodule update --init --checkout
+ # make clean && ./configure --target-list=3Darm-softmmu && make -j8
+ # sudo make install
  =

  I've also tried a different ./configure line, explicitly enabling some
  of the features, i.e. smartcard, with the same results:
  =

  ./configure '--disable-user' '--enable-system' '--enable-linux-user'
  '--enable-modules' '--enable-linux-aio' '--audio-drv-list=3Dpa' '--enable-
  attr' '--enable-brlapi' '--enable-virtfs' '--enable-cap-ng' '--enable-
  curl' '--enable-fdt' '--enable-gnutls' '--disable-gtk' '--disable-vte'
  '--enable-libiscsi' '--enable-curses' '--enable-smartcard' '--enable-
  rbd' '--enable-vnc-sasl' '--enable-seccomp' '--enable-spice' '--enable-
  libusb' '--enable-usb-redir' '--enable-xfsctl' '--enable-vnc' '--enable-
  vnc-jpeg' '--enable-vnc-png' '--enable-kvm' '--enable-vhost-net'
  =

- How have I built it?
- # git clone git://git.qemu.org/qemu.git
- # cd qemu
- # git submodule update --init --checkout
- # make clean && ./configure --target-list=3Darm-softmmu && make -j8
- # sudo make install
- =

  As a reference, and just in case these may be in some way related, I've
  just submitted another ticket for a different issue with snapshots using
  Ubuntu Qemu version (https://bugs.launchpad.net/qemu/+bug/1739371)
  =

  Cheers,
  Gus

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1739378

Title:
  qemu git master snapshot doesn't work

Status in QEMU:
  New

Bug description:
  I'm having different issues trying to have QEMU snapshots working
  using qemu-system-arm with vexpress-a15 board.

  In this opportunity, I'm trying the git master head version:
  # git rev-parse HEAD
  af352675efb7e92a1f5f6461a042a12015ab3d12

  $ /usr/local/bin/qemu-system-arm -kernel kernel/vmlinuz-4.10.0-42-generic=
 -initrd kernel/initrd.img-4.10.0-42-generic -M vexpress-a15 -m 2048 -appen=
d 'root=3D/dev/mmcblk0 rootwait console=3Dtty0' -sd vexpress-4G.qcow2 -dtb =
device-tree/vexpress-v2p-ca15-tc1.dtb
  audio: Could not init `oss' audio driver

  Later on, when the machine finishes booting I savevm ss and quit.
  However, when I try to restore it, I have that Missing section footer
  error:

  $ /usr/local/bin/qemu-system-arm -kernel kernel/vmlinuz-4.10.0-42-generic=
 -initrd kernel/initrd.img-4.10.0-42-generic -M vexpress-a15 -m 2048 -appen=
d 'root=3D/dev/mmcblk0 rootwait console=3Dtty0' -sd vexpress-4G.qcow2 -dtb =
device-tree/vexpress-v2p-ca15-tc1.dtb  -loadvm ss
  audio: Could not init `oss' audio driver
  qemu-system-arm: Missing section footer for sd-card
  qemu-system-arm: Error -22 while loading VM state

  OS: Ubuntu 16.04.3 LTS (xenial)

  $ gcc --version
  gcc (Ubuntu 5.4.0-6ubuntu1~16.04.5) 5.4.0 20160609

  How have I built it?
  # git clone git://git.qemu.org/qemu.git
  # cd qemu
  # git submodule update --init --checkout
  # make clean && ./configure --target-list=3Darm-softmmu && make -j8
  # sudo make install

  I've also tried a different ./configure line, explicitly enabling some
  of the features, i.e. smartcard, with the same results:

  ./configure '--disable-user' '--enable-system' '--enable-linux-user'
  '--enable-modules' '--enable-linux-aio' '--audio-drv-list=3Dpa'
  '--enable-attr' '--enable-brlapi' '--enable-virtfs' '--enable-cap-ng'
  '--enable-curl' '--enable-fdt' '--enable-gnutls' '--disable-gtk'
  '--disable-vte' '--enable-libiscsi' '--enable-curses' '--enable-
  smartcard' '--enable-rbd' '--enable-vnc-sasl' '--enable-seccomp'
  '--enable-spice' '--enable-libusb' '--enable-usb-redir' '--enable-
  xfsctl' '--enable-vnc' '--enable-vnc-jpeg' '--enable-vnc-png'
  '--enable-kvm' '--enable-vhost-net'

  As a reference, and just in case these may be in some way related,
  I've just submitted another ticket for a different issue with
  snapshots using Ubuntu Qemu version
  (https://bugs.launchpad.net/qemu/+bug/1739371)

  Cheers,
  Gus

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1739378/+subscriptions
