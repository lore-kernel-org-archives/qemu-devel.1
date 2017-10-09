Received: from eggs.gnu.org ([2001:4830:134:3::10]:46338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e1bVy-00014Y-Qd
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:06:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e1bVt-0002Av-Pi
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:06:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36961
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1e1bVt-0002Ae-JJ
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:06:45 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v99H4fOG119096
	for <qemu-devel@nongnu.org>; Mon, 9 Oct 2017 13:06:42 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dgcabb6fu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 13:06:42 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 9 Oct 2017 13:06:40 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  9 Oct 2017 12:06:04 -0500
Message-Id: <20171009170607.4155-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 0/3] qdev/vfio: defer DEVICE_DEL to avoid
 races with libvirt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@gibson.dropbear.id.au, groug@kaod.org, peter.maydell@linaro.org, armbru@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, imammedo@redhat.com, ehabkost@redhat.com

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

Since this was originally posted a kernel fix was merged to address the race
on the kernel side (6586b561), but it would still be good to fix this on the
QEMU side for older host kernel and for clearer semantics on the
libvirt/management side.

v2:
 - rebased on master
 - fixed up inaccurate comment in PATCH 1 (Eric)

 hw/core/qdev.c         | 31 ++++++++++++++++++++-----------
 include/hw/qdev-core.h |  1 +
 2 files changed, 21 insertions(+), 11 deletions(-)
