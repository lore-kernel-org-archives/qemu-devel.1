Received: from eggs.gnu.org ([2001:4830:134:3::10]:55070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dUag6-0004rV-J4
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:32:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dUag2-0002RY-K3
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:32:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dUag2-0002Qw-BV
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:32:46 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 10 Jul 2017 17:32:30 +0200
Message-Id: <1499700760-4777-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v3 00/10] Implement network booting directly
 into the s390-ccw BIOS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>

It's already possible to do a network boot of an s390x guest with an
external netboot image based on a Linux installation, but it would
be much more convenient if the s390-ccw firmware supported network
booting right out of the box, without the need to assemble such an
external image first.

This patch series now introduces a s390-netboot.img that can be used
for network booting via DHCP and TFTP by re-using the networking stack
from the SLOF firmware (see https://github.com/aik/SLOF/ for details),
and adds a driver for virtio-net-ccw devices.

The code can only be built if the roms/SLOF submodule has been checked
out (there is a sanity check for this in the Makefile). Once it has
been built, you can download a combined kernel + initrd image via TFTP
by starting QEMU for example with:

 qemu-system-s390x ... -device virtio-net,netdev=n1,bootindex=1 \
       -netdev user,id=n1,tftp=/path/to/tftp,bootfile=kernel.img

Note that this version does not support downloading via config
files (i.e. pxelinux config files or .INS config files) yet. This
will be added later.

v3:
 - Adressed the review feedback from v2
 - The last remaining SLOF patch has now been merged (big thanks to
   Alexey!), so not sending this as RFC anymore - it is ready now for
   integration, I think.

v2:
 - Put the network boot loader into a separate s390-netboot.img
   binary instead of linking it directly into the s390-ccw firmware.
 - Use the SLOF sources from the roms/SLOF/ submodule instead of
   copying them into the pc-bios/s390-ccw folder
 - Removed the .INS config file loading code for now - only support
   combined kernel + initrd images in this initial implementation.

Thomas Huth (10):
  pc-bios/s390-ccw: Move libc functions to separate header
  pc-bios/s390-ccw: Move ebc2asc to sclp.c
  pc-bios/s390-ccw: Move virtio-block related functions into a separate
    file
  pc-bios/s390-ccw: Add a write() function for stdio
  pc-bios/s390-ccw: Move byteswap functions to a separate header
  pc-bios/s390-ccw: Add code for virtio feature negotiation
  roms/SLOF: Update submodule to latest status
  pc-bios/s390-ccw: Add core files for the network bootloading program
  pc-bios/s390-ccw: Add virtio-net driver code
  pc-bios/s390-ccw: Link libnet into the netboot image and do the TFTP
    load

 pc-bios/s390-ccw/Makefile        |  13 +-
 pc-bios/s390-ccw/bootmap.c       |   2 +
 pc-bios/s390-ccw/bootmap.h       |  26 ---
 pc-bios/s390-ccw/bswap.h         |  25 +++
 pc-bios/s390-ccw/libc.h          |  45 +++++
 pc-bios/s390-ccw/main.c          |  14 +-
 pc-bios/s390-ccw/netboot.mak     |  51 ++++++
 pc-bios/s390-ccw/netmain.c       | 365 +++++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/s390-ccw.h      |  33 +---
 pc-bios/s390-ccw/sclp.c          |  37 ++--
 pc-bios/s390-ccw/virtio-blkdev.c | 297 +++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/virtio-net.c    | 133 ++++++++++++++
 pc-bios/s390-ccw/virtio-scsi.c   |   1 +
 pc-bios/s390-ccw/virtio.c        | 306 ++++----------------------------
 pc-bios/s390-ccw/virtio.h        |  18 +-
 roms/SLOF                        |   2 +-
 16 files changed, 1007 insertions(+), 361 deletions(-)
 create mode 100644 pc-bios/s390-ccw/bswap.h
 create mode 100644 pc-bios/s390-ccw/libc.h
 create mode 100644 pc-bios/s390-ccw/netboot.mak
 create mode 100644 pc-bios/s390-ccw/netmain.c
 create mode 100644 pc-bios/s390-ccw/virtio-blkdev.c
 create mode 100644 pc-bios/s390-ccw/virtio-net.c

-- 
1.8.3.1
