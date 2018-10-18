Received: from eggs.gnu.org ([2001:4830:134:3::10]:37685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gDD2u-0002vM-TZ
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:29:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gDD2n-00025a-RI
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:29:19 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu, 18 Oct 2018 19:28:45 +0100
Message-Id: <20181018182856.28001-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 00/11] hw/m68k: add Apple Machintosh Quadra
 800 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, jasowang@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, hpoussin@reactos.org, kraxel@redhat.com, pbonzini@redhat.com, yongbok.kim@mips.com, afaerber@suse.de, aurelien@aurel32.net, laurent@vivier.eu

(MCA: I've reposting this on behalf of Laurent as I've been working on the
feedback from v3 over the past months and therefore am better placed to
update the changelog. If all goes well, it would be good to get this merged
in time for 3.1 soft freeze)

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

v4: Drop RFC from subject prefix as this is getting close to final
    Rebased onto master (fixing ESP, rom_ptr() conflicts)
    Reworked q800.c based upon Thomas' comments about cpu_init() and
      qemu_check_nic_model()
    Address Thomas' comments on using error_report() instead of hw_error()
    Change the NuBus memory regions from DEVICE_NATIVE_ENDIAN to
      DEVICE_BIG_ENDIAN
    Split macfb Nubus support into separate commit
    Change VMSTATE_BUFFER_UNSAFE() to VMSTATE_UINT8_ARRAY() in macfb.c as
      suggested by David
    Remove dummy Apple Sound Chip migration state as pointed out by David
    Keep VIA ADB state and buffers in the mac_via device rather than adding
      to existing ADBState (this matches the pattern used in the PPC CUDA/PMU
      VIAs)
    Remove blacklisting for q800 machine from "make check" as requested by
      Thomas with the following fixes:
        - Fix incorrect MemoryRegion owner in ASC device
        - Add qtest_enabled() check in q800_init() to allow testing when no
          kernel is specified
        - Move some Mac VIA initialisation from init to realize
    Remove legacy drive properties from SWIM floppy controller and instead
      expose separate floppy bus and drive devices as requested by Kevin
        
v3: fix subject prefix "C" -> "RFC"

v2: remove the dp8393x fixes, because one of the patch breaks something
    Update "dp8393x: manage big endian bus" with idea from Thomas
    Mark has reworked most of the patches:
    - use mos6522
    - some code move, renamings and cleanup

Laurent Vivier (10):
  hw/m68k: add via support
  hw/m68k: implement ADB bus support for via
  escc: introduce a selector for the register bit
  hw/m68k: add macfb video card
  hw/m68k: Apple Sound Chip (ASC) emulation
  ESP: add pseudo-DMA as used by Macintosh
  hw/m68k: add Nubus support
  hw/m68k: add a dummy SWIM floppy controller
  dp8393x: manage big endian bus
  hw/m68k: define Macintosh Quadra 800

Mark Cave-Ayland (1):
  hw/m68k: add Nubus support for macfb video card

 MAINTAINERS                         |  19 +
 arch_init.c                         |   4 +
 default-configs/m68k-softmmu.mak    |  14 +
 hw/Makefile.objs                    |   1 +
 hw/audio/Makefile.objs              |   1 +
 hw/audio/asc.c                      | 446 +++++++++++++++++++
 hw/block/Makefile.objs              |   1 +
 hw/block/swim.c                     | 415 ++++++++++++++++++
 hw/char/escc.c                      |  30 +-
 hw/display/Makefile.objs            |   1 +
 hw/display/macfb-template.h         | 158 +++++++
 hw/display/macfb.c                  | 308 +++++++++++++
 hw/input/adb.c                      |   2 +
 hw/intc/Makefile.objs               |   1 +
 hw/intc/q800_irq.c                  |  73 ++++
 hw/m68k/Makefile.objs               |   6 +-
 hw/m68k/bootinfo.h                  | 100 +++++
 hw/m68k/q800.c                      | 367 ++++++++++++++++
 hw/misc/Makefile.objs               |   1 +
 hw/misc/mac_via.c                   | 834 ++++++++++++++++++++++++++++++++++++
 hw/net/dp8393x.c                    |  88 ++--
 hw/nubus/Makefile.objs              |   4 +
 hw/nubus/mac-nubus-bridge.c         |  45 ++
 hw/nubus/nubus-bridge.c             |  34 ++
 hw/nubus/nubus-bus.c                | 111 +++++
 hw/nubus/nubus-device.c             | 209 +++++++++
 hw/scsi/esp.c                       | 292 +++++++++++--
 include/hw/audio/asc.h              |  48 +++
 include/hw/block/swim.h             |  76 ++++
 include/hw/char/escc.h              |   1 +
 include/hw/display/macfb.h          |  63 +++
 include/hw/intc/q800_irq.h          |  39 ++
 include/hw/misc/mac_via.h           | 113 +++++
 include/hw/nubus/mac-nubus-bridge.h |  24 ++
 include/hw/nubus/nubus.h            |  69 +++
 include/hw/scsi/esp.h               |   7 +
 qemu-options.hx                     |   2 +-
 vl.c                                |   3 +-
 38 files changed, 3940 insertions(+), 70 deletions(-)
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
2.11.0
