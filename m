Received: from eggs.gnu.org ([2001:4830:134:3::10]:50185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ckttY-0005nz-8Y
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 09:45:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ckttV-0006tV-10
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 09:45:52 -0500
Received: from indium.canonical.com ([91.189.90.7]:34580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ckttU-0006t9-Mt
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 09:45:48 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1ckttS-0005Dy-33
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 14:45:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id AAE1D2E80D5
	for <qemu-devel@nongnu.org>; Mon,  6 Mar 2017 14:45:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Mar 2017 14:35:48 -0000
From: Michal Nowak <1670377@bugs.launchpad.net>
Reply-To: Bug 1670377 <1670377@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170306143548.23490.4339.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1670377] [NEW] VNC: short read for zlre data/RDR
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

Public bug reported:

In openQA we have a custom VNC client (https://github.com/os-autoinst
/os-autoinst/tree/master/consoles), which connects to QEMU guest and
from there performs actions (sends keys, handles pointer, ...). We have
several backends (https://github.com/os-autoinst/os-
autoinst/tree/master/backend). With qemu backend we start QEMU guest
*locally* on openQA worker which connects to it via VNC and sends
commands. That works fine.

However, with svirt backend we start QEMU on a KVM or Xen host and then
connect to it remotely from openQA worker - the guest and worker are
different systems. In this scenario fairly often happens that while
system operates in Grub2, QEMU stops sending data via VNC:

...
15:24:15.5341 Debug: /var/lib/openqa/share/tests/sle-12-SP1/tests/installat=
ion/bootloader_uefi.pm:50 called testapi::send_key
15:24:15.5342 27074 <<< testapi::send_key(key=3D'c')
15:24:15.7361 Debug: /var/lib/openqa/share/tests/sle-12-SP1/tests/installat=
ion/bootloader_uefi.pm:51 called testapi::type_string
15:24:15.7362 27074 <<< testapi::type_string(string=3D'gfxmode=3D1024x768; =
terminal_output console; terminal_output gfxterm
', max_interval=3D250, wait_screen_changes=3D0)
15:24:22.2243 Debug: /var/lib/openqa/share/tests/sle-12-SP1/tests/installat=
ion/bootloader_uefi.pm:53 called testapi::send_key
15:24:22.2244 27074 <<< testapi::send_key(key=3D'esc')
15:24:22.4255 Debug: /var/lib/openqa/share/tests/sle-12-SP1/tests/installat=
ion/bootloader_uefi.pm:79 called testapi::send_key
15:24:22.4256 27074 <<< testapi::send_key(key=3D'e')
15:24:22.6264 Debug: /var/lib/openqa/share/tests/sle-12-SP1/tests/installat=
ion/bootloader_uefi.pm:81 called testapi::send_key
15:24:22.6265 27074 <<< testapi::send_key(key=3D'down')
15:24:22.8273 Debug: /var/lib/openqa/share/tests/sle-12-SP1/tests/installat=
ion/bootloader_uefi.pm:81 called testapi::send_key
15:24:22.8274 27074 <<< testapi::send_key(key=3D'down')
15:24:23.0282 Debug: /var/lib/openqa/share/tests/sle-12-SP1/tests/installat=
ion/bootloader_uefi.pm:81 called testapi::send_key
15:24:23.0283 27074 <<< testapi::send_key(key=3D'down')
DIE short read for zlre data 107132 - 995002 at /usr/lib/os-autoinst/consol=
es/VNC.pm line 978.

 at /usr/lib/os-autoinst/backend/baseclass.pm line 73.
...

My observation is that it happens only while in Grub, when resolution
happened a short while ago. See attached video and log.

Prior to QEMU 2.8.0 I was able to reproduce a similar issue with
vncviewer. I started QEMU with SLES JeOS image pressed several times a
'down' key in Grub and vncviewer (Tiger VNC 1.6.0 from openSUSE Leap
42.2) crashed with rdr::EndOfStream exception. This does not happen with
QEMU 2.8.0, but I am still able to reproduce similar issue via openQA.

/usr/bin/qemu-system-x86_64 -name guest=3DopenQA-SUT-20,debug-threads=3Don
-S -machine pc-i440fx-2.6,accel=3Dkvm,usb=3Doff -m 1024 -realtime mlock=3Do=
ff
-smp 1,sockets=3D1,cores=3D1,threads=3D1 -uuid 87535fc1-e693-41b9-813e-
834d6fc4cb5a -no-user-config -nodefaults   -rtc base=3Dutc -no-reboot
-boot strict=3Don -device piix3-usb-uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2
-drive file=3D/var/lib/libvirt/images/openQA-
SUT-20.img,format=3Dqcow2,if=3Dnone,id=3Ddrive-virtio-disk0,cache=3Dunsafe
-device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x4,drive=3Ddrive-virt=
io-
disk0,id=3Dvirtio-disk0,bootindex=3D1 -netdev user,id=3Dhostnet0 -device
virtio-net-
pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:12:34:56,bus=3Dpci.0,addr=3D=
0x3
-chardev pty,id=3Dcharserial0 -device isa-
serial,chardev=3Dcharserial0,id=3Dserial0 -device virtio-tablet-
pci,id=3Dinput0,bus=3Dpci.0,addr=3D0x6 -device virtio-keyboard-
pci,id=3Dinput1,bus=3Dpci.0,addr=3D0x7 -vnc 0.0.0.0:20,share=3Dforce-shared
-device cirrus-vga,id=3Dvideo0,bus=3Dpci.0,addr=3D0x2 -device virtio-balloo=
n-
pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x5 -msg timestamp=3Don -monitor stdio

Host: openSUSE Leap 42.2 x86_64 KVM or Xen on x86_64 Intel with QEMU 2.6.0.
Guest: Leap 42.2.

I can't reproduce the problem with QEMU 2.5.0, but I can with any QEMU
version from 2.6 RC1 on.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: vnc

** Attachment added: "log from openQA"
   https://bugs.launchpad.net/bugs/1670377/+attachment/4832318/+files/autoi=
nst-log.txt

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1670377

Title:
   VNC: short read for zlre data/RDR EndOfStream

Status in QEMU:
  New

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
