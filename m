Received: from eggs.gnu.org ([209.51.188.92]:43109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gwTlk-0001Xc-JM
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:26:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gwTlg-0008Jg-5J
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:26:42 -0500
Received: from indium.canonical.com ([91.189.90.7]:41260)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gwTlf-00080M-RM
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:26:40 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gwRoO-0004tl-Hn
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 13:21:20 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 238A92E80D4
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 13:21:20 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 Feb 2019 13:13:48 -0000
From: "Laszlo Ersek \(Red Hat\)" <lersek@redhat.com>
Reply-To: Bug 1685242 <1685242@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170421142319.16919.35932.malonedeb@wampee.canonical.com>
Message-Id: <155066842839.3426.9011980165224724286.malone@wampee.canonical.com>
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

* From "debug-nonworking.log":

> GetFirstNonAddress: Pci64Base=3D0x8800000000 Pci64Size=3D0x800000000
> [...]
> PublishPeiMemory: mPhysMemAddressWidth=3D40 PeiMemoryCap=3D69644 KB
> [...]
> Type =3D  Mem64; Base =3D 0x8800000000;	Length =3D 0x100000;	Alignment =
=3D 0xFFFFF
>  Base =3D 0x8800000000;	Length =3D 0x4000;	Alignment =3D 0x3FFF;	Owner =
=3D PCI [00|12|00:20]; Type =3D PMem64

- The 64-bit MMIO aperture starts at (512+32)GB (see "Pci64Base").
- 40 physical address bits are required (see "mPhysMemAddressWidth").
  Your PCPU has 39 (thanks for confirming that).
- The 64-bit MMIO BAR of the virtio-net-pci device is allocated at
  (512+32)GB. Will not be accessible.


* From "debug-working-222G.log":

> GetFirstNonAddress: Pci64Base=3D0x7800000000 Pci64Size=3D0x800000000
> [...]
> PublishPeiMemory: mPhysMemAddressWidth=3D39 PeiMemoryCap=3D67592 KB
> [...]
> Type =3D  Mem64; Base =3D 0x7800000000;	Length =3D 0x100000;	Alignment =
=3D 0xFFFFF
>  Base =3D 0x7800000000;	Length =3D 0x4000;	Alignment =3D 0x3FFF;	Owner =
=3D PCI [00|12|00:20]; Type =3D PMem64

- Aperture at 480GB.
- 39 phys bits suffice.
- BAR allocated at 480GB. Will be accessible.


* From "debug-working-novirtio-net.log":

- Identical to "debug-nonworking.log", except there is no PCI device
  with a 64-bit BAR, hence no attempt is made to access the inaccessible
  aperture.


* Regarding why 222GB seems to be the cutoff. The base of the 64-bit
  aperture must be suitably aligned. I explained this in the
  earlier-referenced
  <https://bugzilla.redhat.com/show_bug.cgi?id=3D1353591#c8>, in
  particular, bullet (6). If you decrease the aperture size, the
  required alignment will shrink as well, and the DIMM hotplug cutoff
  might increase. Please refer to

    -fw_cfg name=3Dopt/ovmf/X-PciMmio64Mb,string=3D4096

  in <https://bugzilla.redhat.com/show_bug.cgi?id=3D1353591#c10>.

Right now everything appears to work by design. Closing this ticket.


** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1685242

Title:
  ovmf hangs at efi with virtio-net memory hotplug

Status in QEMU:
  Invalid

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
