Received: from eggs.gnu.org ([2001:4830:134:3::10]:48481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fYJtM-0007uV-IQ
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 19:30:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fYJtK-0003iM-Ut
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 19:30:28 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 28 Jun 2018 01:29:41 +0200
Message-Id: <20180627232951.14725-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC v3 00/10] hw/m68k: add Apple Machintosh Quadra
 800 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Jason Wang <jasowang@redhat.com>, Fam Zheng <famz@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

I'm rebasing some of these patches for seven years now,
too many years...

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

v3: fix subject prefix "C" -> "RFC"

v2: remove the dp8393x fixes, because one of the patch breaks something
    Update "dp8393x: manage big endian bus" with idea from Thomas
    Mark has reworked most of the patches:
    - use mos6522
    - some code move, renamings and cleanup

Laurent Vivier (10):
  hw/m68k: add via support
  ADB: VIA probes ADB bus when it is idle
  escc: introduce a selector for the register bit
  hw/m68k: add video card
  hw/m68k: Apple Sound Chip (ASC) emulation
  ESP: add pseudo-DMA as used by Macintosh
  hw/m68k: add Nubus support
  hw/m68k: add a dummy SWIM floppy controller
  dp8393x: manage big endian bus
  hw/m68k: define Macintosh Quadra 800

 MAINTAINERS                         |  19 +
 arch_init.c                         |   4 +
 default-configs/m68k-softmmu.mak    |  14 +
 hw/Makefile.objs                    |   1 +
 hw/audio/Makefile.objs              |   1 +
 hw/audio/asc.c                      | 463 +++++++++++++++++++++++
 hw/block/Makefile.objs              |   1 +
 hw/block/swim.c                     | 284 ++++++++++++++
 hw/char/escc.c                      |  30 +-
 hw/display/Makefile.objs            |   1 +
 hw/display/macfb-template.h         | 158 ++++++++
 hw/display/macfb.c                  | 308 +++++++++++++++
 hw/input/adb-kbd.c                  |   4 +
 hw/input/adb-mouse.c                |   4 +
 hw/input/adb.c                      | 115 ++++++
 hw/intc/Makefile.objs               |   1 +
 hw/intc/q800_irq.c                  |  73 ++++
 hw/m68k/Makefile.objs               |   6 +-
 hw/m68k/bootinfo.h                  | 100 +++++
 hw/m68k/q800.c                      | 385 +++++++++++++++++++
 hw/mips/mips_jazz.c                 |   2 +-
 hw/misc/Makefile.objs               |   1 +
 hw/misc/mac_via.c                   | 731 ++++++++++++++++++++++++++++++++++++
 hw/net/dp8393x.c                    |  88 +++--
 hw/nubus/Makefile.objs              |   4 +
 hw/nubus/mac-nubus-bridge.c         |  45 +++
 hw/nubus/nubus-bridge.c             |  34 ++
 hw/nubus/nubus-bus.c                | 111 ++++++
 hw/nubus/nubus-device.c             | 210 +++++++++++
 hw/scsi/esp.c                       | 297 +++++++++++++--
 include/hw/audio/asc.h              |  48 +++
 include/hw/block/swim.h             |  53 +++
 include/hw/char/escc.h              |   1 +
 include/hw/display/macfb.h          |  63 ++++
 include/hw/input/adb.h              |  10 +
 include/hw/intc/q800_irq.h          |  39 ++
 include/hw/misc/mac_via.h           | 107 ++++++
 include/hw/nubus/mac-nubus-bridge.h |  24 ++
 include/hw/nubus/nubus.h            |  69 ++++
 include/hw/scsi/esp.h               |  11 +-
 qemu-options.hx                     |   2 +-
 tests/qom-test.c                    |   5 +
 tests/test-hmp.c                    |   3 +-
 vl.c                                |   3 +-
 44 files changed, 3857 insertions(+), 76 deletions(-)
 create mode 100644 hw/audio/asc.c
 create mode 100644 hw/block/swim.c
 create mode 100644 hw/display/macfb-template.h
 create mode 100644 hw/display/macfb.c
 create mode 100644 hw/intc/q800_irq.c
 create mode 100644 hw/m68k/bootinfo.h
 create mode 100644 hw/m68k/q800.c
 create mode 100644 hw/misc/mac_via.c
 create mode 100644 hw/nubus/Makefile.objs
 create mode 100644 hw/nubus/mac-nubus-bridge.c
 create mode 100644 hw/nubus/nubus-bridge.c
 create mode 100644 hw/nubus/nubus-bus.c
 create mode 100644 hw/nubus/nubus-device.c
 create mode 100644 include/hw/audio/asc.h
 create mode 100644 include/hw/block/swim.h
 create mode 100644 include/hw/display/macfb.h
 create mode 100644 include/hw/intc/q800_irq.h
 create mode 100644 include/hw/misc/mac_via.h
 create mode 100644 include/hw/nubus/mac-nubus-bridge.h
 create mode 100644 include/hw/nubus/nubus.h

-- 
2.14.4
