Received: from eggs.gnu.org ([2001:4830:134:3::10]:38021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1d3ODf-0003Oc-3c
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:47:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1d3ODa-0002Ot-FG
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:47:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47396)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.vnet.ibm.com>)
	id 1d3ODa-0002Nw-6S
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:46:58 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3QEk6FS093407
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 10:46:57 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a2wj306q9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 10:46:56 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.vnet.ibm.com>;
	Wed, 26 Apr 2017 15:46:54 +0100
From: Eric Farman <farman@linux.vnet.ibm.com>
Date: Wed, 26 Apr 2017 16:46:40 +0200
Message-Id: <20170426144645.12476-1-farman@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v1 0/5] Enable virtio-scsi boot from
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Eric Farman <farman@linux.vnet.ibm.com>

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

The short version of what happens is the host device driver rejects our
requests because the transfer lengths are too long for it to satisfy.
A virtio-scsi disk connected via scsi-generic is fine as a non-boot device
because the guest kernel is able to break up the requests for us.  So we just
need to handle this situation for the boot process.

Patches 2-N in this series do that, but rely on us to specify the max_sectors
parameter for the virtio-scsi-ccw device:

  /usr/bin/qemu-system-s390x ...
    -device virtio-scsi-ccw,id=scsi0,devno=fe.0.0001,max_sectors=2048

Without this, the default of xFFFF is used and we still end up exceeding
the limit in the host drivers.  Which is why we have Patch 1, and thus the
"RFC" tag on this series.  The backing block device has a maximum transfer
value calculated with the help of the BLKSECTGET ioctl[1][2].

With patch 1 applied, we are able to go through the children devices and
apply any known limit received from this IOCTL, and thus break up our requests
before submitting them to the host.  It is admittedly a little coarse, since
the max_sectors value is associated with the virtio-scsi controller and
multiple devices can be attached to it, not all of which are associated
with our boot device.  Meanwhile, each attached device can have its own
maximum transfer from the backing device.

[1] http://git.qemu-project.org/?p=qemu.git;a=commitdiff;h=482652502e98b1d570de0585f01dd55e35fdebfb
[2] http://git.qemu-project.org/?p=qemu.git;a=commitdiff;h=c4c41a0a65d650b241dec9efedf4ee3f00a16a30

Eric Farman (5):
  hw/scsi: Override the max_sectors value for virtio-scsi
  pc-bios/s390-ccw: Remove duplicate blk_factor adjustment
  pc-bios/s390-ccw: Move SCSI block factor to outer read
  pc-bios/s390-ccw: Break up virtio-scsi read into multiples
  pc-bios/s390-ccw.img: rebuild image

 hw/scsi/virtio-scsi.c          |  12 ++++++++++++
 pc-bios/s390-ccw.img           | Bin 26456 -> 26456 bytes
 pc-bios/s390-ccw/s390-ccw.h    |   4 ++++
 pc-bios/s390-ccw/virtio-scsi.c |  29 ++++++++++++++++++++---------
 4 files changed, 36 insertions(+), 9 deletions(-)

-- 
2.10.2
