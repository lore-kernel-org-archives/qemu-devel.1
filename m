Received: from eggs.gnu.org ([209.51.188.92]:37920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gvrkK-0001da-RR
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 17:50:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gvrkJ-0003Hy-PG
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 17:50:44 -0500
Received: from indium.canonical.com ([91.189.90.7]:50138)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gvrkJ-0003Ed-CF
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 17:50:43 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gvrkE-0007tW-5q
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 22:50:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 072BC2E80CC
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 22:50:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 Feb 2019 22:37:54 -0000
From: "Laszlo Ersek \(Red Hat\)" <lersek@redhat.com>
Reply-To: Bug 1685242 <1685242@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170421142319.16919.35932.malonedeb@wampee.canonical.com>
Message-Id: <155052947493.5891.12654195437565640283.malone@soybean.canonical.com>
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

OVMF places the 64-bit PCI MMIO aperture after the memory hotplug area.
If you specify `-m maxmem=3D1024G`, then accessing 64-bit MMIO BARs of
PCI(e) devices, allocated from the aperture, will require at least 41
address bits. If you use KVM, and nested paging (EPT on Intel, NPT on
AMD) is enabled, and your /proc/cpuinfo on the host reports a smaller
phys address width than 41, then 64-bit PCI MMIO accesses in the guest
will silently fail. You can read more details in
<https://bugzilla.redhat.com/show_bug.cgi?id=3D1353591#c8>.

SeaBIOS uses an independent algorithm for aperture placement and BAR
allocation.

If you remove virtio-net-pci, then your command line ends up without any
PCI(e) device that has a 64-bit MMIO BAR. So the issue is not triggered.

If you use a maxmem of 512G, then 40 bits might suffice. It's possible
that your physical CPU has precisely that many address bits, and so the
behavior could change.

If you attach the OVMF debug log (capture `-debugcon file:debug.log
-global isa-debugcon.iobase=3D0x402`), I could say more.

Thus far this ticket looks like "NOTABUG" -- use a smaller memory
hotplug area, or disable nested paging (which will come with a
performance penalty).

** Bug watch added: Red Hat Bugzilla #1353591
   https://bugzilla.redhat.com/show_bug.cgi?id=3D1353591

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
