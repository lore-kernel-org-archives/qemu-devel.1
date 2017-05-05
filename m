Received: from eggs.gnu.org ([2001:4830:134:3::10]:45354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d6h8S-00011H-Ln
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:35:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d6h8P-0005GB-JH
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:35:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47485
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1d6h8P-0005Ft-DJ
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:35:17 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v45HXmnL126758
	for <qemu-devel@nongnu.org>; Fri, 5 May 2017 13:35:16 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a8rx2fnfj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 13:35:16 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 5 May 2017 18:35:14 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri,  5 May 2017 19:34:57 +0200
Message-Id: <20170505173507.74077-1-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 00/10] migration: s390x css migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

This patch set has a dual purpose: introduce proper migration for the
channel subsystem (css) and convert the migration of ccw devices to
vmstate. The state of the css was only partially migrated by the
virtio-ccw devices (was the only device type until recent), which was
good enough for a while.

Since the new vmstate infrastructure is used also for handling the
migration stream for legacy machines some bits are a bit convoluted:
that is, if you see something convoluted there is a good chance the
reason why is compatibility.

Halil Pasic (10):
  s390x: add helper get_machine_class
  s390x: add css_migration_enabled to machine class
  s390x/css: add vmstate entities for css
  s390x/css: add vmstate macro for CcwDevice
  virtio-ccw: add vmstate entities for VirtioCcwDevice
  virtio-ccw: use vmstate way for config migration
  s390x/css: remove unused subch_dev_(load|save)
  s390x/css: add ORB to SubchDev
  s390x/css: turn on channel subsystem migration
  s390x/css: use SubchDev.orb

 hw/intc/s390_flic.c                |  48 ++++
 hw/s390x/ccw-device.c              |  11 +
 hw/s390x/ccw-device.h              |   4 +
 hw/s390x/css.c                     | 478 +++++++++++++++++++++++++------------
 hw/s390x/s390-virtio-ccw.c         |  58 +++--
 hw/s390x/virtio-ccw.c              | 164 +++++++------
 include/hw/s390x/css.h             |  17 +-
 include/hw/s390x/s390-virtio-ccw.h |   7 +
 include/hw/s390x/s390_flic.h       |   5 +
 9 files changed, 543 insertions(+), 249 deletions(-)

-- 
2.10.2
