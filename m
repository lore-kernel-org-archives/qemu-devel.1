Received: from eggs.gnu.org ([2001:4830:134:3::10]:49583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1d8TwO-00015x-KN
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:54:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1d8TwK-0002y2-IM
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:54:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35098
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.vnet.ibm.com>)
	id 1d8TwK-0002xZ-Bi
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:54:12 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4AFrpf7123869
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 11:54:10 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2aby8qv2wc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 11:54:10 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.vnet.ibm.com>;
	Wed, 10 May 2017 16:54:08 +0100
From: Eric Farman <farman@linux.vnet.ibm.com>
Date: Wed, 10 May 2017 17:53:51 +0200
Message-Id: <20170510155359.32727-1-farman@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v2 0/8] s390x: Enable virtio-scsi boot from
 /dev/sgX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Eric Farman <farman@linux.vnet.ibm.com>

Today, trying to boot a guest from a SCSI LUN on s390x yields the following:

  virtio-blk               = OK
  virtio-scsi and /dev/sdX = OK
  virtio-scsi and /dev/sgX = FAIL

Example of the failing scenario:

  /usr/bin/qemu-system-s390x ...
    -device virtio-scsi-ccw,id=scsi0,devno=fe.0.0001
    -drive file=/dev/sg2,if=none,id=drive0,format=raw
    -device scsi-generic,bus=scsi0.0,channel=0,scsi-id=0,drive=drive0,id=disk0
  LOADPARM=[........]
  Using virtio-scsi.
  Using SCSI scheme.
  ..
  ! virtio-scsi:read_many: STATUS=02 RSPN=70 KEY=0b CODE=00 QLFR=06, sure !

Why do we care?  Well, libvirt converts a virtio-scsi device from the host
SCSI address (host:bus:target:lun) into the associated /dev/sgX device,
which means we can't boot from virtio-scsi and have to rely on virtio-blk
for this action.

The short version of what happens is the host block device driver rejects our
requests because the transfer lengths are too long for it to satisfy.
A virtio-scsi disk connected via scsi-generic is fine as a non-boot device
because the guest kernel is able to break up the requests for us.  So we just
need to handle this situation for the boot process.

Patches 1-3 read the max_sectors parameter for the virtio-scsi controller,
and break up the READ(10) I/Os into something that the host will accept.
If not specified, max_sectors defaults to 65535, but could look like this:

  qemu-system-s390x ...
    -device virtio-scsi-ccw,id=scsi0,devno=fe.0.0001,max_sectors=2048

Patches 4-6 read the max_io_size parameter for the virtio-scsi disk device,
and use the minimum of it and the max_sectors from the controller for breaking
up the READ(10) I/Os.  If not specified, max_io_size defaults to 2147483647
but could look like this:

  qemu-system-s390x ...
    -drive file=/dev/sda,if=none,id=drive0,format=raw ...
    -device scsi-hd,bus=scsi0.0,channel=0,scsi-id=0,
            drive=drive0,id=disk0,max_io_size=1048576

In the two examples above, the maximum parameters are equivalent due to the
controller parameter measuring 512-byte blocks, and the disk measuring bytes.

Patch 7 establishes a workable default, in case neither the controller nor
the disk have the parameters specified (and thus the overly large defaults
are taken), or if they are set to something beyond what we can boot from.

Patch 8 rebuilds the s390-ccw BIOS with this entire patch set.

Changelog:

RFC v2:
 - Dropped patch outside the pc-bios/s390-ccw/ tree
 - Added Christian's r-b to patch 1 (formerly patch 2)
 - Added EVPD Inquiry calls to retrieve Block Limits page if supported
 - Added a default if Block Limits page is not supported, or response is
   still way to big to allow boot
RFC v1:
 - https://lists.nongnu.org/archive/html/qemu-devel/2017-04/msg05121.html

Eric Farman (8):
  pc-bios/s390-ccw: Remove duplicate blk_factor adjustment
  pc-bios/s390-ccw: Move SCSI block factor to outer read
  pc-bios/s390-ccw: Break up virtio-scsi read into multiples
  pc-bios/s390-ccw: Refactor scsi_inquiry function
  pc-bios/s390-ccw: Get list of supported VPD pages
  pc-bios/s390-ccw: Get Block Limits VPD device data
  pc-bios/s390-ccw: Build a reasonable max_sectors limit
  pc-bios/s390-ccw.img: rebuild image

 pc-bios/s390-ccw.img           | Bin 26472 -> 26480 bytes
 pc-bios/s390-ccw/s390-ccw.h    |   7 ++++
 pc-bios/s390-ccw/scsi.h        |  30 +++++++++++++++
 pc-bios/s390-ccw/virtio-scsi.c |  85 +++++++++++++++++++++++++++++++++++------
 pc-bios/s390-ccw/virtio-scsi.h |   2 +
 pc-bios/s390-ccw/virtio.h      |   1 +
 6 files changed, 114 insertions(+), 11 deletions(-)

-- 
2.10.2
