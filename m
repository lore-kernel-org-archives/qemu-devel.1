Received: from eggs.gnu.org ([2001:4830:134:3::10]:35766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cgsNv-0006Ae-UL
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 07:20:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cgsNr-0002rW-Uh
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 07:20:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54226
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cgsNr-0002rO-Ps
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 07:20:31 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1NCItLn004627
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 07:20:31 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28sdf6ak3p-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 07:20:31 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 23 Feb 2017 12:20:29 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Thu, 23 Feb 2017 13:20:20 +0100
Message-Id: <20170223122025.10420-1-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH v2 0/5] s390x: network boot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, jfrei@linux.vnet.ibm.com, Cornelia Huck <cornelia.huck@de.ibm.com>

v1->v2:
- style enhancements for patch 3, as suggested by Thomas

If this looks fine (and I'd still like an ack for patch 1), I'd like
to get this into 2.9.

Original cover letter:

This patchset implements network boot for s390x. You need to build
a s390-netboot.img to actually perform the work (not included).

Basically, we add support for virtio-net devices into the ipl code
and update the ccw bios to handle this as well.

For the first patch (elf loading) I'd like to get an ack.

A s390-netboot.img can be built by bundling some shell scripts, busybox
and the kexec binary bundled into an initial ramdisk and append that to
a kernel image. An existing s390 system can be used as source.

The init process can be a simple shell script that mounts a few
essential filesystems, like /dev, /proc, /sys, ..., starts a DHCP client
(busybox udchpc) and then invokes another script to do the actual
network boot.

udchpc will invoke the script /usr/share/udhcpc/default.script in
response to DHCP server messages to configure interfaces. The sample
busybox default.script can be used for that, but needs to also extract
the DHCP options like the tftp server address and pass that on to the
boot script.

The boot script itself has to retrieve the PXELINUX configuration from
the tftp server as in [1], then retrieve the remote kernel and initial
ramdisk and finally use kexec to boot the network kernel.

In a nutshell:

1. Create a skeleton initramfs directory structure
2. Create the init script, the PXE boot scripts and the DHCP default
   script
3. Copy kexec and its dependencies from the source system into the
   initramfs
4. Copy virtio network and block modules from the source system into
   the initramfs
5. Copy the busybox binaries into the initramfs
6. Build the ramdisk (in compressed CPIO format)
7. Concatenate the kernel image and the initial ramdisk
8. Update the 8 bytes at location 66568 with the offset value of the
   ramdisk in the new binary, and the 8 bytes at location 66576 with the
   size of the ramdisk. Both values need to be updated in binary, big
   endian format.

[1]
http://www.syslinux.org/wiki/index.php?title=PXELINUX#Configuration_filename

Cornelia Huck (1):
  pc-bios/s390-ccw.img: rebuild image

Farhan Ali (4):
  elf-loader: Allow late loading of elf
  s390x/ipl: Extend S390IPLState to support network boot
  s390x/ipl: Load network boot image
  pc-bios/s390-ccw: Use the ccw bios to start the network boot

 hw/core/loader.c           |  17 ++++++++-
 hw/s390x/ipl.c             |  90 +++++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/ipl.h             |   5 ++-
 hw/s390x/s390-virtio-ccw.c |   3 +-
 hw/s390x/s390-virtio.c     |   2 +
 hw/s390x/s390-virtio.h     |   1 +
 include/hw/elf_ops.h       |  13 +++++--
 include/hw/loader.h        |  13 ++++++-
 pc-bios/s390-ccw.img       | Bin 26392 -> 26456 bytes
 pc-bios/s390-ccw/bootmap.c |   8 +++-
 pc-bios/s390-ccw/iplb.h    |   3 +-
 pc-bios/s390-ccw/main.c    |  20 +++++++---
 pc-bios/s390-ccw/virtio.c  |   1 +
 pc-bios/s390-ccw/virtio.h  |   1 +
 14 files changed, 160 insertions(+), 17 deletions(-)

-- 
2.11.0
