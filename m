Received: from eggs.gnu.org ([2001:4830:134:3::10]:34324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d3kIb-00036b-1O
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 10:21:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d3kIY-0002V9-Bl
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 10:21:37 -0400
Received: from indium.canonical.com ([91.189.90.7]:45480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d3kIY-0002UY-3W
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 10:21:34 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d3kIW-0005Zx-EK
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 14:21:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 10C7B2E838D
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 14:21:13 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Apr 2017 14:12:23 -0000
From: Daniel Berrange <1670377@bugs.launchpad.net>
Reply-To: Bug 1670377 <1670377@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170306143548.23490.4339.malonedeb@wampee.canonical.com>
Message-Id: <20170427141223.26779.36440.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1670377] Re: VNC: short read for zlre data/RDR
 EndOfStream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

It isn't 100% clear from the info provided, but this is almost certainly
fixed in 2.9.0 by

commit 537848ee62195fc06c328b1cd64f4218f404a7f1
Author: Michael Tokarev <mjt@tls.msk.ru>
Date:   Fri Feb 3 12:52:29 2017 +0300

    vnc: do not disconnect on EAGAIN
    =

    When qemu vnc server is trying to send large update to clients,
    there might be a situation when system responds with something
    like EAGAIN, indicating that there's no system memory to send
    that much data (depending on the network speed, client and server
    and what is happening).  In this case, something like this happens
    on qemu side (from strace):
    =

    sendmsg(16, {msg_name(0)=3DNULL,
            msg_iov(1)=3D[{"\244\"..., 729186}],
            msg_controllen=3D0, msg_flags=3D0}, 0) =3D 103950
    sendmsg(16, {msg_name(0)=3DNULL,
            msg_iov(1)=3D[{"lz\346"..., 1559618}],
            msg_controllen=3D0, msg_flags=3D0}, 0) =3D -1 EAGAIN
    sendmsg(-1, {msg_name(0)=3DNULL,
            msg_iov(1)=3D[{"lz\346"..., 1559618}],
            msg_controllen=3D0, msg_flags=3D0}, 0) =3D -1 EBADF
    =

    qemu closes the socket before the retry, and obviously it gets EBADF
    when trying to send to -1.
    =

    This is because there WAS a special handling for EAGAIN, but now it doe=
sn't
    work anymore, after commit 04d2529da27db512dcbd5e99d0e26d333f16efcc, be=
cause
    now in all error-like cases we initiate vnc disconnect.
    =

    This change were introduced in qemu 2.6, and caused numerous grief for =
many
    people, resulting in their vnc clients reporting sporadic random discon=
nects
    from vnc server.
    =

    Fix that by doing the disconnect only when necessary, i.e. omitting this
    very case of EAGAIN.
    =

    Hopefully the existing condition (comparing with QIO_CHANNEL_ERR_BLOCK)
    is sufficient, as the original code (before the above commit) were
    checking for other errno values too.
    =

    Apparently there's another (semi?)bug exist somewhere here, since the
    code tries to write to fd# -1, it probably should check if the connecti=
on
    is open before. But this isn't important.
    =

    Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
    Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
    Message-id: 1486115549-9398-1-git-send-email-mjt@msgid.tls.msk.ru
    Fixes: 04d2529da27db512dcbd5e99d0e26d333f16efcc
    Cc: Daniel P. Berrange <berrange@redhat.com>
    Cc: Gerd Hoffmann <kraxel@redhat.com>
    Cc: qemu-stable@nongnu.org
    Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>


** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1670377

Title:
   VNC: short read for zlre data/RDR EndOfStream

Status in QEMU:
  Fix Released

Bug description:
  In openQA we have a custom VNC client (https://github.com/os-autoinst
  /os-autoinst/tree/master/consoles), which connects to QEMU guest and
  from there performs actions (sends keys, handles pointer, ...). We
  have several backends (https://github.com/os-autoinst/os-
  autoinst/tree/master/backend). With qemu backend we start QEMU guest
  *locally* on openQA worker which connects to it via VNC and sends
  commands. That works fine.

  However, with svirt backend we start QEMU on a KVM or Xen host and
  then connect to it remotely from openQA worker - the guest and worker
  are different systems. In this scenario fairly often happens that
  while system operates in Grub2, QEMU stops sending data via VNC:

  ...
  15:24:15.5341 Debug: /var/lib/openqa/share/tests/sle-12-SP1/tests/install=
ation/bootloader_uefi.pm:50 called testapi::send_key
  15:24:15.5342 27074 <<< testapi::send_key(key=3D'c')
  15:24:15.7361 Debug: /var/lib/openqa/share/tests/sle-12-SP1/tests/install=
ation/bootloader_uefi.pm:51 called testapi::type_string
  15:24:15.7362 27074 <<< testapi::type_string(string=3D'gfxmode=3D1024x768=
; terminal_output console; terminal_output gfxterm
  ', max_interval=3D250, wait_screen_changes=3D0)
  15:24:22.2243 Debug: /var/lib/openqa/share/tests/sle-12-SP1/tests/install=
ation/bootloader_uefi.pm:53 called testapi::send_key
  15:24:22.2244 27074 <<< testapi::send_key(key=3D'esc')
  15:24:22.4255 Debug: /var/lib/openqa/share/tests/sle-12-SP1/tests/install=
ation/bootloader_uefi.pm:79 called testapi::send_key
  15:24:22.4256 27074 <<< testapi::send_key(key=3D'e')
  15:24:22.6264 Debug: /var/lib/openqa/share/tests/sle-12-SP1/tests/install=
ation/bootloader_uefi.pm:81 called testapi::send_key
  15:24:22.6265 27074 <<< testapi::send_key(key=3D'down')
  15:24:22.8273 Debug: /var/lib/openqa/share/tests/sle-12-SP1/tests/install=
ation/bootloader_uefi.pm:81 called testapi::send_key
  15:24:22.8274 27074 <<< testapi::send_key(key=3D'down')
  15:24:23.0282 Debug: /var/lib/openqa/share/tests/sle-12-SP1/tests/install=
ation/bootloader_uefi.pm:81 called testapi::send_key
  15:24:23.0283 27074 <<< testapi::send_key(key=3D'down')
  DIE short read for zlre data 107132 - 995002 at /usr/lib/os-autoinst/cons=
oles/VNC.pm line 978.

   at /usr/lib/os-autoinst/backend/baseclass.pm line 73.
  ...

  My observation is that it happens only while in Grub, when resolution
  happened a short while ago. See attached video and log.

  Prior to QEMU 2.8.0 I was able to reproduce a similar issue with
  vncviewer. I started QEMU with SLES JeOS image pressed several times a
  'down' key in Grub and vncviewer (Tiger VNC 1.6.0 from openSUSE Leap
  42.2) crashed with rdr::EndOfStream exception. This does not happen
  with QEMU 2.8.0, but I am still able to reproduce similar issue via
  openQA.

  /usr/bin/qemu-system-x86_64 -name guest=3DopenQA-SUT-20,debug-threads=3Don
  -S -machine pc-i440fx-2.6,accel=3Dkvm,usb=3Doff -m 1024 -realtime
  mlock=3Doff -smp 1,sockets=3D1,cores=3D1,threads=3D1 -uuid 87535fc1-e693-=
41b9
  -813e-834d6fc4cb5a -no-user-config -nodefaults   -rtc base=3Dutc -no-
  reboot -boot strict=3Don -device piix3-usb-
  uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2 -drive file=3D/var/lib/libvirt/i=
mages
  /openQA-SUT-20.img,format=3Dqcow2,if=3Dnone,id=3Ddrive-virtio-
  disk0,cache=3Dunsafe -device virtio-blk-
  pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x4,drive=3Ddrive-virtio-disk0,id=3Dvir=
tio-
  disk0,bootindex=3D1 -netdev user,id=3Dhostnet0 -device virtio-net-
  pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:12:34:56,bus=3Dpci.0,addr=
=3D0x3
  -chardev pty,id=3Dcharserial0 -device isa-
  serial,chardev=3Dcharserial0,id=3Dserial0 -device virtio-tablet-
  pci,id=3Dinput0,bus=3Dpci.0,addr=3D0x6 -device virtio-keyboard-
  pci,id=3Dinput1,bus=3Dpci.0,addr=3D0x7 -vnc 0.0.0.0:20,share=3Dforce-shar=
ed
  -device cirrus-vga,id=3Dvideo0,bus=3Dpci.0,addr=3D0x2 -device virtio-
  balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x5 -msg timestamp=3Don -mon=
itor
  stdio

  Host: openSUSE Leap 42.2 x86_64 KVM or Xen on x86_64 Intel with QEMU 2.6.=
0.
  Guest: Leap 42.2.

  I can't reproduce the problem with QEMU 2.5.0, but I can with any QEMU
  version from 2.6 RC1 on.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1670377/+subscriptions
