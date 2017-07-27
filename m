Received: from eggs.gnu.org ([2001:4830:134:3::10]:50885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1daXei-0002so-Hd
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 21:32:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1daXed-00088J-KY
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 21:32:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46117)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1daXed-00086g-A5
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 21:31:55 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6R1V5xd112157
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 21:31:52 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bxyx4rjsm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 21:31:52 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 26 Jul 2017 19:31:51 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 26 Jul 2017 20:30:52 -0500
Message-Id: <1501119055-4060-1-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH for-2.10 0/3] qdev/vfio: defer DEVICE_DEL to
 avoid races with libvirt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, berrange@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au, groug@kaod.org, armbru@redhat.com

This series was motivated by the discussion in this thread:

  https://www.redhat.com/archives/libvir-list/2017-June/msg01370.html

The issue this series addresses is that when libvirt unplugs a VFIO PCI device,
it may attempt to bind the host device back to the host driver when QEMU emits
the DEVICE_DELETED event for the corresponding vfio-pci device. However, the
VFIO group FD is not actually cleaned up until vfio-pci device is *finalized*
by QEMU, whereas the event is emitted earlier during device_unparent.
Depending on the host device and how long certain operations like resetting the
device might take, this can in result in libvirt trying to rebind the device
back to the host while it is still in use by VFIO, leading to host crashes or
other unexpected behavior.

In particular, Mellanox CX4 adapters on PowerNV hosts might not be fully
quiesced by vfio-pci's finalize() routine until up to 6s after the
DEVICE_DELETED was emitted, leading to detach-device on the libvirt side pretty
much always crashing the host.

Implementing this change requires 2 prereqs to ensure the same information is
available when the DEVICE_DELETED is finally emitted:

1) Storing the path in the composition patch, which is addressed by PATCH 1,
   which was plucked from another pending series from Greg Kurz:

   https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg07922.html

   since we are now "disconnected" at the time the event is emitted, and

2) Deferring qemu_opts_del of the DeviceState->QemuOpts till finalize, since
   that is where DeviceState->id is stored. This was actually how it was
   done in the past, so PATCH 2 simply reverts the change which moved it to
   device_unparent.

>From there it's just a mechanical move of the event from device_unparent to
device_finalize.

 hw/core/qdev.c         | 30 +++++++++++++++++++-----------
 include/hw/qdev-core.h |  1 +
 2 files changed, 20 insertions(+), 11 deletions(-)
