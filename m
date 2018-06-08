Received: from eggs.gnu.org ([2001:4830:134:3::10]:47680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fRNeh-0007TB-MG
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 16:06:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fRNee-0006eM-Ed
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 16:06:39 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri,  8 Jun 2018 22:05:45 +0200
Message-Id: <20180608200558.386-1-laurent@vivier.eu>
Subject: [Qemu-devel] [RFC 00/13] hw/m68k: add Apple Machintosh Quadra 800
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, qemu-block@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Laurent Vivier <laurent@vivier.eu>

I'm rebasing some of these patches for seven years now,
too many years...

It's an RFC because things have changed in QEMU in seven years,
for instance the VIA has a new implementation (mos6522) introduced
by Mark Cave-Ayland and I didn't rework my implementation to
fit into this new one (any volunteers?), display has some glitches,
ADB devices are not identified correctly.

if you want to test the machine, I'm sorry, it doesn't boot
a MacROM, but you can boot a linux kernel from the command line.

You can install your own disk using debian-installer, with:

    ...
    -M q800 \
    -serial none -serial mon:stdio \
    -m 1000M -drive file=m68k.qcow2,format=qcow2 \
    -net nic,model=dp83932,addr=09:00:07:12:34:57 \
    -append "console=ttyS0 vga=off" \
    -kernel vmlinux-4.15.0-2-m68k \
    -initrd initrd.gz \
    -drive file=debian-9.0-m68k-NETINST-1.iso \
    -drive file=m68k.qcow2,format=qcow2 \
    -nographic

If you use a graphic adapter instead of "-nographic", you can use "-g" to set the
size of the display (I use "-g 1600x800x24").

You can get the ISO from:

https://cdimage.debian.org/mirror/cdimage/ports/9.0/m68k/iso-cd/debian-9.0-m68k-NETINST-1.iso

and extract the kernel and initrd.gz:

guestfish --add debian-9.0-m68k-NETINST-1.iso --ro \
          --mount /dev/sda:/ <<_EOF_
copy-out /install/cdrom/initrd.gz .
copy-out /install/kernels/vmlinux-4.15.0-2-m68k .
_EOF_

The mirror to use is: http://ftp.ports.debian.org/debian-ports/
when it fails, continue without boot loader.

In the same way, you can extract the kernel and the initramfs from the qcow2
image to use it with "-kernel" and "-initrd":

guestfish --add m68k.qcow2 --mount /dev/sda2:/ <<_EOF_
copy-out /boot/vmlinux-4.15.0-2-m68k .
copy-out /boot/initrd.img-4.15.0-2-m68k .
_EOF_

and boot with:

   ...
   -append "root=/dev/sda2 rw console=ttyS0 console=tty \
   -kernel vmlinux-4.15.0-2-m68k \
   -initrd initrd.img-4.15.0-2-m68k

Laurent Vivier (13):
  hw/m68k: add via support
  ADB: VIA probes ADB bus when it is idle
  escc: introduce a selector for the register bit
  hw/m68k: add video card
  hw/m68k: Apple Sound Chip (ASC) emulation
  ESP: add pseudo-DMA as used by Macintosh
  hw/m68k: add Nubus support
  hw/m68k: add a dummy SWIM floppy controller
  hw/m68k: define Macintosh Quadra 800
  dp8393x: fix dp8393x_receive
  dp8393x: manage big endian bus
  dp8393x: put DMA temp buffer in the state, not in the stack
  dp8393x: fix receiving buffer exhaustion

 arch_init.c                      |   4 +
 default-configs/m68k-softmmu.mak |  12 +
 hw/Makefile.objs                 |   1 +
 hw/audio/Makefile.objs           |   1 +
 hw/audio/asc.c                   | 492 ++++++++++++++++++++
 hw/block/Makefile.objs           |   1 +
 hw/block/swim.c                  | 325 +++++++++++++
 hw/char/escc.c                   |  30 +-
 hw/display/Makefile.objs         |   1 +
 hw/display/macfb-template.h      | 158 +++++++
 hw/display/macfb.c               | 335 ++++++++++++++
 hw/input/adb-kbd.c               |   4 +
 hw/input/adb-mouse.c             |   4 +
 hw/input/adb.c                   | 116 ++++-
 hw/m68k/Makefile.objs            |   6 +-
 hw/m68k/bootinfo.h               |  99 ++++
 hw/m68k/mac.c                    | 384 ++++++++++++++++
 hw/mips/mips_jazz.c              |   2 +-
 hw/misc/Makefile.objs            |   1 +
 hw/misc/mac_via.c                | 965 +++++++++++++++++++++++++++++++++++++++
 hw/net/dp8393x.c                 | 169 ++++---
 hw/nubus/Makefile.objs           |   4 +
 hw/nubus/mac.c                   | 112 +++++
 hw/nubus/nubus-bridge.c          |  34 ++
 hw/nubus/nubus-bus.c             |  60 +++
 hw/nubus/nubus-device.c          | 262 +++++++++++
 hw/scsi/esp.c                    | 330 +++++++++++--
 include/hw/audio/asc.h           |  21 +
 include/hw/char/escc.h           |   1 +
 include/hw/input/adb.h           |   9 +
 include/hw/misc/mac_via.h        |  45 ++
 include/hw/nubus/mac.h           |  24 +
 include/hw/nubus/nubus.h         |  89 ++++
 include/hw/scsi/esp.h            |  15 +-
 include/qemu/typedefs.h          |   2 +
 qemu-options.hx                  |   2 +-
 tests/qom-test.c                 |   5 +
 tests/test-hmp.c                 |   3 +-
 vl.c                             |   3 +-
 39 files changed, 4019 insertions(+), 112 deletions(-)
 create mode 100644 hw/audio/asc.c
 create mode 100644 hw/block/swim.c
 create mode 100644 hw/display/macfb-template.h
 create mode 100644 hw/display/macfb.c
 create mode 100644 hw/m68k/bootinfo.h
 create mode 100644 hw/m68k/mac.c
 create mode 100644 hw/misc/mac_via.c
 create mode 100644 hw/nubus/Makefile.objs
 create mode 100644 hw/nubus/mac.c
 create mode 100644 hw/nubus/nubus-bridge.c
 create mode 100644 hw/nubus/nubus-bus.c
 create mode 100644 hw/nubus/nubus-device.c
 create mode 100644 include/hw/audio/asc.h
 create mode 100644 include/hw/misc/mac_via.h
 create mode 100644 include/hw/nubus/mac.h
 create mode 100644 include/hw/nubus/nubus.h

-- 
2.14.4
