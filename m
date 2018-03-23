Received: from eggs.gnu.org ([2001:4830:134:3::10]:33950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ezLlK-0005oi-7s
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 08:25:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ezLlG-0002LQ-3K
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 08:25:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37518 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ezLlF-0002J3-Tx
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 08:25:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4D593407574E
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 12:25:28 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 23 Mar 2018 13:25:13 +0100
Message-Id: <20180323122520.11270-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/7] ramfb: simple boot framebuffer,
 no legacy vga
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, =?UTF-8?q?L=C3=A1szl=C3=B3=20=C3=89rsek?= <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

  Hi,

Ok folks, here is a experimental patch series for a legacy free boot
framebuffer.  If you want play with it I recommend getting the bits from

	https://www.kraxel.org/cgit/qemu/log/?h=sirius/ramfb

because they come with an updated seabios and a new vgabios rom and an
experimental OVMF build.

Functional overview
-------------------

The boot framebuffer is expected to be configured by the firmware, so it
uses fw_cfg as interface.  Initialization goes as follows:

  (1) Check whenever etc/ramfb is present.
  (2) Allocate framebuffer from RAM.
  (3) Fill struct RAMFBCfg, write it to etc/ramfb.

Done.  You can write stuff to the framebuffer now, and it should appear
automagically on the screen.

Note that this isn't very efficient because it does a full display
update on each refresh.  No dirty tracking.  Dirty tracking would have
to be active for the whole ram slot, so that wouldn't be very efficient
either.  So it is *really* intended to be only active for a short time
at boot, before the guest loaded the drivers for the real display
hardware.

Firmware support -- seabios
---------------------------

seavgabios is able to emulate vga text mode on top of a framebuffer, for
coreboot native graphics initialialization.  Which works fine for
everything which writes text using the vgabios interface (basically
everyhing which works with sgabios).

So I hacked that up to work with ramfb.  Right now it's proof-of-concept
code with too much cut+paste, so it will clearly need a bunch of
cleanups if this approach turns out to be workable.  Look here:

	https://www.kraxe.org/cgit/seabios/log/?h=ramfb

Firmware support -- edk2
------------------------

There is a EFI driver too.  Likewise a hackish proof-of-concept thing,
clearly not in a mergeable state, but good enough for playing.  Note
that the build disables QemuVideoDxe and VirtoGpu drivers, so ramfb is
the only supported display.  Code is here:

	https://github.com/kraxel/edk2/commits/ramfb

Firmware blob is in pc-bios/OVMF-ramfb.fd, to be used with -bios.

So, how to play?
----------------

There is ramfb-testdev.  Standalone device, for testing purposes.  Also
can listen on vga ports and logs any access, so we can see the bad boys.
Use "qemu -vga none -device ramfb-testdev".  Add "vgalog=on" to watch
guests accessing vga registers.

There is virtio-ramfb.  Simliar to virtio-vga, but using ramfb instead of
adding vga compatibility.  Shows how you can wire up ramfb support to
some display device.  Unlike virtio-vga it should work fine on arm.  Use
"qemu -vga none -device virtio-ramfb" for this one.

Tried to add qxl-ramfb, for windows guest tests, but that doesn't work
yet.  Don't use, unless you want help debugging ;)

There is virtio-pci-ramfb, which provides boot display support to vgpu
devices.

In general using UEFI works better than BIOS, because guests don't
expect legacy vga being present then.

What works?
-----------

Both windows and linux UEFI guests handle the ramfb GOP just fine.

BIOS boot loaders for linux all use vgabios calls for text mode, so they
show up just fine.  Also ipxe, seabios itself of course.  So you can
boot up your linux guest.  vesafb works too.

What doesn't work?
------------------

vgacon (direct vga hardware access).  Linux boots just fine
nevertheless, the only effect is that you don't see any boot messages
until the drm driver loads.

Windows in BIOS mode.  Boot logo shows up just fine.  But at some point
windows does lots of vga register accesses (even though it sets the
video mode via vesa bios interface) and appears to be unhappy that
things don't work as expected because there is no vga hardware
emulation.

Known issues
------------

Handover from ramfb-backed efifb to the native linux driver is tricky.
Usually efifb gets kicked out when the native driver loads because of
overlapping ressources.  With efifb being in RAM instead of using a GPU
PCI bar this doesn't happen though, so you'll end up with two
framebuffer devices.

In case vgaarb classifies the GPU as primary display device fbcon will
switch all VTs over to the framebuffer device of the real GPU, so there
isn't a noticable difference.  Otherwise you'll end up with a
non-visible fbcon, because it continues to run on ramfb whereas qemu
switched over to the GPU because the native linux driver initialized the
display.

xorg/wayland will show up on the GPU in any case because they prefer drm
over fbdev, so they wouldn't run on efifb.

Not tested yet
--------------

ARM.

ramfb -> gpu handover with windows guests (only ramfb-testdev so far).

enjoy,
  Gerd

Gerd Hoffmann (7):
  [testing] update bios, add vgabios-ramfb
  [testing] add ovmf build with ramfb support
  hw/display: add ramfb, a simple boot framebuffer living in guest ram
  hw/display: add ramfb-testdev
  hw/display: add virtio-ramfb
  hw/vfio/display: add ramfb support
  [wip] hw/display: add qxl-ramfb

 hw/display/qxl.h              |   2 +
 include/hw/display/ramfb.h    |   8 +++
 include/hw/vfio/vfio-common.h |   2 +
 hw/display/qxl.c              |  47 +++++++++++--
 hw/display/ramfb-testdev.c    |  96 +++++++++++++++++++++++++++
 hw/display/ramfb.c            |  95 +++++++++++++++++++++++++++
 hw/display/virtio-ramfb.c     | 149 ++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/display.c             |  10 +++
 hw/vfio/pci.c                 |  15 +++++
 ui/spice-display.c            |   6 ++
 hw/display/Makefile.objs      |   5 +-
 pc-bios/OVMF-ramfb.fd         | Bin 0 -> 2097152 bytes
 pc-bios/bios-256k.bin         | Bin 262144 -> 262144 bytes
 pc-bios/bios.bin              | Bin 131072 -> 131072 bytes
 pc-bios/vgabios-ramfb.bin     | Bin 0 -> 28160 bytes
 15 files changed, 430 insertions(+), 5 deletions(-)
 create mode 100644 include/hw/display/ramfb.h
 create mode 100644 hw/display/ramfb-testdev.c
 create mode 100644 hw/display/ramfb.c
 create mode 100644 hw/display/virtio-ramfb.c
 create mode 100644 pc-bios/OVMF-ramfb.fd
 create mode 100644 pc-bios/vgabios-ramfb.bin

-- 
2.9.3
