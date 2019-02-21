Received: from eggs.gnu.org ([209.51.188.92]:37536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gwkcP-0005BS-8K
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:26:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gwkcO-0004V2-7N
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:26:13 -0500
Received: from indium.canonical.com ([91.189.90.7]:39730)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gwkcO-0004Q0-0U
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:26:12 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gwkcM-0004DC-OQ
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 09:26:10 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 6CCFD2E80CC
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 09:26:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 Feb 2019 09:14:36 -0000
From: "Laszlo Ersek \(Red Hat\)" <lersek@redhat.com>
Reply-To: Bug 1685242 <1685242@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170421142319.16919.35932.malonedeb@wampee.canonical.com>
Message-Id: <155074047654.22880.13266097062299748360.malone@wampee.canonical.com>
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

Last night I remembered another tidbit:

In OVMF, you can entirely disable the 64-bit MMIO aperture.

  -fw_cfg name=3Dopt/ovmf/X-PciMmio64Mb,string=3D0

If you use the above switch, the firmware log should contain the
following message:

> GetFirstNonAddress: disabling 64-bit PCI host aperture

This will force the BAR allocations into 32-bit address space.
Obviously, that makes it a lot easier to run out of the (much smaller)
32-bit MMIO aperture, but if you don't have PCI(E) devices with large
MMIO BARs, then it should work (e.g. it should totally work in your
present use case).

And then you should be able to increase the DIMM hotplug area
significantly, without running out of the GPA range covered by 39
physical address bits:

    //
    // There's nothing more to do; the amount of memory above 4GB fully
    // determines the highest address plus one. The memory hotplug area (see
    // below) plays no role for the firmware in this case.
    //

"This case" beeing (Pci64Size =3D=3D 0).

Hope this helps.

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
