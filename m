Received: from eggs.gnu.org ([209.51.188.92]:59474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gwO3j-00008X-6l
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 04:20:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gwO3h-0006u5-B9
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 04:20:55 -0500
Received: from indium.canonical.com ([91.189.90.7]:52580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gwO3f-0006od-9H
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 04:20:51 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gwO3Y-0004Dy-GB
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 09:20:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7887B2E80CC
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 09:20:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 Feb 2019 09:05:53 -0000
From: flumm <dominik.csapak@gmail.com>
Reply-To: Bug 1685242 <1685242@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170421142319.16919.35932.malonedeb@wampee.canonical.com>
Message-Id: <155065355393.1294.14079979570298520235.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1685242] Re: ovmf hangs at efi with virtio-net
 memory hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

i see,

but is there a good reason why it did work with an older qemu version/machi=
ne type (<=3D 2.6)
also my cpuinfo says physical bits 39 but i cannot use more maxmem than 222G

i attached the cpuinfo, cmdline, and debug logs for a nonworking invocation=
 and
one for each working, with 222G, with machine type 2.6 and without a virtio=
-net respectively


** Attachment added: "/proc/cpuinfo"
   https://bugs.launchpad.net/qemu/+bug/1685242/+attachment/5240131/+files/=
cpuinfo

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1685242

Title:
  ovmf hangs at efi with virtio-net memory hotplug

Status in QEMU:
  New

Bug description:
  with qemu 2.9 it hangs at the efi stage when memory-hotplug is enabled
  and it has a virtio-net devices

  the ovmf images where compiled from https://github.com/tianocore/edk2
  (current master)

  reproducer:

  qemu-system-x86_64 -drive
  'if=3Dpflash,unit=3D0,format=3Draw,readonly,file=3D./OVMF_CODE.fd' -drive
  'if=3Dpflash,unit=3D1,format=3Draw,file=3D./my_OVMF_VARS.fd' -smp 1 -vga =
std
  -netdev 'type=3Dtap,id=3Dmynet' -device 'virtio-net-pci,netdev=3Dmynet'
  -display sdl -nodefaults -m 'size=3D1G,slots=3D256,maxmem=3D1024G'

  interestingly, it works when you do the following:

  - omit the virtio-net-pci device
  - use seabios
  - use less maxmem, e.g. 512G

  qemu was compiled from source (v2.9.0) with following options:

  ./configure --target-list=3Dx86_64-softmmu --disable-xen --enable-gnutls =
--enable-sdl --enable-linux-aio --enable-rbd --enable-libiscsi --disable-sm=
artcard --audio-drv-list=3D"alsa" --enable
  -spice --enable-usb-redir --enable-glusterfs --enable-libusb --disable-gt=
k --enable-xfsctl --enable-numa --disable-strip --enable-jemalloc --enable-=
virtfs --disable-libnfs --disable-fdt --disable-guest-agent --disable-guest=
-agent-msi

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1685242/+subscriptions
