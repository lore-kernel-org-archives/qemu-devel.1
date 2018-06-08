Received: from eggs.gnu.org ([2001:4830:134:3::10]:58138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fRFRP-00087i-G7
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 07:20:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fRFRK-0001ng-1m
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 07:20:23 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  8 Jun 2018 13:19:55 +0200
Message-Id: <20180608112001.14729-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/6] ramfb: simple boot framebuffer,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?L=C3=A1szl=C3=B3=20=C3=89rsek?= <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

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
either.

Firmware support -- seabios
---------------------------

seavgabios is able to emulate vga text mode on top of a framebuffer, for
coreboot native graphics initialialization.  Which works fine for
everything which writes text using the vgabios interface (basically
everyhing which works with sgabios).

So I hacked that up to work with ramfb (and, while being at it,
bochs-display too).  Right now it's proof-of-concept code with fwcfg
support being cut+paste, so it'll need cleanups before merging.
Look here:

	https://www.kraxe.org/cgit/seabios/log/?h=bochs

Firmware support -- edk2
------------------------

There is a EFI driver too.  Code is here:

	https://github.com/kraxel/edk2/commits/ramfb

Firmware blob is in pc-bios/OVMF-ramfb.fd, to be used with -bios.

So, how to play?
----------------

There is ramfb.  Standalone device.

There is virtio-ramfb.  Simliar to virtio-vga, but using ramfb instead of
adding vga compatibility.  Shows how you can wire up ramfb support to
some display device.  Unlike virtio-vga it should work fine on arm.  Use
"qemu -vga none -device virtio-ramfb" for this one.  Not clear whenever
this will be actually be merged, given that edk2 has a native virtio-gpu
driver.

There is virtio-pci-ramfb, which provides boot display support to vgpu
devices.

What works?
-----------

Both windows (x86 tested) and linux (x86 + arm tested) UEFI guests
handle the ramfb GOP just fine.

BIOS boot loaders for linux all use vgabios calls for text mode, so they
show up just fine.  Also ipxe, seabios itself of course.  So you can
boot up your linux guest.  vesafb works too.

Windows in BIOS mode doesn't use text mode and works fine too.

What doesn't work?
------------------

vgacon (direct vga hardware access).  Linux boots just fine
nevertheless, the only effect is that you don't see any boot messages
until the drm driver loads.

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

enjoy,
  Gerd

Gerd Hoffmann (6):
  hw/display: add ramfb, a simple boot framebuffer living in guest ram
  hw/display: add standalone ramfb device
  hw/display: add virtio-ramfb device
  hw/vfio/display: add ramfb support
  ramfb: enable vgabios
  bochs-display: enable vgabios

 include/hw/display/ramfb.h    |  12 ++++
 include/hw/vfio/vfio-common.h |   2 +
 hw/arm/sysbus-fdt.c           |   7 ++
 hw/arm/virt.c                 |   2 +
 hw/display/bochs-display.c    |   1 +
 hw/display/ramfb-standalone.c |  62 ++++++++++++++++++
 hw/display/ramfb.c            |  96 +++++++++++++++++++++++++++
 hw/display/virtio-ramfb.c     | 149 ++++++++++++++++++++++++++++++++++++++++++
 hw/i386/pc_piix.c             |   2 +
 hw/i386/pc_q35.c              |   2 +
 hw/vfio/display.c             |  10 +++
 hw/vfio/pci.c                 |  15 +++++
 hw/display/Makefile.objs      |   5 +-
 13 files changed, 364 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/display/ramfb.h
 create mode 100644 hw/display/ramfb-standalone.c
 create mode 100644 hw/display/ramfb.c
 create mode 100644 hw/display/virtio-ramfb.c

-- 
2.9.3
