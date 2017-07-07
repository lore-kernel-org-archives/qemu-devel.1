Received: from eggs.gnu.org ([2001:4830:134:3::10]:35302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dTQTi-0002Sx-AE
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 06:27:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dTQTf-0001mk-5p
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 06:27:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dTQTe-0001mP-Sl
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 06:27:11 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  7 Jul 2017 12:26:56 +0200
Message-Id: <1499423224-23060-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [RFC PATCH v2 0/8] Implement network booting directly
 into the s390-ccw BIOS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

It's already possible to do a network boot of an s390x guest with an
external netboot image based on a Linux installation, but it would
be much more convenient if the s390-ccw firmware supported network
booting right out of the box, without the need to assemble such an
external image first.

This patch series now introduces a s390-netboot.img that can be used
for network booting via DHCP and TFTP by re-using the networking stack
from the SLOF firmware (see https://github.com/aik/SLOF/ for details),
and adds a driver for virtio-net-ccw devices.

The code can only be built if the roms/SLOF/ submodule has been checked
out, and you apply the following pending SLOF patch on top of it:

 https://patchwork.ozlabs.org/patch/785384/

Then it should be possible to download a combined kernel + initrd
image via TFTP, e.g. by starting QEMU with:

 qemu-system-s390x ... -device virtio-net,netdev=n1,bootindex=1 \
       -netdev user,id=n1,tftp=/path/to/tftp,bootfile=kernel.img

Note that this version does not support downloading via config
files (i.e. pxelinux config files or .INS config files) yet. This
will be added later.

v2:
 - Put the network boot loader into a separate s390-netboot.img
   binary instead of linking it directly into the s390-ccw firmware.
 - Use the SLOF sources from the roms/SLOF/ submodule instead of
   copying them into the pc-bios/s390-ccw folder
 - Removed the .INS config file loading code for now - only support
   combined kernel + initrd images in this initial implementation.

Thomas Huth (8):
  pc-bios/s390-ccw: Move libc functions to separate header
  pc-bios/s390-ccw: Move ebc2asc to sclp.c
  pc-bios/s390-ccw: Move virtio-block related functions into a separate
    file
  pc-bios/s390-ccw: Add a write() function for stdio
  roms/SLOF: Update submodule to latest status
  pc-bios/s390-ccw: Add core files for the network bootloading program
  pc-bios/s390-ccw: Add virtio-net driver code
  pc-bios/s390-ccw: Link libnet into the netboot image and do the TFTP
    load

 pc-bios/s390-ccw/Makefile      |  13 +-
 pc-bios/s390-ccw/bootmap.c     |   1 +
 pc-bios/s390-ccw/libc.h        |  43 +++++
 pc-bios/s390-ccw/main.c        |  14 +-
 pc-bios/s390-ccw/netboot.mak   |  51 ++++++
 pc-bios/s390-ccw/netmain.c     | 365 +++++++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/s390-ccw.h    |  31 +---
 pc-bios/s390-ccw/sclp.c        |  37 +++--
 pc-bios/s390-ccw/virtio-blk.c  | 296 +++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/virtio-net.c  | 130 +++++++++++++++
 pc-bios/s390-ccw/virtio-scsi.c |   1 +
 pc-bios/s390-ccw/virtio.c      | 283 ++------------------------------
 pc-bios/s390-ccw/virtio.h      |  17 +-
 roms/SLOF                      |   2 +-
 14 files changed, 955 insertions(+), 329 deletions(-)
 create mode 100644 pc-bios/s390-ccw/libc.h
 create mode 100644 pc-bios/s390-ccw/netboot.mak
 create mode 100644 pc-bios/s390-ccw/netmain.c
 create mode 100644 pc-bios/s390-ccw/virtio-blk.c
 create mode 100644 pc-bios/s390-ccw/virtio-net.c

-- 
1.8.3.1
